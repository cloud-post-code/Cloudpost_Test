/**
 * Database migration script
 * Run this to apply migrations to the database
 */

import "dotenv/config";
import { migrate } from "drizzle-orm/postgres-js/migrator";
import { client } from "./db";
import * as schema from "./schema";

async function runMigrations() {
  console.log("Running migrations...");
  await migrate(client, { migrationsFolder: "./src/migrations" });
  console.log("Migrations completed!");
  process.exit(0);
}

runMigrations().catch((error) => {
  console.error("Migration failed:", error);
  process.exit(1);
});

