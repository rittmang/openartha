# B10 — Comparative synthesis engine

Verdict: **NOGO**

Buildout: large · Evidence yield: potentially very high · New expert data: claim/evidence tables

## Decision summary

Produce a source-preserving synthesis of several interpretations through an intermediate claim table. OpenArtha has the raw witnesses, but it lacks reviewed atomic claims and relations. Directly summarizing 29 witnesses now would generate attractive prose without defensible coverage or attribution.

## Research question and hypotheses

After prerequisites:

- **H1:** an evidence-first claim-table pipeline reduces unsupported or misattributed claims relative to direct long-context summarization.
- **H2:** explicitly modelling `compatible difference`, `conflict`, and `not comparable` improves expert-rated perspective preservation.
- Primary outcome: proportion of synthesis claims fully supported and correctly attributed. Secondary: source coverage, distinction preservation, factual consistency, and reviewer preference.

## Inputs needed

Existing: 29 aligned fields, stable passage coordinates, source metadata, three languages, checksums, and compact exports.

Missing:

- reviewed alignments for sampled witnesses;
- atomic source claims with exact evidence spans;
- claim equivalence/conflict labels;
- reference syntheses or structured coverage targets;
- expert reviewers able to assess neutrality and omitted distinctions.

## Scientific and statistical setup

1. Limit each item to one bounded question, passage range, and selected reviewed witnesses.
2. Manually construct confirmation claim/evidence tables before evaluating systems.
3. Compare direct summarization, retrieve-then-summarize, extractive claim clustering, and evidence-first programmatic synthesis.
4. Randomize and blind outputs. Review each atomic output claim for support, attribution, scope, negation, and witness coverage.
5. Analyze claim correctness with a hierarchical logistic model including item, reviewer, and source-count effects. Use paired item bootstrap intervals for system differences.
6. Stress test with contradictory, redundant, irrelevant, and minority-witness packets. Measure whether source order changes conclusions.
7. Treat prose preference as secondary; the primary endpoint is claim-level evidence integrity.

## Nature of the project

Multi-document, multi-perspective generation with structured provenance. The research object is the intermediate claim graph and its effect on errors.

## Outputs

- `OA-Synthesis` claim/evidence benchmark.
- Comparative system paper with fully auditable examples.
- Reader-facing synthesis prototype after validation.
- Blog: **“A moderator should not make every witness sound the same.”**

## OpenArtha fit

The aligned multi-witness structure is unusually suitable and potentially publishable. The current data quality is not sufficient: records are aligned but not claim-segmented or philosophically reviewed. Frequency across 29 fields cannot substitute for coverage truth.

## Minimum-build route after prerequisites

Select 10–20 reviewed passages, 4–6 witnesses per item, and manually build 50 claim tables. Evaluate direct versus table-first synthesis before any general system or UI.

## Stop conditions

Do not start generation if source claims and relations cannot be annotated reliably. Stop if the table-first system does not improve attribution/coverage over a simpler extractive baseline.

## Final verdict

**NOGO.** High eventual value, but B08/B09-style claim and evidence annotations must exist first.

## Method sources

- [Multi-Document Summarization](https://paperswithcode.co/task/multi-document-summarization)
- [QAFactEval](https://paperswithcode.co/paper/qafacteval-improved-qa-based-factual)
- [GenerationPrograms](https://paperswithcode.co/paper/2506.14580)

