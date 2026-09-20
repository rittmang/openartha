# OpenArtha brand positioning and copy audit

Status: deployed

Last updated: 2026-08-27

Related milestone: [OpenArtha rebrand and text-scoped API plan](./openartha-rebrand.md)

## Objective

Make every public-facing word express one coherent position:

> OpenArtha helps people find meaning in primary texts by keeping the text, its interpretations, and the evidence together.

The name must be taught consistently and without mystification: **Artha** is pronounced **“AR-tha”** and means **meaning, purpose, or sense** in Sanskrit.

This document audits the current working tree. It covers the shared metadata, header, navigation, footer, home page, all reader and commentary page templates, data, methodology, sources, the global 404, shared cards and states, `llms.txt`, the README introduction, the favicon, and the social-share image. API payload terminology is included only where it is visible as human-readable copy. No application copy was changed during this audit.

## Executive finding

The project has been renamed, but the brand has not yet been repositioned. Most current copy describes the container—“source-aware texts,” “research corpus,” records, checksums, and APIs—before it communicates the human outcome. That makes OpenArtha credible to a technical reader but emotionally and cognitively distant for someone who simply wants to understand a text.

Four issues matter most:

1. The meaning of **Artha** is not explained anywhere in the interface, so the most ownable part of the name is unused.
2. The home page leads with corpus mechanics and gives downloads/API equal prominence to reading and interpretation. The primary reader job is not yet dominant.
3. Reader-facing surfaces rely on specialist terms such as *corpus*, *recension*, *witness*, and *provenance* before explaining their benefit.
4. `public/og.png` still displays **Agentic Gita**, even though the page metadata describes that image as OpenArtha. Shared links therefore revert to the old brand.

The strongest existing line is **“Many readings. One traceable text.”** It already contains the right strategic ingredients: interpretive openness plus verifiable evidence. The new system should generalize that idea across the product.

## Brand foundation

### Canonical positioning

**Category descriptor**

> An open, source-aware library of primary texts.

**One-sentence position**

> OpenArtha is an open, source-aware library for finding meaning in primary texts by reading the text, comparing interpretations, and following every reading to its source.

**Canonical tagline**

> Find meaning. Follow it to the source.

**Name explanation**

> Artha (AR-tha) means meaning, purpose, or sense in Sanskrit.

**Product promise**

> The text, its interpretations, and the evidence stay together.

**Ethical guardrail**

> OpenArtha does not claim to reveal one final or authoritative meaning. It gives readers the text, multiple readings, and a visible source trail so they can understand and judge for themselves.

### Audience jobs, in priority order

1. **Reader:** “Help me understand this passage without losing its context.”
2. **Comparative reader, student, or educator:** “Help me compare how different translators and commentators understand the same verse.”
3. **Scholar or curator:** “Let me inspect the edition, source trail, alignment, review state, and rights.”
4. **Developer or researcher:** “Give me stable, structured, reusable text and metadata.”

The current home page effectively starts at jobs 3 and 4. The repositioned experience should lead with jobs 1 and 2, then let evidence and open data substantiate the promise.

### Message hierarchy

Every page should draw from the same sequence:

1. **Meaning:** understand an enduring text.
2. **Perspective:** compare translations and commentaries rather than receiving a single unexplained answer.
3. **Trust:** trace each reading to its source and see what has or has not been reviewed.
4. **Openness:** download or query the same structured records.

The sequence is important. Evidence should support meaning; it should not replace meaning as the first benefit.

## Psychology applied

