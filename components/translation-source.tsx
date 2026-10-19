import type { ChapterTranslation } from '@/app/lib/translations';

export function TranslationSource({ translation }: { translation: ChapterTranslation }) {
  return (
    <aside className="author-rights translation-source" aria-label="Translation source and rights">
      <span className="eyebrow">Source and rights</span>
      <p>{translation.translator} · {translation.editionYear} edition · Project Gutenberg ebook #{translation.source.ebookNumber}. {translation.source.rights}.</p>
      <p>{translation.source.credits}</p>
      <p>This eBook is for the use of anyone anywhere in the United States and most other parts of the world at no cost and with almost no restrictions whatsoever. You may copy it, give it away or re-use it under the terms of the <a href={translation.source.licenseUrl}>Project Gutenberg License</a> included with this eBook or online at <a href="https://www.gutenberg.org">www.gutenberg.org</a>. If you are not located in the United States, you will have to check the laws of the country where you are located before using this eBook.</p>
      <div className="source-links">
        <a href={translation.source.catalogUrl}>Gutenberg catalog ↗</a>
        <a href={`/data/${translation.corpusVersion}/pg2388.txt`}>Original text and full license</a>
        <a href={`/data/${translation.corpusVersion}/rights.json`}>Rights record</a>
      </div>
    </aside>
  );
}
