import { commentaryAuthors, getAuthorChapterCommentaries } from '@/app/lib/commentaries';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ author: string; chapter: string }> }) {
  const values = await params;
  const chapter = Number(values.chapter);
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  if (!author || !Number.isInteger(chapter) || chapter < 1 || chapter > 18) {
    const message = 'No published author/chapter record matches this reference.';
    return wantsMarkdown(request) ? markdownResponse(`# Commentary not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'COMMENTARY_NOT_FOUND', message } }, { status: 404 });
  }
  const records = await getAuthorChapterCommentaries(author.id, chapter);
  if (wantsMarkdown(request)) return markdownResponse([`# ${author.displayName} — Chapter ${chapter}`, '', ...records.flatMap((record) => [`## ${record.chapter}.${record.verse}`, '', record.content, ''])].join('\n'));
  return jsonResponse({ data: records, meta: { author, chapter, returned: records.length } });
}
