# Generalized multicultural corpus model plan

Status: second adversarial revision; ready for architectural spike, not frozen for production

Last updated: 2026-08-31

## Outcome

Replace the Gita-specific `chapter`/`verse` model with a compact, extensible corpus architecture that can preserve ordinary reading editions and advanced scholarly corpora without making any culture's citation, book, manuscript, or commentary conventions universal.

The design must preserve OpenArtha's current functions:

- passage and section reading;
- breadcrumbs and previous/next navigation;
- Sanskrit, transliteration, translations, and commentaries;
- author/commentary views and ordered paratext;
- provenance, rights, reviews, checksums, and reproducible releases;
- global and work-scoped search;
- JSON and Markdown API access;
- D1 and bundled fallback implementations;
- V1/V2 compatibility during migration.

It must also provide honest foundations for:

- different canons and concrete publication arrangements;
- work-level citation systems and version-specific realizations;
- alternative boundaries, overlapping structures, and unnumbered content;
- translations, commentaries, supercommentaries, fragments, and testimonia;
- contextual, unresolved, ambiguous, and edition-neutral citations;
- physical manuscripts, inscriptions, fragments, surfaces, and witnesses;
- word, morpheme, marker, quote, point, spatial, and audio-time anchors;
- competing annotations and n-ary textual apparatus assertions;
- composite liturgies, lectionaries, anthologies, and interleaved editions;
- multilingual and projection-specific text bodies;
- immutable historical API retrieval;
- language-appropriate search, including unspaced Classical Chinese.

## Second adversarial audit verdict

Six independent reviewers attacked the previous plan against different textual traditions. They were instructed to find falsifying cases, cite authoritative sources, propose minimal corrections, and avoid editing the plan themselves.

| Independent review | Result | Principal failures found |
|---|---|---|
| Christian Bible | Fail for full scholarly fidelity | concrete Bible manifestations, cross-book selections, point/absence semantics, apparatus, historical releases |
| Qur'an | Conditional fail | qirāʾa transmission identity, token/marker anchors, annotation bodies, resource bundles, recitation series, revisions |
| Broader Abrahamic | Fail beyond linear editions | abstract citations, contextual references, lectionaries, manuscripts, ambiguous/n-ary claims, release closure |
| Ancient Greek | Conditional fail | Stephanus/Bekker identity, exemplars/papyri/inscriptions, fragments/testimonia, apparatus, local language |
| Ancient Roman/Latin | Conditional fail | physical objects/witnesses, epigraphy, fragmentary works, authorship/date claims, historical legal citations |
| Premodern Chinese | Conditional fail | canon-wide citations, composite commentarial editions, gaiji/IVS anchoring, witnesses, annotations, Chinese search |

All six agreed that the previous model is good for a **normalized reading edition**, including the present Gita. None agreed that it was yet a durable multicultural scholarly model.

The repeated failures were architectural rather than tradition-specific:

1. Mutable versions were not separated from immutable revisions.
2. Citation systems were incorrectly owned only by one version.
3. Selectors could not safely describe cross-resource, point, quote, spatial, or contextual targets.
4. Binary text-to-text relations could not represent literal/entity annotations, choices, or n-ary evidence.
5. Abstract collections could not represent concrete ordered selections and publication assemblies.
6. Physical artifacts, witnesses, transcriptions, and digital assets were conflated or absent.
7. Release manifests did not pin every response-affecting fact transitively.
8. Search and text anchoring assumed Western word boundaries and simple Unicode strings.

The previous plan is therefore superseded by the architecture below.

## Evidence behind the corrections

### Shared reference identity versus version realization

