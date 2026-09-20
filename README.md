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
pnpm test
```

The canonical TEI source is `corpus/gita/tei/gita.xml`. Generated JSONL, CSV, simplified TEI, manifests, and checksums are published beneath `public/data/gita-1.0.0-rc.1/`. The complete-source commentary preview is generated beneath `public/data/gita-commentaries-0.2.0/`. D1 schema and FTS5 setup live in `drizzle/`; compiled seed statements live in `db/seed.sql`.

## Cloudflare deployment

The application deploys directly to Cloudflare Workers with a D1 binding named `DB`; no ChatGPT Sites runtime or build plugin is used. The bundled corpus remains a read-only fallback if a local database has not yet been migrated.

```sh
pnpm db:migrate:remote
pnpm deploy
```

Worker, asset, and D1 settings live in `wrangler.jsonc`. The public Worker is OpenArtha at `https://openartha.rittmang.xyz`; the existing D1 database keeps its historical binding name `agentic-gita` for migration continuity.

## Rights

Project code is MIT licensed. Original project metadata and research annotations are CC BY 4.0. The root Gita source retains its source-specific public-domain status; all 29 imported commentary fields in the pinned VedicScriptures snapshot are redistributed under that repository-wide GPL-3.0 license. See `corpus/gita/rights.json` and `corpus/gita-commentaries/rights.json` for the exact source commit, locators, and checksums.
