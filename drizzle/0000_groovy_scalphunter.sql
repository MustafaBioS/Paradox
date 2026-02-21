CREATE TABLE "rsvps" (
	"id" serial PRIMARY KEY NOT NULL,
	"email" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX "rsvps_email_unique_idx" ON "rsvps" USING btree (lower("email"));