| Principle | Current friction | OpenArtha application |
| --- | --- | --- |
| Jobs to Be Done | The copy sells a corpus and API before the reader outcome. | Lead with understanding a passage; present comparison, source checking, and data access as ways to accomplish that job. |
| Curse of Knowledge | “Recension,” “witness,” “provenance,” and “corpus” appear in entry-point copy. | Use plain terms first: edition, translation, source trail, complete text. Retain specialist language on methodology and data pages where precision helps. |
| Processing fluency / Occam’s Razor | Several headings describe internal structure rather than a clear benefit. | Use short, concrete sentences and repeat one stable triad: read, compare, trace. |
| Hick’s Law | The home page gives three different product modes similar visual weight without a clear primary path. | Make **Start reading the Gita** the dominant action; group interpretation and open-data paths below it. |
| Activation energy | “Explore” and “see how it works” require users to infer what happens next. | Use specific actions: start reading, compare interpretations, see how the text is checked. |
| Framing and contrast | Research-preview language can feel like a caveat detached from value. | Frame transparency as the benefit: OpenArtha shows uncertainty instead of hiding it. Never weaken or conceal the caveat. |
| Authority and verifiable proof | Counts and checksums are present but not organized into a trust story. | Use factual proof—700 verses, 29 translation/commentary fields, 22 authors, visible sources—without presenting popularity as validation. |
| Pratfall effect | The product honestly exposes machine alignment and pending review. | Preserve these admissions. They increase trust because they are specific and inspectable. |
| Mere exposure | The name is repeated, but its meaning is not. | Repeat the canonical tagline and the read–compare–trace structure across metadata, home, and footer. Explain the name once above the fold and once in the footer. |
| Peak–end rule | The footer ends on three terse imperatives about product mechanics. | End every page on the brand promise: **Find meaning. Follow it to the source.** |

Do not use false urgency, scarcity, fear, spiritual certainty, or loss-aversion language. Those devices would be manipulative and tonally wrong for a public research library.

## Voice and terminology

### Voice

- Clear before scholarly.
- Curious, plural, and invitational; never doctrinal.
- Confident about the records and humble about interpretation.
- Concrete about evidence; never vague about “ancient wisdom.”
- Warm enough for readers, exact enough for researchers.

### Preferred language

- **find meaning**, **read**, **compare**, **interpretation**, **source trail**, **see what was checked**, **open data**
- **the Bhagavad Gita** when naming the work in prose
- **translation** on reader pages; **witness** only when its scholarly meaning is useful or explained
- **edition** on entry pages; **recension** on methodology pages
- **source trail** in headings; **provenance** in technical record labels

### Avoid or limit

- “Unlock ancient wisdom,” “the true meaning,” “definitive,” “sacred answers,” or any promise of spiritual transformation.
- “Corpus,” “canonical,” “machine-aligned,” and “SHA-256” in a first sentence unless the page is specifically about research or data.
- “Open source” as link copy for a textual source; it can be confused with software licensing. Prefer **View source**.
- Vague actions such as **Explore**, **Open**, and **Learn more** when the destination can be named.
- Calling 29 supplied fields “29 perspectives” unless the data actually supports 29 distinct interpretive positions. Use **29 translations and commentaries** or **29 published fields** according to context.

## Priority findings

### P0 — required for a credible public rebrand

- Replace `public/og.png`; it visibly says **Agentic Gita** and uses the old descriptor.
- Change the global title, description, home hero, and footer to the meaning-led brand system.
- Teach pronunciation and meaning above the fold: **Artha (AR-tha) means meaning, purpose, or sense.**
- Remove old public technical identity where it is externally visible: change the corpus-builder user agent from `AgenticGitaCorpusBuilder` to `OpenArthaCorpusBuilder`. Keep the historical D1 database name because it is operational continuity, not public branding.

### P1 — establish the product narrative

- Reorder the home page around reading, comparison, and source tracing.
- Replace reader-facing jargon on the Gita, verse, and commentary entry pages.
- Make button labels state the next action and destination.
- Fix the methodology page’s **Report a correction** mismatch: it currently promises an action but provides no reporting link or form.

### P2 — supporting consistency

- Update the README and `llms.txt` opening descriptions to use the canonical position.
- Use one compact **OA** monogram in both the header and favicon, with the same rounded-square geometry, forest-green tile, and paper-white letters.
- Keep specialized terminology in the data/API layer, but introduce it with plain-language context.

