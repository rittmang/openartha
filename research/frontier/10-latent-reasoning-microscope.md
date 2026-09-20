# F10 — Latent-reasoning microscope

Verdict: **NOGO**

Buildout: extra large · Evidence yield: potentially very high · New expert data: intervention targets

## Decision summary

Probe and intervene on continuous hidden reasoning states rather than treating visible chain-of-thought as faithful. Current OpenArtha and closed V4 models do not expose latent reasoning trajectories; the project first requires a compatible open recurrent/latent-reasoning model and a validated task where intermediate state changes have interpretable expected effects.

## Research question and hypotheses

After prerequisites:

- **H1:** latent states contain decodable information about an eventual interpretive stance before it appears in output tokens.
- **H2:** targeted intervention on an early causal latent state changes the final claim predictably and more selectively than random-state perturbation.
- Primary outcome: causal change in a prespecified claim under intervention, jointly reported with off-target degradation.

## Inputs needed

Existing: source-conditioned tasks, controlled contrast sets, and passage-level held-out structure.

Missing:

- a model that performs accessible continuous/looped latent reasoning;
- hidden-state capture and decode-time intervention code;
- structural, causal, and geometric probes;
- expert-defined target claims and counterfactual expectations;
- accelerator resources and replication budget.

## Scientific and statistical setup

1. Select tasks with explicit source-conditioned outcomes, not unconstrained essays.
2. Freeze checkpoint, recurrent depth, decode policy, and intervention locations.
3. Train probes only on discovery passages and compare them with selectivity/control tasks.
4. Identify candidate causal hubs on development data through mediation or ablation.
5. Randomize intervention state, depth, direction, and strength. Include sham and norm-matched random perturbations.
6. Evaluate target claim, source faithfulness, fluency, and collateral behaviors on confirmation passages.
7. Fit mixed dose–response models and correct across layer/state searches. Replicate across seeds.
8. Treat decodability without intervention as correlation only.

## Nature of the experiment

Mechanistic interpretability of latent reasoning and decode-time control.

## Outputs

- Latent-state intervention dataset and causal maps.
- Paper on whether interpretive decisions emerge in specific latent phases.
- Visualization/blog: **“Watching a hidden reasoning state become a claim.”**
- A strong null result if decodable states fail causal tests.

## OpenArtha fit

OpenArtha offers controlled source variations and semantic targets, making it an interesting probe domain. Current feasibility is poor: the deployed corpus has no model internals, and the planned proprietary models cannot expose their latent trajectories.

## Minimum-build route after prerequisites

Use one published latent-reasoning checkpoint and 20 source-conditioned binary/ordinal decisions from F04. Reproduce the source paper on its benchmark before adapting it to OpenArtha.

## Stop conditions

Do not proceed if only ordinary autoregressive hidden states are available but the claim concerns latent reasoning. Stop if probes fail selectivity, interventions destroy fluency, or effects do not replicate.

## Final verdict

**NOGO.** Frontier and publishable in principle, but its model-side infrastructure is almost entirely absent.

## Method sources

- [Unlocking the Black Box of Latent Reasoning](https://paperswithcode.co/paper/2606.01243)
- [Scaling Up Test-Time Compute with Latent Reasoning](https://paperswithcode.co/paper/2502.05171)
- [A Survey on Latent Reasoning](https://paperswithcode.co/paper/2507.06203)

