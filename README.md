# paradox

A SvelteKit application with an integrated ElysiaJS API (no separate backend needed).

## Structure

- [`frontend/`](./frontend) — SvelteKit frontend with integrated ElysiaJS API routes at `/api/*`

## Getting Started

```bash
cd frontend
npm install
cp .env.example .env  # fill in your credentials
npm run dev
```

The Elysia API is mounted at `/api` within the SvelteKit app (e.g. `/api/auth/login`).
