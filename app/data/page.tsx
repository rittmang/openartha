import type { Metadata } from 'next';
import Link from 'next/link';
import manifest from '@/public/data/gita-1.0.0-rc.1/manifest.json';
import { corpus } from '@/app/lib/corpus';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Download the corpus',
  description: 'Versioned Bhagavad Gita datasets in TEI XML, JSONL, and CSV with SHA-256 checksums.',
};

const formatNotes: Record<string, string> = {
  'gita.xml': 'Canonical TEI P5 source representation',
  'gita.jsonl': 'One complete passage record per line',
  'gita.csv': 'Flat table for spreadsheets and analysis',
};

function fileSize(bytes: number) {
  return `${(bytes / 1024).toFixed(0)} KB`;
}

export default function DataPage() {
  return (
    <main className="shell page-shell data-page">
      <header className="page-header split-header">
        <div><div className="eyebrow">Corpus distribution</div><h1>Take the whole text.</h1><p>Immutable, checksummed exports generated from one canonical corpus build.</p></div>
        <StatusPill>{corpus.corpusVersion}</StatusPill>
      </header>
      <section className="release-card" aria-labelledby="release-title">
        <div className="release-heading"><div><span>Current release candidate</span><h2 id="release-title">{manifest.corpusVersion}</h2></div><span>{manifest.passages} passages · {manifest.chapters} chapters</span></div>
        <div className="download-list">
          {manifest.files.map((file) => (
            <a key={file.name} href={`/data/${manifest.corpusVersion}/${file.name}`} download>
              <span className="file-type">{file.name.split('.').at(-1)?.toUpperCase()}</span>
              <span><strong>{file.name}</strong><small>{formatNotes[file.name]} · {fileSize(file.bytes)}</small></span>
              <span aria-hidden="true">↓</span>
            </a>
          ))}
        </div>
        <div className="manifest-links">
          <a href={`/data/${manifest.corpusVersion}/manifest.json`}>Manifest.json</a>
          <a href={`/data/${manifest.corpusVersion}/checksums.sha256`}>SHA-256 checksums</a>
          <a href="/corpus-rights.json">Rights manifest</a>
        </div>
      </section>
      <section className="data-notice">
        <div><span className="eyebrow">Release gate</span><h2>Structured does not mean final.</h2></div>
        <div><p>{corpus.releaseBlocker}</p><p>The current files deliberately identify themselves as a research preview. Stable <code>gita-1.0.0</code> will be cut only when all 700 passages satisfy the review gate.</p><Link className="text-link" href="/methodology">See the validation process →</Link></div>
      </section>
      <section className="api-callout"><div><span className="eyebrow">Read-only interface</span><h2>Prefer an API?</h2></div><div><code>GET /api/v1/passages/gita/2/47</code><code>GET /api/v1/search?q=action</code><Link href="/api/v1/works">Inspect the works response →</Link></div></section>
    </main>
  );
}
