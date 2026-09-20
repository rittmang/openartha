# B03 — Multilingual topic atlas

Verdict: **GO**

Buildout: small · Evidence yield: medium · New expert data: small coherence review

## Decision summary

Cluster commentary excerpts into recurring themes as an exploratory map. The atlas is useful if it exposes representative source excerpts and stability; it is scientifically weak if generated cluster names are presented as discovered doctrines.

## Research question and hypotheses

- **H1:** some topic neighborhoods recur across random seeds and reasonable representation models more often than a shuffled-text null.
- **H2:** language-specific topic models are more coherent than a single pooled multilingual model unless cross-lingual alignment is explicitly validated.
- Primary outcome: stability-adjusted human coherence for clusters, not an attractive two-dimensional plot.

## Inputs needed

Existing: commentary units, canonical reference, chapter, language, edition, author, content type, and source provenance.

New: 100–200 blinded cluster-review judgments covering coherence, label adequacy, and whether examples are comparable. Human labels should be descriptions, not claims that the cluster is a canonical philosophical category.

## Scientific and statistical setup

1. Define document units and minimum lengths before embedding. Keep translations and commentaries separate.
2. Fit per-language baselines: TF-IDF plus k-means/NMF and contextual embeddings plus HDBSCAN or k-means.
3. Choose hyperparameters on development chapters only. Repeat each configuration across at least 20 seeds where randomness exists.
4. Measure adjusted mutual information or variation of information across repeats, topic diversity, outlier fraction, NPMI/coherence, and source concentration.
5. Sample clusters and excerpts through a frozen randomization scheme. Reviewers rate coherence while blinded to algorithm and score.
6. Analyze ratings with an ordinal mixed-effects model including reviewer and cluster random effects. Report intervals and multiple-comparison correction across prespecified model families.
7. Negative controls: shuffled word order and shuffled document assignments. Positive control: chapter labels where chapter-specific vocabulary is expected.

## Nature of the project

Unsupervised representation analysis with human validation. It is an atlas and hypothesis generator, not a taxonomy generator.

## Outputs

- Versioned cluster assignments with representative source excerpts and stability scores.
- Internal corpus QA report highlighting outliers and edition-dominated clusters.
- Blog: **“What themes recur when nobody tells the model the categories?”**
- Workshop-style methods note if multilingual stability or metadata effects are novel.

## OpenArtha fit

Fit is good for exploration: thousands of aligned commentary units and rich metadata permit language-, chapter-, and edition-conditioned diagnostics. Passage alignment lets the analysis distinguish topic caused by the source verse from style caused by a witness.

Gaps: no human topic taxonomy, unequal record lengths, multilingual semantic alignment uncertainty, and unresolved corpus review. These do not prevent an exploratory atlas but prevent claims about definitive schools or doctrines.

## Minimum-build route

Reuse B01 tables, sentence/document embeddings, and static figures. Avoid a production topic browser. Estimated effort: three to five days plus a small review session.

## Stop conditions

Stop publication if clusters are unstable, dominated by language/formatting, or less coherent than TF-IDF baselines. Publish that negative finding if the protocol was preregistered.

## Final verdict

**GO.** Suitable as an inexpensive exploratory study and blog, provided the project avoids ontological claims.

## Method sources

- [Topic Models](https://paperswithcode.co/task/topic-models)
- [BERTopic](https://paperswithcode.co/paper/bertopic-neural-topic-modeling-with-a-class)
- [Text Clustering](https://paperswithcode.co/task/text-clustering)

