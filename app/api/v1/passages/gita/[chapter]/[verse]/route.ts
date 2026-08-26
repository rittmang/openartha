import { getPassage, passageAsMarkdown, publicPassage } from '@/app/lib/corpus';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request, { params }: { params: Promise<{ chapter: string; verse: string }> }) {
  const values = await params;
  const chapter = Number(values.chapter);
  const verse = Number(values.verse);
  if (!Number.isInteger(chapter) || !Number.isInteger(verse) || chapter < 1 || verse < 1) {
    const message = 'Chapter and verse must be positive integers.';
    return wantsMarkdown(request) ? markdownResponse(`# Invalid reference\n\n${message}\n`, { status: 400 }) : jsonResponse({ error: { code: 'INVALID_REFERENCE', message } }, { status: 400 });
  }
  const passage = getPassage(chapter, verse);
  if (!passage) {
    const message = `No passage exists at Bhagavad Gita ${chapter}.${verse}.`;
    return wantsMarkdown(request) ? markdownResponse(`# Passage not found\n\n${message}\n`, { status: 404 }) : jsonResponse({ error: { code: 'PASSAGE_NOT_FOUND', message } }, { status: 404 });
  }
  if (wantsMarkdown(request)) return markdownResponse(passageAsMarkdown(passage), { headers: { etag: `"${passage.checksum}"` } });
  return jsonResponse({ data: publicPassage(passage) }, { headers: { etag: `"${passage.checksum}"` } });
}
