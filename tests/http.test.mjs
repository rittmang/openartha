import assert from 'node:assert/strict';
import test from 'node:test';
import { wantsMarkdown, jsonResponse, markdownResponse } from '../app/lib/http.ts';

test('Accept negotiation honors quality, explicit exclusions, wildcards, and specificity', () => {
  for (const [accept, expected] of [
    ['text/markdown', true], ['application/json', false], ['*/*', false],
    ['application/json, text/markdown;q=0', false],
    ['application/json;q=1, text/markdown;q=0.1', false],
    ['application/json;q=0.2, text/markdown;q=0.9', true],
    ['text/*', true], ['text/markdown;q=0, */*;q=1', false],
    ['application/json;q=0, */*;q=0.5', true],
    ['TEXT/MARKDOWN; charset=utf-8', true],
    ['text/markdown;q=garbage, application/json', false],
  ]) assert.equal(wantsMarkdown(new Request('https://example.org/api', { headers: { Accept: accept } })), expected, accept);
  assert.equal(wantsMarkdown(new Request('https://example.org/api?format=markdown', { headers: { Accept: 'application/json' } })), true);
  assert.equal(wantsMarkdown(new Request('https://example.org/api?format=json', { headers: { Accept: 'text/markdown' } })), false);
});

test('cacheable representations and errors retain Vary: Accept and case-insensitive custom headers', () => {
  for (const build of [jsonResponse, markdownResponse]) for (const custom of [new Headers({ ETag: '"pinned"', Vary: 'Origin' }), [['etag', '"pinned"'], ['vary', 'Origin']], { etag: '"pinned"', vary: 'Origin' }]) {
    const response = build('test', { status: 404, headers: custom });
    assert.equal(response.status, 404);
    assert.equal(response.headers.get('etag'), '"pinned"');
    assert.deepEqual(response.headers.get('vary').split(', '), ['Accept', 'Origin']);
    assert.equal(response.headers.get('access-control-allow-origin'), '*');
  }
});
