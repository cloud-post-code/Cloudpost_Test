import { Injectable, Inject } from '@nestjs/common';
import { MySql2Database } from 'drizzle-orm/mysql2';
import { eq } from 'drizzle-orm';
import { admin } from '@cloudpost/database/schema';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AdminService {
  constructor(@Inject('DRIZZLE_DB') private db: MySql2Database<any>) {}

  async findByUsername(username: string) {
    const admins = await this.db
      .select()
      .from(admin)
      .where(eq(admin.adminUsername, username))
      .limit(1);

    return admins.length > 0 ? admins[0] : null;
  }

  async findByEmail(email: string) {
    const admins = await this.db
      .select()
      .from(admin)
      .where(eq(admin.adminEmail, email))
      .limit(1);

    return admins.length > 0 ? admins[0] : null;
  }

  async findOne(id: number) {
    const admins = await this.db
      .select()
      .from(admin)
      .where(eq(admin.adminId, id))
      .limit(1);

    return admins.length > 0 ? admins[0] : null;
  }

  async validatePassword(adminRecord: any, password: string): Promise<boolean> {
    // Check if password is bcrypt hashed (starts with $2a$, $2b$, or $2y$)
    const isHashed = adminRecord.adminPassword.startsWith('$2');
    if (isHashed) {
      return bcrypt.compare(password, adminRecord.adminPassword);
    }
    // Fallback to plain text comparison for backward compatibility
    // TODO: Migrate all admin passwords to bcrypt
    return password === adminRecord.adminPassword;
  }
}

