import { getTranslation, getTranslationChapter, translationSummary } from '@/app/lib/translations';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

type Props = { params: Promise<{ work: string; translation: string; chapter: string }> };

export async function GET(request: Request, { params }: Props) {
  const values = await params;
  const translation = getTranslation(values.translation);
  const chapter = getTranslationChapter(values.translation, Number(values.chapter));
  const error = !getWork(values.work)
    ? { code: 'WORK_NOT_FOUND', message: `Unknown work: ${values.work}.` }
    : !translation || translation.workId !== values.work
      ? { code: 'TRANSLATION_NOT_FOUND', message: `Unknown translation: ${values.translation}.` }
      : !chapter ? { code: 'CHAPTER_NOT_FOUND', message: `Unknown chapter: ${values.chapter}.` } : null;
  if (error) return wantsMarkdown(request) ? markdownResponse(`# Translation error\n\n${error.message}\n`, { status: 404 }) : jsonResponse({ error }, { status: 404 });
  if (!translation || !chapter) throw new Error('Translation validation failed');
  const headers = { 'x-translation-corpus-version': translation.corpusVersion };
  if (wantsMarkdown(request)) return markdownResponse([
    `# The Song Celestial — Chapter ${chapter.chapter}`, '', chapter.title, '',
    `Translator: ${translation.translator} (${translation.editionYear} edition)`, '',
    `Alignment: ${translation.alignmentStatus}.`, '',
    // Markdown code blocks preserve source poetry, indentation, and literal markers.
    '```text', chapter.text, '```', '',
    `Source: [Project Gutenberg ebook #${translation.source.ebookNumber}](${translation.source.catalogUrl}), ${chapter.sourceHeading}, lines ${chapter.sourceLocator.lineStart}–${chapter.sourceLocator.lineEnd}.`, '',
    `Rights: ${translation.source.rights}. [Full original text and license](/data/${translation.corpusVersion}/pg2388.txt).`, '',
    `[Translator's notes](/gita/translations/${translation.id}#translator-notes)`, '',
    `SHA-256: \`${chapter.checksum}\``, '',
  ].join('\n'), { headers });
  return jsonResponse({ data: chapter, meta: { ...translationSummary(translation), notesUrl: `/gita/translations/${translation.id}#translator-notes` } }, { headers });
}
