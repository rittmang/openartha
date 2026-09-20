import { env } from 'cloudflare:workers';
import authorRegistry from '@/corpus/gita-commentaries/authors.json';
import sourceRegistry from '@/corpus/gita-commentaries/source.json';
import { getPassage } from '@/app/lib/corpus';
import { findSearchTerm, normalizeSearchText, type SearchMatchKind, type SearchRange } from '@/app/lib/search';

export type CommentaryAuthor = {
  id: string;
  sourceKey: string;
  displayName: string;
  availableFields: string[];
  publicFields: string[];
  rightsStatus: string;
  rightsNote: string;
};

export type Commentary = {
  id: string;
  canonicalRef: string;
  chapter: number;
  verse: number;
  authorId: string;
  author: string;
  editionId: string;
  fieldCode: string;
  language: string;
  script: string;
  contentType: string;
  content: string;
  sourceLocator: string;
  sourceUrl: string;
  sourceCommit: string;
  alignmentStatus: string;
  checksum: string;
  corpusVersion: string;
};

export type CommentarySearchResult = Omit<Commentary, 'content'> & {
  content: string;
  kind: SearchMatchKind;
  ranges: SearchRange[];
};

type CommentaryRow = {
  id: string;
  canonical_ref: string;
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
  alignment_status: string;
  display_checksum: string;
  corpus_version: string;
};

export const commentaryAuthors = authorRegistry as CommentaryAuthor[];
export const commentarySource = sourceRegistry;
export const publicCommentaryAuthors = commentaryAuthors.filter((author) => author.publicFields.length > 0);
export const commentaryFieldLabels: Record<string, string> = {
  et: 'English translation',
  ec: 'English commentary',
  ht: 'Hindi translation',
  hc: 'Hindi commentary',
  sc: 'Sanskrit commentary',
};
export const commentaryLanguageLabels: Record<string, string> = { en: 'English', hi: 'Hindi', sa: 'Sanskrit' };

export function commentaryDescriptor(commentary: Pick<Commentary, 'contentType' | 'language'>) {
  const contentType = commentary.contentType === 'translation' ? 'Translation' : 'Commentary';
  return `${contentType} · ${commentaryLanguageLabels[commentary.language] ?? commentary.language}`;
}

export function commentaryLang(commentary: Pick<Commentary, 'language' | 'script'>) {
  return `${commentary.language}-${commentary.script}`;
}

export function commentaryConfidence(commentary: Pick<Commentary, 'chapter' | 'verse' | 'language' | 'contentType' | 'content'>): number {
  const passage = getPassage(commentary.chapter, commentary.verse);
  const content = commentary.content || '';

  if (/did not comment on this sloka|commentary starts from/i.test(content)) {
    return 0.99;
  }

  if (!passage) return 0.85;

  let score = 0.85;

  if (commentary.language === 'sa') {
    const devaWords = passage.representations.devanagari
      .replace(/[।॥०-९0-9\n\r]/g, ' ')
      .split(/\s+/)
      .filter((w) => w.length > 2);
    const matches = devaWords.filter((w) => content.includes(w)).length;
    const ratio = devaWords.length ? matches / devaWords.length : 0;
    score = 0.88 + Math.min(0.10, ratio * 0.15);
  } else if (commentary.language === 'en') {
    const enTokens = passage.representations.english
      .toLowerCase()
      .replace(/[^a-z0-9 ]/g, ' ')
      .split(/\s+/)
      .filter((w) => w.length > 3);
    const commLower = content.toLowerCase();
    const matches = enTokens.filter((w) => commLower.includes(w)).length;
    const ratio = enTokens.length ? matches / enTokens.length : 0;
    score = commentary.contentType === 'translation'
      ? 0.90 + Math.min(0.08, ratio * 0.12)
      : 0.87 + Math.min(0.09, ratio * 0.12);
  } else if (commentary.language === 'hi') {
    const devaWords = passage.representations.devanagari
      .replace(/[।॥०-९0-9\n\r]/g, ' ')
      .split(/\s+/)
      .filter((w) => w.length > 2);
    const matches = devaWords.filter((w) => content.includes(w)).length;
    const ratio = devaWords.length ? matches / devaWords.length : 0;
    score = 0.88 + Math.min(0.09, ratio * 0.12);
  }

  const headerPattern = new RegExp(`(\\\\b|\\\\|\\\\|)\\s*${passage.chapter}\\s*[.-]\\s*${passage.verse}`);
  if (headerPattern.test(content.slice(0, 50))) {
    score += 0.02;
  }

  return Math.min(0.99, Math.max(0.60, Number(score.toFixed(2))));
}

function database() {
  return (env as unknown as { DB?: D1Database }).DB;
}

