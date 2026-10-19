# Edwin Arnold translation

Status: corrected and verified locally on `main`; publication awaits local review.

## Scope and decisions

- Make Sir Edwin Arnold's *The Song Celestial; Or, Bhagavad-Gîtâ* available as an English translation of the existing Bhagavad Gita work.
- Preserve Project Gutenberg ebook #2388 as a downloaded plain-text source. The supplied `https://www.gutenberg.org/files/2388/2388-0.txt` returns HTTP 404; the catalog's current plain-text link resolves to `https://www.gutenberg.org/cache/epub/2388/pg2388.txt`.
- Record the 1900 edition shown on the source title page, translator, catalog URL, retrieval URL, source checksum, and Gutenberg's “Public domain in the USA” rights statement. Retain the complete original file, including its credits and license.
- The user's review rejects the extra reader panels and chapter-only integration. Restore the clean existing layout and integrate Arnold as a normal author/translation in the established interpretation flow.
- Align the source semantically against the Sanskrit canon and existing verse-numbered witnesses across every chapter and all 700 canonical verses. Record source spans, shared verse ranges, genuine omissions, and alignment review provenance.
- Preserve poetry, chapter colophons, and all 37 translator's notes. Preserve source footnote-marker anomalies rather than silently correcting them.
- Normalize CRLF to LF only in generated chapter text. Retain original indentation and wording; distribute the unchanged source bytes with the complete Gutenberg header and license. Git attributes prevent newline conversion of the two raw source copies.
- Use the existing author catalog, author chapter reader, verse interpretation list, unified search, and APIs. Do not add Arnold-specific panels to chapter or verse pages or a separate reading catalog.
- Make alignment decisions directly; never invent text for omitted verses or inherit another model's review approval. Identify the actual model and keep independent review pending.
- Completed direct semantic alignment for all 700 canonical references: 684 rendered records, 16 explicit source omissions, and four shared two-verse spans. All source characters are accounted for exactly once at the alignment-group/paratext level.
- Omitted canonical references: 1.43; 8.23–8.27; 13.4; 15.15; 16.23–16.24; 17.23–17.28. The Chapter 8 footnote is misnumbered in the source; Chapter 16's note claims “ten concluding shlokas” although only two verses remain in the project's 24-verse chapter. These discrepancies are documented, not silently corrected.
- Preserve the alternate Chapter 13 opening as paratext and map Krishna's opening to canonical 13.1, retaining the project's standard 34-verse chapter.
- Register Arnold in the existing author list and D1 source/author/edition/unit/chunk/FTS tables, with a scoped seed in `0043_seed_edwin_arnold_v100.sql`. Keep a bundled fallback and deduplicate it against D1 results. Preserve Gutenberg's public-domain rights separately from the older GPL dataset.
- Follow `AGENTS.md`: no browser-based checks; prepare and verify the implementation locally before requesting local review and confirmation to push or deploy.
- Keep the implementation on `main`, in accordance with the user's branch instruction.

## Work

- [x] Inspect the current corpus, interpretation catalog, reader, APIs, and repository instructions.
- [x] Verify the catalog, locate the working plain-text download, and inspect its chapter and note boundaries.
- [x] Preserve the source and add a deterministic import with provenance, rights, and checksummed exports.
- [x] Remove the extra chapter and verse panels and restore the established layout.
- [x] Align and review all 18 chapters and 700 canonical verse references (model alignment; independent review still pending).
- [x] Integrate Arnold into the established author, verse, chapter, search, and API flows.
- [x] Verify exact source spans, full coverage, omissions, review provenance, tests, types, lint, and build using non-browser checks.
- [ ] Obtain local review confirmation before publishing.

## Validation and local review

- All 22 automated tests pass, including all 700 exact source-span checks, known semantic anchors across all chapters, omission/shared-span/prelude handling, full source coverage, checksummed exports, and rejection of incomplete alignments.
- D1 seed tests execute against the actual commentary schema and FTS5 with foreign keys enabled, check all 700 stored texts and 684 indexed renderings, preserve another edition, and pass on repeat application.
- Existing corpus and TEI validation, TypeScript, ESLint, and the production build pass.
- 731 local HTTP checks pass before local database migration, including every one of the 700 verse APIs, all 18 author-chapter APIs, author registry, source download, clean reader pages, search, invalid references, and Markdown omission notices.
- Applied pending migrations through `0043_seed_edwin_arnold_v100.sql` to the local D1 database; no remote database or deployment was touched. All 731 HTTP checks pass again after migration, verifying native D1/bundled deduplication; 1.1 returns 30 total readings and exactly one Arnold record.
- The chapter and verse page templates and shared CSS exactly match the clean pre-import versions (`dddc235`). The Gita index and author catalog retain their existing structures, with updated counts.
- No browser was used. Review: `http://localhost:3100/gita/1`, `http://localhost:3100/gita/1/1`, and `http://localhost:3100/gita/commentaries/edwin-arnold/1`.
- No push or deployment has been performed for this change; confirmation remains pending.

## Blockers and limitations

- Arnold's poetic compression and explicit omissions are represented by shared ranges and omission records; independent textual review remains pending.
- On approved publication, apply the D1 migration remotely before pushing/deploying the new application version.
- Publication requires local review confirmation under `AGENTS.md`.
