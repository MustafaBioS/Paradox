import type { Handle } from "@sveltejs/kit";
import type { HackClubUser } from "./app";

const HACKCLUB_AUTH_URL = "https://auth.hackclub.com";

export const handle: Handle = async ({ event, resolve }) => {
	const accessToken = event.cookies.get("access_token");

	if (accessToken) {
		const res = await fetch(`${HACKCLUB_AUTH_URL}/api/v1/me`, {
			headers: { Authorization: `Bearer ${accessToken}` },
		});

		if (res.ok) {
			event.locals.user = (await res.json()) as HackClubUser;
		} else {
			event.locals.user = null;
		}
	} else {
		event.locals.user = null;
	}

	return resolve(event);
};
