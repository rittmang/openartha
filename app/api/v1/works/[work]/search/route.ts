import { publicPassage, searchCorpusDetailed } from '@/app/lib/corpus';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ work: string }> }) {
  const { work } = await params;
  const workRecord = getWork(work);
  if (!workRecord) {
    const message = `Unknown work: ${work}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Work not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'WORK_NOT_FOUND', message } }, { status: 404 });
  }
  const url = new URL(request.url);
  const query = url.searchParams.get('q')?.trim() ?? '';
  const requestedLimit = Number(url.searchParams.get('limit') ?? 30);
  const limit = Number.isFinite(requestedLimit) ? Math.max(1, Math.min(Math.trunc(requestedLimit), 100)) : 30;
  if (!query) {
    const message = 'Provide a non-empty q search parameter.';
    return wantsMarkdown(request) ? markdownResponse(`# Search error\n\n${message}\n`, { status: 400 }) : jsonResponse({ error: { code: 'MISSING_QUERY', message } }, { status: 400 });
  }
  const search = searchCorpusDetailed(query);
  const results = search.results.slice(0, limit);
  if (wantsMarkdown(request)) return markdownResponse([`# Search ${workRecord.title}: ${query}`, '', `${search.total} result(s): ${search.exactCount} exact word, ${search.compoundCount} compound form. Returning ${results.length}.`, '', ...results.map((result) => `- [${result.passage.chapter}.${result.passage.verse}](/gita/${result.passage.chapter}/${result.passage.verse}) — ${result.kind === 'exact' ? 'Exact word' : 'Compound form'} in ${result.hits[0]?.label ?? 'corpus'}`), ''].join('\n'));
  return jsonResponse({ data: results.map((result) => ({ ...publicPassage(result.passage), workId: work, searchMatch: { kind: result.kind, hits: result.hits } })), meta: { workId: work, query, total: search.total, returned: results.length, exactCount: search.exactCount, compoundCount: search.compoundCount, limit, engine: 'corpus-lexical-v2' } });
}
