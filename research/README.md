# OpenArtha AI/ML research portfolio

Status: proposal portfolio; no model spending, training, or publication authorized

Last reviewed: 2026-09-03

## Purpose

This folder turns 25 possible projects into trackable research decisions. The goal is not to maximize technical novelty in isolation. It is to maximize **defensible evidence and publishable output per unit of new buildout** while respecting what OpenArtha's current corpus can and cannot support.

The portfolio contains exactly:

- [12 foundational projects](#foundational-projects): lower buildout, useful baselines, corpus improvements, and earlier-generation ML/NLP ideas;
- [13 frontier projects](#frontier-projects): 2025–2026 model-behavior, causal-attribution, interpretability, agent, and post-training research.

`GO` means a bounded pilot is scientifically defensible from current assets. It does **not** authorize API spend, training, corpus changes, or public claims. `NOGO` means do not begin the experiment until the file's prerequisites are satisfied.

## Current OpenArtha research inventory

The fit assessments use the repository state on 2026-09-03:

- 700 canonical passages with stable `canonicalRef` identifiers;
- Devanagari, IAST, and a provisional verse-aligned English root view;
- 29 public translation/commentary fields from 22 named authors;
- 20,300 verse-aligned records: 11,900 commentary and 8,400 translation records;
- Sanskrit, English, and Hindi material;
- 515 separately represented paratext records;
- edition, author, language, script, content type, source locator, source commit, review state, and checksum metadata;
- versioned JSONL/TEI exports, read-only APIs, lexical search, and commentary FTS5.

The principal limitation is equally important: all root passages still require two human review passes, and commentary alignments are machine-validated but human review is pending. The commentary snapshot is GPL-3.0. Machine alignments may be used as noisy development data, but not as unquestioned gold labels.

## Shared scientific protocol

Every project inherits these requirements. A project file adds task-specific details but cannot weaken them.

1. **Preregister the claim.** Freeze the research question, primary outcome, exclusion rules, model/corpus versions, sample-size rationale, and analysis before confirmatory runs.
2. **Expose assumptions.** A label such as similarity, faithfulness, perspective, or relevance must have an operational definition and annotation guide. Historical sources are observations, not ground truth about doctrine.
3. **Separate exploration and confirmation.** Use passage-grouped discovery, development, and held-out confirmation sets. Never split different witnesses to the same `canonicalRef` across train and test when that would leak the passage.
4. **Keep immutable receipts.** Store prompts, source packets, raw outputs, failures, provider/model IDs, parameters, timestamps, token/cost records, code commit, corpus versions, and checksums.
5. **Use controls.** Include cheap baselines, positive controls expected to change, negative controls expected not to change, and ablations for every claimed mechanism.
6. **Quantify uncertainty.** Report effect sizes and interval estimates, not only point scores or p-values. Use hierarchical or mixed-effects models when passages, authors, models, or reviewers create repeated measurements.
7. **Control multiplicity.** Name one primary endpoint. Correct prespecified families of secondary comparisons with Holm or Benjamini–Hochberg as appropriate.
8. **Blind subjective evaluation.** Randomize order, mask system identity, measure inter-reviewer agreement, retain disagreement, and disclose reviewer expertise and conflicts.
9. **Do not let one LLM close the loop.** A model may propose labels or score candidates, but cannot be the sole generator, annotator, judge, and final authority.
10. **Report failures and nulls.** Preserve missing calls, refusals, parsing failures, negative results, and methods that fail to beat a simple baseline.
11. **Keep synthetic text separate.** Counterfactuals and generated analyses must never be stored or displayed as canonical or historical source text.
12. **Reproduce before narrating.** A blog or paper claim must point to a frozen result table and script that regenerates every reported number and figure.

## Portfolio scoring

The index uses ordinal planning estimates, not measured scientific results:

- **Buildout:** new engineering beyond a shared experiment runner (`S`, `M`, `L`, `XL`).
- **New expert data:** none, small review set, substantial annotation, or ontology/training corpus.
- **Evidence yield:** likely strength of a defensible result, including a useful null (`1` low to `5` high).
- **Output leverage:** expected reusable outputs relative to engineering, compute, and annotation (`Low`, `Medium`, `High`, `Very high`).

These ratings must be updated after a pilot; they are explicit planning judgments, not hidden quantitative facts.

## Foundational projects

| ID | Project | Buildout | New expert data | Evidence yield | Leverage | Verdict |
|---|---|---:|---|---:|---|---|
| B01 | [ML-ready corpus and leakage-safe splits](foundational/01-ml-ready-corpus-and-splits.md) | S | Small audit | 4 | Very high as infrastructure | GO |
| B02 | [Commentary fingerprint and leakage audit](foundational/02-commentary-fingerprint.md) | S | None initially | 4 | Very high | GO |
| B03 | [Multilingual topic atlas](foundational/03-topic-atlas.md) | S | Small coherence review | 3 | High | GO |
| B04 | [Related-passage finder](foundational/04-related-passage-finder.md) | M | Small pair set | 3 | Medium | GO |
| B05 | [Alignment watchdog](foundational/05-alignment-watchdog.md) | M | Review queue | 5 | Very high | GO |
| B06 | [Hybrid multilingual semantic search](foundational/06-hybrid-multilingual-search.md) | M | Relevance judgments | 4 | High | GO |
| B07 | [Sanskrit word microscope](foundational/07-sanskrit-word-microscope.md) | L | Specialist token labels | 4 | Low now | NOGO |
| B08 | [Interpretation map](foundational/08-interpretation-map.md) | M | Substantial expert pairs | 4 | Low now | NOGO |
| B09 | [Citation-first curator](foundational/09-citation-first-curator.md) | M | Small QA/evidence set | 4 | High as an offline study | GO |
| B10 | [Comparative synthesis engine](foundational/10-comparative-synthesis.md) | L | Claim/evidence tables | 5 | Low now | NOGO |
| B11 | [Domain translation laboratory](foundational/11-domain-translation-lab.md) | L | Expert translation ratings | 3 | Low now | NOGO |
| B12 | [Provenance-aware claim graph](foundational/12-provenance-claim-graph.md) | XL | Ontology and relation gold | 5 | Low now | NOGO |

## Frontier projects

| ID | Project | Buildout | New expert data | Evidence yield | Leverage | Verdict |
|---|---|---:|---|---:|---|---|
| F01 | [Automated behavioral-difference discovery](frontier/01-automated-behavioral-difference-discovery.md) | M | Small validation set | 5 | Very high | GO |
| F02 | [Interpretation test-time scaling](frontier/02-interpretation-test-time-scaling.md) | S–M | Small validation set | 5 | Very high | GO |
| F03 | [Causal context attribution](frontier/03-causal-context-attribution.md) | M | Evidence-span review | 5 | Very high | GO |
| F04 | [Counterfactual reasoning-faithfulness audit](frontier/04-counterfactual-reasoning-faithfulness.md) | M | Counterfactual validation | 5 | High | GO |
| F05 | [Model-family behavioral entanglement](frontier/05-model-family-entanglement.md) | S after shared runs | Small correctness set | 5 | Very high | GO |
| F06 | [Disagreement-aware human evaluation](frontier/06-disagreement-aware-human-evaluation.md) | M | Multiple expert ratings | 5 | Medium now | NOGO |
| F07 | [Executable interpretation programs](frontier/07-executable-interpretation-programs.md) | M–L | Operation/evidence audit | 5 | High | GO |
| F08 | [Interpretive-lens activation vectors](frontier/08-interpretive-lens-activation-vectors.md) | L | Trait definitions | 5 | Low now | NOGO |
| F09 | [Sparse cross-architecture model diffing](frontier/09-cross-architecture-model-diffing.md) | XL | Behavioral validation set | 5 | Low now | NOGO |
| F10 | [Latent-reasoning microscope](frontier/10-latent-reasoning-microscope.md) | XL | Intervention gold | 5 | Low now | NOGO |
| F11 | [Failure-attributed agentic scholar](frontier/11-failure-attributed-agentic-scholar.md) | L | Failure trajectories | 4 | Low now | NOGO |
| F12 | [Pluralistic post-training](frontier/12-pluralistic-post-training.md) | XL | Rights-cleared expert targets | 5 | Low now | NOGO |
| F13 | [Dynamic causal InterpretBench](frontier/13-dynamic-causal-interpretbench.md) | XL | Continuing expert governance | 5 | Low now | NOGO |

## Best evidence per unit of buildout

The recommended sequence reuses one shared backbone rather than building 25 systems:

1. **B01 corpus/splits** — one to two engineering days for manifests, passage-grouped folds, and reproducible tables. It prevents invalid results everywhere else.
2. **B02 commentary fingerprint** — the fastest no-API study. It can produce a leakage/artifact audit, technical blog, and negative-result baseline with existing data.
3. **B05 alignment watchdog** — creates immediate editorial value and converts reviewer work into reusable gold labels.
4. **F01 + F02 + F03 as one preregistered study** — reuse the same model calls to publish behavioral slices, inference-scaling effects, and causal context-attribution results.
5. **F05 as a secondary analysis of the same runs** — estimate whether model families supply independent evidence; little new engineering after F01–F03.
6. **B09 offline citation study** — reuse the retriever and evidence annotations from B05/B06/F03 before considering a user-facing curator.

This sequence can produce, from one backbone:

- a versioned experimental dataset and model-output release, subject to provider/output rights;
- one corpus-quality technical report;
- one model-behavior research paper or workshop paper;
- one causal-attribution paper or combined paper section;
- one public visualization/blog series;
- reusable human annotations for later projects.

## Minimum shared build

Build these once:

```text
versioned corpus loader
  -> passage-grouped split manifest
  -> model/run adapter with immutable receipts
  -> source-packet/intervention generator
  -> atomic-claim and evidence schema
  -> blind annotation export/import
  -> statistical analysis tables
  -> figure and report generator
```

Do not begin with a chat UI, production vector database, multi-agent framework, fine-tuning pipeline, or mechanistic-interpretability stack. None is required for the highest-leverage first studies.

## Portfolio-wide hard stops

Stop or redesign any study if:

- the result disappears on passage-grouped confirmation data;
- an apparent model effect is smaller than repeat-run variation;
- source alignment errors explain the effect;
- the primary outcome changes after seeing the results;
- one automated judge supplies the only positive finding;
- synthetic counterfactuals can be confused with source records;
- rights do not permit the proposed output release;
- model/version identifiers are mutable or unavailable;
- the study cannot report failures and missing responses.

## Relationship to other plans

This portfolio instantiates the ideas in [the AI/ML ladder](../docs/plans/ai-ml-project-ladder.md). Work status for creating this folder is maintained in [the portfolio materialization plan](../docs/plans/research-portfolio.md).
