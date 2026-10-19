# OpenArtha

OpenArtha is an open, source-aware library for finding meaning in primary texts by reading the text, comparing interpretations, and following every reading to its source. Artha (AR-tha) means meaning, purpose, or sense in Sanskrit. The Bhagavad Gita is the first work, with 700 canonical passages in Devanagari, IAST, and a provisional verse-aligned English translation, together with interpretations, provenance, review state, variants, and checksums.

Production: https://openartha.rittmang.xyz

The stable `gita-1.0.0` corpus is intentionally blocked until every passage receives two independent human review passes.

## Local development

Requires pnpm. The workspace pins pnpm 10.34.5 and Node.js 24.19.0, so `pnpm` downloads and uses the correct project runtime even when the shell's global Node.js version is older.

```sh
pnpm install
pnpm dev
```

## Corpus workflow

```sh
pnpm corpus:build
pnpm corpus:validate
pnpm commentaries:build
pnpm commentaries:validate
pnpm translations:build
pnpm test
```

The canonical TEI source is `corpus/gita/tei/gita.xml`. Generated JSONL, CSV, simplified TEI, manifests, and checksums are published beneath `public/data/gita-1.0.0-rc.1/`. The complete-source commentary preview is generated beneath `public/data/gita-commentaries-0.2.0/`. D1 schema and FTS5 setup live in `drizzle/`; compiled seed statements live in `db/seed.sql`.

Sir Edwin Arnold's *The Song Celestial* is integrated into the existing verse interpretation list, author catalog, and chapter reader at `/gita/commentaries/edwin-arnold`. Project Gutenberg ebook #2388 was downloaded once; the app makes no runtime request to Gutenberg. All 700 canonical references across 18 chapters have semantic alignment records: 684 have rendered text, while 16 record Arnold's source omissions. Four two-verse groups share a documented source span where his poetry interweaves the verses. The standard 34-verse Chapter 13 numbering is respected; its alternate opening is retained as paratext. Alignment was performed by gpt-6.1-sol, with independent review pending.

The saved source, authored alignment map, and generated records live in `corpus/gita-translations/edwin-arnold/`. `pnpm translations:build` regenerates the corpus, checksummed `public/data/gita-edwin-arnold-1.0.0/` exports, and D1 migration `0043_seed_edwin_arnold_v100.sql` offline. Every source character belongs to an alignment group or preserved paratext; the build rejects gaps, overlaps, missing verse IDs, and invalid source anchors. Inspect a chapter and its canonical witness with `pnpm exec node scripts/inspect-arnold-alignment.mjs 1`. The digitized title page identifies the 1900 edition. All 37 notes, credits, and the full original Gutenberg file and license remain available in the data download.

Arnold uses the existing `GET /api/v2/passages/gita/1/1`, `/api/v2/commentaries/authors/edwin-arnold/chapters/1`, and unified `/api/v2/works/gita/search?q=...` endpoints (JSON or `?format=markdown`). The D1 seed registers his source, author, edition, all verse records, paratext, and FTS5 entries. Bundled records keep the same reader and API available before the database migration is applied. Passage and search results deduplicate the database and bundled copies and retain Arnold's own review provenance and public-domain rights.

## Cloudflare deployment

The application deploys directly to Cloudflare Workers with a D1 binding named `DB`; no ChatGPT Sites runtime or build plugin is used. The bundled corpus remains a read-only fallback if a local database has not yet been migrated.

```sh
pnpm db:migrate:remote
pnpm deploy
```

Worker, asset, and D1 settings live in `wrangler.jsonc`. The public Worker is OpenArtha at `https://openartha.rittmang.xyz`; the existing D1 database keeps its historical binding name `agentic-gita` for migration continuity.

## Rights

Project code is MIT licensed. Original project metadata and research annotations are CC BY 4.0. The root Gita source retains its source-specific public-domain status; all 29 imported commentary fields in the pinned VedicScriptures snapshot are redistributed under that repository-wide GPL-3.0 license. See `corpus/gita/rights.json` and `corpus/gita-commentaries/rights.json` for the exact source commit, locators, and checksums.

Gutenberg lists Arnold's translation as public domain in the USA. Its source-specific rights record and complete original Gutenberg file, including the full Project Gutenberg License, accompany the separate Arnold download. It is not relicensed under the commentary dataset's GPL-3.0 terms.
