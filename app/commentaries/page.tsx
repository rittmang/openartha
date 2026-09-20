import type { Metadata } from 'next';
import { commentaryAuthors, commentaryFieldLabels, commentarySource } from '@/app/lib/commentaries';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Translations and commentaries on the Bhagavad Gita',
  description: 'Compare 29 supplied translations and commentaries from 22 authors across Sanskrit, English, and Hindi, aligned verse by verse.',
  alternates: { canonical: '/gita/commentaries' },
};

export default function CommentariesPage() {
  const published = commentaryAuthors.filter((author) => author.publicFields.length);
  const witnessCount = published.reduce((total, author) => total + author.publicFields.length, 0);
  return (
    <main className="shell page-shell prose-page">
      <header className="page-header split-header">
        <div><div className="eyebrow">Interpretations across the Gita</div><h1>One text. Many paths to meaning.</h1><p>Read Sanskrit, English, and Hindi translations and commentaries beside the verses they interpret. Every reading stays linked to its source.</p></div>
        <StatusPill>{commentarySource.status}</StatusPill>
      </header>
      <section aria-labelledby="published-title">
        <div className="section-heading"><h2 id="published-title">Explore by author</h2><span>{published.length} authors · {witnessCount} translations and commentaries</span></div>
        <div className="author-grid">{published.map((author) => <a className="author-card" key={author.id} href={`/gita/commentaries/${author.id}`}><span className="eyebrow">{author.publicFields.map((field) => commentaryFieldLabels[field]).join(' · ')}</span><h3>{author.displayName}</h3><p>{author.rightsNote}</p><span className="text-link">Read by chapter →</span></a>)}</div>
      </section>
      <section className="metadata-authors" aria-labelledby="license-title">
        <div className="section-heading"><h2 id="license-title">Where these readings come from</h2><span>GPL-3.0</span></div>
        <p>One pinned repository snapshot supplies every reading and is redistributed under GPL-3.0. The verse alignments are machine-generated and still await independent human review.</p>
      </section>
    </main>
  );
}
