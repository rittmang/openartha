# V2 commentary corpus plan

Status: approved direction; implementation not started

Last updated: 2026-08-26

## Goal

Add the translations and commentaries represented in the VedicScriptures Bhagavad Gita dataset while keeping the existing 700-verse corpus stable, source-aware, and free of AI-generated material.

## Decisions

- Include all 22 authors and every available English, Hindi, and Sanskrit text in the staging corpus.
- Treat the GitHub repository as the pinned source snapshot. Treat Kaggle as a mirror, not an independent textual source.
- Keep the current 700 canonical verse identifiers unchanged.
- Publish full text only when its source edition and redistribution rights are verified. Otherwise publish author and source metadata with an outbound link.
- Keep the original verse first on every reading page.
- Search the original text, translations, and commentaries through one unified search experience.
- Do not add AI, curator, or generated analysis features in V2.

## Plan

### 1. Import the source dataset

Pin an exact GitHub commit and record checksums for every imported file. Preserve raw source text and create a separately checksummed display-normalized form.

### 2. Register every author and source edition

Create stable records for all 22 authors and their available English, Hindi, and Sanskrit material. Record the actual translator, editor, book edition, publisher, language, and source link when known.

### 3. Align the material to the canonical Gita

Match imported material to the project's 700 canonical verses. Keep the dataset's 18 chapter colophons and the alternate Chapter 13 opening as explicit paratext rather than extra canonical verses. Flag author-specific numbering differences for human review.

### 4. Verify publishing rights

Give each source edition one clear status: full text allowed, permission needed, source link only, or blocked. All authors may appear in the bibliography, but unverified text must not appear in pages, APIs, search results, or downloads.

### 5. Add the reading and comparison interface

On each verse page, keep the original verse and Telang witness first. Add available translations and commentaries below them, with filters for author, language, and content type. Allow readers to compare up to three authors. Add an author-by-chapter reading view.

### 6. Expand search into one unified experience

Use one search box and one results page for the original Sanskrit, IAST, Telang translation, imported translations, and commentaries.

Each result must show:

- Canonical verse reference.
- Matched text with the matching substring highlighted.
- Content type: original, transliteration, translation, or commentary.
- Author, language, and source edition when applicable.
- Exact-word or Sanskrit-compound match status when applicable.

Provide optional author, language, and content-type filters without requiring the reader to choose a corpus before searching. Keep `/api/v1/search` unchanged for compatibility and expose unified search through `/api/v2/search`.

### 7. Publish versioned data and APIs

Add versioned TEI and JSONL commentary exports, a rights manifest, an alignment report, and checksums. Use D1 for the compiled read model and full-text search. Use R2 only for download bundles that exceed Worker static-asset limits.

### 8. Review and release

Before public deployment, verify source identity, rights, verse alignment, author attribution, Unicode normalization, checksums, unified search behavior, API responses, and responsive accessibility. Release the commentary corpus separately from the root corpus so either can be corrected without silently changing the other.

## Release blockers

- Unresolved source-edition or redistribution rights.
- Unreviewed numbering or alignment exceptions.
- Commentary text appearing under the wrong author, language, content type, or verse.
- Search, API, page, and download checksums that do not agree.

## First implementation slice

Create the pinned source snapshot manifest, author and edition registry, rights matrix, database migration, importer, and alignment report. Do not expose commentary text publicly during this slice.