## Global copy specification

### Metadata and social preview

| Surface | Current | Recommended |
| --- | --- | --- |
| Default title | `OpenArtha — Read deeply. Check the source.` | `OpenArtha — Find meaning. Follow it to the source.` |
| Default description | “OpenArtha is a source-aware home for primary texts…” | “OpenArtha is an open, source-aware library for reading primary texts alongside translations, commentaries, and evidence. Begin with the Bhagavad Gita.” |
| Open Graph / Twitter description | “Read primary texts and check the evidence behind every record.” | “Read primary texts, compare interpretations, and follow every reading to its source.” |
| OG alt | Claims the old image is OpenArtha. | `OpenArtha — Find meaning. Follow it to the source.` after the actual image is replaced. |
| Social image text | `Agentic Gita · A versioned public corpus of the Bhagavad Gita` | `OpenArtha · Find meaning. Follow it to the source.` with a smaller optional line: `Read · Compare · Trace`. |

### Header and navigation

- Keep **Read the Gita**. It is specific and action-led.
- Keep **Commentaries**, **Sources**, and **How it works**; these are clear at navigation scale.
- Change **Downloads** to **Open data** so the label communicates the brand value, not only the click behavior. If analytics or user tests show “Open data” is unclear, retain **Downloads**.
- Change the brand aria-label to **OpenArtha home** only; pronunciation belongs in visible explanatory copy, not a long navigation label.

### Footer

Replace:

> Read the text. Meet its interpreters. Check every source.

With:

> Find meaning. Follow it to the source.

Add a quiet explanatory line if the layout supports it:

> Artha (AR-tha) means meaning, purpose, or sense in Sanskrit.

This repetition uses mere exposure to make the unfamiliar name memorable and correctly pronounced.

## Page-by-page audit and replacement copy

### `/` — Home

**Assessment:** This is the largest positioning gap. The hero makes trust the headline but never connects trust to the human desire for meaning. The statistics emphasize “1 work” and “research,” which frame the product as incomplete before demonstrating its value. The lower paths omit commentaries—the feature most closely tied to the name—and split the technical journey into downloads and API.

**Hero**

- Eyebrow: `OpenArtha (AR-tha) · Meaning, purpose, or sense`
- H1: `Find meaning.` / `Follow it to the source.`
- Body: `OpenArtha is an open, source-aware library for reading primary texts alongside translations, commentaries, and evidence. Begin with all 700 verses of the Bhagavad Gita.`
- Primary CTA: `Start reading the Gita`
- Secondary CTA: `See how the text is checked`

**Hero proof row**

Replace **Works 1 / Passages 700 / Sources Open / Status Research** with:

- `Verses` / `700`
- `Chapters` / `18`
- `Translations & commentaries` / `29`
- `Authors` / `22`

Keep **Research preview** visible as a status pill near the proof row or Gita entry; do not make “research” the primary value statistic.

**Featured verse**

- Section label: `Featured verse · Read the text in three forms`
- Link: `Read Bhagavad Gita 2.47`
- Keep the Devanagari, IAST, and Telang translation. Do not claim that the card shows multiple interpretations unless a commentary excerpt is added.

**Evidence band**

- Eyebrow: `Meaning with evidence`
- H2: `Meaning opens up when the source stays visible.`
- Body: `Every passage keeps its text, translation, source locator, review status, and checksum together. The 700-verse structure passes automated checks; independent human review is still in progress.`
- Status: keep `Human review in progress`
- CTA: `See how the evidence is checked →`

**Pathways section**

