import { Elysia } from "elysia";
import { authPlugin } from "$lib/server/auth";

const app = new Elysia({ prefix: "/api" }).use(authPlugin).compile();

const handle = ({ request }: { request: Request }) => app.handle(request);

export const GET = handle;
export const POST = handle;
export const PUT = handle;
export const PATCH = handle;
export const DELETE = handle;
