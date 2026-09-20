# F02 — Interpretation test-time scaling

Verdict: **GO**

Buildout: small–medium · Evidence yield: very high · New expert data: small validation set

## Decision summary

Measure how interpretations change when inference uses more context tokens, more parallel samples, or more revision turns. “More thinking” is not assumed to improve anything: the experiment separately measures evidence use, stability, diversity, faithfulness, length, and cost.

## Research question and hypotheses

- **H1:** scaling curves differ materially across model families and outcomes; more compute may improve support while reducing or increasing viewpoint diversity.
- **H2:** length-normalized gains are smaller than raw judge-preference gains, revealing verbosity confounding.
- Primary outcome: within-model change in expert-verified evidence-supported claim rate from the minimal to scaled regime.

## Inputs needed

Existing: passage/chapter/full-work V4 contexts, four model families, stable text packets, and provenance.

New: controlled inference regimes and a reviewed outcome set. Use three axes where supported:

- context scaling: passage → chapter → complete work;
- batch scaling: one sample → `N` independent samples with fixed aggregation;
- turn scaling: direct answer → one structured critique/revision turn.

Provider-specific hidden reasoning effort is not directly comparable. Analyze slopes within each model and use tokens/cost as observed exposure; do not claim equal “thought” across providers.

## Scientific and statistical setup

1. Preregister passages, regimes, token ceilings, aggregation, stopping, and cost ceiling.
2. Randomize call order to reduce temporal/provider-load confounding. Freeze exact model versions.
3. Use repeated runs and preserve all timeouts/refusals.
4. Extract atomic claims and review a stratified blind sample for support, omission, stance, and uncertainty.
5. Fit hierarchical models with fixed effects for scale axis, model, and interactions; random intercepts/slopes for passage where supported.
6. Report cost–quality Pareto curves, within-model effect sizes, bootstrap intervals, and multiplicity-corrected secondary outcomes.
7. Negative control: extra output-token allowance without an instruction to reconsider. Positive control: a constructed item where a supplied missing fact should change the answer.
8. Test whether effects remain after controlling for output length.

## Nature of the experiment

Inference-time scaling science for open-ended, evidence-conditioned interpretation rather than math accuracy.

## Outputs

- Scaling-curve dataset with cost and token receipts.
- Paper: **“Does more inference compute improve interpretation—or only confidence and length?”**
- Blog/visual: interactive cost versus evidence/diversity curves.
- Practical model-selection policy for later OpenArtha experiments.

## OpenArtha fit

Fit is strong because context sizes are naturally nested and the same passages can be repeated across regimes. The multi-witness corpus supports evidence and diversity outcomes unavailable in single-answer benchmarks.

Gaps: expert outcome labels, provider-incomparable reasoning controls, and API cost. These are manageable with within-model analysis and a small preregistered pilot.

## Minimum-build route

Add regime configuration to the shared runner. Use 24 reviewed passages, two regimes first, and three repeats. Reuse outputs for F01/F03/F05. No new UI or training.

## Stop conditions

Stop if model IDs are mutable, token/cost receipts are missing, revision prompts change the task definition, or apparent gains vanish after length control.

## Final verdict

**GO.** Low incremental engineering and high paper/blog leverage when run as part of the shared causal study; API spend remains gated.

## Method sources

- [s1: Simple Test-Time Scaling](https://paperswithcode.co/paper/2501.19393)
- [3D Test-Time Scaling](https://paperswithcode.co/paper/2511.15738)
- [Inference Scaling and Reasoning Faithfulness](https://paperswithcode.co/paper/2601.06423)

