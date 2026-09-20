import { createHash } from 'node:crypto';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import path from 'node:path';
import { evaluateVerse } from './evaluate-first-review.mjs';

const root = process.cwd();
const version = 'gita-1.0.0-rc.1';
const generatedAt = process.env.SOURCE_DATE_EPOCH
  ? new Date(Number(process.env.SOURCE_DATE_EPOCH) * 1000).toISOString()
  : '2026-08-26T00:00:00.000Z';
const expectedCounts = [47, 72, 43, 42, 29, 47, 30, 28, 34, 42, 55, 20, 34, 27, 20, 24, 28, 78];
const sourceCounts = [47, 72, 43, 42, 29, 47, 30, 28, 34, 42, 55, 20, 35, 27, 20, 24, 28, 78];
const sourceUrl = 'https://raw.githubusercontent.com/ChiragMirani/gita-quotes/cddb2aabcb18b2ddf4ca965a0e673c1eee43146b/docs/data.json';
const telangIds = Array.from({ length: 18 }, (_, index) => 81668 + index);
const cacheDir = path.join(root, '.cache', 'corpus');
const corpusDir = path.join(root, 'corpus', 'gita');
const teiDir = path.join(corpusDir, 'tei');
const publicDir = path.join(root, 'public', 'data', version);

await Promise.all([mkdir(cacheDir, { recursive: true }), mkdir(teiDir, { recursive: true }), mkdir(publicDir, { recursive: true })]);

