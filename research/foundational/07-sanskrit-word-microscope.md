# B07 — Sanskrit word microscope

Verdict: **NOGO**

Buildout: large · Evidence yield: potentially high · New expert data: specialist token, morphology, and alignment labels

## Decision summary

Segment Sanskrit under sandhi, assign lemmas/morphology, analyze compounds, and align source units to translations. The reader experience would be valuable, but the current OpenArtha corpus does not contain the token-level gold data or reviewed linguistic analysis needed to evaluate it honestly.

## Research question and hypotheses

If prerequisites are met:

- **H1:** an existing Sanskrit NLP model adapted with a small reviewed Gita set improves exact segmentation and morphological F1 over its zero-shot output.
- **H2:** multilingual alignment improves when segmentation and lemma features are included.
- Primary outcome: exact sentence segmentation accuracy; secondary outcomes: boundary F1, lemma/morphology F1, compound-label agreement, and alignment error rate.

## Inputs needed

Existing: 700 Devanagari passages, IAST representation, provisional English, aligned Sanskrit/Hindi/English witnesses, stable references, and provenance.

Missing:

- licensed Sanskrit treebanks or segmentation/morphology corpora compatible with the target conventions;
- expert-reviewed segmentation, lemmas, morphology, compound analyses, and token/phrase alignments for a representative Gita subset;
- an annotation policy for legitimate alternative analyses.

IAST is another representation of the same witness, not an independent label.

## Scientific and statistical setup

1. Select an external pretrained toolkit and declare its annotation scheme before touching OpenArtha labels.
2. Sample passages by chapter, token length, sandhi density, and compound complexity; reserve entire passages for confirmation.
3. Obtain two independent Sanskrit-specialist annotations and adjudicate only after measuring agreement.
4. Compare lexicon/rule baseline, zero-shot toolkit, adapter/fine-tuned model, and ensemble.
5. Report exact match and boundary/morphology F1 with passage bootstrap intervals. Preserve alternative acceptable analyses rather than forcing one label.
6. Evaluate word-to-translation links separately from morphology. Blind translation-alignment reviewers to model identity.
7. Negative control: corrupted transliteration; positive control: simple unambiguous forms.

## Nature of the project

Low-resource historical-language NLP plus a reader-facing linguistic tool. It requires linguistic scholarship, not just model engineering.

## Outputs

- Expert-reviewed Sanskrit evaluation subset.
- Adapter or inference pipeline with error analysis.
- Dataset/tool paper and a reader prototype.
- Blog: **“Why one Sanskrit line is not simply a row of words.”**

## OpenArtha fit

OpenArtha is suitable as the target corpus because it has stable paired representations, bounded passages, translations, and provenance. It is not currently suitable as the training or gold evaluation corpus because it lacks token-level linguistic labels and completed source review.

## Minimum-build route after prerequisites

Import a compatible toolkit, annotate 75–100 stratified passages, and evaluate zero-shot before training anything. This is still several weeks of specialist work; a UI should come last.

## Stop conditions

Do not proceed without a qualified annotator, rights-compatible external data, explicit treatment of alternative analyses, and enough double annotation to estimate reliability.

## Final verdict

**NOGO.** Reconsider after expert annotation resources and conventions are secured. Technical inference is easy; trustworthy evaluation is not.

## Method sources

- [TransLIST](https://paperswithcode.co/paper/translist-a-transformer-based-linguistically)
- [SanskritShala](https://paperswithcode.co/paper/sanskritshala-a-neural-sanskrit-nlp-toolkit)
- [Word Alignment](https://paperswithcode.co/task/word-alignment)

