export function arnoldSeedSql(translation) {
  const sql = (value) => value === null ? 'NULL' : typeof value === 'number' ? String(value) : `'${String(value).replaceAll("'", "''")}'`;
  const statements = ['PRAGMA foreign_keys=ON;'];
  function insert(table, columns, rows, ignore = false) {
    const prefix = `INSERT ${ignore ? 'OR IGNORE ' : ''}INTO ${table} (${columns.join(',')}) VALUES\n`;
    let batch = [];
    let bytes = 0;
    for (const row of rows) {
      const value = `(${row.map(sql).join(',')})`;
      if (batch.length && bytes + Buffer.byteLength(value) > 70_000) {
        statements.push(prefix + batch.join(',\n') + ';');
        batch = [];
        bytes = 0;
      }
      batch.push(value);
      bytes += Buffer.byteLength(value) + 2;
    }
    if (batch.length) statements.push(prefix + batch.join(',\n') + ';');
  }
  insert('commentary_sources', ['id', 'title', 'repository_url', 'commit_sha', 'license', 'license_url', 'corpus_version'], [[translation.source.id, translation.title, translation.source.catalogUrl, translation.source.sha256, translation.source.rights, translation.source.licenseUrl, translation.corpusVersion]], true);
  insert('commentary_authors', ['id', 'source_key', 'display_name', 'available_fields', 'public_fields', 'rights_status', 'rights_note'], [[translation.id, translation.source.id, translation.translator, '["et"]', '["et"]', 'full-text-allowed', `${translation.source.rights}. Project Gutenberg ebook #2388; ${translation.reviewStatus}.`]], true);
  insert('commentary_editions', ['id', 'author_id', 'source_id', 'field_code', 'language', 'script', 'content_type', 'public_text', 'rights_status', 'corpus_version'], [['edwin-arnold-et', translation.id, translation.source.id, 'et', 'en', 'Latn', 'translation', 1, 'full-text-allowed', translation.corpusVersion]], true);
  statements.push("DELETE FROM commentary_fts WHERE unit_id IN (SELECT id FROM commentary_units WHERE edition_id = 'edwin-arnold-et');");
  statements.push("DELETE FROM commentary_unit_chunks WHERE unit_id IN (SELECT id FROM commentary_units WHERE edition_id = 'edwin-arnold-et');");
  statements.push("DELETE FROM commentary_units WHERE edition_id = 'edwin-arnold-et';");
  const units = translation.verses.map((verse) => [verse.id, verse.editionId, verse.canonicalRef, verse.chapter, verse.verse, 'passage-commentary', verse.alignmentRelation, verse.alignmentStatus, verse.sourceLocator, verse.rawChecksum, verse.checksum]);
  const paratext = translation.paratext.map((item) => ({ id: `edwin-arnold-et:paratext:${item.chapter}:${item.type}`, ...item }));
  units.push(...paratext.map((item) => [item.id, 'edwin-arnold-et', null, item.chapter, 0, item.type, null, 'paratext-preserved', `pg2388.txt:L${item.sourceSpan.lineStart}–L${item.sourceSpan.lineEnd}`, item.sourceSpan.checksum, item.checksum]));
  insert('commentary_units', ['id', 'edition_id', 'passage_id', 'source_chapter', 'source_verse', 'unit_type', 'alignment_relation', 'alignment_status', 'source_locator', 'raw_checksum', 'display_checksum'], units);
  insert('commentary_unit_chunks', ['unit_id', 'chunk_index', 'content'], [...translation.verses.map((verse) => [verse.id, 0, verse.content]), ...paratext.map((item) => [item.id, 0, item.text])]);
  insert('commentary_fts', ['unit_id', 'author', 'canonical_ref', 'language', 'content_type', 'content'], translation.verses.filter((verse) => verse.content).map((verse) => [verse.id, verse.author, verse.canonicalRef, verse.language, verse.contentType, verse.content]));
  return statements.join('\n--> statement-breakpoint\n') + '\n';
}
