# V2 commentary corpus plan

Status: full-source research preview deployed; stable editorial release remains blocked on human review

Last updated: 2026-08-27

## Goal

Add the translations and commentaries represented in the VedicScriptures Bhagavad Gita dataset while keeping the existing 700-verse corpus stable, source-aware, and free of AI-generated material.

## Decisions

- Include all 22 authors and every available English, Hindi, and Sanskrit text in the staging corpus.
- Treat the GitHub repository as the pinned source snapshot. Treat Kaggle as a mirror, not an independent textual source.
- Keep the current 700 canonical verse identifiers unchanged.
- Publish every translation and commentary field supplied by the pinned source snapshot. The repository-wide GPL-3.0 license covers the dataset as distributed; retain that license, the exact source commit, source locators, and checksums with every release.
- Keep the original verse and Telang witness first on every reading page, followed by every supplied translation and commentary in one continuous full-width reading sequence.
- Search the original text, translations, and commentaries through one unified search experience.
- Do not add AI, curator, or generated analysis features in V2.
- Publish all 29 supplied fields from all 22 registered authors across Sanskrit, English, and Hindi.
- Keep corpus licensing separate from project code licensing: application code remains MIT, project metadata remains CC BY 4.0, and the imported dataset text is redistributed under GPL-3.0.
- Preserve the 13-witness `gita-commentaries-0.1.0` download unchanged. Publish the expanded corpus as `gita-commentaries-0.2.0` rather than silently replacing it.
- Label the first public commentary corpus as a research preview; machine-aligned records remain visibly pending human review.

## Plan

### 1. Import the source dataset

Pin an exact GitHub commit and record checksums for every imported file. Preserve raw source text and create a separately checksummed display-normalized form.

### 2. Register every author and source edition

Create stable records for all 22 authors and their available English, Hindi, and Sanskrit material. Record the actual translator, editor, book edition, publisher, language, and source link when known.

### 3. Align the material to the canonical Gita

Match imported material to the project's 700 canonical verses. Keep the dataset's 18 chapter colophons and the alternate Chapter 13 opening as explicit paratext rather than extra canonical verses. Flag author-specific numbering differences for human review.

### 4. Preserve publishing rights

Mark all 29 supplied source fields as full-text allowed under the pinned dataset snapshot's repository-wide GPL-3.0 license. Ship a GPL-3.0 license copy, source attribution, exact commit, source locators, and content checksums with the downloadable corpus.

### 5. Add the sequential reading interface

On each verse page, keep the original verse and Telang witness first. Show all available translations and commentaries below them, one after another, with full-width text and visible author, language, type, alignment state, and checksum. Do not use selection controls or a side-by-side comparison grid. Retain the author-by-chapter reading view.

### 6. Expand search into one unified experience

Use one search box and one results page for the original Sanskrit, IAST, Telang translation, imported translations, and commentaries.

Each result must show:

- Canonical verse reference.
- Matched text with the matching substring highlighted.
- Content type: original, transliteration, translation, or commentary.
- Author, language, and source edition when applicable.
- Exact-word or Sanskrit-compound match status when applicable.

Do not ask the reader to choose an author, language, content type, or corpus. One query searches every representation and witness together. Keep `/api/v1/search` unchanged for compatibility and expose unified search through `/api/v2/search`; the V2 API accepts only `q` and an optional result `limit`.

### 7. Publish versioned data and APIs

Add versioned TEI and JSONL commentary exports, a rights manifest, an alignment report, and checksums. Use D1 for the compiled read model and full-text search. Use R2 only for download bundles that exceed Worker static-asset limits.

### 8. Review and release

Before public deployment, verify source identity, rights, verse alignment, author attribution, Unicode normalization, checksums, unified search behavior, API responses, and responsive accessibility. Release the commentary corpus separately from the root corpus so either can be corrected without silently changing the other.

## Release blockers

- Missing GPL-3.0 license, source attribution, exact commit, or source locator in the distributed corpus.
- Unreviewed numbering or alignment exceptions.
- Commentary text appearing under the wrong author, language, content type, or verse.
- Search, API, page, and download checksums that do not agree.

## First implementation slice

Create the pinned source snapshot manifest, author and edition registry, rights matrix, database migration, importer, and alignment report. Do not expose commentary text publicly during this slice.

## Implementation checklist

- [x] Pin source and mirror lineage.
- [x] Correct the publishing policy to cover the complete GPL-3.0 dataset snapshot.
- [x] Add the author, edition, rights, and snapshot registries.
- [x] Add deterministic import, alignment, export, and validation tooling.
- [x] Add the D1 commentary read model and full-text index.
- [x] Add unified reader and API search.
- [x] Add sequential all-witness verse reading and author-by-chapter views.
- [x] Publish versioned commentary downloads and checksums.
- [x] Apply migrations, deploy to Cloudflare, and verify production.

## Implemented 0.1.0 preview

- Deployed at `https://gita.rittmang.xyz` on 2026-08-26.
- Pinned source commit: `43dfc8db815d01e15a347ea294b089334cf2aa17`.
- Registered 22 authors and 29 source fields/editions across Sanskrit, English, and Hindi.
- Published an initial 13-witness classical Sanskrit subset: 9,100 verse-aligned records over the unchanged 700-verse canon.
- Preserved 247 commentary paratext records: 234 chapter colophons and 13 copies of the alternate Chapter 13 opening.
- Added unified FTS5-backed search, subtle substring highlighting, optional filters, verse comparison for up to three witnesses, author-by-chapter reading, V2 JSON/Markdown APIs, TEI/JSONL exports, rights manifest, alignment report, and checksums.
- The 13-witness subset is retained as an immutable historical preview and is superseded by the planned complete-source `0.2.0` release.
- Kept exports below Cloudflare's 25 MiB single-asset limit, so R2 was not introduced.

## 0.2.0 correction and expansion

- [x] Publish all 29 source fields from all 22 authors in D1, unified search, APIs, reading views, and downloads.
- [x] Align Prabhupada's supplied Chapter 1 and Chapter 13 recension explicitly rather than using the default source-number mapping.
- [x] Keep witness identity edition-specific so one author can expose more than one language or content type.
- [x] Split large versioned downloads by language when required by Cloudflare's static-asset limit.
- [x] Apply additive D1 migrations, deploy to Cloudflare, and verify the public custom domain.

The `gita-commentaries-0.2.0` research preview now contains 29 public fields, 22 authors, 20,300 verse-aligned records, and 515 explicit paratext records. The split TEI/JSONL exports and rights manifest are published under `/data/gita-commentaries-0.2.0/`; the OpenArtha reader and text-scoped APIs use this version.

On 2026-08-27, the verse interface was simplified: the three-witness selector and side-by-side grid were removed. All 29 supplied readings now appear sequentially after Telang. The immutable corpus and API payloads did not change. This interface was deployed in Cloudflare Worker version `e2092560-6c37-413d-8500-c42009437ca1`.

Also on 2026-08-27, author, language, and content-type search filters were removed locally. The reader and V2 API now treat search as one unified query across every Gita representation and witness. The user approved the search interface locally; deployment remains pending a final review after the local runtime fix.

## Remaining editorial work

The corpus remains deliberately labeled a research preview. Human review of author attribution, edition identity, and all machine-generated verse alignments remains required before a stable commentary release. This editorial review gate does not limit redistribution of the fields already covered by the pinned source snapshot's GPL-3.0 license.
