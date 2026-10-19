import arnoldTranslation from '@/corpus/gita-translations/edwin-arnold/translation.json';
import { searchPassages } from '@/app/lib/search';

export type TranslationCorpus = typeof arnoldTranslation;
export const translations: TranslationCorpus[] = [arnoldTranslation];
export const arnoldAuthor = {
  id: arnoldTranslation.id,
  sourceKey: arnoldTranslation.source.id,
  displayName: arnoldTranslation.translator,
  availableFields: ['et'],
  publicFields: ['et'],
  rightsStatus: 'full-text-allowed',
  rightsNote: `${arnoldTranslation.source.rights}. The Song Celestial, ${arnoldTranslation.editionYear} edition; Project Gutenberg ebook #2388. ${arnoldTranslation.reviewStatus}.`,
  sourceId: arnoldTranslation.source.id,
  sourceUrl: arnoldTranslation.source.catalogUrl,
  corpusVersion: arnoldTranslation.corpusVersion,
};

export function translationSummary(translation: TranslationCorpus) {
  const { chapters, notes, verses, paratext, ...metadata } = translation;
  return {
    ...metadata,
    chapterCount: chapters.length,
    translatorNoteCount: notes.length,
    canonicalPassages: verses.length,
    paratextCount: paratext.length,
    route: `/gita/commentaries/${translation.id}`,
    apiRoot: `/api/v2/commentaries/authors/${translation.id}`,
    downloadUrl: `/data/${translation.corpusVersion}/translation.json`,
  };
}

export function getArnoldPassage(chapter: number, verse: number) {
  return arnoldTranslation.verses.find((record) => record.chapter === chapter && record.verse === verse);
}

export function getArnoldChapter(chapter: number) {
  return arnoldTranslation.verses.filter((record) => record.chapter === chapter);
}

const searchableVerses = arnoldTranslation.verses.filter((verse) => verse.content).map((verse) => ({
  ...verse,
  speaker: null,
  representations: { devanagari: '', iast: '', english: verse.content },
}));
const recordsByReference = new Map(arnoldTranslation.verses.map((verse) => [verse.canonicalRef, verse]));

export function searchArnoldTranslations(query: string, limit = 60) {
  return searchPassages(searchableVerses, query).results.slice(0, limit).map((result) => ({
    ...recordsByReference.get(result.passage.canonicalRef)!,
    kind: result.kind,
    ranges: result.hits.find((hit) => hit.field === 'english')?.ranges ?? [],
  }));
}
