# B04 — Related-passage finder

Verdict: **GO**

Buildout: medium · Evidence yield: medium · New expert data: small passage-pair set

## Decision summary

Build and evaluate passage recommendations under several representations. The scientific question is not whether embeddings can return neighbors; it is which source view produces relationships that human reviewers find useful and what kinds of relationships are lost.

## Research question and hypotheses

- **H1:** a hybrid of lexical evidence and multilingual dense representations improves held-out nDCG over either alone.
- **H2:** adding commentary increases apparent relatedness but also introduces edition/topic leakage.
- Primary outcome: nDCG@10 on pooled, blinded human relevance judgments.

## Inputs needed

Existing: 700 canonical passages, Sanskrit, IAST, provisional English, aligned translations/commentaries, lexical search, and stable references.

New: roughly 150 seed queries or source passages with pooled candidate judgments. Labels should distinguish “usefully related,” “weakly related,” “not related,” and “cannot judge,” plus an optional relation description.

## Scientific and statistical setup

1. Predefine representations: Sanskrit only, English only, Sanskrit plus English, translations pooled, and commentary-augmented.
2. Predefine systems: BM25/lexical, frozen multilingual embeddings, reciprocal-rank fusion, and optional reranker.
3. Pool the top candidates from every system so judgments do not favor one retriever.
4. Blind system identity and candidate rank during review. Keep all records for a canonical passage within one split.
5. Report nDCG@10, Recall@10, MRR, coverage, and per-language/query-type effects with query-cluster bootstrap intervals.
6. Use paired randomization tests for the primary hybrid-versus-lexical comparison; correct secondary system comparisons.
7. Negative control: randomly permuted embeddings. Positive control: known same-chapter or exact lexical parallels, labelled as controls rather than presumed semantic relations.

## Nature of the project

An information-retrieval experiment with a possible reader feature after evaluation. The model proposes similarity; only reviewed records may be called curated relationships.

## Outputs

- A small relevance dataset and benchmark script.
- Comparative retrieval report across source views.
- Product candidate: evidence-exposing “related passages.”
- Blog: **“Does commentary help a model connect passages—or leak the answer?”**
- Possible short IR/digital-humanities paper if the multi-view comparison is robust.

## OpenArtha fit

Fit is good because 700 passages are small enough for exhaustive retrieval and each has multiple controlled textual views. Stable IDs and source metadata make every recommendation inspectable.

Gaps: no curated cross-reference graph, provisional English, and no relevance judgments. A modest annotation pool is feasible; 700 passages keep labeling and computation bounded.

## Minimum-build route

Reuse existing lexical results and precompute several embedding matrices offline. Do not deploy a vector service during research. Estimated effort: four to seven days plus judgments.

## Stop conditions

Do not ship dense recommendations if they fail to beat lexical search, if reviewers cannot agree on usefulness, or if commentary-augmented performance vanishes after passage-grouped evaluation.

## Final verdict

**GO.** Moderate buildout and good reusable output; begin after B01 and a small annotation protocol.

## Method sources

- [Sentence-BERT](https://paperswithcode.co/paper/sentence-bert-sentence-embeddings-using)
- [Semantic Textual Similarity](https://paperswithcode.co/task/semantic-textual-similarity)
- [Language-agnostic BERT Sentence Embedding](https://paperswithcode.co/paper/language-agnostic-bert-sentence-embedding)
