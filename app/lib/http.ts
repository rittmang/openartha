export function wantsMarkdown(request: Request) {
  const url = new URL(request.url);
  return url.searchParams.get('format') === 'markdown' || request.headers.get('accept')?.includes('text/markdown');
}

export const publicHeaders = {
  'access-control-allow-origin': '*',
  'cache-control': 'public, max-age=300, s-maxage=3600, stale-while-revalidate=86400',
  'x-corpus-version': 'gita-1.0.0-rc.1',
  'x-commentary-corpus-version': 'gita-commentaries-0.2.0',
};

export function jsonResponse(body: unknown, init: ResponseInit = {}) {
  return Response.json(body, { ...init, headers: { ...publicHeaders, ...init.headers } });
}

export function markdownResponse(body: string, init: ResponseInit = {}) {
  return new Response(body, { ...init, headers: { ...publicHeaders, 'content-type': 'text/markdown; charset=utf-8', ...init.headers } });
}
