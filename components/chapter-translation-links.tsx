import { chapterTranslations } from '@/app/lib/translations';

export function ChapterTranslationLinks({ chapter }: { chapter: number }) {
  return (
    <aside className="chapter-translation-links" aria-label="Chapter translations">
      <span className="eyebrow">More English translations</span>
      {chapterTranslations.map((translation) => (
        <a key={translation.id} href={`/gita/translations/${translation.id}/${chapter}`}>
          Read {translation.translator}’s Chapter {chapter} translation →
        </a>
      ))}
      <p>Available by chapter. Verse alignment has not been verified.</p>
    </aside>
  );
}
