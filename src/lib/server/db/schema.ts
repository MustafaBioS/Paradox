import { pgTable, serial, text, timestamp, uniqueIndex } from "drizzle-orm/pg-core";
import { sql } from "drizzle-orm";

export const rsvps = pgTable(
	"rsvps",
	{
		id: serial("id").primaryKey(),
		email: text("email").notNull(),
		createdAt: timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
	},
	(table) => [
		uniqueIndex("rsvps_email_unique_idx").on(sql`lower(${table.email})`),
	]
);
