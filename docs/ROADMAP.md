# OpenArtha roadmap

## V1 — raw corpus and reader

The stable release candidate contains the versioned corpus, provenance, downloads, unified search, read-only APIs, and the minimal public reader. The Bhagavad Gita is available at `/gita` within the OpenArtha multi-text shell.

## V2 — historical commentaries

The deployed `gita-commentaries-0.2.0` research preview contains all 29 supplied fields from 22 authors in Sanskrit, English, and Hindi, aligned to the 700-verse canon with explicit paratext and source checksums. It is available under `/gita/commentaries` and is licensed according to the pinned source snapshot. Stable editorial release remains gated on human review of attribution and alignment.

The maintained implementation plan expands this milestone to the full multilingual, 22-author source dataset and unified search: [`docs/plans/v2-commentaries.md`](plans/v2-commentaries.md).

## V3 — BYOK curator

Add a grounded curator on Cloudflare Agents using OpenRouter OAuth PKCE. Retrieval remains corpus-bound through D1 FTS5. Provider keys and conversations are session-only and never logged or stored. Owner-funded inference, Vectorize, Workers AI, and AI Search remain excluded by default. Add a read-only remote MCP interface only in this phase.

## V4 — comparative model experiment

This phase requires separate authorization and explicit manual cost approval. It must never run automatically.

- Models: `openai/gpt-5.6-sol-pro`, `anthropic/claude-opus-5`, `google/gemini-3.7-flash`, and `deepseek/deepseek-v4-pro-0813`.
- Coverage: 700 passages × 4 models × 3 isolated contexts = 8,400 raw outputs.
- Contexts: current passage only, complete containing chapter, and complete Gita. Historical commentaries are excluded from model context.
- Freeze corpus version, prompts, system instructions, model and provider identifiers, parameters, timestamps, token usage, cost, and response hashes.
- Preserve raw model output immutably; keep human and automated annotations separate.
- Evaluate blind and randomized outputs for grounding, interpretive diversity, consistency, citation accuracy, unsupported claims, and context sensitivity.
