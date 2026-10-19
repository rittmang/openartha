import { corpus } from '@/app/lib/corpus';
import { gitaSources } from '@/app/lib/sources';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request) {
  if (wantsMarkdown(request)) {
    return markdownResponse(['# Sources', '', ...gitaSources.map((source) => `## ${source.title}\n\n- ID: \`${source.id}\`\n- Contributor: ${source.contributor}\n- Rights: ${source.rights}\n- URL: ${source.url}`), ''].join('\n'));
  }
  return jsonResponse({ data: gitaSources, meta: { corpusVersion: corpus.corpusVersion } });
}
