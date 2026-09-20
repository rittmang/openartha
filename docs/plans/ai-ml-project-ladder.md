# OpenArtha AI/ML project ladder

Status: research roadmap; no implementation authorized

Last updated: 2026-09-03

## Outcome

Identify AI and machine-learning projects that are genuinely supported by OpenArtha's current data, order them by end-to-end difficulty, and separate useful research from impressive-looking but scientifically weak demos.

The recommended frontier project is now **OpenArtha Causal Model Diffing**: do not merely compare model answers; intervene on context, inference budget, repeated sampling, model identity, and model version, then estimate which factor actually caused a claim to appear, disappear, or reverse. The earlier Interpretation Observatory remains the required measurement infrastructure, not the research contribution by itself.

The **alignment watchdog** and **hybrid multilingual semantic search** remain valuable supporting corpus-ML projects. They are prerequisites for trustworthy retrieval-grounded work, but they are no longer the headline recommendation in this revision.

## Current-state evidence

This plan is grounded in the repository state on 2026-09-02:

- one work: the Bhagavad Gita;
- 700 canonical passages in Devanagari, IAST, and a provisional aligned English translation;
- 29 public commentary/translation editions from 22 named authors;
- 20,300 verse-aligned records: 11,900 commentary records and 8,400 translation records;
- 9,100 Sanskrit, 7,700 English, and 3,500 Hindi records;
- 515 explicit paratext records outside the 20,300 canonical alignments;
- exact/compound lexical search over the root corpus and D1 FTS5 search over commentaries;
- passage, edition, source locator, commit, alignment status, checksum, language, script, and content-type metadata;
- JSONL and TEI exports suitable for offline experiments.

Important limitations:

- all 700 root passages still require two independent human review passes;
- all 20,300 commentary alignments are machine-validated but await human review;
- the material is large enough for experiments, adapters, rerankers, and benchmarks, but far too small to train a trustworthy general language model from scratch;
- the current labels identify source fields and editions, not verified philosophical positions;
- similarity does not prove agreement, difference does not prove disagreement, and an LLM summary is not a source;
- the commentary snapshot is GPL-3.0, so every released dataset, checkpoint, and hosted service needs explicit rights and model-license review.

## How complexity is ranked

"Complexity" includes data cleaning, expert annotation, evaluation, multilingual behavior, model training, product integration, and the harm caused by a plausible but wrong result. A project that calls one large API can therefore be harder than a project that trains a small classifier.

## 2026 frontier correction

The previous revision leaned too heavily on the 2023–2024 stack: RAG, embeddings/NLI, semantic entropy, static LLM judges, and generic multi-agent panels. Those tools remain useful controls, but they are no longer a strong research contribution on their own.

The frontier opportunity is to use OpenArtha as a **causal intervention laboratory** for models. Because the same bounded source units have many aligned human witnesses, the project can manipulate one factor at a time and study the resulting behavior rather than build another answer-generation product.

## 2026 frontier ladder (primary roadmap)

| Level | Project | ELI5 version | Actual research question | Requirements |
|---:|---|---|---|---|
| F1 | Automated behavioral-difference discovery | Let the system find the kinds of passages or prompts where two models reliably separate. | Can BehaviorBox-style feature discovery find coherent, held-out interpretation differences that aggregate scores hide? | Many controlled contrast items; discovery and held-out passage splits. |
| F2 | Interpretation test-time scaling curves | Give a model more thinking time, more attempts, or a chance to revise; see whether its reading converges or merely becomes longer. | How do context, batch, and turn scaling change interpretive diversity, stability, evidence use, and faithfulness? | API models are sufficient; control token budget and cost carefully. |
| F3 | Causal context attribution | Remove one piece of evidence and see which claims stop appearing. | Which exact source spans causally influence each generated claim, rather than receiving a plausible citation afterward? | Black-box ablation works now; attention/activation variants need open weights. |
| F4 | Counterfactual reasoning-faithfulness audit | Change a stated reason while holding the question steady; see whether the conclusion follows the change. | Does a model's explanation reflect a causally influential reasoning process, or is it a convincing story written after the answer? | Controlled counterfactuals, stance labels, and expert review. |
| F5 | Model-family entanglement graph | Check whether four supposed jurors are secretly making the same mistakes. | Are cross-model agreements independent evidence, or synchronized failures caused by shared data, distillation, or alignment? | Repeated outputs from many items; black-box statistical analysis. |
| F6 | Disagreement-aware human evaluation | Treat reviewer disagreement as information instead of deleting it with majority vote. | Which passages are inherently ambiguous, which reviewers are reliable for which distinctions, and how stable are model rankings? | Multiple domain reviewers and a probabilistic annotation model. |
| F7 | Executable interpretation programs | Make the model write a tiny auditable recipe—quote, contrast, qualify, synthesize—before writing its interpretation. | Can an executable operation graph improve fine-grained attribution and make synthesis locally repairable? | Agent/program runner, typed operations, exact provenance. |
| F8 | Interpretive-lens activation vectors | Find an internal slider for an interpretive tendency and move it without prompting or retraining. | Can open models expose controllable latent directions for textual literalism, synthesis, uncertainty, or deference to context? | Open weights, GPUs, expert-defined traits, causal interventions. Do not equate a vector with a real tradition. |
| F9 | Sparse cross-architecture model diffing | Translate the internal feature dictionaries of two different models and find what one has that the other lacks. | Which model-specific latent features predict reproducible interpretation differences? | Open models, crosscoders/SAEs, aligned activations, strong causal validation. |
| F10 | Latent-reasoning microscope | Inspect and intervene on hidden continuous reasoning states rather than trusting visible chain-of-thought. | Do latent reasoning states encode interpretive decisions, and can controlled interventions change those decisions predictably? | Models supporting latent/recurrent reasoning plus structural, causal, and geometric probes. |
| F11 | Failure-attributed agentic scholar | When a research agent fails, identify the decisive bad step and roll back there. | Can a multi-stage retrieve–compare–verify system localize errors with calibrated coverage instead of restarting or trusting self-critique? | Typed trajectories, failure taxonomy, conformal error sets, rollback. |
| F12 | Pluralistic post-training | Train a small open model to cover several reviewed human perspectives without collapsing them into one average answer. | Can reinforcement or preference optimization improve both authentic perspective coverage and uniqueness? | Rights-cleared expert data, open model, reward validation, substantial compute. |
| F13 | Dynamic causal InterpretBench | Generate fresh, hidden interventions and track models across time. | Can a benchmark remain contamination-resistant and measure model × context × compute × lens × version interactions with disagreement-aware scoring? | All prior components, held-out generators, external review, ongoing governance. |

### Best first frontier experiment — Causal Model Diffing

