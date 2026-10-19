import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { existsSync } from 'node:fs';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { parseGutenbergTranslation } from './lib/parse-gutenberg-translation.mjs';
import { alignArnoldTranslation } from './lib/align-arnold-translation.mjs';
import { arnoldSeedSql } from './lib/arnold-sql.mjs';
import { attachArnoldFirstReview } from './lib/arnold-review.mjs';

const root = fileURLToPath(new URL('../', import.meta.url));
const corpusDir = path.join(root, 'corpus/gita-translations/edwin-arnold');
const metadata = JSON.parse(await readFile(path.join(corpusDir, 'source.json'), 'utf8'));
const raw = await readFile(path.join(corpusDir, 'source/pg2388.txt'));
const sha256 = (value) => createHash('sha256').update(value).digest('hex');
assert.equal(sha256(raw), metadata.source.sha256, 'Downloaded source must match its pinned checksum');
const parsed = parseGutenbergTranslation(raw.toString('utf8'));
const canonical = JSON.parse(await readFile(path.join(root, 'corpus/gita/gita.json'), 'utf8'));
const alignment = JSON.parse(await readFile(path.join(corpusDir, 'alignment.json'), 'utf8'));
const aligned = alignArnoldTranslation(parsed, alignment, canonical, metadata);
const reviewPath = path.join(root, 'research/arnold-first-review/first-review.json');
const firstReview = existsSync(reviewPath) ? JSON.parse(await readFile(reviewPath, 'utf8')) : null;
if (firstReview) {
  assert.equal(firstReview.sourceSha256, metadata.source.sha256, 'Review must identify the exact source');
  aligned.verses = attachArnoldFirstReview(aligned.verses, firstReview);
}
const translation = {
  schemaVersion: 1,
  ...metadata,
  chapters: parsed.chapters.map((chapter) => ({
    id: `gita.edwin-arnold.${chapter.chapter}`,
    ...chapter,
    checksum: sha256(chapter.text),
  })),
  notes: parsed.notes,
  verses: aligned.verses,
  paratext: aligned.paratext,
  ...(firstReview ? { firstReview: { reviewerModel: firstReview.reviewerModel, providerModel: firstReview.providerModel, transport: firstReview.transport, status: firstReview.status, reviewedAt: firstReview.reviewedAt, counts: firstReview.counts, confidence: firstReview.confidence } } : {}),
};
const alignmentReport = {
  corpusVersion: metadata.corpusVersion,
  sourceSha256: metadata.source.sha256,
  canonicalCorpusVersion: canonical.corpusVersion,
  review: alignment.review,
  canonicalPassages: aligned.verses.length,
  translatedPassages: aligned.verses.filter((verse) => verse.content).length,
  omittedPassages: aligned.verses.filter((verse) => !verse.content).map((verse) => verse.canonicalRef),
  sharedSpans: aligned.groups.filter((group) => group.relation === 'shared-source-span'),
  chapters: parsed.chapters.map((chapter) => ({ chapter: chapter.chapter, canonicalPassages: aligned.verses.filter((verse) => verse.chapter === chapter.chapter).length, sourceCoverage: 'complete; each source character belongs to one alignment group or preserved paratext' })),
  groups: aligned.groups,
  ...(firstReview ? { firstReview: translation.firstReview } : {}),
};
const rights = {
  translationId: metadata.id,
  workId: metadata.workId,
  title: metadata.title,
  translator: metadata.translator,
  editionYear: metadata.editionYear,
  rights: metadata.source.rights,
  source: metadata.source,
  distribution: 'The complete, unchanged Project Gutenberg source, including credits and full license, is included as pg2388.txt.',
  metadataLicense: 'CC BY 4.0',
};
const files = [
  { name: 'translation.json', data: JSON.stringify(translation, null, 2) + '\n' },
  { name: 'pg2388.txt', data: raw },
  { name: 'rights.json', data: JSON.stringify(rights, null, 2) + '\n' },
  { name: 'verses.jsonl', data: aligned.verses.map((verse) => JSON.stringify(verse)).join('\n') + '\n' },
  { name: 'alignment-report.json', data: JSON.stringify(alignmentReport, null, 2) + '\n' },
  ...(firstReview ? [{ name: 'first-review.json', data: JSON.stringify(firstReview, null, 2) + '\n' }] : []),
];
const manifest = {
  schemaVersion: 1,
  corpusVersion: metadata.corpusVersion,
  workId: metadata.workId,
  translationId: metadata.id,
  granularity: metadata.granularity,
  chapters: translation.chapters.length,
  translatorNotes: translation.notes.length,
  canonicalPassages: aligned.verses.length,
  translatedPassages: alignmentReport.translatedPassages,
  omittedPassages: alignmentReport.omittedPassages.length,
  sourceSha256: metadata.source.sha256,
  files: files.map(({ name, data }) => ({ name, bytes: Buffer.byteLength(data), sha256: sha256(data) })),
};
const publicDir = path.join(root, 'public/data', metadata.corpusVersion);
await mkdir(publicDir, { recursive: true });
await writeFile(path.join(corpusDir, 'translation.json'), files[0].data);
for (const file of files) await writeFile(path.join(publicDir, file.name), file.data);
const manifestJson = JSON.stringify(manifest, null, 2) + '\n';
await writeFile(path.join(publicDir, 'manifest.json'), manifestJson);
await writeFile(path.join(publicDir, 'checksums.sha256'), [
  ...manifest.files.map((file) => `${file.sha256}  ${file.name}`),
  `${sha256(manifestJson)}  manifest.json`,
  '',
].join('\n'));
// Keep the original seed immutable: local databases may already have applied it.
const migrationTag = firstReview ? '0044_review_edwin_arnold_v100' : '0043_seed_edwin_arnold_v100';
await writeFile(path.join(root, 'drizzle', `${migrationTag}.sql`), arnoldSeedSql(translation));
const journalPath = path.join(root, 'drizzle/meta/_journal.json');
const journal = JSON.parse(await readFile(journalPath, 'utf8'));
if (!journal.entries.some((entry) => entry.tag === migrationTag)) {
  journal.entries.push({ idx: journal.entries.length, version: '6', when: Math.max(...journal.entries.map((entry) => entry.when)) + 1, tag: migrationTag, breakpoints: true });
  await writeFile(journalPath, JSON.stringify(journal, null, 2) + '\n');
}
console.log(`Built ${metadata.corpusVersion}: ${translation.chapters.length} chapters, ${translation.verses.length} verse records (${alignmentReport.translatedPassages} renderings, ${alignmentReport.omittedPassages.length} omissions), ${translation.notes.length} notes, and D1 seed migration.`);
