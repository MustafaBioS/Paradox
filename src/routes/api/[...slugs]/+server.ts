import { Elysia, t } from "elysia";
import { openapi } from "@elysiajs/openapi";
import { authPlugin } from "$lib/server/auth";
import { drizzlePlugin } from "$lib/server/db/plugin";
import { rsvpPlugin } from "$lib/server/rsvpPlugin";

const HackClubUserSchema = t.Object({
	id: t.String({ description: "Hack Club user ID" }),
	email: t.String({ description: "User email", format: "email" }),
	name: t.String({ description: "Display name" }),
	username: t.Optional(t.String({ description: "Username" })),
	avatar: t.Optional(t.String({ description: "Avatar URL" })),
});

const RsvpRecordSchema = t.Object({
	id: t.Number({ description: "RSVP record ID" }),
	email: t.String({ description: "Registered email", format: "email" }),
	createdAt: t.String({ description: "ISO 8601 timestamp when the RSVP was created" }),
});

const app = new Elysia({ prefix: "/api" })
	.model({
		HackClubUser: HackClubUserSchema,
		MeResponse: t.Object({
			user: t.Union([HackClubUserSchema, t.Null()], {
				description: "Authenticated user or null if not authenticated",
			}),
		}),
		RsvpRecord: RsvpRecordSchema,
		RsvpSuccessResponse: t.Object({
			success: t.Literal(true, { description: "Always true on success" }),
			rsvp: RsvpRecordSchema,
		}),
		RsvpConflictResponse: t.Object({
			success: t.Literal(false, { description: "Always false on conflict" }),
			message: t.String({ description: "Error message (e.g. email already registered)" }),
		}),
	})
	.use(
		openapi({
			documentation: {
				info: {
					title: "Paradox API",
					version: "1.0.0",
					description:
						"Paradox event API: authenticate via Hack Club OAuth and register for the event with an email RSVP.",
				},
				servers: [{ url: "/api", description: "API base path" }],
				tags: [
					{ name: "Auth", description: "Hack Club OAuth endpoints" },
					{ name: "RSVPs", description: "Event RSVP registration" },
				],
				components: {
					securitySchemes: {
						bearerAuth: {
							type: "http",
							scheme: "bearer",
							bearerFormat: "JWT",
						},
					},
				},
			},
		})
	)
	.use(authPlugin)
	.use(drizzlePlugin)
	.use(rsvpPlugin)
	.compile();

const handle = ({ request }: { request: Request }) => app.handle(request);

export const GET = handle;
export const POST = handle;
export const PUT = handle;
export const PATCH = handle;
export const DELETE = handle;
