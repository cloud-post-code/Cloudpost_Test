// Database exports
export * from './schema';

// Export db utility (for standalone usage only)
// In NestJS apps, inject 'DRIZZLE_DB' from DatabaseModule instead
export { createDatabaseConnection } from './db';

