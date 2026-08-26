import Link from 'next/link';
import { StatusPill } from '@/components/status-pill';
import { corpus, getPassage } from '@/app/lib/corpus';

export default function Home() {
  const specimen = getPassage(2, 47)!;
  return (
    <main>
      <section className="hero shell">
        <div className="eyebrow">A versioned public corpus</div>
        <h1>The Bhagavad Gita,<br />presented as evidence.</h1>
        <p className="hero-copy">
          Sanskrit, transliteration, and a historical English witness—kept
          together with the sources and review state behind every passage.
        </p>
        <div className="hero-actions">
          <Link className="button button-primary" href="/gita">Begin reading</Link>
          <Link className="button button-secondary" href="/data">Download the data</Link>
        </div>
        <dl className="hero-stats" aria-label="Corpus summary">
          <div><dt>Passages</dt><dd>{corpus.work.passageCount}</dd></div>
          <div><dt>Chapters</dt><dd>18</dd></div>
          <div><dt>Version</dt><dd>RC.1</dd></div>
          <div><dt>Access</dt><dd>Open</dd></div>
        </dl>
      </section>

      <section className="shell specimen" aria-labelledby="specimen-title">
        <div className="section-heading">
          <span>One passage, three representations</span>
          <Link href="/gita/2/47">Gītā 2.47</Link>
        </div>
        <article className="verse-card">
          <h2 id="specimen-title" className="devanagari" lang="sa-Deva">{specimen.representations.devanagari}</h2>
          <p className="iast" lang="sa-Latn">{specimen.representations.iast}</p>
          <div className="translation">
            <span>Telang, 1882</span>
            <p>{specimen.representations.english}</p>
          </div>
        </article>
      </section>

      <section className="evidence-band">
        <div className="shell evidence-grid">
          <div>
            <div className="eyebrow">Research preview</div>
            <h2>Nothing here is silently “cleaned.”</h2>
          </div>
          <div className="evidence-copy">
            <p>
              Every record includes a stable reference, source locator,
              representation-level attribution, checksum, and explicit review state.
              The 700-verse structure is validated; human textual review is still open.
            </p>
            <StatusPill>Two human review passes pending</StatusPill>
            <Link className="text-link" href="/methodology">Read the methodology <span aria-hidden="true">→</span></Link>
          </div>
        </div>
      </section>

      <section className="shell access-section" aria-labelledby="access-title">
        <div>
          <div className="eyebrow">Use the corpus</div>
          <h2 id="access-title">Read it. Inspect it. Take it with you.</h2>
        </div>
        <div className="access-cards">
          <Link href="/gita" className="access-card">
            <span className="card-number">01</span>
            <h3>Reader</h3>
            <p>Move through all eighteen chapters with Sanskrit, IAST, translation, and provenance together.</p>
          </Link>
          <Link href="/data" className="access-card">
            <span className="card-number">02</span>
            <h3>Dataset</h3>
            <p>Download versioned TEI XML, JSONL, and CSV with a manifest and SHA-256 checksums.</p>
          </Link>
          <Link href="/api/v1/works" className="access-card">
            <span className="card-number">03</span>
            <h3>API</h3>
            <p>Use stable, read-only JSON or Markdown interfaces without an account or API key.</p>
          </Link>
        </div>
      </section>
    </main>
  );
}
