# OpenArtha rebrand and text-scoped API plan

Status: complete

Last updated: 2026-08-27

## Goal

Rename the public project to OpenArtha and make the Bhagavad Gita the first text in a multi-text library. The existing Gita reader remains at `/gita`; the home page becomes a work-neutral entry point.

## Decisions

- Public brand: OpenArtha.
- Primary hostname: `https://openartha.rittmang.xyz`; the former `gita.rittmang.xyz` hostname remains a legacy alias during the transition.
- Bhagavad Gita reader and search: `/gita`, `/gita/:chapter`, `/gita/:chapter/:verse`, and `/gita?q=...`.
- Gita commentary browsing moves under `/gita/commentaries`; old Gita commentary URLs remain compatibility links while the new canonical paths are introduced.
- Search is always scoped to one work. The Gita reader and canonical V2 endpoint use one unified index across the root text, Telang witness, and published Gita commentary fields; there is no cross-work search endpoint. The V1 scoped route remains a root-corpus compatibility surface.
- The current D1 database and Worker binding remain in place while the public Worker/project identity changes to OpenArtha. This avoids a data migration solely for branding.

## API shape

Canonical text-scoped endpoints:

- `GET /api/v1/works` — discover available works and their route/API roots.
- `GET /api/v1/works/gita/passages/:chapter/:verse` — retrieve one canonical Gita passage.
- `GET /api/v1/works/gita/search?q=...` — compatibility search over the Gita root corpus; optional `limit` applies to that work.
- `GET /api/v1/works/gita/sources` — Gita source registry and rights metadata.
- `GET /api/v1/works/gita/versions` — Gita corpus and commentary release identifiers.
- `GET /api/v2/works/gita/passages/:chapter/:verse` — Gita passage plus published commentary witnesses.
- `GET /api/v2/works/gita/search?q=...` — unified Gita root + translation + commentary search; only the optional result `limit` changes the response.

Compatibility endpoints remain available for existing clients (`/api/v1/passages/gita/...`, `/api/v1/search`, `/api/v2/passages/gita/...`, `/api/v2/search`). New clients should use the work-scoped forms. Every response includes `workId`, `canonicalRef`, `corpusVersion`, and content negotiation remains JSON or Markdown.

Future texts add a work registry entry and the same scoped route family; they do not change Gita search semantics or identifiers. A future cross-work discovery endpoint, if needed, will be explicitly separate from text search.

## Implementation checklist

- [x] Rename app metadata, navigation, footer, docs, and package/Worker display identity.
- [x] Update canonical host, sitemap, robots, JSON-LD, and download links to `openartha.rittmang.xyz`.
- [x] Add the text-scoped API route family and work metadata.
- [x] Add canonical `/gita/commentaries` links while preserving old compatibility paths.
- [x] Configure the Cloudflare custom domain for `openartha.rittmang.xyz`, move the legacy alias, and deploy the Worker.
- [x] Verify Gita pages, scoped search, legacy API compatibility, canonical headers, DNS, and deployment health.

## Implementation record

- Cloudflare Worker: `openartha`, current version `24fd7531-df2d-4109-b37c-4f72c5ff2d33`.
- Custom domains: `openartha.rittmang.xyz` (primary) and `gita.rittmang.xyz` (legacy alias to the OpenArtha Worker).
- The D1 database remains named `agentic-gita` to avoid a data migration for a public-brand change.
- Canonical Gita API routes are live under `/api/v1/works/gita/*` and `/api/v2/works/gita/*`; the pre-existing unscoped routes remain compatibility endpoints.
- The unified V2 search interface accepts one query and searches every Gita representation and witness together; author, language, and content-type filters were removed locally and approved by the user on 2026-08-27.
- Local development now pins pnpm 10.34.5 and Node.js 24.19.0 through repository configuration. This fixes `pnpm dev` in shells still using Node.js 16 and eliminates the unsupported-engine and ignored-build-script warnings. The combined search/runtime change awaits final local review before deployment.

## Out of scope

No additional religious texts, curator AI, MCP interface, model calls, or cross-work search are introduced by this rebrand.
