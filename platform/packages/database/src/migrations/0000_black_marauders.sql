CREATE TABLE IF NOT EXISTS "user_credentials" (
	"credential_user_id" integer PRIMARY KEY NOT NULL,
	"credential_username" varchar(255) NOT NULL,
	"credential_email" varchar(150),
	"credential_password_old" varchar(100) DEFAULT '' NOT NULL,
	"credential_password" varchar(100) NOT NULL,
	"credential_active" integer DEFAULT 1 NOT NULL,
	"credential_verified" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_extras" (
	"uextra_id" serial PRIMARY KEY NOT NULL,
	"uextra_user_id" integer NOT NULL,
	"uextra_company_name" varchar(100) DEFAULT '' NOT NULL,
	"uextra_website" varchar(100) DEFAULT '' NOT NULL,
	"uextra_tax_id" varchar(100) DEFAULT '' NOT NULL,
	"uextra_payment_method" integer DEFAULT 0 NOT NULL,
	"uextra_cheque_payee_name" varchar(100) DEFAULT '' NOT NULL,
	"uextra_paypal_email_id" varchar(100) DEFAULT '' NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"user_id" serial PRIMARY KEY NOT NULL,
	"user_name" varchar(100) NOT NULL,
	"user_phone_dcode" varchar(50) DEFAULT '' NOT NULL,
	"user_phone" bigint,
	"user_dob" date NOT NULL,
	"user_profile_info" text DEFAULT '' NOT NULL,
	"user_address1" varchar(250) DEFAULT '' NOT NULL,
	"user_address2" varchar(250) DEFAULT '' NOT NULL,
	"user_zip" varchar(20) DEFAULT '' NOT NULL,
	"user_country_id" integer NOT NULL,
	"user_state_id" integer NOT NULL,
	"user_city" varchar(255) DEFAULT '' NOT NULL,
	"user_is_buyer" boolean DEFAULT false NOT NULL,
	"user_is_supplier" boolean DEFAULT false NOT NULL,
	"user_parent" integer DEFAULT 0 NOT NULL,
	"user_is_advertiser" boolean DEFAULT false NOT NULL,
	"user_is_affiliate" boolean DEFAULT false NOT NULL,
	"user_is_shipping_company" boolean DEFAULT false NOT NULL,
	"user_autorenew_subscription" boolean DEFAULT false NOT NULL,
	"user_fb_access_token" varchar(255) DEFAULT '' NOT NULL,
	"user_referral_code" varchar(100),
	"user_referrer_user_id" integer DEFAULT 0 NOT NULL,
	"user_affiliate_referrer_user_id" integer DEFAULT 0 NOT NULL,
	"user_preferred_dashboard" integer DEFAULT 0 NOT NULL,
	"user_regdate" timestamp DEFAULT now(),
	"user_company" varchar(500) DEFAULT '' NOT NULL,
	"user_products_services" text DEFAULT '' NOT NULL,
	"user_registered_initially_for" integer DEFAULT 0 NOT NULL,
	"user_order_tracking_url" varchar(255) DEFAULT '' NOT NULL,
	"user_has_valid_subscription" boolean DEFAULT false NOT NULL,
	"user_updated_on" timestamp DEFAULT now(),
	"user_deleted" boolean DEFAULT false NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "addresses" (
	"addr_id" bigserial PRIMARY KEY NOT NULL,
	"addr_type" integer NOT NULL,
	"addr_record_id" integer NOT NULL,
	"addr_added_by" integer NOT NULL,
	"addr_lang_id" integer NOT NULL,
	"addr_title" varchar(255) NOT NULL,
	"addr_name" varchar(255) NOT NULL,
	"addr_address1" varchar(255) NOT NULL,
	"addr_address2" varchar(255) NOT NULL,
	"addr_city" varchar(255) NOT NULL,
	"addr_state_id" integer NOT NULL,
	"addr_country_id" integer NOT NULL,
	"addr_phone_dcode" varchar(50) NOT NULL,
	"addr_phone" bigint NOT NULL,
	"addr_zip" varchar(20) NOT NULL,
	"addr_lat" varchar(150) DEFAULT '' NOT NULL,
	"addr_lng" varchar(150) DEFAULT '' NOT NULL,
	"addr_is_default" boolean DEFAULT false NOT NULL,
	"addr_deleted" boolean DEFAULT false NOT NULL,
	"addr_updated_on" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "option_values" (
	"optionvalue_id" serial PRIMARY KEY NOT NULL,
	"optionvalue_option_id" integer NOT NULL,
	"optionvalue_identifier" varchar(255) NOT NULL,
	"optionvalue_color_code" varchar(10) DEFAULT '' NOT NULL,
	"optionvalue_display_order" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "option_values_lang" (
	"optionvaluelang_optionvalue_id" integer NOT NULL,
	"optionvaluelang_lang_id" integer NOT NULL,
	"optionvalue_name" varchar(255) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_categories" (
	"prodcat_id" serial PRIMARY KEY NOT NULL,
	"prodcat_parent" integer DEFAULT 0 NOT NULL,
	"prodcat_identifier" varchar(255) NOT NULL,
	"prodcat_active" boolean DEFAULT true NOT NULL,
	"prodcat_featured" boolean DEFAULT false NOT NULL,
	"prodcat_display_order" integer DEFAULT 0 NOT NULL,
	"prodcat_created_at" timestamp DEFAULT now(),
	"prodcat_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_categories_lang" (
	"prodcatlang_prodcat_id" integer NOT NULL,
	"prodcatlang_lang_id" integer NOT NULL,
	"prodcat_name" varchar(255) NOT NULL,
	"prodcat_description" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "options" (
	"option_id" serial PRIMARY KEY NOT NULL,
	"option_identifier" varchar(255) NOT NULL,
	"option_seller_id" integer DEFAULT 0 NOT NULL,
	"option_type" integer NOT NULL,
	"option_deleted" boolean DEFAULT false NOT NULL,
	"option_is_separate_images" boolean DEFAULT false NOT NULL,
	"option_is_color" boolean DEFAULT false NOT NULL,
	"option_display_in_filter" boolean DEFAULT false NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "options_lang" (
	"optionlang_option_id" integer NOT NULL,
	"optionlang_lang_id" integer NOT NULL,
	"option_name" varchar(255) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_to_category" (
	"ptc_product_id" integer NOT NULL,
	"ptc_prodcat_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_to_options" (
	"pto_product_id" integer NOT NULL,
	"pto_option_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_to_tags" (
	"ptt_product_id" integer NOT NULL,
	"ptt_tag_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "products" (
	"product_id" serial PRIMARY KEY NOT NULL,
	"product_seller_id" integer DEFAULT 0 NOT NULL,
	"product_identifier" varchar(255) NOT NULL,
	"product_type" integer DEFAULT 0 NOT NULL,
	"product_active" boolean DEFAULT true NOT NULL,
	"product_deleted" boolean DEFAULT false NOT NULL,
	"product_created_at" timestamp DEFAULT now(),
	"product_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "products_lang" (
	"productlang_product_id" integer NOT NULL,
	"productlang_lang_id" integer NOT NULL,
	"product_name" varchar(255) NOT NULL,
	"product_description" text,
	"product_short_description" text,
	"product_yotpo_id" varchar(100)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "seller_products" (
	"selprod_id" serial PRIMARY KEY NOT NULL,
	"selprod_product_id" integer NOT NULL,
	"selprod_user_id" integer NOT NULL,
	"selprod_sku" varchar(100),
	"selprod_price" numeric(10, 2) NOT NULL,
	"selprod_cost_price" numeric(10, 2),
	"selprod_stock" integer DEFAULT 0 NOT NULL,
	"selprod_min_order_qty" integer DEFAULT 1 NOT NULL,
	"selprod_track_inventory" boolean DEFAULT true NOT NULL,
	"selprod_active" boolean DEFAULT true NOT NULL,
	"selprod_deleted" boolean DEFAULT false NOT NULL,
	"selprod_added_on" timestamp DEFAULT now(),
	"selprod_updated_on" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "seller_products_lang" (
	"selprodlang_selprod_id" integer NOT NULL,
	"selprodlang_lang_id" integer NOT NULL,
	"selprod_title" varchar(255) NOT NULL,
	"selprod_options" varchar(255),
	"selprod_condition" varchar(50)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tags" (
	"tag_id" serial PRIMARY KEY NOT NULL,
	"tag_identifier" varchar(255) NOT NULL,
	"tag_active" boolean DEFAULT true NOT NULL,
	"tag_created_at" timestamp DEFAULT now(),
	"tag_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tags_lang" (
	"taglang_tag_id" integer NOT NULL,
	"taglang_lang_id" integer NOT NULL,
	"tag_name" varchar(255) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_cancellation_requests" (
	"ocrequest_id" serial PRIMARY KEY NOT NULL,
	"ocrequest_order_id" bigint NOT NULL,
	"ocrequest_user_id" integer NOT NULL,
	"ocrequest_reason_id" integer,
	"ocrequest_message" text,
	"ocrequest_status" integer DEFAULT 0 NOT NULL,
	"ocrequest_date" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_payments" (
	"opayment_id" serial PRIMARY KEY NOT NULL,
	"opayment_order_id" bigint NOT NULL,
	"opayment_method" varchar(100),
	"opayment_gateway_txn_id" varchar(150),
	"opayment_amount" numeric(10, 2) NOT NULL,
	"opayment_comments" text,
	"opayment_date" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_products" (
	"op_id" bigserial PRIMARY KEY NOT NULL,
	"op_order_id" bigint NOT NULL,
	"op_selprod_id" integer NOT NULL,
	"op_invoice_number" varchar(50),
	"op_qty" integer NOT NULL,
	"op_unit_price" numeric(10, 2) NOT NULL,
	"op_total_price" numeric(10, 2) NOT NULL,
	"op_status_id" integer NOT NULL,
	"op_selprod_options" varchar(255),
	"op_product_name" varchar(255),
	"op_brand_name" varchar(255),
	"op_other_charges" numeric(10, 2) DEFAULT '0' NOT NULL,
	"op_tax_collected_by_seller" boolean DEFAULT false NOT NULL,
	"op_rounding_off" numeric(10, 2) DEFAULT '0' NOT NULL,
	"op_added_on" timestamp DEFAULT now(),
	"op_updated_on" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_return_requests" (
	"orrequest_id" serial PRIMARY KEY NOT NULL,
	"orrequest_op_id" bigint NOT NULL,
	"orrequest_user_id" integer NOT NULL,
	"orrequest_qty" integer NOT NULL,
	"orrequest_type" integer NOT NULL,
	"orrequest_reference" varchar(50),
	"orrequest_status" integer DEFAULT 0 NOT NULL,
	"orrequest_date" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_status" (
	"orderstatus_id" serial PRIMARY KEY NOT NULL,
	"orderstatus_identifier" varchar(50) NOT NULL,
	"orderstatus_active" boolean DEFAULT true NOT NULL,
	"orderstatus_color_class" varchar(50),
	"orderstatus_display_order" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_status_lang" (
	"orderstatuslang_orderstatus_id" integer NOT NULL,
	"orderstatuslang_lang_id" integer NOT NULL,
	"orderstatus_name" varchar(100) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "orders" (
	"order_id" bigserial PRIMARY KEY NOT NULL,
	"order_user_id" integer NOT NULL,
	"order_number" varchar(50) NOT NULL,
	"order_net_amount" numeric(10, 2) NOT NULL,
	"order_pmethod_id" integer,
	"order_date_added" timestamp DEFAULT now(),
	"order_date_updated" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_transactions" (
	"utxn_id" bigserial PRIMARY KEY NOT NULL,
	"utxn_user_id" integer NOT NULL,
	"utxn_date" timestamp DEFAULT now(),
	"utxn_gateway_txn_id" varchar(150),
	"utxn_comments" text,
	"utxn_status" integer DEFAULT 0 NOT NULL,
	"utxn_order_id" bigint,
	"utxn_op_id" bigint,
	"utxn_withdrawal_id" integer,
	"utxn_type" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_withdrawal_requests" (
	"withdrawal_id" bigserial PRIMARY KEY NOT NULL,
	"withdrawal_user_id" integer NOT NULL,
	"withdrawal_payment_method" integer NOT NULL,
	"withdrawal_bank" varchar(255),
	"withdrawal_account_holder_name" varchar(255),
	"withdrawal_account_number" varchar(100),
	"withdrawal_ifc_swift_code" varchar(100),
	"withdrawal_bank_address" text,
	"withdrawal_instructions" text,
	"withdrawal_request_date" timestamp DEFAULT now(),
	"withdrawal_status" integer DEFAULT 0 NOT NULL,
	"withdrawal_cheque_payee_name" varchar(100),
	"withdrawal_paypal_email_id" varchar(100),
	"withdrawal_comments" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_subscriptions" (
	"ossubs_id" serial PRIMARY KEY NOT NULL,
	"ossubs_user_id" integer NOT NULL,
	"ossubs_plan_id" integer NOT NULL,
	"ossubs_type" integer NOT NULL,
	"ossubs_price" numeric(10, 2) NOT NULL,
	"ossubs_images_allowed" integer DEFAULT 0 NOT NULL,
	"ossubs_products_allowed" integer DEFAULT 0 NOT NULL,
	"ossubs_inventory_allowed" integer DEFAULT 0 NOT NULL,
	"ossubs_interval" integer NOT NULL,
	"ossubs_frequency" integer NOT NULL,
	"ossubs_commission" numeric(5, 2) DEFAULT '0' NOT NULL,
	"ossubs_till_date" date,
	"ossubs_created_at" timestamp DEFAULT now(),
	"ossubs_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "seller_packages" (
	"spackage_id" serial PRIMARY KEY NOT NULL,
	"spackage_identifier" varchar(255) NOT NULL,
	"spackage_active" boolean DEFAULT true NOT NULL,
	"spackage_created_at" timestamp DEFAULT now(),
	"spackage_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "seller_packages_lang" (
	"spackagelang_spackage_id" integer NOT NULL,
	"spackagelang_lang_id" integer NOT NULL,
	"spackage_name" varchar(255) NOT NULL,
	"spackage_description" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "shops" (
	"shop_id" serial PRIMARY KEY NOT NULL,
	"shop_user_id" integer NOT NULL,
	"shop_identifier" varchar(255) NOT NULL,
	"shop_active" boolean DEFAULT true NOT NULL,
	"shop_featured" boolean DEFAULT false NOT NULL,
	"shop_created_at" timestamp DEFAULT now(),
	"shop_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "shops_lang" (
	"shoplang_shop_id" integer NOT NULL,
	"shoplang_lang_id" integer NOT NULL,
	"shop_name" varchar(255) NOT NULL,
	"shop_description" text,
	"shop_policy" text,
	"shop_return_policy" text,
	"shop_shipping_policy" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "countries" (
	"country_id" serial PRIMARY KEY NOT NULL,
	"country_code" varchar(3) NOT NULL,
	"country_active" boolean DEFAULT true NOT NULL,
	"country_created_at" timestamp DEFAULT now(),
	"country_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "countries_lang" (
	"countrylang_country_id" integer NOT NULL,
	"countrylang_lang_id" integer NOT NULL,
	"country_name" varchar(255) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "currencies" (
	"currency_id" serial PRIMARY KEY NOT NULL,
	"currency_code" varchar(3) NOT NULL,
	"currency_symbol_left" varchar(10),
	"currency_symbol_right" varchar(10),
	"currency_active" boolean DEFAULT true NOT NULL,
	"currency_created_at" timestamp DEFAULT now(),
	"currency_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "currencies_lang" (
	"currencylang_currency_id" integer NOT NULL,
	"currencylang_lang_id" integer NOT NULL,
	"currency_name" varchar(100) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "languages" (
	"lang_id" serial PRIMARY KEY NOT NULL,
	"lang_code" varchar(10) NOT NULL,
	"lang_name" varchar(100) NOT NULL,
	"lang_active" boolean DEFAULT true NOT NULL,
	"lang_layout_direction" varchar(10) DEFAULT 'ltr' NOT NULL,
	"lang_created_at" timestamp DEFAULT now(),
	"lang_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "states" (
	"state_id" serial PRIMARY KEY NOT NULL,
	"state_country_id" integer NOT NULL,
	"state_code" varchar(10),
	"state_active" boolean DEFAULT true NOT NULL,
	"state_created_at" timestamp DEFAULT now(),
	"state_updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "states_lang" (
	"statelang_state_id" integer NOT NULL,
	"statelang_lang_id" integer NOT NULL,
	"state_name" varchar(255) NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_credentials" ADD CONSTRAINT "user_credentials_credential_user_id_users_user_id_fk" FOREIGN KEY ("credential_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_extras" ADD CONSTRAINT "user_extras_uextra_user_id_users_user_id_fk" FOREIGN KEY ("uextra_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "addresses" ADD CONSTRAINT "addresses_addr_state_id_states_state_id_fk" FOREIGN KEY ("addr_state_id") REFERENCES "states"("state_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "addresses" ADD CONSTRAINT "addresses_addr_country_id_countries_country_id_fk" FOREIGN KEY ("addr_country_id") REFERENCES "countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "option_values" ADD CONSTRAINT "option_values_optionvalue_option_id_options_option_id_fk" FOREIGN KEY ("optionvalue_option_id") REFERENCES "options"("option_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "option_values_lang" ADD CONSTRAINT "option_values_lang_optionvaluelang_optionvalue_id_option_values_optionvalue_id_fk" FOREIGN KEY ("optionvaluelang_optionvalue_id") REFERENCES "option_values"("optionvalue_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_categories_lang" ADD CONSTRAINT "product_categories_lang_prodcatlang_prodcat_id_product_categories_prodcat_id_fk" FOREIGN KEY ("prodcatlang_prodcat_id") REFERENCES "product_categories"("prodcat_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "options" ADD CONSTRAINT "options_option_seller_id_users_user_id_fk" FOREIGN KEY ("option_seller_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "options_lang" ADD CONSTRAINT "options_lang_optionlang_option_id_options_option_id_fk" FOREIGN KEY ("optionlang_option_id") REFERENCES "options"("option_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_to_category" ADD CONSTRAINT "product_to_category_ptc_product_id_products_product_id_fk" FOREIGN KEY ("ptc_product_id") REFERENCES "products"("product_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_to_category" ADD CONSTRAINT "product_to_category_ptc_prodcat_id_product_categories_prodcat_id_fk" FOREIGN KEY ("ptc_prodcat_id") REFERENCES "product_categories"("prodcat_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_to_options" ADD CONSTRAINT "product_to_options_pto_product_id_products_product_id_fk" FOREIGN KEY ("pto_product_id") REFERENCES "products"("product_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_to_options" ADD CONSTRAINT "product_to_options_pto_option_id_options_option_id_fk" FOREIGN KEY ("pto_option_id") REFERENCES "options"("option_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_to_tags" ADD CONSTRAINT "product_to_tags_ptt_product_id_products_product_id_fk" FOREIGN KEY ("ptt_product_id") REFERENCES "products"("product_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_to_tags" ADD CONSTRAINT "product_to_tags_ptt_tag_id_tags_tag_id_fk" FOREIGN KEY ("ptt_tag_id") REFERENCES "tags"("tag_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "products" ADD CONSTRAINT "products_product_seller_id_users_user_id_fk" FOREIGN KEY ("product_seller_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "products_lang" ADD CONSTRAINT "products_lang_productlang_product_id_products_product_id_fk" FOREIGN KEY ("productlang_product_id") REFERENCES "products"("product_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "seller_products" ADD CONSTRAINT "seller_products_selprod_product_id_products_product_id_fk" FOREIGN KEY ("selprod_product_id") REFERENCES "products"("product_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "seller_products" ADD CONSTRAINT "seller_products_selprod_user_id_users_user_id_fk" FOREIGN KEY ("selprod_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "seller_products_lang" ADD CONSTRAINT "seller_products_lang_selprodlang_selprod_id_seller_products_selprod_id_fk" FOREIGN KEY ("selprodlang_selprod_id") REFERENCES "seller_products"("selprod_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tags_lang" ADD CONSTRAINT "tags_lang_taglang_tag_id_tags_tag_id_fk" FOREIGN KEY ("taglang_tag_id") REFERENCES "tags"("tag_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_cancellation_requests" ADD CONSTRAINT "order_cancellation_requests_ocrequest_order_id_orders_order_id_fk" FOREIGN KEY ("ocrequest_order_id") REFERENCES "orders"("order_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_cancellation_requests" ADD CONSTRAINT "order_cancellation_requests_ocrequest_user_id_users_user_id_fk" FOREIGN KEY ("ocrequest_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_payments" ADD CONSTRAINT "order_payments_opayment_order_id_orders_order_id_fk" FOREIGN KEY ("opayment_order_id") REFERENCES "orders"("order_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_products" ADD CONSTRAINT "order_products_op_order_id_orders_order_id_fk" FOREIGN KEY ("op_order_id") REFERENCES "orders"("order_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_products" ADD CONSTRAINT "order_products_op_selprod_id_seller_products_selprod_id_fk" FOREIGN KEY ("op_selprod_id") REFERENCES "seller_products"("selprod_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_products" ADD CONSTRAINT "order_products_op_status_id_order_status_orderstatus_id_fk" FOREIGN KEY ("op_status_id") REFERENCES "order_status"("orderstatus_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_return_requests" ADD CONSTRAINT "order_return_requests_orrequest_op_id_order_products_op_id_fk" FOREIGN KEY ("orrequest_op_id") REFERENCES "order_products"("op_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_return_requests" ADD CONSTRAINT "order_return_requests_orrequest_user_id_users_user_id_fk" FOREIGN KEY ("orrequest_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_status_lang" ADD CONSTRAINT "order_status_lang_orderstatuslang_orderstatus_id_order_status_orderstatus_id_fk" FOREIGN KEY ("orderstatuslang_orderstatus_id") REFERENCES "order_status"("orderstatus_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "orders" ADD CONSTRAINT "orders_order_user_id_users_user_id_fk" FOREIGN KEY ("order_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_transactions" ADD CONSTRAINT "user_transactions_utxn_user_id_users_user_id_fk" FOREIGN KEY ("utxn_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_withdrawal_requests" ADD CONSTRAINT "user_withdrawal_requests_withdrawal_user_id_users_user_id_fk" FOREIGN KEY ("withdrawal_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_subscriptions" ADD CONSTRAINT "order_subscriptions_ossubs_user_id_users_user_id_fk" FOREIGN KEY ("ossubs_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_subscriptions" ADD CONSTRAINT "order_subscriptions_ossubs_plan_id_seller_packages_spackage_id_fk" FOREIGN KEY ("ossubs_plan_id") REFERENCES "seller_packages"("spackage_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "seller_packages_lang" ADD CONSTRAINT "seller_packages_lang_spackagelang_spackage_id_seller_packages_spackage_id_fk" FOREIGN KEY ("spackagelang_spackage_id") REFERENCES "seller_packages"("spackage_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "shops" ADD CONSTRAINT "shops_shop_user_id_users_user_id_fk" FOREIGN KEY ("shop_user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "shops_lang" ADD CONSTRAINT "shops_lang_shoplang_shop_id_shops_shop_id_fk" FOREIGN KEY ("shoplang_shop_id") REFERENCES "shops"("shop_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "countries_lang" ADD CONSTRAINT "countries_lang_countrylang_country_id_countries_country_id_fk" FOREIGN KEY ("countrylang_country_id") REFERENCES "countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "countries_lang" ADD CONSTRAINT "countries_lang_countrylang_lang_id_languages_lang_id_fk" FOREIGN KEY ("countrylang_lang_id") REFERENCES "languages"("lang_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "currencies_lang" ADD CONSTRAINT "currencies_lang_currencylang_currency_id_currencies_currency_id_fk" FOREIGN KEY ("currencylang_currency_id") REFERENCES "currencies"("currency_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "currencies_lang" ADD CONSTRAINT "currencies_lang_currencylang_lang_id_languages_lang_id_fk" FOREIGN KEY ("currencylang_lang_id") REFERENCES "languages"("lang_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "states" ADD CONSTRAINT "states_state_country_id_countries_country_id_fk" FOREIGN KEY ("state_country_id") REFERENCES "countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "states_lang" ADD CONSTRAINT "states_lang_statelang_state_id_states_state_id_fk" FOREIGN KEY ("statelang_state_id") REFERENCES "states"("state_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "states_lang" ADD CONSTRAINT "states_lang_statelang_lang_id_languages_lang_id_fk" FOREIGN KEY ("statelang_lang_id") REFERENCES "languages"("lang_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
