import type { Commentary } from './commentaries';

export function commentaryReviewSummary(commentary: Commentary) {
  const shared = commentary.alignment && commentary.alignment.references.length > 1 ? `Shared rendering of ${commentary.alignment.references.map((ref) => ref.replace('gita.', '')).join('–')}. ` : '';
  if (commentary.firstReview) {
    const review = commentary.firstReview;
    const outcome = review.status === 'verified' ? 'verified' : review.status === 'needs-correction' ? 'flagged for correction' : 'uncertain';
    return `${shared}First model review ${outcome} (${review.reviewerModel} confidence: ${Math.round(review.confidence * 100)}%); second review pending.`;
  }
  if (commentary.alignment) {
    return `${shared}Aligned by ${commentary.alignment.review.reviewerModel}; independent review pending.`;
  }
  return 'Machine-validated alignment; human review pending.';
}