- Eyebrow: `Choose your path`
- H2: `Read for meaning. Compare interpretations. Use the open data.`
- Card 1 title: `Read the Gita`
- Card 1 body: `Move verse by verse through Sanskrit, transliteration, English, and source notes.`
- Card 2 title: `Compare interpretations`
- Card 2 body: `See how 22 authors translate and comment on the same verses across Sanskrit, English, and Hindi.`
- Card 2 destination: `/gita/commentaries`
- Card 3 title: `Use the open corpus`
- Card 3 body: `Download versioned files or query the read-only API, with manifests and checksums included.`
- Card 3 destination: `/data`; the data page already leads to the API.

This structure uses Hick’s Law and the Jobs-to-Be-Done model: one primary action above the fold, then three distinct jobs below it.

### `/gita` — Work index and unified search

**Assessment:** Functionally clear, but the lead is a catalogue description and the search says “everything,” which is broad without being meaningful. `Standard 700-verse recension` is correct but too specialist for the entry point.

- Metadata title: keep `Read the Bhagavad Gita`.
- Metadata description: `Read and search all 700 verses of the Bhagavad Gita across Sanskrit, transliteration, English translation, and 29 supplied translations and commentaries.`
- Eyebrow: `OpenArtha’s first text`
- H1: keep `Bhagavad Gita`.
- Lead: `Read all 700 verses in Sanskrit, transliteration, and English. Search 29 supplied translations and commentaries alongside the text.`
- Status: keep `Research preview`.
- Search label: `Search the text and its interpretations`
- Placeholder: keep the multilingual examples.
- Search button: `Search the Gita`
- Results explanation: `Search covers the Sanskrit text, transliteration, Telang translation, and supplied Sanskrit, English, and Hindi translations and commentaries. Exact words appear before matches inside compound forms.`
- Empty state: `No matches. Try a shorter term, a verse number such as 2.47, or an IAST word without diacritics.`
- Keep **Exact word**, **Compound form**, result counts, chapter titles, verse counts, and **Clear search**. These are useful task labels, not marketing copy.

### `/gita/[chapter]` — Chapter template

**Assessment:** This is a utility reading page and should stay quiet. The chapter title, English subtitle, counts, breadcrumbs, and previous/next navigation are already clear.

- Metadata description: change `passages` to `verses` for reader fluency: `Read all {count} verses in Sanskrit, transliteration, and the Telang English translation.`
- Keep the chapter kicker, titles, count, and chapter navigation.
- Shared passage-card CTA: change `Open passage` to `Read verse`.
- Shared passage-card aria-label: keep the explicit work and reference.

### `/gita/[chapter]/[verse]` — Verse template

**Assessment:** This is the core brand experience. It already does the hard product work—text, translation, interpretation, variants, source trail—but presents the final third in system language. The page should feel like the proof of “read, compare, trace,” not like a database record with a reader attached.

- Keep the verse metadata title and quotation JSON-LD.
- Keep breadcrumbs, chapter title, verse reference, speaker, Sanskrit labels, and adjacent verse navigation.
- Change `English witness` to `English translation`.
- Rewrite the alignment note: `This verse was aligned by machine and has not yet completed two independent human reviews. Alignment confidence: {percent}%.`
- Commentary eyebrow: `Interpretations`
- Commentary H2: `Compare translations and commentaries`
- Commentary lead: `Read every available interpretation aligned to this verse. Translations appear first, followed by commentaries; each keeps its author and source trail.`
- Commentary status: `Machine-aligned; independent review pending.`
- Commentary CTA: `Read more from {author} →`
- Keep the GPL-3.0 and pending-review note; it is material disclosure.
- Keep `Critical apparatus` on this specialist detail page, but change `Recorded variant` to `Textual variant` for slightly better comprehension.
- Provenance eyebrow: `Source trail`
- Provenance H2: `Trace this verse`
- Keep the technical record labels under that plain-language heading.
- API link labels: `View JSON`, `View Markdown`, and `View JSON with commentaries`.
- Final navigation fallback: replace `Return / Index` with `All / Chapters`.

### `/gita/commentaries` — Commentary index

