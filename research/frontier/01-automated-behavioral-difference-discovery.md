# F01 — Automated behavioral-difference discovery

Verdict: **GO**

Buildout: medium · Evidence yield: very high · New expert data: small held-out validation set

## Decision summary

Adapt BehaviorBox-style discovery to find coherent conditions under which two model families behave differently. The unit is not a pretty answer or average score; it is a reproducible behavioral phenotype such as “adds an unsupported universal claim when commentary is absent” or “changes stance under alternate translation.”

## Research question and hypotheses

- **H1:** automated discovery identifies passage/context features with model-pair effect differences that replicate on held-out canonical passages.
- **H0:** discovered slices fail to replicate beyond exploration; that null is publishable evidence against broad model-difference claims.
- Primary outcome: held-out absolute difference in a prespecified claim phenotype between a model pair, with interval estimates.

## Inputs needed

Existing: 700 shared passages, multiple aligned textual views, metadata, V4's four model families, versioned contexts, and source provenance.

New:

- controlled contrast items: alternate translations, commentary present/absent, evidence ablations, position changes, and harmless distractors;
- atomic behavioral outcomes that can be annotated without deciding theological truth;
- a small blinded expert validation set.

The original BehaviorBox uses performance-aware language-model signals. Closed APIs may not expose comparable likelihoods, so the minimum-build adaptation uses repeated claim-presence/stance outcomes. A direct algorithmic replication requires open models.

## Scientific and statistical setup

1. Split canonical passages into discovery, development, and untouched confirmation chapters.
2. Predefine behavioral phenotypes: claim inclusion, unsupported generalization, abstention, evidence use, stance change, and uncertainty expression.
3. Generate contrast variants deterministically and label every synthetic modification as non-source material.
4. Collect repeated outputs per model/version/variant. Preserve all failures.
5. Embed item features and search the discovery set for coherent slices with heterogeneous model-pair effects.
6. Freeze slice descriptions and thresholds before applying them to confirmation data.
7. Fit hierarchical logistic/ordinal models with passage random effects and fixed model, intervention, and interaction terms. Control the false-discovery rate across exploratory slices; confirmation tests use a small prespecified family.
8. Blind human reviewers to model and discovered slice. Require both behavioral replication and coherent human interpretation of the slice.

## Nature of the experiment

Automated behavioral evaluation and heterogeneous-treatment-effect discovery. It produces hypotheses about where models differ and then tests them out of sample.

## Outputs

- OpenArtha contrast-set dataset and frozen behavioral schema.
- Pairwise model “difference cards” with replicated effects and uncertainty.
- Paper: **“Automated discovery of interpretive behavior differences in aligned multi-witness texts.”**
- Blog series showing one replicated difference and one failed discovery.
- Reusable canary prompts for model-version monitoring.

## OpenArtha fit

Fit is excellent: shared canonical units and many source views support controlled contrasts, while stable provenance makes every condition reconstructable. Seven hundred passages are sufficient for grouped exploration and confirmation if item generation is bounded.

Gaps: no behavioral claim labels, pending alignment review, and closed-model likelihood limitations. A small reviewed subset and black-box outcome definition make a pilot feasible.

## Minimum-build route

Reuse B01 splits and one model runner. Start with 24 reviewed passages, four contrast variants, four models, and three repeats. Analyze a small fixed phenotype list before attempting automated natural-language slice descriptions.

## Stop conditions

Stop if slices do not replicate, model effects are smaller than repeat variance, features encode chapter/length artifacts, or findings depend on one LLM judge.

## Final verdict

**GO.** Highest publication leverage among current ideas, provided exploration and held-out confirmation are strictly separated and V4 spend is separately approved.

## Method sources

- [BehaviorBox (2506.02204)](https://paperswithcode.co/paper/2506.02204)
- [BehaviorBox code](https://github.com/lindiatjuatja/behaviorbox)
- [Behavioral Fingerprinting of LLMs](https://paperswithcode.co/paper/2509.04504)

