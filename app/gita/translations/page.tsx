import type { Metadata } from 'next';
import { corpus } from '@/app/lib/corpus';
import { chapterTranslations } from '@/app/lib/translations';
import { publicCommentaryAuthors, commentaryFieldLabels } from '@/app/lib/commentaries';
import { Breadcrumbs } from '@/components/breadcrumbs';

export const metadata: Metadata = {
  title: 'Bhagavad Gita translations',
  description: 'Read English translations by K. T. Telang and Sir Edwin Arnold, and explore supplied English and Hindi translations of the Bhagavad Gita.',
  alternates: { canonical: '/gita/translations' },
};

export default function TranslationsPage() {
  const authors = publicCommentaryAuthors.filter((author) => author.publicFields.some((field) => field === 'et' || field === 'ht'));
  return (
    <main className="shell page-shell prose-page">
      <Breadcrumbs items={[{ label: 'Bhagavad Gita', href: '/gita' }, { label: 'Translations' }]} />
      <header className="page-header"><div className="eyebrow">Available translations</div><h1>Read the Gita in another voice.</h1><p>Each translation keeps its edition, source, rights, and available reading structure.</p></header>
      <section aria-labelledby="english-translations-title">
        <div className="section-heading"><h2 id="english-translations-title">English editions</h2></div>
        <div className="author-grid">
          <a className="author-card" href="/gita"><span className="eyebrow">English · {corpus.verses[0].translation.editionYear} · verse-aligned preview</span><h3>{corpus.verses[0].translation.translator}</h3><p>The default English translation alongside Sanskrit and IAST. Verse alignment is provisional; second review is pending.</p><span className="text-link">Read with the Sanskrit →</span></a>
          {chapterTranslations.map((translation) => <a key={translation.id} className="author-card" href={`/gita/translations/${translation.id}`}><span className="eyebrow">English · {translation.editionYear} edition · 18 chapters</span><h3>{translation.translator}</h3><p>{translation.title}. {translation.source.rights}. Available as complete chapters.</p><span className="text-link">Choose a chapter →</span></a>)}
        </div>
      </section>
      <section className="metadata-authors" aria-labelledby="supplied-translations-title">
        <div className="section-heading"><h2 id="supplied-translations-title">Supplied English and Hindi translations</h2><a href="/gita/commentaries">All interpretations →</a></div>
        <div className="author-grid">{authors.map((author) => <a key={author.id} className="author-card" href={`/gita/commentaries/${author.id}`}><span className="eyebrow">{author.publicFields.filter((field) => field === 'et' || field === 'ht').map((field) => commentaryFieldLabels[field]).join(' · ')}</span><h3>{author.displayName}</h3><p>{author.rightsNote}</p><span className="text-link">Read by chapter →</span></a>)}</div>
      </section>
    </main>
  );
}
