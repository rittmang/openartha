# Independent public API audit

Latest result: **PASS — all seven identified issues are fixed and verified in production.** Application commit `234fece` is deployed as Cloudflare version `5502f8a7-ab36-40d3-a103-030b1f8ade28` at `https://openartha.rittmang.xyz`.

The original audit began on 2026-10-18 America/Los_Angeles (UTC evidence on 2026-10-19) against application commit `06f0fb6` and failed. That baseline and its findings are retained below; current results follow.

## Complete remediation

The user subsequently authorized fixing every finding, push/deployment, and production HTTP verification. All seven findings now have implementation coverage: precomputed/sparse Unicode search normalization; shared complete-record retrieval and numeric canonical ordering; source-scoped review metadata correction with a new immutable `gita-commentaries-0.2.1` release; `Vary: Accept`; weighted content negotiation; and complete work/release metadata in V2 search.

The imported commentary release now truthfully states `machine-validated; human review pending`, replacing unsupported blanket model-review claims in the current release and UI. Old releases remain byte-for-byte intact. Arnold's independent review artifacts and approvals remain intact. Metadata-only migration `0045_commentary_review_metadata_v021.sql` changes only the pinned imported source.

All 41 tests, types, lint, build, commentary checks, and corpus/TEI validation pass. Both the [final local audit](./local-remediation.json) and [final production audit](./production-remediation.json) pass **4,016 requests / 54,044 assertions / zero failures**, each including 72 serial repeated searches without hidden retries. Production checks verify all 700 references through all four passage routes, all 414 author chapters (including Arnold), all 21,000 readings and their current review states, content negotiation/cache headers, scoped metadata, errors, and all 18 current release downloads. Earlier findings/results below are preserved as historical evidence.

