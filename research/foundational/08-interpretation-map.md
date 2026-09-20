# B08 — Interpretation map

Verdict: **NOGO**

Buildout: medium · Evidence yield: potentially high · New expert data: substantial paired-claim annotation

## Decision summary

Map where historical interpretations are similar, distinct, contradictory, or not comparable. The corpus structure is unusually promising, but edition IDs are not perspective labels and semantic distance is not a validated theory of interpretation. A map built now would look persuasive before it became scientifically meaningful.

## Research question and hypotheses

After annotation:

- **H1:** verse-conditioned claim representations predict expert pair judgments better than lexical and generic embedding baselines.
- **H2:** a model with an explicit `not comparable/unclear` class is better calibrated than forced agreement-versus-disagreement classification.
- Primary outcome: macro-F1 or ordinal agreement with expert pair labels on passage-grouped held-out data, accompanied by calibration.

## Inputs needed

Existing: many witnesses aligned to each canonical passage, author/edition/language metadata, provenance, and compact source units.

Missing:

- atomic claim boundaries;
- an expert annotation guide for `similar`, `compatible but distinct`, `conflicting`, `not comparable`, and `insufficient context`;
- multiple reviewer labels and adjudication;
- reviewed alignments and attribution for the sampled passages.

## Scientific and statistical setup

1. Restrict the first study to a human-reviewed subset and bounded claims from the same canonical passage.
2. Develop the label guide on an exploratory set; freeze it before confirmatory annotation.
3. Sample pairs across same/different language, edition, and commentary/translation type, including hard negatives.
4. Blind author/model identity where the wording permits. Retain all individual labels.
5. Compare lexical overlap, frozen multilingual embeddings, cross-encoder/NLI proposals, and a small task-trained classifier.
6. Report macro-F1, per-class recall, calibration, and reviewer agreement with passage-cluster bootstrap intervals. Use a hierarchical confusion model if annotator behavior differs.
7. Visualizations are secondary and must show uncertainty. Distances cannot be labelled doctrinal without separate evidence.

## Nature of the project

Expert-annotated semantic relation learning and digital-humanities visualization. The core product is the claim-pair dataset and uncertainty-aware relation model, not a two-dimensional map.

## Outputs

- Annotation guide and reviewed claim-pair benchmark.
- Paper: **“Beyond agreement: modelling compatible difference in aligned interpretations.”**
- Interactive evidence map only after validation.
- Blog: **“Two interpretations can be different without disagreeing.”**

## OpenArtha fit

Structural fit is excellent: many witnesses share stable passage coordinates and provenance. Evidential readiness is poor: no philosophical-position labels exist, all alignments await human review, and long commentary may exceed a single claim.

## Minimum-build route after prerequisites

Start with 20 reviewed passages, extract bounded claims manually, and double-label roughly 1,000 stratified pairs. Test cheap baselines before building visualization or training.

## Stop conditions

Do not proceed to modeling if expert agreement remains low, if classes cannot be operationalized, or if model performance is driven by author/language artifacts.

## Final verdict

**NOGO.** The corpus geometry is ideal, but the central construct does not yet exist as trustworthy data. Annotation—not engineering—is the prerequisite.

## Method sources

- [Natural Language Inference](https://paperswithcode.co/task/natural-language-inference)
- [Cross-Lingual Natural Language Inference](https://paperswithcode.co/task/cross-lingual-natural-language-inference)
- [Semantic Textual Similarity](https://paperswithcode.co/task/semantic-textual-similarity)
