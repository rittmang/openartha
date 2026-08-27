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

function normalizeCharacter(character: string) {
  return character
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();
}

export function normalizeSearchText(value: string) {
  return Array.from(value, normalizeCharacter).join('');
}

function normalizedView(value: string) {
  let normalized = '';
  let originalOffset = 0;
  const offsets: SearchRange[] = [];

  for (const character of value) {
    const normalizedCharacter = normalizeCharacter(character);
    normalized += normalizedCharacter;
    for (let index = 0; index < normalizedCharacter.length; index += 1) {
      offsets.push({ start: originalOffset, end: originalOffset + character.length });
    }
    originalOffset += character.length;
  }

  return { normalized, offsets };
}

function isTokenCharacter(character: string | undefined) {
  return Boolean(character && /[\p{L}\p{M}\p{N}]/u.test(character));
}

export function findSearchTerm(value: string, rawTerm: string) {
  const term = normalizeSearchText(rawTerm);
  const view = normalizedView(value);
  const occurrences: Array<SearchRange & { exact: boolean }> = [];
  let fromIndex = 0;

  while (fromIndex <= view.normalized.length - term.length) {
    const normalizedIndex = view.normalized.indexOf(term, fromIndex);
    if (normalizedIndex < 0) break;

    const firstOffset = view.offsets[normalizedIndex];
    const lastOffset = view.offsets[normalizedIndex + term.length - 1];
    const before = view.normalized[normalizedIndex - 1];
    const after = view.normalized[normalizedIndex + term.length];
    occurrences.push({
      start: firstOffset.start,
      end: lastOffset.end,
      exact: !isTokenCharacter(before) && !isTokenCharacter(after),
    });
    fromIndex = normalizedIndex + Math.max(term.length, 1);
  }

  return occurrences;
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

export function searchPassages<T extends SearchablePassage>(passages: T[], rawQuery: string): CorpusSearchResults<T> {
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

      for (const term of terms) {
        const occurrences = findSearchTerm(text, term);
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
