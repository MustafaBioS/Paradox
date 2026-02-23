import { Elysia, t } from "elysia";
import { db } from "./db/index";
import { rsvps } from "./db/schema";

type RsvpBody = { email: string };

export const rsvpPlugin = new Elysia({ prefix: "/rsvps" }).post(
	"/",
	async ({ body, set }) => {
		const email = (body as RsvpBody).email.trim().toLowerCase();

		try {
			const [row] = await db
				.insert(rsvps)
				.values({ email })
				.returning({ id: rsvps.id, email: rsvps.email, createdAt: rsvps.createdAt });

			if (!row) {
				set.status = 500;
				return { success: false, message: "Failed to create RSVP." };
			}

			// Drizzle returns Date for timestamp columns; response schema expects ISO string
			const rsvp = {
				id: row.id,
				email: row.email,
				createdAt: row.createdAt instanceof Date ? row.createdAt.toISOString() : String(row.createdAt),
			};

			set.status = 201;
			return { success: true, rsvp };
		} catch (err: any) {
			// Postgres unique constraint violation
			if (err?.code === "23505") {
				set.status = 409;
				return { success: false, message: "This email is already registered." };
			}
			throw err;
		}
	},
	{
		body: t.Object({
			email: t.String({ format: "email", description: "Email address to register" }),
		}),
		response: {
			201: "RsvpSuccessResponse",
			409: "RsvpConflictResponse",
		} as unknown as Record<number, ReturnType<typeof t.Object>>,
		detail: {
			tags: ["RSVPs"],
			summary: "Submit RSVP",
			description: "Registers an email address for the event. Returns 201 with the created RSVP on success, or 409 if the email is already signed up.",
			responses: {
				201: { description: "RSVP created successfully" },
				409: { description: "Email already registered for this event" },
			},
			requestBody: {
				content: {
					"application/json": {
						example: { email: "user@example.com" },
					},
				},
			},
		},
	}
);
