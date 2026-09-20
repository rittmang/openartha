# B11 — Domain translation laboratory

Verdict: **NOGO**

Buildout: large · Evidence yield: uncertain · New expert data: blind translation assessments and terminology labels

## Decision summary

Adapt an existing multilingual translation model to Sanskrit/Hindi/English material and test how context affects translation. The current corpus has many aligned fields, but they are not interchangeable references: some are commentary, some are translations, alignments await review, and different witnesses intentionally interpret terms differently.

## Research question and hypotheses

After data curation:

- **H1:** adapter-based domain adaptation improves terminology accuracy and expert adequacy over a zero-shot Indic model on passage-held-out data.
- **H2:** chapter context improves discourse consistency but may increase interpretive insertion.
- Primary outcome: blinded expert adequacy/faithfulness rating. Automatic chrF/COMET-style scores remain secondary because legitimate translations vary.

## Inputs needed

Existing: Sanskrit root text, Hindi/English fields, content types, edition metadata, stable passage IDs, and source provenance.

Missing:

- reviewed identification of true translation pairs versus commentary;
- rights analysis for training and checkpoint release;
- expert reference translations or multidimensional ratings;
- a terminology glossary with acceptable alternatives;
- sufficient parallel diversity to separate edition style from target meaning.

## Scientific and statistical setup

1. Curate only reviewed `translation` records; exclude commentary and uncertain spans.
2. Group splits by canonical passage and chapter. Reserve editions for out-of-domain testing where possible.
3. Compare zero-shot baseline, terminology-constrained decoding, lightweight adapter, and context-aware adapter.
4. Obtain blind pairwise expert ratings for adequacy, fluency, terminology, omission, and interpretive addition.
5. Use a cumulative-link mixed model with reviewer and passage random effects. Report automatic metrics with bootstrap intervals but do not optimize exclusively against one reference.
6. Include identity/transliteration and deliberately corrupted translations as controls.
7. Predefine acceptable alternative renderings; do not score one theological wording as universally correct.

## Nature of the project

Low-resource domain adaptation and translation-quality evaluation, potentially producing adapters rather than a full model.

## Outputs

- Curated translation-pair subset and terminology evaluation.
- Translation-quality paper or negative-result report.
- Optional adapter/checkpoint only if rights allow.
- Blog: **“When translation ends and interpretation begins.”**

## OpenArtha fit

OpenArtha is a useful evaluation domain because passages and witnesses align with provenance. It is currently weak training data because content types, alignments, references, and rights need task-specific human verification. Seven hundred source passages are far too small for foundation-model training.

## Minimum-build route after prerequisites

First run zero-shot evaluation on 100 reviewed passages with terminology constraints. Only fine-tune if the error taxonomy identifies a learnable, rights-compatible gap. Specialist review is the dominant cost.

## Stop conditions

Do not train if translation/commentary boundaries are uncertain, no expert evaluation is available, or output/checkpoint rights are unresolved.

## Final verdict

**NOGO.** Revisit after reviewed translation pairs and expert scoring exist. A zero-shot diagnostic may be folded into another study without becoming this project.

## Method sources

- [IndicTrans2](https://paperswithcode.co/paper/indictrans2-towards-high-quality-and)
- [Low-Resource Neural Machine Translation](https://paperswithcode.co/task/low-resource-neural-machine-translation)
- [Machine Translation](https://paperswithcode.co/task/machine-translation)

