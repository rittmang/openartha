import type { Metadata } from 'next';
import { corpus, chapterTitles, searchCorpusDetailed, type PassageSearchResult, type Passage } from '@/app/lib/corpus';
import { searchCommentaries, type CommentarySearchResult } from '@/app/lib/commentaries';
import { PassageCard } from '@/components/passage-card';
import { CommentarySearchCard } from '@/components/commentary-search-card';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Read the Bhagavad Gita',
  description: 'Read and search all 700 verses of the Bhagavad Gita across Sanskrit, transliteration, English translation, and 29 supplied translations and commentaries.',
  alternates: { canonical: '/gita' },
};

type SearchParams = { q?: string };
type UnifiedResult =
  | { source: 'root'; result: PassageSearchResult<Passage> }
  | { source: 'commentary'; result: CommentarySearchResult };

function ResultCard({ item }: { item: UnifiedResult }) {
  return item.source === 'root'
    ? <PassageCard passage={item.result.passage} compact match={item.result} />
    : <CommentarySearchCard result={item.result} />;
}

function resultKey(item: UnifiedResult) {
  return item.source === 'root' ? `root-${item.result.passage.id}` : `commentary-${item.result.id}`;
}

export default async function GitaIndex({ searchParams }: { searchParams: Promise<SearchParams> }) {
  const query = (await searchParams).q?.trim() ?? '';
  const rootResults = query ? searchCorpusDetailed(query).results : [];
  const commentaryResults = query ? await searchCommentaries(query) : [];
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
          <div className="eyebrow">OpenArtha’s first text</div>
          <h1>Bhagavad Gita</h1>
          <p>Read the Sanskrit text, transliteration, and English translation together. Search 29 supplied translations and commentaries alongside them.</p>
        </div>
        <StatusPill>Research preview</StatusPill>
      </header>

      <form className="search-form" role="search" action="/gita">
        <label htmlFor="corpus-search">Search the text and its interpretations</label>
        <div className="search-input-row">
          <input id="corpus-search" name="q" defaultValue={query} placeholder="Try ‘action’, ‘yoga’, धर्म, or 2.47" autoComplete="off" />
          <button className="button button-primary" type="submit">Search the Gita</button>
        </div>
      </form>

      {query ? (
        <section className="search-results" aria-labelledby="search-results-title">
          <div className="section-heading"><h2 id="search-results-title">{results.length} matches for “{query}”</h2><a href="/gita">Clear search</a></div>
          <p className="search-explainer">Search covers the Sanskrit text, transliteration, Telang translation, and supplied Sanskrit, English, and Hindi translations and commentaries. Exact words appear before matches inside compound forms.</p>
          {results.length ? (
            <div className="search-groups">
              {exactResults.length ? <section className="search-group" aria-labelledby="exact-matches-title"><div className="search-group-heading"><h3 id="exact-matches-title">Exact word</h3><span>{exactResults.length} matches</span></div><div className="passage-list">{exactResults.map((item) => <ResultCard key={resultKey(item)} item={item} />)}</div></section> : null}
              {compoundResults.length ? <section className="search-group" aria-labelledby="compound-matches-title"><div className="search-group-heading"><h3 id="compound-matches-title">Compound form</h3><span>{compoundResults.length} matches</span></div><div className="passage-list">{compoundResults.map((item) => <ResultCard key={resultKey(item)} item={item} />)}</div></section> : null}
            </div>
          ) : <div className="empty-state"><p>No matches. Try a shorter term, a verse number such as 2.47, or an IAST word without diacritics.</p></div>}
        </section>
      ) : (
        <section aria-labelledby="chapters-title">
          <div className="section-heading"><h2 id="chapters-title">Chapters</h2><span>{corpus.work.passageCount} verses</span></div>
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
