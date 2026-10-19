import { chapterTranslations, translationSummary } from '@/app/lib/translations';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ work: string }> }) {
  const { work } = await params;
  if (!getWork(work)) {
    const message = `Unknown work: ${work}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Work not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'WORK_NOT_FOUND', message } }, { status: 404 });
  }
  const data = chapterTranslations.filter((translation) => translation.workId === work).map(translationSummary);
  if (wantsMarkdown(request)) return markdownResponse([
    '# Chapter translations', '',
    ...data.map((translation) => `## ${translation.translator}\n\n${translation.title}\n\n- ID: \`${translation.id}\`\n- Edition: ${translation.editionYear}\n- Language: ${translation.language}\n- Chapters: ${translation.chapterCount}\n- Alignment: ${translation.alignmentStatus}\n- Rights: ${translation.source.rights}\n- Source: ${translation.source.catalogUrl}\n- Reader: ${translation.route}\n- Chapter API: ${translation.apiRoot}/chapters/1`), '',
  ].join('\n'));
  return jsonResponse({ data, meta: { workId: work, granularity: 'chapter' } });
}
