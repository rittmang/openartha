# F09 — Sparse cross-architecture model diffing

Verdict: **NOGO**

Buildout: extra large · Evidence yield: potentially very high · New expert data: behavioral validation set

## Decision summary

Train crosscoders or related sparse representation models to align activations from two open LLM architectures and discover features unique to one. Then test whether those features causally explain reproducible interpretation differences. This is genuinely frontier work, but it is not compatible with the current closed V4 model set and is not a minimum-build starting point.

## Research question and hypotheses

After prerequisites:

- **H1:** cross-model latent features predict model-specific behavioral phenotypes discovered in F01 on held-out passages.
- **H2:** suppressing or activating a candidate feature causally reduces or induces the corresponding behavior more than matched random features.
- Primary outcome: held-out causal effect of feature intervention on the prespecified behavior, with reconstruction and off-target effects reported.

## Inputs needed

Existing: passage-aligned prompts, controlled contrast sets, and potential behavioral phenotypes.

Missing:

- two rights-compatible open models with accessible activations;
- large matched activation traces and a layer/alignment policy;
- crosscoder/SAE training compute;
- validated F01 behavioral differences;
- causal intervention and collateral-capability evaluation.

## Scientific and statistical setup

1. Establish a behavioral difference on discovery and confirmation passages before inspecting internals.
2. Freeze model checkpoints, tokenizer handling, prompt templates, layer pairings, and activation sampling.
3. Train crosscoders on a training corpus separated from behavioral confirmation items.
4. Select candidate shared and model-specific features on development data only.
5. Evaluate feature interpretability with automated descriptions as proposals and blinded human checks.
6. Perform activation patching/ablation/steering with matched random, frequency-matched, and reconstruction-error controls.
7. Fit hierarchical dose–response models across passages. Correct the candidate-feature family and report failed interventions.
8. Replicate across at least one second seed/checkpoint before mechanistic language is used.

## Nature of the experiment

Mechanistic interpretability, sparse representation learning, and causal model comparison.

## Outputs

- Cross-model feature dictionary and intervention benchmark.
- Paper: **“From behavioral slices to causal latent differences across language-model architectures.”**
- Interactive feature cards tied to source passages.
- Blog: **“Two models disagree—but is there an internal feature that explains why?”**

## OpenArtha fit

OpenArtha is well suited as a structured behavioral probe set because it offers matched prompts, source variants, and held-out chapters. It supplies none of the expensive model-side requirements. The four planned V4 models are closed and cannot support activation analysis.

## Minimum-build route after prerequisites

Use two small open models and one confirmed F01 phenotype. Adapt an existing crosscoder implementation; avoid training general-purpose SAEs from scratch if compatible dictionaries exist.

## Stop conditions

Do not begin without a replicated behavioral difference. Do not call correlating probe features mechanisms; require causal intervention, random-feature controls, held-out passages, and off-target measurement.

## Final verdict

**NOGO.** High novelty but among the worst current evidence-per-buildout choices. Revisit after F01/F08 and an open-model infrastructure decision.

## Method sources

- [Cross-Architecture Model Diffing with Crosscoders](https://paperswithcode.co/paper/2602.11729)
- [Overcoming Sparsity Artifacts in Crosscoders](https://paperswithcode.co/paper/2504.02922)
- [BehaviorBox](https://paperswithcode.co/paper/2506.02204)

