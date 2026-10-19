import { corpus } from '@/app/lib/corpus';
import { gitaSources } from '@/app/lib/sources';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ work: string }> }) {
  const { work } = await params;
  if (!getWork(work)) {
    const message = `Unknown work: ${work}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Work not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'WORK_NOT_FOUND', message } }, { status: 404 });
  }
  if (wantsMarkdown(request)) return markdownResponse(['# Sources', '', ...gitaSources.map((source) => `## ${source.title}\n\n- ID: \`${source.id}\`\n- Contributor: ${source.contributor}\n- Rights: ${source.rights}\n- URL: ${source.url}`), ''].join('\n'));
  return jsonResponse({ data: gitaSources, meta: { workId: work, corpusVersion: corpus.corpusVersion } });
}
