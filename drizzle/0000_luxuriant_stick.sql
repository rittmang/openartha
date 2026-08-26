CREATE TABLE `corpus_versions` (
	`id` text PRIMARY KEY NOT NULL,
	`work_id` text NOT NULL,
	`status` text NOT NULL,
	`passage_count` integer NOT NULL,
	`release_eligible` integer NOT NULL,
	`generated_at` text NOT NULL,
	FOREIGN KEY (`work_id`) REFERENCES `works`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `editions` (
	`id` text PRIMARY KEY NOT NULL,
	`work_id` text NOT NULL,
	`corpus_version_id` text NOT NULL,
	`title` text NOT NULL,
	`passage_count` integer NOT NULL,
	FOREIGN KEY (`work_id`) REFERENCES `works`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`corpus_version_id`) REFERENCES `corpus_versions`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `passage_sources` (
	`passage_id` text NOT NULL,
	`source_id` text NOT NULL,
	`locator` text NOT NULL,
	`role` text NOT NULL,
	PRIMARY KEY(`passage_id`, `source_id`, `role`),
	FOREIGN KEY (`passage_id`) REFERENCES `passages`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`source_id`) REFERENCES `sources`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `passages` (
	`id` text PRIMARY KEY NOT NULL,
	`edition_id` text NOT NULL,
	`corpus_version_id` text NOT NULL,
	`canonical_ref` text NOT NULL,
	`chapter` integer NOT NULL,
	`verse` integer NOT NULL,
	`speaker` text,
	`checksum` text NOT NULL,
	`review_status` text NOT NULL,
	`release_eligible` integer NOT NULL,
	FOREIGN KEY (`edition_id`) REFERENCES `editions`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`corpus_version_id`) REFERENCES `corpus_versions`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_passages_canonical_ref` ON `passages` (`canonical_ref`);--> statement-breakpoint
CREATE UNIQUE INDEX `idx_passages_chapter_verse` ON `passages` (`edition_id`,`chapter`,`verse`);--> statement-breakpoint
CREATE TABLE `reviews` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`passage_id` text NOT NULL,
	`pass` integer NOT NULL,
	`reviewer` text NOT NULL,
	`reviewed_at` text NOT NULL,
	`decision` text NOT NULL,
	`note` text,
	`confidence` real,
	FOREIGN KEY (`passage_id`) REFERENCES `passages`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `idx_reviews_passage_pass` ON `reviews` (`passage_id`,`pass`);--> statement-breakpoint
CREATE TABLE `sources` (
	`id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`contributor` text NOT NULL,
	`year` integer,
	`url` text NOT NULL,
	`rights` text NOT NULL,
	`role` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `text_representations` (
	`passage_id` text NOT NULL,
	`kind` text NOT NULL,
	`language` text NOT NULL,
	`script` text NOT NULL,
	`content` text NOT NULL,
	`source_id` text NOT NULL,
	PRIMARY KEY(`passage_id`, `kind`, `language`),
	FOREIGN KEY (`passage_id`) REFERENCES `passages`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`source_id`) REFERENCES `sources`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `variants` (
	`id` text PRIMARY KEY NOT NULL,
	`passage_id` text NOT NULL,
	`type` text NOT NULL,
	`note` text NOT NULL,
	`devanagari` text NOT NULL,
	`iast` text NOT NULL,
	FOREIGN KEY (`passage_id`) REFERENCES `passages`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `works` (
	`id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`original_title` text NOT NULL,
	`language` text NOT NULL
);
--> statement-breakpoint
CREATE VIRTUAL TABLE `passages_fts` USING fts5(
	`canonical_ref` UNINDEXED,
	`devanagari`,
	`iast`,
	`english`,
	tokenize = 'unicode61 remove_diacritics 2'
);
