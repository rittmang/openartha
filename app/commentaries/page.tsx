import type { Metadata } from 'next';
import { commentaryAuthors, commentarySource } from '@/app/lib/commentaries';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Commentary witnesses',
  description: 'Browse the rights-reviewed commentary and translation registry for the Bhagavad Gita corpus.',
};

export default function CommentariesPage() {
  const published = commentaryAuthors.filter((author) => author.publicFields.length);
  const metadataOnly = commentaryAuthors.filter((author) => !author.publicFields.length);
  return (
    <main className="shell page-shell prose-page">
      <header className="page-header split-header">
        <div><div className="eyebrow">Commentary corpus</div><h1>Many readings. One traceable text.</h1><p>Compare classical Sanskrit commentary beside the same canonical verse. Modern editions remain listed—but not copied—until their reuse rights are verified.</p></div>
        <StatusPill>{commentarySource.status}</StatusPill>
      </header>
      <section aria-labelledby="published-title">
        <div className="section-heading"><h2 id="published-title">Published Sanskrit witnesses</h2><span>{published.length} authors</span></div>
        <div className="author-grid">{published.map((author) => <a className="author-card" key={author.id} href={`/commentaries/${author.id}`}><span className="eyebrow">Full text · Sanskrit</span><h3>{author.displayName}</h3><p>{author.rightsNote}</p><span className="text-link">Browse by chapter →</span></a>)}</div>
      </section>
      <section className="metadata-authors" aria-labelledby="metadata-title">
        <div className="section-heading"><h2 id="metadata-title">Registered, metadata only</h2><span>{metadataOnly.length} authors</span></div>
        <div className="metadata-author-list">{metadataOnly.map((author) => <article key={author.id}><div><h3>{author.displayName}</h3><span>{author.availableFields.join(' · ').toUpperCase()}</span></div><p>{author.rightsNote}</p></article>)}</div>
      </section>
    </main>
  );
}
