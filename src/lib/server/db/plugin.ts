import { Elysia } from "elysia";
import { db } from "./index";

export const drizzlePlugin = new Elysia({ name: "drizzle" }).decorate("db", db);
