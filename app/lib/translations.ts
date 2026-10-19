import arnoldTranslation from '@/corpus/gita-translations/edwin-arnold/translation.json';
import { searchTranslationChapters } from '@/app/lib/search';

export type ChapterTranslation = typeof arnoldTranslation;
export const chapterTranslations: ChapterTranslation[] = [arnoldTranslation];

export function getTranslation(id: string) {
  return chapterTranslations.find((translation) => translation.id === id);
}

export function getTranslationChapter(id: string, chapter: number) {
  if (!Number.isInteger(chapter)) return undefined;
  return getTranslation(id)?.chapters.find((item) => item.chapter === chapter);
}

export function translationSummary(translation: ChapterTranslation) {
  const { chapters, notes, ...metadata } = translation;
  return {
    ...metadata,
    chapterCount: chapters.length,
    translatorNoteCount: notes.length,
    route: `/gita/translations/${translation.id}`,
    apiRoot: `/api/v1/works/${translation.workId}/translations/${translation.id}`,
    downloadUrl: `/data/${translation.corpusVersion}/translation.json`,
  };
}

export function searchChapterTranslations(query: string) {
  return chapterTranslations.flatMap((translation) => searchTranslationChapters(translation.chapters, query)
    .map((match) => ({ ...match, translationId: translation.id, translator: translation.translator, corpusVersion: translation.corpusVersion })));
}

export type ChapterTranslationSearchResult = ReturnType<typeof searchChapterTranslations>[number];
