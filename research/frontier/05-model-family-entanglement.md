# F05 — Model-family behavioral entanglement

Verdict: **GO**

Buildout: small after shared runs · Evidence yield: very high · New expert data: small validated outcome set

## Decision summary

Test whether apparently different model families supply independent evidence. Four models agreeing is less informative if they fail on the same items in the same way because of shared training data, distillation, or alignment conventions.

## Research question and hypotheses

- **H1:** model-pair errors and interpretive phenotypes remain correlated after controlling for item difficulty and output style.
- **H2:** weighting models by estimated behavioral independence changes ensemble conclusions and improves held-out evidence-supported accuracy or calibration over equal voting.
- Primary outcome: held-out performance difference between independence-weighted and equal-weight ensembles on a prespecified, expert-verifiable behavioral target.

## Inputs needed

Existing after F01–F04: repeated outputs from several model families on identical passage/intervention cells, exact versions, failures, atomic claims, and cost records.

New: expert-verified binary/ordinal outcomes for claims where support or expected intervention behavior is assessable. Open-ended stylistic differences alone cannot define error entanglement.

## Scientific and statistical setup

1. Freeze discovery and confirmation passages before estimating dependency weights.
2. Define correctness narrowly: evidence support, intervention-consistent behavior, or another reviewed phenotype—not doctrinal agreement.
3. Estimate marginal error correlation, difficulty-weighted behavioral entanglement, and directional information gain while controlling for passage difficulty.
4. Cluster models by correlated failures and compare equal vote, performance-weighted vote, and entanglement-adjusted vote.
5. Learn weights only on development data; evaluate once on confirmation passages.
6. Use passage bootstrap intervals and permutation tests that preserve item difficulty. Report sensitivity to label ambiguity and missing responses.
7. Negative control: independently permuted model errors matched for accuracy. Positive control: duplicate one model's responses under a fake identity.

## Nature of the experiment

Black-box statistical audit of model independence and ensemble validity. It is a secondary analysis of shared model runs, not another generation system.

## Outputs

- Model-family dependency graph with uncertainty.
- Paper: **“When multi-model agreement is not independent evidence in interpretive tasks.”**
- Blog: **“Four jurors can agree because they copied the same notes.”**
- A principled weighting policy for later verifier ensembles.

## OpenArtha fit

Fit is strong because all models receive identical, reconstructable source units and interventions. The repeated-measures structure permits item-difficulty controls that ad hoc chatbot comparisons lack.

Gaps: V4 outputs do not yet exist, and many interpretations lack binary correctness. Restrict the primary analysis to source support and intervention expectations; use broader interpretive convergence as descriptive only.

## Minimum-build route

Reuse F01–F04 outputs and labels. Add statistical analysis only; no new model calls may be required. Begin with pairwise failure correlations and a held-out reweighting test.

## Stop conditions

Do not interpret stylistic similarity as shared error, learn and test weights on the same passages, or claim independence when confidence intervals are broad.

## Final verdict

**GO.** Exceptional marginal leverage because it reuses the costly shared runs and can invalidate naive multi-model voting.

## Method sources

- [How Independent Are Large Language Models?](https://paperswithcode.co/paper/2604.07650)
- [Cross-Model Disagreement as a Label-Free Correctness Signal](https://paperswithcode.co/paper/2603.25450)

