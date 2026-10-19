export type SearchField = 'reference' | 'speaker' | 'devanagari' | 'iast' | 'english';
export type SearchMatchKind = 'exact' | 'compound';

export type SearchRange = {
  start: number;
  end: number;
};

export type SearchHit = {
  field: SearchField;
  label: string;
  text: string;
  kind: SearchMatchKind;
  ranges: SearchRange[];
  matchedTerms: string[];
};

export type SearchablePassage = {
  canonicalRef: string;
  chapter: number;
  verse: number;
  speaker: string | null;
  representations: {
    devanagari: string;
    iast: string;
    english: string;
  };
};

export type PassageSearchResult<T extends SearchablePassage> = {
  passage: T;
  kind: SearchMatchKind;
  hits: SearchHit[];
};

export type CorpusSearchResults<T extends SearchablePassage> = {
  query: string;
  terms: string[];
  total: number;
  exactCount: number;
  compoundCount: number;
  results: PassageSearchResult<T>[];
};

const fields: Array<{ field: SearchField; label: string; priority: number }> = [
  { field: 'english', label: 'English', priority: 0 },
  { field: 'iast', label: 'IAST', priority: 1 },
  { field: 'devanagari', label: 'Devanagari', priority: 2 },
  { field: 'reference', label: 'Reference', priority: 3 },
  { field: 'speaker', label: 'Speaker', priority: 4 },
];

type NormalizedView = {
  normalized: string;
  changes: Array<{ start: number; end: number; originalStart: number; originalEnd: number }>;
};

export type PassageSearchIndex = Record<string, Record<SearchField, NormalizedView>>;
const lengthChangingCharacters = new RegExp(normalization.pattern, 'gu');

export function normalizeSearchText(value: string) {
  // Normalize natively; preserve the previous per-character handling of capital sigma.
  return value.normalize('NFKD').replace(/[\u0300-\u036f]/g, '').replace(/Σ/g, 'σ').toLowerCase();
}

function normalizedView(value: string): NormalizedView {
  let delta = 0;
  const changes: NormalizedView['changes'] = [];
  for (const match of value.matchAll(lengthChangingCharacters)) {
    const length = normalizeSearchText(match[0]).length;
    changes.push({ start: match.index + delta, end: match.index + delta + length, originalStart: match.index, originalEnd: match.index + match[0].length });
    delta += length - match[0].length;
  }
  return { normalized: normalizeSearchText(value), changes };
}

function originalRange(view: NormalizedView, index: number) {
  let low = 0;
  let high = view.changes.length;
  while (low < high) {
    const middle = (low + high) >>> 1;
    if (view.changes[middle].start <= index) low = middle + 1;
    else high = middle;
  }
  const change = view.changes[low - 1];
  if (!change) return { start: index, end: index + 1 };
  if (index < change.end) return { start: change.originalStart, end: change.originalEnd };
  const offset = change.originalEnd - change.end;
  return { start: index + offset, end: index + offset + 1 };
}

function isTokenCharacter(character: string | undefined) {
  return Boolean(character && /[\p{L}\p{M}\p{N}]/u.test(character));
}

function findInView(view: NormalizedView, term: string) {
  const occurrences: Array<SearchRange & { exact: boolean }> = [];
  if (!term) return occurrences;
  let fromIndex = 0;
  while (fromIndex <= view.normalized.length - term.length) {
    const index = view.normalized.indexOf(term, fromIndex);
    if (index < 0) break;
    occurrences.push({
      start: originalRange(view, index).start,
      end: originalRange(view, index + term.length - 1).end,
      exact: !isTokenCharacter(view.normalized[index - 1]) && !isTokenCharacter(view.normalized[index + term.length]),
    });
    fromIndex = index + term.length;
  }
  return occurrences;
}

export function findSearchTerms(value: string, terms: string[]) {
  const view = normalizedView(value);
  return terms.map((term) => findInView(view, normalizeSearchText(term)));
}

