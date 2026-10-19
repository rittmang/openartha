# Edwin Arnold translation

Status: first independent model review completed using Gemini 3.8 Flash through OpenCode; all 700 mappings verified. The reviewed corpus passes all local checks; publication awaits local confirmation.

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
- Register Arnold in the existing author list and D1 source/author/edition/unit/chunk/FTS tables, with a scoped seed in `0043_seed_edwin_arnold_v100.sql`. Keep a bundled fallback and deduplicate it against D1 results. Preserve Gutenberg's public-domain rights separately from the older GPL dataset.
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
- [ ] Obtain local review confirmation before publishing.

## Gemini first review

- [x] Prepare pinned inputs for all 18 chapters, recording the implementation commit, original source checksum, per-verse alignment fingerprints, and input file hashes.
- [x] Launch Gemini 3.8 Flash through OpenCode; actual task IDs and chapter ranges are retained in `research/arnold-first-review/execution.json` (chapters 1–6, 7–12, and 13–18).
- [x] Receive all raw per-verse review artifacts and terminal task outcomes (chapters 1–6: 280 records verified; chapters 7–18: 420 records verified; all 700 canonical records reviewed).
- [x] Validate complete 700-reference coverage, statuses, confidence values, and source-specific findings (all 18 chapters pass schema, fingerprint, and coverage validation; 700 records verified).
- [x] Resolve alignment findings: none reported. Gemini verified all 700 mappings; no corrected records or additional review round were required.
- [x] Attach authentic per-verse first-review outcomes and confidence to the existing review notices and exports; preserve the clean reader and distinguish model review from human review.
- [x] Regenerate and verify the data, local database, APIs, tests, types, lint, and build. Publication remains pending local confirmation.
- Parent-side preparation is complete: validation rejects missing references, stale alignment fingerprints, wrong models, missing real task provenance, and invalid confidence. Corpus hooks attach actual Gemini outcomes only after full validation. All 27 tests pass with the actual 700 reviews attached, including exact raw artifact hashes and unchanged alignment fingerprints. TypeScript, lint, corpus/TEI validation, and the production build pass. Reader layout is unchanged. A separate `0044_review_edwin_arnold_v100.sql` migration carries reviewed statuses and updates Arnold’s author metadata while preserving the already-applied original seed. It has been applied locally.

## Validation and local review

- All 27 automated tests pass, including all 700 exact source-span checks, known semantic anchors across all chapters, omission/shared-span/prelude handling, full source coverage, checksummed exports, and rejection of incomplete alignments.
- D1 seed tests execute against the actual commentary schema and FTS5 with foreign keys enabled, check all 700 stored texts and 684 indexed renderings, preserve another edition, and pass on repeat application.
- Existing corpus and TEI validation, TypeScript, ESLint, and the production build pass.
- 731 local HTTP checks pass before local database migration, including every one of the 700 verse APIs, all 18 author-chapter APIs, author registry, source download, clean reader pages, search, invalid references, and Markdown omission notices.
- Applied pending migrations through `0044_review_edwin_arnold_v100.sql` to the local D1 database; no remote database or deployment was touched. All 731 HTTP checks pass again with the actual Gemini first-review records after migration, verifying all 700 verse payloads, all 18 author chapters, review notices, unchanged clean reader structure, and native D1/bundled deduplication; 1.1 returns 30 total readings and exactly one Arnold record.
- The chapter and verse page templates and shared CSS exactly match the clean pre-import versions (`dddc235`). The Gita index and author catalog retain their existing structures, with updated counts.
- No browser was used. Review: `http://localhost:3100/gita/1`, `http://localhost:3100/gita/1/1`, and `http://localhost:3100/gita/commentaries/edwin-arnold/1`.
- No push or deployment has been performed for this change; confirmation remains pending.

## Blockers and limitations

- Arnold's poetic compression and explicit omissions are represented by shared ranges and omission records. Gemini's first model review is complete; the second review and required human release reviews remain pending. The 97.79% mean confidence is the reviewer's self-assessment, not a calibrated probability.
- On approved publication, apply the D1 migration remotely before pushing/deploying the new application version.
- Publication requires local review confirmation under `AGENTS.md`.
