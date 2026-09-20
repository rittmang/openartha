import { corpus } from '@/app/lib/corpus';
import { commentarySource } from '@/app/lib/commentaries';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request) {
  const version = {
    id: corpus.corpusVersion,
    workId: corpus.work.id,
    status: corpus.status,
    passageCount: corpus.work.passageCount,
    chapterCounts: corpus.chapterCounts,
    generatedAt: corpus.generatedAt,
    releaseEligible: corpus.releaseEligible,
    releaseBlocker: corpus.releaseBlocker,
    commentaryCorpusVersion: commentarySource.corpusVersion,
  };
  if (wantsMarkdown(request)) return markdownResponse(`# Corpus versions\n\n## ${version.id}\n\n- Status: ${version.status}\n- Passages: ${version.passageCount}\n- Commentary corpus: \`${version.commentaryCorpusVersion}\`\n- Release eligible: ${version.releaseEligible ? 'yes' : 'no'}\n- Gate: ${version.releaseBlocker}\n`);
  return jsonResponse({ data: [version] });
}
