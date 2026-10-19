# Edwin Arnold translation

Status: implemented locally on `main`; publication awaits local review.

## Scope and decisions

- Make Sir Edwin Arnold's *The Song Celestial; Or, Bhagavad-Gîtâ* available as an English translation of the existing Bhagavad Gita work.
- Preserve Project Gutenberg ebook #2388 as a downloaded plain-text source. The supplied `https://www.gutenberg.org/files/2388/2388-0.txt` returns HTTP 404; the catalog's current plain-text link resolves to `https://www.gutenberg.org/cache/epub/2388/pg2388.txt`.
- Record the 1900 edition shown on the source title page, translator, catalog URL, retrieval URL, source checksum, and Gutenberg's “Public domain in the USA” rights statement. Retain the complete original file, including its credits and license.
- Split only at the 18 explicit chapter headings. Preserve poetry, chapter colophons, and all 37 translator's notes. Preserve source footnote-marker anomalies rather than silently correcting them.
- Normalize CRLF to LF only in generated chapter text. Retain original indentation and wording; distribute the unchanged source bytes with the complete Gutenberg header and license. Git attributes prevent newline conversion of the two raw source copies.
- Offer chapter reading and search, downloads, source records, and read-only API access. Keep links from the Gita reader and its translation/commentary catalog.
- Keep Arnold at chapter granularity. No verified mapping to the 700 canonical verse IDs is supplied, and Arnold explicitly omits some lines; do not invent verse assignments or inherit existing review approvals.
- Follow `AGENTS.md`: no browser-based checks; prepare and verify the implementation locally before requesting local review and confirmation to push or deploy.
- Keep the implementation on `main`, in accordance with the user's branch instruction.

## Work

- [x] Inspect the current corpus, interpretation catalog, reader, APIs, and repository instructions.
- [x] Verify the catalog, locate the working plain-text download, and inspect its chapter and note boundaries.
- [x] Preserve the source and add a deterministic import with provenance, rights, and checksummed exports.
- [x] Expose the translation through the reader, catalog, search, APIs, bibliography, and downloads.
- [x] Verify source fidelity, all 18 chapters, notes, API behavior, tests, types, lint, and production build using non-browser checks.
- [ ] Obtain local review confirmation before publishing.

## Validation and local review

- All 19 automated tests pass, including source bytes, chapter line ranges, content hashes, all 37 notes, known source anomalies, malformed-import rejection, downloads, and search offsets.
- Existing corpus and TEI validation pass. Type checking, ESLint, and the production build pass.
- 44 local HTTP checks pass, covering all 18 JSON chapter payloads, Markdown negotiation, metadata, CORS/version headers, invalid references, unified search, linked reader pages, and byte-identical source downloads.
- No browser was used. Local review server: `http://localhost:3100/gita/translations/edwin-arnold`.
- No push or deployment has been performed for this change; confirmation remains pending.

## Blockers and limitations

- No source-provided verse alignment; chapter-level availability is intentional.
- Publication requires local review confirmation under `AGENTS.md`.
