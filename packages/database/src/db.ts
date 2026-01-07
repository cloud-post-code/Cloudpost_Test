/**
 * Database connection utility
 * 
 * NOTE: In a monorepo with NestJS, database connections should be managed
 * through NestJS dependency injection (see apps/backend/src/db/database.module.ts).
 * 
 * This file is kept for standalone usage or testing purposes only.
 * For production use, inject 'DRIZZLE_DB' from the DatabaseModule.
 */

import { drizzle } from 'drizzle-orm/mysql2';
import { createPool, Pool } from 'mysql2/promise';
import * as schema from './schema';
import { MySql2Database } from 'drizzle-orm/mysql2';

/**
 * Create a database connection pool (for standalone usage only)
 * In NestJS apps, use DatabaseModule instead
 */
export function createDatabaseConnection(): {
  pool: Pool;
  db: MySql2Database<typeof schema>;
} {
  const pool = createPool({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306'),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'cloudpost_db',
    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 10,
    idleTimeout: 60000,
    queueLimit: 0,
    enableKeepAlive: true,
    keepAliveInitialDelay: 0,
  });

  const db = drizzle(pool, { schema, mode: 'default' });

  return { pool, db };
}

