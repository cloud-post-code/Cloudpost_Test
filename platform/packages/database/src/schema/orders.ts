/**
 * Orders schema
 * Orders, Order Products, Order Payments, Order Status
 */

import {
  pgTable,
  bigserial,
  serial,
  integer,
  varchar,
  timestamp,
  boolean,
  decimal,
  bigint,
  text,
  date,
  time,
} from "drizzle-orm/pg-core";
import { users } from "./users";
import { addresses } from "./addresses";
import { sellerProducts } from "./products";

// Order status table
export const orderStatus = pgTable("order_status", {
  id: serial("orderstatus_id").primaryKey(),
  identifier: varchar("orderstatus_identifier", { length: 50 }).notNull(),
  active: boolean("orderstatus_active").notNull().default(true),
  colorClass: varchar("orderstatus_color_class", { length: 50 }),
  displayOrder: integer("orderstatus_display_order").notNull().default(0),
});

// Order status language table
export const orderStatusLang = pgTable("order_status_lang", {
  statusId: integer("orderstatuslang_orderstatus_id").notNull().references(() => orderStatus.id),
  langId: integer("orderstatuslang_lang_id").notNull(),
  name: varchar("orderstatus_name", { length: 100 }).notNull(),
});

// Orders table
export const orders = pgTable("orders", {
  id: bigserial("order_id", { mode: "number" }).primaryKey(),
  userId: integer("order_user_id").notNull().references(() => users.id),
  number: varchar("order_number", { length: 50 }).notNull(),
  netAmount: decimal("order_net_amount", { precision: 10, scale: 2 }).notNull(),
  paymentMethodId: integer("order_pmethod_id"),
  dateAdded: timestamp("order_date_added").defaultNow(),
  dateUpdated: timestamp("order_date_updated").defaultNow(),
});

// Order products table
export const orderProducts = pgTable("order_products", {
  id: bigserial("op_id", { mode: "number" }).primaryKey(),
  orderId: bigint("op_order_id", { mode: "number" }).notNull().references(() => orders.id),
  sellerProductId: integer("op_selprod_id").notNull().references(() => sellerProducts.id),
  invoiceNumber: varchar("op_invoice_number", { length: 50 }),
  qty: integer("op_qty").notNull(),
  unitPrice: decimal("op_unit_price", { precision: 10, scale: 2 }).notNull(),
  totalPrice: decimal("op_total_price", { precision: 10, scale: 2 }).notNull(),
  statusId: integer("op_status_id").notNull().references(() => orderStatus.id),
  options: varchar("op_selprod_options", { length: 255 }),
  productName: varchar("op_product_name", { length: 255 }),
  brandName: varchar("op_brand_name", { length: 255 }),
  otherCharges: decimal("op_other_charges", { precision: 10, scale: 2 }).notNull().default("0"),
  taxCollectedBySeller: boolean("op_tax_collected_by_seller").notNull().default(false),
  roundingOff: decimal("op_rounding_off", { precision: 10, scale: 2 }).notNull().default("0"),
  createdAt: timestamp("op_added_on").defaultNow(),
  updatedAt: timestamp("op_updated_on").defaultNow(),
});

// Order payments table
export const orderPayments = pgTable("order_payments", {
  id: serial("opayment_id").primaryKey(),
  orderId: bigint("opayment_order_id", { mode: "number" }).notNull().references(() => orders.id),
  method: varchar("opayment_method", { length: 100 }),
  gatewayTxnId: varchar("opayment_gateway_txn_id", { length: 150 }),
  amount: decimal("opayment_amount", { precision: 10, scale: 2 }).notNull(),
  comments: text("opayment_comments"),
  createdAt: timestamp("opayment_date").defaultNow(),
});

// Order cancellation requests table
export const orderCancelRequests = pgTable("order_cancellation_requests", {
  id: serial("ocrequest_id").primaryKey(),
  orderId: bigint("ocrequest_order_id", { mode: "number" }).notNull().references(() => orders.id),
  userId: integer("ocrequest_user_id").notNull().references(() => users.id),
  reasonId: integer("ocrequest_reason_id"),
  message: text("ocrequest_message"),
  status: integer("ocrequest_status").notNull().default(0),
  date: timestamp("ocrequest_date").defaultNow(),
});

// Order return requests table
export const orderReturnRequests = pgTable("order_return_requests", {
  id: serial("orrequest_id").primaryKey(),
  orderProductId: bigint("orrequest_op_id", { mode: "number" })
    .notNull()
    .references(() => orderProducts.id),
  userId: integer("orrequest_user_id").notNull().references(() => users.id),
  qty: integer("orrequest_qty").notNull(),
  type: integer("orrequest_type").notNull(),
  reference: varchar("orrequest_reference", { length: 50 }),
  status: integer("orrequest_status").notNull().default(0),
  date: timestamp("orrequest_date").defaultNow(),
});

// User transactions table (wallet)
export const userTransactions = pgTable("user_transactions", {
  id: bigserial("utxn_id", { mode: "number" }).primaryKey(),
  userId: integer("utxn_user_id").notNull().references(() => users.id),
  date: timestamp("utxn_date").defaultNow(),
  gatewayTxnId: varchar("utxn_gateway_txn_id", { length: 150 }),
  comments: text("utxn_comments"),
  status: integer("utxn_status").notNull().default(0),
  orderId: bigint("utxn_order_id", { mode: "number" }),
  orderProductId: bigint("utxn_op_id", { mode: "number" }),
  withdrawalId: integer("utxn_withdrawal_id"),
  type: integer("utxn_type").notNull(),
});

// User withdrawal requests table
export const userWithdrawalRequests = pgTable("user_withdrawal_requests", {
  id: bigserial("withdrawal_id", { mode: "number" }).primaryKey(),
  userId: integer("withdrawal_user_id").notNull().references(() => users.id),
  paymentMethod: integer("withdrawal_payment_method").notNull(),
  bank: varchar("withdrawal_bank", { length: 255 }),
  accountHolderName: varchar("withdrawal_account_holder_name", { length: 255 }),
  accountNumber: varchar("withdrawal_account_number", { length: 100 }),
  ifcSwiftCode: varchar("withdrawal_ifc_swift_code", { length: 100 }),
  bankAddress: text("withdrawal_bank_address"),
  instructions: text("withdrawal_instructions"),
  requestDate: timestamp("withdrawal_request_date").defaultNow(),
  status: integer("withdrawal_status").notNull().default(0),
  chequePayeeName: varchar("withdrawal_cheque_payee_name", { length: 100 }),
  paypalEmailId: varchar("withdrawal_paypal_email_id", { length: 100 }),
  comments: text("withdrawal_comments"),
});

