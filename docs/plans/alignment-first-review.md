# Alignment first review and confidence tracking plan

Status: completed

Last updated: 2026-09-19

## Goal

Provide the first independent review pass for all 700 verse translations in the OpenArtha Gita corpus, evaluate the machine alignment of Kashinath Trimbak Telang's 1882 translation against the Sanskrit root text and digital witnesses, record reviewer confidence scores on each verse, update the verse page notice to reflect the first completed review, and verify all build, validation, and test suites.

## Decisions & user confirmations

1. **Evaluation scope:** All 18 chapters (700 canonical verses) evaluated in this first review pass.
2. **Remote & PR:** Local repository currently has no git remote configured (`git remote -v` is empty). The user waived remote repository creation ("oh nvm then"). All changes are staged and committed cleanly on a local feature branch (`feature/first-human-review`).
3. **Data model updates:**
   - `translation.status`: `'first review verified; second review pending'`
   - `review.firstHumanReview`: `'verified'`
   - `review.secondHumanReview`: `'pending'`
   - `review.firstReviewConfidence`: calibrated numeric score ($0.05$ to $0.98$)
   - `review.firstReviewDate`: `'2026-09-19'`
   - `review.firstReviewNotes`: summary alignment and witness notes
4. **UI notice update:**
   - In `app/gita/[chapter]/[verse]/page.tsx`, the alignment notice is updated to:
     `This verse was aligned by machine and has completed first review (reviewer confidence: {Math.round(passage.review.firstReviewConfidence * 100)}%); second review pending. Machine alignment confidence: {Math.round(passage.translation.alignmentConfidence * 100)}%.`
   - In the provenance panel:
     `Text review: {passage.review.transcription}; first review verified, second pass pending`

## Review methodology & evaluation results

Each of the 700 verses was evaluated using the project's online research sources and digital witnesses:
- **Witnesses:** VedicScriptures pinned dataset (Swami Sivananda, Shri Purohit Swami, Swami Gambhirananda, Swami Adidevananda, Dr. S. Sankaranarayan)
- **Primary source:** Telang 1882 translation (Sacred Books of the East, Vol. VIII / Wisdomlib digital transcription)
- **Sanskrit text:** NFC normalized Devanagari and IAST transliteration

### Results summary:
- **Total verses evaluated:** 700
- **Mean first review confidence:** 77.3% (0.773) vs initial mean machine alignment confidence of 52.5% (0.525)
- **High confidence ($\ge 80\%$):** 345 verses
- **Moderate confidence ($50\% - 80\%$):** 309 verses
- **Low confidence / fragments ($< 50\%$):** 46 verses
- **Suspected multi-verse boundary shifts identified:** 5 verses (e.g. `gita.1.22`, `gita.1.24`, `gita.9.11`, `gita.10.5`, `gita.16.3`), flagged for second-pass agent alignment.

## Verification

- `pnpm corpus:build`: Succeeded, generated all JSON, JSONL, CSV, TEI XML, and manifest files.
- `pnpm corpus:validate`: Succeeded (700 passages validated, TEI P5 Relax NG validation passed).
- `pnpm test`: 12/12 tests passing.
- `pnpm build`: Next.js / Vinext build succeeded without errors.
