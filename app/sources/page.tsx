import type { Metadata } from 'next';
import { corpus } from '@/app/lib/corpus';
import { commentaryAuthors, commentaryFieldLabels, commentarySource } from '@/app/lib/commentaries';

export const metadata: Metadata = {
  title: 'Sources and rights',
  description: 'Trace the texts, translations, and commentaries in OpenArtha to their bibliographic sources, licenses, and review records.',
  alternates: { canonical: '/sources' },
};

export default function SourcesPage() {
  return (
    <main className="shell page-shell prose-page">
      <header className="page-header">
        <div className="eyebrow">Bibliography and rights</div>
        <h1>Follow every reading to its source.</h1>
        <p>Each passage retains its bibliographic source, locator, rights, and review record so you can inspect the evidence yourself.</p>
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
              <div className="source-links"><a href={source.url}>View source ↗</a>{source.transcriptionUrl && <a href={source.transcriptionUrl}>View transcription ↗</a>}</div>
            </div>
          </article>
        ))}
      </section>
      <section className="commentary-source-section" aria-labelledby="commentary-source-title">
        <div className="section-heading"><h2 id="commentary-source-title">Where the commentaries come from</h2><span>{commentaryAuthors.length} authors</span></div>
        <article className="source-entry commentary-source-entry"><span className="source-index">{String(corpus.sources.length + 1).padStart(2, '0')}</span><div><h2>{commentarySource.source.title}</h2><p className="source-contributor">Pinned Git commit · <code>{commentarySource.source.commit.slice(0, 12)}</code></p><p>The GitHub snapshot is the import source. Kaggle is recorded only as a same-lineage mirror, not as independent textual evidence.</p><dl><div><dt>License</dt><dd>{commentarySource.source.license}</dd></div><div><dt>Scope</dt><dd>719 source units · 22 authors · 29 published fields</dd></div></dl><div className="source-links"><a href={commentarySource.source.repository}>Open repository ↗</a><a href={`/data/${commentarySource.corpusVersion}/rights.json`}>Rights matrix</a><a href={`/data/${commentarySource.corpusVersion}/alignment-report.json`}>Alignment report</a></div></div></article>
        <div className="source-author-table">{commentaryAuthors.map((author) => <article key={author.id}><div><strong>{author.displayName}</strong><span>{author.publicFields.map((field) => commentaryFieldLabels[field]).join(' · ')}</span></div><p>Full supplied text published · {author.rightsNote}</p></article>)}</div>
      </section>
      <section className="rights-section">
        <div><span className="eyebrow">Rights policy</span><h2>Rights stay attached to every layer.</h2></div>
        <div><p>Project code is MIT licensed. Original project metadata and research annotations are offered under CC BY 4.0. The complete imported translation and commentary dataset is redistributed under the pinned source snapshot’s GPL-3.0 license, with its license text and source commit included in the release.</p><a className="text-link" href="/data">Download rights data →</a></div>
      </section>
    </main>
  );
}
