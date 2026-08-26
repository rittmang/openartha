import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Corpus methodology',
  description: 'Recension, transcription, alignment, validation, versioning, and correction methods for Agentic Gita.',
};

const steps = [
  ['01', 'Choose the passage structure', 'The research edition follows the standard 700-verse structure. Chapter 13 contains 34 numbered verses; the alternate opening question by Arjuna is preserved as an unnumbered recensional prelude.'],
  ['02', 'Keep representations distinct', 'Devanagari, IAST, and English are stored as separate representations with their own source roles. A change to one does not silently rewrite another.'],
  ['03', 'Cross-check machines before people', 'Build checks enforce 18 chapters, 700 unique references, continuous numbering, NFC Unicode, Devanagari presence, reproducible exports, and matching SHA-256 hashes.'],
  ['04', 'Review every passage twice', 'Two independent human decisions are required for Sanskrit, transliteration, English alignment, and provenance. No record can inherit approval from a chapter-level check.'],
  ['05', 'Version every correction', 'A released file is immutable. Corrections create a new corpus version, regenerate every export, and appear in the changelog.'],
];

export default function MethodologyPage() {
  return (
    <main className="shell page-shell prose-page">
      <header className="page-header">
        <div className="eyebrow">Editorial method</div>
        <h1>A corpus should show its seams.</h1>
        <p>The purpose of this release is not to disguise uncertainty. It is to make uncertainty inspectable, reviewable, and correctable.</p>
      </header>
      <section className="method-steps" aria-label="Corpus method">
        {steps.map(([number, title, body]) => <article key={number}><span>{number}</span><h2>{title}</h2><p>{body}</p></article>)}
      </section>
      <section className="method-note">
        <div><span className="eyebrow">Important limitation</span><h2>The English alignment is provisional.</h2></div>
        <div><p>Telang’s 1882 English translation is public domain, but the available digital transcription is chapter-level rather than verse-numbered. This release preserves the machine-assisted verse alignment and its confidence signal instead of presenting it as settled scholarship.</p><p>Low-confidence alignments and all other records still require two human review passes before the stable release.</p></div>
      </section>
      <section className="correction-policy">
        <h2>Report a correction</h2>
        <p>A useful correction identifies the canonical reference, representation, proposed reading, source, and exact locator. Corpus curation remains repository-reviewed; there is no public editing or administration interface in V1.</p>
        <div><a className="button button-secondary" href="/sources">Inspect sources</a><a className="button button-primary" href="/data">Download the corpus</a></div>
      </section>
    </main>
  );
}
