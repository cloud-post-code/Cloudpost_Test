# Database

This directory contains the database schema and migration files.

## Files

- `schema.sql` - Database schema (moved from root)
- `data.sql` - Initial data dump (moved from root)

## Setup

1. Create the database:
```bash
mysql -u root -p < schema.sql
```

2. Import data (optional):
```bash
mysql -u root -p cloudpost_db < data.sql
```

## Drizzle ORM

The Drizzle schema definitions are in `packages/database/src/schema/`.

To generate Drizzle schemas from your existing MySQL database:

```bash
cd packages/database
npm run generate
```

