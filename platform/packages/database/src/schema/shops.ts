/**
 * Shops/Seller schema
 */

import {
  pgTable,
  serial,
  integer,
  varchar,
  timestamp,
  boolean,
  text,
  decimal,
  date,
  bigint,
} from "drizzle-orm/pg-core";
import { users } from "./users";
import { countries, states } from "./reference";

// Shops table
export const shops = pgTable("shops", {
  id: serial("shop_id").primaryKey(),
  userId: integer("shop_user_id").notNull().references(() => users.id),
  identifier: varchar("shop_identifier", { length: 255 }).notNull(),
  url: varchar("shop_url", { length: 255 }),
  phoneDcode: varchar("shop_phone_dcode", { length: 50 }),
  phone: bigint("shop_phone", { mode: "number" }),
  postalCode: varchar("shop_postalcode", { length: 50 }),
  countryId: integer("shop_country_id").references(() => countries.id),
  stateId: integer("shop_state_id").references(() => states.id),
  city: varchar("shop_city", { length: 255 }),
  address1: varchar("shop_address_line_1", { length: 255 }),
  address2: varchar("shop_address_line_2", { length: 255 }),
  logo: varchar("shop_logo", { length: 500 }),
  banner: varchar("shop_banner", { length: 500 }),
  vacationStatus: boolean("shop_vacation_status").notNull().default(false),
  returnEligibilityDays: integer("shop_return_eligibility_days"),
  cancellationEligibilityDays: integer("shop_cancellation_eligibility_days"),
  fulfillmentMethod: integer("shop_fulfillment_type").default(1), // 1 = Shipping, 2 = Pickup
  returnAddressSame: boolean("shop_return_address_same").notNull().default(true),
  lat: varchar("shop_lat", { length: 100 }),
  lng: varchar("shop_lng", { length: 100 }),
  active: boolean("shop_active").notNull().default(true),
  featured: boolean("shop_featured").notNull().default(false),
  createdAt: timestamp("shop_created_at").defaultNow(),
  updatedAt: timestamp("shop_updated_at").defaultNow(),
});

// Shops language table
export const shopsLang = pgTable("shops_lang", {
  shopId: integer("shoplang_shop_id").notNull().references(() => shops.id),
  langId: integer("shoplang_lang_id").notNull(),
  name: varchar("shop_name", { length: 255 }).notNull(),
  description: text("shop_description"),
  policy: text("shop_policy"),
  returnPolicy: text("shop_return_policy"),
  shippingPolicy: text("shop_shipping_policy"),
  paymentPolicy: text("shop_payment_policy"),
  refundPolicy: text("shop_refund_policy"),
  sellerInformation: text("shop_seller_info"),
  additionalInformation: text("shop_additional_info"),
});

// Seller packages table
export const sellerPackages = pgTable("seller_packages", {
  id: serial("spackage_id").primaryKey(),
  identifier: varchar("spackage_identifier", { length: 255 }).notNull(),
  active: boolean("spackage_active").notNull().default(true),
  createdAt: timestamp("spackage_created_at").defaultNow(),
  updatedAt: timestamp("spackage_updated_at").defaultNow(),
});

// Seller packages language table
export const sellerPackagesLang = pgTable("seller_packages_lang", {
  packageId: integer("spackagelang_spackage_id").notNull().references(() => sellerPackages.id),
  langId: integer("spackagelang_lang_id").notNull(),
  name: varchar("spackage_name", { length: 255 }).notNull(),
  description: text("spackage_description"),
});

// Shop pickup locations table
export const shopPickupLocations = pgTable("shop_pickup_locations", {
  id: serial("spl_id").primaryKey(),
  shopId: integer("spl_shop_id").notNull().references(() => shops.id),
  countryId: integer("spl_country_id").references(() => countries.id),
  stateId: integer("spl_state_id").references(() => states.id),
  city: varchar("spl_city", { length: 255 }),
  address1: varchar("spl_address1", { length: 255 }),
  address2: varchar("spl_address2", { length: 255 }),
  postalCode: varchar("spl_postal_code", { length: 50 }),
  lat: varchar("spl_lat", { length: 100 }),
  lng: varchar("spl_lng", { length: 100 }),
  isActive: boolean("spl_is_active").notNull().default(true),
  createdAt: timestamp("spl_created_at").defaultNow(),
  updatedAt: timestamp("spl_updated_at").defaultNow(),
});

// Order subscriptions table (seller subscription plans)
export const orderSubscriptions = pgTable("order_subscriptions", {
  id: serial("ossubs_id").primaryKey(),
  userId: integer("ossubs_user_id").notNull().references(() => users.id),
  planId: integer("ossubs_plan_id").notNull().references(() => sellerPackages.id),
  type: integer("ossubs_type").notNull(),
  price: decimal("ossubs_price", { precision: 10, scale: 2 }).notNull(),
  imagesAllowed: integer("ossubs_images_allowed").notNull().default(0),
  productsAllowed: integer("ossubs_products_allowed").notNull().default(0),
  inventoryAllowed: integer("ossubs_inventory_allowed").notNull().default(0),
  interval: integer("ossubs_interval").notNull(),
  frequency: integer("ossubs_frequency").notNull(),
  commission: decimal("ossubs_commission", { precision: 5, scale: 2 }).notNull().default("0"),
  tillDate: date("ossubs_till_date"),
  createdAt: timestamp("ossubs_created_at").defaultNow(),
  updatedAt: timestamp("ossubs_updated_at").defaultNow(),
});

