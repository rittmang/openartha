# Agentic Gita roadmap

## V1 — raw corpus and reader

The active release contains only the versioned corpus, provenance, downloads, search, read-only APIs, and the minimal public reader. No commentary corpus, curator, MCP server, model invocation, or generated analysis is implemented.

## V2 — historical commentaries

Add verse-aligned, rights-cleared English witnesses for Śaṅkara, Rāmānuja, Madhva, Abhinavagupta, Vallabha, Baladeva Vidyābhūṣaṇa, Śrīdhara Svāmin, and Madhusūdana Sarasvatī. Full text is stored only when redistribution is permitted; otherwise the record contains bibliographic metadata and an outbound source link.

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
