import { Elysia } from "elysia";
import { openapi } from "@elysiajs/openapi";
import { authPlugin } from "$lib/server/auth";
import { drizzlePlugin } from "$lib/server/db/plugin";

const app = new Elysia({ prefix: "/api" })
	.use(
		openapi({
			documentation: {
				info: {
					title: "Paradox API",
					version: "1.0.0",
				},
				tags: [{ name: "Auth", description: "Hack Club OAuth endpoints" }],
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
	.compile();

const handle = ({ request }: { request: Request }) => app.handle(request);

export const GET = handle;
export const POST = handle;
export const PUT = handle;
export const PATCH = handle;
export const DELETE = handle;
