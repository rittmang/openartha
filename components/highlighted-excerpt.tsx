import type { SearchRange } from '@/app/lib/search';

export function excerptAroundMatch(text: string, ranges: SearchRange[], maximumLength = 220) {
  const firstRange = ranges[0];
  if (!firstRange || text.length <= maximumLength) return { text, ranges, prefix: false, suffix: false };
  let start = Math.max(0, firstRange.start - Math.floor(maximumLength * .34));
  let end = Math.min(text.length, start + maximumLength);
  if (end === text.length) start = Math.max(0, end - maximumLength);
  const firstSpace = text.indexOf(' ', start);
  if (start > 0 && firstSpace > start && firstSpace < firstRange.start) start = firstSpace + 1;
  const lastSpace = text.lastIndexOf(' ', end);
  if (end < text.length && lastSpace > firstRange.end) end = lastSpace;
  return {
    text: text.slice(start, end),
    ranges: ranges.filter((range) => range.end > start && range.start < end).map((range) => ({ start: Math.max(0, range.start - start), end: Math.min(end, range.end) - start })),
    prefix: start > 0,
    suffix: end < text.length,
  };
}

export function HighlightedExcerpt({ text, ranges, maximumLength }: { text: string; ranges: SearchRange[]; maximumLength?: number }) {
  const excerpt = excerptAroundMatch(text, ranges, maximumLength);
  const content = [];
  let cursor = 0;
  for (const [index, range] of excerpt.ranges.entries()) {
    if (range.start > cursor) content.push(excerpt.text.slice(cursor, range.start));
    content.push(<mark key={`${range.start}-${range.end}-${index}`}>{excerpt.text.slice(range.start, range.end)}</mark>);
    cursor = range.end;
  }
  if (cursor < excerpt.text.length) content.push(excerpt.text.slice(cursor));
  return <>{excerpt.prefix ? '…' : ''}{content}{excerpt.suffix ? '…' : ''}</>;
}