Migration `0045_commentary_review_metadata_v021.sql` was applied locally and remotely. The code was pushed and deployed with the existing local Cloudflare authentication. [CI](https://github.com/rittmang/openartha/actions/runs/39212785400) passed its validation/tests/build but its deployment token remains invalid; that separate CI maintenance issue did not prevent this release or its successful production verification. No Worker resource limits or paid infrastructure settings were raised. The user's explicit request authorized production HTTP verification for this remediation; no browser was used. The [maintained plan](../../plans/public-api-verification.md#remediation-milestone) records publication details and authorization.

## Local shared-author follow-up

Following the audit, the user requested that Arnold use the same runtime data path as the other authors. The local implementation now reads every author's passage, chapter, and search content through the shared D1 repository. Arnold-specific text fallback/replacement and in-memory search have been removed. Its independent source files, rights, and authentic alignment/review metadata remain preserved; supplemental metadata is applied only when the stored record identity, version, checksum, source, and review status match.

The [follow-up local audit](./local-shared-authors.json) sent 3,943 requests: **53,858 assertions passed and 41 failed**. All **414 chapter-order checks** now pass, all **36 search-integrity checks** pass, and the full 700-reference/21,000-reading data checks continue to pass. All 34 repository tests, TypeScript, ESLint, and the production build pass. The 41 remaining assertions are the existing missing `Vary: Accept` checks (30), work-scoped V2 search metadata checks (9), and quality-weight negotiation checks (2).

At the end of local verification, this follow-up had not been pushed or deployed, and production was not retested during it. The user subsequently authorized publication with “Deploy the changes”; deployment status is maintained in the [translation milestone](../../plans/edwin-arnold-translation.md#shared-author-data-path-follow-up). This local verification does not establish resolution of production resource-limit failures or review-state discrepancies. The original evidence files and findings below describe the baseline audit; follow-up results are retained separately.

The approved follow-up was subsequently pushed as application commit `630d3de` and deployed successfully with the local Cloudflare CLI as version `db6b3856-53e4-4520-bb6f-5e91d5b95764`. The GitHub deployment workflow passed validation/tests/build but its invalid Cloudflare token prevented CI deployment. No production checks were performed after publication, following `AGENTS.md`; this report does not claim the remaining production findings are resolved.

## Method and coverage

The audit sent ordinary HTTP requests to `https://openartha.rittmang.xyz` and the existing local server at `http://localhost:3100`. No browser, browser automation, deployment, remote database mutation, or application behavior change was used. The runner imports no application code. Expected text and metadata come from pinned public JSONL exports and release manifests, and returned content is independently hashed with SHA-256.

The baseline run sent **3,943 requests per origin**, using at most four concurrent requests. Both origins were audited twice; `production.json` and `local.json` retain those original results. The first production run's HTTP failures are retained separately, along with serial targeted rechecks and compact reproductions. The current runner adds one origin preflight and 72 repeated serial searches, for 4,016 requests per complete run; current release expectations follow the pinned source registry.

Baseline assertion totals were **53,458 passed / 441 failed locally** and **12,835 passed / 41,064 failed in production**. These were repeated assertions, not distinct defects: 40,600 production failures alone represented the 20,300 mismatched review statuses checked through two aliases. That production run also observed nine unsuccessful HTTP responses, with consequent failures in negotiation/header or search checks. Findings below distinguish those secondary failures from separate bugs.

Coverage includes:

- Every implemented public V1/V2 route family: **15** total, inventoried below.
- Every canonical passage: **700 references × four JSON passage routes**, including full root payload comparison, commentary content/identity, SHA-256, review provenance, compatibility equivalence, and V1 ETag identity. Cloudflare's valid weak ETags are accepted.
- All **23 authors × 18 chapters = 414 author/chapter JSON responses**; all **21,000 distinct reading records** are compared to exports. This includes 20,300 imported commentary records and 700 Arnold records, with the latter's source omissions and independent model-review provenance preserved.
- JSON plus `?format=markdown` and `Accept: text/markdown` for every route family; Markdown passage contents at the first/last reference of every chapter plus Arnold's 1.43 omission, and author Markdown for chapters 1 and 18 of every author.
- **62 invalid-input cases × three response formats**, including empty/whitespace queries, invalid/nonexistent references, Chapter 13's 34-verse boundary, unknown works, and unknown authors/chapters.
- HEAD, CORS, version/cache headers, negotiation, aliases, search limits, diacritics, Devanagari, multiword queries, no-match queries, syntax-like query text, and known Arnold/Sivananda witnesses.
- All **three current manifests and 18 manifest-listed download files**, including byte counts and SHA-256.

Public documentation used: [README](../../../README.md), [`llms.txt`](../../../public/llms.txt), [data page source](../../../app/data/page.tsx), and [completed work-scoped API specification](../../plans/openartha-rebrand.md#api-shape). Proposed V3 endpoints in the generalized corpus design are outside the implemented public API.

## Findings

### 1. High: production search repeatedly exceeds Cloudflare resource limits

Ordinary search requests intermittently return **HTTP 503 with HTML** headed **“Worker exceeded resource limits”**, where clients expect JSON. The first full production run observed nine 503 responses and one invalid/truncated JSON body. A separate serial recheck of seven affected requests over three rounds observed **11 failures in 21 requests**. Identical requests sometimes succeed in another round, so this is not a deterministic input-validation rejection. Local requests succeed.

Examples include:

```sh
curl -i 'https://openartha.rittmang.xyz/api/v1/search?q=yoga&limit=100'
curl -i 'https://openartha.rittmang.xyz/api/v2/works/gita/search?q=sacred+plain&limit=100'
curl -i 'https://openartha.rittmang.xyz/api/v2/works/gita/search?q=sankhya&limit=100'
```

Evidence: [`search-delivery-rechecks.json`](./search-delivery-rechecks.json) retains status, content type, response samples, and Cloudflare Ray IDs for all 21 requests; [`initial-production-http-errors.json`](./initial-production-http-errors.json) preserves initial failures. The precise exhausted resource and underlying cause were not determined; this audit does not infer a CPU or memory diagnosis from the error page alone.

### 2. High: V2 search returns partial commentary with the full-text checksum

Both origins return incomplete `commentary.content` for some long Hindi results, with `commentary.checksum` still identifying the complete record. This is distinct from passage retrieval, which returns and hashes the full text correctly.

For `q=धर्म&limit=100`, the `swami-ramsukhdas-hc:source:3.35` result returns **9,226 characters** against **17,074** in the full passage/export. Its advertised checksum is `78be2ce52d6e81013ad4f25e949e51d2a4487d4d72899464470810b1169bcf4f`, while the returned content hashes to `1d676a0c34bbffe66cb0e2c16de5151c146a2e98677f4038d8022148248d6775`.

For `q=कर्तव्य&limit=100`, five returned Hindi records differ from their full exports. The 3.30 result starts **9,196 characters into** the original record. No field identifies `content` as a partial chunk or supplies a checksum for those returned bytes.

```sh
curl -G 'https://openartha.rittmang.xyz/api/v2/works/gita/search' \
  --data-urlencode 'q=धर्म' --data-urlencode 'limit=100'
```

Source inspection explains the observed behavior in the [baseline implementation](https://github.com/rittmang/openartha/blob/06f0fb6/app/lib/commentaries.ts#L277): it selects `f.content` from individual FTS rows, while `u.display_checksum` belongs to the complete unit, then deduplicates by unit ID without reconstructing all chunks. Both `/api/v2/search` and `/api/v2/works/gita/search` are affected in that implementation. Full comparisons and byte/hash measurements are retained in [`reproductions.json`](./reproductions.json).

### 3. Medium: author chapters return verses in lexicographic order

All **396 chapter responses for the 22 imported authors** have verse ordering such as `1, 10, 11, …, 19, 2, 20, …`. The same ordering reaches the Markdown representation. All 18 Arnold chapters pass because they use a separate bundled path. Record membership and complete content are correct.

```sh
curl -s 'https://openartha.rittmang.xyz/api/v2/commentaries/authors/swami-sivananda/chapters/1' \
  | jq '[.data[].verse]'
```

Cause: the [baseline implementation](https://github.com/rittmang/openartha/blob/06f0fb6/app/lib/commentaries.ts#L239) orders by textual `u.passage_id`. Ordering by numeric source/canonical verse is needed to return the chapter in reading order. This is a behavioral defect; public docs do not contain an explicit JSON-array sorting guarantee. Evidence: `author-chapter-order` in both complete reports and the first 20 returned verse numbers in [`reproductions.json`](./reproductions.json).

### 4. Medium: production review metadata disagrees with published exports

All **20,300 imported commentary records** return `alignmentStatus: "machine-validated; human review pending"` in production, while their current public JSONL exports say `"first review verified (google/gemini-3.8-flash); second review pending"`. This produces 40,600 failures across the two V2 passage aliases; it is **20,300 distinct mismatched records**, not 40,600 independent defects.

Local D1 responses match the exports. All 700 Arnold records match on both origins. Content and content checksums for the imported records also match on both origins. This isolates the mismatch to review-state metadata; the audit does not establish which approval label is justified and does not recommend assigning verification without the corresponding evidence.

```sh
curl -s 'https://openartha.rittmang.xyz/api/v2/works/gita/passages/1/1' \
  | jq '.data.commentaries[] | select(.authorId == "swami-sivananda") | {id, alignmentStatus}'
```

Evidence: `review-status-export-parity` in [`production.json`](./production.json) and [`local.json`](./local.json), plus [`reproductions.json`](./reproductions.json). Review status is loaded directly from D1 in the [baseline implementation](https://github.com/rittmang/openartha/blob/06f0fb6/app/lib/commentaries.ts#L196); production database/migration state was not inspected or changed.

### 5. Medium: cacheable JSON/Markdown negotiation omits `Vary: Accept`

All 15 route families return different representations at the same URL according to `Accept`, with `Cache-Control: public, max-age=300, s-maxage=3600, stale-while-revalidate=86400`, while `Vary` omits `Accept`. Both origins reproduce the missing header. The audit checks this requirement only for URLs without the explicit `format=markdown` override.

This permits HTTP caches that use the advertised response metadata to reuse a representation for a client requesting the other format. Actual cross-client cache contamination was not demonstrated. Shared headers are defined in [`app/lib/http.ts:6`](../../../app/lib/http.ts#L6); observed request/response headers are retained in [`reproductions.json`](./reproductions.json).

### 6. Low: negotiation ignores `Accept` quality weights

`Accept: application/json, text/markdown;q=0` still returns Markdown, although that header explicitly excludes it. A lower Markdown preference (`application/json;q=1, text/markdown;q=0.1`) also returns Markdown. Both origins reproduce this.

```sh
curl -i -H 'Accept: application/json, text/markdown;q=0' \
  'https://openartha.rittmang.xyz/api/v1/works'
```

Cause: [`app/lib/http.ts:3`](../../../app/lib/http.ts#L3) uses a substring test. The two simple negotiation forms explicitly documented in `llms.txt` work; this finding concerns standard client preference/exclusion semantics beyond those examples.

### 7. Low: work-scoped V2 search omits documented work metadata

The completed [API specification](../../plans/openartha-rebrand.md#api-shape) says every response includes `workId`, `canonicalRef`, and `corpusVersion`. `/api/v2/works/gita/search` directly returns the unscoped handler's response. Its `meta` has only `query`, `returned`, `limit`, and `engine`; top-level search hits also omit `workId`, and commentary hits do not contain it inside the commentary record. An empty result therefore has no work identifier in its JSON response. Root hits do contain `passage.workId`.

This is a documentation/schema consistency gap, rather than wrong-work search: every tested result belongs to Gita, and unknown works correctly return 404. V1 work-scoped search includes `meta.workId`. The general “every response” wording is also too broad for discovery/registry responses, where a single canonical reference is not applicable. Either narrow the documented guarantees or implement a consistent response envelope.

Evidence: `work-scoped-search-metadata` in both complete reports and [`app/api/v2/works/[work]/search/route.ts:11`](../../../app/api/v2/works/[work]/search/route.ts#L11).

## Successful checks and limits

All 2,800 JSON passage responses per origin match the canonical root data. The two V2 passage forms each return the correct 30 readings at every reference, including explicit Arnold omission records; their text and checksums match the pinned exports. All 414 author/chapter endpoints return the expected record sets. Tested invalid requests return the expected JSON/Markdown statuses and error bodies. All three manifests and all 18 files match their expected byte counts and hashes on both origins. Basic JSON/Markdown negotiation, CORS/version headers, and HEAD pass locally and on successful production responses; intermittent production search delivery failures also affect those checks. Passage aliases pass on both origins.

At baseline the existing repository suite passed **27/27 tests** while the HTTP audit failed. The current suite passes **41/41** and the corrected HTTP contracts pass locally and in production. The runner exits nonzero on any failed assertion and does not retry delivery failures invisibly.

This audit tests every route family and every current passage/author chapter, but cannot enumerate every possible query or header. Markdown content is sampled at all chapter boundaries rather than tested for all 700 references. It uses the existing migrated local D1 database; no fresh/unmigrated database, simulated D1 outage, alternate production hostname, sustained load test, or browser behavior was tested. Production search failures can cause secondary integrity/alias/limit assertions to fail; those counts do not establish additional independent defects.

## Re-run

From the project root, with the local server running:

```sh
pnpm exec node scripts/audit-public-api.mjs \
  --base-url http://localhost:3100 \
  --output docs/reports/public-api/local-remediation.json

pnpm exec node scripts/audit-public-api.mjs \
  --base-url https://openartha.rittmang.xyz \
  --output docs/reports/public-api/production-remediation.json
```

`--concurrency` accepts 1–8 and defaults to 4. The runner sends read-only GET/HEAD requests and does not retry failures invisibly. Reports aggregate assertions and retain up to eight failure examples per group; assertion totals count repeated checks and should not be interpreted as distinct bug counts.

## Route inventory

```text
GET /api/v1/works
GET /api/v1/sources
GET /api/v1/corpus-versions
GET /api/v1/passages/gita/{chapter}/{verse}
GET /api/v1/search?q={query}
GET /api/v1/works/{work}/passages/{chapter}/{verse}
GET /api/v1/works/{work}/search?q={query}
GET /api/v1/works/{work}/sources
GET /api/v1/works/{work}/versions
GET /api/v2/passages/gita/{chapter}/{verse}
GET /api/v2/search?q={query}
GET /api/v2/works/{work}/passages/{chapter}/{verse}
GET /api/v2/works/{work}/search?q={query}
GET /api/v2/commentaries/authors
GET /api/v2/commentaries/authors/{author}/chapters/{chapter}
```
