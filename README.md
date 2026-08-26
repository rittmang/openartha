# Agentic Gita

A source-aware, versioned Bhagavad Gita corpus and minimal public reader. The current release candidate contains 700 canonical passages in Devanagari, IAST, and a provisional verse-aligned English witness, together with provenance, review state, variants, and checksums.

Production: https://gita.rittmang.xyz

The stable `gita-1.0.0` corpus is intentionally blocked until every passage receives two independent human review passes.

## Local development

Requires Node.js 22.13 or newer and pnpm.

```sh
pnpm install
pnpm dev
```

## Corpus workflow

```sh
pnpm corpus:build
pnpm corpus:validate
pnpm test
```

The canonical TEI source is `corpus/gita/tei/gita.xml`. Generated JSONL, CSV, simplified TEI, manifests, and checksums are published beneath `public/data/gita-1.0.0-rc.1/`. D1 schema and FTS5 setup live in `drizzle/`; compiled seed statements live in `db/seed.sql`.

## Cloudflare deployment

The application deploys directly to Cloudflare Workers with a D1 binding named `DB`; no ChatGPT Sites runtime or build plugin is used. The bundled corpus remains a read-only fallback if a local database has not yet been migrated.

```sh
pnpm db:migrate:remote
pnpm deploy
```

Worker, asset, and D1 settings live in `wrangler.jsonc`.

## Rights

Project code is MIT licensed. Original project metadata and research annotations are CC BY 4.0. Source texts and digital witnesses retain their source-specific public-domain or licensed status; see `corpus/gita/rights.json`.
