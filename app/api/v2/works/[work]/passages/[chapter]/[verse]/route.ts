import { GET as getGitaPassage } from '@/app/api/v2/passages/gita/[chapter]/[verse]/route';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ work: string; chapter: string; verse: string }> }) {
  const values = await params;
  if (!getWork(values.work)) {
    const message = `Unknown work: ${values.work}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Work not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'WORK_NOT_FOUND', message } }, { status: 404 });
  }
  return getGitaPassage(request, { params: Promise.resolve({ chapter: values.chapter, verse: values.verse }) });
}