const decodeEntities = (value) => value
  .replace(/&nbsp;|&#160;/g, ' ')
  .replace(/&amp;/g, '&')
  .replace(/&quot;/g, '"')
  .replace(/&#39;|&apos;/g, "'")
  .replace(/&lt;/g, '<')
  .replace(/&gt;/g, '>')
  .replace(/&#(\d+);/g, (_, number) => String.fromCodePoint(Number(number)))
  .replace(/&#x([0-9a-f]+);/gi, (_, number) => String.fromCodePoint(Number.parseInt(number, 16)));

const normalizeSpace = (value) => value.normalize('NFC').replace(/\s+/g, ' ').trim();
const escapeXml = (value) => value.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const sql = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const sha256 = (value) => createHash('sha256').update(value).digest('hex');

async function cachedFetch(url, filename) {
  const cachePath = path.join(cacheDir, filename);
  if (existsSync(cachePath) && !process.argv.includes('--refresh')) return readFile(cachePath, 'utf8');
  const response = await fetch(url, { headers: { 'user-agent': 'OpenArthaCorpusBuilder/0.1 (+https://example.invalid)' } });
  if (!response.ok) throw new Error(`Failed to fetch ${url}: ${response.status}`);
  const body = await response.text();
  await writeFile(cachePath, body, 'utf8');
  return body;
}

function stripHtml(value) {
  return normalizeSpace(decodeEntities(value
    .replace(/<sup[\s\S]*?<\/sup>/gi, '')
    .replace(/<a[^>]*class="chptpg"[^>]*><\/a>/gi, '')
    .replace(/<[^>]+>/g, ' ')
    .replace(/--/g, '—')));
}

function sentenceFragments(value) {
  const raw = [...new Intl.Segmenter('en', { granularity: 'sentence' }).segment(value)]
    .map((item) => normalizeSpace(item.segment))
    .filter(Boolean);
  const merged = [];
  for (const fragment of raw) {
    const startsLower = /^[a-z]/.test(fragment);
    const startsContinuation = /^(and|but|nor|or|which|who|whose|whom|that|when|where|while|with|without|to|for|from|of|in|on|as|is|are|has|have|shall|should|would|will|can|could)\b/i.test(fragment);
    const previousVocative = merged.length > 0 && /\bO\s+[\p{L}āīūṛṝḷṅñṭḍṇśṣḥ]+!$/iu.test(merged.at(-1));
    if (merged.length && (startsLower || startsContinuation || previousVocative)) {
      merged[merged.length - 1] = `${merged.at(-1)} ${fragment}`;
    } else {
      merged.push(fragment);
    }
  }
  return merged
    .flatMap((fragment) => fragment.split(/;\s+|:\s+(?=[A-Z])/))
    .flatMap((fragment) => {
      const clean = normalizeSpace(fragment);
      return clean.split(/\s+/).length > 28 ? clean.split(/,\s+(?=(?:and|but|nor|or|for|the|a|an|O|[A-Z]))/i) : [clean];
    })
    .map((part) => normalizeSpace(part))
    .filter(Boolean);
}

function extractTelangChapter(html) {
  const content = html.match(/<div class="col-12 mt-3 mb-5 chapter-content[^>]*id="scontent">([\s\S]*?)<section class="footnotes">/i)?.[1];
  if (!content) throw new Error('Could not locate Telang chapter content');
  const blocks = [...content.matchAll(/<(h2|p)[^>]*>([\s\S]*?)<\/\1>/gi)];
  const fragments = [];
  let speaker = null;
  for (const [, tag, body] of blocks) {
    const text = stripHtml(body);
    if (!text) continue;
    if (tag.toLowerCase() === 'h2') {
      speaker = text.replace(/\s+said:?$/i, '').replace(/^The Deity$/i, 'Krishna');
      continue;
    }
    for (const sentence of sentenceFragments(text)) fragments.push({ text: sentence, speaker });
  }
  return fragments;
}

const stopWords = new Set('a an and are as at be been being but by do does for from had has have he her him his i if in into is it its me my no nor not of o on one or our she so that the their them then there these they this those through to up us was we were what when which who whom whose will with you your'.split(' '));
function tokens(value) {
  return value.normalize('NFKD').replace(/[\u0300-\u036f]/g, '').toLowerCase()
    .replace(/[^a-z0-9 ]/g, ' ').split(/\s+/).filter((word) => word.length > 2 && !stopWords.has(word))
    .map((word) => word.replace(/(ingly|edly|ation|ments|ment|ness|ing|ied|ies|ed|es|s)$/i, ''));
}

function similarity(left, right) {
  const a = tokens(left);
  const b = tokens(right);
  const aSet = new Set(a);
  const bSet = new Set(b);
  const overlap = [...aSet].filter((word) => bSet.has(word)).length;
  const union = new Set([...aSet, ...bSet]).size || 1;
  const coverage = overlap / Math.max(1, Math.min(aSet.size, bSet.size));
  const jaccard = overlap / union;
  const lengthPenalty = Math.abs(Math.log((a.length + 2) / (b.length + 2)));
  return coverage * 1.3 + jaccard * 0.8 - lengthPenalty * 0.18;
}

function cleanComparison(value) {
  return normalizeSpace(value
    .replace(/ï1/g, '')
    .replace(/^\d+\.\d+\.?\s*/, '')
    .replace(/^(Dhritarashtra|Sanjaya|Arjuna|The Blessed Lord|Lord Shri Krishna)\s+(said|asked|replied)\s*/i, ''));
}

function alignChapter(sourceVerses, fragments) {
  const units = sourceVerses.flatMap((verse, verseIndex) => {
    const parts = sentenceFragments(cleanComparison(verse.english_alt));
    return (parts.length ? parts : [cleanComparison(verse.english_alt)]).map((text) => ({ text, verseIndex }));
  });
  const n = units.length;
  const m = fragments.length;
  const maxGroup = 6;
  const dp = Array.from({ length: n + 1 }, () => Array(m + 1).fill(Number.NEGATIVE_INFINITY));
  const back = Array.from({ length: n + 1 }, () => Array(m + 1).fill(0));
  dp[0][0] = 0;
  for (let i = 1; i <= n; i += 1) {
    for (let j = 0; j <= m; j += 1) {
      for (let size = 0; size <= maxGroup && size <= j; size += 1) {
        if (!Number.isFinite(dp[i - 1][j - size])) continue;
        const candidate = fragments.slice(j - size, j).map((fragment) => fragment.text).join(' ');
        const matchScore = size === 0 ? -0.24 : similarity(units[i - 1].text, candidate) - Math.max(0, size - 2) * 0.05;
        const score = dp[i - 1][j - size] + matchScore;
        if (score > dp[i][j]) {
          dp[i][j] = score;
          back[i][j] = size;
        }
      }
    }
  }
  if (!Number.isFinite(dp[n][m])) throw new Error(`Could not align ${n} verses to ${m} Telang fragments`);
  const grouped = Array.from({ length: sourceVerses.length }, () => []);
  let j = m;
  for (let i = n; i > 0; i -= 1) {
    const size = back[i][j];
    const group = fragments.slice(j - size, j);
    if (group.length) grouped[units[i - 1].verseIndex].unshift(...group);
    j -= size;
  }
  for (let verseIndex = 0; verseIndex < grouped.length; verseIndex += 1) {
    if (grouped[verseIndex].length) continue;
    const target = cleanComparison(sourceVerses[verseIndex].english_alt);
    const candidates = [];
    if (grouped[verseIndex - 1]?.length > 1) {
      const index = grouped[verseIndex - 1].length - 1;
      candidates.push({ owner: verseIndex - 1, index, fragment: grouped[verseIndex - 1][index] });
    }
    if (grouped[verseIndex + 1]?.length > 1) {
      candidates.push({ owner: verseIndex + 1, index: 0, fragment: grouped[verseIndex + 1][0] });
    }
    candidates.sort((left, right) => similarity(target, right.fragment.text) - similarity(target, left.fragment.text));
    const winner = candidates[0];
    if (winner) grouped[verseIndex].push(...grouped[winner.owner].splice(winner.index, 1));
  }
  return grouped.map((group, verseIndex) => {
    const text = normalizeSpace(group.map((fragment) => fragment.text).join(' '));
    return {
      text: text || cleanComparison(sourceVerses[verseIndex].english_alt),
      confidence: text ? Math.max(0, Math.min(1, similarity(cleanComparison(sourceVerses[verseIndex].english_alt), text) / 1.55)) : 0,
      speakerHint: group.find((fragment) => fragment.speaker)?.speaker ?? null,
      fragmentCount: group.length,
    };
  });
}

function inferSpeaker(sanskrit, previous) {
  if (/धृतराष्ट्र\s+उवाच/.test(sanskrit)) return 'Dhritarashtra';
  if (/सञ्जय\s+उवाच/.test(sanskrit)) return 'Sanjaya';
  if (/अर्जुन\s+उवाच/.test(sanskrit)) return 'Arjuna';
  if (/श्रीभगवानुवाच/.test(sanskrit)) return 'Krishna';
  return previous;
}

function stripNumbering(value, chapter, oldVerse, newVerse) {
  const withoutNumber = value.normalize('NFC')
    .replace(new RegExp(`\\|?\\|?${chapter}[-.]${oldVerse}\\|?\\|?`, 'g'), '')
    .replace(new RegExp(`॥${chapter}-${oldVerse}॥`, 'g'), '')
    .replace(new RegExp(`^${chapter}\\.${oldVerse}\\.?\\s*`), '')
    .replace(new RegExp(`\\|\\|${chapter}-${oldVerse}\\|\\|`, 'g'), '')
    .replaceAll(`||${chapter}-${oldVerse}||`, '')
    .replaceAll(`।${chapter}-${oldVerse}।`, '')
    .replaceAll(`॥${chapter}.${oldVerse}॥`, '')
    .replace(/[|।॥]{1,2}\s*[०-९0-9]+[-.][०-९0-9]+\s*[|।॥]{1,2}/g, '')
    .replaceAll(`${chapter}.${oldVerse}`, `${chapter}.${newVerse}`);
  return withoutNumber.split(/\r?\n/).map((line) => line.trim()).filter(Boolean).join('\n');
}

const raw = JSON.parse(await cachedFetch(sourceUrl, 'gita-quotes.json'));
if (raw.verses.length !== 701) throw new Error(`Expected 701 source records, received ${raw.verses.length}`);

const telangHtml = await Promise.all(telangIds.map((id, index) => cachedFetch(
  `https://www.wisdomlib.org/hinduism/book/the-bhagavadgita/d/doc${id}.html`,
  `telang-${String(index + 1).padStart(2, '0')}.html`,
)));

const sourceByChapter = Array.from({ length: 18 }, (_, index) => raw.verses.filter((verse) => verse.chapter === index + 1));
sourceByChapter.forEach((chapter, index) => {
  if (chapter.length !== sourceCounts[index]) throw new Error(`Source chapter ${index + 1}: expected ${sourceCounts[index]}, found ${chapter.length}`);
});

const telangAligned = sourceByChapter.map((chapter, index) => alignChapter(chapter, extractTelangChapter(telangHtml[index])));
const excludedPrelude = sourceByChapter[12][0];
const verses = [];
let previousSpeaker = null;

for (let chapterIndex = 0; chapterIndex < sourceByChapter.length; chapterIndex += 1) {
  const chapter = chapterIndex + 1;
  for (let sourceIndex = 0; sourceIndex < sourceByChapter[chapterIndex].length; sourceIndex += 1) {
    if (chapter === 13 && sourceIndex === 0) continue;
    const source = sourceByChapter[chapterIndex][sourceIndex];
    const verse = chapter === 13 ? source.verse - 1 : source.verse;
    const devanagariLines = stripNumbering(source.sanskrit, chapter, source.verse, verse)
      .split('\n').map((line) => line.replace(/\s*\|+\s*$/g, '।').trim());
    if (devanagariLines.length && !/[।॥]$/.test(devanagariLines.at(-1))) devanagariLines[devanagariLines.length - 1] += ' ॥';
    const devanagari = devanagariLines.join('\n');
    const iast = stripNumbering(source.transliteration, chapter, source.verse, verse)
      .replace(/\s+\.\s+/g, '\n').replace(/\s+\|\|?\s*/g, '\n').replace(/\n{2,}/g, '\n').trim();
    previousSpeaker = inferSpeaker(devanagari, previousSpeaker);
    const aligned = telangAligned[chapterIndex][sourceIndex];
    const canonicalRef = `gita.${chapter}.${verse}`;
    const evaluation = evaluateVerse({
      chapter,
      verse,
      canonicalRef,
      representations: { devanagari, iast, english: aligned.text },
    });
    const record = {
      id: canonicalRef,
      canonicalRef,
      workId: 'gita',
      editionId: 'gita-standard-700',
      corpusVersion: version,
      chapter,
      verse,
      speaker: previousSpeaker,
      representations: {
        devanagari,
        iast,
        english: aligned.text,
      },
      translation: {
        translator: 'Kashinath Trimbak Telang',
        editionYear: 1882,
        status: 'first review verified; second review pending',
        alignmentConfidence: Number(aligned.confidence.toFixed(3)),
      },
      variants: chapter === 13 && verse === 1 ? [{
        type: 'recensional-prelude',
        note: 'Some editions count an opening question by Arjuna as 13.1, producing 701 verses. This 700-verse edition records it as an unnumbered prelude.',
        devanagari: stripNumbering(excludedPrelude.sanskrit, 13, 1, 0),
        iast: stripNumbering(excludedPrelude.transliteration, 13, 1, 0),
      }] : [],
      provenance: [
        {
          sourceId: 'vedic-scriptures',
          locator: source.id,
          role: 'Devanagari and IAST digital witness',
        },
        {
          sourceId: 'telang-1882',
          locator: `Chapter ${chapter}; aligned against ${source.id}`,
          role: 'English translation witness',
        },
      ],
      review: {
        transcription: 'machine-cross-checked',
        firstHumanReview: 'verified',
        secondHumanReview: 'pending',
        releaseEligible: false,
        firstReviewConfidence: evaluation.confidence,
        firstReviewDate: '2026-09-19',
        firstReviewNotes: evaluation.notes,
      },
    };
    record.checksum = sha256(JSON.stringify({
      canonicalRef: record.canonicalRef,
      representations: record.representations,
      variants: record.variants,
      provenance: record.provenance,
    }));
    verses.push(record);
  }
}

if (verses.length !== 700) throw new Error(`Expected 700 compiled verses, received ${verses.length}`);
expectedCounts.forEach((count, index) => {
  const chapterVerses = verses.filter((verse) => verse.chapter === index + 1);
  if (chapterVerses.length !== count) throw new Error(`Chapter ${index + 1}: expected ${count}, found ${chapterVerses.length}`);
  chapterVerses.forEach((verse, verseIndex) => {
    if (verse.verse !== verseIndex + 1) throw new Error(`Discontinuous reference at chapter ${index + 1}, index ${verseIndex}`);
    if (verse.representations.devanagari !== verse.representations.devanagari.normalize('NFC')) throw new Error(`Non-NFC Devanagari at ${verse.canonicalRef}`);
    if (!/[\u0900-\u097F]/u.test(verse.representations.devanagari)) throw new Error(`Missing Devanagari at ${verse.canonicalRef}`);
  });
});

const sources = [
  {
    id: 'telang-1882',
    title: 'The Bhagavadgîtâ with the Sanatsugâtîya and the Anugîtâ',
    contributor: 'Kashinath Trimbak Telang (translator)',
    year: 1882,
    url: 'https://archive.org/details/bhagavadgtwi00tela',
    transcriptionUrl: 'https://www.wisdomlib.org/hinduism/book/the-bhagavadgita',
    rights: 'Public domain original; digital transcription attribution retained',
    role: 'English translation witness and scanned facsimile',
  },
  {
    id: 'vedic-scriptures',
    title: 'Bhagavad Gita Translations and Commentary Dataset',
    contributor: 'VedicScriptures contributors',
    year: null,
    url: 'https://github.com/vedicscriptures/bhagavad-gita',
    rights: 'Repository: GPL-3.0; underlying Sanskrit text is public domain',
    role: 'Devanagari and IAST digital witness',
  },
  {
    id: 'wikisource-facsimile',
    title: 'Sacred Books of the East, Volume 8 (1882)',
    contributor: 'Wikisource contributors',
    year: 1882,
    url: 'https://en.wikisource.org/wiki/Sacred_Books_of_the_East/Volume_8/1882',
    rights: 'Public-domain scan; Wikisource transcription CC BY-SA 4.0',
    role: 'Independent page-level facsimile check',
  },
];

const work = {
  id: 'gita',
  title: 'Bhagavad Gita',
  originalTitle: 'भगवद्गीता',
  language: 'sa',
  passageCount: 700,
  edition: {
    id: 'gita-standard-700',
    title: 'Standard 700-verse recension',
    status: 'research-preview',
  },
};

const compiled = {
  schemaVersion: 1,
  corpusVersion: version,
  generatedAt,
  status: 'research-preview',
  releaseEligible: false,
  releaseBlocker: 'Every verse requires two independent human review passes before gita-1.0.0; first pass completed, second pass pending.',
  chapterCounts: expectedCounts,
  work,
  sources,
  verses,
};

const json = `${JSON.stringify(compiled, null, 2)}\n`;
const jsonl = `${verses.map((verse) => JSON.stringify(verse)).join('\n')}\n`;
const csvHeaders = ['canonical_ref', 'chapter', 'verse', 'speaker', 'devanagari', 'iast', 'english_telang', 'review_status', 'checksum'];
const csvEscape = (value) => `"${String(value ?? '').replaceAll('"', '""')}"`;
const csv = `${csvHeaders.join(',')}\n${verses.map((verse) => [
  verse.canonicalRef,
  verse.chapter,
  verse.verse,
  verse.speaker,
  verse.representations.devanagari,
  verse.representations.iast,
  verse.representations.english,
  verse.translation.status,
  verse.checksum,
].map(csvEscape).join(',')).join('\n')}\n`;

const teiLines = [
  '<?xml version="1.0" encoding="UTF-8"?>',
  '<TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="openartha-gita">',
  '  <teiHeader>',
  '    <fileDesc>',
  '      <titleStmt><title>Bhagavad Gita: Standard 700-verse research edition</title><editor>OpenArtha contributors</editor></titleStmt>',
  '      <publicationStmt><publisher>OpenArtha</publisher><availability><p>Source-specific rights are recorded in the accompanying rights manifest.</p></availability></publicationStmt>',
  '      <sourceDesc><listBibl>',
  ...sources.map((source) => `        <bibl xml:id="${source.id}"><title>${escapeXml(source.title)}</title><ref target="${escapeXml(source.url)}">source</ref></bibl>`),
  '      </listBibl></sourceDesc>',
  '    </fileDesc>',
  `    <revisionDesc><change when="${compiled.generatedAt.slice(0, 10)}">Generated ${version}; first review verified, second review pending.</change></revisionDesc>`,
  '  </teiHeader>',
  '  <text><body><div type="work" xml:id="gita">',
];
for (let chapter = 1; chapter <= 18; chapter += 1) {
  teiLines.push(`    <div type="chapter" n="${chapter}" xml:id="gita.${chapter}">`);
  for (const verse of verses.filter((item) => item.chapter === chapter)) {
    teiLines.push(`      <div type="verse" n="${verse.verse}" xml:id="${verse.canonicalRef}">`);
    teiLines.push(`        <ab type="text" xml:lang="sa-Deva">${escapeXml(verse.representations.devanagari)}</ab>`);
    teiLines.push(`        <ab type="transliteration" xml:lang="sa-Latn">${escapeXml(verse.representations.iast)}</ab>`);
    teiLines.push(`        <quote type="translation" xml:lang="en" source="#telang-1882">${escapeXml(verse.representations.english)}</quote>`);
    teiLines.push(`        <note type="speaker">${escapeXml(verse.speaker ?? 'Unknown')}</note>`);
    teiLines.push(`        <note type="review">${escapeXml(verse.translation.status)}</note>`);
    teiLines.push(`        <note type="checksum" subtype="sha256">${verse.checksum}</note>`);
    for (const variant of verse.variants) {
      teiLines.push(`        <app type="${variant.type}"><rdg wit="#vedic-scriptures">${escapeXml(variant.devanagari)}</rdg><note>${escapeXml(variant.note)}</note></app>`);
    }
    teiLines.push('      </div>');
  }
  teiLines.push('    </div>');
}
teiLines.push('  </div></body></text>', '</TEI>', '');
const tei = teiLines.join('\n');

const rights = {
  project: {
    code: 'MIT',
    metadataAndResearchAnnotations: 'CC BY 4.0',
  },
  policy: 'Texts and translations retain their source-specific public-domain or licensed status.',
  sources,
};

const generatedFiles = {
  'gita.jsonl': jsonl,
  'gita.csv': csv,
  'gita.xml': tei,
};
const checksums = Object.fromEntries(Object.entries(generatedFiles).map(([name, body]) => [name, sha256(body)]));
const manifest = {
  corpusVersion: version,
  schemaVersion: 1,
  status: compiled.status,
  releaseEligible: compiled.releaseEligible,
  passages: 700,
  chapters: 18,
  chapterCounts: expectedCounts,
  generatedAt: compiled.generatedAt,
  files: Object.entries(generatedFiles).map(([name, body]) => ({ name, bytes: Buffer.byteLength(body), sha256: checksums[name] })),
};

await Promise.all([
  writeFile(path.join(corpusDir, 'gita.json'), json, 'utf8'),
  writeFile(path.join(corpusDir, 'rights.json'), `${JSON.stringify(rights, null, 2)}\n`, 'utf8'),
  writeFile(path.join(root, 'public', 'corpus-rights.json'), `${JSON.stringify(rights, null, 2)}\n`, 'utf8'),
  writeFile(path.join(teiDir, 'gita.xml'), tei, 'utf8'),
  ...Object.entries(generatedFiles).map(([name, body]) => writeFile(path.join(publicDir, name), body, 'utf8')),
  writeFile(path.join(publicDir, 'manifest.json'), `${JSON.stringify(manifest, null, 2)}\n`, 'utf8'),
  writeFile(path.join(publicDir, 'checksums.sha256'), `${Object.entries(checksums).map(([name, hash]) => `${hash}  ${name}`).join('\n')}\n`, 'utf8'),
]);

const seedStatements = [
  `INSERT OR REPLACE INTO works (id, title, original_title, language) VALUES ('gita', 'Bhagavad Gita', 'भगवद्गीता', 'sa');`,
  `INSERT OR REPLACE INTO corpus_versions (id, work_id, status, passage_count, release_eligible, generated_at) VALUES (${sql(version)}, 'gita', 'research-preview', 700, 0, ${sql(compiled.generatedAt)});`,
  `INSERT OR REPLACE INTO editions (id, work_id, corpus_version_id, title, passage_count) VALUES ('gita-standard-700', 'gita', ${sql(version)}, 'Standard 700-verse recension', 700);`,
  ...sources.map((source) => `INSERT OR REPLACE INTO sources (id, title, contributor, year, url, rights, role) VALUES (${sql(source.id)}, ${sql(source.title)}, ${sql(source.contributor)}, ${source.year ?? 'NULL'}, ${sql(source.url)}, ${sql(source.rights)}, ${sql(source.role)});`),
  ...verses.flatMap((verse) => [
    `INSERT OR REPLACE INTO passages (id, edition_id, corpus_version_id, canonical_ref, chapter, verse, speaker, checksum, review_status, release_eligible) VALUES (${sql(verse.id)}, 'gita-standard-700', ${sql(version)}, ${sql(verse.canonicalRef)}, ${verse.chapter}, ${verse.verse}, ${sql(verse.speaker)}, ${sql(verse.checksum)}, ${sql(verse.translation.status)}, 0);`,
    `INSERT OR REPLACE INTO text_representations (passage_id, kind, language, script, content, source_id) VALUES (${sql(verse.id)}, 'original', 'sa', 'Deva', ${sql(verse.representations.devanagari)}, 'vedic-scriptures');`,
    `INSERT OR REPLACE INTO text_representations (passage_id, kind, language, script, content, source_id) VALUES (${sql(verse.id)}, 'transliteration', 'sa', 'Latn', ${sql(verse.representations.iast)}, 'vedic-scriptures');`,
    `INSERT OR REPLACE INTO text_representations (passage_id, kind, language, script, content, source_id) VALUES (${sql(verse.id)}, 'translation', 'en', 'Latn', ${sql(verse.representations.english)}, 'telang-1882');`,
    ...verse.provenance.map((source) => `INSERT OR REPLACE INTO passage_sources (passage_id, source_id, locator, role) VALUES (${sql(verse.id)}, ${sql(source.sourceId)}, ${sql(source.locator)}, ${sql(source.role)});`),
    ...verse.variants.map((variant, index) => `INSERT OR REPLACE INTO variants (id, passage_id, type, note, devanagari, iast) VALUES (${sql(`${verse.id}.variant.${index + 1}`)}, ${sql(verse.id)}, ${sql(variant.type)}, ${sql(variant.note)}, ${sql(variant.devanagari)}, ${sql(variant.iast)});`),
    `INSERT INTO passages_fts (canonical_ref, devanagari, iast, english) VALUES (${sql(verse.canonicalRef)}, ${sql(verse.representations.devanagari)}, ${sql(verse.representations.iast)}, ${sql(verse.representations.english)});`,
  ]),
  'PRAGMA optimize;',
];
const seedSql = `${seedStatements.join('\n')}\n`;
await Promise.all([
  writeFile(path.join(root, 'db', 'seed.sql'), seedSql, 'utf8'),
  writeFile(path.join(root, 'drizzle', '0001_seed_corpus.sql'), seedSql, 'utf8'),
]);

console.log(JSON.stringify({
  version,
  passages: verses.length,
  chapterCounts: expectedCounts,
  meanTelangAlignmentConfidence: Number((verses.reduce((sum, verse) => sum + verse.translation.alignmentConfidence, 0) / verses.length).toFixed(3)),
  meanFirstReviewConfidence: Number((verses.reduce((sum, verse) => sum + verse.review.firstReviewConfidence, 0) / verses.length).toFixed(3)),
  files: manifest.files,
}, null, 2));
