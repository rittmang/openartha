import { publicPassage, passageAsMarkdown, getPassage } from '@/app/lib/corpus';
import { getWork } from '@/app/lib/works';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ work: string; chapter: string; verse: string }> }) {
  const values = await params;
  const workRecord = getWork(values.work);
  if (!workRecord) {
    const message = `Unknown work: ${values.work}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Work not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'WORK_NOT_FOUND', message } }, { status: 404 });
  }
  const chapter = Number(values.chapter);
  const verse = Number(values.verse);
  if (!Number.isInteger(chapter) || !Number.isInteger(verse) || chapter < 1 || verse < 1) {
    const message = 'Chapter and verse must be positive integers.';
    return wantsMarkdown(request) ? markdownResponse(`# Invalid reference\n\n${message}\n`, { status: 400 }) : jsonResponse({ error: { code: 'INVALID_REFERENCE', message } }, { status: 400 });
  }
  const passage = getPassage(chapter, verse);
  if (!passage) {
    const message = `No passage exists at ${workRecord.title} ${chapter}.${verse}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Passage not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'PASSAGE_NOT_FOUND', message } }, { status: 404 });
  }
  if (wantsMarkdown(request)) return markdownResponse(passageAsMarkdown(passage), { headers: { etag: `"${passage.checksum}"` } });
  return jsonResponse({ data: { ...publicPassage(passage), workId: values.work } }, { headers: { etag: `"${passage.checksum}"` } });
}
