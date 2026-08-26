import type { Metadata } from 'next';
import { corpus, chapterTitles, searchCorpusDetailed } from '@/app/lib/corpus';
import { PassageCard } from '@/components/passage-card';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Read the Bhagavad Gita',
  description: 'Browse the complete 700-verse research corpus by chapter or search across Sanskrit, IAST, and English.',
};

export default async function GitaIndex({ searchParams }: { searchParams: Promise<{ q?: string }> }) {
  const query = (await searchParams).q?.trim() ?? '';
  const search = query ? searchCorpusDetailed(query) : null;
  const exactResults = search?.results.filter((result) => result.kind === 'exact') ?? [];
  const compoundResults = search?.results.filter((result) => result.kind === 'compound') ?? [];
  return (
    <main className="shell page-shell">
      <header className="page-header split-header">
        <div>
          <div className="eyebrow">Standard 700-verse recension</div>
          <h1>Bhagavad Gita</h1>
          <p>भगवद्गीता · Eighteen chapters · Sanskrit, IAST, and English</p>
        </div>
        <StatusPill>Research preview</StatusPill>
      </header>

      <form className="search-form" role="search" action="/gita">
        <label htmlFor="corpus-search">Search the corpus</label>
        <div>
          <input id="corpus-search" name="q" defaultValue={query} placeholder="Try ‘action’, ‘dharma’, or 2.47" autoComplete="off" />
          <button className="button button-primary" type="submit">Search</button>
        </div>
      </form>

      {search ? (
        <section className="search-results" aria-labelledby="search-results-title">
          <div className="section-heading">
            <h2 id="search-results-title">{search.total} results for “{query}”</h2>
            <a href="/gita">Clear search</a>
          </div>
          <p className="search-explainer">Literal matches across Devanagari, IAST, and English. Exact words appear first; compound matches contain the term inside a larger Sanskrit form.</p>
          {search.total ? (
            <div className="search-groups">
              {exactResults.length ? (
                <section className="search-group" aria-labelledby="exact-matches-title">
                  <div className="search-group-heading"><h3 id="exact-matches-title">Exact word</h3><span>{search.exactCount} passages</span></div>
                  <div className="passage-list">{exactResults.map((result) => <PassageCard key={result.passage.id} passage={result.passage} compact match={result} />)}</div>
                </section>
              ) : null}
              {compoundResults.length ? (
                <section className="search-group" aria-labelledby="compound-matches-title">
                  <div className="search-group-heading"><h3 id="compound-matches-title">Compound form</h3><span>{search.compoundCount} passages</span></div>
                  <div className="passage-list">{compoundResults.map((result) => <PassageCard key={result.passage.id} passage={result.passage} compact match={result} />)}</div>
                </section>
              ) : null}
            </div>
          ) : <div className="empty-state"><p>No lexical matches. Try a shorter word, an IAST term without diacritics, or a reference such as 2.47.</p></div>}
        </section>
      ) : (
        <section aria-labelledby="chapters-title">
          <div className="section-heading"><h2 id="chapters-title">Chapters</h2><span>{corpus.work.passageCount} passages</span></div>
          <ol className="chapter-grid">
            {chapterTitles.map(([sanskritTitle, englishTitle], index) => (
              <li key={sanskritTitle}>
                <a href={`/gita/${index + 1}`}>
                  <span className="chapter-number">{String(index + 1).padStart(2, '0')}</span>
                  <span className="chapter-name"><strong>{sanskritTitle}</strong><span>{englishTitle}</span></span>
                  <span className="chapter-count">{corpus.chapterCounts[index]} verses</span>
                  <span aria-hidden="true">↗</span>
                </a>
              </li>
            ))}
          </ol>
        </section>
      )}
    </main>
  );
}