**Assessment:** The existing line **“Many readings. One traceable text.”** is strategically strong and may remain as a secondary campaign line. The page can connect more explicitly to Artha while simplifying “witness” terminology.

- Metadata title: `Translations and commentaries on the Bhagavad Gita`
- Metadata description: `Compare 29 supplied translations and commentaries from 22 authors across Sanskrit, English, and Hindi, aligned verse by verse.`
- Eyebrow: `Interpretations across the Gita`
- H1: `One text. Many paths to meaning.`
- Lead: `Compare 29 translations and commentaries from 22 authors in Sanskrit, English, and Hindi. Each reading stays aligned to a verse and linked to its source.`
- Section heading: `Explore by author`
- Count: `{author count} authors · {field count} translations and commentaries`
- Card CTA: `Read by chapter →`
- Licensing section heading: `Where these readings come from`
- Licensing body: `All supplied readings come from one pinned repository snapshot redistributed under GPL-3.0. Their verse alignments are machine-generated and still await independent human review.`
- Keep exact rights notes, language/content labels, source version, and research-preview status.

### `/gita/commentaries/[author]` — Author template

**Assessment:** The page currently leads with project implementation (“fixed 700-verse canonical structure”) rather than the reader’s reason for choosing an author.

- Metadata description: `Read {author}’s supplied translations and commentaries on the Bhagavad Gita, organized across all 18 chapters.`
- Keep the author’s name as H1 and the available content/language eyebrow.
- Lead: `Follow {author}’s reading across all 18 chapters. Each passage stays beside the Sanskrit verse and keeps its source and review status.`
- Keep `Chapters`, chapter titles, record counts, rights, and status.
- If a field is translation-only, generate grammatically accurate copy rather than universally calling it commentary.

### `/gita/commentaries/[author]/[chapter]` — Author chapter template

**Assessment:** The reading surface is clear. Two pieces expose implementation rather than helping the reader: “aligned records” and “database is unavailable.”

- Header count: `{count} aligned translations and commentaries` or `{count} aligned readings`.
- Verse CTA: `Compare every reading of this verse →`
- Empty state: `Readings for this chapter are temporarily unavailable.`
- Keep author, chapter title, root Sanskrit, language/content labels, breadcrumbs, and chapter navigation.

### `/data` — Downloads and API entry

**Assessment:** “Take the whole text” is memorable and should stay. The page is appropriately technical because visitors have selected a data job. It needs only a stronger connection to openness and slightly more action-led links.

- Metadata title: `Download OpenArtha data`
- Metadata description: `Download versioned Bhagavad Gita text and commentary data in TEI XML, JSONL, and CSV, with manifests, rights records, and SHA-256 checksums.`
- Eyebrow: `Open data`
- H1: `Take the whole text with you.`
- Lead: `Download versioned, checksummed exports built from the same source-aware records you read on OpenArtha.`
- Keep all file names, file-format explanations, sizes, manifests, version numbers, rights labels, and checksum labels.
- Release-gate H2: `Structured does not mean verified.`
- Release-gate CTA: `See how releases are checked →`
- API eyebrow: `Read-only API`
- API H2: `Build with OpenArtha.`
- API CTA: `View the works API →`

### `/methodology` — Editorial method

**Assessment:** The page is honest and rigorous. Its hero can turn that rigor into a brand benefit. One step title unintentionally suggests machines outrank humans, and the correction section promises a reporting action without providing one.

- Metadata title: `How OpenArtha checks each text`
- Metadata description: `See how OpenArtha structures, aligns, validates, versions, and reviews primary texts while keeping uncertainty visible.`
- Eyebrow: `How OpenArtha earns trust`
- H1: `Meaning is stronger when the evidence stays visible.`
- Lead: `Every text, translation, alignment, and correction keeps a visible trail. OpenArtha shows what is known, what was automated, and what still needs human review.`

**Step headings**

