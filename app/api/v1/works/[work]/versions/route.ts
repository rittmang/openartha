import { commentarySource } from '@/app/lib/commentaries';
import { corpus } from '@/app/lib/corpus';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ work: string }> }) {
  const { work } = await params;
  const workRecord = getWork(work);
  if (!workRecord) {
    const message = `Unknown work: ${work}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Work not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'WORK_NOT_FOUND', message } }, { status: 404 });
  }
  const versions = { workId: work, corpusVersion: corpus.corpusVersion, commentaryCorpusVersion: commentarySource.corpusVersion, status: corpus.status, passageCount: corpus.work.passageCount, chapterCounts: corpus.chapterCounts, generatedAt: corpus.generatedAt, releaseEligible: corpus.releaseEligible, releaseBlocker: corpus.releaseBlocker };
  if (wantsMarkdown(request)) return markdownResponse(`# ${workRecord.title} versions\n\n- Corpus: \`${versions.corpusVersion}\`\n- Commentary corpus: \`${versions.commentaryCorpusVersion}\`\n- Status: ${versions.status}\n- Passages: ${versions.passageCount}\n`);
  return jsonResponse({ data: [versions] });
}
