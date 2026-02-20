import { Elysia, t } from "elysia";

const HACKCLUB_AUTH_URL = "https://auth.hackclub.com";

export interface HackClubUser {
  id: string;
  email: string;
  name: string;
  username?: string;
  avatar?: string;
}

export const authPlugin = new Elysia({ prefix: "/auth" })
  .get("/login", ({ redirect }) => {
    const params = new URLSearchParams({
      client_id: process.env.HACKCLUB_CLIENT_ID!,
      redirect_uri: process.env.HACKCLUB_REDIRECT_URI!,
      response_type: "code",
      scope: "openid profile email",
    });
    return redirect(`${HACKCLUB_AUTH_URL}/oauth/authorize?${params}`);
  })

  .get(
    "/callback",
    async ({ query, cookie, redirect }) => {
      const { code } = query;
      const frontendUrl = process.env.FRONTEND_URL ?? "http://localhost:5173";

      if (!code) {
        return redirect(`${frontendUrl}/?error=no_code`);
      }

      // Exchange authorization code for access token
      // OAuth 2.0 spec (RFC 6749) requires application/x-www-form-urlencoded
      const tokenRes = await fetch(`${HACKCLUB_AUTH_URL}/oauth/token`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          client_id: process.env.HACKCLUB_CLIENT_ID!,
          client_secret: process.env.HACKCLUB_CLIENT_SECRET!,
          redirect_uri: process.env.HACKCLUB_REDIRECT_URI!,
          code,
          grant_type: "authorization_code",
        }),
      });

      if (!tokenRes.ok) {
        return redirect(`${frontendUrl}/?error=token_exchange_failed`);
      }

      const { access_token } = (await tokenRes.json()) as {
        access_token: string;
      };

      // Store access token in httpOnly cookie
      // Cookies for 'localhost' are port-agnostic, so this works in dev
      // across backend (:3000) and frontend (:5173)
      cookie.access_token.set({
        value: access_token,
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "lax",
        path: "/",
        domain: "localhost",
        maxAge: 60 * 60 * 24 * 7, // 7 days
      });

      return redirect(frontendUrl);
    },
    {
      query: t.Object({
        code: t.Optional(t.String()),
        error: t.Optional(t.String()),
      }),
    }
  )

  .get("/me", async ({ headers }) => {
    const auth = headers.authorization;
    if (!auth?.startsWith("Bearer ")) {
      return { user: null };
    }

    const token = auth.slice(7);
    const res = await fetch(`${HACKCLUB_AUTH_URL}/api/v1/me`, {
      headers: { Authorization: `Bearer ${token}` },
    });

    if (!res.ok) {
      return { user: null };
    }

    return { user: (await res.json()) as HackClubUser };
  })

  .post("/logout", ({ cookie, redirect }) => {
    const frontendUrl = process.env.FRONTEND_URL ?? "http://localhost:5173";
    cookie.access_token.remove();
    return redirect(frontendUrl);
  });
