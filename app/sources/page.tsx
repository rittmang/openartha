import type { Metadata } from 'next';
import { corpus } from '@/app/lib/corpus';

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
      <section className="rights-section">
        <div><span className="eyebrow">Rights policy</span><h2>Rights attach to each layer.</h2></div>
        <div><p>Project code is MIT licensed. Original project metadata and research annotations are offered under CC BY 4.0. Ancient source text is public domain; digital witnesses and transcriptions retain their own stated terms.</p><a className="text-link" href="/data">Download the machine-readable rights manifest →</a></div>
      </section>
    </main>
  );
}
