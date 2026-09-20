# B02 — Commentary fingerprint and leakage audit

Verdict: **GO**

Buildout: small · Evidence yield: medium–high · New expert data: none for the first audit

## Decision summary

Predict an edition from a commentary excerpt, not to prove authorial essence, but to discover whether formatting, boilerplate, translation conventions, or stable stylistic signals leak through the corpus. This is the quickest defensible empirical study because labels already exist and no paid model calls are needed.

## Research question and hypotheses

- **H1:** edition attribution remains above a character n-gram baseline's permutation null when entire chapters are held out.
- **Diagnostic hypothesis:** performance will fall substantially after removing headers, verse numbers, names, and repeated boilerplate; the decrease estimates artifact leakage.
- Primary outcome: macro-F1 for `editionId` on held-out chapters, with character n-gram logistic regression fixed as the primary model.

The study does not claim to identify philosophical schools. It measures discriminative surface patterns associated with registered editions.

## Inputs needed

Existing: commentary text, edition/author IDs, language, content type, canonical reference, chapter, and review status.

New: deterministic text-cleaning variants and a manual review of the strongest model features. Author-level analysis waits until authorship/edition identity is verified.

## Scientific and statistical setup

1. Run separate experiments by language and content type; do not let language itself solve the task.
2. Group folds by chapter or canonical passage. Compare record-random splits only as a documented leakage demonstration.
3. Predefine baselines: majority class, character n-gram TF-IDF plus logistic regression, word n-grams, and frozen multilingual embeddings plus a linear head.
4. Run ablations removing metadata-like text, punctuation, proper names, verse numbers, and repeated phrases.
5. Report macro-F1, balanced accuracy, per-edition recall, and calibration. Compute chapter-cluster bootstrap intervals and paired intervals for ablation differences.
6. Run label permutation as a negative control. Test a positive control containing the edition label to prove that the pipeline detects intentional leakage.
7. Have reviewers inspect the top positive/negative features without seeing the performance narrative first; record whether each feature is style, content, boilerplate, transcription, or unknown.

## Nature of the project

This is a supervised classification and corpus-forensics experiment. The valuable result may be that a high score disappears after leakage controls.

## Outputs

- Reproducible classification baselines and feature reports.
- Corpus-cleaning issues suitable for pull requests or editorial tickets.
- Short paper: **“Topic-controlled edition attribution in a passage-aligned multilingual commentary corpus.”**
- Blog: **“Can a tiny model recognize a commentator—or only their punctuation?”**

Every published claim should include the held-out unit, confidence interval, class support, and ablation result.

## OpenArtha fit

Fit is strong: 20,300 records, 29 fields, stable edition labels, three languages, and shared passage coordinates create a rare controlled stylometry setting. The shared verses let the design partially hold topic constant.

Gaps: class balance varies; some “author” labels may combine editorial or translation effects; alignments and attribution await human review. The first study should therefore target edition IDs and present authorship only as exploratory.

## Minimum-build route

Use the B01 tables and scikit-learn-style linear baselines. No fine-tuning or app integration. Estimated effort: two to four days, including feature review.

## Stop conditions

Do not claim style if performance collapses under chapter holdout, if a few artifacts explain the score, or if an edition has too little support for stable estimates.

## Final verdict

**GO.** This is the best zero-API starting study and can produce a credible audit even if the headline model result is negative.

## Method sources

- [Authorship Attribution](https://paperswithcode.co/task/authorship-attribution)
- [Authorship Verification](https://paperswithcode.co/task/authorship-verification)

