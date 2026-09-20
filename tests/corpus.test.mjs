import test from 'node:test';
import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';

const corpus = JSON.parse(await readFile(new URL('../corpus/gita/gita.json', import.meta.url), 'utf8'));

test('publishes the standard 700-passage structure', () => {
  assert.equal(corpus.verses.length, 700);
  assert.deepEqual(corpus.chapterCounts, [47, 72, 43, 42, 29, 47, 30, 28, 34, 42, 55, 20, 34, 27, 20, 24, 28, 78]);
  assert.equal(new Set(corpus.verses.map((verse) => verse.canonicalRef)).size, 700);
});

test('preserves the chapter 13 recensional prelude without creating passage 701', () => {
  const first = corpus.verses.find((verse) => verse.canonicalRef === 'gita.13.1');
  assert.equal(corpus.verses.filter((verse) => verse.chapter === 13).length, 34);
  assert.equal(first.variants[0].type, 'recensional-prelude');
  assert.match(first.variants[0].note, /701 verses/);
});

test('checksums bind the public passage payload', () => {
  for (const passage of [corpus.verses[0], corpus.verses[346], corpus.verses.at(-1)]) {
    const value = JSON.stringify({ canonicalRef: passage.canonicalRef, representations: passage.representations, variants: passage.variants, provenance: passage.provenance });
    assert.equal(passage.checksum, createHash('sha256').update(value).digest('hex'));
  }
});

test('records first review as verified while gating final release on second review', () => {
  assert.equal(corpus.releaseEligible, false);
  assert.ok(corpus.verses.every((verse) => !verse.review.releaseEligible));
  assert.ok(corpus.verses.every((verse) => verse.review.firstHumanReview === 'verified' && verse.review.secondHumanReview === 'pending'));
  assert.ok(corpus.verses.every((verse) => verse.review.reviewerModel === 'google/gemini-3.8-flash'));
  assert.ok(corpus.verses.every((verse) => typeof verse.review.firstReviewConfidence === 'number' && verse.review.firstReviewConfidence > 0));
});