Use a fractional-factorial pilot instead of a giant undifferentiated generation dump. For a reviewed set of passages, manipulate:

- **model**: the four already selected V4 families;
- **context intervention**: original evidence, evidence ablated, evidence repositioned among distractors, and a clearly labelled counterfactual packet;
- **inference regime**: direct response versus controlled extra compute through multiple samples or a revision turn;
- **repeat**: independent runs to estimate randomness;
- **version/time**: immutable model IDs now, followed by the same canary suite later.

The unit of analysis is an atomic claim. A mixed-effects or hierarchical model then estimates how much variance comes from model identity, context intervention, inference regime, passage, and their interactions.

ELI5: **change one ingredient at a time, then see which ingredient changed the answer.** That is much closer to a current research project than placing four chatbot responses in columns.

An initial `24 passages × 4 models × 4 context interventions × 2 inference regimes × 3 repeats = 2,304`-run design is large enough to expose interactions while remaining a separately cost-gated pilot. The exact power calculation and fractional design must be fixed before any calls are authorized.

### Frontier Papers With Code source map

All entries below were inspected through the live `pwc` catalog; the paper year is intentionally 2025 or 2026.

| Frontier component | Current source | Reusable idea |
|---|---|---|
| Automated model comparison | [BehaviorBox (2506.02204)](https://paperswithcode.co/paper/2506.02204) | Discover coherent fine-grained contexts where models differ instead of relying on corpus-level averages. [Code](https://github.com/lindiatjuatja/behaviorbox) |
| Test-time scaling | [s1: Simple Test-Time Scaling (2501.19393)](https://paperswithcode.co/paper/2501.19393) and [3D Test-Time Scaling (2511.15738)](https://paperswithcode.co/paper/2511.15738) | Treat context length, parallel samples, and revision turns as separate compute axes. [s1 code](https://github.com/simplescaling/s1) |
| Causal context attribution | [ARC-JSD (2505.16415)](https://paperswithcode.co/paper/2505.16415), [SelfCite (2502.09604)](https://paperswithcode.co/paper/2502.09604), and [AttnTrace (2508.03793)](https://paperswithcode.co/paper/2508.03793) | Use removal/retention interventions or internal traces to find context that actually contributes to a response. [ARC-JSD code](https://github.com/ruizheliuoa/arc_jsd), [SelfCite code](https://github.com/facebookresearch/selfcite), [AttnTrace code](https://github.com/Wang-Yanting/AttnTrace) |
| Reasoning faithfulness | [RFEval (2602.17053)](https://paperswithcode.co/paper/2602.17053) and [Inference Scaling and Reasoning Faithfulness (2601.06423)](https://paperswithcode.co/paper/2601.06423) | Separate accuracy from stance consistency and causal influence; extra inference compute can affect models differently. |
| Model independence | [How Independent Are LLMs? (2604.07650)](https://paperswithcode.co/paper/2604.07650) | Measure synchronized failures and reweight verifier ensembles rather than counting model votes equally. |
| Disagreement-aware evaluation | [STABLEVAL (2605.02122)](https://paperswithcode.co/paper/2605.02122) | Model item ambiguity and reviewer-specific confusion; optimize ranking stability rather than erase disagreement. |
| Executable provenance | [GenerationPrograms (2506.14580)](https://paperswithcode.co/paper/2506.14580) and [LAQuer (2506.01187)](https://paperswithcode.co/paper/2506.01187) | Generate via explicit text operations and support user-selected claims with localized source spans. [GenerationPrograms code](https://github.com/meetdavidwan/generationprograms), [LAQuer code](https://github.com/eranhirs/LAQuer) |
| Activation-level traits | [Persona Vectors (2507.21509)](https://paperswithcode.co/paper/2507.21509) | Automatically identify and causally steer latent behavior directions. [Code](https://github.com/safety-research/persona_vectors) |
| Cross-model latent differences | [Cross-Architecture Model Diffing with Crosscoders (2602.11729)](https://paperswithcode.co/paper/2602.11729) | Discover features unique to one architecture and connect them to reproducible behavior. |
| Latent reasoning intervention | [Unlocking the Black Box of Latent Reasoning (2606.01243)](https://paperswithcode.co/paper/2606.01243) | Probe hidden reasoning geometrically and causally, then intervene at decode time. |
| Agent failure science | [Why Do Multi-Agent LLM Systems Fail? (2503.13657)](https://paperswithcode.co/paper/2503.13657) and [Conformal Agent Error Attribution (2605.06788)](https://paperswithcode.co/paper/2605.06788) | Use an explicit failure taxonomy and finite-sample error-location sets for rollback. [Failure taxonomy code](https://github.com/multi-agent-systems-failure-taxonomy/masft), [conformal attribution code](https://github.com/layer6ai-labs/conformal-agent-error-attribution) |
| Pluralistic post-training | [Overton Pluralistic RL (2602.20759)](https://paperswithcode.co/paper/2602.20759) | Optimize coverage and uniqueness of multiple authentic perspectives rather than majority imitation. |

## Foundation-model baseline ladder (supporting, mostly 2023–2024 methods)

These projects are ordered so that each level fixes a weakness in the previous one. The distinction is important:

- **variation**: one model gives different answers on repeat runs;
- **difference**: two answers emphasize different things but can both be compatible;
- **disagreement**: two answers make claims that cannot both be true in the same sense;
- **coverage**: an answer may be reasonable yet omit a legitimate human interpretation;
- **grounding**: an answer may sound good but have no support in the supplied sources.

| Level | Project | ELI5 version | What makes it modern | Honest output |
|---:|---|---|---|---|
| M0 | Reproducible model observatory | Build a laboratory notebook before doing the experiment. | Frozen prompts, exact model/provider versions, context packets, sampling settings, costs, timestamps, raw outputs, and hashes. | A rerunnable experiment ledger, not a chatbot screenshot. |
| M1 | Side-by-side interpretation diff | Ask four readers the same question and highlight where their answers look different. | Multi-model inference and interactive comparison. | A useful viewer, explicitly labelled as a **wording diff**, not proof of disagreement. |
| M2 | Same-model stability and semantic uncertainty | Ask the same reader several times to see whether it changes its own mind. | Meaning-clustered repeated generations and semantic entropy rather than token probability alone. | Per-question stability, meaning clusters, and an "unstable" flag. |
| M3 | Claim-level model-to-model difference | Cut each essay into small claims, match equivalent claims, and find shared, unique, or conflicting claims. | Structured output, embeddings/NLI, calibrated abstention, and human adjudication. | A claim matrix with `shared`, `unique`, `conflicting`, and `unclear`; never a single doctrine score. |
| M4 | Context-sensitivity atlas | Give each reader one page, a chapter, or the whole book and see what changes. | Controlled long-context experiments, position shuffling, context-versus-prior analysis, and lost-in-the-middle tests. | A map of claims added, removed, or reversed by context. |
| M5 | Citation-grounded interpretation lab | Require every important statement to show its receipt. | Attributed generation, RAG, exact evidence spans, citation recall/precision, and abstention. | Claim-to-source links plus unsupported-claim and missing-evidence flags. |
| M6 | Human-perspective coverage benchmark | Compare the AI panel with the range of human witnesses instead of choosing one human answer key. | Pluralistic evaluation: Overton coverage, steerability, omission, and homogenization. | Which reviewed perspectives appear, disappear, or get merged; frequency is not treated as truth. |
| M7 | Judge-the-judges | Test whether the referee likes confident or fancy prose more than good evidence. | Swapped answer order, style-preserving/content-preserving perturbations, multiple judges, and blinded human calibration. | Bias and reliability profiles for each automated judge. |
| M8 | Disagreement-aware verifier and router | When the readers disagree, call for more evidence or a human instead of guessing. | Cross-model perplexity/entropy, verifier ensembles, selective prediction, and calibrated routing. | Risk scores and actions such as answer, retrieve more, show plurality, or defer. |
| M9 | Behavioral fingerprint and model-drift tracker | Repeat the same eye exam after a model update and record what changed. | Diagnostic prompt suites, change-point analysis, dated API snapshots, and model-family comparison. | Version-to-version drift in claims, citations, refusals, sensitivity, and stability. |
| M10 | Evidence-first multi-model panel | Let models propose and criticize claims, but make a source-backed table before writing prose. | Multi-agent orchestration with explicit roles, adversarial checking, and failure tracing. | A provenance-bearing claim table and a synthesis generated only from that table. |
| M11 | Open-weight internal model diffing | Open the machines and look for internal switches associated with different readings. | Activation probes, crosscoders, representation comparison, and causal interventions. | Behavioral findings linked cautiously to model features; closed APIs are out of scope. |
| M12 | OpenArtha InterpretBench | Turn the whole laboratory into a public exam with hidden questions and human baselines. | A longitudinal, multi-model, multi-context benchmark for semantic uncertainty, pluralism, grounding, and drift. | Frozen test sets, raw receipts, confidence intervals, human adjudication, and reproducible scoring. |

### Baseline infrastructure package: OpenArtha Interpretation Observatory

If the frontier experiment is authorized, **M0–M4 remain its measurement infrastructure**. Do not execute all 8,400 V4 calls immediately.

Suggested pilot:

- select 50 passages using a documented mix of chapters, lengths, themes, and known interpretive difficulty;
- use the four V4 model families and the three already planned contexts: passage, chapter, and complete work;
- collect three independent generations per cell so within-model instability is measurable: `50 × 4 × 3 × 3 = 1,800` outputs;
- randomize output order and hide model identity during human review;
- extract atomic claims, but retain the untouched raw answer;
- annotate a stratified subset for claim equivalence, compatible difference, contradiction, unsupported claim, and unclear/not-comparable;
- report results per passage, model, context, and repeat rather than declaring an overall "best interpreter."

The ELI5 idea is: **before saying Alice and Bob disagree, first check whether Alice tells the same story twice; then check whether Bob merely used different words; then show the exact sentence or source that supports each claim.**

This pilot does not alter the existing V4 authorization gate. API execution and cost still require separate explicit approval.

### How to compute a model-to-model interpretation diff

```text
same passage + same prompt + controlled context
  -> several answers from each model
  -> split each answer into small claims
  -> group claims that mean the same thing
  -> label each cross-model relation
       shared / compatible-but-different / conflicting / unique / unclear
  -> attach source evidence where available
  -> human-check a representative sample
```

Do not use edit distance as the result: two sentences can use different words and mean the same thing. Do not use embedding distance as the result either: nearby vectors do not prove agreement. Embeddings can propose pairs; an NLI-style model, evidence checks, and humans must decide the research labels.

Useful measures:

- **self-stability**: how often one model returns the same meaning across repeats;
- **pairwise semantic overlap**: proportion of matched claims shared by two models;
- **unique-claim rate**: supported claims introduced by only one model;
- **conflict rate**: adjudicated incompatible claim pairs;
- **context flip rate**: claims added, removed, or reversed after more context;
- **evidence coverage**: important claims supported by an exact corpus span;
- **perspective coverage**: reviewed human positions represented without being collapsed together;
- **abstention quality**: whether the system says "unclear" when comparison is genuinely ambiguous.

## Baseline Papers With Code source map (mostly 2023–2024 ancestry)

These are live catalog results inspected with the repository's `pwc` CLI, including paper metadata, resources, related work, and—where useful—the paper text. Papers With Code is a discovery catalog; the paper and repository remain the primary evidence.

| Research idea | Source and reusable lesson | Public implementation found by `pwc` |
|---|---|---|
| Same-model semantic uncertainty | [Semantic Uncertainty (2302.09664)](https://paperswithcode.co/paper/2302.09664): cluster generations by meaning before measuring entropy; different wording is not automatically a different answer. | [semantic_uncertainty](https://github.com/lorenzkuhn/semantic_uncertainty) |
| Black-box uncertainty extension | [Generating with Confidence (2305.19187)](https://paperswithcode.co/paper/2305.19187): a related-work route for uncertainty when token probabilities or model internals are unavailable. | Inspect per experiment; catalog search found the paper through Semantic Uncertainty's related work. |
| Cross-model disagreement | [Cross-Model Disagreement as a Label-Free Correctness Signal (2603.25450)](https://paperswithcode.co/paper/2603.25450): a second model can supply a useful correctness/uncertainty signal through cross-model perplexity or entropy. | No catalog-linked code yet; treat as a research lead, not a drop-in package. |
| Context versus prior | [Controllable Context Sensitivity (2411.07404)](https://paperswithcode.co/paper/2411.07404): models trade off supplied context against prior knowledge, and that sensitivity can be measured. | [context-vs-prior-finetuning](https://github.com/kdu4108/context-vs-prior-finetuning) |
| Long-context position effects | [Lost in the Middle (2307.03172)](https://paperswithcode.co/paper/2307.03172): relevant evidence is often used less reliably when placed in the middle of a long context. | [lost-in-the-middle](https://github.com/nelson-liu/lost-in-the-middle) |
| Citation-grounded generation | [ALCE (2305.14627)](https://paperswithcode.co/paper/2305.14627): score citation correctness and completeness separately from fluent answer quality. | [ALCE](https://github.com/princeton-nlp/ALCE) |
| RAG evaluation | [ARES (2311.09476)](https://paperswithcode.co/paper/2311.09476) and [RAGAS (2309.15217)](https://paperswithcode.co/paper/2309.15217): separate context relevance, answer faithfulness, and answer relevance. | [ARES](https://github.com/stanford-futuredata/ares), [RAGAS](https://github.com/explodinggradients/ragas) |
| Pluralistic evaluation | [A Roadmap to Pluralistic Alignment (2402.05070)](https://paperswithcode.co/paper/2402.05070): distinguish Overton coverage, steerability, and distributional representation. | [ai_pluralistic_alignment](https://github.com/jfisher52/ai_pluralistic_alignment) |
| Multi-model pluralism | [Modular Pluralism (2406.15951)](https://paperswithcode.co/paper/2406.15951): use multiple models to preserve a range of positions rather than forcing one averaged response. | [modular_pluralism](https://github.com/BunsenFeng/modular_pluralism) |
| Measuring whose views a model resembles | [Subjective Global Opinions (2306.16388)](https://paperswithcode.co/paper/2306.16388): measure similarity to different human response groups and watch for prompted stereotypes. | The catalog links [CultureBank](https://github.com/salt-nlp/culturebank); verify task fit before reuse. |
| Automated judge bias | [Judging LLM-as-a-Judge (2306.05685)](https://paperswithcode.co/paper/2306.05685) and [Style Outweighs Substance (2409.15268)](https://paperswithcode.co/paper/2409.15268): judges exhibit position, verbosity, self-preference, and style biases. | [FastChat](https://github.com/lm-sys/FastChat), [SOS-Bench](https://github.com/penfever/sos-bench) |
| Behavioral fingerprinting | [Behavioral Fingerprinting of LLMs (2509.04504)](https://paperswithcode.co/paper/2509.04504): a fixed diagnostic suite can reveal model differences hidden by aggregate capability scores. | [Behavioral-Fingerprinting](https://github.com/JarvisPei/Behavioral-Fingerprinting) |
| Model drift | [How Is ChatGPT's Behavior Changing over Time? (2307.09009)](https://paperswithcode.co/paper/2307.09009): hosted-model behavior can change enough that continuous, dated monitoring is necessary. | [llmdrift](https://github.com/lchen001/llmdrift) |
| Internal model diffing | [Cross-Architecture Model Diffing with Crosscoders (2602.11729)](https://paperswithcode.co/paper/2602.11729): compare model-specific representation features after behavioral differences are established. | No catalog-linked implementation yet; only feasible for open-weight models. |

The most directly reusable chain is **Semantic Uncertainty → claim-level cross-model disagreement → context sensitivity → ALCE/ARES grounding → pluralistic evaluation → judge-bias checks**. Internal model diffing is exciting, but it belongs near the end because OpenArtha's planned V4 models are closed APIs and expose no activations.

## Supporting corpus-ML ladder (secondary)

| Level | Project | ELI5 version | Main result | Honest success test |
|---:|---|---|---|---|
| 0 | ML-ready corpus and splits | Put every card in the correct train, practice, or final-exam box. | Versioned Parquet/JSONL views, leakage-safe splits, dataset card, reproducible baselines. | A checksum-pinned build recreates every split; all records for one canonical verse stay in one fold. |
| 1 | Commentary fingerprint | Guess which shelf a paragraph came from by its writing fingerprints. | Edition/author classifier and stylometry report. | Macro-F1 on held-out chapters, compared with character n-gram logistic regression. |
| 2 | Topic atlas | Ask a machine to sort explanations into unnamed idea buckets. | Per-language topic clusters with representative source excerpts. | Human coherence judgments plus cluster stability across seeds/models. |
| 3 | Related-passage finder | Recommend verses the way a music app recommends similar songs. | "Related passages" with an explanation and exact evidence. | Recall/nDCG on a small, doubly reviewed set of related/unrelated passage pairs. |
| 4 | Alignment watchdog | A smoke alarm for commentary filed under the wrong verse. | A review queue with confidence, expected verse, strongest alternative, and evidence. | Precision among the top flagged records on expert-reviewed alignments; never auto-correct. |
| 5 | Hybrid multilingual semantic search | Find the idea even when the reader does not type the exact word or language. | FTS5 + multilingual embedding retrieval + reranking. | Recall@k, MRR, and nDCG on human relevance judgments in English, Hindi, Sanskrit, and transliterated queries. |
| 6 | Sanskrit word microscope | Break a joined Sanskrit expression into pieces and show how translations render each piece. | Word segmentation, morphology, compound analysis, and source-to-translation word links. | Perfect-match segmentation, token F1, morphological F1, and alignment error rate on expert annotation. |
| 7 | Interpretation map | Put similar explanations near one another without claiming that distance equals doctrine. | Verse-conditioned clusters and author/edition comparison maps. | Expert pair labels for similar, distinct, and not-comparable interpretations; calibrated uncertainty. |
| 8 | Citation-first curator | A librarian answers, shows the exact shelf and passage, and says "I don't know" when the library lacks the answer. | Corpus-bound question answering with passage-level citations and abstention. | Retrieval recall, answer correctness, citation precision/recall, entailment, and abstention accuracy. |
| 9 | Comparative synthesis engine | A careful panel moderator says who agrees on what, who differs, and where each statement came from. | Claim/evidence tables followed by a cited synthesis across selected witnesses. | Every atomic claim is supported by the cited text; scholars rate coverage, neutrality, and distinction preservation. |
| 10 | Domain translation laboratory | Teach an existing translator the vocabulary of this library without letting it invent scripture. | Evaluated Sanskrit/Hindi/English translation adapters and quality-estimation models. | Blind expert review, chrF/COMET-style metrics, terminology accuracy, and verse-held-out tests. |
| 11 | Provenance-aware concept and claim graph | Turn the library into a subway map of concepts, claims, authors, passages, and evidence. | Human-governed ontology plus extracted, sourced, uncertainty-bearing claims. | Entity/relation F1, evidence-span accuracy, inter-annotator agreement, and zero unsupported public edges. |
| 12 | OpenArtha Bench and model laboratory | Give several models the same closed-book and open-book exams, then keep the receipts. | Public benchmark for retrieval, alignment, citation, synthesis, multilinguality, and context sensitivity. | Frozen test sets, blind evaluation, reproducible prompts/configs, confidence intervals, error taxonomy, and human baselines. |

## Supporting project details

### Level 0 — ML-ready corpus and splits

This is the non-negotiable foundation rather than a product feature.

Build:

- one immutable experiment manifest pinning the root corpus version, commentary version, source commit, input checksums, code commit, normalization, and licenses;
- tabular views for passages, commentary units, editions, and aligned passage-edition pairs;
- group-based folds where every representation and commentary for the same `canonicalRef` stays together;
- leave-one-chapter-out evaluation where appropriate;
- a small manually verified gold subset kept separate from the machine-aligned training pool;
- deterministic baseline scripts and machine-readable metrics.

Why the split matters: if one author's explanation of verse 2.47 is in training and another author's explanation of the same verse is in testing, a model can memorize the verse topic and appear smarter than it is.

### Level 1 — Commentary fingerprint

Start with separate experiments by language and content type. Predict `editionId` first; use `authorId` only where the registry's authorship and edition identity have been human-verified.

Baselines:

1. majority class;
2. character n-gram TF-IDF + logistic regression;
3. word n-gram linear model;
4. frozen multilingual embeddings + linear classifier;
5. optional small fine-tuned encoder.

Research questions:

- Can style survive when topic is controlled by holding out whole chapters?
- Does a model identify an author, a translator, a language, or formatting artifacts?
- Which phrases or characters drive a prediction?

This is useful as a data-audit tool even if it never becomes a reader feature. Unexpectedly easy classification may reveal headers, verse numbers, boilerplate, or edition-specific normalization leaks.

Papers With Code starting points: [Authorship Attribution](https://paperswithcode.com/task/authorship-attribution) and [Authorship Verification](https://paperswithcode.com/task/authorship-verification).

### Level 2 — Topic atlas

Run this per language before attempting a shared multilingual topic space. Keep verse text, translation, and commentary as different views rather than mixing everything into one bag.

Build:

- document embeddings for commentary units or bounded chunks;
- HDBSCAN/k-means and c-TF-IDF/keyword descriptions;
- representative passages and source links for every topic;
- cluster stability and outlier reports;
- human-written labels only after reviewers inspect examples.

Do not publish automatically generated topic names as scholarly facts.

Papers With Code starting points: [Topic Models](https://paperswithcode.com/task/topic-models), [BERTopic](https://paperswithcode.com/paper/bertopic-neural-topic-modeling-with-a-class), and [Text Clustering](https://paperswithcode.com/task/text-clustering).

### Level 3 — Related-passage finder

Embed each verse using several controlled representations:

- Sanskrit only;
- provisional English only;
- Sanskrit plus English;
- a pooled summary of translations;
- source text plus commentary, tested separately to measure commentary leakage.

Return the nearest passages with a visible reason such as overlapping source terms, shared embedding neighborhood, or a human-reviewed relation. Do not imply a traditional cross-reference unless a source says so.

Papers With Code starting points: [Sentence-BERT](https://paperswithcode.com/paper/sentence-bert-sentence-embeddings-using), [Semantic Textual Similarity](https://paperswithcode.com/task/semantic-textual-similarity), and [Language-agnostic BERT Sentence Embedding](https://paperswithcode.com/paper/language-agnostic-bert-sentence-embedding).

### Level 4 — Alignment watchdog

For each commentary record, compare the record with:

- its assigned root verse;
- adjacent verses;
- all verses in the same chapter;
- the top candidate verses in the whole work;
- other translations/commentaries already attached to each candidate.

Useful signals:

- multilingual embedding similarity;
- named entities and distinctive terms;
- chapter/verse numbers accidentally preserved in the content;
- agreement among several independent edition views;
- abrupt sequence discontinuities;
- known alignment exceptions such as the alternate Chapter 13 opening and the Prabhupada Chapter 1 span.

Output a suspicion score and evidence. Humans accept, reject, or defer the flag. Reviewer decisions become the first trustworthy supervised alignment set.

Evaluation must measure precision in the top review queue, because reviewer time—not overall accuracy—is the scarce resource.

Papers With Code starting points: [Language-agnostic BERT Sentence Embedding](https://paperswithcode.com/paper/language-agnostic-bert-sentence-embedding), [Unsupervised Dense Information Retrieval with Contrastive Learning](https://paperswithcode.com/paper/towards-unsupervised-dense-information), and [Word Alignment](https://paperswithcode.com/task/word-alignment).

### Level 5 — Hybrid multilingual semantic search

Keep the current lexical engine as a baseline and precision signal. Add:

1. lexical retrieval from root text and commentaries;
2. multilingual dense retrieval;
3. reciprocal-rank or learned fusion;
4. a cross-encoder reranker over the top candidates;
5. exact highlighted evidence and source metadata;
6. query-language detection only as a convenience, never as a hidden filter.

Build a relevance set before tuning. A reasonable first target is 300–500 natural questions and concepts, each judged against pooled results from lexical and several semantic systems. Include spelling variants, IAST, Devanagari, Hindi, and cross-language queries.

Papers With Code starting points: [Passage Retrieval](https://paperswithcode.com/task/passage-retrieval), [Dense Passage Retrieval](https://paperswithcode.com/paper/dense-passage-retrieval-for-open-domain), [Passage Re-ranking](https://paperswithcode.com/task/passage-re-ranking), [Cross-Lingual Information Retrieval](https://paperswithcode.com/task/cross-lingual-information-retrieval), and [Contriever](https://paperswithcode.com/paper/towards-unsupervised-dense-information).

### Level 6 — Sanskrit word microscope

This project adds linguistic structure rather than generative prose.

Build:

- Sanskrit word segmentation that accounts for sandhi;
- lemma and morphological tags;
- compound candidates/types;
- alignment from Sanskrit tokens or compounds to phrases in each translation;
- a reader view that presents model suggestions separately from reviewed analysis.

OpenArtha alone does not contain token-level gold labels. Import compatible, properly licensed Sanskrit treebanks/benchmarks and create an expert-reviewed Gita evaluation set. Never treat the IAST string as a second independent Sanskrit witness; it is another representation.

Papers With Code starting points: [TransLIST](https://paperswithcode.com/paper/translist-a-transformer-based-linguistically), [SanskritShala](https://paperswithcode.com/paper/sanskritshala-a-neural-sanskrit-nlp-toolkit), and [Word Alignment](https://paperswithcode.com/task/word-alignment).

### Level 7 — Interpretation map

The basic unit is not "author A versus author B." It is a pair of bounded claims or excerpts conditioned on the same passage.

Start with three conservative labels:

- meaningfully similar;
- meaningfully distinct;
- not comparable or insufficient context.

Add agreement/disagreement only after scholars define a usable annotation guide and reach acceptable inter-annotator agreement. Train and compare embedding similarity, pair classifiers, and cross-lingual NLI, but keep the human labels primary.

Papers With Code starting points: [Natural Language Inference](https://paperswithcode.com/task/natural-language-inference), [Cross-Lingual Natural Language Inference](https://paperswithcode.com/task/cross-lingual-natural-language-inference), and [Semantic Textual Similarity](https://paperswithcode.com/task/semantic-textual-similarity).

### Level 8 — Citation-first curator

This is the repository's planned V3 direction, but a trustworthy version requires an evaluation project before a chat interface.

Pipeline:

```text
question
  -> hybrid retriever
  -> reranker
  -> bounded source packets
  -> answer or abstain
  -> citations to exact passage/commentary IDs
  -> automatic and human verification
```

Every answer should distinguish root text, provisional translation, historical commentary, and model synthesis. Citations must point to immutable versioned records and checksums, not merely a page that can change.

Build adversarial tests for unanswerable questions, false premises, cherry-picked witnesses, quotation errors, and requests to collapse multiple traditions into one definitive view.

Papers With Code starting points: [Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://paperswithcode.com/paper/retrieval-augmented-generation-for-knowledge), [Open-Domain Question Answering](https://paperswithcode.com/task/open-domain-question-answering), [Fact Verification](https://paperswithcode.com/task/fact-verification), and [Evidence Selection](https://paperswithcode.com/task/evidence-selection).

For citation-specific evaluation, add ALCE's citation precision/recall ideas: [Papers With Code dataset](https://paperswithcode.com/dataset/alce), [paper](https://arxiv.org/abs/2305.14627), and [code](https://github.com/princeton-nlp/ALCE).

### Level 9 — Comparative synthesis engine

Do not ask a model to summarize 29 long witnesses in one pass. Use an auditable intermediate representation:

1. retrieve the selected witnesses for one bounded question and passage range;
2. extract atomic claims with exact evidence spans;
3. cluster only comparable claims;
4. label agreement/difference/uncertainty with calibrated confidence;
5. generate prose from the claim table;
6. verify every sentence against its cited spans;
7. expose the table next to the prose.

Measure factual consistency separately from prose quality. A fluent synthesis with a wrong attribution is a failed result.

Papers With Code starting points: [Multi-Document Summarization](https://paperswithcode.com/task/multi-document-summarization), [QAFactEval](https://paperswithcode.com/paper/qafacteval-improved-qa-based-factual), [Natural Language Inference](https://paperswithcode.com/task/natural-language-inference), and [Fact Verification](https://paperswithcode.com/task/fact-verification).

### Level 10 — Domain translation laboratory

Use an existing multilingual/Indic translation model and train small adapters or rerank candidates. Do not train a translation model from the 700 verses alone.

Potential experiments:

- Sanskrit-to-English and Sanskrit-to-Hindi terminology adaptation;
- translation quality estimation without a gold reference;
- compare how much commentary context helps or distorts a verse translation;
- terminology-constrained decoding for named concepts;
- detect when a translation is actually interpretive commentary.

The 29 fields are not 29 interchangeable translations: many are commentaries, and editions may contain source-specific wording. Training pairs must be selected by `contentType`, language, rights, and human-verified alignment.

Papers With Code starting points: [IndicTrans2](https://paperswithcode.com/paper/indictrans2-towards-high-quality-and), [Low-Resource Neural Machine Translation](https://paperswithcode.com/task/low-resource-neural-machine-translation), and [NMT](https://paperswithcode.com/task/nmt).

### Level 11 — Provenance-aware concept and claim graph

Define a small ontology with scholars before training extraction models. A graph edge must carry:

- subject, relation, and object;
- exact evidence anchor;
- asserting witness/edition;
- source and immutable revision;
- confidence and review state;
- scope and negation;
- competing or alternative assertions.

This must fit the generalized corpus model's assertion/anchor architecture. It must not flatten "commentator X asserts Y" into "OpenArtha says Y is true."

Papers With Code starting points: [Relation Extraction](https://paperswithcode.com/task/relation-extraction), [Joint Entity and Relation Extraction](https://paperswithcode.com/task/joint-entity-and-relation-extraction), [Document-level Relation Extraction](https://paperswithcode.com/task/document-level-relation-extraction), and [Knowledge Graphs](https://paperswithcode.com/task/knowledge-graphs).

### Level 12 — OpenArtha Bench and model laboratory

Unify the earlier gold sets into a public evaluation suite:

- `OA-Align`: correct, incorrect, partial, ambiguous, and paratext alignments;
- `OA-Retrieve`: multilingual queries with pooled relevance judgments;
- `OA-Relate`: reviewed passage-similarity and cross-reference pairs;
- `OA-Lex`: Sanskrit segmentation, morphology, compounds, and translation links;
- `OA-Perspectives`: paired claims with similarity/difference/not-comparable labels;
- `OA-CiteQA`: answerable and unanswerable questions with complete evidence sets;
- `OA-Synthesis`: comparative claim tables and citation-complete reference syntheses.

The repository's V4 comparative model experiment can sit on top of this suite. Its four-model, three-context design remains separately gated by explicit authorization and manual cost approval. Preserve raw outputs, prompts, provider/model identifiers, parameters, token use, cost, timestamps, response hashes, randomized display order, and human judgments.

This is the most publishable project, but it should be the last rather than the first: a benchmark built before annotation rules and smaller task pilots will encode avoidable mistakes.

## Recommended execution sequence

### Milestone A — black-box causal pilot

1. Freeze the claim schema, selected passages, model versions, prompts, and intervention matrix.
2. Perform a power analysis and choose a fractional design before spending on calls.
3. Run F1–F4 only after the existing V4 cost gate is explicitly approved.
4. Estimate main effects and interactions for model, context intervention, inference regime, and repeat.

Exit condition: every reported difference has uncertainty, raw receipts, a predefined analysis, and evidence that it exceeds same-model randomness.

### Milestone B — independence and evaluation

1. Build F5's behavioral-entanglement graph from correlated successes and failures.
2. Collect multiple blinded expert judgments and fit F6's disagreement-aware evaluation model.
3. Compare majority vote, equal-weight model ensembles, and independence-weighted ensembles.

Exit condition: apparent consensus is not counted as independent confirmation, and rankings remain stable across plausible reviewer subsets.

### Milestone C — auditable generation and open-model interventions

1. Build F7 typed interpretation programs and localized evidence queries.
2. Select rights-compatible open models for F8–F10.
3. Require causal interventions, not only probe accuracy, before naming a latent feature.

Exit condition: source operations can be replayed, localized claims can be repaired, and internal-feature claims predict controlled behavioral changes on held-out passages.

### Milestone D — agents, post-training, and benchmark

1. Build F11 only after a single-agent executable pipeline is a strong baseline.
2. Attempt F12 only with rights-cleared, expert-reviewed pluralistic targets and independently validated rewards.
3. Freeze F13 only after external review; keep generating hidden counterfactual items over time.

Exit condition: the benchmark can be rerun independently, reports annotator disagreement and model entanglement, keeps historical sources separate from generated outputs, and has a public limitations/rights statement.

## Shared engineering shape

Keep model experimentation outside the request path at first:

```text
versioned OpenArtha exports
  -> offline experiment build
  -> immutable embeddings/predictions/evidence
  -> evaluation report
  -> reviewed derived artifact
  -> optional read-only product integration
```

Suggested artifact boundaries:

- `datasets/` or an external release bucket for checksum-pinned training/evaluation views;
- `experiments/<project>/<run-id>/manifest.json` for config, code/data hashes, metrics, and environment;
- separate tables for model proposals, human reviews, and accepted scholarly assertions;
- no silent replacement of existing passage/commentary text;
- no provider keys, private conversations, or unreviewed generated outputs in the corpus.

Cloudflare D1 can continue serving compact lexical and reviewed result tables. Embedding generation, reranker training, and evaluation should run offline. A production vector service is a later architecture and cost decision, not a prerequisite for the experiments.

## Minimum evaluation rules

Every project must:

1. compare against a cheap non-neural baseline;
2. group splits by canonical passage and, where useful, by chapter;
3. report per-language and per-content-type results, not only one aggregate number;
4. keep machine-aligned training labels distinct from human-verified evaluation labels;
5. preserve exact source IDs, locators, versions, checksums, and evidence spans;
6. report uncertainty and common error classes;
7. avoid LLM-as-judge as the only evaluation;
8. document model, dataset, and output rights;
9. keep generated analysis visibly separate from historical source text;
10. publish negative results when semantic or generative methods fail to beat lexical/extractive baselines;
11. measure repeat-run variation before attributing a difference to model identity;
12. report results per model, model version, context, prompt, language, and sampling configuration;
13. randomize and blind output identity wherever human comparison permits;
14. never let the same model be the sole generator, annotator, judge, and final authority;
15. distinguish unsupported, different, contradictory, and not-comparable outputs.

## Papers With Code CLI queries used for this revision

The modern source map came from direct catalog searches with the repository's installed `pwc` CLI:

```bash
pwc search "test-time scaling" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "BehaviorBox" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "context attribution" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "reasoning faithfulness" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "persona vectors" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "model diffing" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "behavioral entanglement language models" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "disagreement-aware stable evaluation" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "latent reasoning" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "multi-agent systems fail" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "source attribution language model generation" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage
pwc search "overton pluralism language models" --mode keyword --start-date 2025-01-01 --limit 12 --implementation-coverage

# Older baselines and conceptual ancestry
pwc search "semantic uncertainty" --mode keyword --limit 10 --implementation-coverage
pwc search "model disagreement" --mode keyword --limit 10 --implementation-coverage
pwc search "pluralistic alignment" --mode keyword --limit 10 --implementation-coverage
pwc search "LLM as a judge" --mode keyword --limit 10 --implementation-coverage
pwc search "behavioral fingerprinting" --mode keyword --limit 10 --implementation-coverage
pwc search "model drift language models" --mode keyword --limit 10 --implementation-coverage
pwc search "context sensitivity language models" --mode keyword --limit 10 --implementation-coverage
pwc search "attributed question answering" --mode keyword --limit 10 --implementation-coverage
pwc search "citation grounded generation" --mode keyword --limit 10 --implementation-coverage
pwc search "model diffing" --mode keyword --limit 10 --implementation-coverage
pwc search "cultural perspectives language models" --mode keyword --limit 10 --implementation-coverage
pwc search "multi-perspective question answering" --mode keyword --limit 10 --implementation-coverage
```

Then inspect, rather than trusting the result title:

```bash
pwc paper info 2302.09664 --include-resources --include-evals
pwc paper read 2302.09664
pwc paper related 2302.09664 --limit 10
pwc paper lineage list 2302.09664
```

Repeat the last four commands for any selected paper ID. The catalog returned no predecessor/successor lineage entries for `2302.09664`, `2305.14627`, or `2402.05070`, so related-paper search was more useful than catalog lineage for this topic.

As of 2026-09-02, treat Papers With Code as a discovery map to papers and code—not as proof that a method works on interpretive texts, small multilingual corpora, or this dataset.

## Copy-paste queries for Trending Research

The current natural-language Trending Research interface can search much more effectively than isolated legacy task pages. These queries deliberately describe OpenArtha as a generic **small, versioned, multilingual corpus of primary passages with many aligned translations and commentaries**, rather than mentioning the Bhagavad Gita.

### Start with the research landscape

> Find papers with public code on machine learning for versioned multilingual primary-text corpora with multiple translations, commentaries, interpretations, or textual witnesses aligned to the same passages. Prefer work from 2021 onward in NLP, digital humanities, historical texts, legal texts, religious texts, classics, or other source-critical corpora. Group the results by retrieval, alignment, text analysis, generation, and evaluation. For each paper, report its data size, languages, supervision required, metrics, code repository, and the closest reusable idea for a small corpus.

### Retrieval and semantic search

> Find recent papers with code on hybrid lexical and dense retrieval for small domain-specific multilingual corpora. Prioritize cross-lingual query-to-passage retrieval, low-resource languages, transliterated text, metadata-aware retrieval, reranking, and methods that can be evaluated against BM25. Exclude papers whose only evidence is English web-scale retrieval.

> Find papers with code on multilingual sentence or passage embeddings that work across different scripts and low-resource languages. Compare zero-shot retrieval, contrastive fine-tuning, hard-negative mining, and late-interaction reranking. Report whether Sanskrit, Hindi, Indic languages, or comparable morphologically rich languages are included in training or evaluation.

### Alignment and corpus quality

> Find papers with code on detecting incorrect sentence, passage, verse, document, or translation alignments in multilingual parallel or comparable corpora. Include weakly supervised alignment, multilingual embeddings, sequence constraints, anomaly detection, hard-negative retrieval, confidence calibration, and human-in-the-loop review prioritization. Prefer methods evaluated by precision at the top of a review queue.

> Find papers with code on active learning for textual corpus correction where experts review only the most informative or suspicious examples. Focus on ranking annotation work, calibrated uncertainty, noisy labels, and small multilingual datasets.

### Related passages and intertextuality

> Find papers with code on semantic similarity, passage recommendation, intertextuality detection, quotation or allusion detection, and cross-document passage linking for literary, historical, legal, or scholarly texts. Prefer explainable systems that return evidence spans and distinguish model similarity from human-curated relationships.

### Topic and interpretation discovery

> Find papers with code on multilingual or cross-lingual topic modeling for corpora containing document metadata such as author, edition, language, date, and source passage. Compare classical topic models, contextualized topic models, and embedding clustering. Prioritize work that evaluates topic coherence, stability, and human interpretability on small or medium corpora.

> Find papers with code on comparing multiple interpretations of the same source passage. Search related tasks including stance detection, argument mining, natural language inference, semantic textual similarity, claim matching, perspective identification, and opinion or viewpoint summarization. Prefer research that allows neutral, unrelated, ambiguous, or not-comparable labels rather than forcing agreement versus disagreement.

### Authorship and style

> Find papers with code on authorship or edition attribution when topic is a confounder. Prioritize stylometry for historical or translated texts, cross-topic and cross-domain evaluation, character-level baselines, explainable features, short documents, and train/test splits that prevent topic leakage.

### Sanskrit and historical-language NLP

> Find papers with code on NLP for Sanskrit or comparable low-resource historical languages, especially word segmentation under sandhi, lemmatization, morphological tagging, compound analysis, dependency parsing, transliteration, word alignment, and semantic embeddings. Report available datasets, licenses, annotation schemes, metrics, model size, and whether inference can run locally.

> Find papers with code on adapting multilingual language models to historical languages or historical stages of a language with limited labeled data. Include continued pretraining, adapters or LoRA, multilingual transfer, character or byte models, lexicon-assisted models, and evaluation against non-neural baselines.

### Citation-first question answering

> Find papers with code on attributed question answering and citation-aware retrieval-augmented generation over a fixed, versioned corpus. Prioritize systems that cite exact passages, measure citation precision and recall, verify entailment, handle unanswerable questions, abstain, preserve document provenance, and separate retrieval errors from generation errors.

> Find papers with code that evaluate RAG on small specialized corpora rather than Wikipedia-scale open-domain QA. Compare lexical, dense, and hybrid retrieval; passage chunking; reranking; answer faithfulness; citation completeness; and abstention. Include benchmarks and evaluation code, not only frameworks.

### Comparative synthesis

> Find papers with code on multi-document or multi-perspective summarization where sources may disagree. Prefer claim-first or evidence-first pipelines, source attribution at sentence or claim level, factual-consistency evaluation, contradiction handling, viewpoint preservation, and datasets with human judgments. Exclude ordinary single-document news summarization unless the method explicitly handles provenance.

### Translation experiments

> Find papers with code on low-resource domain adaptation for machine translation among Sanskrit, Hindi, English, or comparable Indic and historical languages. Focus on adapter-based fine-tuning, terminology constraints, translation quality estimation, document or context-aware translation, small parallel corpora, and human evaluation. Exclude proposals to train a foundation translation model from scratch.

### Knowledge graphs and scholarly claims

> Find papers with code on provenance-aware knowledge graph construction from scholarly, historical, legal, or humanities texts. Prioritize joint entity and relation extraction, claim extraction, evidence-span grounding, uncertainty, negation, conflicting claims, source attribution, and human validation. Distinguish a source asserting a claim from the system asserting that the claim is true.

### Benchmark design

> Find papers with code on designing leakage-resistant NLP benchmarks from aligned, parallel, or multi-view documents. Focus on group-based splits, near-duplicate contamination, multilingual evaluation, expert annotation, inter-annotator agreement, retrieval pooling, adversarial unanswerable cases, confidence intervals, and reproducible versioned datasets.

### Compare selected papers with `@`

After selecting three to six promising papers, use:

> Compare @paper1 @paper2 @paper3 for a corpus with roughly 700 source passages and about 20,000 passage-aligned translations or commentaries across three languages. Which assumptions still hold at this scale? Compare required labels, risk of train/test leakage, multilingual and cross-script support, compute, code maturity, licenses, evaluation quality, and the smallest reproducible experiment. Recommend one baseline and one stronger method, and explain what human-reviewed gold data is still required.

Then pressure-test the recommendation:

> For @paper1, identify the strongest non-neural baseline, the exact train/dev/test splitting unit, all sources of label leakage or near-duplicate contamination, and which reported metrics would be misleading for passage-aligned multilingual commentaries. Propose a corrected evaluation protocol for a small versioned corpus.

For the frontier program, the best first six searches are: test-time scaling, causal context attribution, counterfactual reasoning faithfulness, model diffing, behavioral entanglement, and disagreement-aware evaluation. Semantic uncertainty, RAG, and ordinary LLM-as-judge work are supporting ancestry rather than the research destination.

## Decisions

- Make **causal model diffing**, not side-by-side model comparison, the primary research direction.
- Treat the previous M0–M4 Interpretation Observatory as measurement infrastructure and a baseline.
- Start with a cost-gated fractional-factorial F1–F4 pilot before scaling to the full V4 matrix.
- Prefer 2025–2026 intervention, attribution, entanglement, latent-diffing, and disagreement-aware methods over another generic RAG or multi-agent application.
- Estimate model, context, compute, passage, repeat, and version effects separately where the design permits.
- Measure same-model instability before claiming cross-model disagreement.
- Compare atomic claims, not whole-answer edit or embedding distance.
- Require causal behavioral change before treating a probe, SAE feature, crosscoder direction, or persona vector as an explanation.
- Use a strong single-agent executable baseline before authorizing multi-agent complexity.
- Treat pluralistic coverage and evidence support as separate from correctness.
- Calibrate automated judges against blind humans and explicit bias tests.
- Keep alignment triage and hybrid retrieval as prerequisites for grounded generative features.
- Use existing multilingual encoders and small adapters; do not train a foundation model from this corpus.
- Treat edition attribution, theological position, semantic similarity, and textual alignment as different tasks.
- Keep human review as the authority for corpus correction and scholarly claims.
- Keep V4 model-comparison costs and execution under their existing explicit authorization gate.

## Blockers

- Root text and commentary alignment gold standards do not yet exist at useful scale.
- Author, edition, and attribution review remains incomplete.
- Search relevance, related-passage, claim-pair, citation-QA, morphology, and translation gold sets require new annotation.
- Sanskrit and comparative-philosophy projects require domain experts, not only general NLP annotators.
- The four planned V4 closed models expose neither comparable internal activations nor perfectly comparable reasoning-budget controls.
- F8–F10 require separately selected open-weight models, sufficient accelerator access, and a causal-validation protocol.
- Counterfactual source packets must be unmistakably separated from canonical or historical text.
- Release and checkpoint rights must be assessed per source, model, and derived artifact.

## Completion state

- [x] Inspect current OpenArtha corpus, API, search, provenance, rights, and review state.
- [x] Search the live Papers With Code catalog with the project CLI.
- [x] Inspect metadata, implementations, paper text, related work, and available lineage for the principal sources.
- [x] Separate modern foundation-model projects from supporting corpus-ML projects.
- [x] Rank both project families by total scientific and product complexity.
- [x] Define a model-to-model interpretation-difference pilot aligned with the existing V4 design.
- [x] Reassess the roadmap against 2025–2026 Papers With Code results after the 2024-era critique.
- [x] Replace the primary recommendation with causal model diffing and a frontier intervention ladder.
- [x] Add current sources for test-time scaling, causal attribution, reasoning faithfulness, behavioral entanglement, stable evaluation, activation steering, latent model diffing, and conformal agent error attribution.
- [x] Define recommended sequencing, evaluation rules, and blockers.
- [ ] Select and authorize an implementation milestone.
- [ ] Write a project-specific execution plan after a milestone is selected.
