# Arnold independent first review

The user requested Gemini 3.8 Flash through OpenCode to review all 700 canonical verse alignments of Edwin Arnold's *The Song Celestial* (Project Gutenberg #2388).

Completed: all 700 canonical alignments across 18 chapters were verified; no correction or uncertain outcomes were reported. This includes the 16 source omissions and four shared two-verse ranges. Mean self-assessed alignment confidence was 97.79%, ranging from 90% to 100%. The second review remains pending.

- Requested model: `google/gemini-3.8-flash`.
- Configured OpenCode model: `openrouter/google/gemini-3.8-flash`.
- Execution: T3-owned OpenCode review tasks, recorded in `execution.json` with actual task IDs, model, provider, chapter assignments, and terminal outcomes.
- `review-brief.md` preserves the complete review instructions.
- `input-manifest.json` pins the reviewed implementation commit, source SHA-256, input hashes, and all 18 chapter inputs.
- `inputs/` contains the exact supplied source chapters, Sanskrit/IAST, proposed source spans, and comparison witnesses. Arnold's text retains its Gutenberg public-domain status in the USA; the comparison witnesses retain the GPL-3.0 terms and attribution of `public/data/gita-commentaries-0.2.0/`.
- `reviews/` contains the raw Gemini chapter judgments. Parent code validates every reference, input hash, alignment fingerprint, outcome, confidence, and supporting note before attaching anything to the public corpus.
- `first-review.json` is assembled only after all actual delegated tasks complete and all 700 records validate. It records findings, not an automatic blanket approval.

Confidence values are the review model's self-assessments of the alignment, not statistically calibrated probabilities. A model review is distinct from a human review, and does not satisfy or waive the project's human release gate.

```sh
# One-time input preparation; refuses to overwrite an existing pinned manifest.
pnpm exec node scripts/prepare-arnold-review.mjs
# Run the requested OpenCode review tasks against these pinned inputs.
pnpm exec node scripts/validate-arnold-review.mjs --assemble
pnpm translations:build
```

Do not regenerate input files while their reviews are running. Corrections require new pinned inputs and a fresh review round; retain the earlier inputs and findings as audit evidence. Do not silently attach a stale review to changed text.
