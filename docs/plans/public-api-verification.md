# Public API verification

Status: complete. Independent HTTP contract audit requested on 2026-10-18 (America/Los_Angeles). Result: public API audit fails; findings and reproducible evidence are retained in `docs/reports/public-api/`.

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
