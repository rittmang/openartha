import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';
import corpus from '../corpus/gita/gita.json' with { type: 'json' };
import { searchPassages } from '../app/lib/search.ts';

const root = new URL('../', import.meta.url);

test('search reports exact words and Sanskrit compound forms separately', () => {
  const search = searchPassages(corpus.verses, 'yoga');

  assert.equal(search.total, 58);
  assert.equal(search.exactCount, 5);
  assert.equal(search.compoundCount, 53);
  assert.equal(search.results[0].kind, 'exact');

  const compound = search.results.find((result) => result.passage.canonicalRef === 'gita.2.45');
  assert.equal(compound?.kind, 'compound');
  assert.equal(compound?.hits[0].field, 'iast');
  const firstRange = compound?.hits[0].ranges[0];
  assert.equal(
    firstRange ? compound?.hits[0].text.slice(firstRange.start, firstRange.end).toLowerCase() : null,
    'yoga',
  );
});

test('search removes Latin transliteration diacritics deterministically', () => {
  const plain = searchPassages(corpus.verses, 'sankhya');
  const marked = searchPassages(corpus.verses, 'sāṅkhya');

  assert.deepEqual(
    plain.results.map((result) => result.passage.canonicalRef),
    marked.results.map((result) => result.passage.canonicalRef),
  );
});

test('unified search exposes one query without author, language, or content filters', async () => {
  const reader = await readFile(new URL('app/gita/page.tsx', root), 'utf8');
  const api = await readFile(new URL('app/api/v2/search/route.ts', root), 'utf8');

  assert.match(reader, /name="q"/);
  assert.doesNotMatch(reader, /search-filters|name="author"|name="language"|name="type"/);
  assert.doesNotMatch(api, /searchParams\.get\(['"](?:author|language|type)['"]\)/);
  assert.match(api, /searchCommentaries\(query, limit\)/);
});