- CTS distinguishes notional works, editions/translations, exemplars, and a logical passage hierarchy that can apply across versions. It also treats literal substring positions as version-specific. Source: [CTS URN specification](https://cite-architecture.github.io/ctsurn_spec/).
- Sefaria separates an Index and its reference structure from the many editions and translations called Versions. This is not sufficient for all translation differences, but it confirms that `Genesis 1:1` can have identity before a digital edition is selected. Source: [Sefaria Index and Versions](https://developers.sefaria.org/docs/index-and-versions).
- Greek Stephanus and Bekker coordinates, Biblical versifications, and Chinese Taishō or concordance coordinates are scholarly address systems reused across versions or whole collections.

### Overlapping and non-citable structures

- USFM explicitly describes paragraphs and chapter/verse divisions as overlapping, non-hierarchical structures. Source: [USFM chapters and verses](https://docs.usfm.bible/usfm/3.1.2/cv/index.html).
- The basmala can be present but unnumbered before later surahs, showing that content identity cannot depend on an ayah number. Source: [Tanzil note on Bismillah](https://tanzil.net/docs/a_note_on_bismillah).
- EpiDoc distinguishes physical lines, semantic divisions, supplied restorations, and gaps. Sources: [EpiDoc line breaks](https://epidoc.stoa.org/gl/latest/trans-linebreak.html) and [supplied text](https://epidoc.stoa.org/gl/latest/ref-supplied.html).

### Apparatus, annotations, and scholarly evidence

- TEI apparatus groups a lemma, multiple readings and reading groups, witnesses, hands, responsibility, and uncertainty. A list of binary `variant_of` edges is not equivalent. Source: [TEI critical apparatus](https://tei-c.org/release/doc/tei-p5-doc/en/html/TC.html).
- W3C Web Annotation supports bodies, targets, choices, positions, text quotes, and other selector forms. OpenArtha should borrow that compositional idea without reducing ordered works to disconnected annotations. Source: [Web Annotation Data Model](https://www.w3.org/TR/annotation-model/).
- QUL exposes distinct resources for Qur'anic script, morphology, tafsir, layout, and recitation, confirming that annotation bodies and compatible resource components need their own release identity. Source: [QUL data model](https://qul.tarteel.ai/docs/data-model).

### Physical artifacts and witnesses

- TEI and EpiDoc distinguish physical objects, parts, surfaces, fragments, lines, texts, and editions. Sources: [TEI manuscript description](https://www.tei-c.org/release/doc/tei-p5-doc/en/html/MS.html) and [EpiDoc text parts](https://epidoc.stoa.org/gl/latest/trans-textpart.html).
- Papyri.info combines editions, translations, commentary, bibliography, images, and document identifiers without treating the image or database record as the ancient object. Source: [Papyri.info](https://papyri.info/).
- IIIF targets ordered canvases and spatial regions, which requires a spatial anchor rather than a time or character range. Source: [IIIF annotation example](https://iiif.io/api/cookbook/recipe/0269-embedded-or-referenced-annotations/).

### Collection-wide coordinates and Chinese text

- CBETA locators combine canon, volume, text number, page, column, and line, so the address space is not owned by one work version. Source: [CBETA linehead specification](https://www.cbeta-org-tw.cbeta.org/data-format/linehead.htm).
- Chinese Text Project exposes opaque URNs, concordance mappings, paragraph structures, and commentary alignments. Sources: [CTP API](https://ctext.org/tools/api) and [concordance documentation](https://ctext.org/tools/concordance).
- SQLite FTS5's ordinary tokenization and trigram behavior do not by themselves provide reliable one- and two-character Classical Chinese search. Source: [SQLite FTS5 documentation](https://www.sqlite.org/fts5.html).

## Architectural principle

Do not make a citation node, Unicode string, translation, manuscript, or current database row the universal textual identity.

Instead, separate seven orthogonal graphs:

```text
1. Catalog       Collection ──> Work ──> Version
                                      └──> immutable Version revision

2. Content       Revision ──> content units + anchor streams + projections

3. Reference     Reference system ──> entries ──> revision realizations
                                                        │
4. Addressing                                             ▼
                 Anchor = typed, immutable location(s)

5. Knowledge     Assertion/annotation = typed arguments over anchors,
                                           entities, values, and evidence

6. Evidence      Artifact ──> parts/surfaces; Witness maps text to artifact

7. Composition   Assembly revision ──> ordered anchors, choices, conditions

Release manifest = transitive closure of every object used by an API response
```

The common reader path remains small:

```text
work + reference + selected version revision
  → reference realization
  → text anchor
  → selected projection bodies
  → bounded related assertions
```

Physical evidence, apparatus, recitation, or complex assemblies are joined only when requested.

## Domain vocabulary

- **Identity record**: a stable opaque ID and type used by all public catalog objects.
- **Collection**: an abstract ordered or hierarchical grouping, canon, category, or catalog.
- **Work**: an abstract intellectual work.
- **Version**: a mutable catalog identity for an edition, recension, reading, translation, commentary, or research text.
- **Version revision**: an immutable published state of one version.
- **Projection**: a declared representation of one revision, such as diplomatic, normalized, punctuated, transliterated, or display text.
- **Content unit**: an ordered source block such as a paragraph, verse group, heading, note, or apparatus block.
- **Anchor stream**: an immutable ordered address layer within a revision, such as primary text segments, words, morphemes, glyphs, or markers.
- **Reference system**: a named scholarly, traditional, navigational, layout, or classification coordinate system.
- **Reference entry**: one node and locator within a reference system.
- **Realization**: a sourced statement that a reference entry is exact, partial, absent, or otherwise represented by an anchor in a revision.
- **Anchor**: one typed location or ordered composite of locations in immutable revisions, assets, artifacts, reference systems, or entities.
- **Assertion**: a sourced, status-bearing, possibly n-ary scholarly statement whose arguments can be anchors, entities, or literal/structured values.
- **Assembly**: a concrete ordered composition of exact revisions or anchors, with optional alternatives and applicability rules.
- **Artifact**: a physical codex, scroll, papyrus, stone, tablet, print exemplar, or other carrier.
- **Witness**: the evidence for a work or reading embodied by one or more artifact parts.
- **Asset**: a digital file or service representation, never the same identity as the artifact it depicts.
- **Release**: an immutable, transitively closed manifest of every response-affecting revision and assertion.

Use **passage** in generic product language. Terms such as verse, ayah, sloka, sutra, juan, daf, folio, or line remain data in named reference systems.

## Logical model

### 1. Identity registry and external identifiers

Every persistent public object registers one identity row. Typed tables reuse that ID as their primary key.

```text
identities
  id, identity_kind, created_at

identifiers
  id, identity_id, authority, value, canonical_uri,
  status, replaced_by_identifier_id, source_id

localized_names
  identity_id, language, script, name_kind, value,
  is_default, status, source_id
```

`identity_kind` includes collection, work, version, revision, projection, content unit, stream item, reference system, reference entry, anchor, assertion, apparatus entry, assembly, artifact, surface, witness, asset, media series, profile, source, agent, place, concept, and other explicitly registered kinds.

Rules:

- Public IDs are opaque and never parsed.
- `(authority, value)` is unique, but values remain opaque.
- Superseded external IDs redirect rather than disappear.
- Scalar `title` convenience columns may remain in compiled read tables, but multilingual names and disputed labels live here.
- Build validation proves that every identity has exactly one permitted primary subtype.
- Internal rows need not be registered, but any object exposed by an API, targeted by an external authority, or used as a durable anchor is registered.

This registry avoids an unchecked `subject_type/subject_id` while allowing CTP URNs, CTS URNs, CIL/EDH IDs, CBETA locators, shelfmarks, and legacy OpenArtha IDs to identify the appropriate resource level.

### 2. Collections, works, versions, and immutable revisions

```text
collections
  id, slug, collection_kind, description

collection_children
  parent_collection_id, child_collection_id, position, member_key

collection_works
  collection_id, work_id, position, member_key, status, source_id

works
  id, slug, description, primary_language

work_relations
  subject_work_id, predicate, object_work_id,
  status, confidence, source_id, note

work_agents
  work_id, agent_id, role, position, status,
  confidence, source_id

versions
  id, work_id, slug, version_kind, language_default,
  status, rights_status, current_revision_id

version_revisions
  id, version_id, revision_key, created_at, source_checksum,
  status, rights_status, supersedes_revision_id

version_relations
  subject_version_id, predicate, object_version_id,
  status, source_id, note

version_agents
  version_id, agent_id, role, position, status,
  confidence, source_id
```

Rules:

- Versions are catalog identities; all text, schemes, selectors, and bodies attach to immutable revisions.
- A released revision is append-only. Corrections create a new revision and explicit alignment/supersession records.
- A translation may be a version of the source work or a related independent work, according to catalog policy.
- An independently citable commentary is normally its own work and version.
- Work and version contributor roles include author, attributed author, compiler, redactor, translator, editor, commentator, collator, and digitizer.
- Disputed attribution and dates are assertions, not destructive scalar updates.
- `work_relations`, `work_agents`, and `version_agents` are indexed convenience projections of release-pinned assertions; the assertions remain the provenance-preserving source of truth.

### 3. Content units, anchor streams, and text projections

```text
content_units
  id, version_revision_id, parent_id, position, sequence,
  unit_kind, source_ref, review_status

anchor_streams
  id, version_revision_id, stream_kind, title,
  parent_stream_id, source_id, checksum

stream_items
  id, stream_id, content_unit_id, parent_item_id,
  ordinal, item_kind, stable_key, is_zero_width

text_projections
  id, version_revision_id, projection_kind, language,
  script, media_type, format, normalization_profile,
  offset_unit, source_projection_id, checksum

item_bodies
  stream_item_id, projection_id, position, body_kind,
  content, normalized_text, asset_revision_id, checksum
```

The primary stream contains durable source-order anchors. Additional streams can represent words, morphemes, glyphs, punctuation, pause markers, layout tokens, or another corpus-defined segmentation without turning words into reader passages.

Rules:

- Stream items are immutable inside a revision and have stored order; clients never infer order from IDs or reference strings.
- A marker, gap, omission point, heading, basmala, or milestone may be addressable and zero-width.
- Text projections state exactly what transformation they represent. Diplomatic, normalized, punctuated, simplified, transliterated, and restored text are never silently conflated.
- A projection may share an anchor stream only when its boundaries are genuinely compatible. Otherwise it uses another stream or another version revision with sourced alignment.
- Language and script are recorded at projection/body level and may be refined by span annotations for multilingual documents.
- Structured TEI, USJ, EpiDoc, or corpus JSON remains lossless archival content; `normalized_text` is a generated search/read projection.
- Offset validators use the projection's declared unit and checksum. They reject offsets inside an indivisible grapheme, ideographic variation sequence, gaiji surrogate, or corpus-defined atomic token.
- A new editorial boundary does not mutate a released stream. It creates a new revision and old-to-new alignment.
- Sourced assertions align subordinate streams to the primary stream; matching ordinals are never assumed to prove word, morpheme, or glyph equivalence.

### 4. Shared reference systems and revision realizations

```text
reference_systems
  id, slug, system_kind, authority, grammar,
  description, status, source_id

reference_system_revisions
  id, reference_system_id, revision_key, checksum, status

reference_system_work_scopes
  system_revision_id, work_id

reference_system_collection_scopes
  system_revision_id, collection_id

reference_system_version_scopes
  system_revision_id, version_revision_id

reference_system_artifact_scopes
  system_revision_id, artifact_revision_id

reference_entries
  id, system_revision_id, parent_id, ref, ref_part,
  unit_kind, position, navigation_ordinal, is_citable, label

reference_realizations
  id, reference_entry_id, version_revision_id, anchor_id,
  coverage, resolution_status, status, source_id, note

reference_aliases
  system_revision_id, alias_ref, reference_entry_id,
  alias_kind, status, source_id
```

One system may be scoped to a work, collection, exact version revision, or artifact revision without weak polymorphic foreign keys.

Examples:

- Gita chapter/sloka: work-scoped reference system.
- Bible source versification: work or collection scoped; each version has realizations.
- Qur'an regional verse counting: work-scoped systems with different entries/boundaries.
- Stephanus and Bekker: work-scoped scholarly coordinate systems.
- Taishō volume/page/column/line: collection-scoped system spanning works.
- Paragraphs or one publisher's page/line layout: version-revision or artifact scoped.
- Rigveda navigation containing an anuvaka omitted from a common citation: one entry can be navigable but non-citable.

`resolution_status` includes:

- `exact`
- `partial`
- `split`
- `merged`
- `reordered`
- `omitted`
- `supplied`
- `lacuna`
- `unmapped`
- `not_applicable`
- `ambiguous`
- `disputed`

An abstract citation never silently becomes a locator in the current default version. Resolution returns zero or more explicit realizations.

`anchor_id` is required for present textual realizations and nullable only for explicit states such as `omitted`, `unmapped`, or `not_applicable`. A lacuna or zero-width omission with a known location uses a boundary anchor rather than a null target.

Aliases are only alternate spellings and legacy URLs. A different hierarchy, ordering, or boundary is another reference system revision or realization mapping.

### 5. Typed immutable anchors

```text
anchors
  id, anchor_kind, status, created_in_release_id, description

text_anchor_parts
  anchor_id, position, version_revision_id, stream_id,
  start_item_id, start_edge, end_item_id, end_edge,
  projection_id, start_offset, end_offset, body_checksum

boundary_anchor_parts
  anchor_id, position, version_revision_id, stream_id,
  item_id, edge, affinity

reference_anchor_parts
  anchor_id, position, reference_entry_id

time_anchor_parts
  anchor_id, position, asset_revision_id, start_ms, end_ms

spatial_anchor_parts
  anchor_id, position, surface_revision_id,
  geometry_kind, geometry, coordinate_system

entity_anchor_parts
  anchor_id, position, identity_id

external_anchor_parts
  anchor_id, position, authority, locator, source_id

text_quote_descriptors
  anchor_id, part_position, projection_id, exact, prefix, suffix,
  normalization_profile, last_resolved_release_id, resolution_status
```

Rules:

- Every non-external part pins an immutable revision or immutable reference entry.
- A composite anchor can contain ordered parts from several works, revisions, or assets.
- A reference-system realization is normally constrained to one target revision even though general annotations and assemblies may use cross-resource composite anchors.
- Text ranges are half-open boundary intervals. Whole-item spans and zero-width points are structurally distinct.
- `edge` is `before` or `after`; `affinity` records how a point behaves when content is revised.
- Disjoint targets use multiple ordered parts, never a comma-separated locator grammar.
- Quote descriptors can refine positional anchors and support re-resolution after punctuation or normalization changes. Failure becomes `stale` or `review_required`, never a silent shift.
- Character/grapheme offsets require an immutable projection and checksum.
- Spatial anchors preserve coordinates now even if a facsimile viewer is deferred.

### 6. Assertions, annotations, and simple relations

```text
assertions
  id, predicate, motivation, status, confidence,
  source_id, asserting_agent_id, created_in_release_id, note

assertion_anchor_arguments
  assertion_id, position, role, anchor_id, choice_group, argument_group

assertion_entity_arguments
  assertion_id, position, role, identity_id, choice_group, argument_group

assertion_literal_arguments
  assertion_id, position, role, body_kind, language,
  media_type, value, structured_value, choice_group, argument_group
```

This is the general scholarly statement model. It supports:

- translation and commentary alignment;
- speaker, hand, author, compiler, or entity attribution;
- literal lemma, morphology, tajweed, topic, date, or grade annotations;
- competing candidate targets and explicit choices;
- fragments/testimonia pointing from surviving text to a lost work;
- quotation, allusion, parallel, and cross-reference assertions;
- contextual citations preserving raw surface and resolver evidence;
- witness and editorial evidence around a reading;
- commentary with several targets or several bodies.

Common predicates begin with:

- `aligns_with`
- `translates`
- `transliterates`
- `comments_on`
- `glosses`
- `quotes`
- `alludes_to`
- `parallel_to`
- `cross_references`
- `variant_of`
- `attested_by`
- `spoken_by`
- `attributed_to`
- `preserves_fragment_of`
- `testifies_to`
- `derived_from`

`status`, semantic predicate, coverage, evidence, and confidence remain separate facts.

A compiled `relations` read table may materialize assertions with exactly one subject anchor and one object anchor for fast current-reader queries. It is a projection, not the source of truth.

### 7. Minimal queryable textual apparatus

Generic assertions preserve unusual source structures, but common critical-apparatus queries need a small explicit projection.

```text
variation_units
  id, version_revision_id, lemma_anchor_id,
  apparatus_kind, status, source_id, responsible_agent_id

apparatus_readings
  id, variation_unit_id, parent_reading_id, position,
  reading_kind, reading_anchor_id, literal_body,
  is_lemma, preference, certainty

reading_attestations
  reading_id, witness_id, hand_identity_id,
  status, certainty, source_id, note
```

This is the minimum needed to ask which witnesses support a reading. Full TEI apparatus remains archival truth. Stemmatics, automatic collation, CBGM, and exhaustive hand modeling remain deferred.

Omissions use a boundary anchor or explicit empty reading, never fabricated text. An editorial conjecture can have zero witnesses.

### 8. Abstract collections versus concrete assemblies

Collections describe catalog membership. Assemblies describe an exact ordered composition.

```text
assemblies
  id, assembly_kind, status, current_revision_id

assembly_revisions
  id, assembly_id, revision_key, source_id, checksum,
  supersedes_revision_id

assembly_items
  id, assembly_revision_id, parent_item_id, position,
  anchor_id, included_revision_id, role,
  choice_group, applicability_expression, presentation_data, status
```

Assemblies represent:

- one concrete Bible publication selecting exact revisions and front/back matter;
- Torah/maftir/haftarah or Christian lectionary readings;
- a Chinese canon volume or anthology containing exact versions and excerpts;
- an interleaved base text, commentary, subcommentary, and rubric display;
- a fragment reconstruction using parts held in several repositories;
- a recitation playlist or source sheet.

Applicability expressions are declarative, schema-validated data for rite, locale, calendar, or audience. They never contain executable code.

Leaf items include exactly one anchor or exact component revision. Grouping items may contain neither and derive their content from children. `presentation_data` is validated structured data for source order, indentation, interleaving, typography role, or rubric behavior; it never replaces the underlying structured bodies.

An assembly orders anchors without copying their text. Choices remain choices rather than becoming a falsely exact disjoint range.

### 9. Artifacts, surfaces, and witnesses

```text
artifacts
  id, artifact_kind, repository_identity_id, shelfmark,
  material, description, status

artifact_revisions
  id, artifact_id, revision_key, checksum, status

artifact_parts
  id, artifact_revision_id, parent_id, part_kind,
  label, position, physical_order

surfaces
  id, artifact_part_id, position, side, canvas_identity_id,
  width, height, coordinate_system

surface_revisions
  id, surface_id, revision_key, asset_revision_id, checksum

witnesses
  id, work_id, witness_kind, siglum, status

witness_artifact_parts
  witness_id, artifact_part_id, role, position, source_id

witness_realizations
  witness_id, reference_entry_id, text_anchor_id,
  spatial_anchor_id, coverage, status, source_id
```

Invariants:

- Artifact, witness, abstract work, version revision, transcription, and digital image are distinct identities.
- One artifact can bear several works/witnesses.
- One witness can span several fragments, surfaces, or repositories.
- Physical order and reconstructed reading order are separate.
- Transcription and restoration claims point back to spatial or witness evidence.
- External IIIF canvases can be registered without copying image data.

### 10. Assets, media series, profiles, and dependency bundles

```text
assets
  id, asset_kind, current_revision_id

asset_revisions
  id, asset_id, media_type, uri, byte_size, duration_ms,
  width, height, checksum, rights_status, source_id

media_series
  id, series_kind, current_revision_id

media_series_revisions
  id, media_series_id, profile_id, checksum, status

media_series_items
  series_revision_id, position, asset_revision_id,
  anchor_id, role

profiles
  id, profile_kind, name, structured_definition,
  status, source_id

profile_agents
  profile_id, agent_id, role, position

component_bundles
  id, bundle_kind, revision_key, checksum

bundle_components
  bundle_id, position, role, identity_id, required_revision_id
```

Profiles can describe a qirāʾa/riwāya/ṭarīq, transcription policy, normalization, tokenization, search policy, or layout compatibility rule.

Bundles state required compatibility explicitly:

- a mushaf layout requires a script/token stream, font pages, layout data, and metadata;
- a recitation timing dataset requires an audio series and anchor stream;
- a glyph projection requires compatible fonts;
- a diplomatic edition may require a witness, projection profile, and facsimile manifest.

A recitation series groups 114 surah files or ayah files under one reciter, reading profile, release, and timing identity. An individual asset URL is not the recitation.

### 11. Citation occurrences and contextual resolution

```text
citation_occurrences
  id, citing_anchor_id, raw_surface, raw_locator,
  context_anchor_id, language, source_id

citation_candidates
  citation_occurrence_id, position, reference_entry_id,
  anchor_id, resolution_status, confidence,
  resolver_profile_id, asserting_agent_id
```

This preserves `ibid.`, incipit-based citations, `supra lex proxima`, dibbur ha-matḥil, erroneous locators, and unresolved historical references without inventing a target.

Resolvers may propose several candidates. Human review can verify one while retaining the original surface and rejected alternatives.

### 12. Sources, entities, dates, and review

```text
agents
  id, agent_kind, description

entities
  id, entity_kind, description

sources
  id, source_kind, citation, locator_url,
  repository_commit, license_id, license_url,
  rights_note, checksum

review_events
  id, assertion_id, reviewing_agent_id,
  decision, note, created_at
```

People, organizations, places, offices, characters, narrative units, concepts, and bibliographic entities receive authority identities only when the corpus needs them. Text mentions target entity identities through assertions.

Dates, authorship, provenance, discovery, location, and attribution are sourced assertions with intervals, uncertainty, and alternatives—not destructive scalar facts.

### 13. Transitively closed releases

```text
releases
  id, slug, status, generated_at, manifest_uri,
  root_checksum, supersedes_release_id

release_manifest_entries
  release_id, identity_id, revision_id,
  component_kind, role, checksum

release_dependencies
  release_id, subject_revision_id, predicate,
  object_revision_id
```

A release validator computes the transitive closure of every API-visible component, including:

- collections and assemblies;
- works, versions, revisions, and projections;
- reference systems, entries, and realizations;
- streams, anchors, assertions, apparatus, and citation candidates;
- sources, agents, entities, rights, and localized names;
- artifacts, witnesses, surfaces, assets, profiles, and bundles;
- search projections and generated API indexes.

Changing only canon order, a source attribution, rights status, identifier redirect, witness support, or citation realization creates a different release checksum.

Released rows are append-only. The manifest is canonical and signed/checksummed; D1 is a compiled read model.

## API V3 revision

Every read is release-resolvable. `release` may be omitted only as an explicit request for the current release.

### Catalog and identity

```text
GET /api/v3/collections?release=...
GET /api/v3/works/{work}?release=...
GET /api/v3/works/{work}/versions?release=...
GET /api/v3/works/{work}/versions/{version}/revisions
GET /api/v3/identifiers/{authority}/{opaqueValue}?release=...
GET /api/v3/entities/{entity}?release=...
GET /api/v3/releases/{release}
```

### Reference resolution and navigation

```text
GET /api/v3/reference-systems/{system}?release=...
GET /api/v3/reference-systems/{system}/entries/{ref}?release=...
GET /api/v3/reference-systems/{system}/entries/{ref}/realizations
    ?version=...&revision=...&release=...

GET /api/v3/works/{work}/navigation
    ?system=...&ref=...&revision=...&depth=1&release=...

GET /api/v3/resolve
    ?authority=cbeta&identifier=T30n1579_p0517b06&release=...
```

Use `ref` as a query parameter when an imported grammar does not fit safely in a path. The Gita convenience route may retain path references.

A resolution response returns:

- requested surface/system/ref;
- abstract reference entry;
- zero or more revision realizations;
- anchor parts and coverage/status;
- selected projection bodies;
- source and review evidence;
- immutable release and checksums;
- links to bounded related assertions.

### Passage/body access

```text
GET /api/v3/works/{work}/versions/{version}/passages
    ?system=...&ref=...&revision=...&projection=...&release=...

GET /api/v3/anchors/{anchor}?projection=...&release=...
GET /api/v3/anchors/{anchor}/assertions
    ?predicate=comments_on&match=overlaps&limit=50&release=...
```

`match` is one of `exact`, `overlaps`, `contains`, or `contained_by`. A word-level note must be discoverable when its enclosing passage is requested.

Do not embed every translation, commentary, apparatus, or media resource by default. Return the selected body, bounded summaries, and paginated links.

### Assemblies, evidence, and apparatus

```text
GET /api/v3/assemblies/{assembly}?revision=...&release=...
GET /api/v3/artifacts/{artifact}?release=...
GET /api/v3/witnesses/{witness}?release=...
GET /api/v3/surfaces/{surface}/annotations?release=...
GET /api/v3/apparatus?revision=...&within=...&witness=...&release=...
GET /api/v3/media-series/{series}?release=...
```

### Contextual citation resolution

```text
POST /api/v3/citations/resolve?release=...
{
  "surface": "ibid., section 2",
  "contextAnchor": "anchor_...",
  "system": null,
  "language": "la"
}
```

This endpoint is nondestructive. It returns candidates and never silently overwrites the stored citation occurrence.

### Search

```text
GET /api/v3/search
    ?q=...&collection=...&work=...&version=...
    &system=...&language=...&profile=...&release=...
```

Search profiles compile immutable, release-pinned projections:

- whitespace/token search for suitable languages;
- exact and normalized Sanskrit/Greek/Latin/Arabic/Hebrew modes;
- word/morpheme search where a validated anchor stream exists;
- single-character, bigram, and longer substring postings for Classical Chinese;
- exact-source and normalized/variant-aware Chinese modes kept distinct;
- structured filters for entity, lemma, root, POS, witness, or apparatus only when those modules are present.

Search never mutates diplomatic text. Results include projection, anchor, reference-system realizations, normalization/search profile, and release.

### Content negotiation and compatibility

- Continue `Accept: application/json` and `Accept: text/markdown`.
- Add lossless source formats such as TEI/USJ only where a release declares them.
- V1/V2 remain adapters over one configured Gita release, version revision, projection set, and reference system.
- Existing `chapter/verse` parameters become a Gita reference lookup; legacy `gita.x.y` IDs resolve through the identifier registry.
- D1 and bundled fallback implement one repository interface.

Stable errors add:

- `REFERENCE_NOT_REALIZED`
- `REFERENCE_AMBIGUOUS`
- `RELEASE_NOT_FOUND`
- `REVISION_NOT_FOUND`
- `SELECTOR_STALE`
- `PROJECTION_NOT_AVAILABLE`
- `IDENTIFIER_REDIRECT`
- `WITNESS_NOT_FOUND`
- `TRANSCRIPTION_VIEW_NOT_AVAILABLE`

## Efficient physical implementation

The logical graph is richer, but the common reader path should not execute arbitrary graph traversals.

Compile these current-release projections into D1:

```text
current_reference_lookup
  system_id, ref, entry_id, revision_id, anchor_id,
  coverage, resolution_status, navigation_ordinal

current_anchor_intervals
  anchor_id, revision_id, stream_id,
  ordinal_start, ordinal_end, is_contiguous

current_passage_bodies
  entry_id, revision_id, projection_id,
  content_chunks, normalized_text, checksum

current_relation_edges
  subject_anchor_id, predicate, object_anchor_id,
  ordinal_start, ordinal_end, status

current_search_documents
  release_id, projection_id, anchor_id, search_profile_id,
  work_id, version_id, language, content
```

Indexes cover:

- `(system_revision_id, ref)`;
- `(system_revision_id, parent_id, position)`;
- `(system_revision_id, navigation_ordinal)`;
- revision/stream interval overlap;
- assertion predicate and argument anchor;
- collection/work/version filters;
- identity authority/value;
- current-release component joins.

Composite and non-contiguous anchors keep normalized part rows. Contiguous anchors additionally receive cached ordinal bounds.

Historical releases remain immutable normalized artifacts. The repository can load a release-qualified bundle from object storage; D1 serves current and optionally recent hot releases. The API contract is identical regardless of storage path.

Continue chunking generated SQL and large bodies to remain below D1 statement/row limits. Sources: [D1 limits](https://developers.cloudflare.com/d1/platform/limits/) and [D1 index guidance](https://developers.cloudflare.com/d1/best-practices/use-indexes/).

## Current OpenArtha migration mapping

| Existing data/function | Revised representation |
|---|---|
| Bhagavad Gita | work |
| standard Sanskrit corpus | version + immutable revision |
| Devanagari and IAST | compatible text projections over one anchor stream |
| Telang English | translation version/revision with alignment assertions |
| chapter/sloka | work-scoped reference system and entries |
| chapter title/breadcrumbs | reference entry labels and ancestry |
| previous/next verse | reference-entry navigation ordinal |
| commentary author stream | commentary work/version/revision |
| commentary-to-passage link | `comments_on` assertion over anchors |
| one commentary spanning 1.36–1.37 | one commentary anchor targeting a range anchor |
| commentary paratext | ordered content with no target assertion |
| `gita.x.y` | legacy identifier/alias resolving to reference entry |
| passage API | configured reference realization and projection read |
| author/chapter view | commentary assembly or ordered revision units filtered by overlapping target |
| variants | anchored assertion; apparatus projection when witnesses/readings are modeled |
| bundled fallback | generated release bundle behind shared repository interface |

## Adversarial fixture matrix

The model is not accepted because diagrams appear general. Tests must encode real structural failures.

### Hindu/Indic

- Gita chapter/sloka, Devanagari/IAST projections, translation and commentary relations.
- Ramayana kanda/sarga/sloka.
- Rigveda navigation containing a non-reference anuvaka.
- Upanishad recension with mixed prose/mantra content.
- Sutra work with non-verse leaf terminology.
- Ramcharitmanas mixed numbered and unnumbered forms.
- Commentary span and ordered unaligned paratext.

### Christian Bible

- Catholic Baruch 1–6 versus separate Letter of Jeremiah arrangement.
- Greek Daniel additions embedded versus separate.
- Psalm superscription citable in one system and paratext in another.
- Verse bridge/split plus a citable but omitted verse.
- Paragraph and poetic line crossing verse milestones.
- One parallel heading targeting Mark, Luke, and John as an ordered group.
- Lectionary unit with nonconsecutive passages, supplied incipit, and alternatives.
- Apparatus lemma with several readings, witnesses, omission, and correction.
- Release R2 splits a segment while R1 remains exactly retrievable.

### Qur'an and Islamic resources

- Kūfan and another documented counting boundary.
- Present unnumbered basmala before surah 2 and none before surah 9.
- Q 1:4 reading profile distinguishing *māliki/maliki* with reader/transmitter/source lineage.
- Context-dependent pause/continuation realization.
- Paired stop positions as distinct boundary anchors with a shared constraint.
- Juzʾ/hizb and page/line structures overlapping surah/ayah.
- Grouped tafsir and supercommentary.
- Independent morphology analyses targeting stable word/morpheme stream items.
- Recitation series with reading profile, audio assets, and timing anchors.
- Two hadith grades by different graders retained as separate assertions.

### Broader Abrahamic

- Version-neutral `Genesis 1:1` with different version realizations.
- Talmud daf and chapter/Mishnah structures over one content flow.
- Dibbur ha-matḥil quote anchoring survives punctuation revision or becomes review-required.
- `ibid.` citation resolved only with preserved context.
- Torah/maftir/haftarah assembly with rite and locale alternatives.
- Ketiv/qere/omission with witness support.
- Dead Sea Scroll fragment with reconstruction, damage, signs, and image regions.
- One Genizah artifact containing parts of two works and competing reconstruction orders.
- Isnad and matn separately addressable; parallel matns align without merging identities.

### Ancient Greek

- Homer `Iliad 1.1` realized by Greek and translation revisions.
- Dramatic line split across speakers and speeches; speaker entity assertion.
- Plato Stephanus and Aristotle Bekker coordinates shared across editions.
- Fragmentary historian: preserving source, lost-work attribution, testimonium, translation, commentary, and competing concordances.
- Papyrus IDs co-refer while recto/verso, columns, logical text, and images remain distinct.
- Inscription fragments reconstructed in disputed order with gaps and supplied text.
- Multilingual document with local language/script.
- Scholia tied to lemma, manuscript, folio, and hand.

### Ancient Roman/Latin

- Cicero book/section; Pliny book/letter/section; Ovid book/line.
- Plautus speech crossing verse lines and non-citable stage direction.
- Roman-law references with different depths, including `pr`.
- Vulgate volume/column plus lemma-attached gloss.
- Contextual `supra lex proxima` preserved as ambiguous without context.
- One stone bearing two texts and one text reconstructed from several stones.
- Bilingual Latin/Greek inscription.
- Fragmentary author with quotation, testimonium, and edition concordance.
- Competing sourced authorship and date assertions.

### Premodern Chinese

- Jing–shi–zi–ji classification plus a collection containing an exact version and excerpt.
- Variable juan strings, preface, table of contents, and appendix.
- CBETA collection/volume/text/page/column/line resolution without prior work slug.
- Work crossing physical volumes while logical navigation remains continuous.
- Interleaved base, commentary, subcommentary, phonetic gloss, and small-character note.
- Unpunctuated diplomatic text plus two competing punctuation projections.
- Non-invertible traditional/simplified mapping.
- TEI gaiji and Unicode IVS round-trip with safe anchors.
- Vertical block-print surfaces, columns, lines, and image regions.
- Table, diagram, poetry couplets, and rhyme annotation.
- One- and two-character search inside long unpunctuated content.

## Cross-fixture invariants

- Abstract reference identity is never coerced to a default version.
- Every text position pins one immutable revision/projection checksum.
- Released objects are never updated in place.
- Points, empty readings, nonempty spans, gaps, and absent realizations are distinct.
- Composite anchors preserve cross-work part order.
- Reference realization coverage is explicit and never assumed exact.
- Relations discovered by overlap include sub-passage notes in enclosing-passage reads.
- Alternative targets remain choices, not a false disjoint exact match.
- Artifact, witness, work, version, transcription, and asset identities remain distinct.
- One artifact may bear many texts; one witness may span many artifact parts.
- Every apparatus reading can enumerate supporting witnesses or explicitly have none.
- Unresolved and ambiguous historical citations remain valid stored data.
- Diplomatic, normalized, punctuated, restored, and transliterated projections declare their policies.
- Language may vary below version level.
- Every API-visible fact is in the release's verified transitive closure.
- Historical release retrieval reproduces bodies, references, assertions, identifiers, search results, checksums, and ETags.
- Archival TEI/USJ/EpiDoc/source data round-trips even when D1 materializes only common projections.

## Implementation phases

### Phase 0 — contract freeze and falsifying fixtures

- Snapshot current Gita V1/V2 payloads, counts, search behavior, source links, rights, checksums, and ETags.
- Encode the smallest fixture from each tradition before finalizing SQL.
- Define TypeScript contracts and validators for revisions, references, anchors, assertions, assemblies, and releases.
- Benchmark the common passage path and relation-overlap query on fixture-scale D1.

### Phase 1 — immutable reading core

- Add identity registry, works, versions/revisions, content units, primary anchor streams, text projections, reference systems/entries/realizations, simple text anchors, sources, and closed release manifests.
- Build deterministic normalized JSONL and D1 projections.
- Implement current-release catalog, navigation, passage, and search repository operations.
- Keep current pages and V1/V2 on the old model.

### Phase 2 — assertions, identifiers, and assemblies

- Add external identifiers, typed anchors, multi-argument assertions, quote and boundary anchors, ordered assembly revisions, contributor roles, and contextual citation occurrences.
- Add overlap indexes and bounded assertion APIs.
- Add one Bible/lectionary and one Chinese/composite fixture to prove cross-work ordering.

### Phase 3 — evidence and resource modules

- Add artifacts, parts/surfaces, witnesses, spatial anchors, assets, profiles, bundles, media series, and minimal apparatus projection.
- Prove one manuscript/inscription fixture, one apparatus fixture, and one Qur'anic recitation/layout bundle.
- Archival source markup remains authoritative; only common query dimensions are normalized.

### Phase 4 — migrate the Gita corpus

- Create the Gita work, Sanskrit version revision, Devanagari/IAST projections, and chapter/sloka reference system.
- Import Telang as a translation revision with alignment assertions.
- Import commentaries as independent ordered works/versions, preserving paratext and the span exception.
- Register every legacy URL/ID and compare all current counts, bodies, sources, rights, reviews, checksums, and search results.

### Phase 5 — publish V3 and adapters

- Publish release-qualified catalog, reference, passage, anchor, assertion, assembly, evidence, and search endpoints.
- Implement D1 current-release and immutable-bundle historical adapters.
- Make V1/V2 thin adapters only after exhaustive equivalence tests.
- Preserve JSON/Markdown behavior and documented ETags.

### Phase 6 — reader migration and real pilots

- Replace Gita-specific parsing, sorting, labels, breadcrumbs, and sitemap logic with returned reference metadata.
- Import at least one licensed real corpus from each structural family before declaring the model stable; synthetic fixtures alone are insufficient.
- Do not claim every philological feature is implemented merely because its extension point exists.
- Ask the user to review locally before any push or deployment. Do not use browser automation for verification.

## First implementation slice

Implement only the smallest foundation that is difficult to change later:

1. Identity registry and immutable `version_revisions`.
2. Primary content stream plus Devanagari/IAST projections.
3. Work-scoped Gita reference system and revision realizations.
4. Text-range, boundary, reference, and entity anchors.
5. Simple assertions compiled to fast binary relation edges.
6. Transitively closed release manifest.
7. Gita conversion plus one boundary-split Bible/Qur'an fixture and one collection-scoped Chinese coordinate fixture.
8. D1 and bundled repository parity for catalog, resolve, passage, navigation, relations, and search.
9. Read-only V3 routes and V1/V2 equivalence tests; no production cutover.

Do not build a manuscript viewer, complete apparatus UI, qirāʾāt rule engine, or historical calendar engine in this slice. Their identities and anchor types are designed now; their feature modules follow only when a real corpus requires them.

## Acceptance criteria before schema freeze

- All 700 Gita references and all legacy IDs resolve exactly in every supported release.
- Existing Sanskrit, IAST, Telang, commentary, paratext, source, review, rights, checksum, search, JSON, and Markdown behavior round-trips.
- One abstract reference has exact, partial, omitted, and split realizations in different revisions without changing its identity.
- One ordered assembly combines anchors from several works without copying text.
- One point marker, one empty reading, one gap, and one nonempty range remain structurally distinct.
- One quote anchor re-resolves safely after punctuation change or becomes review-required.
- One apparatus fixture enumerates readings and witness attestations.
- One artifact bears multiple texts and one witness spans multiple artifact parts.
- One spatial and one time anchor survive asset URL changes through stable revision identity.
- One resource bundle rejects an incompatible script/font/layout combination.
- One recitation series groups ordered assets and timings under a reading profile.
- One collection-scoped reference resolves without first knowing a work/version slug.
- Classical Chinese one- and two-character search is reproducible and differs intentionally from normalized/variant-aware modes.
- Changing any API-visible assertion or metadata changes the release checksum.
- Old release URLs remain fully retrievable after content, segmentation, or metadata corrections.
- D1 and bundled adapters pass identical contracts for current data.
- All six adversarial fixture groups pass their applicable invariants.

## Safe deferrals

Safe after the foundations exist:

- automatic versification, translation, commentary, or fragment alignment;
- automatic citation extraction and contextual resolution;
- complete morphology, syntax, prosody, tajweed, and stemmatics;
- full isnad/rijāl/person-identity graph analytics;
- automatic collation, CBGM, and manuscript reconstruction;
- IIIF viewer, polygon editor, OCR/HTR, and 3D artifacts;
- executable qirāʾāt or liturgical-calendar rule engines;
- automatic Chinese punctuation, variant expansion, and word segmentation;
- full CTS, DTS, Sefaria, USFM, TEI, EpiDoc, IIIF, or RDF protocol conformance.

Not safe to defer before claiming broad scholarly support:

- immutable revisions and historical retrieval;
- shared reference systems plus revision realizations;
- explicit point/absence/quote/spatial anchor semantics;
- cross-resource composite anchors;
- annotation/assertion bodies and choices;
- concrete assemblies;
- artifact/witness identity;
- minimal reading/witness apparatus;
- projection-local language and normalization policy;
- generic external identifiers;
- transitive release closure;
- search profiles appropriate to the language.

## Rejected alternatives

### One version tree plus aliases

Aliases cannot express split boundaries, cross-version identity, canon-wide coordinates, overlapping structures, or missing realizations.

### Citation entries as stored text identity

This loses unnumbered content, gaps, markers, and alternative boundaries. Reference entries must realize anchors rather than own the text.

### Every translation/commentary as a layer

Translations and commentaries have independent order, paratext, revisions, sources, and sometimes their own commentaries. Compatible visual projections remain lightweight; textual expressions are versions.

### Binary relations as the entire annotation model

Binary edges cannot represent literal morphology, speaker/entity bodies, choices, apparatus groups, multiple witnesses, or ambiguous candidate targets. They remain a useful compiled read projection.

### One generic polymorphic foreign key

Unchecked `type/id` columns are easy to corrupt. Identity registration plus typed argument/selector tables preserve referential integrity.

### Treat assets as manuscripts or inscriptions

An image URL is not the physical object, witness, text, or transcription. Those identities and their relationships must remain separate.

### Store only normalized plain text

Normalized text is useful for search, not archival truth. Structured bodies must preserve gaps, supplied text, notes, glyph variants, typography, and responsibility.

### One tokenizer for every language

Search behavior is part of the release and depends on language, projection, and corpus policy. Classical Chinese alone disproves a universal whitespace/trigram solution.

### Adopt one external standard wholesale

CTS, TEI, DTS, USFM/USX, Sefaria, QUL, EpiDoc, IIIF, CBETA, and Web Annotation each solve different parts. OpenArtha should import/export them where valuable while keeping a small indexed reader projection over an immutable normalized graph.

## Honest completion boundary

This plan establishes a model that can represent the adversarial cases without corrupting their identity or evidence. It does not prove that every culture or every scholarly practice is already supported.

The schema may be called **architecturally durable** only after all listed fixtures pass. OpenArtha may be called **multicultural in practice** only after licensed real corpora from several traditions are imported, independently reviewed, and served through both storage adapters without tradition-specific schema changes.
