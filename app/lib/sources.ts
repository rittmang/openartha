import { corpus, type Source } from '@/app/lib/corpus';
import { translations } from '@/app/lib/translations';

export const gitaSources: Source[] = [
  ...corpus.sources,
  ...translations.map((translation) => ({
    id: translation.source.id,
    title: translation.title,
    contributor: `${translation.translator} (translator)`,
    year: translation.editionYear,
    url: translation.source.catalogUrl,
    transcriptionUrl: translation.source.textUrl,
    rights: `${translation.source.rights}; Project Gutenberg credits and full license retained with the downloaded source`,
    role: 'English poetic translation aligned to the 700-verse canon, with shared renderings and source omissions recorded',
  })),
];
