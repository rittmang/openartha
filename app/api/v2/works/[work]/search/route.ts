import { GET as getGitaSearch } from '@/app/api/v2/search/route';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ work: string }> }) {
  const { work } = await params;
  if (!getWork(work)) {
    const message = `Unknown work: ${work}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Work not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'WORK_NOT_FOUND', message } }, { status: 404 });
  }
  return getGitaSearch(request);
}
