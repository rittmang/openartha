# F04 — Counterfactual reasoning-faithfulness audit

Verdict: **GO**

Buildout: medium · Evidence yield: very high · New expert data: counterfactual validation

## Decision summary

Test whether a model's stated interpretation rationale is causally connected to its conclusion. The project never assumes visible reasoning is the model's internal computation; it measures stance consistency and output-level causal influence under controlled counterfactual interventions.

## Research question and hypotheses

- **H1:** a nontrivial fraction of interpretations contain rationales whose stance is inconsistent with the final claim or whose controlled replacement fails to influence it.
- **H2:** faithfulness varies by model, inference regime, and whether evidence conflicts with model priors.
- Primary outcome: proportion of outputs satisfying both preregistered stance-consistency and causal-influence criteria.

## Inputs needed

Existing: canonical passages, multiple translations/commentaries, controlled model/context configurations, and provenance.

New:

- bounded prompts requiring a claim plus concise evidence-linked rationale;
- expert-validated counterfactual rationale/evidence interventions;
- labels for stance consistency, expected direction of change, invalid counterfactual, and ambiguous case.

Counterfactuals are evaluation stimuli, never source corrections.

## Scientific and statistical setup

1. Define faithfulness separately from correctness: a wrong conclusion can follow its stated reasoning faithfully, while a correct answer can have an unfaithful rationale.
2. Sample only items where experts can specify a valid intervention and expected stance relation.
3. Generate original responses, then insert or substitute controlled rationale premises without revealing the expected outcome.
4. Score stance consistency through a frozen rubric and blind double review on a stratified sample.
5. Estimate causal influence as the change in conclusion/claim probability or repeated claim frequency under intervention.
6. Fit hierarchical logistic models with passage and reviewer effects; report model/regime interactions and uncertainty.
7. Negative control: paraphrase the rationale without changing meaning. Positive control: reverse a decisive premise in a synthetic item.
8. Correct secondary comparisons and report invalid-intervention rates.

## Nature of the experiment

Behavioral causal evaluation of reasoning-model explanations. It avoids requiring hidden chain-of-thought or internal activations.

## Outputs

- OpenArtha reasoning-faithfulness contrast set.
- Paper: **“Faithful interpretation under counterfactual source interventions.”**
- Blog: **“A convincing explanation may not be the reason the model answered.”**
- Model-specific faithfulness cards and reusable intervention templates.

## OpenArtha fit

Fit is good because aligned witnesses offer naturally competing premises and the source structure supports precise counterfactual packets. Interpretive openness also makes the distinction between correctness and faithfulness especially valuable.

Gaps: counterfactual validity requires expert review; many open-ended claims lack a single expected reversal; closed APIs expose no stable answer probability. Repeated categorical outcomes can support a bounded black-box pilot.

## Minimum-build route

Use 20–30 expert-selected claims with one valid paraphrase control and one premise intervention each. Reuse the F02 runner and claim schema. Do not request or store hidden chain-of-thought.

## Stop conditions

Stop if experts cannot agree that interventions preserve all non-target factors, if outcomes cannot be coded reliably, or if the analysis conflates correctness with faithfulness.

## Final verdict

**GO.** A small expert-curated pilot is feasible and research-current; scaling before intervention validity is established is NOGO.

## Method sources

- [RFEval](https://paperswithcode.co/paper/2602.17053)
- [Measuring Faithfulness in Chain-of-Thought Reasoning](https://paperswithcode.co/paper/2307.13702)
- [Inference Scaling and Reasoning Faithfulness](https://paperswithcode.co/paper/2601.06423)