function toCommentary(row: CommentaryRow): Commentary {
  const [, chapter, verse] = row.canonical_ref.split('.').map(Number);
  return {
    id: row.id,
    canonicalRef: row.canonical_ref,
    chapter,
    verse,
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
    alignmentStatus: row.alignment_status,
    checksum: row.display_checksum,
    corpusVersion: row.corpus_version,
  };
}

const selectCommentary = `
  SELECT u.id, u.passage_id AS canonical_ref, e.author_id, a.display_name,
    e.id AS edition_id, e.field_code, e.language, e.script, e.content_type,
    (SELECT group_concat(content, '') FROM (
      SELECT content FROM commentary_unit_chunks WHERE unit_id = u.id ORDER BY chunk_index
    )) AS content,
    u.source_locator, s.repository_url, s.commit_sha, u.alignment_status,
    u.display_checksum, e.corpus_version
  FROM commentary_units u
  JOIN commentary_editions e ON e.id = u.edition_id
  JOIN commentary_authors a ON a.id = e.author_id
  JOIN commentary_sources s ON s.id = e.source_id
`;

export async function getPassageCommentaries(chapter: number, verse: number) {
  const db = database();
  if (!db) return [];
  try {
    const result = await db.prepare(`${selectCommentary}
      WHERE u.passage_id = ? AND e.public_text = 1
      ORDER BY a.display_name, e.content_type, e.language`).bind(`gita.${chapter}.${verse}`).all<CommentaryRow>();
    return result.results.map(toCommentary);
  } catch (error) {
    console.error('Could not load passage commentaries', error);
    return [];
  }
}

export async function getAuthorChapterCommentaries(authorId: string, chapter: number) {
  const db = database();
  if (!db) return [];
  try {
    const result = await db.prepare(`${selectCommentary}
      WHERE e.author_id = ? AND u.source_chapter = ? AND u.passage_id IS NOT NULL AND e.public_text = 1
      ORDER BY u.passage_id, e.content_type, e.language`).bind(authorId, chapter).all<CommentaryRow>();
    return result.results.map(toCommentary);
  } catch (error) {
    console.error('Could not load author chapter', error);
    return [];
  }
}

function ftsQuery(rawQuery: string) {
  const terms = rawQuery.normalize('NFC').match(/[\p{L}\p{M}\p{N}]+/gu) ?? [];
  return terms.map((term) => `"${term.replaceAll('"', '""')}"*`).join(' AND ');
}

function matchEvidence(content: string, query: string) {
  const terms = normalizeSearchText(query).split(/\s+/).filter(Boolean);
  const ranges: SearchRange[] = [];
  let exact = true;
  for (const term of terms) {
    const occurrences = findSearchTerm(content, term);
    if (!occurrences.length) continue;
    ranges.push(...occurrences.map(({ start, end }) => ({ start, end })));
    if (!occurrences.some((occurrence) => occurrence.exact)) exact = false;
  }
  ranges.sort((left, right) => left.start - right.start || left.end - right.end);
  return { kind: exact ? 'exact' as const : 'compound' as const, ranges };
}

export async function searchCommentaries(query: string, limit = 60): Promise<CommentarySearchResult[]> {
  const db = database();
  const match = ftsQuery(query);
  if (!db || !match) return [];
  const bindings: Array<string | number> = [match];
  bindings.push(Math.min(Math.max(limit * 4, limit), 240));
  try {
    const result = await db.prepare(`
      SELECT u.id, u.passage_id AS canonical_ref, e.author_id, a.display_name,
        e.id AS edition_id, e.field_code, e.language, e.script, e.content_type,
        f.content, u.source_locator, s.repository_url, s.commit_sha,
        u.alignment_status, u.display_checksum, e.corpus_version,
        bm25(commentary_fts) AS rank
      FROM commentary_fts f
      JOIN commentary_units u ON u.id = f.unit_id
      JOIN commentary_editions e ON e.id = u.edition_id
      JOIN commentary_authors a ON a.id = e.author_id
      JOIN commentary_sources s ON s.id = e.source_id
      WHERE commentary_fts MATCH ? AND e.public_text = 1
      ORDER BY rank, u.source_chapter, u.source_verse, a.display_name
      LIMIT ?
    `).bind(...bindings).all<CommentaryRow & { rank: number }>();
    const seen = new Set<string>();
    const matches: CommentarySearchResult[] = [];
    for (const row of result.results) {
      if (seen.has(row.id)) continue;
      seen.add(row.id);
      const evidence = matchEvidence(row.content, query);
      matches.push({ ...toCommentary(row), ...evidence });
      if (matches.length >= limit) break;
    }
    return matches;
  } catch (error) {
    console.error('Could not search commentaries', error);
    return [];
  }
}
