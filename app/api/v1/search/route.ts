import { corpus, publicPassage, searchCorpus } from '@/app/lib/corpus';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';
import { searchD1 } from '@/db/corpus-repository';

export async function GET(request: Request) {
  const url = new URL(request.url);
  const query = url.searchParams.get('q')?.trim() ?? '';
  const requestedLimit = Number(url.searchParams.get('limit') ?? 30);
  const limit = Number.isFinite(requestedLimit) ? Math.max(1, Math.min(Math.trunc(requestedLimit), 100)) : 30;
  if (!query) {
    const message = 'Provide a non-empty q search parameter.';
    return wantsMarkdown(request) ? markdownResponse(`# Search error\n\n${message}\n`, { status: 400 }) : jsonResponse({ error: { code: 'MISSING_QUERY', message } }, { status: 400 });
  }
  const d1Refs = await searchD1(query, limit);
  const passages = d1Refs
    ? d1Refs.map((reference) => corpus.verses.find((passage) => passage.canonicalRef === reference)).filter((passage): passage is NonNullable<typeof passage> => Boolean(passage))
    : searchCorpus(query, limit);
  if (wantsMarkdown(request)) {
    return markdownResponse([`# Search: ${query}`, '', `${passages.length} result(s).`, '', ...passages.map((passage) => `- [${passage.chapter}.${passage.verse}](/gita/${passage.chapter}/${passage.verse}) — ${passage.representations.english}`), ''].join('\n'));
  }
  return jsonResponse({ data: passages.map(publicPassage), meta: { query, count: passages.length, limit, engine: d1Refs ? 'd1-fts5' : 'bundled-corpus' } });
}
