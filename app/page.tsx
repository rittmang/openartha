import type { Metadata } from 'next';
import { StatusPill } from '@/components/status-pill';
import { corpus, getPassage } from '@/app/lib/corpus';
import { publicCommentaryAuthors } from '@/app/lib/commentaries';

export const metadata: Metadata = {
  alternates: { canonical: '/' },
};

export default function Home() {
  const specimen = getPassage(2, 47)!;
  const commentaryCount = publicCommentaryAuthors.reduce((total, author) => total + author.publicFields.length, 0);
  return (
    <main>
      <section className="hero shell">
        <div className="eyebrow">OpenArtha (AR-tha) · Meaning, purpose, or sense</div>
        <h1>Find meaning.<br />Follow it to the source.</h1>
        <p className="hero-copy">
          OpenArtha is an open, source-aware library for reading primary texts alongside
          translations, commentaries, and evidence. Begin with the Bhagavad Gita.
        </p>
        <div className="hero-actions">
          <a className="button button-primary" href="/gita">Start reading the Gita</a>
          <a className="button button-secondary" href="/methodology">See how the text is checked</a>
        </div>
        <dl className="hero-stats" aria-label="Bhagavad Gita corpus summary">
          <div><dt>Verses</dt><dd>{corpus.work.passageCount}</dd></div>
          <div><dt>Chapters</dt><dd>{corpus.chapterCounts.length}</dd></div>
          <div><dt>Translations &amp; commentaries</dt><dd>{commentaryCount}</dd></div>
          <div><dt>Authors</dt><dd>{publicCommentaryAuthors.length}</dd></div>
        </dl>
      </section>

      <section className="shell specimen" aria-labelledby="specimen-title">
        <div className="section-heading">
          <span>Featured verse · Read the text in three forms</span>
          <a href="/gita/2/47">Read Bhagavad Gita 2.47</a>
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
            <div className="eyebrow">Built for scrutiny</div>
            <h2>Meaning opens up when the source stays visible.</h2>
          </div>
          <div className="evidence-copy">
            <p>
              Every passage keeps its text, translation, source locator, review status, and
              checksum together. The 700-verse structure passes automated checks; independent
              human review is still in progress.
            </p>
            <StatusPill>Human review in progress</StatusPill>
            <a className="text-link" href="/methodology">See how the evidence is checked <span aria-hidden="true">→</span></a>
          </div>
        </div>
      </section>

      <section className="shell access-section" aria-labelledby="access-title">
        <div>
          <div className="eyebrow">Ways to use OpenArtha</div>
          <h2 id="access-title">Begin with the text—or take it further.</h2>
        </div>
        <div className="access-cards">
          <a href="/gita" className="access-card">
            <span className="card-number">01</span>
            <h3>Read the Gita</h3>
            <p>Move verse by verse through Sanskrit, transliteration, English, and source notes.</p>
          </a>
          <a href="/gita/commentaries" className="access-card">
            <span className="card-number">02</span>
            <h3>Compare interpretations</h3>
            <p>See how different authors translate and comment on the same verses across Sanskrit, English, and Hindi.</p>
          </a>
          <a href="/data" className="access-card">
            <span className="card-number">03</span>
            <h3>Use the open corpus</h3>
            <p>Download versioned files or query the read-only API, with manifests and checksums included.</p>
          </a>
        </div>
      </section>
    </main>
  );
}
