import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';

export const reviewModel = 'google/gemini-3.8-flash';
export const reviewProviderModel = 'openrouter/google/gemini-3.8-flash';
export const sha256 = (value) => createHash('sha256').update(value).digest('hex');

export function arnoldAlignmentProposal(verse) {
  return { canonicalRef: verse.canonicalRef, content: verse.content, relation: verse.alignment.relation, references: verse.alignment.references, sourceSpans: verse.alignment.sourceSpans, note: verse.alignment.note };
}

export function arnoldAlignmentFingerprint(verse) {
  return sha256(JSON.stringify(arnoldAlignmentProposal(verse)));
}

export function validateArnoldChapterReview(review, input, entry) {
  assert.equal(review.schemaVersion, 1);
  assert.equal(review.reviewerModel, reviewModel, 'Reviewer must be the requested Gemini model');
  assert.equal(review.providerModel, reviewProviderModel);
  assert.equal(review.transport, 'opencode');
  assert.equal(review.reviewedCommit, input.reviewedCommit);
  assert.equal(review.sourceSha256, input.sourceSha256);
  assert.equal(review.chapter, input.chapter);
  assert.equal(review.inputSha256, entry.sha256, 'Review must bind the exact supplied input file');
  assert.ok(Array.isArray(review.reviews));
  assert.ok(Array.isArray(review.chapterFindings) && review.chapterFindings.every((finding) => typeof finding === 'string'), 'Chapter findings must be preserved');
  assert.deepEqual(review.reviews.map((record) => record.canonicalRef), input.records.map((record) => record.canonicalRef), 'Every chapter reference must be reviewed exactly once in order');
  for (const [index, record] of review.reviews.entries()) {
    assert.equal(record.alignmentFingerprint, input.records[index].alignmentFingerprint, `Wrong reviewed alignment for ${record.canonicalRef}`);
    assert.ok(['verified', 'needs-correction', 'uncertain'].includes(record.status), `Invalid status for ${record.canonicalRef}`);
    assert.ok(Number.isFinite(record.confidence) && record.confidence >= 0 && record.confidence <= 1, `Invalid confidence for ${record.canonicalRef}`);
    assert.ok(typeof record.notes === 'string' && record.notes.trim(), `Missing semantic evidence for ${record.canonicalRef}`);
    if (record.status === 'needs-correction') {
      assert.ok(record.suggestedCorrection?.sourceBoundarySuggestion && record.suggestedCorrection?.reason, `Missing actionable correction for ${record.canonicalRef}`);
      assert.ok(Array.isArray(record.suggestedCorrection.affectedRefs) && record.suggestedCorrection.affectedRefs.includes(record.canonicalRef), `Missing affected reference for ${record.canonicalRef}`);
    }
  }
  return review.reviews;
}

export function reviewStatistics(records) {
  const counts = { verified: 0, 'needs-correction': 0, uncertain: 0 };
  for (const record of records) counts[record.status]++;
  return {
    reviewed: records.length,
    counts,
    confidence: {
      mean: records.reduce((sum, record) => sum + record.confidence, 0) / Math.max(records.length, 1),
      minimum: Math.min(...records.map((record) => record.confidence)),
      maximum: Math.max(...records.map((record) => record.confidence)),
      interpretation: 'Reviewer self-assessment of alignment confidence; not a statistically calibrated probability',
    },
  };
}

export function attachArnoldFirstReview(verses, bundle) {
  assert.equal(bundle.reviewKind, 'independent-model-review');
  assert.equal(bundle.reviewerModel, reviewModel);
  assert.equal(bundle.providerModel, reviewProviderModel);
  assert.equal(bundle.transport, 'opencode');
  assert.equal(bundle.reviews.length, verses.length);
  assert.deepEqual(bundle.counts, reviewStatistics(bundle.reviews).counts, 'Review totals must match the actual outcomes');
  const byReference = new Map(bundle.reviews.map((review) => [review.canonicalRef, review]));
  assert.equal(byReference.size, verses.length, 'Review references must be unique and complete');
  return verses.map((verse) => {
    const review = byReference.get(verse.canonicalRef);
    assert.ok(review, `Missing first review for ${verse.canonicalRef}`);
    assert.equal(review.alignmentFingerprint, arnoldAlignmentFingerprint(verse), `Stale first review for ${verse.canonicalRef}`);
    assert.ok(review.evidence?.taskId && review.evidence?.reviewFileSha256, 'Missing real reviewer evidence');
    assert.ok(['verified', 'needs-correction', 'uncertain'].includes(review.status));
    assert.ok(Number.isFinite(review.confidence) && review.confidence >= 0 && review.confidence <= 1);
    assert.ok(typeof review.notes === 'string' && review.notes.trim());
    const firstReview = {
      reviewKind: bundle.reviewKind,
      reviewerModel: bundle.reviewerModel,
      providerModel: bundle.providerModel,
      transport: bundle.transport,
      reviewedAt: bundle.reviewedAt,
      reviewedCommit: bundle.reviewedCommit,
      status: review.status,
      confidence: review.confidence,
      notes: review.notes,
      alignmentFingerprint: review.alignmentFingerprint,
      evidence: review.evidence,
      secondReview: 'pending',
    };
    return { ...verse, alignmentStatus: `first model review ${review.status} (${bundle.reviewerModel}); second review pending`, firstReview };
  });
}
