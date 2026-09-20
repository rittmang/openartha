# F06 — Disagreement-aware human evaluation

Verdict: **NOGO**

Buildout: medium · Evidence yield: very high · New expert data: multiple independent ratings per item

## Decision summary

Replace majority-vote labels with a probabilistic model of item ambiguity and reviewer-specific confusion. The method is especially appropriate for interpretation, but it cannot run honestly until multiple qualified reviewers produce overlapping judgments.

## Research question and hypotheses

After reviewer recruitment:

- **H1:** disagreement-aware aggregation produces model rankings that are more stable across reviewer subsamples than majority vote.
- **H2:** ambiguity concentrates in identifiable item/relation types rather than behaving as uniform noise.
- Primary outcome: ranking stability/error under preregistered reviewer resampling, not agreement maximization.

## Inputs needed

Existing: passages, witnesses, source metadata, candidate model outputs, and claim relation schemes from F01/B08.

Missing:

- at least three independent qualified ratings for a meaningful overlapping item set;
- reviewer training/calibration items;
- an annotation policy that preserves `unclear/not comparable`;
- consented metadata sufficient to interpret expertise effects without inferring demographics.

## Scientific and statistical setup

1. Predefine items, rubrics, reviewer eligibility, training, compensation, exclusions, and primary stability metric.
2. Randomize and blind model/author identity where possible. Every core item receives overlapping ratings.
3. Preserve individual ratings; do not adjudicate them away before fitting the model.
4. Compare majority vote, simple mean/ordinal aggregation, Dawid–Skene-style hard-label recovery, and STABLEVAL-style posterior credit/confusion models.
5. Evaluate through held-out ratings, posterior predictive checks, ranking stability across reviewer subsets, and calibration on clear controls.
6. Use hierarchical models for reviewer and item effects. Report posterior intervals and sensitivity to priors explicitly.
7. Negative control: random reviewer identities. Positive controls: unambiguous support/non-support examples.

## Nature of the experiment

Measurement science and probabilistic human evaluation. It studies ambiguity and annotator behavior rather than treating disagreement as annotation failure.

## Outputs

- Reusable disagreement-aware evaluation package and anonymized rating matrix where consent/rights allow.
- Paper: **“Stable evaluation of plural interpretations under expert disagreement.”**
- Blog: **“Why majority vote can erase the most interesting part of interpretation.”**
- Better uncertainty estimates for every model-comparison project.

## OpenArtha fit

Conceptual fit is excellent: interpretation naturally permits ambiguity and multiple legitimate readings. Current operational fit is poor because no qualified reviewer panel or overlapping ratings exist.

## Minimum-build route after prerequisites

Recruit at least three reviewers for 200–300 overlapping claim pairs or model outputs, including control items. Fit existing probabilistic models before inventing a new one.

## Stop conditions

Do not infer reviewer reliability from sparse non-overlapping labels, conceal priors, or describe disagreement as error without evidence.

## Final verdict

**NOGO.** Begin only after a real overlapping expert-rating design and reviewer governance are funded.

## Method sources

- [STABLEVAL](https://paperswithcode.co/paper/2605.02122)
- [A Roadmap to Pluralistic Alignment](https://paperswithcode.co/paper/2402.05070)

