import assert from 'node:assert/strict';
import { readFile, writeFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { arnoldAlignmentFingerprint, reviewStatistics, sha256, validateArnoldChapterReview } from './lib/arnold-review.mjs';

const root = fileURLToPath(new URL('../', import.meta.url));
const directory = path.join(root, 'research/arnold-first-review');
const manifest = JSON.parse(await readFile(path.join(directory, 'input-manifest.json'), 'utf8'));
const execution = JSON.parse(await readFile(path.join(directory, 'execution.json'), 'utf8'));
const translation = JSON.parse(await readFile(path.join(root, 'corpus/gita-translations/edwin-arnold/translation.json'), 'utf8'));
const current = new Map(translation.verses.map((verse) => [verse.canonicalRef, verse]));
const reviews = [];
const chapterFindings = [];
for (const entry of manifest.chapters) {
  const body = await readFile(path.join(directory, entry.path), 'utf8');
  assert.equal(sha256(body), entry.sha256, `Changed input file: ${entry.path}`);
  const input = JSON.parse(body);
  const reviewFile = `reviews/chapter-${String(entry.chapter).padStart(2, '0')}.json`;
  const reviewBody = await readFile(path.join(directory, reviewFile), 'utf8');
  const review = JSON.parse(reviewBody);
  const task = execution.rounds.find((round) => round.round === 1 && round.chapters[0] <= entry.chapter && round.chapters[1] >= entry.chapter);
  assert.ok(task?.taskId && task.providerInstanceId === 'opencode' && task.model === manifest.providerModel, 'Missing actual OpenCode task provenance');
  const evidence = { inputSha256: entry.sha256, reviewFile, reviewFileSha256: sha256(reviewBody), taskId: task.taskId };
  for (const record of validateArnoldChapterReview(review, input, entry)) {
    assert.equal(record.alignmentFingerprint, arnoldAlignmentFingerprint(current.get(record.canonicalRef)), `Stale review for ${record.canonicalRef}`);
    reviews.push({ ...record, evidence });
  }
  chapterFindings.push({ chapter: entry.chapter, findings: review.chapterFindings, evidence });
}
assert.equal(reviews.length, 700);
assert.equal(new Set(reviews.map((record) => record.canonicalRef)).size, 700);
const statistics = reviewStatistics(reviews);
const result = {
  schemaVersion: 1,
  reviewKind: 'independent-model-review',
  reviewerModel: manifest.reviewerModel,
  providerModel: manifest.providerModel,
  transport: manifest.transport,
  sourceSha256: manifest.sourceSha256,
  reviewedCommit: manifest.reviewedCommit,
  reviewedAt: new Date().toISOString(),
  status: statistics.counts.verified === 700 ? 'verified' : 'completed-with-findings',
  ...statistics,
  chapterFindings,
  reviews,
};
if (process.argv.includes('--assemble')) {
  assert.ok(execution.rounds.filter((round) => round.round === 1).every((round) => round.status === 'completed'), 'All delegated review tasks must actually complete before assembling approval data');
  await writeFile(path.join(directory, 'first-review.json'), JSON.stringify(result, null, 2) + '\n');
}
console.log(JSON.stringify({ reviewerModel: result.reviewerModel, transport: result.transport, status: result.status, ...statistics }, null, 2));
