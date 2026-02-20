import { Elysia } from "elysia";
import { cors } from "@elysiajs/cors";
import { authPlugin } from "./plugins/auth";

const app = new Elysia()
  .use(
    cors({
      origin: process.env.FRONTEND_URL ?? "http://localhost:5173",
      credentials: true,
    })
  )
  .use(authPlugin)
  .get("/", () => "Hello Elysia")
  .listen(3000);

console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`
);
