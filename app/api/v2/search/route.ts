import { publicPassage, searchCorpusDetailed } from '@/app/lib/corpus';
import { searchCommentaries } from '@/app/lib/commentaries';
import { jsonResponse, markdownResponse, wantsMarkdown } from '@/app/lib/http';

export async function GET(request: Request) {
  const url = new URL(request.url);
  const query = url.searchParams.get('q')?.trim() ?? '';
  const author = url.searchParams.get('author')?.trim() || undefined;
  const language = url.searchParams.get('language')?.trim() || undefined;
  const contentType = url.searchParams.get('type')?.trim() || undefined;
  const requestedLimit = Number(url.searchParams.get('limit') ?? 50);
  const limit = Number.isFinite(requestedLimit) ? Math.max(1, Math.min(Math.trunc(requestedLimit), 100)) : 50;
  if (!query) {
    const message = 'Provide a non-empty q search parameter.';
    return wantsMarkdown(request) ? markdownResponse(`# Search error\n\n${message}\n`, { status: 400 }) : jsonResponse({ error: { code: 'MISSING_QUERY', message } }, { status: 400 });
  }

  const root = author ? [] : searchCorpusDetailed(query).results.filter((result) => {
    if (!language && !contentType) return true;
    return result.hits.some((hit) => {
      const hitLanguage = hit.field === 'english' ? 'en' : hit.field === 'iast' || hit.field === 'devanagari' ? 'sa' : undefined;
      const hitType = hit.field === 'english' ? 'translation' : hit.field === 'iast' ? 'transliteration' : hit.field === 'devanagari' ? 'original' : 'metadata';
      return (!language || language === hitLanguage) && (!contentType || contentType === hitType);
    });
  });
  const includeCommentary = !contentType || contentType === 'commentary' || contentType === 'translation';
  const commentary = includeCommentary ? await searchCommentaries(query, { author, language, contentType: contentType === 'commentary' || contentType === 'translation' ? contentType : undefined }, limit) : [];
  const combined = [
    ...root.map((result) => ({ corpus: 'root' as const, kind: result.kind, canonicalRef: result.passage.canonicalRef, passage: publicPassage(result.passage), match: { hits: result.hits } })),
    ...commentary.map((result) => ({ corpus: 'commentary' as const, kind: result.kind, canonicalRef: result.canonicalRef, commentary: result })),
  ].sort((left, right) => (left.kind === right.kind ? 0 : left.kind === 'exact' ? -1 : 1)).slice(0, limit);

  if (wantsMarkdown(request)) return markdownResponse([
    `# Unified search: ${query}`, '', `${combined.length} returned matches.`, '',
    ...combined.map((result) => result.corpus === 'root'
      ? `- [${result.passage.chapter}.${result.passage.verse}](/gita/${result.passage.chapter}/${result.passage.verse}) — root corpus · ${result.kind}`
      : `- [${result.commentary.chapter}.${result.commentary.verse}](/gita/${result.commentary.chapter}/${result.commentary.verse}#commentaries) — ${result.commentary.author} · ${result.commentary.contentType} · ${result.kind}`), '',
  ].join('\n'));
  return jsonResponse({ data: combined, meta: { query, returned: combined.length, limit, filters: { author, language, contentType }, engine: 'unified-d1-fts5-v2' } });
}
