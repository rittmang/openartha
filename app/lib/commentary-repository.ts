import type { Commentary } from './commentaries';

export type CommentaryRow = {
  id: string;
  canonical_ref: string;
  chapter: number;
  verse: number;
  author_id: string;
  display_name: string;
  edition_id: string;
  field_code: string;
  language: string;
  script: string;
  content_type: string;
  content: string;
  source_locator: string;
  repository_url: string;
  commit_sha: string;
  license: string;
  alignment_relation: string | null;
  alignment_status: string;
  raw_checksum: string;
  display_checksum: string;
  corpus_version: string;
};

type ReadingMetadata = Pick<Commentary, 'id' | 'canonicalRef' | 'editionId' | 'checksum' | 'corpusVersion' | 'alignmentStatus'>
  & Partial<Pick<Commentary, 'sourceCommit' | 'sourceChecksum' | 'alignment' | 'firstReview'>>;

export function toCommentary(row: CommentaryRow, metadata?: ReadingMetadata): Commentary {
  const record: Commentary = {
    id: row.id,
    canonicalRef: row.canonical_ref,
    chapter: row.chapter,
    verse: row.verse,
    authorId: row.author_id,
    author: row.display_name,
    editionId: row.edition_id,
    fieldCode: row.field_code,
    language: row.language,
    script: row.script,
    contentType: row.content_type,
    content: row.content,
    sourceLocator: row.source_locator,
    sourceUrl: row.repository_url,
    sourceCommit: row.commit_sha,
    rights: row.license,
    alignmentRelation: row.alignment_relation ?? undefined,
    alignmentStatus: row.alignment_status,
    rawChecksum: row.raw_checksum,
    checksum: row.display_checksum,
    corpusVersion: row.corpus_version,
  };
  // Supplemental provenance describes a pinned record, never an alternative text store.
  if (!metadata || metadata.id !== record.id || metadata.canonicalRef !== record.canonicalRef
    || metadata.editionId !== record.editionId || metadata.checksum !== record.checksum
    || metadata.corpusVersion !== record.corpusVersion || metadata.alignmentStatus !== record.alignmentStatus
    || (metadata.sourceChecksum && metadata.sourceChecksum !== row.commit_sha)) return record;
  return {
    ...record,
    sourceCommit: metadata.sourceCommit ?? record.sourceCommit,
    ...(metadata.sourceChecksum ? { sourceChecksum: metadata.sourceChecksum } : {}),
    ...(metadata.alignment ? { alignment: metadata.alignment } : {}),
    ...(metadata.firstReview ? { firstReview: metadata.firstReview } : {}),
  };
}

const selectCommentary = `
  SELECT u.id, u.passage_id AS canonical_ref, p.chapter, p.verse, e.author_id, a.display_name,
    e.id AS edition_id, e.field_code, e.language, e.script, e.content_type,
    (SELECT group_concat(content, '') FROM (
      SELECT content FROM commentary_unit_chunks WHERE unit_id = u.id ORDER BY chunk_index
    )) AS content,
    u.source_locator, s.repository_url, s.commit_sha, s.license,
    u.alignment_relation, u.alignment_status, u.raw_checksum, u.display_checksum, e.corpus_version
  FROM commentary_units u
  JOIN passages p ON p.id = u.passage_id
  JOIN commentary_editions e ON e.id = u.edition_id
  JOIN commentary_authors a ON a.id = e.author_id
  JOIN commentary_sources s ON s.id = e.source_id
`;

export async function getPassageReadingRows(db: D1Database, chapter: number, verse: number) {
  const result = await db.prepare(`${selectCommentary}
    WHERE u.passage_id = ? AND e.public_text = 1
    ORDER BY a.display_name, e.content_type, e.language, u.id`).bind(`gita.${chapter}.${verse}`).all<CommentaryRow>();
  return result.results;
}

export async function getAuthorChapterReadingRows(db: D1Database, authorId: string, chapter: number) {
  const result = await db.prepare(`${selectCommentary}
    WHERE e.author_id = ? AND p.chapter = ? AND e.public_text = 1
    ORDER BY p.verse, e.content_type, e.language, u.id`).bind(authorId, chapter).all<CommentaryRow>();
  return result.results;
}

export async function searchReadingRows(db: D1Database, match: string, limit: number) {
  const hits = await db.prepare(`
    SELECT u.id
    FROM commentary_fts f
    JOIN commentary_units u ON u.id = f.unit_id
    JOIN passages p ON p.id = u.passage_id
    JOIN commentary_editions e ON e.id = u.edition_id
    JOIN commentary_authors a ON a.id = e.author_id
    WHERE commentary_fts MATCH ? AND e.public_text = 1
    ORDER BY bm25(commentary_fts), p.chapter, p.verse, a.display_name, u.id
    LIMIT ?
  `).bind(match, Math.min(limit * 4, 240)).all<{ id: string }>();
  const ids = [...new Set(hits.results.map((hit) => hit.id))].slice(0, limit);
  if (!ids.length) return [];
  // An FTS hit identifies a record. Read its complete chunks through the same query
  // as passage/chapter retrieval, then restore the ranking from the hit list.
  const result = await db.prepare(`${selectCommentary}
    WHERE u.id IN (${ids.map(() => '?').join(',')}) AND e.public_text = 1`).bind(...ids).all<CommentaryRow>();
  const records = new Map(result.results.map((row) => [row.id, row]));
  return ids.flatMap((id) => {
    const row = records.get(id);
    return row ? [row] : [];
  });
}
