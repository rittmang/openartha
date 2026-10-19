import { env } from 'cloudflare:workers';
import authorRegistry from '@/corpus/gita-commentaries/authors.json';
import sourceRegistry from '@/corpus/gita-commentaries/source.json';
import { findSearchTerms, normalizeSearchText, type SearchMatchKind, type SearchRange } from '@/app/lib/search';
import { translationAuthors, readingMetadataById } from '@/app/lib/translations';
import { getPassageReadingRows, getAuthorChapterReadingRows, searchReadingRows, toCommentary } from '@/app/lib/commentary-repository';

export type CommentaryAuthor = {
  id: string;
  sourceKey: string;
  displayName: string;
  availableFields: string[];
  publicFields: string[];
  rightsStatus: string;
  rightsNote: string;
  sourceId?: string;
  sourceUrl?: string;
  corpusVersion?: string;
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
  rawChecksum?: string;
  corpusVersion: string;
  sourceChecksum?: string;
  rights?: string;
  alignmentRelation?: string;
  firstReview?: {
    reviewerModel: string;
    status: string;
    confidence: number;
    notes: string;
    secondReview: string;
  };
  alignment?: {
    id: string;
    references: string[];
    relation: string;
    note: string | null;
    review: { reviewerModel: string; status: string; method: string; date: string };
  };
};

export type CommentarySearchResult = Omit<Commentary, 'content'> & {
  content: string;
  kind: SearchMatchKind;
  ranges: SearchRange[];
};

export const datasetCommentaryAuthors = authorRegistry as CommentaryAuthor[];
export const commentaryAuthors: CommentaryAuthor[] = [...datasetCommentaryAuthors, ...translationAuthors];
export const commentarySource = sourceRegistry;
export const publicCommentaryAuthors = commentaryAuthors.filter((author) => author.publicFields.length > 0);
export const publicCommentaryWitnessCount = publicCommentaryAuthors.reduce((count, author) => count + author.publicFields.length, 0);
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

export { commentaryReviewSummary } from '@/app/lib/commentary-review';

function database() {
  return (env as unknown as { DB?: D1Database }).DB;
}

export async function getPassageCommentaries(chapter: number, verse: number) {
  const db = database();
  if (!db) return [];
  try {
    const rows = await getPassageReadingRows(db, chapter, verse);
    return rows.map((row) => toCommentary(row, readingMetadataById.get(row.id)));
  } catch (error) {
    console.error('Could not load passage commentaries', error);
    return [];
  }
}

export async function getAuthorChapterCommentaries(authorId: string, chapter: number) {
  const db = database();
  if (!db) return [];
  try {
    const rows = await getAuthorChapterReadingRows(db, authorId, chapter);
    return rows.map((row) => toCommentary(row, readingMetadataById.get(row.id)));
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
  for (const occurrences of findSearchTerms(content, terms)) {
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
  try {
    const rows = await searchReadingRows(db, match, limit);
    return rows.map((row) => ({
      ...toCommentary(row, readingMetadataById.get(row.id)),
      ...matchEvidence(row.content, query),
    })).sort((left, right) => left.kind === right.kind ? 0 : left.kind === 'exact' ? -1 : 1);
  } catch (error) {
    console.error('Could not search commentaries', error);
    return [];
  }
}
