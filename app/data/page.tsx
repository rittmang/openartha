import type { Metadata } from 'next';
import manifest from '@/public/data/gita-1.0.0-rc.1/manifest.json';
import commentaryManifest from '@/public/data/gita-commentaries-0.2.0/manifest.json';
import { corpus } from '@/app/lib/corpus';
import { StatusPill } from '@/components/status-pill';

export const metadata: Metadata = {
  title: 'Download OpenArtha data',
  description: 'Download versioned Bhagavad Gita text and commentary data in TEI XML, JSONL, and CSV, with manifests, rights records, and SHA-256 checksums.',
  alternates: { canonical: '/data' },
};

const formatNotes: Record<string, string> = {
  'gita.xml': 'Canonical TEI P5 source representation',
  'gita.jsonl': 'One complete passage record per line',
  'gita.csv': 'Flat table for spreadsheets and analysis',
};

function commentaryFormatNote(name: string) {
  if (name.endsWith('.jsonl')) return 'Verse-aligned records, split by language';
  if (name.endsWith('.xml')) return 'Simplified TEI, split by language';
  if (name === 'rights.json') return 'Dataset licensing and author-field coverage';
  if (name === 'alignment-report.json') return 'Canonical alignment counts and exceptions';
  if (name.startsWith('LICENSE')) return 'GPL-3.0 license text';
  return 'Versioned corpus file';
}

function fileSize(bytes: number) {
  return bytes > 1024 * 1024 ? `${(bytes / 1024 / 1024).toFixed(1)} MB` : `${(bytes / 1024).toFixed(0)} KB`;
}

export default function DataPage() {
  return (
    <main className="shell page-shell data-page">
      <header className="page-header split-header">
        <div><div className="eyebrow">Open data</div><h1>Take the whole text with you.</h1><p>The same source-aware records are available as versioned, checksummed exports.</p></div>
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
      <section className="release-card commentary-release" aria-labelledby="commentary-release-title">
        <div className="release-heading"><div><span>Commentary research preview</span><h2 id="commentary-release-title">{commentaryManifest.corpusVersion}</h2></div><span>{commentaryManifest.commentaryRecords.toLocaleString()} records · {commentaryManifest.publicEditions} public witnesses</span></div>
        <div className="download-list">{commentaryManifest.files.map((file) => <a key={file.name} href={`/data/${commentaryManifest.corpusVersion}/${file.name}`} download><span className="file-type">{file.name.split('.').at(-1)?.toUpperCase()}</span><span><strong>{file.name}</strong><small>{commentaryFormatNote(file.name)} · {fileSize(file.bytes)}</small></span><span aria-hidden="true">↓</span></a>)}</div>
        <div className="manifest-links"><a href={`/data/${commentaryManifest.corpusVersion}/manifest.json`}>Manifest.json</a><a href={`/data/${commentaryManifest.corpusVersion}/checksums.sha256`}>SHA-256 checksums</a><a href="/api/v2/commentaries/authors">Author registry API</a></div>
      </section>
      <section className="data-notice">
        <div><span className="eyebrow">Release gate</span><h2>Structured does not mean verified.</h2></div>
        <div><p>{corpus.releaseBlocker}</p><p>The current files deliberately identify themselves as a research preview. Stable <code>gita-1.0.0</code> will be cut only when all 700 passages satisfy the review gate.</p><a className="text-link" href="/methodology">See how releases are checked →</a></div>
      </section>
      <section className="api-callout"><div><span className="eyebrow">Read-only API</span><h2>Build with OpenArtha.</h2></div><div><code>GET /api/v2/works/gita/passages/2/47</code><code>GET /api/v2/works/gita/search?q=yoga</code><code>GET /api/v1/works</code><a href="/api/v1/works">View the works API →</a></div></section>
    </main>
  );
}
