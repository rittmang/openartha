# B12 — Provenance-aware claim graph

Verdict: **NOGO**

Buildout: extra large · Evidence yield: potentially very high · New expert data: ontology, entities, relations, evidence spans

## Decision summary

Represent passages, concepts, witness assertions, conflicts, and evidence as a graph. OpenArtha's provenance structure is an excellent substrate, but no reviewed claim ontology or relation corpus exists. Automatically extracting a graph now would convert model guesses into authoritative-looking database edges.

## Research question and hypotheses

After ontology work:

- **H1:** joint extraction conditioned on canonical passage and witness provenance improves evidence-grounded relation F1 over sentence-only extraction.
- **H2:** modelling assertion source, negation, scope, and competing claims reduces false “OpenArtha says X” edges.
- Primary outcome: exact evidence-span and relation correctness jointly; a relation without the correct asserting witness and span counts as wrong.

## Inputs needed

Existing: canonical references, authors/editions, source locators, revision/checksum metadata, text bodies, and a generalized corpus model capable of assertions and anchors.

Missing:

- a small scholar-governed ontology;
- entity and concept normalization policies;
- reviewed atomic claims, relations, scope, negation, and evidence anchors;
- explicit treatment of disagreement and alternative conceptualizations;
- rights and governance for public derived assertions.

## Scientific and statistical setup

1. Begin with 5–10 relations and written competency questions, not a universal ontology.
2. Double-annotate a stratified sample; measure span and relation agreement before modeling.
3. Group all claims from a canonical passage within one fold.
4. Compare rule/lexicon, pipeline entity-plus-relation extraction, joint extraction, and LLM structured extraction.
5. Score entity spans, normalized concepts, relations, asserting witness, polarity/scope, and evidence anchor separately and jointly.
6. Use passage bootstrap intervals and per-relation error analysis. Correct comparisons across relations.
7. Negative controls include source-shuffled witness IDs; positive controls include explicit attribution sentences.
8. Public edges require human acceptance; rejected proposals remain model artifacts.

## Nature of the project

Ontology engineering, information extraction, provenance modeling, and scholarly data governance. The graph is a reviewed derived artifact, not a generated summary.

## Outputs

- Versioned ontology and annotation guide.
- Evidence-grounded relation dataset.
- Knowledge-graph/semantic-web paper and queryable research artifact.
- Blog: **“A source asserting a claim is not the database declaring it true.”**

## OpenArtha fit

Architectural fit is excellent: stable IDs, immutable revisions, evidence locators, witness identity, and the planned assertion/anchor model solve much of the provenance problem. Data readiness is poor because the semantic edges and concepts have not been reviewed.

## Minimum-build route after prerequisites

Pilot one chapter, five relations, and a few hundred claims in flat tables before choosing a graph database. Validate competency queries and extraction first.

## Stop conditions

Do not build infrastructure before ontology agreement. Do not publish unsupported model edges, collapse witness assertions into facts, or proceed when reviewer agreement is inadequate.

## Final verdict

**NOGO.** This is an excellent destination but a poor starting point. Claim annotations from B08/B10/F07 should precede it.

## Method sources

- [Relation Extraction](https://paperswithcode.co/task/relation-extraction)
- [Document-Level Relation Extraction](https://paperswithcode.co/task/document-level-relation-extraction)
- [Knowledge Graphs](https://paperswithcode.co/task/knowledge-graphs)
