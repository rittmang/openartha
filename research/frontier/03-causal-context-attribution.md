# F03 — Causal context attribution

Verdict: **GO**

Buildout: medium · Evidence yield: very high · New expert data: evidence-span review

## Decision summary

Determine which supplied source spans actually influence a generated claim. This differs from citation generation: a model can attach a plausible citation after using its prior knowledge. Context ablation and retention interventions test necessity and sufficiency.

## Research question and hypotheses

- **H1:** evidence spans selected by causal ablation predict claim changes better than lexical similarity or post-hoc citation alone.
- **H2:** context influence differs by model family, evidence position, and witness type.
- Primary outcome: agreement between predicted influential spans and the change in a target claim under held-out ablation/retention interventions.

## Inputs needed

Existing: immutable source packets, canonical IDs, passage/commentary alignment, source locators, checksums, and nested contexts.

New:

- target atomic claims and candidate evidence spans;
- intervention packets that remove, retain, reposition, or replace spans;
- expert judgments about whether remaining context still supports the claim.

Only reviewed alignments should enter confirmatory analysis. Counterfactual packets must be stored outside the corpus namespace.

## Scientific and statistical setup

1. Predefine target claims and candidate spans on an exploratory subset without looking at confirmation outcomes.
2. For each item, generate original, leave-one-span-out, retain-only, repositioned, and irrelevant-control contexts.
3. Randomize calls and repeat them. Match output claims semantically, then manually validate a stratified subset.
4. Compare baselines: lexical overlap, embedding similarity, model-generated citations, leave-one-out effect, SelfCite-style necessity/sufficiency, and—on open models only—ARC-JSD/attention traceback.
5. Fit hierarchical models for claim persistence with intervention, model, position, and source type as effects and passage as a random effect.
6. Report average treatment effects, interval estimates, precision/recall of influential-span detection, and sensitivity to semantic-matching thresholds.
7. Negative control: remove an unrelated distractor. Positive control: remove the sole explicit support for a constructed target claim.

## Nature of the experiment

Causal black-box attribution, with an optional mechanistic extension on open weights. It tests source influence, not metaphysical truth.

## Outputs

- Context-intervention dataset and claim/span schema.
- Paper: **“Causal source attribution for interpretive generation.”**
- Evidence visualization showing which removal changed which claim.
- Blog: **“The citation beside an answer may not be the evidence that caused it.”**
- Reusable evidence selectors for B09/F07.

## OpenArtha fit

Fit is excellent: source units are bounded, aligned, versioned, and checksummed, so interventions are reconstructable. Multiple witnesses allow influence comparisons across source type and language.

Gaps: pending review, no atomic claim/evidence labels, and potential semantic drift when a span is removed. A small manually validated pilot is feasible.

## Minimum-build route

Use black-box ablation first; do not implement attention tracing or fine-tuning. Add a deterministic packet generator and claim-persistence scorer to the shared runner. Reuse F01/F02 calls where designs overlap.

## Stop conditions

Stop if interventions make contexts incoherent, source deletion changes multiple uncontrolled factors, semantic claim matching is unreliable, or only post-hoc automated judges support the effect.

## Final verdict

**GO.** One of the strongest OpenArtha-specific projects because provenance and aligned witnesses enable interventions that ordinary web corpora cannot reproduce cleanly.

## Method sources

- [ARC-JSD](https://paperswithcode.co/paper/2505.16415) and [code](https://github.com/ruizheliuoa/arc_jsd)
- [SelfCite](https://paperswithcode.co/paper/2502.09604) and [code](https://github.com/facebookresearch/selfcite)
- [AttnTrace](https://paperswithcode.co/paper/2508.03793)

