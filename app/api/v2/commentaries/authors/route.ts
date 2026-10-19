import { commentaryAuthors, commentarySource } from '@/app/lib/commentaries';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';
import { translations, translationSummary } from '@/app/lib/translations';

export async function GET(request: Request) {
  if (wantsMarkdown(request)) {
    return markdownResponse([
      '# Commentary authors', '',
      `Source snapshot: [${commentarySource.source.title}](${commentarySource.source.repository}) at \`${commentarySource.source.commit}\`.`, '',
      ...translations.map((translation) => `Additional source: [${translation.title}](${translation.source.catalogUrl}) — ${translation.source.rights}; \`${translation.corpusVersion}\`.`), '',
      ...commentaryAuthors.map((author) => `- **${author.displayName}** — published fields: ${author.publicFields.join(', ')} — ${author.rightsNote}`), '',
    ].join('\n'));
  }
  return jsonResponse({ data: commentaryAuthors, meta: { corpusVersion: commentarySource.corpusVersion, sourceCommit: commentarySource.source.commit, additionalTranslations: translations.map(translationSummary) } });
}
