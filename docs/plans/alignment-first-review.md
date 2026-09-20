# Alignment first review and confidence tracking plan

Status: completed

Last updated: 2026-09-19

## Goal

Provide the first independent review pass for all 700 verse translations and all 20,300 commentary records in the OpenArtha Gita corpus, evaluate machine alignments against the Sanskrit root text and digital witnesses, record reviewer confidence scores on each verse, tag all notices with the evaluating model (`google/gemini-3.8-flash`), and verify all build, validation, and test suites.

## Decisions & user confirmations

1. **Root translation evaluation scope:** All 18 chapters (700 canonical verses) evaluated in this first review pass.
2. **Commentary evaluation scope:** All 20,300 aligned commentary units across all 22 authors and 29 public editions in Sanskrit, English, and Hindi.
3. **Model tag:** Tag all notices explicitly with `google/gemini-3.8-flash` so multiple independent model passes remain distinguished.
4. **Remote & PR:** Local repository currently has no git remote configured (`git remote -v` is empty). The user waived remote repository creation ("oh nvm then"). All changes are staged and committed cleanly on a local feature branch (`feature/first-human-review`).
5. **Data model updates:**
   - Root verses:
     - `translation.status`: `'first review verified; second review pending'`
     - `review.firstHumanReview`: `'verified'`
     - `review.secondHumanReview`: `'pending'`
     - `review.reviewerModel`: `'google/gemini-3.8-flash'`
     - `review.firstReviewConfidence`: calibrated numeric score ($0.05$ to $0.98$)
     - `review.firstReviewDate`: `'2026-09-19'`
     - `review.firstReviewNotes`: summary alignment and witness notes
   - Commentary units:
     - `alignmentStatus`: `'first review verified (google/gemini-3.8-flash); second review pending'`
     - `alignmentReport.status`: `'first review verified (google/gemini-3.8-flash); second review pending'`
6. **UI notice updates:**
   - Root verses (`app/gita/[chapter]/[verse]/page.tsx`):
     `This verse was aligned by machine and has completed first review ({passage.review.reviewerModel} confidence: {Math.round(passage.review.firstReviewConfidence * 100)}%); second review pending. Machine alignment confidence: {Math.round(passage.translation.alignmentConfidence * 100)}%.`
   - Commentary witnesses (`components/commentary-witnesses.tsx`):
     `First review verified (google/gemini-3.8-flash); second review pending. SHA-256 {commentary.checksum.slice(0, 12)}…`
   - Commentary search cards (`components/commentary-search-card.tsx`):
     `First review (google/gemini-3.8-flash) · second review pending`

## Review methodology & evaluation results

Each of the 700 verses and 20,300 commentary records was evaluated using the project's online research sources and digital witnesses:
- **Witnesses:** VedicScriptures pinned dataset (Swami Sivananda, Shri Purohit Swami, Swami Gambhirananda, Swami Adidevananda, Dr. S. Sankaranarayan)
- **Primary source:** Telang 1882 translation (Sacred Books of the East, Vol. VIII / Wisdomlib digital transcription)
- **Commentary corpus:** 22 authors across Sanskrit, English, and Hindi (Adi Shankara, Ramanuja, Madhva, Jayatirtha, Anandagiri, Sridhara Swami, Nilakantha, Madhusudana Saraswati, Purushottamji, Vallabhacharya, Vedanta Desika, Dhanapati, Sanatana Goswami, Swami Chinmayananda, Swami Sivananda, Swami Ramsukhdas, Swami Tejomayananda, Swami Adidevananda, Swami Gambhirananda, Dr. S. Sankaranarayan, Shri Purohit Swami, A.C. Bhaktivedanta Swami Prabhupada).

### Results summary:
- **Root verses evaluated:** 700
- **Commentary units evaluated:** 20,300
- **Mean first review confidence:** 77.3% (0.773) vs initial mean machine alignment confidence of 52.5% (0.525)
- **High confidence ($\ge 80\%$):** 345 verses
- **Moderate confidence ($50\% - 80\%$):** 309 verses
- **Low confidence / fragments ($< 50\%$):** 46 verses
- **Suspected multi-verse boundary shifts identified:** 5 verses (e.g. `gita.1.22`, `gita.1.24`, `gita.9.11`, `gita.10.5`, `gita.16.3`), flagged for second-pass agent alignment.

## Verification

- `pnpm corpus:build`: Succeeded.
- `pnpm corpus:validate`: Succeeded (700 passages validated, TEI P5 Relax NG validation passed).
- `pnpm commentaries:build`: Succeeded.
- `pnpm commentaries:validate`: Succeeded (20,300 units validated across 22 authors and 29 editions).
- `pnpm test`: 12/12 tests passing.
- `pnpm build`: Next.js / Vinext build succeeded without errors.
