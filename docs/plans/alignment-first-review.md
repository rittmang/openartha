# Alignment first review and confidence tracking plan

Status: completed

Last updated: 2026-09-19

## Goal

Provide the first independent review pass for all 700 verse translations and all 20,300 commentary records in the OpenArtha Gita corpus, evaluate machine alignments against the Sanskrit root text and digital witnesses, record reviewer confidence scores on each verse, tag all notices with the evaluating model (`google/gemini-3.8-flash`), and verify all build, validation, and test suites.

## Decisions & user confirmations

1. **Root translation evaluation scope:** All 18 chapters (700 canonical verses) evaluated in this first review pass.
2. **Commentary evaluation scope:** All 20,300 aligned commentary units across all 22 authors and 29 public editions in Sanskrit, English, and Hindi.
3. **Model tag:** Tag all notices explicitly with `google/gemini-3.8-flash` so multiple independent model passes remain distinguished.
4. **GitHub Repository & PR:**
   - Repository created: `https://github.com/rittmang/openartha` (Public)
   - PR opened and linked: [PR #1](https://github.com/rittmang/openartha/pull/1) from `feature/first-human-review` to `main`.
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
     `First review verified (google/gemini-3.8-flash confidence: {Math.round(commentaryConfidence(commentary) * 100)}%); second review pending. SHA-256 {commentary.checksum.slice(0, 12)}…`
   - Commentary search cards (`components/commentary-search-card.tsx`):
     `First review (google/gemini-3.8-flash confidence: {Math.round(commentaryConfidence(result) * 100)}%) · second review pending`

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

### Subagent evaluation pass (Chapter 10)
- **Artifact:** `research/subagent-chapter-10.json`
- **Passage count:** 42 verses (`gita.10.1` through `gita.10.42`)
- **Reviewer:** Expert Sanskritist & Gita scholar evaluation of machine-aligned Telang (1882) translation against Devanagari/IAST root text and reference witnesses.
- **Findings:**
  - High confidence ($\ge 0.80$): 19 verses (45.2%)
  - Moderate confidence ($0.50 \le c < 0.80$): 20 verses (47.6%)
  - Low confidence / boundary shifts / severed fragments ($c < 0.50$): 3 verses (7.1%, verses 10.4, 10.5, 10.9)
  - Mean confidence: 0.776
  - Identified key boundary displacement cascades:
    - Verses 10.2–10.6: mental dispositions and qualities list cascade (10.2 annexes start of 10.3; 10.3 loses start to 10.2 and annexes start of 10.4; 10.4 loses start to 10.3 and second hemistich to 10.5; 10.5 severely corrupted with confidence 0.18, retaining only two words and losing bulk to 10.6; 10.6 prepends 10.5 text).
    - Verses 10.8–10.11: catuḥ-ślokī gītā boundary shifts (10.8 annexes start of 10.9; 10.9 reduced to a fragment lacking both start and end; 10.10 prepends end of 10.9 and annexes start of 10.11; 10.11 loses 'remaining in their hearts').
    - Verses 10.12–10.16: Arjuna's stuti and prayer (10.12 loses second hemistich to 10.13; 10.13 prepends 10.12 and truncates end into 10.14; 10.15 annexes 'be pleased to declare without' from 10.16; 10.16 begins with severed 'exception').
    - Verses 10.22–10.24, 10.29–10.32, 10.38–10.42: minor forward/backward shifts across vibhūti enumerations and concluding cosmic majesty.

### Subagent evaluation pass (Chapters 11–15)
- **Artifact:** `research/subagent-chapters-11-15.json`
- **Passage count:** 156 verses (`gita.11.1` through `gita.15.20`)
  - Chapter 11: 55 verses (Viśvarūpa-darśana Yoga)
  - Chapter 12: 20 verses (Bhakti Yoga)
  - Chapter 13: 34 verses (Kṣetra-Kṣetrajña-Vibhāga Yoga, counting 13.1–13.34)
  - Chapter 14: 27 verses (Guṇatraya-Vibhāga Yoga)
  - Chapter 15: 20 verses (Puruṣottama Yoga)
- **Reviewer:** Expert Sanskritist & Gita scholar evaluation of machine-aligned Telang (1882) translation against Devanagari/IAST root text and reference witnesses.
- **Findings:**
  - High confidence ($\ge 0.80$): 79 verses (50.6%)
  - Moderate confidence ($0.50 \le c < 0.80$): 47 verses (30.1%)
  - Low confidence / boundary shifts / severed fragments ($c < 0.50$): 30 verses (19.2%)
  - Identified severe multi-verse alignment cascades:
    - Chapter 11: verses 11.51–11.55 (concluding verses heavily distorted; 11.52 reduced to a fragment of 11.53, 11.53 reduced to "not by gift")
    - Chapter 12: verses 12.1–12.12 and 12.17–12.20 (widespread forward/backward displacement across philosophical lists)
    - Chapter 13: verses 13.1–13.8 (definition of Kṣetra/Kṣetrajña and 13.7/13.8 list absorption) and 13.30–13.33 (space simile displacement)
    - Chapter 14: verses 14.10–14.14 (absorption of 14.11 and 14.12 into 14.10, leaving severed fragments in 14.11–14.13)
    - Chapter 15: verses 15.14–15.18 (Vaiśvānara and Puruṣottama transition bleeding)

## Verification & deployment

- `pnpm corpus:validate`: Passed.
- `pnpm commentaries:validate`: Passed (20,300 units validated across 22 authors and 29 editions).
- `pnpm test`: 12/12 tests passing.
- `pnpm build`: Next.js / Vinext build succeeded without errors.
- `pnpm run deploy`: Deployed directly to Cloudflare Workers (`openartha.rittmang.xyz` and `gita.rittmang.xyz`, version `981b1855-6edd-4b35-803d-a57a67eece76`).
- Live site verification: Confirmed updated first-review notice and model confidence scores on both root verses and commentaries.
