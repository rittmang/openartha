import commentarySource from '../../corpus/gita-commentaries/source.json' with { type: 'json' };

function quality(accept: string, type: string) {
  const [major] = type.split('/');
  let specificity = -1;
  let result = 0;
  for (const entry of accept.toLowerCase().split(',')) {
    const [range, ...parameters] = entry.trim().split(';');
    const rank = range.trim() === type ? 2 : range.trim() === `${major}/*` ? 1 : range.trim() === '*/*' ? 0 : -1;
    if (rank < 0 || rank < specificity) continue;
    const weight = parameters.find((parameter) => parameter.trim().startsWith('q='))?.trim().slice(2) ?? '1';
    const q = /^(?:0(?:\.\d{0,3})?|1(?:\.0{0,3})?)$/.test(weight) ? Number(weight) : 0;
    if (rank > specificity) result = q;
    else result = Math.max(result, q);
    specificity = rank;
  }
  return result;
}

export function wantsMarkdown(request: Request) {
  const url = new URL(request.url);
  const format = url.searchParams.get('format');
  if (format === 'markdown') return true;
  if (format === 'json') return false;
  const accept = request.headers.get('accept') ?? '*/*';
  return quality(accept, 'text/markdown') > quality(accept, 'application/json');
}

export const publicHeaders = {
  'access-control-allow-origin': '*',
  'cache-control': 'public, max-age=300, s-maxage=3600, stale-while-revalidate=86400',
  'x-corpus-version': 'gita-1.0.0-rc.1',
  'x-commentary-corpus-version': commentarySource.corpusVersion,
  vary: 'Accept',
};

function responseHeaders(init: HeadersInit = {}) {
  const headers = new Headers(publicHeaders);
  for (const [name, value] of new Headers(init)) {
    if (name === 'vary') headers.set(name, [...new Set(['Accept', ...value.split(',').map((token) => token.trim())])].join(', '));
    else headers.set(name, value);
  }
  return headers;
}

export function jsonResponse(body: unknown, init: ResponseInit = {}) {
  return Response.json(body, { ...init, headers: responseHeaders(init.headers) });
}

export function markdownResponse(body: string, init: ResponseInit = {}) {
  const headers = responseHeaders(init.headers);
  headers.set('content-type', 'text/markdown; charset=utf-8');
  return new Response(body, { ...init, headers });
}