export function findSearchTerm(value: string, rawTerm: string) {
  return findSearchTerms(value, [rawTerm])[0];
}

function mergeRanges(ranges: SearchRange[]) {
  const sorted = [...ranges].sort((left, right) => left.start - right.start || left.end - right.end);
  const merged: SearchRange[] = [];
  for (const range of sorted) {
    const previous = merged.at(-1);
    if (previous && range.start <= previous.end) previous.end = Math.max(previous.end, range.end);
    else merged.push({ ...range });
  }
  return merged;
}

function getFieldValue(passage: SearchablePassage, field: SearchField) {
  switch (field) {
    case 'reference': return `${passage.canonicalRef} ${passage.chapter}.${passage.verse}`;
    case 'speaker': return passage.speaker ?? '';
    case 'devanagari': return passage.representations.devanagari;
    case 'iast': return passage.representations.iast;
    case 'english': return passage.representations.english;
  }
}

export function buildPassageSearchIndex<T extends SearchablePassage>(passages: T[]): PassageSearchIndex {
  return Object.fromEntries(passages.map((passage) => [passage.canonicalRef, Object.fromEntries(fields.map(({ field }) => [field, normalizedView(getFieldValue(passage, field))]))])) as PassageSearchIndex;
}

export function searchPassages<T extends SearchablePassage>(passages: T[], rawQuery: string, index?: PassageSearchIndex): CorpusSearchResults<T> {
  const query = rawQuery.trim();
  const terms = normalizeSearchText(query).split(/\s+/).filter(Boolean);
  if (!terms.length) return { query, terms, total: 0, exactCount: 0, compoundCount: 0, results: [] };

  const results = passages.flatMap((passage): PassageSearchResult<T>[] => {
    const exactTerms = new Set<string>();
    const foundTerms = new Set<string>();
    const hits = fields.flatMap(({ field, label, priority }) => {
      const text = getFieldValue(passage, field);
      const matchedTerms: string[] = [];
      const ranges: SearchRange[] = [];
      let everyFieldTermIsExact = true;

      const view = index?.[passage.canonicalRef]?.[field] ?? normalizedView(text);
      for (const term of terms) {
        const occurrences = findInView(view, term);
        if (!occurrences.length) continue;
        foundTerms.add(term);
        matchedTerms.push(term);
        ranges.push(...occurrences.map(({ start, end }) => ({ start, end })));
        if (occurrences.some((occurrence) => occurrence.exact)) exactTerms.add(term);
        else everyFieldTermIsExact = false;
      }

      if (!matchedTerms.length) return [];
      return [{
        field,
        label,
        text,
        kind: everyFieldTermIsExact ? 'exact' as const : 'compound' as const,
        ranges: mergeRanges(ranges),
        matchedTerms,
        priority,
      }];
    });

    if (foundTerms.size !== terms.length) return [];
    const kind: SearchMatchKind = exactTerms.size === terms.length ? 'exact' : 'compound';
    hits.sort((left, right) => {
      if (left.kind !== right.kind) return left.kind === 'exact' ? -1 : 1;
      if (left.matchedTerms.length !== right.matchedTerms.length) return right.matchedTerms.length - left.matchedTerms.length;
      return left.priority - right.priority;
    });
    return [{
      passage,
      kind,
      hits: hits.map((hit) => ({
        field: hit.field,
        label: hit.label,
        text: hit.text,
        kind: hit.kind,
        ranges: hit.ranges,
        matchedTerms: hit.matchedTerms,
      })),
    }];
  });

  results.sort((left, right) => {
    if (left.kind !== right.kind) return left.kind === 'exact' ? -1 : 1;
    return left.passage.chapter - right.passage.chapter || left.passage.verse - right.passage.verse;
  });
  const exactCount = results.filter((result) => result.kind === 'exact').length;
  return {
    query,
    terms,
    total: results.length,
    exactCount,
    compoundCount: results.length - exactCount,
    results,
  };
}
import normalization from './search-normalization.json' with { type: 'json' };
