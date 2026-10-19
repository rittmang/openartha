# Edwin Arnold translation

Status: original translation/review deployment completed as recorded below. Shared-author runtime follow-up is implemented and verified locally; the user authorized publication with “Deploy the changes.” Push/deployment is in progress. Remote migrations 0043–0044 are already applied and no new migration is needed.

## Shared author data path follow-up

- The 2026-10-18 independent API audit found that imported author chapters sort textual canonical IDs, while Arnold bypasses the database and returns preordered bundled records. The UI/routes are already shared, but runtime data loading was not fully integrated.
- The user's current instruction supersedes the original pre-migration bundled fallback decision: all authors must read passage, chapter, and search content from the existing D1 tables. Missing or unavailable D1 content follows the same behavior for all authors.
- Preserve source-specific import files, rights, exact spans, omissions, and authentic model-review provenance. Supplemental provenance may be attached by stable record identity/checksum; it must not replace database text or grant stale review approval.
- Use one shared repository and numeric canonical verse ordering. Search must return complete stored records, so chunking cannot change the content/checksum contract.
- [x] Remove Arnold-specific runtime passage/chapter/search branches and use shared database queries.
- [x] Preserve source metadata through a generic record enrichment step with stale-data guards.
- [x] Add regression tests for common retrieval, numeric ordering, FTS chunk reconstruction, omissions, and metadata provenance.
- [x] Run tests, types, lint, build, and the local HTTP audit; retain results without overwriting the original audit evidence.
- [x] Record the outcome and local review entry points. Do not push or deploy this follow-up before local user confirmation under `AGENTS.md`.
- `app/lib/commentary-repository.ts` now queries every author through the same D1 joins and reads canonical chapter/verse numbers from `passages`. Search deduplicates FTS unit IDs and loads complete chunks through that same repository. `app/lib/translations.ts` retains source-specific catalog/provenance registration without providing runtime passage, chapter, or search content.
- All 34 tests pass, including real SQLite/FTS regression tests proving changed D1 text is not replaced with pinned JSON, stale metadata cannot inherit approval, and publication visibility applies to all authors. TypeScript, ESLint, and the production build pass.
- `docs/reports/public-api/local-shared-authors.json` records 3,943 local HTTP requests: 53,858 passed assertions, 41 remaining failures. All 414 author-chapter order checks and all 36 search-integrity checks pass; all 700 passages and 21,000 reading records still match their exports. The remaining 41 assertions cover unrelated cache/negotiation/scoped-envelope issues from the original audit.
- Local review entry points: `http://localhost:3100/gita/commentaries/edwin-arnold/1`, `http://localhost:3100/gita/commentaries/swami-sivananda/1`, and `http://localhost:3100/gita/1/1`. No browser, push, deployment, remote migration, or production follow-up check was performed.
- The user subsequently instructed “Deploy the changes,” authorizing publication of the locally verified follow-up. Use the existing Cloudflare deployment workflow; do not perform browser-based or other post-deployment checks.

## Scope and decisions

- Make Sir Edwin Arnold's *The Song Celestial; Or, Bhagavad-Gîtâ* available as an English translation of the existing Bhagavad Gita work.
- Preserve Project Gutenberg ebook #2388 as a downloaded plain-text source. The supplied `https://www.gutenberg.org/files/2388/2388-0.txt` returns HTTP 404; the catalog's current plain-text link resolves to `https://www.gutenberg.org/cache/epub/2388/pg2388.txt`.
- Record the 1900 edition shown on the source title page, translator, catalog URL, retrieval URL, source checksum, and Gutenberg's “Public domain in the USA” rights statement. Retain the complete original file, including its credits and license.
- The user's review rejects the extra reader panels and chapter-only integration. Restore the clean existing layout and integrate Arnold as a normal author/translation in the established interpretation flow.
- Align the source semantically against the Sanskrit canon and existing verse-numbered witnesses across every chapter and all 700 canonical verses. Record source spans, shared verse ranges, genuine omissions, and alignment review provenance.
- Preserve poetry, chapter colophons, and all 37 translator's notes. Preserve source footnote-marker anomalies rather than silently correcting them.
- Normalize CRLF to LF only in generated chapter text. Retain original indentation and wording; distribute the unchanged source bytes with the complete Gutenberg header and license. Git attributes prevent newline conversion of the two raw source copies.
- Use the existing author catalog, author chapter reader, verse interpretation list, unified search, and APIs. Do not add Arnold-specific panels to chapter or verse pages or a separate reading catalog.
- Make alignment decisions directly; never invent text for omitted verses or inherit another model's review approval. Identify the actual alignment and review models, preserve their independent provenance, and keep any unperformed review pending.
- Completed direct semantic alignment for all 700 canonical references: 684 rendered records, 16 explicit source omissions, and four shared two-verse spans. All source characters are accounted for exactly once at the alignment-group/paratext level.
- Omitted canonical references: 1.43; 8.23–8.27; 13.4; 15.15; 16.23–16.24; 17.23–17.28. The Chapter 8 footnote is misnumbered in the source; Chapter 16's note claims “ten concluding shlokas” although only two verses remain in the project's 24-verse chapter. These discrepancies are documented, not silently corrected.
- Preserve the alternate Chapter 13 opening as paratext and map Krishna's opening to canonical 13.1, retaining the project's standard 34-verse chapter.
- Register Arnold in the existing author list and D1 source/author/edition/unit/chunk/FTS tables, with a scoped seed in `0043_seed_edwin_arnold_v100.sql`. The original pre-migration bundled content fallback is superseded by the shared-author follow-up above. Preserve Gutenberg's public-domain rights separately from the older GPL dataset.
- Follow `AGENTS.md`: no browser-based checks; prepare and verify the implementation locally before requesting local review and confirmation to push or deploy.
- Keep the implementation on `main`, in accordance with the user's branch instruction.
- The user explicitly requested the first review by Gemini 3.8 Flash through OpenCode. The live T3 catalog exposes OpenCode provider `opencode` and model `openrouter/google/gemini-3.8-flash`. Review every canonical reference against Sanskrit, independent verse-numbered witnesses, the source chapter, notes, and the proposed source spans; do not transfer another translation's approval.

