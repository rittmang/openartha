import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { chapterTitles, getAdjacentPassages, getPassage } from '@/app/lib/corpus';
import { getPassageCommentaries } from '@/app/lib/commentaries';
import { Breadcrumbs } from '@/components/breadcrumbs';
import { CommentaryWitnesses } from '@/components/commentary-witnesses';
import { StatusPill } from '@/components/status-pill';

type Props = { params: Promise<{ chapter: string; verse: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const values = await params;
  const passage = getPassage(Number(values.chapter), Number(values.verse));
  if (!passage) return {};
  const title = `Bhagavad Gita ${passage.chapter}.${passage.verse}`;
  const description = passage.representations.english.slice(0, 155);
  return {
    title,
    description,
    alternates: { canonical: `/gita/${passage.chapter}/${passage.verse}` },
    openGraph: { title, description, images: [] },
    twitter: { title, description, images: [] },
  };
}

export default async function VersePage({ params }: Props) {
  const values = await params;
  const chapter = Number(values.chapter);
  const verse = Number(values.verse);
  if (!Number.isInteger(chapter) || !Number.isInteger(verse)) notFound();
  const passage = getPassage(chapter, verse);
  if (!passage) notFound();
  const adjacent = getAdjacentPassages(passage);
  const commentaries = await getPassageCommentaries(chapter, verse);
  const chapterTitle = chapterTitles[chapter - 1][0];
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Quotation',
    name: `Bhagavad Gita ${chapter}.${verse}`,
    text: passage.representations.english,
    inLanguage: 'en',
    isPartOf: { '@type': 'Book', name: 'Bhagavad Gita' },
    citation: passage.provenance.map((source) => `${source.sourceId}: ${source.locator}`),
  };
  return (
    <main className="shell page-shell verse-page">
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd).replace(/</g, '\\u003c') }} />
      <Breadcrumbs items={[
        { label: 'Bhagavad Gita', href: '/gita' },
        { label: `Chapter ${chapter}`, href: `/gita/${chapter}` },
        { label: `Verse ${verse}` },
      ]} />
      <header className="verse-page-header">
        <div>
          <span className="eyebrow">{chapterTitle}</span>
          <h1>{chapter}.{verse}</h1>
        </div>
        <div className="verse-badges"><StatusPill>{passage.translation.status}</StatusPill><span>{passage.speaker}</span></div>
      </header>

      <article className="detail-verse">
        <section aria-labelledby="devanagari-title">
          <h2 id="devanagari-title">Sanskrit · Devanagari</h2>
          <p className="detail-devanagari" lang="sa-Deva">{passage.representations.devanagari}</p>
        </section>
        <section aria-labelledby="iast-title">
          <h2 id="iast-title">Sanskrit · IAST</h2>
          <p className="detail-iast" lang="sa-Latn">{passage.representations.iast}</p>
        </section>
        <section aria-labelledby="translation-title">
          <div className="detail-section-title">
            <h2 id="translation-title">English translation</h2>
            <span>{passage.translation.translator}, {passage.translation.editionYear}</span>
          </div>
          <blockquote>{passage.representations.english}</blockquote>
          {passage.review.firstHumanReview === 'verified' && passage.review.firstReviewConfidence !== undefined ? (
            <p className="alignment-note">This verse was aligned by machine and has completed first review (reviewer confidence: {Math.round(passage.review.firstReviewConfidence * 100)}%); second review pending. Machine alignment confidence: {Math.round(passage.translation.alignmentConfidence * 100)}%.</p>
          ) : (
            <p className="alignment-note">This verse was aligned by machine and has not yet completed two independent human reviews. Alignment confidence: {Math.round(passage.translation.alignmentConfidence * 100)}%.</p>
          )}
        </section>
      </article>

      {commentaries.length ? <CommentaryWitnesses commentaries={commentaries} /> : null}

      {passage.variants.length > 0 && (
        <section className="variant-panel" aria-labelledby="variant-title">
          <div><span className="eyebrow">Critical apparatus</span><h2 id="variant-title">Textual variant</h2></div>
          {passage.variants.map((variant) => (
            <div key={variant.type}>
              <p>{variant.note}</p>
              <p className="variant-devanagari" lang="sa-Deva">{variant.devanagari}</p>
              <p className="variant-iast" lang="sa-Latn">{variant.iast}</p>
            </div>
          ))}
        </section>
      )}

      <section className="provenance-panel" aria-labelledby="provenance-title">
        <div>
          <span className="eyebrow">Source trail</span>
          <h2 id="provenance-title">Trace this verse</h2>
        </div>
        <dl>
          <div><dt>Canonical ID</dt><dd><code>{passage.canonicalRef}</code></dd></div>
          <div><dt>Corpus version</dt><dd>{passage.corpusVersion}</dd></div>
          <div><dt>Text review</dt><dd>{passage.review.transcription}; {passage.review.firstHumanReview === 'verified' ? 'first review verified, second pass pending' : 'two human passes pending'}</dd></div>
          {passage.provenance.map((source) => <div key={`${source.sourceId}-${source.role}`}><dt>{source.role}</dt><dd>{source.sourceId} · {source.locator}</dd></div>)}
          <div><dt>SHA-256</dt><dd className="checksum"><code>{passage.checksum}</code></dd></div>
        </dl>
        <div className="api-links">
          <a href={`/api/v1/passages/gita/${chapter}/${verse}`}>View JSON</a>
          <a href={`/api/v1/passages/gita/${chapter}/${verse}?format=markdown`}>View Markdown</a>
          <a href={`/api/v2/passages/gita/${chapter}/${verse}`}>View JSON with commentaries</a>
        </div>
      </section>

      <nav className="passage-navigation" aria-label="Passage navigation">
        {adjacent.previous ? <a href={`/gita/${adjacent.previous.chapter}/${adjacent.previous.verse}`}><span>Previous</span><strong>{adjacent.previous.chapter}.{adjacent.previous.verse}</strong></a> : <span />}
        {adjacent.next ? <a href={`/gita/${adjacent.next.chapter}/${adjacent.next.verse}`}><span>Next</span><strong>{adjacent.next.chapter}.{adjacent.next.verse}</strong></a> : <a href="/gita"><span>All</span><strong>Chapters</strong></a>}
      </nav>
    </main>
  );
}
