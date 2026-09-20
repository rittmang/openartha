# F07 — Executable interpretation programs

Verdict: **GO**

Buildout: medium–large · Evidence yield: very high · New expert data: operation and evidence audit

## Decision summary

Require a model to create an executable sequence of bounded text operations—select, quote, paraphrase, contrast, qualify, fuse—before producing a synthesis. This makes provenance inspectable and allows a wrong step to be repaired without regenerating everything.

## Research question and hypotheses

- **H1:** executable operation graphs improve claim-level attribution completeness and correctness over direct generation at comparable cost.
- **H2:** localized repair of a failed operation changes fewer already-correct claims than full-response regeneration.
- Primary outcome: fully supported and correctly attributed output-claim rate.

## Inputs needed

Existing: bounded passages/commentaries, stable source IDs and checksums, source locators, and retrieval.

New:

- a typed operation schema with deterministic validation;
- 30–50 reviewed tasks with complete evidence sets;
- operation-level labels for valid inputs, transformation faithfulness, and output support;
- injected operation failures for repair testing.

## Scientific and statistical setup

1. Freeze allowed operations and execution semantics; reject free-form steps from confirmatory runs.
2. Compare direct long-context generation, citation-prompted generation, post-hoc attribution, and executable-program generation.
3. Match source packets and approximate inference cost across systems.
4. Review atomic output claims and operation traces blind to method. Score document/span attribution, transformation validity, omission, and unsupported fusion.
5. Inject a known faulty source selection or transformation and compare local rollback/repair with full regeneration.
6. Use paired task bootstrap intervals and hierarchical claim-level models. The primary comparison is program versus strongest non-program baseline.
7. Negative control: a decorative “plan” ignored by execution. Positive control: a simple extract/quote task.

## Nature of the experiment

Programmatic attributed generation and error localization. It resembles a small code agent whose operations are text transformations with immutable provenance.

## Outputs

- Open specification for interpretation programs and validator.
- Executable traces and benchmark tasks.
- Paper: **“Auditable interpretation through executable source operations.”**
- Blog: **“Instead of asking the model for an essay, ask for a recipe you can replay.”**
- Reusable engine for comparative synthesis and future agent work.

## OpenArtha fit

Fit is excellent at the data-architecture level because every operation can point to a stable source record and checksum. Compact passage units keep execution bounded.

Gaps: no operation schema, claim gold, or complete evidence tasks. A small pilot can create them without changing the public app or corpus.

## Minimum-build route

Implement five operations in a local typed runner and evaluate 30 tasks. Reuse B09 evidence labels. Avoid a multi-agent framework; one generator plus deterministic executor is the stronger baseline.

## Stop conditions

Stop if programs are free-form prose, execution cannot be replayed, model plans cite nonexistent spans, or attribution gains disappear after cost matching.

## Final verdict

**GO.** More buildout than F01–F05, but it can yield a distinctive paper and reusable research infrastructure from a small bounded implementation.

## Method sources

- [GenerationPrograms](https://paperswithcode.co/paper/2506.14580) and [code](https://github.com/meetdavidwan/generationprograms)
- [LAQuer](https://paperswithcode.co/paper/2506.01187) and [code](https://github.com/eranhirs/LAQuer)

