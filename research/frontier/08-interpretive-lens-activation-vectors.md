# F08 — Interpretive-lens activation vectors

Verdict: **NOGO**

Buildout: large · Evidence yield: potentially very high · New expert data: validated behavioral trait definitions

## Decision summary

Find latent activation directions associated with behaviors such as literal paraphrase, synthesis, uncertainty expression, or deference to supplied context, then intervene on those directions. This must not label a vector “Vedanta,” “Buddhist,” or any real tradition without extensive scholarly validation; a vector is a model feature, not a human school.

## Research question and hypotheses

After prerequisites:

- **H1:** an automatically derived activation direction predicts a prespecified interpretive behavior on held-out passages.
- **H2:** causal steering along that direction changes the target behavior monotonically while preserving unrelated capabilities and source faithfulness.
- Primary outcome: held-out causal dose–response for the target behavior, with off-target degradation reported jointly.

## Inputs needed

Existing: aligned passages/witnesses and potential behavioral contrast items.

Missing:

- selected open-weight model families and accelerator access;
- expert-operationalized, non-doctrinal behavior traits;
- balanced positive/negative prompts and held-out passages;
- activation capture/intervention infrastructure;
- collateral-behavior and capability controls.

## Scientific and statistical setup

1. Define one narrow behavior such as “deference to supplied evidence over prior completion,” not a philosophical identity.
2. Build balanced contrast prompts and group by canonical passage.
3. Extract candidate directions on discovery data; choose layer and strength only on development data.
4. Test prediction and steering on untouched passages and a second model where feasible.
5. Randomize intervention strength, include zero/sham/random directions, and blind behavioral review.
6. Fit dose–response mixed models with passage effects. Report target change, off-target changes, perplexity/fluency, and uncertainty.
7. Require causal intervention results; probe accuracy alone does not establish a mechanism.

## Nature of the experiment

Mechanistic interpretability and activation steering on open models.

## Outputs

- Behavior-specific activation dataset and intervention code.
- Paper on evidence-deference or uncertainty vectors in interpretive generation.
- Visual/blog: **“Can an internal slider change how much a model listens to the text?”**
- Negative results are valuable if directions fail to transfer or cause broad degradation.

## OpenArtha fit

OpenArtha supplies unusually clean contrast contexts and many held-out passage units. It does not supply model activations, open models, GPUs, or validated latent traits. Historical commentators cannot be used naively as persona labels.

## Minimum-build route after prerequisites

Choose one 7B–14B open model, one behavior, 100 contrast prompts, and one activation-steering library. Do not train or compare many models initially.

## Stop conditions

Do not proceed without open weights and expert trait definitions. Stop if effects fail sham/random-vector controls, do not generalize, or introduce large unsupported claims.

## Final verdict

**NOGO.** Scientifically attractive but not a low-build project; first create validated behavioral contrasts through F01–F04.

## Method sources

- [Persona Vectors](https://paperswithcode.co/paper/2507.21509) and [code](https://github.com/safety-research/persona_vectors)
- [The Assistant Axis](https://paperswithcode.co/paper/2601.10387) and [code](https://github.com/safety-research/assistant-axis)
- [Activation Steering](https://paperswithcode.co/search?q=activation+steering)
