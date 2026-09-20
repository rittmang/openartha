import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'How OpenArtha checks each text',
  description: 'See how OpenArtha structures, aligns, validates, versions, and reviews primary texts while keeping uncertainty visible.',
  alternates: { canonical: '/methodology' },
};

const steps = [
  ['01', 'Define the edition', 'The research edition follows the standard 700-verse structure. Chapter 13 contains 34 numbered verses; the alternate opening question by Arjuna is preserved as an unnumbered recensional prelude.'],
  ['02', 'Keep each representation separate', 'Devanagari, IAST, and English are stored as separate representations with their own source roles. A change to one does not silently rewrite another.'],
  ['03', 'Automate structural checks', 'Build checks enforce 18 chapters, 700 unique references, continuous numbering, NFC Unicode, Devanagari presence, reproducible exports, and matching SHA-256 hashes.'],
  ['04', 'Require two human reviews', 'Two independent human decisions are required for Sanskrit, transliteration, English alignment, and provenance. No record can inherit approval from a chapter-level check.'],
  ['05', 'Version every correction', 'A released file is immutable. Corrections create a new corpus version, regenerate every export, and appear in the changelog.'],
  ['06', 'Keep verses and paratext distinct', 'The commentary source has 719 chapter-level records. Eighteen colophons and the alternate Chapter 13 opening are preserved as paratext, while only 700 records align to canonical verse IDs.'],
  ['07', 'Carry every license forward', 'All 29 supplied fields from 22 authors are published under the pinned dataset snapshot’s repository-wide GPL-3.0 license. The exact commit, source locators, license text, and checksums travel with the release.'],
];

export default function MethodologyPage() {
  return (
    <main className="shell page-shell prose-page">
      <header className="page-header">
        <div className="eyebrow">How OpenArtha earns trust</div>
        <h1>Meaning is stronger when the evidence stays visible.</h1>
        <p>Each record states what was automated, what was checked, and what still needs independent human review.</p>
      </header>
      <section className="method-steps" aria-label="Corpus method">
        {steps.map(([number, title, body]) => <article key={number}><span>{number}</span><h2>{title}</h2><p>{body}</p></article>)}
      </section>
      <section className="method-note">
        <div><span className="eyebrow">Important limitation</span><h2>The English alignment is provisional.</h2></div>
        <div><p>Telang’s 1882 English translation is public domain, but the available digital transcription is chapter-level rather than verse-numbered. This release preserves the machine-assisted verse alignment and its confidence signal instead of presenting it as settled scholarship.</p><p>Low-confidence alignments and all other records still require two human review passes before the stable release.</p></div>
      </section>
      <section className="method-note">
        <div><span className="eyebrow">Commentary limitation</span><h2>Alignment is visible, not assumed.</h2></div>
        <div><p>Public translation and commentary records are deterministically mapped from a pinned 719-unit source snapshot to the 700-verse research edition. Each record carries its original file locator, raw and display checksums, and an explicit machine-aligned review status.</p><p>Prabhupada’s supplied Chapter 1 and 13 numbering differs from the default source layout. That exception is mapped explicitly and documented instead of being silently forced onto the same coordinates.</p><a className="text-link" href="/data/gita-commentaries-0.2.0/alignment-report.json">Open the alignment report →</a></div>
      </section>
      <section className="correction-policy">
        <h2>What a useful correction includes</h2>
        <p>Include the canonical reference, representation, proposed reading, source, and exact locator. Corpus curation remains repository-reviewed; there is no public editing or administration interface in V1.</p>
        <div><a className="button button-secondary" href="/sources">View the sources</a><a className="button button-primary" href="/data">Download the data</a></div>
      </section>
    </main>
  );
}
