# OpenArtha research portfolio materialization

Status: complete; implementation of individual research projects remains unauthorized

Last updated: 2026-09-03

## Objective

Create a tracked `research/` portfolio containing exactly 25 independently reviewable AI/ML project proposals: 12 foundational projects that minimize buildout and 13 frontier projects that maximize research novelty. Each proposal must define required inputs, a transparent scientific and statistical process, experiment type, concrete outputs, OpenArtha fit and gaps, minimum-build route, stop conditions, sources, and a binary GO/NOGO decision.

## Scope and decisions

- Use `research/README.md` as the portfolio index and prioritization dashboard.
- Use `research/foundational/` for 12 earlier/easier projects.
- Use `research/frontier/` for 13 2025–2026-oriented projects.
- Do not count the experiment ledger as a standalone idea; every idea must still use the shared reproducibility protocol.
- Do not duplicate the older static OpenArtha benchmark because the frontier dynamic causal benchmark subsumes it.
- Optimize ranking for evidence and publishable outputs per unit of new buildout, not novelty alone.
- A GO means a bounded pilot is defensible from current assets; it is not authorization to incur model costs or publish claims.
- A NOGO means the proposed experiment should not start until its named prerequisites are met.

## Required shared protocol

Every project file must specify hypotheses and outcomes before analysis; freeze corpus/model/code versions; preserve raw records and failures; group splits by canonical passage; separate exploratory from confirmatory results; report uncertainty and effect sizes; correct families of comparisons; blind human review where possible; treat machine alignment separately from human gold; and avoid a single LLM as final judge.

## Work plan

- [x] Fix the portfolio at 12 foundational plus 13 frontier ideas.
- [x] Create the portfolio index and scoring rubric.
- [x] Create all 12 foundational project analyses.
- [x] Create all 13 frontier project analyses.
- [x] Cross-check links, counts, verdicts, and shared protocol coverage.
- [x] Rank the minimum-build/high-output starting sequence.

## Result

- Created `research/README.md` as the portfolio index, shared scientific protocol, prioritization matrix, and minimum-build sequence.
- Created exactly 25 substantive project files: 12 foundational and 13 frontier.
- Recorded 13 GO and 12 NOGO decisions. Each NOGO names the evidence or infrastructure required to reconsider it.
- Verified that every project includes inputs, scientific/statistical setup, project nature, outputs, OpenArtha fit, minimum-build route, stop conditions, sources, and a final verdict.
- No model calls, paid experiments, training, corpus edits, or deployments were performed.

## Completion condition

The milestone is complete when `research/README.md` links to exactly 25 substantive Markdown analyses, all required sections are present, every verdict is explicit, and repository checks report no missing or duplicate portfolio entries.
