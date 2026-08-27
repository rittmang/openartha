import type { Metadata } from 'next';
import { corpus, chapterTitles, searchCorpusDetailed, type PassageSearchResult, type Passage, type SearchHit } from '@/app/lib/corpus';
import { publicCommentaryAuthors, searchCommentaries, type CommentarySearchResult } from '@/app/lib/commentaries';
import { PassageCard } from '@/components/passage-card';
import { CommentarySearchCard } from '@/components/commentary-search-card';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Read the Bhagavad Gita',
  description: 'Browse the complete 700-verse research corpus and search its Sanskrit, IAST, English, and classical Sanskrit commentaries together.',
};

type SearchParams = { q?: string; author?: string; language?: string; type?: string };
type UnifiedResult =
  | { source: 'root'; result: PassageSearchResult<Passage> }
  | { source: 'commentary'; result: CommentarySearchResult };

const fieldLanguage: Record<SearchHit['field'], string | null> = {
  devanagari: 'sa', iast: 'sa', english: 'en', reference: null, speaker: null,
};
const fieldType: Record<SearchHit['field'], string> = {
  devanagari: 'original', iast: 'transliteration', english: 'translation', reference: 'metadata', speaker: 'metadata',
};

function filteredRootResults(query: string, filters: SearchParams) {
  if (filters.author) return [];
  return searchCorpusDetailed(query).results.flatMap((result) => {
    const hits = result.hits.filter((hit) => {
      if (filters.language && fieldLanguage[hit.field] !== filters.language) return false;
      if (filters.type && fieldType[hit.field] !== filters.type) return false;
      return true;
    });
    return hits.length ? [{ ...result, hits }] : [];
  });
}

function ResultCard({ item }: { item: UnifiedResult }) {
  return item.source === 'root'
    ? <PassageCard passage={item.result.passage} compact match={item.result} />
    : <CommentarySearchCard result={item.result} />;
}

function resultKey(item: UnifiedResult) {
  return item.source === 'root' ? `root-${item.result.passage.id}` : `commentary-${item.result.id}`;
}

export default async function GitaIndex({ searchParams }: { searchParams: Promise<SearchParams> }) {
  const filters = await searchParams;
  const query = filters.q?.trim() ?? '';
  const rootResults = query ? filteredRootResults(query, filters) : [];
  const includesCommentary = !filters.type || filters.type === 'commentary' || filters.type === 'translation';
  const commentaryResults = query && includesCommentary ? await searchCommentaries(query, {
    author: filters.author,
    language: filters.language,
    contentType: filters.type === 'commentary' || filters.type === 'translation' ? filters.type : undefined,
  }) : [];
  const results: UnifiedResult[] = [
    ...rootResults.map((result): UnifiedResult => ({ source: 'root', result })),
    ...commentaryResults.map((result): UnifiedResult => ({ source: 'commentary', result })),
  ];
  const exactResults = results.filter(({ result }) => result.kind === 'exact');
  const compoundResults = results.filter(({ result }) => result.kind === 'compound');

  return (
    <main className="shell page-shell">
      <header className="page-header split-header">
        <div>
          <div className="eyebrow">Standard 700-verse recension</div>
          <h1>Bhagavad Gita</h1>
          <p>भगवद्गीता · Eighteen chapters · Root text, Telang’s English witness, and classical Sanskrit commentaries</p>
        </div>
        <StatusPill>Research preview</StatusPill>
      </header>

      <form className="search-form" role="search" action="/gita">
        <label htmlFor="corpus-search">Search everything together</label>
        <div className="search-input-row">
          <input id="corpus-search" name="q" defaultValue={query} placeholder="Try ‘action’, ‘yoga’, धर्म, or 2.47" autoComplete="off" />
          <button className="button button-primary" type="submit">Search</button>
        </div>
        <div className="search-filters" aria-label="Optional search filters">
          <label>Author<select name="author" defaultValue={filters.author ?? ''}><option value="">All authors</option>{publicCommentaryAuthors.map((author) => <option key={author.id} value={author.id}>{author.displayName}</option>)}</select></label>
          <label>Language<select name="language" defaultValue={filters.language ?? ''}><option value="">All languages</option><option value="sa">Sanskrit</option><option value="en">English</option><option value="hi">Hindi</option></select></label>
          <label>Content<select name="type" defaultValue={filters.type ?? ''}><option value="">All content</option><option value="original">Original</option><option value="transliteration">Transliteration</option><option value="translation">Translation</option><option value="commentary">Commentary</option></select></label>
        </div>
      </form>

      {query ? (
        <section className="search-results" aria-labelledby="search-results-title">
          <div className="section-heading"><h2 id="search-results-title">{results.length} matches for “{query}”</h2><a href="/gita">Clear search</a></div>
          <p className="search-explainer">One search across the root text, transliteration, Telang translation, and published classical commentary witnesses. Matching substrings are highlighted; exact words appear before compound forms.</p>
          {results.length ? (
            <div className="search-groups">
              {exactResults.length ? <section className="search-group" aria-labelledby="exact-matches-title"><div className="search-group-heading"><h3 id="exact-matches-title">Exact word</h3><span>{exactResults.length} matches</span></div><div className="passage-list">{exactResults.map((item) => <ResultCard key={resultKey(item)} item={item} />)}</div></section> : null}
              {compoundResults.length ? <section className="search-group" aria-labelledby="compound-matches-title"><div className="search-group-heading"><h3 id="compound-matches-title">Compound form</h3><span>{compoundResults.length} matches</span></div><div className="passage-list">{compoundResults.map((item) => <ResultCard key={resultKey(item)} item={item} />)}</div></section> : null}
            </div>
          ) : <div className="empty-state"><p>No matches. Try a shorter word, an IAST term without diacritics, or remove a filter.</p></div>}
        </section>
      ) : (
        <section aria-labelledby="chapters-title">
          <div className="section-heading"><h2 id="chapters-title">Chapters</h2><span>{corpus.work.passageCount} passages</span></div>
          <ol className="chapter-grid">
            {chapterTitles.map(([sanskritTitle, englishTitle], index) => (
              <li key={sanskritTitle}><a href={`/gita/${index + 1}`}><span className="chapter-number">{String(index + 1).padStart(2, '0')}</span><span className="chapter-name"><strong>{sanskritTitle}</strong><span>{englishTitle}</span></span><span className="chapter-count">{corpus.chapterCounts[index]} verses</span><span aria-hidden="true">↗</span></a></li>
            ))}
          </ol>
        </section>
      )}
    </main>
  );
}
