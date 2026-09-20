# B06 — Hybrid multilingual semantic search

Verdict: **GO**

Buildout: medium · Evidence yield: high for product evaluation · New expert data: relevance judgments

## Decision summary

Combine the existing lexical engine with multilingual dense retrieval and optional reranking. The experiment is worthwhile only if it beats lexical search on blinded human relevance judgments; “semantic search feels better” is not evidence.

## Research question and hypotheses

- **H1:** reciprocal-rank fusion of lexical and dense retrieval improves nDCG@10 over the stronger component on held-out multilingual queries.
- **H2:** a reranker improves precision at shallow ranks without reducing language coverage.
- Primary outcome: nDCG@10 over pooled judgments. Secondary: Recall@20, MRR, latency, and per-language performance.

## Inputs needed

Existing: exact/compound root search, D1 FTS5 commentary search, 700 root passages, 20,300 commentary records, language/script/content metadata, and read-only source-aware APIs.

New: 300–500 natural information needs across English, Hindi, Devanagari Sanskrit, IAST, spelling variants, and cross-language cases. Candidates are pooled from all systems and graded for relevance by blinded reviewers.

## Scientific and statistical setup

1. Freeze query-development and query-test partitions before tuning.
2. Predefine BM25/FTS as the non-neural baseline, a frozen multilingual bi-encoder, rank fusion, and one cross-encoder reranker.
3. Pool candidates from every method and randomize presentation. Reviewers may choose `highly relevant`, `partly relevant`, `not relevant`, or `cannot judge`.
4. Analyze with paired query bootstrap intervals and randomization tests. Prespecify fusion-versus-best-single-system as the primary comparison.
5. Report per-language, transliteration, exact-reference, concept, quotation, and cross-language slices; do not hide a weak Sanskrit result inside an English aggregate.
6. Test robustness to misspellings and metadata filters. Measure latency and index size as secondary engineering outcomes.
7. Negative control: randomized dense vectors. Positive control: exact canonical-reference queries.

## Nature of the project

Information retrieval benchmark plus an optional reader feature. Model output is a ranked list of source records, not generated doctrine.

## Outputs

- Multilingual relevance set and evaluation harness.
- Retrieval comparison paper/technical report.
- Reader feature if confirmatory metrics improve.
- Blog: **“When semantic search actually beats exact words—and when it does not.”**
- Reusable retriever for citation and context-attribution projects.

## OpenArtha fit

Fit is strong: the corpus has multilingual aligned views, stable IDs, existing lexical baselines, compact scale, and exact source evidence. Cross-script retrieval is a real research/product need.

Gaps: no natural-query log or relevance judgments, unbalanced languages, and provisional English. A curated evaluation set is the main cost; no production vector service is needed for the study.

## Minimum-build route

Embed exports offline, run exhaustive similarity over the small corpus, fuse with current lexical rankings, and evaluate in scripts. Deploy only after a win. Estimated effort: one to two weeks plus judgments.

## Stop conditions

Do not deploy if gains are absent on the frozen test set, confined to English, caused by label leakage, or purchased with unacceptable latency. Keep lexical search even if dense retrieval wins overall.

## Final verdict

**GO.** High reuse and product value, with a clear inexpensive baseline and falsifiable success criterion.

## Method sources

- [Passage Retrieval](https://paperswithcode.co/task/passage-retrieval)
- [Contriever](https://paperswithcode.co/paper/towards-unsupervised-dense-information)
- [Cross-Lingual Information Retrieval](https://paperswithcode.co/task/cross-lingual-information-retrieval)