## Work

- [x] Inspect the current corpus, interpretation catalog, reader, APIs, and repository instructions.
- [x] Verify the catalog, locate the working plain-text download, and inspect its chapter and note boundaries.
- [x] Preserve the source and add a deterministic import with provenance, rights, and checksummed exports.
- [x] Remove the extra chapter and verse panels and restore the established layout.
- [x] Align and review all 18 chapters and 700 canonical verse references (alignment by gpt-6.1-sol; first independent review by Gemini 3.8 Flash completed).
- [x] Integrate Arnold into the established author, verse, chapter, search, and API flows.
- [x] Verify exact source spans, full coverage, omissions, review provenance, tests, types, lint, and build using non-browser checks.
- [x] Obtain local review confirmation before publishing (user: “Ok confirmed, push deploy”).

## Gemini first review

- [x] Prepare pinned inputs for all 18 chapters, recording the implementation commit, original source checksum, per-verse alignment fingerprints, and input file hashes.
- [x] Launch Gemini 3.8 Flash through OpenCode; actual task IDs and chapter ranges are retained in `research/arnold-first-review/execution.json` (chapters 1–6, 7–12, and 13–18).
- [x] Receive all raw per-verse review artifacts and terminal task outcomes (chapters 1–6: 280 records verified; chapters 7–18: 420 records verified; all 700 canonical records reviewed).
- [x] Validate complete 700-reference coverage, statuses, confidence values, and source-specific findings (all 18 chapters pass schema, fingerprint, and coverage validation; 700 records verified).
- [x] Resolve alignment findings: none reported. Gemini verified all 700 mappings; no corrected records or additional review round were required.
- [x] Attach authentic per-verse first-review outcomes and confidence to the existing review notices and exports; preserve the clean reader and distinguish model review from human review.
- [x] Regenerate and verify the data, local database, APIs, tests, types, lint, and build. The user has confirmed local review and authorized publication.
- Parent-side preparation is complete: validation rejects missing references, stale alignment fingerprints, wrong models, missing real task provenance, and invalid confidence. Corpus hooks attach actual Gemini outcomes only after full validation. All 27 tests pass with the actual 700 reviews attached, including exact raw artifact hashes and unchanged alignment fingerprints. TypeScript, lint, corpus/TEI validation, and the production build pass. Reader layout is unchanged. A separate `0044_review_edwin_arnold_v100.sql` migration carries reviewed statuses and updates Arnold’s author metadata while preserving the already-applied original seed. It has been applied locally.

## Validation and local review

- All 27 automated tests pass, including all 700 exact source-span checks, known semantic anchors across all chapters, omission/shared-span/prelude handling, full source coverage, checksummed exports, and rejection of incomplete alignments.
- D1 seed tests execute against the actual commentary schema and FTS5 with foreign keys enabled, check all 700 stored texts and 684 indexed renderings, preserve another edition, and pass on repeat application.
- Existing corpus and TEI validation, TypeScript, ESLint, and the production build pass.
- 731 local HTTP checks pass before local database migration, including every one of the 700 verse APIs, all 18 author-chapter APIs, author registry, source download, clean reader pages, search, invalid references, and Markdown omission notices.
- Applied pending migrations through `0044_review_edwin_arnold_v100.sql` to the local D1 database; no remote database or deployment was touched during local validation. All 731 HTTP checks pass again with the actual Gemini first-review records after migration, verifying all 700 verse payloads, all 18 author chapters, review notices, unchanged clean reader structure, and native D1/bundled deduplication; 1.1 returns 30 total readings and exactly one Arnold record.
- The chapter and verse page templates and shared CSS exactly match the clean pre-import versions (`dddc235`). The Gita index and author catalog retain their existing structures, with updated counts.
- No browser was used. Review: `http://localhost:3100/gita/1`, `http://localhost:3100/gita/1/1`, and `http://localhost:3100/gita/commentaries/edwin-arnold/1`.
- The user confirmed local review and authorized push/deployment. Remote migrations `0043_seed_edwin_arnold_v100.sql` and `0044_review_edwin_arnold_v100.sql` applied successfully. `main` was pushed through `17f6916`. [GitHub Actions run 39205422596](https://github.com/rittmang/openartha/actions/runs/39205422596) passed corpus validation, tests, and build, but deployment failed because its stored Cloudflare API token was invalid (codes 10000/9109). The confirmed version was successfully deployed with `pnpm run deploy` using the existing local Cloudflare authentication. Wrangler reported version `b3007209-0e66-47db-81ae-d4d9f45c7958` on `openartha.rittmang.xyz`, `gita.rittmang.xyz`, and `openartha.godmod.workers.dev`. No browser-based or other post-deployment checks were performed, following `AGENTS.md`.

## Blockers and limitations

- Arnold's poetic compression and explicit omissions are represented by shared ranges and omission records. Gemini's first model review is complete; the second review and required human release reviews remain pending. The 97.79% mean confidence is the reviewer's self-assessment, not a calibrated probability.
- Remote migrations 0043–0044 were applied before pushing the new application version. Deployment is complete; the GitHub Actions Cloudflare token remains invalid and must be replaced separately for future automated deployments.
- The local confirmation required by `AGENTS.md` has been received. Do not run browser-based or other post-deployment checks.
