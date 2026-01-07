import { Module, Global, OnModuleDestroy, Inject } from '@nestjs/common';
import { drizzle } from 'drizzle-orm/mysql2';
import { createPool, Pool } from 'mysql2/promise';
import * as schema from '@cloudpost/database/schema';
import { ConfigService } from '@nestjs/config';
import { MySql2Database } from 'drizzle-orm/mysql2';

@Global()
@Module({
  providers: [
    {
      provide: 'MYSQL_POOL',
      inject: [ConfigService],
      useFactory: (configService: ConfigService): Pool => {
        return createPool({
          host: configService.get('DB_HOST') || 'localhost',
          port: configService.get('DB_PORT') || 3306,
          user: configService.get('DB_USER'),
          password: configService.get('DB_PASSWORD'),
          database: configService.get('DB_NAME') || 'cloudpost_db',
          waitForConnections: true,
          connectionLimit: 10,
          maxIdle: 10,
          idleTimeout: 60000,
          queueLimit: 0,
          enableKeepAlive: true,
          keepAliveInitialDelay: 0,
        });
      },
    },
    {
      provide: 'DRIZZLE_DB',
      inject: ['MYSQL_POOL'],
      useFactory: (pool: Pool): MySql2Database<typeof schema> => {
        return drizzle(pool, { schema, mode: 'default' });
      },
    },
  ],
  exports: ['DRIZZLE_DB', 'MYSQL_POOL'],
})
export class DatabaseModule implements OnModuleDestroy {
  constructor(
    @Inject('MYSQL_POOL') private readonly pool: Pool,
  ) {}

  async onModuleDestroy() {
    await this.pool.end();
  }
}

