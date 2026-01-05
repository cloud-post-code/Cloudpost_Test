/**
 * Products schema
 * Products, Product Categories, Seller Products, Product Options, Tags
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
} from "drizzle-orm/pg-core";
import { users } from "./users";

// Product categories table
export const productCategories = pgTable("product_categories", {
  id: serial("prodcat_id").primaryKey(),
  parentId: integer("prodcat_parent").notNull().default(0),
  identifier: varchar("prodcat_identifier", { length: 255 }).notNull(),
  active: boolean("prodcat_active").notNull().default(true),
  featured: boolean("prodcat_featured").notNull().default(false),
  displayOrder: integer("prodcat_display_order").notNull().default(0),
  createdAt: timestamp("prodcat_created_at").defaultNow(),
  updatedAt: timestamp("prodcat_updated_at").defaultNow(),
});

// Product categories language table
export const productCategoriesLang = pgTable("product_categories_lang", {
  categoryId: integer("prodcatlang_prodcat_id").notNull().references(() => productCategories.id),
  langId: integer("prodcatlang_lang_id").notNull(),
  name: varchar("prodcat_name", { length: 255 }).notNull(),
  description: text("prodcat_description"),
});

// Products table
export const products = pgTable("products", {
  id: serial("product_id").primaryKey(),
  sellerId: integer("product_seller_id").notNull().default(0).references(() => users.id),
  identifier: varchar("product_identifier", { length: 255 }).notNull(),
  type: integer("product_type").notNull().default(0),
  active: boolean("product_active").notNull().default(true),
  deleted: boolean("product_deleted").notNull().default(false),
  createdAt: timestamp("product_created_at").defaultNow(),
  updatedAt: timestamp("product_updated_at").defaultNow(),
});

// Products language table
export const productsLang = pgTable("products_lang", {
  productId: integer("productlang_product_id").notNull().references(() => products.id),
  langId: integer("productlang_lang_id").notNull(),
  name: varchar("product_name", { length: 255 }).notNull(),
  description: text("product_description"),
  shortDescription: text("product_short_description"),
  yotpoId: varchar("product_yotpo_id", { length: 100 }),
});

// Product to category table
export const productToCategory = pgTable("product_to_category", {
  productId: integer("ptc_product_id").notNull().references(() => products.id),
  categoryId: integer("ptc_prodcat_id").notNull().references(() => productCategories.id),
});

// Seller products table
export const sellerProducts = pgTable("seller_products", {
  id: serial("selprod_id").primaryKey(),
  productId: integer("selprod_product_id").notNull().references(() => products.id),
  userId: integer("selprod_user_id").notNull().references(() => users.id),
  sku: varchar("selprod_sku", { length: 100 }),
  price: decimal("selprod_price", { precision: 10, scale: 2 }).notNull(),
  costPrice: decimal("selprod_cost_price", { precision: 10, scale: 2 }),
  stock: integer("selprod_stock").notNull().default(0),
  minOrderQty: integer("selprod_min_order_qty").notNull().default(1),
  trackInventory: boolean("selprod_track_inventory").notNull().default(true),
  active: boolean("selprod_active").notNull().default(true),
  deleted: boolean("selprod_deleted").notNull().default(false),
  createdAt: timestamp("selprod_added_on").defaultNow(),
  updatedAt: timestamp("selprod_updated_on").defaultNow(),
});

// Seller products language table
export const sellerProductsLang = pgTable("seller_products_lang", {
  sellerProductId: integer("selprodlang_selprod_id").notNull().references(() => sellerProducts.id),
  langId: integer("selprodlang_lang_id").notNull(),
  title: varchar("selprod_title", { length: 255 }).notNull(),
  options: varchar("selprod_options", { length: 255 }),
  condition: varchar("selprod_condition", { length: 50 }),
});

// Product options table
export const productOptions = pgTable("options", {
  id: serial("option_id").primaryKey(),
  identifier: varchar("option_identifier", { length: 255 }).notNull(),
  sellerId: integer("option_seller_id").notNull().default(0).references(() => users.id),
  type: integer("option_type").notNull(),
  deleted: boolean("option_deleted").notNull().default(false),
  isSeparateImages: boolean("option_is_separate_images").notNull().default(false),
  isColor: boolean("option_is_color").notNull().default(false),
  displayInFilter: boolean("option_display_in_filter").notNull().default(false),
});

// Product options language table
export const productOptionsLang = pgTable("options_lang", {
  optionId: integer("optionlang_option_id").notNull().references(() => productOptions.id),
  langId: integer("optionlang_lang_id").notNull(),
  name: varchar("option_name", { length: 255 }).notNull(),
});

// Option values table
export const optionValues = pgTable("option_values", {
  id: serial("optionvalue_id").primaryKey(),
  optionId: integer("optionvalue_option_id").notNull().references(() => productOptions.id),
  identifier: varchar("optionvalue_identifier", { length: 255 }).notNull(),
  colorCode: varchar("optionvalue_color_code", { length: 10 }).notNull().default(""),
  displayOrder: integer("optionvalue_display_order").notNull().default(0),
});

// Option values language table
export const optionValuesLang = pgTable("option_values_lang", {
  optionValueId: integer("optionvaluelang_optionvalue_id")
    .notNull()
    .references(() => optionValues.id),
  langId: integer("optionvaluelang_lang_id").notNull(),
  name: varchar("optionvalue_name", { length: 255 }).notNull(),
});

// Product to options table
export const productToOptions = pgTable("product_to_options", {
  productId: integer("pto_product_id").notNull().references(() => products.id),
  optionId: integer("pto_option_id").notNull().references(() => productOptions.id),
});

// Tags table
export const tags = pgTable("tags", {
  id: serial("tag_id").primaryKey(),
  identifier: varchar("tag_identifier", { length: 255 }).notNull(),
  active: boolean("tag_active").notNull().default(true),
  createdAt: timestamp("tag_created_at").defaultNow(),
  updatedAt: timestamp("tag_updated_at").defaultNow(),
});

// Tags language table
export const tagsLang = pgTable("tags_lang", {
  tagId: integer("taglang_tag_id").notNull().references(() => tags.id),
  langId: integer("taglang_lang_id").notNull(),
  name: varchar("tag_name", { length: 255 }).notNull(),
});

// Product to tags table
export const productToTags = pgTable("product_to_tags", {
  productId: integer("ptt_product_id").notNull().references(() => products.id),
  tagId: integer("ptt_tag_id").notNull().references(() => tags.id),
});

