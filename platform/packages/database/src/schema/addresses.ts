/**
 * Addresses schema
 */

import {
  pgTable,
  bigserial,
  integer,
  varchar,
  bigint,
  timestamp,
  boolean,
} from "drizzle-orm/pg-core";
import { users } from "./users";
import { states } from "./reference";
import { countries } from "./reference";

// Addresses table
export const addresses = pgTable("addresses", {
  id: bigserial("addr_id", { mode: "number" }).primaryKey(),
  type: integer("addr_type").notNull(),
  recordId: integer("addr_record_id").notNull(),
  addedBy: integer("addr_added_by").notNull(),
  langId: integer("addr_lang_id").notNull(),
  title: varchar("addr_title", { length: 255 }).notNull(),
  name: varchar("addr_name", { length: 255 }).notNull(),
  address1: varchar("addr_address1", { length: 255 }).notNull(),
  address2: varchar("addr_address2", { length: 255 }).notNull(),
  city: varchar("addr_city", { length: 255 }).notNull(),
  stateId: integer("addr_state_id").notNull().references(() => states.id),
  countryId: integer("addr_country_id").notNull().references(() => countries.id),
  phoneDcode: varchar("addr_phone_dcode", { length: 50 }).notNull(),
  phone: bigint("addr_phone", { mode: "number" }).notNull(),
  zip: varchar("addr_zip", { length: 20 }).notNull(),
  lat: varchar("addr_lat", { length: 150 }).notNull().default(""),
  lng: varchar("addr_lng", { length: 150 }).notNull().default(""),
  isDefault: boolean("addr_is_default").notNull().default(false),
  deleted: boolean("addr_deleted").notNull().default(false),
  updatedOn: timestamp("addr_updated_on").defaultNow(),
});

