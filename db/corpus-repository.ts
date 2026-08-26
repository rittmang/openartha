import { env } from 'cloudflare:workers';

export async function searchD1(query: string, limit: number): Promise<string[] | null> {
  try {
    if (!env.DB) return null;
    const result = await env.DB.prepare(
      `SELECT canonical_ref
       FROM passages_fts
       WHERE passages_fts MATCH ?
       ORDER BY rank
       LIMIT ?`,
    ).bind(query, limit).all<{ canonical_ref: string }>();
    if (!result.results.length) return null;
    return result.results.map((row) => row.canonical_ref);
  } catch {
    return null;
  }
}
