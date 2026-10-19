/**
 * Independent HTTP checks against pinned public exports, with no app imports.
 * pnpm exec node scripts/audit-public-api.mjs --base-url http://localhost:3100 --output /tmp/api-local.json
 * A failing contract produces exit code 1 after all checks finish.
 */
import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile, mkdir, writeFile } from 'node:fs/promises';
import { dirname, resolve } from 'node:path';
import { parseArgs } from 'node:util';

const { values } = parseArgs({ options: {
  'base-url': { type: 'string' }, output: { type: 'string' },
  concurrency: { type: 'string', default: '4' },
} });
if (!values['base-url']) throw new Error('--base-url is required');
const origin = new URL(values['base-url']);
if (!['http:', 'https:'].includes(origin.protocol)) throw new Error('Use an HTTP(S) origin');
const concurrency = Number(values.concurrency);
assert.ok(Number.isInteger(concurrency) && concurrency >= 1 && concurrency <= 8, 'concurrency must be 1–8');
const startedAt = new Date().toISOString();
const root = new URL('../', import.meta.url);
const load = async (path) => JSON.parse(await readFile(new URL(path, root), 'utf8'));
const jsonl = async (path) => (await readFile(new URL(path, root), 'utf8')).trim().split('\n').map((line) => JSON.parse(line));
const sha256 = (bytes) => createHash('sha256').update(bytes).digest('hex');
const commentaryRelease = await load('corpus/gita-commentaries/source.json');
const [passages, imported, arnold, authors, manifest] = await Promise.all([
  jsonl('public/data/gita-1.0.0-rc.1/gita.jsonl'),
  Promise.all(['en', 'hi', 'sa'].map((lang) => jsonl(`public/data/${commentaryRelease.corpusVersion}/commentaries-${lang}.jsonl`))).then((lists) => lists.flat().map((record) => ({ ...record, corpusVersion: commentaryRelease.corpusVersion }))),
  jsonl('public/data/gita-edwin-arnold-1.0.0/verses.jsonl'),
  load('corpus/gita-commentaries/authors.json'),
  load('public/data/gita-1.0.0-rc.1/manifest.json'),
]);
const records = [...imported, ...arnold];
const recordById = new Map(records.map((record) => [record.id, record]));
const passageByRef = new Map(passages.map((passage) => [passage.canonicalRef, passage]));
const byRef = Map.groupBy(records, (record) => record.canonicalRef);
const byAuthorChapter = Map.groupBy(records, (record) => `${record.authorId}/${record.canonicalRef.split('.')[1]}`);
const authorIds = [...authors.map((author) => author.id), 'edwin-arnold'];
const groups = {};
let requests = 0;
let responseBytes = 0;

function check(group, label, fn, context = {}) {
  const stats = groups[group] ??= { passed: 0, failed: 0, failures: [] };
  try { fn(); stats.passed++; }
  catch (error) {
    stats.failed++;
    if (stats.failures.length < 8) stats.failures.push({ label, ...context, message: String(error.message).slice(0, 1000) });
  }
}

async function request(path, { mode = 'json', method = 'GET', headers = {}, status = 200, group = 'http' } = {}) {
  const url = new URL(path, origin);
  if (mode === 'query-markdown') url.searchParams.set('format', 'markdown');
  if (mode === 'accept-markdown') headers = { ...headers, Accept: 'text/markdown' };
  const label = `${method} ${url.pathname}${url.search} [${mode}]`;
  requests++;
  try {
    const response = await fetch(url, { method, headers, signal: AbortSignal.timeout(30000), redirect: 'manual' });
    const bytes = Buffer.from(await response.arrayBuffer());
    responseBytes += bytes.length;
    const text = bytes.toString('utf8');
    const contentType = response.headers.get('content-type') ?? '';
    let body;
    if (contentType.includes('application/json') && method !== 'HEAD') {
      try { body = JSON.parse(text); }
      catch (error) { check(group, `${label}: valid JSON`, () => assert.fail(error.message), { status: response.status, bytes: bytes.length, bodyStart: text.slice(0, 250), bodyEnd: text.slice(-250), cfRay: response.headers.get('cf-ray') }); }
    }
    check(group, label, () => assert.equal(response.status, status), response.status === status ? {} : { status: response.status, expectedStatus: status, bodyStart: text.slice(0, 500), cfRay: response.headers.get('cf-ray') });
    return { response, bytes, text, body, label, path: url.pathname + url.search };
  } catch (error) {
    check(group, label, () => { throw error; });
    return { label, path: url.pathname + url.search, text: '', bytes: Buffer.alloc(0) };
  }
}

