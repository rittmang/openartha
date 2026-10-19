import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { chapterTranslations, getTranslation } from '@/app/lib/translations';
import { Breadcrumbs } from '@/components/breadcrumbs';
import { TranslationSource } from '@/components/translation-source';

type Props = { params: Promise<{ translation: string }> };

export function generateStaticParams() {
  return chapterTranslations.map((translation) => ({ translation: translation.id }));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const translation = getTranslation((await params).translation);
  return translation ? { title: `${translation.translator} — The Song Celestial`, description: `Read all 18 chapters of ${translation.translator}'s English translation of the Bhagavad Gita, from Project Gutenberg ebook #${translation.source.ebookNumber}.`, alternates: { canonical: `/gita/translations/${translation.id}` } } : {};
}

export default async function TranslationPage({ params }: Props) {
  const translation = getTranslation((await params).translation);
  if (!translation) notFound();
  return (
    <main className="shell page-shell prose-page">
      <Breadcrumbs items={[{ label: 'Bhagavad Gita', href: '/gita' }, { label: 'Translations', href: '/gita/translations' }, { label: translation.translator }]} />
      <header className="page-header"><div className="eyebrow">English translation · {translation.editionYear} edition</div><h1>The Song Celestial</h1><p>{translation.translator}’s poetic translation of the Bhagavad Gita, preserved in its 18 source chapters.</p><p className="alignment-note">Chapter-level translation. Verse alignment has not been verified. Arnold’s omissions, wording, line breaks, and notes follow the source.</p></header>
      <section aria-labelledby="translation-chapters-title">
        <div className="section-heading"><h2 id="translation-chapters-title">Choose a chapter</h2><span>{translation.chapters.length} chapters</span></div>
        <ol className="chapter-grid">{translation.chapters.map((chapter) => <li key={chapter.id}><a href={`/gita/translations/${translation.id}/${chapter.chapter}`}><span className="chapter-number">{String(chapter.chapter).padStart(2, '0')}</span><span className="chapter-name"><strong className="translation-chapter-title">{chapter.title}</strong></span><span className="chapter-count">English</span><span aria-hidden="true">→</span></a></li>)}</ol>
      </section>
      <TranslationSource translation={translation} />
      <div className="source-links"><a href={`/data/${translation.corpusVersion}/translation.json`} download>Download all chapters (JSON)</a><a href={`/data/${translation.corpusVersion}/manifest.json`}>Manifest and checksums</a><a href={`/api/v1/works/gita/translations/${translation.id}/chapters/1`}>Chapter API</a></div>
      <section className="translation-notes" id="translator-notes" aria-labelledby="translator-notes-title">
        <div className="section-heading"><h2 id="translator-notes-title">Translator’s notes</h2><span>{translation.notes.length} notes</span></div>
        <p className="alignment-note">Footnote markers follow the downloaded source, including its numbering anomalies. All notes are preserved here.</p>
        <ol>{translation.notes.map((note) => <li key={note.number} id={`note-${note.number}`} value={note.number}><p>{note.text}</p></li>)}</ol>
      </section>
    </main>
  );
}
