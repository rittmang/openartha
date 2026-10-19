import { corpus, type Source } from '@/app/lib/corpus';
import { chapterTranslations } from '@/app/lib/translations';

export const gitaSources: Source[] = [
  ...corpus.sources,
  ...chapterTranslations.map((translation) => ({
    id: translation.source.id,
    title: translation.title,
    contributor: `${translation.translator} (translator)`,
    year: translation.editionYear,
    url: translation.source.catalogUrl,
    transcriptionUrl: translation.source.textUrl,
    rights: `${translation.source.rights}; Project Gutenberg credits and full license retained with the downloaded source`,
    role: 'English poetic translation, available in 18 source chapters; verse alignment not verified',
  })),
];
