import { corpus } from '@/app/lib/corpus';
import { works } from '@/app/lib/works';
import { chapterTranslations, translationSummary } from '@/app/lib/translations';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request) {
  const data = works.map((work) => ({ ...work, editions: [corpus.work.edition], chapterTranslations: chapterTranslations.filter((translation) => translation.workId === work.id).map(translationSummary) }));
  if (wantsMarkdown(request)) {
    return markdownResponse(['# Works', '', ...data.map((work) => `## ${work.title}\n\n- ID: \`${work.id}\`\n- Original title: ${work.originalTitle}\n- Language: ${work.language}\n- Passages: ${work.passageCount}\n- Reader: ${work.route}\n- API root: ${work.apiRoot}\n- Current version: \`${work.currentCorpusVersion}\`\n- Commentary version: \`${work.currentCommentaryVersion}\`\n- Chapter translations: ${work.chapterTranslations.map((translation) => `[${translation.translator}](${translation.route})`).join(', ')}`), ''].join('\n'));
  }
  return jsonResponse({ data, meta: { schemaVersion: corpus.schemaVersion } });
}
