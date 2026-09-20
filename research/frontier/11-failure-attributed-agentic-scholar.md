# F11 — Failure-attributed agentic scholar

Verdict: **NOGO**

Buildout: large · Evidence yield: high if prerequisites exist · New expert data: failed and successful trajectories

## Decision summary

Construct a retrieve–select–compare–verify–synthesize agent whose failures can be localized to a contiguous set of steps and rolled back with calibrated coverage. Starting here would be wasteful: OpenArtha lacks a strong executable single-agent baseline, typed trajectories, and a corpus of verified failure locations.

## Research question and hypotheses

After prerequisites:

- **H1:** a typed single-agent or multi-agent research pipeline fails in repeatable categories that can be annotated reliably.
- **H2:** conformal step-set prediction contains the decisive failure with nominal finite-sample coverage while producing sets small enough for efficient rollback.
- **H3:** targeted rollback improves final evidence integrity over full restart at matched compute.
- Primary outcome: empirical coverage and mean prediction-set length for decisive-error localization.

## Inputs needed

Existing: source corpus, retrieval, provenance, candidate claim/evidence schema, and future executable programs from F07.

Missing:

- a strong single-agent baseline;
- typed, timestamped, immutable trajectories;
- 150+ tasks with success/failure labels and decisive-step annotations;
- recovery/rollback semantics;
- enough exchangeable calibration trajectories for conformal analysis.

## Scientific and statistical setup

1. Define every step type, permitted tool, success criterion, and termination rule before collection.
2. Compare single-agent executable workflow against any multi-agent variant; added agents must beat the simpler baseline.
3. Sample tasks by difficulty/source count and preserve all trajectories, including crashes.
4. Triple-annotate a subset using a published failure taxonomy; measure agreement before scaling.
5. Split tasks chronologically or by canonical passage into training, conformal calibration, and untouched evaluation.
6. Report finite-sample coverage, set length, error localization, recovery rate, final claim support, cost, and latency.
7. Compare rollback to full restart and no recovery at matched budget. Use paired bootstrap intervals.
8. Negative control: random failure steps. Positive control: injected deterministic operation failures.

## Nature of the experiment

Agent systems research, sequential error attribution, conformal prediction, and recovery.

## Outputs

- OpenArtha agent failure taxonomy and trajectory dataset.
- Paper: **“Calibrated failure localization and rollback in source-grounded research agents.”**
- Debugging viewer and blog: **“Do not ask an agent to try again; find where it first went wrong.”**

## OpenArtha fit

OpenArtha is a good eventual environment because sources and expected evidence can be bounded and every operation can be logged. It currently lacks the prerequisite agent, tasks, and trajectory labels.

## Minimum-build route after prerequisites

Extend F07's single executable program with deterministic injected failures. Validate failure attribution there before adding independent agents or open-ended planning.

## Stop conditions

Do not add agents without a matched single-agent win. Do not claim conformal guarantees when calibration/test exchangeability is implausible or after tuning on evaluation trajectories.

## Final verdict

**NOGO.** Build F07 and collect failures first. The multi-agent label alone does not justify the engineering.

## Method sources

- [Why Do Multi-Agent LLM Systems Fail?](https://paperswithcode.co/paper/2503.13657) and [code](https://github.com/multi-agent-systems-failure-taxonomy/masft)
- [Conformal Agent Error Attribution](https://paperswithcode.co/paper/2605.06788) and [code](https://github.com/layer6ai-labs/conformal-agent-error-attribution)

