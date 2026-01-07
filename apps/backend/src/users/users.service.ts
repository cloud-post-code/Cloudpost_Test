import { Injectable, Inject } from '@nestjs/common';
import { MySql2Database } from 'drizzle-orm/mysql2';
import { eq, and } from 'drizzle-orm';
import { Pool } from 'mysql2/promise';
import { users, userCredentials } from '@cloudpost/database/schema';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @Inject('DRIZZLE_DB') private db: MySql2Database<any>,
    @Inject('MYSQL_POOL') private pool: Pool,
  ) {}

  async findByEmail(email: string) {
    const credentials = await this.db
      .select()
      .from(userCredentials)
      .where(eq(userCredentials.credentialEmail, email))
      .limit(1);

    if (credentials.length === 0) {
      return null;
    }

    const credential = credentials[0];
    const userRecords = await this.db
      .select()
      .from(users)
      .where(eq(users.userId, credential.credentialUserId))
      .limit(1);

    if (userRecords.length === 0) {
      return null;
    }

    const user = userRecords[0];
    return {
      ...user,
      email: credential.credentialEmail,
      username: credential.credentialUsername,
      password: credential.credentialPassword,
      active: credential.credentialActive,
      verified: credential.credentialVerified,
    };
  }

  async findOne(id: number) {
    const userRecords = await this.db
      .select()
      .from(users)
      .where(eq(users.userId, id))
      .limit(1);

    if (userRecords.length === 0) {
      return null;
    }

    const user = userRecords[0];
    const credentials = await this.db
      .select()
      .from(userCredentials)
      .where(eq(userCredentials.credentialUserId, id))
      .limit(1);

    if (credentials.length === 0) {
      return user;
    }

    const credential = credentials[0];
    return {
      ...user,
      email: credential.credentialEmail,
      username: credential.credentialUsername,
      active: credential.credentialActive,
      verified: credential.credentialVerified,
    };
  }

  async findAll() {
    return this.db.select().from(users);
  }

  async create(userData: {
    email: string;
    username: string;
    password: string;
    name: string;
    phone?: string;
    phoneDcode?: string;
  }) {
    // Hash password
    const hashedPassword = await bcrypt.hash(userData.password, 10);

    // Use raw query to get insertId
    const connection = await this.pool.getConnection();
    try {
      await connection.beginTransaction();

      // Insert user using raw query to get insertId
      const [userResult] = await connection.execute(
        `INSERT INTO tbl_users (
          user_name, user_phone_dcode, user_phone, user_dob, user_profile_info,
          user_address1, user_address2, user_zip, user_country_id, user_state_id,
          user_city, user_is_buyer, user_is_supplier, user_parent, user_is_advertiser,
          user_is_affiliate, user_is_shipping_company, user_autorenew_subscription,
          user_fb_access_token, user_referral_code, user_referrer_user_id,
          user_affiliate_referrer_user_id, user_preferred_dashboard, user_regdate,
          user_company, user_products_services, user_affiliate_commission,
          user_registered_initially_for, user_order_tracking_url, user_has_valid_subscription,
          user_updated_on, user_deleted, user_is_guest
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?)`,
        [
          userData.name,
          userData.phoneDcode || '',
          userData.phone || null,
          '1990-01-01',
          '',
          '',
          '',
          '',
          0,
          0,
          '',
          1,
          1,
          0,
          0,
          0,
          0,
          0,
          '',
          null,
          0,
          0,
          0,
          new Date(),
          '',
          '',
          '0.00',
          0,
          '',
          0,
          0,
          0,
        ],
      );

      const userId = (userResult as any).insertId;

      // Insert credentials
      await connection.execute(
        `INSERT INTO tbl_user_credentials (
          credential_user_id, credential_username, credential_email,
          credential_password_old, credential_password, credential_active, credential_verified
        ) VALUES (?, ?, ?, ?, ?, ?, ?)`,
        [userId, userData.username, userData.email, '', hashedPassword, 1, 0],
      );

      await connection.commit();
      return this.findOne(userId);
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