async function pool(items, run) {
  let cursor = 0;
  await Promise.all(Array.from({ length: concurrency }, async () => {
    while (cursor < items.length) await run(items[cursor++]);
  }));
}

function compareRoot(actual, expected) {
  assert.ok(actual, 'missing data');
  for (const key of ['canonicalRef', 'workId', 'corpusVersion', 'chapter', 'verse', 'speaker', 'representations', 'translation', 'variants', 'provenance', 'review', 'checksum']) {
    assert.deepEqual(actual[key], expected[key], `${key} differs at ${expected.canonicalRef}`);
  }
  assert.equal(actual.edition, expected.editionId);
  assert.equal(actual.checksum, sha256(JSON.stringify({ canonicalRef: actual.canonicalRef, representations: actual.representations, variants: actual.variants, provenance: actual.provenance })));
}

function compareReading(actual, expected) {
  assert.ok(actual, `missing ${expected.id}`);
  for (const key of ['id', 'canonicalRef', 'authorId', 'author', 'editionId', 'language', 'script', 'contentType', 'content', 'sourceLocator', 'checksum', 'alignmentStatus', 'corpusVersion']) {
    assert.deepEqual(actual[key], expected[key], `${key} differs for ${expected.id}`);
  }
  assert.equal(actual.checksum, sha256(actual.content), `content checksum at ${actual.id}`);
  if (expected.authorId === 'edwin-arnold') {
    for (const key of ['rights', 'sourceChecksum', 'corpusVersion', 'alignment', 'firstReview']) assert.deepEqual(actual[key], expected[key], `${key} at ${expected.id}`);
  }
}

const routeSamples = [
  '/api/v1/works', '/api/v1/sources', '/api/v1/corpus-versions',
  '/api/v1/passages/gita/2/47', '/api/v1/search?q=yoga',
  '/api/v1/works/gita/passages/2/47', '/api/v1/works/gita/search?q=yoga',
  '/api/v1/works/gita/sources', '/api/v1/works/gita/versions',
  '/api/v2/passages/gita/2/47', '/api/v2/search?q=yoga',
  '/api/v2/works/gita/passages/2/47', '/api/v2/works/gita/search?q=yoga',
  '/api/v2/commentaries/authors', '/api/v2/commentaries/authors/edwin-arnold/chapters/1',
];
console.log(`Auditing ${origin.origin}: ${routeSamples.length} route families; concurrency ${concurrency}`);
const ready = await request('/api/v1/works');
assert.ok(Array.isArray(ready.body?.data), `API preflight failed at ${origin.origin}; start the server or resolve the transport error before running the full audit.`);

