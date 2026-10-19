import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';
import { arnoldAlignmentFingerprint, attachArnoldFirstReview, reviewStatistics, sha256, validateArnoldChapterReview } from '../scripts/lib/arnold-review.mjs';

const directory = new URL('../research/arnold-first-review/', import.meta.url);
const manifest = JSON.parse(await readFile(new URL('input-manifest.json', directory), 'utf8'));
const translation = JSON.parse(await readFile(new URL('../corpus/gita-translations/edwin-arnold/translation.json', import.meta.url), 'utf8'));
const input = JSON.parse(await readFile(new URL(manifest.chapters[0].path, directory), 'utf8'));

test('review inputs pin the current alignment without inheriting approval labels', () => {
  assert.equal(manifest.canonicalPassages, 700);
  for (const record of input.records) {
    assert.equal(record.alignmentFingerprint, arnoldAlignmentFingerprint(translation.verses.find((verse) => verse.canonicalRef === record.canonicalRef)));
    assert.equal('review' in record.arnold, false);
    assert.equal('confidence' in record.arnold, false);
    assert.ok(record.sanskrit && record.iast && record.witnesses.length === 3);
  }
});

test('review validation rejects incomplete coverage, stale text, wrong model, and invalid confidence', () => {
  // Deliberately invalid fixtures; these are never assembled as real review data.
  const invalid = { schemaVersion: 1, reviewerModel: 'google/gemini-3.8-flash', providerModel: 'openrouter/google/gemini-3.8-flash', transport: 'opencode', reviewedCommit: input.reviewedCommit, sourceSha256: input.sourceSha256, chapter: 1, inputSha256: manifest.chapters[0].sha256, chapterFindings: [], reviews: [] };
  assert.throws(() => validateArnoldChapterReview(invalid, input, manifest.chapters[0]), /Every chapter reference/);
  invalid.reviews = input.records.map((record) => ({ canonicalRef: record.canonicalRef, alignmentFingerprint: record.alignmentFingerprint, status: 'verified', confidence: 2, notes: 'Invalid confidence fixture.' }));
  assert.throws(() => validateArnoldChapterReview(invalid, input, manifest.chapters[0]), /Invalid confidence/);
  invalid.reviews[0].alignmentFingerprint = 'stale';
  assert.throws(() => validateArnoldChapterReview(invalid, input, manifest.chapters[0]), /Wrong reviewed alignment/);
  invalid.reviewerModel = 'another-model';
  assert.throws(() => validateArnoldChapterReview(invalid, input, manifest.chapters[0]), /requested Gemini model/);
});

test('review statistics retain flagged outcomes instead of turning them into approval', () => {
  const statistics = reviewStatistics([{ status: 'verified', confidence: .9 }, { status: 'needs-correction', confidence: .4 }, { status: 'uncertain', confidence: .5 }]);
  assert.deepEqual(statistics.counts, { verified: 1, 'needs-correction': 1, uncertain: 1 });
  assert.equal(statistics.confidence.minimum, .4);
  assert.equal(statistics.confidence.maximum, .9);
});

test('publishing a stale or incomplete first review is rejected', () => {
  const invalid = { reviewKind: 'independent-model-review', reviewerModel: 'google/gemini-3.8-flash', providerModel: 'openrouter/google/gemini-3.8-flash', transport: 'opencode', reviews: [], counts: { verified: 0, 'needs-correction': 0, uncertain: 0 } };
  assert.throws(() => attachArnoldFirstReview(translation.verses, invalid));
  const stale = { ...invalid, counts: { verified: 700, 'needs-correction': 0, uncertain: 0 }, reviews: translation.verses.map((verse) => ({ canonicalRef: verse.canonicalRef, alignmentFingerprint: 'stale', status: 'verified' })) };
  assert.throws(() => attachArnoldFirstReview(translation.verses, stale), /Stale first review/);
});

test('published first-review outcomes come from the exact Gemini review artifacts', { skip: !translation.firstReview }, async () => {
  const bundle = JSON.parse(await readFile(new URL('first-review.json', directory), 'utf8'));
  const execution = JSON.parse(await readFile(new URL('execution.json', directory), 'utf8'));
  const records = [];
  for (const entry of manifest.chapters) {
    const body = await readFile(new URL(entry.path, directory), 'utf8');
    assert.equal(sha256(body), entry.sha256);
    const reviewFile = `reviews/chapter-${String(entry.chapter).padStart(2, '0')}.json`;
    const raw = await readFile(new URL(reviewFile, directory), 'utf8');
    const review = JSON.parse(raw);
    const rows = validateArnoldChapterReview(review, JSON.parse(body), entry);
    for (const row of rows) {
      const published = bundle.reviews.find((record) => record.canonicalRef === row.canonicalRef);
      const { evidence, ...judgment } = published;
      assert.deepEqual(judgment, row);
      assert.equal(evidence.reviewFileSha256, sha256(raw));
      const task = execution.rounds.find((round) => round.taskId === evidence.taskId);
      assert.equal(task.status, 'completed');
      assert.equal(task.providerInstanceId, 'opencode');
      assert.equal(task.model, 'openrouter/google/gemini-3.8-flash');
      const verse = translation.verses.find((record) => record.canonicalRef === row.canonicalRef);
      assert.equal(verse.firstReview.status, row.status);
      assert.equal(verse.firstReview.confidence, row.confidence);
      assert.equal(verse.firstReview.alignmentFingerprint, arnoldAlignmentFingerprint(verse));
    }
    records.push(...rows);
  }
  assert.equal(records.length, 700);
  assert.deepEqual(bundle.counts, reviewStatistics(records).counts);
  const exported = JSON.parse(await readFile(new URL(`../public/data/${translation.corpusVersion}/first-review.json`, import.meta.url), 'utf8'));
  assert.deepEqual(exported, bundle);
});
