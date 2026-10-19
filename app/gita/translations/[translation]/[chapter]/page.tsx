import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { chapterTranslations, getTranslation, getTranslationChapter } from '@/app/lib/translations';
import { Breadcrumbs } from '@/components/breadcrumbs';
import { TranslationSource } from '@/components/translation-source';

type Props = { params: Promise<{ translation: string; chapter: string }> };

export function generateStaticParams() {
  return chapterTranslations.flatMap((translation) => translation.chapters.map((chapter) => ({ translation: translation.id, chapter: String(chapter.chapter) })));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const values = await params;
  const translation = getTranslation(values.translation);
  const chapter = getTranslationChapter(values.translation, Number(values.chapter));
  return translation && chapter ? { title: `Edwin Arnold — Chapter ${chapter.chapter}`, description: `${chapter.title}. Read Chapter ${chapter.chapter} of The Song Celestial in ${translation.translator}'s English translation.`, alternates: { canonical: `/gita/translations/${translation.id}/${chapter.chapter}` } } : {};
}

export default async function TranslationChapterPage({ params }: Props) {
  const values = await params;
  const translation = getTranslation(values.translation);
  const chapter = getTranslationChapter(values.translation, Number(values.chapter));
  if (!translation || !chapter) notFound();
  const base = `/gita/translations/${translation.id}`;
  return (
    <main className="shell page-shell prose-page translation-chapter-page">
      <Breadcrumbs items={[{ label: 'Bhagavad Gita', href: '/gita' }, { label: 'Translations', href: '/gita/translations' }, { label: translation.translator, href: base }, { label: `Chapter ${chapter.chapter}` }]} />
      <header className="page-header"><div className="eyebrow">The Song Celestial · Chapter {chapter.chapter}</div><h1 className="translation-chapter-title">{chapter.title}</h1><p>{translation.translator} · English · {translation.editionYear} edition</p><p className="alignment-note">Complete source chapter. Verse alignment has not been verified.</p><div className="source-links"><a href={`/gita/${chapter.chapter}`}>Read the Sanskrit chapter</a><a href={`${base}#translator-notes`}>Translator’s notes</a></div></header>
      <article className="translation-poem" lang="en" aria-label={`Chapter ${chapter.chapter} translation`}>{chapter.text}</article>
      <nav className="chapter-navigation" aria-label="Translation chapter navigation">
        {chapter.chapter > 1 ? <a href={`${base}/${chapter.chapter - 1}`}>← Chapter {chapter.chapter - 1}</a> : <a href={base}>All chapters</a>}
        {chapter.chapter < 18 ? <a href={`${base}/${chapter.chapter + 1}`}>Chapter {chapter.chapter + 1} →</a> : <a href={base}>All chapters</a>}
      </nav>
      <TranslationSource translation={translation} />
      <p className="alignment-note">Source locator: {chapter.sourceHeading}, lines {chapter.sourceLocator.lineStart}–{chapter.sourceLocator.lineEnd} of the downloaded text. {translation.reviewStatus}.</p>
      <div className="source-links"><a href={`/api/v1/works/gita/translations/${translation.id}/chapters/${chapter.chapter}`}>View JSON</a><a href={`/api/v1/works/gita/translations/${translation.id}/chapters/${chapter.chapter}?format=markdown`}>View Markdown</a></div>
    </main>
  );
}
