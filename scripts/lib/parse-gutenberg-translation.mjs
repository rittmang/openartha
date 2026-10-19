import assert from 'node:assert/strict';

const numerals = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII', 'XIII', 'XIV', 'XV', 'XVI', 'XVII', 'XVIII'];
const stripBlankLines = (value) => value.replace(/^(?:[ \t]*\n)+/, '').replace(/(?:\n[ \t]*)+$/, '');

export function parseGutenbergTranslation(rawText) {
  const text = rawText.replace(/^\uFEFF/, '').replace(/\r\n?/g, '\n');
  const start = text.indexOf('*** START OF THE PROJECT GUTENBERG EBOOK');
  const end = text.indexOf('*** END OF THE PROJECT GUTENBERG EBOOK');
  assert.ok(start >= 0 && end > start, 'Expected Gutenberg text boundaries');
  const body = text.slice(0, end);
  const headings = [...body.matchAll(/^[ \t]*CHAPTER ([IVX]+)[ \t]*$/gm)];
  assert.deepEqual(headings.map((heading) => heading[1]), numerals, 'Expected exactly 18 chapter headings in order');
  assert.ok(headings[0].index > start, 'Chapter text must follow the Gutenberg header');

  const titles = [...body.slice(start, headings[0].index).matchAll(/^[ \t]*([IVX]+)\. (.+)$/gm)];
  assert.deepEqual(titles.map((title) => title[1]), numerals, 'Expected 18 contents entries');
  const noteHeadings = [...body.matchAll(/^\[FN#(\d+)\][ \t]*/gm)];
  assert.deepEqual(noteHeadings.map((note) => Number(note[1])), Array.from({ length: 37 }, (_, index) => index + 1), 'Expected all 37 translator notes');
  assert.ok(noteHeadings[0].index > headings.at(-1).index, 'Notes must follow all 18 chapters');
  const notes = noteHeadings.map((heading, index) => ({
    number: Number(heading[1]),
    marker: `[FN#${heading[1]}]`,
    text: body.slice(heading.index + heading[0].length, noteHeadings[index + 1]?.index ?? end).trim(),
  }));
  const chapters = headings.map((heading, index) => {
    const from = heading.index + heading[0].length;
    const to = headings[index + 1]?.index ?? noteHeadings[0].index;
    const content = stripBlankLines(body.slice(from, to));
    assert.ok(content.length > 500, `Chapter ${index + 1} must contain its translation`);
    assert.match(content, /HERE END(?:ETH|S)/, `Chapter ${index + 1} must retain its colophon`);
    const contentStart = body.indexOf(content, from);
    return {
      chapter: index + 1,
      chapterRef: `gita.${index + 1}`,
      sourceHeading: heading[0].trim(),
      title: titles[index][2].trim(),
      text: content,
      sourceLocator: {
        lineStart: text.slice(0, contentStart).split('\n').length,
        lineEnd: text.slice(0, contentStart + content.length).split('\n').length,
      },
    };
  });
  return { chapters, notes };
}
