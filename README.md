# Paradox

## Setup

**1. Install dependencies.**

```bash
bun install
```

**2. Copy the environment file and fill it in.**

```bash
cp .env.example .env
```

You'll need a Hack Club OAuth app — create one at [auth.hackclub.com](https://auth.hackclub.com). Set `HACKCLUB_REDIRECT_URI` to `http://localhost:5173/api/auth/callback` for local dev. It must match exactly what's registered on your OAuth app.

You'll also need a PostgreSQL database running. If you don't have one yet:

```bash
createdb paradox
```

Then set `DATABASE_URL` in your `.env` to your connection string.

**3. Run the database migration.**

```bash
bun run db:migrate
```

**4. Start the dev server.**

```bash
bun run dev
```

The app runs at `http://localhost:5173`.
