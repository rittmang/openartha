# B09 — Citation-first curator

Verdict: **GO**

Buildout: medium · Evidence yield: high · New expert data: small QA and complete-evidence set

## Decision summary

Evaluate corpus-bound question answering with exact citations and abstention before building a chat product. This is a GO only as an offline experiment. A fluent interface without retrieval, citation-completeness, and unanswerable-question evidence remains out of scope.

## Research question and hypotheses

- **H1:** hybrid retrieval plus reranking improves complete-evidence recall over current lexical retrieval.
- **H2:** a claim-first answer format improves citation recall and unsupported-claim rate over ordinary prompted RAG.
- **H3:** explicit abstention examples improve selective accuracy without unacceptable coverage loss.
- Primary outcome: citation recall over all important claims; secondary: citation precision, answer correctness, retrieval recall, unsupported-claim rate, abstention AUROC/risk–coverage.

## Inputs needed

Existing: fixed corpus, stable passage/commentary IDs, exact source locators, checksums, lexical/FTS retrieval, multilingual material, and read-only APIs.

New: 100–200 questions with answerability labels, complete evidence sets, claim decomposition, and reviewer ratings. Include false premises, missing information, underspecified perspective questions, and cross-language queries.

## Scientific and statistical setup

1. Freeze question creation, retrieval corpus, chunking, model/version, and primary endpoint.
2. Split by canonical passage/chapter, keeping paraphrased questions together.
3. Compare closed-book, lexical RAG, dense/hybrid RAG, reranked RAG, and claim-first generation.
4. Separate retrieval failure, evidence insufficiency, generation contradiction, attribution error, and citation-format failure.
5. Review claims blind to system identity. A citation is correct only if the cited immutable span supports the claim; plausible topical proximity is insufficient.
6. Use paired question bootstrap intervals and a prespecified paired test for claim-first versus ordinary RAG. Plot selective risk versus coverage for abstention.
7. Negative control: irrelevant but topically similar evidence. Positive control: questions answerable from one explicit passage.

## Nature of the project

Attributed question-answering evaluation and a reusable retrieval/generation harness. A user-facing curator is a later product decision.

## Outputs

- `OA-CiteQA` pilot with answerable/unanswerable questions and complete evidence.
- Reproducible system and error taxonomy.
- Paper/technical report on citation completeness in a small versioned corpus.
- Blog: **“A citation can be real and still fail to support the sentence.”**
- Evaluation foundation for OpenArtha V3.

## OpenArtha fit

Fit is strong because the corpus is bounded, versioned, checksummed, source-aware, and retrievable. Unlike web RAG, the complete evidence universe can sometimes be enumerated.

Gaps: no QA benchmark, incomplete alignment review, provisional translation, and no settled policy for questions with multiple legitimate perspectives. Restrict the pilot to reviewed passages and expose uncertainty.

## Minimum-build route

Use current FTS and offline dense retrieval; store answers as experiment artifacts, not corpus content. Start with 100 questions and two generation conditions. No chat UI or production vector database. Estimated effort: one to two weeks plus review.

## Stop conditions

Do not expose as a trusted curator if complete-evidence recall is poor, abstention is uncalibrated, citations are judged only automatically, or answer text cannot be reproduced from a frozen run.

## Final verdict

**GO.** High-leverage offline study; NOGO for product launch until the evaluation passes.

## Method sources

- [ALCE](https://paperswithcode.co/paper/2305.14627) and [code](https://github.com/princeton-nlp/ALCE)
- [ARES](https://paperswithcode.co/paper/2311.09476) and [code](https://github.com/stanford-futuredata/ares)
- [RAGAS](https://paperswithcode.co/paper/2309.15217)

