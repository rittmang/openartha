// Correct metadata for the pinned import without changing text or another source.
export function commentaryReviewReleaseSql(source) {
  const quote = (value) => `'${value.replaceAll("'", "''")}'`;
  const eligibleSources = `SELECT id FROM commentary_sources WHERE id = ${quote(source.source.id)} AND commit_sha = ${quote(source.source.commit)} AND corpus_version IN ('gita-commentaries-0.2.0', ${quote(source.corpusVersion)})`;
  const editions = `SELECT id FROM commentary_editions WHERE source_id IN (${eligibleSources}) AND corpus_version IN ('gita-commentaries-0.2.0', ${quote(source.corpusVersion)})`;
  return [
    'PRAGMA foreign_keys=ON;',
    `UPDATE commentary_units SET alignment_status = 'machine-validated; human review pending' WHERE passage_id IS NOT NULL AND edition_id IN (${editions});`,
    `UPDATE commentary_editions SET corpus_version = ${quote(source.corpusVersion)} WHERE id IN (${editions});`,
    `UPDATE commentary_sources SET corpus_version = ${quote(source.corpusVersion)} WHERE id IN (${eligibleSources});`,
  ].join('\n--> statement-breakpoint\n') + '\n';
}
