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
} from "drizzle-orm/pg-core";
import { users } from "./users";

// Shops table
export const shops = pgTable("shops", {
  id: serial("shop_id").primaryKey(),
  userId: integer("shop_user_id").notNull().references(() => users.id),
  identifier: varchar("shop_identifier", { length: 255 }).notNull(),
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

