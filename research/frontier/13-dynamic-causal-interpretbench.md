# F13 — Dynamic causal InterpretBench

Verdict: **NOGO**

Buildout: extra large and ongoing · Evidence yield: potentially very high · New expert data: continuous governance and hidden-item review

## Decision summary

Create a living benchmark that generates fresh controlled interventions and tracks model × context × inference budget × lens × version interactions. This is the portfolio's destination, not its starting point. Freezing a benchmark before component constructs and labels are validated would permanently encode avoidable errors.

## Research question and hypotheses

After prerequisites:

- **H1:** dynamic held-out intervention families produce more stable and contamination-resistant estimates of model behavior than one static prompt set.
- **H2:** model rankings depend strongly on context, compute, version, and ambiguity; one aggregate leaderboard obscures those interactions.
- Primary outcome: out-of-time predictive stability and reproducibility of prespecified behavioral effects, not a single total score.

## Inputs needed

Existing eventually: B01 splits, F01 behavioral slices, F02 scaling regimes, F03/F04 interventions, F05 entanglement estimates, F06 disagreement model, and provenance infrastructure.

Missing now:

- validated component tasks and gold/uncertainty models;
- secure hidden item-generation and review process;
- expert governance, release cadence, and deprecation policy;
- model-output rights and long-term cost budget;
- contamination probes and out-of-time evaluation protocol.

## Scientific and statistical setup

1. Define separate subscales; never collapse citation, faithfulness, diversity, and evidence use without a justified measurement model.
2. Generate new item variants from held-out passages and intervention templates, then human-validate a sample before scoring.
3. Maintain sealed evaluation periods and publish only after model submissions are frozen.
4. Use hierarchical item-response or mixed-effects models for model, item family, context, compute, language, and version interactions.
5. Fit disagreement-aware reviewer models and publish posterior/interval uncertainty.
6. Measure test–retest, inter-version drift, ranking stability, and susceptibility to benchmark-specific tuning.
7. Maintain negative controls, canary items, duplicate detection, and retired contaminated sets.
8. Release raw-enough receipts for reproduction without exposing active hidden items.

## Nature of the project

Benchmark governance, dynamic evaluation, longitudinal model auditing, and causal measurement science.

## Outputs

- Versioned benchmark releases and evaluation server/package.
- Dataset/benchmark paper plus annual model-drift reports.
- Public model cards and interactive causal-effect explorer.
- Blog series: **“The leaderboard changes when the context, budget, and reviewer change.”**
- Reusable standards for other multi-witness primary-text corpora.

## OpenArtha fit

Long-term fit is excellent: stable canonical units, multiple witnesses, versions, provenance, and compact scale support fresh controlled items. Current readiness is insufficient because almost every benchmark construct still lacks confirmed labels and external review.

## Minimum-build route after prerequisites

Publish individual pilot datasets first. When at least three component tasks survive external review, combine them into a versioned offline benchmark before considering a service or leaderboard.

## Stop conditions

Do not launch a total-score leaderboard, reuse public development items as hidden tests, silently change source/model versions, or aggregate reviewer disagreement away.

## Final verdict

**NOGO.** Treat as the integration milestone after the high-leverage GO studies produce validated components.

## Method sources

- [STABLEVAL](https://paperswithcode.co/paper/2605.02122)
- [DyVal](https://paperswithcode.co/paper/2309.17167)
- [JADE: Expert-Grounded Dynamic Evaluation](https://paperswithcode.co/paper/2602.06486)
- [How Is ChatGPT's Behavior Changing over Time?](https://paperswithcode.co/paper/2307.09009)