await pool(routeSamples, async (path) => {
  const responses = [];
  for (const mode of ['json', 'query-markdown', 'accept-markdown']) {
    const result = await request(path, { mode });
    responses.push(result);
    check('content-negotiation', result.label, () => {
      assert.match(result.response?.headers.get('content-type') ?? '', mode === 'json' ? /^application\/json/ : /^text\/markdown/);
      if (mode === 'json') assert.ok(result.body?.data);
      else assert.match(result.text, /^# /);
    });
    check('public-headers', result.label, () => {
      assert.equal(result.response?.headers.get('access-control-allow-origin'), '*');
      assert.equal(result.response?.headers.get('x-corpus-version'), manifest.corpusVersion);
      assert.equal(result.response?.headers.get('x-commentary-corpus-version'), commentaryRelease.corpusVersion);
      assert.match(result.response?.headers.get('cache-control') ?? '', /public/);
    });
    if (mode !== 'query-markdown') check('http-vary-accept', result.label, () => assert.ok((result.response?.headers.get('vary') ?? '').toLowerCase().split(/,\s*/).includes('accept'), 'cacheable negotiated response omits Vary: Accept'));
  }
  check('markdown-equivalence', path, () => assert.equal(responses[1].text, responses[2].text));
  const head = await request(path, { method: 'HEAD' });
  check('head', path, () => { assert.equal(head.text, ''); assert.equal(head.response?.headers.get('content-type'), responses[0].response?.headers.get('content-type')); });
});

console.log('Checking registries and compatibility routes');
const registries = {};
for (const path of ['/api/v1/works', '/api/v1/sources', '/api/v1/works/gita/sources', '/api/v1/corpus-versions', '/api/v1/works/gita/versions', '/api/v2/commentaries/authors']) {
  registries[path] = (await request(path)).body;
}
check('registries', 'work registry', () => {
  const works = registries['/api/v1/works'].data;
  assert.deepEqual(works.map((work) => work.id), ['gita']);
  assert.equal(works[0].passageCount, 700);
  assert.equal(works[0].currentCorpusVersion, manifest.corpusVersion);
  assert.equal(works[0].apiRoot, '/api/v2/works/gita');
});
check('registries', 'source registry aliases and Arnold rights', () => {
  const sources = registries['/api/v1/sources'].data;
  assert.deepEqual(sources, registries['/api/v1/works/gita/sources'].data);
  assert.ok(sources.some((source) => /Arnold/.test(source.contributor) && /Public domain/.test(source.rights)));
});
check('registries', 'release count, chapter numbering, and human-review gate', () => {
  for (const path of ['/api/v1/corpus-versions', '/api/v1/works/gita/versions']) {
    const version = registries[path].data[0];
    assert.equal(version.passageCount, 700);
    assert.deepEqual(version.chapterCounts, [47, 72, 43, 42, 29, 47, 30, 28, 34, 42, 55, 20, 34, 27, 20, 24, 28, 78]);
    assert.equal(version.releaseEligible, false);
    assert.equal(version.workId, 'gita');
  }
});
check('registries', 'all published authors and field counts', () => {
  const registry = registries['/api/v2/commentaries/authors'].data;
  assert.deepEqual(registry.map((author) => author.id).sort(), [...authorIds].sort());
  assert.equal(registry.reduce((total, author) => total + author.publicFields.length, 0), 30);
});

const passageRoutes = ['/api/v1/passages/gita', '/api/v1/works/gita/passages', '/api/v2/passages/gita', '/api/v2/works/gita/passages'];
console.log('Checking all 700 passages through all four passage routes');
await pool(passages, async (passage) => {
  const results = [];
  for (const prefix of passageRoutes) {
    const result = await request(`${prefix}/${passage.chapter}/${passage.verse}`);
    results.push(result);
    check('passage-data', result.label, () => compareRoot(result.body?.data, passage));
    // Cloudflare may weaken a strong origin ETag when applying compression.
    if (prefix.includes('/v1/')) check('passage-etag', result.label, () => assert.equal(result.response?.headers.get('etag')?.replace(/^W\//, ''), `"${passage.checksum}"`));
    if (!prefix.includes('/v2/')) continue;
    const expected = byRef.get(passage.canonicalRef);
    const actual = result.body?.data?.commentaries;
    check('passage-readings', result.label, () => {
      assert.equal(actual?.length, expected.length);
      assert.equal(result.body?.meta.commentaryCount, expected.length);
      assert.equal(new Set(actual.map((record) => record.id)).size, expected.length);
      const actualById = new Map(actual.map((record) => [record.id, record]));
      for (const record of expected) compareReading(actualById.get(record.id), record);
    });
    if (actual) for (const record of actual) {
      check('review-status-export-parity', record.id, () => assert.equal(record.alignmentStatus, recordById.get(record.id)?.alignmentStatus), { path: result.path });
    }
  }
  check('passage-aliases', passage.canonicalRef, () => {
    assert.deepEqual(results[0].body, results[1].body);
    assert.deepEqual(results[2].body, results[3].body);
  });
});

console.log('Checking all 23 authors across all 18 chapters');
await pool(authorIds.flatMap((author) => Array.from({ length: 18 }, (_, i) => ({ author, chapter: i + 1 }))), async ({ author, chapter }) => {
  const path = `/api/v2/commentaries/authors/${author}/chapters/${chapter}`;
  const result = await request(path);
  const expected = byAuthorChapter.get(`${author}/${chapter}`);
  check('author-chapter-data', result.label, () => {
    const actual = result.body?.data;
    assert.equal(actual?.length, expected.length);
    assert.equal(result.body?.meta.returned, expected.length);
    assert.equal(result.body?.meta.chapter, chapter);
    assert.equal(result.body?.meta.author.id, author);
    const actualById = new Map(actual.map((record) => [record.id, record]));
    assert.equal(actualById.size, expected.length);
    for (const record of expected) compareReading(actualById.get(record.id), record);
  });
  check('author-chapter-order', result.label, () => {
    const verses = result.body.data.map((record) => record.verse);
    assert.deepEqual(verses, [...verses].sort((a, b) => a - b), 'chapter reader returns verses out of canonical order');
  });
  if (chapter !== 1 && chapter !== 18) return;
  for (const mode of ['query-markdown', 'accept-markdown']) {
    const markdown = await request(path, { mode });
    check('author-chapter-markdown', markdown.label, () => {
      for (const record of expected) assert.ok(markdown.text.includes(record.content || 'This verse is omitted in this translation.'), `missing ${record.id}`);
      const verses = [...markdown.text.matchAll(/^## \d+\.(\d+)$/gm)].map((match) => Number(match[1]));
      assert.deepEqual(verses, verses.toSorted((a, b) => a - b));
    });
  }
});

console.log('Checking Markdown passage content at every chapter boundary');
await pool(passages.filter((p) => p.verse === 1 || p.verse === manifest.chapterCounts[p.chapter - 1] || (p.chapter === 1 && p.verse === 43)), async (passage) => {
  for (const prefix of passageRoutes) for (const mode of ['query-markdown', 'accept-markdown']) {
    const result = await request(`${prefix}/${passage.chapter}/${passage.verse}`, { mode });
    check('passage-markdown', result.label, () => {
      for (const content of Object.values(passage.representations)) assert.ok(result.text.includes(content));
      if (prefix.includes('/v2/')) for (const record of byRef.get(passage.canonicalRef)) assert.ok(result.text.includes(record.content || 'This verse is omitted in this translation.'), `missing ${record.id}`);
      else assert.ok(result.text.includes(passage.checksum));
    });
  }
});

console.log('Checking errors in JSON and both Markdown forms');
const errors = [];
for (const prefix of passageRoutes) {
  for (const ref of ['0/1', '-1/1', 'one/1', '1/0', '1/1.5', 'Infinity/1']) errors.push([`${prefix}/${ref}`, 400, 'INVALID_REFERENCE']);
  for (const ref of ['19/1', '13/35', '1/48', '18/79']) errors.push([`${prefix}/${ref}`, 404, 'PASSAGE_NOT_FOUND']);
}
for (const path of ['/api/v1/search', '/api/v1/works/gita/search', '/api/v2/search', '/api/v2/works/gita/search']) {
  for (const suffix of ['', '?q=', '?q=%20%20']) errors.push([path + suffix, 400, 'MISSING_QUERY']);
}
for (const suffix of ['passages/1/1', 'search?q=yoga', 'sources', 'versions']) errors.push([`/api/v1/works/unknown/${suffix}`, 404, 'WORK_NOT_FOUND']);
for (const suffix of ['passages/1/1', 'search?q=yoga']) errors.push([`/api/v2/works/unknown/${suffix}`, 404, 'WORK_NOT_FOUND']);
for (const ref of ['unknown/chapters/1', 'edwin-arnold/chapters/0', 'edwin-arnold/chapters/19', 'edwin-arnold/chapters/1.5']) errors.push([`/api/v2/commentaries/authors/${ref}`, 404, 'COMMENTARY_NOT_FOUND']);
await pool(errors, async ([path, status, code]) => {
  for (const mode of ['json', 'query-markdown', 'accept-markdown']) {
    const result = await request(path, { status, mode, group: 'error-status' });
    check('error-body', result.label, () => {
      if (mode === 'json') assert.equal(result.body?.error?.code, code);
      else { assert.match(result.response?.headers.get('content-type') ?? '', /^text\/markdown/); assert.match(result.text, /^# /); }
    });
  }
});

console.log('Checking search limits, Unicode, aliases, deduplication, and corpus coverage');
const searchRoutes = ['/api/v1/search', '/api/v1/works/gita/search', '/api/v2/search', '/api/v2/works/gita/search'];
for (const prefix of searchRoutes) {
  for (const [limit, expected] of [['1', 1], ['0', 1], ['-5', 1], ['2.9', 2], ['999', 100], ['NaN', prefix.includes('/v1/') ? 30 : 50]]) {
    const result = await request(`${prefix}?q=yoga&limit=${limit}`);
    check('search-limits', result.label, () => {
      assert.equal(result.body?.meta.limit, expected);
      assert.equal(result.body.meta.returned, result.body.data.length);
      assert.ok(result.body.data.length > 0 && result.body.data.length <= expected);
    });
  }
  const queries = new Map();
  for (const q of ['yoga', 'sankhya', 'sāṅkhya', 'धर्म', 'कर्तव्य', 'sacred plain', 'zzzznohitopenartha123456789', '" OR * --', 'yoga\u0304']) {
    const result = await request(`${prefix}?${new URLSearchParams({ q, limit: '100' })}`);
    queries.set(q, result.body);
    check('search-integrity', result.label, () => {
      const data = result.body.data;
      assert.equal(result.body.meta.query, q);
      assert.equal(result.body.meta.returned, data.length);
      const keys = data.map((item) => item.corpus === 'commentary' ? item.commentary.id : item.canonicalRef);
      assert.equal(new Set(keys).size, keys.length);
      let compound = false;
      for (const item of data) {
        const p = item.passage ?? (item.corpus === 'commentary' ? null : item);
        assert.ok(passageByRef.has(item.canonicalRef));
        if (p) compareRoot(p, passageByRef.get(item.canonicalRef));
        if (item.commentary) compareReading(item.commentary, recordById.get(item.commentary.id));
        const kind = item.kind ?? item.searchMatch.kind;
        assert.ok(['exact', 'compound'].includes(kind));
        if (kind === 'compound') compound = true;
        if (kind === 'exact') assert.equal(compound, false, 'exact results must precede compound results');
      }
      if (q === 'zzzznohitopenartha123456789') assert.equal(data.length, 0);
      if (q === 'yoga' && prefix.includes('/v1/')) { assert.equal(result.body.meta.total, 58); assert.equal(result.body.meta.exactCount, 5); assert.equal(result.body.meta.compoundCount, 53); }
    });
    if (prefix.includes('/v2/works/')) check('work-scoped-search-metadata', result.label, () => {
      assert.equal(result.body?.meta.workId, 'gita', 'text-scoped response lacks workId');
      assert.equal(result.body.meta.corpusVersion, manifest.corpusVersion);
      assert.equal(result.body.meta.commentaryCorpusVersion, commentaryRelease.corpusVersion);
      for (const hit of result.body.data) {
        assert.equal(hit.workId, 'gita');
        assert.equal(hit.corpusVersion, hit.passage?.corpusVersion ?? hit.commentary.corpusVersion);
      }
    });
  }
  check('search-diacritics', prefix, () => assert.deepEqual(queries.get('sankhya').data, queries.get('sāṅkhya').data));
}
for (const version of ['v1', 'v2']) {
  const a = await request(`/api/${version}/search?q=yoga&limit=100`);
  const b = await request(`/api/${version}/works/gita/search?q=yoga&limit=100`);
  check('search-aliases', version, () => assert.deepEqual(a.body?.data, b.body?.data));
}
for (const [query, author] of [['Ranged thus for battle', 'edwin-arnold'], ['Dharmakshetra', 'swami-sivananda']]) {
  const result = await request(`/api/v2/works/gita/search?${new URLSearchParams({ q: query, limit: '100' })}`);
  check('search-witness-coverage', result.label, () => assert.ok(result.body?.data.some((item) => item.commentary?.authorId === author), `missing expected ${author} witness`));
}

// HTTP clients must be able to explicitly exclude Markdown using a zero quality weight.
for (const accept of ['application/json, text/markdown;q=0', 'application/json;q=1, text/markdown;q=0.1']) {
  const result = await request('/api/v1/works', { headers: { Accept: accept } });
  check('http-accept-quality', accept, () => assert.match(result.response?.headers.get('content-type') ?? '', /^application\/json/));
}

console.log('Verifying the actual published download bytes against pinned release manifests');
for (const version of ['gita-1.0.0-rc.1', commentaryRelease.corpusVersion, 'gita-edwin-arnold-1.0.0']) {
  const expected = await load(`public/data/${version}/manifest.json`);
  const published = await request(`/data/${version}/manifest.json`);
  check('download-manifests', version, () => assert.deepEqual(published.body, expected));
  await pool(expected.files, async (file) => {
    const result = await request(`/data/${version}/${file.name}`);
    check('download-checksums', result.label, () => { assert.equal(result.bytes.length, file.bytes); assert.equal(sha256(result.bytes), file.sha256); });
  });
}

console.log('Repeating production-failure search cases serially without retries');
const repeatedSearches = [];
for (let round = 1; round <= 3; round++) for (const prefix of searchRoutes) for (const q of ['yoga', 'sankhya', 'धर्म', 'कर्तव्य', 'sacred plain', '" OR * --']) {
  const start = performance.now();
  const result = await request(`${prefix}?${new URLSearchParams({ q, limit: '100' })}`, { group: 'repeated-search-status' });
  repeatedSearches.push({ round, path: result.path, status: result.response?.status, milliseconds: Math.round(performance.now() - start) });
  check('repeated-search-contract', result.label, () => {
    assert.ok(Array.isArray(result.body?.data), 'complete JSON search body is required');
    assert.equal(result.body.meta.query, q);
    assert.equal(result.body.meta.returned, result.body.data.length);
    assert.ok(result.response.headers.get('vary').toLowerCase().includes('accept'));
  });
}

const totals = Object.values(groups).reduce((sum, group) => ({ passed: sum.passed + group.passed, failed: sum.failed + group.failed }), { passed: 0, failed: 0 });
const report = {
  startedAt, finishedAt: new Date().toISOString(), origin: origin.origin,
  scope: { routeFamilies: routeSamples.length, passageReferences: passages.length, passageRouteVariants: passageRoutes.length, authors: authorIds.length, authorChapters: authorIds.length * 18, distinctReadingRecords: records.length, fixtureBasis: 'Pinned public JSONL exports and manifests; no application imports', concurrency },
  requests, responseBytes, ...totals, groups, repeatedSearches,
};
if (values.output) {
  const path = resolve(values.output);
  await mkdir(dirname(path), { recursive: true });
  await writeFile(path, JSON.stringify(report, null, 2) + '\n');
  console.log(`Report: ${path}`);
}
for (const [name, group] of Object.entries(groups)) console.log(`${name}: ${group.passed} passed; ${group.failed} failed`);
console.log(`${requests} HTTP requests; ${totals.passed} passed assertions; ${totals.failed} failed assertions`);
process.exitCode = totals.failed ? 1 : 0;
