# Database Module

This module provides database connectivity using Drizzle ORM with MySQL connection pooling.

## Architecture

- **Connection Pooling**: Uses `mysql2/promise` connection pool for efficient database connections
- **Drizzle ORM**: Type-safe database queries with schema validation
- **Dependency Injection**: Managed through NestJS DI system
- **Graceful Shutdown**: Automatically closes connections on app shutdown

## Usage

### Injecting the Database

```typescript
import { Inject } from '@nestjs/common';
import { MySql2Database } from 'drizzle-orm/mysql2';

@Injectable()
export class MyService {
  constructor(
    @Inject('DRIZZLE_DB') private readonly db: MySql2Database<any>,
  ) {}

  async findAll() {
    return this.db.select().from(users);
  }
}
```

### Direct Pool Access (if needed)

```typescript
import { Inject } from '@nestjs/common';
import { Pool } from 'mysql2/promise';

@Injectable()
export class MyService {
  constructor(
    @Inject('MYSQL_POOL') private readonly pool: Pool,
  ) {}
}
```

## Configuration

Database connection is configured via environment variables:

- `DB_HOST` - Database host (default: localhost)
- `DB_PORT` - Database port (default: 3306)
- `DB_USER` - Database user
- `DB_PASSWORD` - Database password
- `DB_NAME` - Database name (default: cloudpost_db)

## Connection Pool Settings

- **connectionLimit**: 10 concurrent connections
- **maxIdle**: 10 idle connections
- **idleTimeout**: 60 seconds
- **enableKeepAlive**: true (prevents connection timeouts)

## Schema Location

Database schemas are defined in `packages/database/src/schema/` and imported via `@cloudpost/database/schema`.

