import { StatusPill } from '@/components/status-pill';
import { corpus, getPassage } from '@/app/lib/corpus';

export default function Home() {
  const specimen = getPassage(2, 47)!;
  return (
    <main>
      <section className="hero shell">
        <div className="eyebrow">A public, source-aware Gita</div>
        <h1>Read the Gita.<br />See the evidence.</h1>
        <p className="hero-copy">
          Explore all 700 verses in Devanagari, IAST, and English. Every verse
          shows its source, version, and review status, so you can check the text for yourself.
        </p>
        <div className="hero-actions">
          <a className="button button-primary" href="/gita">Read the Gita</a>
          <a className="button button-secondary" href="/methodology">See how this edition works</a>
        </div>
        <dl className="hero-stats" aria-label="Corpus summary">
          <div><dt>Verses</dt><dd>{corpus.work.passageCount}</dd></div>
          <div><dt>Chapters</dt><dd>18</dd></div>
          <div><dt>Version</dt><dd>RC.1</dd></div>
          <div><dt>Access</dt><dd>Open</dd></div>
        </dl>
      </section>

      <section className="shell specimen" aria-labelledby="specimen-title">
        <div className="section-heading">
          <span>One verse, three ways to read it</span>
          <a href="/gita/2/47">Gita 2.47</a>
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
            <div className="eyebrow">Why trust this edition?</div>
            <h2>Every verse shows where it came from.</h2>
          </div>
          <div className="evidence-copy">
            <p>
              Each record includes a stable reference, source locator, text attribution,
              checksum, and clear review status. The 700-verse structure passes automated
              checks. Independent human review is still in progress.
            </p>
            <StatusPill>Human review in progress</StatusPill>
            <a className="text-link" href="/methodology">See how we check the text <span aria-hidden="true">→</span></a>
          </div>
        </div>
      </section>

      <section className="shell access-section" aria-labelledby="access-title">
        <div>
          <div className="eyebrow">Choose your next step</div>
          <h2 id="access-title">Start with a verse—or use the full corpus.</h2>
        </div>
        <div className="access-cards">
          <a href="/gita" className="access-card">
            <span className="card-number">01</span>
            <h3>Read the Gita</h3>
            <p>Read or search all 700 verses. Devanagari, IAST, English, and source notes stay together.</p>
          </a>
          <a href="/data" className="access-card">
            <span className="card-number">02</span>
            <h3>Download the corpus</h3>
            <p>Choose TEI XML, JSONL, or CSV. Each version includes a manifest and SHA-256 checksums.</p>
          </a>
          <a href="/api/v1/works" className="access-card">
            <span className="card-number">03</span>
            <h3>Use the API</h3>
            <p>Fetch verses and search results as JSON or Markdown. No account or API key is required.</p>
          </a>
        </div>
      </section>
    </main>
  );
}
