# F12 — Pluralistic post-training

Verdict: **NOGO**

Buildout: extra large · Evidence yield: potentially very high · New expert data: rights-cleared perspective targets and reward validation

## Decision summary

Fine-tune or reinforce a small open model to cover multiple reviewed human perspectives distinctly rather than imitate a majority or collapse views into generic synthesis. OpenArtha has many witnesses but does not yet have validated perspective units, coverage labels, preference data, or a trustworthy reward.

## Research question and hypotheses

After prerequisites:

- **H1:** pluralistic post-training increases coverage of held-out reviewed perspectives without reducing evidence support.
- **H2:** a dual objective for coverage and uniqueness outperforms ordinary supervised fine-tuning and generic preference optimization.
- Primary outcome: expert-verified perspective coverage at a fixed unsupported-claim ceiling. Uniqueness and fluency are secondary.

## Inputs needed

Existing: 22 named authors, 29 fields, aligned passage structure, multilingual text, and provenance.

Missing:

- human-reviewed atomic perspectives and evidence spans;
- a definition of authentic coverage that does not equate frequency with legitimacy;
- rights clearance for training and checkpoint/output release;
- train/dev/test passage grouping and minority-view protection;
- independently validated reward/evaluator models;
- open base model and substantial compute.

## Scientific and statistical setup

1. Build the perspective set through expert annotation; never treat edition ID as a perspective label.
2. Freeze evidence-linked training targets and hold out whole passages and selected authors/editions for generalization tests.
3. Compare prompt-only, retrieval-only, supervised fine-tuning, generic preference optimization, and pluralistic objective.
4. Measure coverage, uniqueness, evidence support, omission, collapse, stereotyping, and language balance.
5. Blind expert evaluation and use disagreement-aware aggregation. Automated rewards cannot be the final metric.
6. Fit hierarchical models across passage, perspective, reviewer, and method; report Pareto fronts for coverage versus unsupported claims.
7. Include majority-only and shuffled-perspective controls. Audit reward hacking and memorization.

## Nature of the experiment

Pluralistic alignment/post-training for a small open model, with retrieval and prompting as necessary baselines.

## Outputs

- Rights-cleared evidence-linked pluralism dataset.
- Adapter/model and training code if licensing permits.
- Paper: **“Perspective coverage without collapse in source-grounded language models.”**
- Blog: **“Teaching a model to preserve differences instead of averaging them away.”**

## OpenArtha fit

The multi-witness alignment is a rare and promising substrate. Current readiness is poor: the repository records authors and fields, not verified perspective units, and all commentary alignments await human review. GPL-3.0 and base-model licenses require specific legal/rights analysis.

## Minimum-build route after prerequisites

First test retrieval/prompting on 20 passages and 100 reviewed perspective units. Train only if those baselines show a persistent coverage gap. Prefer a small adapter over full-model training.

## Stop conditions

Do not train on machine-derived perspective labels, optimize solely against an LLM judge, release a checkpoint without rights analysis, or proceed if gains reflect memorized wording.

## Final verdict

**NOGO.** Potentially the largest research payoff, but it requires B08/B10/F06-quality labels and is the opposite of minimum buildout today.

## Method sources

- [Overton Pluralistic Reinforcement Learning](https://paperswithcode.co/paper/2602.20759)
- [Modular Pluralism](https://paperswithcode.co/paper/2406.15951)
- [A Roadmap to Pluralistic Alignment](https://paperswithcode.co/paper/2402.05070)

