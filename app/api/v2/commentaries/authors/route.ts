import { commentaryAuthors, commentarySource } from '@/app/lib/commentaries';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request) {
  if (wantsMarkdown(request)) {
    return markdownResponse([
      '# Commentary authors', '',
      `Source snapshot: [${commentarySource.source.title}](${commentarySource.source.repository}) at \`${commentarySource.source.commit}\`.`, '',
      ...commentaryAuthors.map((author) => `- **${author.displayName}** — published fields: ${author.publicFields.join(', ')} — ${author.rightsNote}`), '',
    ].join('\n'));
  }
  return jsonResponse({ data: commentaryAuthors, meta: { corpusVersion: commentarySource.corpusVersion, sourceCommit: commentarySource.source.commit } });
}
