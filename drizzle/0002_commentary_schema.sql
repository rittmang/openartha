CREATE TABLE `commentary_sources` (
	`id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`repository_url` text NOT NULL,
	`commit_sha` text NOT NULL,
	`license` text NOT NULL,
	`license_url` text NOT NULL,
	`corpus_version` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `commentary_authors` (
	`id` text PRIMARY KEY NOT NULL,
	`source_key` text NOT NULL UNIQUE,
	`display_name` text NOT NULL,
	`available_fields` text NOT NULL,
	`public_fields` text NOT NULL,
	`rights_status` text NOT NULL,
	`rights_note` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `commentary_editions` (
	`id` text PRIMARY KEY NOT NULL,
	`author_id` text NOT NULL,
	`source_id` text NOT NULL,
	`field_code` text NOT NULL,
	`language` text NOT NULL,
	`script` text NOT NULL,
	`content_type` text NOT NULL,
	`public_text` integer NOT NULL,
	`rights_status` text NOT NULL,
	`corpus_version` text NOT NULL,
	FOREIGN KEY (`author_id`) REFERENCES `commentary_authors`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`source_id`) REFERENCES `commentary_sources`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_commentary_editions_author_field` ON `commentary_editions` (`author_id`,`field_code`);
--> statement-breakpoint
CREATE TABLE `commentary_units` (
	`id` text PRIMARY KEY NOT NULL,
	`edition_id` text NOT NULL,
	`passage_id` text,
	`source_chapter` integer NOT NULL,
	`source_verse` integer NOT NULL,
	`unit_type` text NOT NULL,
	`alignment_relation` text,
	`alignment_status` text NOT NULL,
	`source_locator` text NOT NULL,
	`raw_checksum` text NOT NULL,
	`display_checksum` text NOT NULL,
	FOREIGN KEY (`edition_id`) REFERENCES `commentary_editions`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`passage_id`) REFERENCES `passages`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `idx_commentary_units_passage` ON `commentary_units` (`passage_id`);
--> statement-breakpoint
CREATE INDEX `idx_commentary_units_edition_chapter` ON `commentary_units` (`edition_id`,`source_chapter`,`source_verse`);
--> statement-breakpoint
CREATE TABLE `commentary_unit_chunks` (
	`unit_id` text NOT NULL,
	`chunk_index` integer NOT NULL,
	`content` text NOT NULL,
	PRIMARY KEY (`unit_id`,`chunk_index`),
	FOREIGN KEY (`unit_id`) REFERENCES `commentary_units`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE VIRTUAL TABLE `commentary_fts` USING fts5(
	`unit_id` UNINDEXED,
	`author`,
	`canonical_ref` UNINDEXED,
	`language` UNINDEXED,
	`content_type` UNINDEXED,
	`content`,
	tokenize = 'unicode61 remove_diacritics 2'
);