1. `Define the edition`
2. `Keep each representation separate`
3. `Automate structural checks`
4. `Require two human reviews`
5. `Version every correction`
6. `Keep verses and paratext distinct`
7. `Carry every license forward`

The existing detailed step bodies, English-alignment limitation, commentary limitation, exception note, and alignment-report action should remain; their specificity creates credible authority.

**Correction blocker**

Choose one implementation before preserving the heading **Report a correction**:

- Add a real email, issue template, or form and use the primary CTA `Report a correction`; or
- If no reporting route will exist, rename the section `What a useful correction includes` and retain `View the sources` / `Download the data` as supporting links.

Do not leave “Report a correction” as a heading above two actions that cannot report one. That breaks the promise–action match and weakens trust.

### `/sources` — Sources and rights

**Assessment:** This page already supports the brand promise. Its opening should explicitly connect visible evidence to trustworthy meaning, and its link labels can be less ambiguous.

- Metadata title: keep `Sources and rights`.
- Metadata description: `Trace the texts, translations, and commentaries in OpenArtha to their bibliographic sources, licenses, and review records.`
- Eyebrow: `Source trail and rights`
- H1: `Follow every reading to its source.`
- Lead: `OpenArtha keeps sources visible because meaning is easier to trust when the evidence can be inspected.`
- Visually hidden H2: keep `Corpus sources` or change to `Text sources`; either is accessible and accurate.
- Link labels: `View source ↗` and `View transcription ↗`.
- Commentary registry heading: `Where the commentaries come from`
- Rights H2: `Rights stay attached to every layer.`
- Rights CTA: `Download rights data →`
- Keep source titles, contributor names, years, roles, IDs, commit, license, scope, rights notes, and alignment-report labels unchanged.

### Global 404

**Assessment:** The global 404 assumes every invalid URL is a chapter or verse. It should work for missing data, methodology, commentary, and future-text pages as well.

- Eyebrow: keep `404`.
- H1: `This page could not be found.`
- Body: `The link may be outdated, or the page may have moved.`
- Primary CTA: `Start with the Bhagavad Gita`
- Optional secondary CTA: `Go to OpenArtha home`

## Shared button and microcopy audit

| Current | Recommended | Reason |
| --- | --- | --- |
| Explore the Gita | Start reading the Gita | Lowers activation energy and states the action. |
| See how OpenArtha works | See how the text is checked | Names the concrete benefit. |
| See how we check the text | See how the evidence is checked | Matches the trust promise. |
| Open passage | Read verse | Uses reader language and a specific object. |
| Search | Search the Gita | Removes ambiguity. |
| Open with commentary | Read in context | States why the click is valuable. |
| Browse by chapter | Read by chapter | More active and less catalogue-like. |
| Read all witnesses for this verse | Compare every reading of this verse | Connects to the user job and removes jargon. |
| Inspect sources | View the sources | Plain language. |
| Download the corpus | Download the data | More familiar at action level; retain “corpus” on the destination page. |
| Open source | View source | Avoids confusion with open-source software. |
| Open transcription | View transcription | Consistent action language. |
| Download the machine-readable rights manifests | Download rights data | Shorter without losing meaning. |
| JSON response | View JSON | Describes the click. |
| Markdown response | View Markdown | Describes the click. |
| JSON with commentary | View JSON with commentaries | Describes the click and uses the plural accurately. |
| Inspect the works response | View the works API | Clear destination. |

Keep **Clear search**, **Previous**, **Next**, **All chapters**, file names, format names, status pills, exact/compound match labels, and accessibility labels. These are already precise.

## Adjacent brand surfaces

### `public/llms.txt`

Replace the opening with:

> OpenArtha is an open, source-aware library for finding meaning in primary texts by reading the text, comparing interpretations, and following every reading to its source. Artha (AR-tha) means meaning, purpose, or sense in Sanskrit. The Bhagavad Gita is the first work.

