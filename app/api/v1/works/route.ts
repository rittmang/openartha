import { corpus } from '@/app/lib/corpus';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request) {
  const work = {
    id: corpus.work.id,
    title: corpus.work.title,
    originalTitle: corpus.work.originalTitle,
    language: corpus.work.language,
    passageCount: corpus.work.passageCount,
    editions: [corpus.work.edition],
    currentCorpusVersion: corpus.corpusVersion,
  };
  if (wantsMarkdown(request)) {
    return markdownResponse(`# Works\n\n## ${work.title}\n\n- ID: \`${work.id}\`\n- Original title: ${work.originalTitle}\n- Language: ${work.language}\n- Passages: ${work.passageCount}\n- Current version: \`${work.currentCorpusVersion}\`\n`);
  }
  return jsonResponse({ data: [work], meta: { schemaVersion: corpus.schemaVersion } });
}
