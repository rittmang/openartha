import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import { spawnSync } from 'node:child_process';
import path from 'node:path';

const root = process.cwd();
const expectedCounts = [47, 72, 43, 42, 29, 47, 30, 28, 34, 42, 55, 20, 34, 27, 20, 24, 28, 78];
const corpus = JSON.parse(await readFile(path.join(root, 'corpus/gita/gita.json'), 'utf8'));
const versionDir = path.join(root, 'public/data', corpus.corpusVersion);
const manifest = JSON.parse(await readFile(path.join(versionDir, 'manifest.json'), 'utf8'));
const rights = JSON.parse(await readFile(path.join(root, 'corpus/gita/rights.json'), 'utf8'));
const sha256 = (value) => createHash('sha256').update(value).digest('hex');

assert.equal(corpus.verses.length, 700, 'The corpus must contain exactly 700 passages');
assert.equal(new Set(corpus.verses.map((verse) => verse.canonicalRef)).size, 700, 'Canonical references must be unique');
assert.deepEqual(corpus.chapterCounts, expectedCounts, 'Chapter counts must match the standard 700-verse structure');
assert.equal(expectedCounts.reduce((sum, count) => sum + count, 0), 700);
assert.equal(corpus.releaseEligible, false, 'A release candidate cannot claim stable eligibility');
assert.match(corpus.releaseBlocker, /two independent human review/i);

for (let chapter = 1; chapter <= 18; chapter += 1) {
  const passages = corpus.verses.filter((verse) => verse.chapter === chapter);
  assert.equal(passages.length, expectedCounts[chapter - 1], `Chapter ${chapter} count`);
  passages.forEach((passage, index) => {
    assert.equal(passage.verse, index + 1, `Chapter ${chapter} numbering must be continuous`);
    assert.equal(passage.canonicalRef, `gita.${chapter}.${index + 1}`);
    assert.equal(passage.representations.devanagari, passage.representations.devanagari.normalize('NFC'));
    assert.equal(passage.representations.iast, passage.representations.iast.normalize('NFC'));
    assert.match(passage.representations.devanagari, /[\u0900-\u097F]/u, `${passage.canonicalRef} needs Devanagari`);
    assert.match(passage.representations.iast, /[a-zāīūṛṝḷṅñṭḍṇśṣḥṃ]/iu, `${passage.canonicalRef} needs IAST`);
    assert.ok(passage.representations.english.length > 0, `${passage.canonicalRef} needs English text`);
    assert.ok(passage.provenance.length >= 2, `${passage.canonicalRef} needs two source roles`);
    assert.equal(passage.review.firstHumanReview, 'verified');
    assert.equal(passage.review.secondHumanReview, 'pending');
    assert.equal(passage.review.releaseEligible, false);
    assert.equal(passage.review.reviewerModel, 'google/gemini-3.8-flash');
    assert.equal(typeof passage.review.firstReviewConfidence, 'number');
    assert.ok(passage.review.firstReviewConfidence >= 0 && passage.review.firstReviewConfidence <= 1);
    const expectedChecksum = sha256(JSON.stringify({
      canonicalRef: passage.canonicalRef,
      representations: passage.representations,
      variants: passage.variants,
      provenance: passage.provenance,
    }));
    assert.equal(passage.checksum, expectedChecksum, `${passage.canonicalRef} checksum`);
  });
}

const jsonl = await readFile(path.join(versionDir, 'gita.jsonl'), 'utf8');
const jsonlPassages = jsonl.trim().split('\n').map((line) => JSON.parse(line));
assert.equal(jsonlPassages.length, 700, 'JSONL must contain one record per passage');
assert.deepEqual(jsonlPassages.map((verse) => verse.checksum), corpus.verses.map((verse) => verse.checksum));

for (const file of manifest.files) {
  const body = await readFile(path.join(versionDir, file.name));
  assert.equal(body.byteLength, file.bytes, `${file.name} byte length`);
  assert.equal(sha256(body), file.sha256, `${file.name} manifest checksum`);
}

assert.equal(rights.project.code, 'MIT');
assert.equal(rights.project.metadataAndResearchAnnotations, 'CC BY 4.0');
for (const source of rights.sources) {
  assert.ok(source.id && source.url && source.rights && source.role, `Complete rights metadata for ${source.id ?? 'unknown source'}`);
}

const teiPath = path.join(root, 'corpus/gita/tei/gita.xml');
const tei = await readFile(teiPath, 'utf8');
assert.match(tei, /<TEI xmlns="http:\/\/www\.tei-c\.org\/ns\/1\.0"/);
assert.equal((tei.match(/<div type="verse"/g) ?? []).length, 700, 'TEI must contain 700 verse divisions');
const xmlLint = spawnSync('xmllint', ['--noout', teiPath], { encoding: 'utf8' });
if (xmlLint.error?.code !== 'ENOENT') assert.equal(xmlLint.status, 0, xmlLint.stderr || 'TEI must be well formed XML');

console.log(`Validated ${corpus.corpusVersion}: 18 chapters, 700 passages, ${manifest.files.length} checked exports.`);