Keep all version, review, rights, route, API, and “do not describe as verified” constraints. They are important machine-facing truth guards.

### `README.md`

Replace the first paragraph with the canonical position, followed by the current technical description:

> OpenArtha is an open, source-aware library for finding meaning in primary texts by reading the text, comparing interpretations, and following every reading to its source. Artha (AR-tha) means meaning, purpose, or sense in Sanskrit. The Bhagavad Gita is the first work, with 700 canonical passages in Devanagari, IAST, and a provisional verse-aligned English translation, together with interpretations, provenance, review state, variants, and checksums.

Keep the rest of the technical README and the explicit note about the historical D1 binding.

### Human-readable API copy

Keep API error messages and Markdown headings factual and terse. They are utility copy, not brand-marketing surfaces. Two consistency changes are worthwhile:

- Prefer the public work title **Bhagavad Gita** over the slug `gita` in human-readable Markdown headings and not-found messages.
- Use **translation** in descriptive Markdown output while retaining schema field names for compatibility.

Do not add the tagline to API errors or payloads.

## Acceptance criteria for implementation

- [x] The canonical tagline appears in the default title, home hero, footer, and replacement social-share image.
- [x] The meaning and pronunciation of **Artha** appear visibly above the fold on the home page and quietly in the footer.
- [x] No public image or human-readable identifier says **Agentic Gita**; operational historical names remain only where documented.
- [x] The home page has one dominant CTA: **Start reading the Gita**.
- [x] Reading, comparison, and source tracing appear before data/API access in the home-page hierarchy.
- [x] Every public page template above has been checked against its approved copy in this document.
- [x] Entry pages introduce plain-language terms before specialist terms.
- [x] Research-preview, machine-alignment, rights, and pending-review disclosures remain visible and exact.
- [x] The methodology correction section either provides a real reporting action or stops promising one.
- [x] Button labels state the next action or destination.
- [x] The social-share image, metadata alt text, favicon/mark decision, README, and `llms.txt` agree with the OpenArtha identity.
- [x] Existing navigation, search, metadata, accessibility, lint, tests, and production build pass after copy implementation.
- [ ] The user reviews the copy locally before any push or deployment; no browser automation is used for project verification.

## Implementation record

- Approved copy was applied across the shared metadata, header, navigation, footer, home page, Gita index, chapter and verse templates, commentary index and reader templates, data, methodology, sources, global 404, shared passage/commentary cards, human-readable API Markdown, README, and `llms.txt`.
- The home-page proof counts now derive from the published corpus and commentary-author registries rather than duplicating the values in copy.
- Author pages describe each author’s actual published field types so translation-only and commentary-only sources are not mislabeled.
- The correction section uses the no-reporting-route option: **What a useful correction includes**, **View the sources**, and **Download the data**.
- `public/favicon.svg` and the shared header now use the same **OA** monogram, rounded-square geometry, forest-green tile, and paper-white letters.
- `public/og.png` was replaced with a 1200 × 630 OpenArtha asset using the exact text **OpenArtha** and **Find meaning. Follow it to the source.** The built-in image-generation tool preserved the established editorial paper, manuscript, and geometric visual language; the selected output was normalized to the declared metadata dimensions.
- The public corpus-builder user agent is now `OpenArthaCorpusBuilder`; the historical D1 database name remains unchanged for migration continuity.
- Navigation coverage was updated to assert the approved primary CTA.
- Verification passed locally on 2026-08-27: ESLint, TypeScript (`tsc --noEmit`), 12 Node tests, `git diff --check`, and the Vinext production build.
- Nothing was pushed or deployed. Local user review remains the release gate.

## Second-pass redundancy audit

Local review on 2026-08-27 showed that the home-page pathways headline repeated the three card titles almost word for word. The large split layout amplified the problem: the left column consumed more attention while adding no information.

The revised rule is now recorded in `.agents/product-marketing.md`: **headline for orientation, body for proof or explanation, and CTA/card title for action.** Adjacent layers must not restate one another.

