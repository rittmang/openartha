import type { Metadata } from 'next';
import { corpus } from '@/app/lib/corpus';
import { commentaryAuthors, commentarySource } from '@/app/lib/commentaries';

export const metadata: Metadata = {
  title: 'Sources and rights',
  description: 'Bibliography, source roles, and rights information for the Agentic Gita research corpus.',
};

export default function SourcesPage() {
  return (
    <main className="shell page-shell prose-page">
      <header className="page-header">
        <div className="eyebrow">Bibliography and rights</div>
        <h1>Sources remain visible.</h1>
        <p>A source is not just a footnote here. It is part of every passage record and every correction.</p>
      </header>
      <section className="source-list" aria-labelledby="source-list-title">
        <h2 id="source-list-title" className="visually-hidden">Corpus sources</h2>
        {corpus.sources.map((source, index) => (
          <article key={source.id} className="source-entry">
            <span className="source-index">{String(index + 1).padStart(2, '0')}</span>
            <div>
              <h2>{source.title}</h2>
              <p className="source-contributor">{source.contributor}{source.year ? ` · ${source.year}` : ''}</p>
              <p>{source.role}</p>
              <dl><div><dt>Rights</dt><dd>{source.rights}</dd></div><div><dt>Source ID</dt><dd><code>{source.id}</code></dd></div></dl>
              <div className="source-links"><a href={source.url}>Open source ↗</a>{source.transcriptionUrl && <a href={source.transcriptionUrl}>Open transcription ↗</a>}</div>
            </div>
          </article>
        ))}
      </section>
      <section className="commentary-source-section" aria-labelledby="commentary-source-title">
        <div className="section-heading"><h2 id="commentary-source-title">Commentary source registry</h2><span>{commentaryAuthors.length} authors</span></div>
        <article className="source-entry commentary-source-entry"><span className="source-index">{String(corpus.sources.length + 1).padStart(2, '0')}</span><div><h2>{commentarySource.source.title}</h2><p className="source-contributor">Pinned Git commit · <code>{commentarySource.source.commit.slice(0, 12)}</code></p><p>The GitHub snapshot is the import source. Kaggle is recorded only as a same-lineage mirror, not as independent textual evidence.</p><dl><div><dt>License</dt><dd>{commentarySource.source.license}</dd></div><div><dt>Scope</dt><dd>719 source units · 22 authors · 29 described editions</dd></div></dl><div className="source-links"><a href={commentarySource.source.repository}>Open repository ↗</a><a href={`/data/${commentarySource.corpusVersion}/rights.json`}>Rights matrix</a><a href={`/data/${commentarySource.corpusVersion}/alignment-report.json`}>Alignment report</a></div></div></article>
        <div className="source-author-table">{commentaryAuthors.map((author) => <article key={author.id}><div><strong>{author.displayName}</strong><span>{author.availableFields.join(' · ').toUpperCase()}</span></div><p>{author.publicFields.length ? 'Classical Sanskrit full text published' : 'Metadata only'} · {author.rightsNote}</p></article>)}</div>
      </section>
      <section className="rights-section">
        <div><span className="eyebrow">Rights policy</span><h2>Rights attach to each layer.</h2></div>
        <div><p>Project code is MIT licensed. Original project metadata and research annotations are offered under CC BY 4.0. Ancient source text is public domain; digital witnesses and transcriptions retain their own stated terms. Modern translation and commentary text is excluded unless its exact edition and redistribution rights are verified.</p><a className="text-link" href="/data">Download the machine-readable rights manifests →</a></div>
      </section>
    </main>
  );
}
