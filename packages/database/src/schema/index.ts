// Export all schema definitions
import {
  mysqlTable,
  int,
  varchar,
  datetime,
  decimal,
  text,
  tinyint,
  bigint,
  date,
  mediumtext,
} from 'drizzle-orm/mysql-core';

// Users table
export const users = mysqlTable('tbl_users', {
  userId: int('user_id').primaryKey().autoincrement(),
  userName: varchar('user_name', { length: 100 }).notNull(),
  userPhoneDcode: varchar('user_phone_dcode', { length: 50 }).notNull(),
  userPhone: bigint('user_phone'),
  userDob: date('user_dob').notNull(),
  userProfileInfo: mediumtext('user_profile_info').notNull(),
  userAddress1: varchar('user_address1', { length: 250 }).notNull(),
  userAddress2: varchar('user_address2', { length: 250 }).notNull(),
  userZip: varchar('user_zip', { length: 20 }).notNull(),
  userCountryId: int('user_country_id').notNull(),
  userStateId: int('user_state_id').notNull(),
  userCity: varchar('user_city', { length: 255 }).notNull(),
  userIsBuyer: tinyint('user_is_buyer').notNull(),
  userIsSupplier: tinyint('user_is_supplier').notNull(),
  userParent: int('user_parent').notNull(),
  userIsAdvertiser: tinyint('user_is_advertiser').notNull(),
  userIsAffiliate: tinyint('user_is_affiliate').notNull(),
  userIsShippingCompany: tinyint('user_is_shipping_company').notNull(),
  userAutorenewSubscription: tinyint('user_autorenew_subscription').notNull(),
  userFbAccessToken: varchar('user_fb_access_token', { length: 255 }).notNull(),
  userReferralCode: varchar('user_referral_code', { length: 100 }),
  userReferrerUserId: int('user_referrer_user_id').notNull(),
  userAffiliateReferrerUserId: int('user_affiliate_referrer_user_id').notNull(),
  userPreferredDashboard: tinyint('user_preferred_dashboard').notNull(),
  userRegdate: datetime('user_regdate').notNull(),
  userCompany: varchar('user_company', { length: 500 }).notNull(),
  userProductsServices: mediumtext('user_products_services').notNull(),
  userAffiliateCommission: decimal('user_affiliate_commission', { precision: 10, scale: 2 }).notNull(),
  userRegisteredInitiallyFor: int('user_registered_initially_for').notNull(),
  userOrderTrackingUrl: varchar('user_order_tracking_url', { length: 255 }).notNull(),
  userHasValidSubscription: tinyint('user_has_valid_subscription').notNull(),
  userUpdatedOn: datetime('user_updated_on').notNull().defaultNow(),
  userDeleted: tinyint('user_deleted').notNull(),
  userIsGuest: tinyint('user_is_guest').notNull().default(0),
});

// User credentials table
export const userCredentials = mysqlTable('tbl_user_credentials', {
  credentialUserId: int('credential_user_id').primaryKey(),
  credentialUsername: varchar('credential_username', { length: 255 }).notNull(),
  credentialEmail: varchar('credential_email', { length: 150 }),
  credentialPasswordOld: varchar('credential_password_old', { length: 100 }).notNull(),
  credentialPassword: varchar('credential_password', { length: 100 }).notNull(),
  credentialActive: tinyint('credential_active').notNull(),
  credentialVerified: tinyint('credential_verified').notNull(),
});

// Admin table
export const admin = mysqlTable('tbl_admin', {
  adminId: int('admin_id').primaryKey().autoincrement(),
  adminUsername: varchar('admin_username', { length: 100 }).notNull(),
  adminPasswordOld: varchar('admin_password_old', { length: 100 }).notNull(),
  adminPassword: varchar('admin_password', { length: 100 }).notNull(),
  adminEmail: varchar('admin_email', { length: 150 }).notNull(),
  adminName: varchar('admin_name', { length: 100 }).notNull(),
  adminActive: tinyint('admin_active').notNull(),
  adminEmailNotification: tinyint('admin_email_notification').notNull(),
  adminAdmpermUpdatedOn: datetime('admin_admperm_updated_on').notNull(),
});

// User auth token table
export const userAuthToken = mysqlTable('tbl_user_auth_token', {
  uauthUserId: int('uauth_user_id').notNull(),
  uauthToken: varchar('uauth_token', { length: 32 }).notNull(),
  uauthFcmId: varchar('uauth_fcm_id', { length: 300 }).notNull(),
  uauthDeviceOs: tinyint('uauth_device_os').notNull(),
  uauthUserType: tinyint('uauth_user_type').notNull(),
  uauthExpiry: datetime('uauth_expiry').notNull(),
  uauthBrowser: mediumtext('uauth_browser').notNull(),
  uauthLastAccess: datetime('uauth_last_access').notNull(),
  uauthLastIp: varchar('uauth_last_ip', { length: 16 }).notNull(),
});

// Admin auth token table
export const adminAuthToken = mysqlTable('tbl_admin_auth_token', {
  admauthAdminId: int('admauth_admin_id').notNull(),
  admauthToken: varchar('admauth_token', { length: 32 }).notNull(),
  admauthExpiry: datetime('admauth_expiry').notNull(),
  admauthBrowser: mediumtext('admauth_browser').notNull(),
  admauthLastAccess: datetime('admauth_last_access').notNull(),
  admauthLastIp: varchar('admauth_last_ip', { length: 16 }).notNull(),
});

