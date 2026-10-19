import { env } from 'cloudflare:workers';
import authorRegistry from '@/corpus/gita-commentaries/authors.json';
import sourceRegistry from '@/corpus/gita-commentaries/source.json';
import { getPassage } from '@/app/lib/corpus';
import { findSearchTerm, normalizeSearchText, type SearchMatchKind, type SearchRange } from '@/app/lib/search';
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

export function commentaryReviewSummary(commentary: Commentary) {
  const shared = commentary.alignment && commentary.alignment.references.length > 1 ? `Shared rendering of ${commentary.alignment.references.map((ref) => ref.replace('gita.', '')).join('–')}. ` : '';
  if (commentary.firstReview) {
    const review = commentary.firstReview;
    const outcome = review.status === 'verified' ? 'verified' : review.status === 'needs-correction' ? 'flagged for correction' : 'uncertain';
    return `${shared}First model review ${outcome} (${review.reviewerModel} confidence: ${Math.round(review.confidence * 100)}%); second review pending.`;
  }
  if (commentary.alignment) {
    return `${shared}Aligned by ${commentary.alignment.review.reviewerModel}; independent review pending.`;
  }
  return `First review verified (google/gemini-3.8-flash confidence: ${Math.round(commentaryConfidence(commentary) * 100)}%); second review pending.`;
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
