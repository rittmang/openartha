import { integer, primaryKey, real, sqliteTable, text, uniqueIndex } from 'drizzle-orm/sqlite-core';

export const works = sqliteTable('works', {
  id: text('id').primaryKey(),
  title: text('title').notNull(),
  originalTitle: text('original_title').notNull(),
  language: text('language').notNull(),
});

export const corpusVersions = sqliteTable('corpus_versions', {
  id: text('id').primaryKey(),
  workId: text('work_id').notNull().references(() => works.id),
  status: text('status').notNull(),
  passageCount: integer('passage_count').notNull(),
  releaseEligible: integer('release_eligible', { mode: 'boolean' }).notNull(),
  generatedAt: text('generated_at').notNull(),
});

export const editions = sqliteTable('editions', {
  id: text('id').primaryKey(),
  workId: text('work_id').notNull().references(() => works.id),
  corpusVersionId: text('corpus_version_id').notNull().references(() => corpusVersions.id),
  title: text('title').notNull(),
  passageCount: integer('passage_count').notNull(),
});

export const passages = sqliteTable('passages', {
  id: text('id').primaryKey(),
  editionId: text('edition_id').notNull().references(() => editions.id),
  corpusVersionId: text('corpus_version_id').notNull().references(() => corpusVersions.id),
  canonicalRef: text('canonical_ref').notNull(),
  chapter: integer('chapter').notNull(),
  verse: integer('verse').notNull(),
  speaker: text('speaker'),
  checksum: text('checksum').notNull(),
  reviewStatus: text('review_status').notNull(),
  releaseEligible: integer('release_eligible', { mode: 'boolean' }).notNull(),
}, (table) => [
  uniqueIndex('idx_passages_canonical_ref').on(table.canonicalRef),
  uniqueIndex('idx_passages_chapter_verse').on(table.editionId, table.chapter, table.verse),
]);

export const sources = sqliteTable('sources', {
  id: text('id').primaryKey(),
  title: text('title').notNull(),
  contributor: text('contributor').notNull(),
  year: integer('year'),
  url: text('url').notNull(),
  rights: text('rights').notNull(),
  role: text('role').notNull(),
});

export const textRepresentations = sqliteTable('text_representations', {
  passageId: text('passage_id').notNull().references(() => passages.id),
  kind: text('kind').notNull(),
  language: text('language').notNull(),
  script: text('script').notNull(),
  content: text('content').notNull(),
  sourceId: text('source_id').notNull().references(() => sources.id),
}, (table) => [primaryKey({ columns: [table.passageId, table.kind, table.language] })]);

export const passageSources = sqliteTable('passage_sources', {
  passageId: text('passage_id').notNull().references(() => passages.id),
  sourceId: text('source_id').notNull().references(() => sources.id),
  locator: text('locator').notNull(),
  role: text('role').notNull(),
}, (table) => [primaryKey({ columns: [table.passageId, table.sourceId, table.role] })]);

export const variants = sqliteTable('variants', {
  id: text('id').primaryKey(),
  passageId: text('passage_id').notNull().references(() => passages.id),
  type: text('type').notNull(),
  note: text('note').notNull(),
  devanagari: text('devanagari').notNull(),
  iast: text('iast').notNull(),
});

export const reviews = sqliteTable('reviews', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  passageId: text('passage_id').notNull().references(() => passages.id),
  pass: integer('pass').notNull(),
  reviewer: text('reviewer').notNull(),
  reviewedAt: text('reviewed_at').notNull(),
  decision: text('decision').notNull(),
  note: text('note'),
  confidence: real('confidence'),
}, (table) => [uniqueIndex('idx_reviews_passage_pass').on(table.passageId, table.pass)]);
