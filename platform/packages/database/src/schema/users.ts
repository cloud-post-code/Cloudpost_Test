/**
 * User management schema
 * Users, User Credentials, User Extras
 */

import {
  pgTable,
  serial,
  varchar,
  bigint,
  timestamp,
  boolean,
  integer,
  date,
  text,
} from "drizzle-orm/pg-core";

// Users table
export const users = pgTable("users", {
  id: serial("user_id").primaryKey(),
  name: varchar("user_name", { length: 100 }).notNull(),
  phoneDcode: varchar("user_phone_dcode", { length: 50 }).notNull().default(""),
  phone: bigint("user_phone", { mode: "bigint" }),
  dob: date("user_dob").notNull(),
  profileInfo: text("user_profile_info").notNull().default(""),
  address1: varchar("user_address1", { length: 250 }).notNull().default(""),
  address2: varchar("user_address2", { length: 250 }).notNull().default(""),
  zip: varchar("user_zip", { length: 20 }).notNull().default(""),
  countryId: integer("user_country_id").notNull(),
  stateId: integer("user_state_id").notNull(),
  city: varchar("user_city", { length: 255 }).notNull().default(""),
  isBuyer: boolean("user_is_buyer").notNull().default(false),
  isSupplier: boolean("user_is_supplier").notNull().default(false),
  parent: integer("user_parent").notNull().default(0),
  isAdvertiser: boolean("user_is_advertiser").notNull().default(false),
  isAffiliate: boolean("user_is_affiliate").notNull().default(false),
  isShippingCompany: boolean("user_is_shipping_company").notNull().default(false),
  autoRenewSubscription: boolean("user_autorenew_subscription").notNull().default(false),
  fbAccessToken: varchar("user_fb_access_token", { length: 255 }).notNull().default(""),
  referralCode: varchar("user_referral_code", { length: 100 }),
  referrerUserId: integer("user_referrer_user_id").notNull().default(0),
  affiliateReferrerUserId: integer("user_affiliate_referrer_user_id").notNull().default(0),
  preferredDashboard: integer("user_preferred_dashboard").notNull().default(0),
  regDate: timestamp("user_regdate").defaultNow(),
  company: varchar("user_company", { length: 500 }).notNull().default(""),
  productsServices: text("user_products_services").notNull().default(""),
  registeredInitiallyFor: integer("user_registered_initially_for").notNull().default(0),
  orderTrackingUrl: varchar("user_order_tracking_url", { length: 255 }).notNull().default(""),
  hasValidSubscription: boolean("user_has_valid_subscription").notNull().default(false),
  updatedAt: timestamp("user_updated_on").defaultNow(),
  deleted: boolean("user_deleted").notNull().default(false),
});

// User credentials table
export const userCredentials = pgTable("user_credentials", {
  userId: integer("credential_user_id").primaryKey().references(() => users.id),
  username: varchar("credential_username", { length: 255 }).notNull(),
  email: varchar("credential_email", { length: 150 }),
  passwordOld: varchar("credential_password_old", { length: 100 }).notNull().default(""),
  password: varchar("credential_password", { length: 100 }).notNull(),
  active: integer("credential_active").notNull().default(1),
  verified: integer("credential_verified").notNull().default(0),
});

// User extras table
export const userExtras = pgTable("user_extras", {
  id: serial("uextra_id").primaryKey(),
  userId: integer("uextra_user_id").notNull().references(() => users.id),
  companyName: varchar("uextra_company_name", { length: 100 }).notNull().default(""),
  website: varchar("uextra_website", { length: 100 }).notNull().default(""),
  taxId: varchar("uextra_tax_id", { length: 100 }).notNull().default(""),
  paymentMethod: integer("uextra_payment_method").notNull().default(0),
  chequePayeeName: varchar("uextra_cheque_payee_name", { length: 100 }).notNull().default(""),
  paypalEmailId: varchar("uextra_paypal_email_id", { length: 100 }).notNull().default(""),
});

