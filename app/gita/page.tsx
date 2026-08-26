import type { Metadata } from 'next';
import { corpus, chapterTitles, searchCorpus } from '@/app/lib/corpus';
import { PassageCard } from '@/components/passage-card';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Read the Bhagavad Gita',
  description: 'Browse the complete 700-verse research corpus by chapter or search across Sanskrit, IAST, and English.',
};

export default async function GitaIndex({ searchParams }: { searchParams: Promise<{ q?: string }> }) {
  const query = (await searchParams).q?.trim() ?? '';
  const results = query ? searchCorpus(query, 40) : [];
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

      {query ? (
        <section className="search-results" aria-labelledby="search-results-title">
          <div className="section-heading">
            <h2 id="search-results-title">{results.length} results for “{query}”</h2>
            <a href="/gita">Clear search</a>
          </div>
          {results.length ? (
            <div className="passage-list">{results.map((passage) => <PassageCard key={passage.id} passage={passage} compact />)}</div>
          ) : <div className="empty-state"><p>No exact matches. Try a shorter word, an IAST term without diacritics, or a reference such as 2.47.</p></div>}
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
