# Public API verification

Status: remediation in progress. The independent audit identified seven findings. The user now requests fixing all findings, pushing/deploying, and testing the fixes in production.

## Remediation milestone

- The user's current request explicitly authorizes push/deployment and post-deployment production HTTP verification, superseding the repository's default local confirmation/post-deployment-check restrictions for this work. Browser verification remains prohibited.
- Preserve the original audit evidence. Add separate final local and production reports, including repeated searches that previously exceeded Cloudflare resource limits.
- Findings 2/3 already have shared database fixes deployed in `630d3de`; verify full-text/checksum integrity and numeric order across every author, including Arnold, rather than reintroducing separate author behavior.
- Review consistency must not fabricate verification. Investigate imported review provenance and publish a new release if existing immutable exports contain unsupported approval labels; preserve authentic Arnold review evidence.
- [x] Fix search CPU cost/resource failures without increasing paid infrastructure limits (implementation/local validation complete; production confirmation pending).
- [x] Confirm and strengthen complete-text/checksum and numeric-order regressions for all authors.
- [x] Reconcile database/API/download review state with preserved evidence and append-only migrations/releases (remote migration pending below).
- [x] Fix cache negotiation (`Vary: Accept`), Accept quality weights, and work-scoped metadata; clarify the documented envelope.
- [x] Pass regression tests, types, lint, build, corpus checks, and the full local HTTP audit.
- [ ] Push and deploy all fixes, applying any required metadata-only migration.
- [ ] Run the complete production HTTP audit plus serial repeated searches, resolve failures, and record the release/results.

### Implementation and local verification

- Root search uses a generated, content-bound normalized index. Unicode offsets use sparse corrections for length-changing characters and commentary evidence normalizes each text once per query. Local sampled root execution dropped from about 40–83 ms to about 1–7 ms, without changing the tested results/highlights. Tests reject stale prepared data and cover Unicode expansions, deletions, and decomposed marks.
- Retained the shared D1 full-record reads and numeric canonical ordering for all 23 authors. Both JSON and Markdown ordering/content contracts pass, including Arnold's 700 reviewed records and omissions.
- Imported commentary has no matching per-record model-review artifacts in this repository; the older blanket verification strings and heuristic UI confidence were unsupported. New immutable release `gita-commentaries-0.2.1` uses `machine-validated; human review pending`, preserves every text/alignment/content checksum, and retains old release bytes. Metadata-only migration `0045_commentary_review_metadata_v021.sql` is source/commit/version scoped and repeatable; it preserves Arnold and other sources. The UI no longer turns token overlap into a claimed review/confidence.
- Response helpers merge `Vary: Accept` and caller headers across all `HeadersInit` forms; negotiation handles quality weights, exclusions, wildcards, and explicit format overrides. V2 search includes work/root/commentary release metadata even for empty results and source-specific metadata on hits. Registry/error documentation now describes applicable identifiers instead of promising a passage reference everywhere.
- All 41 regression tests, TypeScript, ESLint, production build, commentary validation, and corpus/TEI validation pass. Historical 0.2.0 download bytes and already-applied migrations are unchanged.
- `docs/reports/public-api/local-remediation.json`: 4,016 requests, 54,044 passed assertions, zero failures, including 72 serial repeated searches without hidden retries. An initial HTTP attempt found the existing dev server stopped; it was restarted before this complete successful run. The audit now fails early if the API origin is unavailable.

## Scope and decisions

- Test all 15 implemented public V1/V2 route families documented by `public/llms.txt`, the README, `/data`, and the completed rebrand milestone. V3 routes in the generalized corpus proposal are future design, outside the current public contract.
- Exercise the production origin `https://openartha.rittmang.xyz` and a local runtime through ordinary HTTP, without a browser or browser automation. This new explicit testing request authorizes the read-only production audit; no deployment is performed.
- Independently compare API content with pinned published exports, without importing application handlers or search helpers into the audit.
- Cover JSON, both documented Markdown negotiation mechanisms, compatibility aliases, all 700 canonical references, all published authors across all 18 chapters, search behavior, malformed references, unknown works/authors, and public response headers.
- Add a reproducible audit runner and retain machine-readable results. Report defects without changing application behavior, pushing, or deploying.

## Work

- [x] Read project instructions, public documentation, current route inventory, and existing tests.
- [x] Confirm production is reachable through a read-only HTTP request.
- [x] Implement the independent HTTP contract checks.
- [x] Run the production audit, with bounded concurrency.
- [x] Run the local audit and existing tests.
- [x] Reproduce and document failures, coverage, and limitations.

## Findings and evidence

- The independent runner is `scripts/audit-public-api.mjs`. It sends 3,943 HTTP requests per origin and compares all 700 canonical references through all four passage routes, all 414 author chapters, and all 21,000 reading records against public exports. It also verifies errors, negotiation, search samples, three release manifests, and 18 downloads.
- Two complete runs were performed per origin. Final machine-readable results are `docs/reports/public-api/local.json` and `production.json`; `README.md` in that directory records the full findings, commands, inventory, and limits. Harness checks were corrected to accept valid weak Cloudflare ETags and to require `Vary: Accept` only when the format can depend on that header; both full audits were rerun after those corrections.
- All passage texts/identities/checksums and author-chapter record sets match exports; all current manifests/downloads pass byte/hash checks. Existing tests pass 27/27. The new runner passes Node syntax checking and ESLint.
- Production search intermittently returns Cloudflare resource-limit HTML with HTTP 503. A serial recheck independently reproduces this in 11/21 requests. The first production pass also observed one invalid/truncated JSON response. Evidence retains response samples and Cloudflare Ray IDs.
- V2 search returns partial long Hindi commentary with full-record checksums on both origins; 396 imported-author chapter responses sort verses lexicographically on both origins; all 20,300 imported production commentary review statuses disagree with downloads (local statuses match).
- Every route family omits `Vary: Accept` on cacheable negotiated responses; quality-zero Markdown exclusions are ignored; work-scoped V2 search lacks the `workId` promised by the completed API specification. The report distinguishes explicit documentation mismatches from behavioral and HTTP interoperability defects.
- Final assertion counts: local 53,458 passed / 441 failed; production 12,835 passed / 41,064 failed. These count repeated checks, not distinct defects; production delivery failures also cause secondary assertions to fail.
- No application behavior was changed, and no push, deployment, database migration, or browser action was performed. No blockers remain for the requested audit; remediation is separate work.
