# B01 — ML-ready corpus and leakage-safe splits

Verdict: **GO**

Buildout: small · Evidence yield: high as infrastructure · New expert data: small audit only

## Decision summary

Create immutable experiment tables and passage-grouped splits before any modeling. This is not a glamorous paper by itself, but it has the best portfolio-wide leverage: it prevents the same verse, paraphrase, or edition artifact from appearing on both sides of an evaluation.

## Research question and hypotheses

Primary question: can every later experiment be reconstructed from versioned source records without passage or near-duplicate leakage?

- **H1:** naive record-level random splitting produces materially more cross-split semantic/identifier leakage than grouping by `canonicalRef`.
- **H0:** the leakage audit finds no meaningful difference; this is still useful evidence that the simpler split is safe for a named task.
- Primary outcome: proportion of test items with an exact or thresholded near-duplicate in training, reported by split strategy.

## Inputs needed

Existing inputs:

- `corpus/gita/gita.json` and its 700 canonical references;
- commentary source, author, rights, staging, and alignment reports;
- versioned JSONL/TEI exports, checksums, language, script, author, edition, and content-type fields.

New inputs:

- a short manually inspected set of candidate duplicates and normalization edge cases;
- task-specific grouping rules recorded in a manifest.

## Scientific and statistical setup

1. Freeze root/commentary versions, source commit, code commit, normalizers, and all input checksums.
2. Materialize passages, commentary units, editions, and passage–edition pairs without altering source bodies.
3. Compare naive record randomization, `canonicalRef` grouping, leave-one-chapter-out, and—where authorship is the target—leave-one-edition or cross-topic schemes.
4. Audit exact hashes, normalized hashes, character n-gram similarity, and multilingual-embedding neighbors across folds. Thresholds are chosen on an audit subset before final measurement.
5. Report leakage rates with passage-cluster bootstrap intervals. Use paired bootstrap differences because the same records enter each split strategy.
6. Publish the split manifest before downstream confirmatory analyses. No fold may be changed because a result is inconvenient.

Positive control: deliberately duplicate a small set across folds and verify detection. Negative control: distinct passages sharing common formulaic language should not all be marked duplicates.

## Nature of the project

This is a data-methods and reproducibility project: deterministic builders, validation reports, dataset cards, and reusable split manifests. It does not train a substantive model.

## Outputs

- Versioned Parquet/JSONL research views and machine-readable split manifests.
- A leakage audit with tables and confidence intervals.
- Technical note: **“Why passage-aligned corpora leak under ordinary train/test splits.”**
- Blog: **“The same verse was in the exam and the textbook.”**
- A methods section and artifact appendix reusable in every later paper.

## OpenArtha fit

Fit is excellent. Stable canonical references, versions, source locators, metadata, and checksums are exactly the infrastructure needed. The many records attached to the same passage also make leakage a real, measurable threat.

What is lacking: verified duplicate labels and final human review. Both are manageable for a small audit; the split builder can carry review status so uncertain material never silently becomes gold.

## Minimum-build route

Add one offline exporter, one split-manifest schema, and one audit script. No API changes, vector database, model calls, or UI are required. Estimated effort: one to three focused engineering days plus a small manual audit.

## Stop conditions

Stop downstream modeling if a split cannot be reproduced from its manifest, if `canonicalRef` crosses a protected fold, or if normalization collapses materially different records.

## Final verdict

**GO.** Build first. Its direct publication value is moderate, but it is the cheapest way to increase the validity of all 24 other projects.

## Method sources

- [Datasheets for Datasets](https://paperswithcode.co/paper/1803.09010)
- [Data Contamination task map](https://paperswithcode.co/task/data-contamination)