Changes from the second pass:

- Home pathways: replaced the list-like headline with **Begin with the text—or take it further.** The cards alone name reading, comparison, and open-data actions.
- Home hero and comparison card: removed counts already supplied by the proof row.
- Home section labels: replaced repeated concepts with category labels that add context.
- Gita index: removed the 700-verse count from the lead because the chapter section already presents it.
- Commentary index: moved the 22-author and 29-field proof entirely into the section count; the hero now explains the reading experience.
- Author template: removed the repeated 18-chapter claim because the chapter section states it immediately below.
- Verse commentary panel: the heading supplies the action; the body now supplies count, order, alignment, and source-trail details.
- Data, methodology, and sources: supporting sentences now explain format, review state, or record contents instead of paraphrasing their headlines.
- Correction and licensing sections: removed repeated heading phrases from their opening sentences.
- Internal product-marketing context: renamed and updated from the obsolete Agentic Gita V1 description to the current OpenArtha product and commentary scope.

Deliberate cross-surface reinforcement remains limited to the canonical brand tagline and the meaning of Artha in the home hero, metadata/social preview, and footer. Those appearances are separated by context and serve recognition rather than repeating adjacent information.

Verification after the second pass: ESLint, TypeScript (`tsc --noEmit`), all 12 Node tests, `git diff --check`, and the Vinext production build passed. No browser automation was used.

## OA identity mark

Local visual review replaced the temporary Devanagari mark with a compact **OA** monogram:

- The shared header renders the monogram as a 36 × 36 SVG beside the OpenArtha wordmark.
- The favicon mirrors the same 36 × 36 view box, rounded-square geometry, letter positioning, weight, and spacing.
- Both use a fixed forest-green tile (`#29473a`), green border (`#49685a`), and paper-white letters (`#f5f7f3`) so contrast and identity do not vary across operating-system themes.
- Root metadata explicitly declares `/favicon.svg` as both the icon and shortcut icon.
- Navigation coverage asserts that the header and favicon both contain the **OA** mark and that the favicon metadata remains present.
- The favicon was rendered to PNG and inspected at native and enlarged sizes without browser automation.

Verification after the mark change: ESLint, TypeScript (`tsc --noEmit`), all 12 Node tests, `git diff --check`, and the Vinext production build passed.

## Deployment record

- Deployed on 2026-08-27 after explicit user approval with `pnpm run deploy`.
- Cloudflare Worker: `openartha`.
- Version ID: `24fd7531-df2d-4109-b37c-4f72c5ff2d33`.
- Worker URL: `https://openartha.godmod.workers.dev`.
- Custom domains: `https://openartha.rittmang.xyz` and `https://gita.rittmang.xyz`.
- Cloudflare uploaded seven new or modified assets, including `/favicon.svg`, `/og.png`, `/llms.txt`, and the revised CSS/client bundles.
- No browser, network, or other post-deployment verification was performed, per project policy.

## Recommended implementation order

1. Replace the P0 global identity surfaces: metadata, home hero, footer, OG image, and public builder user agent.
2. Rework the home proof and pathway sections without changing the underlying product scope.
3. Apply reader-language changes to Gita, passage cards, verse, and commentary templates.
4. Apply specialist-page changes to data, methodology, sources, 404, README, and `llms.txt`.
5. Resolve the correction-reporting blocker.
6. Run static checks and present the local result for user review before any deployment.

## Scope decisions

- This is a copy and positioning audit, not an assertion that all recommendations have been implemented.
- The OpenArtha position remains multi-text even though the Bhagavad Gita is currently the first and only work.
- The brand welcomes spiritual, literary, educational, and research use without presenting OpenArtha itself as a spiritual authority.
- Technical transparency remains a differentiator; it moves from the lead message to the proof layer.
- No artificial social proof, popularity claim, scarcity, or conversion pressure should be introduced.
