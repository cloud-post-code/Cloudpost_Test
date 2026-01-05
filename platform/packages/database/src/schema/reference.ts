/**
 * Reference tables schema
 * Countries, States, Languages, Currencies
 */

import { pgTable, serial, varchar, timestamp, boolean, integer } from "drizzle-orm/pg-core";

// Languages table
export const languages = pgTable("languages", {
  id: serial("lang_id").primaryKey(),
  code: varchar("lang_code", { length: 10 }).notNull(),
  name: varchar("lang_name", { length: 100 }).notNull(),
  active: boolean("lang_active").notNull().default(true),
  layoutDirection: varchar("lang_layout_direction", { length: 10 }).notNull().default("ltr"),
  createdAt: timestamp("lang_created_at").defaultNow(),
  updatedAt: timestamp("lang_updated_at").defaultNow(),
});

// Countries table
export const countries = pgTable("countries", {
  id: serial("country_id").primaryKey(),
  code: varchar("country_code", { length: 3 }).notNull(),
  active: boolean("country_active").notNull().default(true),
  createdAt: timestamp("country_created_at").defaultNow(),
  updatedAt: timestamp("country_updated_at").defaultNow(),
});

// Countries language table
export const countriesLang = pgTable("countries_lang", {
  countryId: integer("countrylang_country_id").notNull().references(() => countries.id),
  langId: integer("countrylang_lang_id").notNull().references(() => languages.id),
  name: varchar("country_name", { length: 255 }).notNull(),
});

// States table
export const states = pgTable("states", {
  id: serial("state_id").primaryKey(),
  countryId: integer("state_country_id").notNull().references(() => countries.id),
  code: varchar("state_code", { length: 10 }),
  active: boolean("state_active").notNull().default(true),
  createdAt: timestamp("state_created_at").defaultNow(),
  updatedAt: timestamp("state_updated_at").defaultNow(),
});

// States language table
export const statesLang = pgTable("states_lang", {
  stateId: integer("statelang_state_id").notNull().references(() => states.id),
  langId: integer("statelang_lang_id").notNull().references(() => languages.id),
  name: varchar("state_name", { length: 255 }).notNull(),
});

// Currencies table
export const currencies = pgTable("currencies", {
  id: serial("currency_id").primaryKey(),
  code: varchar("currency_code", { length: 3 }).notNull(),
  symbolLeft: varchar("currency_symbol_left", { length: 10 }),
  symbolRight: varchar("currency_symbol_right", { length: 10 }),
  active: boolean("currency_active").notNull().default(true),
  createdAt: timestamp("currency_created_at").defaultNow(),
  updatedAt: timestamp("currency_updated_at").defaultNow(),
});

// Currencies language table
export const currenciesLang = pgTable("currencies_lang", {
  currencyId: integer("currencylang_currency_id").notNull().references(() => currencies.id),
  langId: integer("currencylang_lang_id").notNull().references(() => languages.id),
  name: varchar("currency_name", { length: 100 }).notNull(),
});

