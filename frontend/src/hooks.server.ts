import type { Handle } from "@sveltejs/kit";
import type { HackClubUser } from "./app";

const BACKEND_URL = process.env.BACKEND_URL ?? "http://localhost:3000";

export const handle: Handle = async ({ event, resolve }) => {
	const accessToken = event.cookies.get("access_token");

	if (accessToken) {
		const res = await fetch(`${BACKEND_URL}/auth/me`, {
			headers: { Authorization: `Bearer ${accessToken}` },
		});

		if (res.ok) {
			const { user } = (await res.json()) as { user: HackClubUser | null };
			event.locals.user = user;
		} else {
			event.locals.user = null;
		}
	} else {
		event.locals.user = null;
	}

	return resolve(event);
};
