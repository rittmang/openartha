import arnoldTranslation from '@/corpus/gita-translations/edwin-arnold/translation.json';

export type TranslationCorpus = typeof arnoldTranslation;
export const translations: TranslationCorpus[] = [arnoldTranslation];
export const translationAuthors = translations.map((translation) => ({
  id: translation.id,
  sourceKey: translation.source.id,
  displayName: translation.translator,
  availableFields: ['et'],
  publicFields: ['et'],
  rightsStatus: 'full-text-allowed',
  rightsNote: `${translation.source.rights}. ${translation.title}, ${translation.editionYear} edition; Project Gutenberg ebook #${translation.source.ebookNumber}. ${translation.reviewStatus}.`,
  sourceId: translation.source.id,
  sourceUrl: translation.source.catalogUrl,
  corpusVersion: translation.corpusVersion,
}));

export const readingMetadataById = new Map(translations.flatMap((translation) => translation.verses.map((record) => {
  const { id, canonicalRef, editionId, checksum, corpusVersion, alignmentStatus, sourceCommit, sourceChecksum, alignment, firstReview } = record;
  return [id, { id, canonicalRef, editionId, checksum, corpusVersion, alignmentStatus, sourceCommit, sourceChecksum, alignment, firstReview }] as const;
})));

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
