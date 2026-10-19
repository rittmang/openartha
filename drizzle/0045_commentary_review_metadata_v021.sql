PRAGMA foreign_keys=ON;
--> statement-breakpoint
UPDATE commentary_units SET alignment_status = 'machine-validated; human review pending' WHERE passage_id IS NOT NULL AND edition_id IN (SELECT id FROM commentary_editions WHERE source_id IN (SELECT id FROM commentary_sources WHERE id = 'vedicscriptures-bhagavad-gita' AND commit_sha = '43dfc8db815d01e15a347ea294b089334cf2aa17' AND corpus_version IN ('gita-commentaries-0.2.0', 'gita-commentaries-0.2.1')) AND corpus_version IN ('gita-commentaries-0.2.0', 'gita-commentaries-0.2.1'));
--> statement-breakpoint
UPDATE commentary_editions SET corpus_version = 'gita-commentaries-0.2.1' WHERE id IN (SELECT id FROM commentary_editions WHERE source_id IN (SELECT id FROM commentary_sources WHERE id = 'vedicscriptures-bhagavad-gita' AND commit_sha = '43dfc8db815d01e15a347ea294b089334cf2aa17' AND corpus_version IN ('gita-commentaries-0.2.0', 'gita-commentaries-0.2.1')) AND corpus_version IN ('gita-commentaries-0.2.0', 'gita-commentaries-0.2.1'));
--> statement-breakpoint
UPDATE commentary_sources SET corpus_version = 'gita-commentaries-0.2.1' WHERE id IN (SELECT id FROM commentary_sources WHERE id = 'vedicscriptures-bhagavad-gita' AND commit_sha = '43dfc8db815d01e15a347ea294b089334cf2aa17' AND corpus_version IN ('gita-commentaries-0.2.0', 'gita-commentaries-0.2.1'));
