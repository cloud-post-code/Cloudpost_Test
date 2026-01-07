SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `cloudpost_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cloudpost_db`;

CREATE TABLE `tbl_abandoned_cart` (
  `abandonedcart_id` int NOT NULL,
  `abandonedcart_user_id` int NOT NULL,
  `abandonedcart_selprod_id` int UNSIGNED NOT NULL,
  `abandonedcart_type` tinyint(1) NOT NULL COMMENT 'Defined in model	',
  `abandonedcart_qty` int NOT NULL,
  `abandonedcart_amount` decimal(10,2) NOT NULL,
  `abandonedcart_action` tinyint(1) NOT NULL COMMENT 'Defined in model',
  `abandonedcart_email_count` int NOT NULL,
  `abandonedcart_discount_notification` tinyint(1) NOT NULL,
  `abandonedcart_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_abusive_words` (
  `abusive_id` int NOT NULL,
  `abusive_keyword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `abusive_lang_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_addresses` (
  `addr_id` bigint UNSIGNED NOT NULL,
  `addr_type` int NOT NULL,
  `addr_record_id` int NOT NULL,
  `addr_added_by` int NOT NULL,
  `addr_lang_id` int NOT NULL,
  `addr_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_address1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_address2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_state_id` int NOT NULL,
  `addr_country_id` int NOT NULL,
  `addr_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_phone` bigint NOT NULL,
  `addr_zip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_lat` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_lng` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_is_default` tinyint(1) NOT NULL,
  `addr_deleted` tinyint(1) NOT NULL,
  `addr_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_admin` (
  `admin_id` int NOT NULL,
  `admin_username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_password_old` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_active` tinyint NOT NULL,
  `admin_email_notification` tinyint(1) NOT NULL,
  `admin_admperm_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_admin_auth_token` (
  `admauth_admin_id` int NOT NULL,
  `admauth_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admauth_expiry` datetime NOT NULL,
  `admauth_browser` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admauth_last_access` datetime NOT NULL,
  `admauth_last_ip` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='To store admin cookies information, Remember Me functionalit';


CREATE TABLE `tbl_admin_password_reset_requests` (
  `aprr_admin_id` int NOT NULL,
  `aprr_token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `aprr_expiry` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_admin_permissions` (
  `admperm_admin_id` int NOT NULL,
  `admperm_section_id` int NOT NULL,
  `admperm_value` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_ads_batches` (
  `adsbatch_id` int NOT NULL,
  `adsbatch_user_id` int NOT NULL,
  `adsbatch_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `adsbatch_lang_id` tinyint NOT NULL,
  `adsbatch_target_country_id` int NOT NULL,
  `adsbatch_status` tinyint NOT NULL,
  `adsbatch_expired_on` datetime NOT NULL,
  `adsbatch_next_execution_on` datetime NOT NULL,
  `adsbatch_synced_on` datetime NOT NULL,
  `adsbatch_added_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_ads_batch_products` (
  `abprod_adsbatch_id` int NOT NULL,
  `abprod_selprod_id` int UNSIGNED NOT NULL,
  `abprod_cat_id` int NOT NULL COMMENT 'Google Product Category',
  `abprod_age_group` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `abprod_item_group_identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `abprod_product_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_affiliate_commission_settings` (
  `afcommsetting_id` int NOT NULL,
  `afcommsetting_prodcat_id` int NOT NULL,
  `afcommsetting_user_id` int NOT NULL COMMENT 'affiliate user_id',
  `afcommsetting_fees` decimal(12,2) NOT NULL,
  `afcommsetting_is_mandatory` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_affiliate_commission_setting_history` (
  `acsh_id` int NOT NULL,
  `acsh_afcommsetting_id` int NOT NULL,
  `acsh_afcommsetting_prodcat_id` int NOT NULL,
  `acsh_afcommsetting_user_id` int NOT NULL,
  `acsh_afcommsetting_fees` decimal(12,2) NOT NULL,
  `acsh_afcommsetting_is_mandatory` tinyint(1) NOT NULL,
  `acsh_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_attached_files` (
  `afile_id` int UNSIGNED NOT NULL,
  `afile_type` int NOT NULL,
  `afile_record_id` bigint NOT NULL,
  `afile_record_subid` bigint NOT NULL,
  `afile_lang_id` int NOT NULL,
  `afile_screen` int NOT NULL COMMENT '1=>Desktop,2=>Ipad/Tablet,3=>Mobile',
  `afile_physical_path` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `afile_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'For display Only',
  `afile_attribute_title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `afile_attribute_alt` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `afile_aspect_ratio` int NOT NULL,
  `afile_display_order` int NOT NULL,
  `afile_downloaded_times` int NOT NULL,
  `afile_updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_attached_files_temp` (
  `afile_id` int UNSIGNED NOT NULL,
  `afile_type` int NOT NULL,
  `afile_record_id` bigint NOT NULL,
  `afile_record_subid` bigint NOT NULL,
  `afile_lang_id` int NOT NULL,
  `afile_screen` int NOT NULL COMMENT '1=>Desktop,2=>Ipad/Tablet,3=>Mobile',
  `afile_physical_path` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `afile_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'For display Only',
  `afile_attribute_title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `afile_attribute_alt` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `afile_aspect_ratio` int NOT NULL,
  `afile_display_order` int NOT NULL,
  `afile_updated_at` datetime NOT NULL,
  `afile_downloaded` tinyint(1) NOT NULL,
  `afile_unique` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_attribute_groups` (
  `attrgrp_id` int NOT NULL,
  `attrgrp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Used for Product Comparison';

CREATE TABLE `tbl_attribute_group_attributes` (
  `attr_id` int NOT NULL,
  `attr_attrgrp_id` int NOT NULL,
  `attr_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `attr_type` int NOT NULL COMMENT 'number, text defined in class',
  `attr_display_order` int NOT NULL,
  `attr_fld_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Used for Product Comparison';

CREATE TABLE `tbl_attribute_group_attributes_lang` (
  `attrlang_attr_id` int NOT NULL,
  `attrlang_lang_id` int NOT NULL,
  `attr_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `attr_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `attr_prefix` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `attr_postfix` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Used for Product Comparison';

CREATE TABLE `tbl_badges` (
  `badge_id` bigint NOT NULL,
  `badge_type` int NOT NULL,
  `badge_trigger_type` tinyint NOT NULL DEFAULT '1',
  `badge_display_inside` tinyint NOT NULL COMMENT 'For Ribbons',
  `badge_shape_type` int NOT NULL COMMENT 'For Ribbons',
  `badge_color` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'For Ribbons',
  `badge_text_color` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'For Ribbons',
  `badge_identifier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `badge_required_approval` tinyint NOT NULL,
  `badge_active` tinyint NOT NULL,
  `badge_updated_on` datetime NOT NULL,
  `badge_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_badges_lang` (
  `badgelang_badge_id` bigint NOT NULL,
  `badgelang_lang_id` int NOT NULL,
  `badge_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_badge_links` (
  `badgelink_id` int NOT NULL,
  `badgelink_blinkcond_id` bigint NOT NULL,
  `badgelink_record_id` bigint NOT NULL,
  `badgelink_breq_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_badge_link_conditions` (
  `blinkcond_id` bigint NOT NULL,
  `blinkcond_badge_id` bigint NOT NULL,
  `blinkcond_user_id` int NOT NULL COMMENT 'Seller Id',
  `blinkcond_position` tinyint NOT NULL,
  `blinkcond_record_type` int NOT NULL,
  `blinkcond_from_date` datetime DEFAULT NULL,
  `blinkcond_to_date` datetime DEFAULT NULL,
  `blinkcond_condition_type` int NOT NULL,
  `blinkcond_condition_from` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blinkcond_condition_to` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_badge_requests` (
  `breq_id` int NOT NULL,
  `breq_blinkcond_id` int NOT NULL,
  `breq_record_type` int NOT NULL,
  `breq_user_id` bigint NOT NULL COMMENT 'Seller Id',
  `breq_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `breq_status` tinyint NOT NULL,
  `breq_requested_on` datetime NOT NULL,
  `breq_status_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_banners` (
  `banner_id` int NOT NULL,
  `banner_blocation_id` int NOT NULL,
  `banner_type` int NOT NULL,
  `banner_record_id` int NOT NULL,
  `banner_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `banner_target` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `banner_added_on` datetime NOT NULL,
  `banner_start_date` date NOT NULL,
  `banner_end_date` date NOT NULL,
  `banner_start_time` time NOT NULL,
  `banner_end_time` time NOT NULL,
  `banner_active` tinyint(1) NOT NULL,
  `banner_deleted` tinyint(1) NOT NULL,
  `banner_display_order` int NOT NULL,
  `banner_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_banners_clicks` (
  `bclick_id` bigint NOT NULL,
  `bclick_banner_id` int NOT NULL,
  `bclick_user_id` int NOT NULL,
  `bclick_datetime` datetime NOT NULL,
  `bclick_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bclick_cost` decimal(10,4) NOT NULL,
  `bclick_session_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_banners_lang` (
  `bannerlang_banner_id` int NOT NULL,
  `bannerlang_lang_id` int NOT NULL,
  `banner_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_banners_logs` (
  `lbanner_banner_id` int NOT NULL,
  `lbanner_date` date NOT NULL,
  `lbanner_impressions` int NOT NULL DEFAULT '1',
  `lbanner_clicks` int NOT NULL,
  `lbanner_orders` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_banner_locations` (
  `blocation_id` int NOT NULL,
  `blocation_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blocation_collection_id` int NOT NULL,
  `blocation_banner_count` int NOT NULL,
  `blocation_promotion_cost` decimal(10,4) NOT NULL,
  `blocation_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_banner_locations_lang` (
  `blocationlang_blocation_id` int NOT NULL,
  `blocationlang_lang_id` int NOT NULL,
  `blocation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_banner_location_dimensions` (
  `bldimension_blocation_id` int NOT NULL,
  `bldimension_device_type` int NOT NULL,
  `blocation_banner_width` decimal(10,0) NOT NULL,
  `blocation_banner_height` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_blog_contributions` (
  `bcontributions_id` int NOT NULL,
  `bcontributions_author_first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bcontributions_author_last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bcontributions_author_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bcontributions_author_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bcontributions_author_phone` bigint NOT NULL,
  `bcontributions_status` tinyint(1) NOT NULL,
  `bcontributions_added_on` datetime NOT NULL,
  `bcontributions_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_blog_post` (
  `post_id` int NOT NULL,
  `post_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `post_published` tinyint(1) NOT NULL,
  `post_comment_opened` tinyint(1) NOT NULL,
  `post_featured` tinyint(1) NOT NULL,
  `post_added_on` datetime NOT NULL,
  `post_published_on` datetime NOT NULL,
  `post_updated_on` datetime NOT NULL,
  `post_view_count` bigint NOT NULL,
  `post_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_blog_post_categories` (
  `bpcategory_id` int NOT NULL,
  `bpcategory_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bpcategory_parent` int NOT NULL,
  `bpcategory_display_order` int NOT NULL,
  `bpcategory_featured` tinyint(1) NOT NULL,
  `bpcategory_active` tinyint(1) NOT NULL,
  `bpcategory_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_blog_post_categories_lang` (
  `bpcategorylang_bpcategory_id` int NOT NULL,
  `bpcategorylang_lang_id` int NOT NULL,
  `bpcategory_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_blog_post_comments` (
  `bpcomment_id` int NOT NULL,
  `bpcomment_post_id` int NOT NULL,
  `bpcomment_user_id` int NOT NULL,
  `bpcomment_author_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bpcomment_author_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bpcomment_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bpcomment_approved` tinyint(1) NOT NULL,
  `bpcomment_deleted` tinyint(1) NOT NULL,
  `bpcomment_added_on` datetime NOT NULL,
  `bpcomment_user_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bpcomment_user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_blog_post_lang` (
  `postlang_post_id` int NOT NULL,
  `postlang_lang_id` int NOT NULL,
  `post_author_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `post_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `post_short_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `post_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_blog_post_to_category` (
  `ptc_bpcategory_id` int NOT NULL,
  `ptc_post_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_brands` (
  `brand_id` int NOT NULL,
  `brand_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `brand_seller_id` int NOT NULL,
  `brand_featured` tinyint(1) NOT NULL,
  `brand_active` tinyint(1) NOT NULL,
  `brand_status` tinyint NOT NULL,
  `brand_deleted` tinyint(1) NOT NULL,
  `brand_comments` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `brand_updated_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `brand_requested_on` datetime NOT NULL,
  `brand_status_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_brands_lang` (
  `brandlang_brand_id` int NOT NULL,
  `brandlang_lang_id` int NOT NULL,
  `brand_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `brand_short_description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_calculative_data` (
  `cd_key` int NOT NULL,
  `cd_type` int NOT NULL,
  `cd_value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `cd_updated_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_catalog_request_messages` (
  `scatrequestmsg_id` int NOT NULL,
  `scatrequestmsg_scatrequest_id` int NOT NULL,
  `scatrequestmsg_from_user_id` int NOT NULL,
  `scatrequestmsg_from_admin_id` int NOT NULL,
  `scatrequestmsg_msg` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scatrequestmsg_date` datetime NOT NULL,
  `scatrequestmsg_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_collections` (
  `collection_id` int NOT NULL,
  `collection_identifier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `collection_type` tinyint NOT NULL COMMENT 'defined in collection model',
  `collection_criteria` int NOT NULL,
  `collection_primary_records` tinyint NOT NULL,
  `collection_child_records` tinyint NOT NULL,
  `collection_display_order` int NOT NULL,
  `collection_active` tinyint(1) NOT NULL,
  `collection_deleted` tinyint(1) NOT NULL,
  `collection_link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `collection_layout_type` tinyint NOT NULL COMMENT 'defined in collections model',
  `collection_display_media_only` tinyint(1) NOT NULL,
  `collection_for_web` tinyint(1) NOT NULL,
  `collection_for_app` tinyint(1) NOT NULL,
  `collection_updated_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_collections_lang` (
  `collectionlang_collection_id` int NOT NULL,
  `collectionlang_lang_id` int NOT NULL,
  `collection_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `collection_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `collection_link_caption` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_collection_to_records` (
  `ctr_collection_id` int NOT NULL,
  `ctr_record_id` int NOT NULL,
  `ctr_display_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_commission_settings` (
  `commsetting_id` int NOT NULL,
  `commsetting_product_id` int UNSIGNED NOT NULL,
  `commsetting_user_id` int NOT NULL,
  `commsetting_prodcat_id` int NOT NULL,
  `commsetting_fees` decimal(10,2) NOT NULL COMMENT 'in %',
  `commsetting_is_mandatory` tinyint(1) NOT NULL,
  `commsetting_by_package` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_commission_setting_history` (
  `csh_id` int NOT NULL,
  `csh_commsetting_id` int NOT NULL,
  `csh_commsetting_product_id` int UNSIGNED NOT NULL,
  `csh_commsetting_user_id` int NOT NULL,
  `csh_commsetting_prodcat_id` int NOT NULL,
  `csh_commsetting_fees` decimal(10,2) NOT NULL COMMENT 'in %',
  `csh_commsetting_is_mandatory` tinyint(1) NOT NULL,
  `csh_commsetting_deleted` tinyint(1) NOT NULL,
  `csh_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_configurations` (
  `conf_name` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `conf_val` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `conf_common` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_content_block_to_category` (
  `cbtc_prodcat_id` int NOT NULL,
  `cbtc_cpage_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_content_pages` (
  `cpage_id` int NOT NULL,
  `cpage_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cpage_layout` tinyint NOT NULL,
  `cpage_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_content_pages_block_lang` (
  `cpblocklang_id` int NOT NULL,
  `cpblocklang_lang_id` int NOT NULL,
  `cpblocklang_cpage_id` int NOT NULL,
  `cpblocklang_block_id` int NOT NULL,
  `cpblocklang_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_content_pages_lang` (
  `cpagelang_cpage_id` int NOT NULL,
  `cpagelang_lang_id` int NOT NULL,
  `cpage_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cpage_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cpage_image_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cpage_image_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_countries` (
  `country_id` int NOT NULL,
  `country_code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country_code_alpha3` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country_dial_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country_active` tinyint(1) NOT NULL,
  `country_zone_id` int NOT NULL,
  `country_currency_id` int NOT NULL,
  `country_language_id` int NOT NULL,
  `country_updated_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_countries_lang` (
  `countrylang_country_id` int NOT NULL,
  `countrylang_lang_id` int NOT NULL,
  `country_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_coupons` (
  `coupon_id` int NOT NULL,
  `coupon_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `coupon_type` tinyint NOT NULL COMMENT 'Defined in model like discount or free shipping coupon',
  `coupon_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `coupon_valid_for` int NOT NULL COMMENT 'Defined in Discount Coupon model',
  `coupon_min_order_value` decimal(12,2) NOT NULL,
  `coupon_discount_in_percent` tinyint(1) NOT NULL,
  `coupon_discount_value` decimal(12,2) NOT NULL,
  `coupon_max_discount_value` decimal(12,2) NOT NULL,
  `coupon_start_date` date NOT NULL,
  `coupon_end_date` date NOT NULL,
  `coupon_uses_count` int NOT NULL,
  `coupon_uses_coustomer` int NOT NULL,
  `coupon_active` tinyint(1) NOT NULL,
  `coupon_deleted` tinyint(1) NOT NULL,
  `coupon_updated_on` datetime NOT NULL,
  `coupon_amount_deduct_from_seller` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_coupons_history` (
  `couponhistory_id` int NOT NULL,
  `couponhistory_coupon_id` int NOT NULL,
  `couponhistory_order_id` bigint NOT NULL,
  `couponhistory_user_id` int NOT NULL,
  `couponhistory_amount` double(12,2) NOT NULL,
  `couponhistory_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_coupons_hold` (
  `couponhold_id` int NOT NULL,
  `couponhold_coupon_id` int NOT NULL,
  `couponhold_user_id` int NOT NULL,
  `couponhold_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_coupons_hold_pending_order` (
  `ochold_order_id` bigint NOT NULL,
  `ochold_coupon_id` int NOT NULL,
  `ochold_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_coupons_lang` (
  `couponlang_coupon_id` int NOT NULL,
  `couponlang_lang_id` int NOT NULL,
  `coupon_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `coupon_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_coupon_to_brands` (
  `ctb_brand_id` int NOT NULL,
  `ctb_coupon_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_coupon_to_category` (
  `ctc_prodcat_id` int NOT NULL,
  `ctc_coupon_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_coupon_to_plan` (
  `ctplan_spplan_id` int NOT NULL,
  `ctplan_coupon_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_coupon_to_products` (
  `ctp_product_id` int UNSIGNED NOT NULL,
  `ctp_coupon_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_coupon_to_seller` (
  `cts_user_id` int NOT NULL,
  `cts_coupon_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_coupon_to_shops` (
  `cts_shop_id` int NOT NULL,
  `cts_coupon_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_coupon_to_users` (
  `ctu_user_id` int NOT NULL,
  `ctu_coupon_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_cron_log` (
  `cronlog_id` int UNSIGNED NOT NULL,
  `cronlog_cron_id` int NOT NULL,
  `cronlog_started_at` datetime NOT NULL,
  `cronlog_ended_at` datetime NOT NULL,
  `cronlog_details` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_cron_schedules` (
  `cron_id` int NOT NULL,
  `cron_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cron_command` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cron_duration` int NOT NULL COMMENT 'Minutes',
  `cron_active` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_currency` (
  `currency_id` int NOT NULL,
  `currency_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `currency_symbol_left` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `currency_symbol_right` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `currency_value` decimal(20,8) NOT NULL,
  `currency_active` tinyint(1) NOT NULL,
  `currency_date_modified` datetime NOT NULL,
  `currency_display_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_currency_lang` (
  `currencylang_currency_id` int NOT NULL,
  `currencylang_lang_id` int NOT NULL,
  `currency_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_email_archives` (
  `earch_id` int NOT NULL,
  `earch_to_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `earch_to_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `earch_cc_email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `earch_bcc_email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `earch_tpl_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `earch_subject` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `earch_body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `earch_attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `earch_priority` tinyint NOT NULL COMMENT '5 = immediate ,Others must be less than 5',
  `earch_added` datetime NOT NULL,
  `earch_sent_on` datetime DEFAULT NULL,
  `earch_from_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `earch_from_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_email_templates` (
  `etpl_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `etpl_lang_id` int NOT NULL,
  `etpl_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `etpl_subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `etpl_body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `etpl_replacements` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `etpl_priority` tinyint NOT NULL COMMENT '5 means immediate, Others must be less than 5',
  `etpl_status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_empty_cart_items` (
  `emptycartitem_id` int NOT NULL,
  `emptycartitem_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `emptycartitem_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `emptycartitem_url_is_newtab` tinyint(1) NOT NULL,
  `emptycartitem_active` tinyint(1) NOT NULL,
  `emptycartitem_display_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_empty_cart_items_lang` (
  `emptycartitemlang_emptycartitem_id` int NOT NULL,
  `emptycartitemlang_lang_id` int NOT NULL,
  `emptycartitem_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_extra_attributes` (
  `eattribute_id` int NOT NULL,
  `eattribute_eattrgroup_id` int NOT NULL,
  `eattribute_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `eattrgroup_display_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_extra_attributes_lang` (
  `eattributelang_eattribute_id` int NOT NULL,
  `eattributelang_lang_id` int NOT NULL,
  `eattribute_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_extra_attribute_groups` (
  `eattrgroup_id` int NOT NULL,
  `eattrgroup_seller_id` int NOT NULL,
  `eattrgroup_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `eattrgroup_display_order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `eattrgroup_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_extra_attribute_groups_lang` (
  `eattrgrouplang_eattrgroup_id` int NOT NULL,
  `eattrgrouplang_lang_id` int NOT NULL,
  `eattrgroup_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_extra_pages` (
  `epage_id` int NOT NULL,
  `epage_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `epage_type` tinyint NOT NULL COMMENT 'defined in ExtraPage Model',
  `epage_content_for` tinyint(1) NOT NULL,
  `epage_active` tinyint(1) NOT NULL,
  `epage_default` tinyint(1) NOT NULL COMMENT 'Default can not deactivated',
  `epage_default_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `epage_extra_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `epage_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_extra_pages_lang` (
  `epagelang_epage_id` int NOT NULL,
  `epagelang_lang_id` int NOT NULL,
  `epage_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `epage_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_failed_login_attempts` (
  `attempt_username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `attempt_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `attempt_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_faqs` (
  `faq_id` int NOT NULL,
  `faq_faqcat_id` int NOT NULL,
  `faq_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `faq_active` tinyint(1) NOT NULL,
  `faq_deleted` tinyint(1) NOT NULL,
  `faq_display_order` int NOT NULL,
  `faq_featured` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_faqs_lang` (
  `faqlang_faq_id` int NOT NULL,
  `faqlang_lang_id` int NOT NULL,
  `faq_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `faq_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_faq_categories` (
  `faqcat_id` int NOT NULL,
  `faqcat_identifier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `faqcat_active` tinyint(1) NOT NULL,
  `faqcat_type` tinyint NOT NULL,
  `faqcat_deleted` tinyint(1) NOT NULL,
  `faqcat_display_order` int NOT NULL,
  `faqcat_featured` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_faq_categories_lang` (
  `faqcatlang_faqcat_id` int NOT NULL,
  `faqcatlang_lang_id` int NOT NULL,
  `faqcat_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_filters` (
  `filter_id` int NOT NULL,
  `filter_filtergroup_id` int NOT NULL,
  `filter_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `filter_display_order` int NOT NULL,
  `filter_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_filters_lang` (
  `filterlang_filter_id` int NOT NULL,
  `filterlang_lang_id` int NOT NULL,
  `filter_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_filter_groups` (
  `filtergroup_id` int NOT NULL,
  `filtergroup_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `filtergroup_active` tinyint(1) NOT NULL,
  `filtergroup_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_filter_groups_lang` (
  `filtergrouplang_filtergroup_id` int NOT NULL,
  `filtergrouplang_lang_id` int NOT NULL,
  `filtergroup_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_help_center` (
  `hc_id` int NOT NULL,
  `hc_user_type` tinyint NOT NULL,
  `hc_controller` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hc_action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hc_default_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hc_default_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_help_center_lang` (
  `hclang_hc_id` int NOT NULL,
  `hclang_lang_id` tinyint NOT NULL,
  `hclang_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hclang_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_import_export_settings` (
  `impexp_setting_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `impexp_setting_value` tinyint(1) NOT NULL,
  `impexp_setting_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_languages` (
  `language_id` int NOT NULL,
  `language_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_country_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_active` tinyint(1) NOT NULL DEFAULT '1',
  `language_css` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_layout_direction` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_language_labels` (
  `label_id` int NOT NULL,
  `label_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `label_lang_id` int NOT NULL,
  `label_caption` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `label_type` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_layout_templates` (
  `ltemplate_id` int NOT NULL,
  `ltemplate_indentifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ltemplate_type` int NOT NULL,
  `ltemplate_active` tinyint(1) NOT NULL,
  `ltemplate_deleted` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_manual_shipping_api` (
  `mshipapi_id` int NOT NULL,
  `mshipapi_sduration_id` int NOT NULL,
  `mshipapi_volume_upto` decimal(10,2) NOT NULL,
  `mshipapi_weight_upto` decimal(10,2) NOT NULL,
  `mshipapi_zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mshipapi_state_id` int NOT NULL,
  `mshipapi_country_id` int NOT NULL,
  `mshipapi_cost` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_manual_shipping_api_lang` (
  `mshipapilang_mshipapi_id` int NOT NULL,
  `mshipapilang_lang_id` int NOT NULL,
  `mshipapi_comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_meta_tags` (
  `meta_id` int NOT NULL,
  `meta_controller` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_action` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_record_id` int NOT NULL,
  `meta_subrecord_id` int NOT NULL,
  `meta_default` tinyint(1) NOT NULL,
  `meta_advanced` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_meta_tags_lang` (
  `metalang_meta_id` int NOT NULL,
  `metalang_lang_id` int NOT NULL,
  `meta_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_keywords` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_other_meta_tags` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_navigations` (
  `nav_id` int NOT NULL,
  `nav_identifier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nav_active` tinyint(1) DEFAULT NULL,
  `nav_is_multilevel` tinyint(1) NOT NULL,
  `nav_type` tinyint(1) NOT NULL,
  `nav_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_navigations_lang` (
  `navlang_nav_id` int NOT NULL,
  `navlang_lang_id` int NOT NULL,
  `nav_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_navigation_links` (
  `nlink_id` int NOT NULL,
  `nlink_nav_id` int NOT NULL,
  `nlink_cpage_id` int NOT NULL,
  `nlink_category_id` int NOT NULL,
  `nlink_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nlink_target` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nlink_type` tinyint NOT NULL,
  `nlink_parent_id` int NOT NULL,
  `nlink_login_protected` tinyint(1) NOT NULL,
  `nlink_deleted` tinyint(1) NOT NULL,
  `nlink_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nlink_display_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_navigation_links_lang` (
  `nlinklang_nlink_id` int NOT NULL,
  `nlinklang_lang_id` int NOT NULL,
  `nlink_caption` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_notifications` (
  `notification_id` bigint NOT NULL,
  `notification_record_type` int NOT NULL,
  `notification_record_id` bigint NOT NULL,
  `notification_user_id` int NOT NULL,
  `notification_marked_read` tinyint(1) NOT NULL,
  `notification_label_key` int NOT NULL,
  `notification_deleted` tinyint(1) NOT NULL,
  `notification_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_options` (
  `option_id` int NOT NULL,
  `option_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `option_seller_id` int NOT NULL,
  `option_type` int NOT NULL COMMENT 'Defined in Model',
  `option_deleted` tinyint(1) NOT NULL,
  `option_is_separate_images` tinyint(1) NOT NULL,
  `option_is_color` tinyint(1) NOT NULL,
  `option_display_in_filter` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_options_lang` (
  `optionlang_option_id` int NOT NULL,
  `optionlang_lang_id` int NOT NULL,
  `option_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_option_values` (
  `optionvalue_id` int NOT NULL,
  `optionvalue_option_id` int NOT NULL,
  `optionvalue_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `optionvalue_color_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `optionvalue_display_order` int NOT NULL,
  `optionvalue_display_in_filter` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_option_values_lang` (
  `optionvaluelang_optionvalue_id` int NOT NULL,
  `optionvaluelang_lang_id` int NOT NULL,
  `optionvalue_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_orders` (
  `order_id` bigint NOT NULL,
  `order_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_type` int NOT NULL COMMENT 'products, subscription, wallet tarns etc etc',
  `order_user_id` int NOT NULL,
  `order_payment_status` tinyint(1) NOT NULL COMMENT 'defined in order model',
  `order_status` int NOT NULL,
  `order_net_amount` decimal(10,2) NOT NULL,
  `order_is_wallet_selected` tinyint NOT NULL,
  `order_wallet_amount_charge` decimal(10,2) NOT NULL,
  `order_tax_charged` decimal(10,2) NOT NULL,
  `order_site_commission` decimal(10,2) NOT NULL,
  `order_discount_coupon_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_discount_amount_deduct_from_seller` tinyint(1) NOT NULL DEFAULT '0',
  `order_discount_type` tinyint NOT NULL,
  `order_discount_value` decimal(10,2) NOT NULL,
  `order_discount_total` decimal(10,2) NOT NULL,
  `order_discount_info` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_volume_discount_total` decimal(10,2) NOT NULL,
  `order_reward_point_used` decimal(10,2) NOT NULL,
  `order_reward_point_value` decimal(10,2) NOT NULL,
  `order_user_comments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_admin_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_language_id` int NOT NULL,
  `order_language_code` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_currency_id` int NOT NULL,
  `order_currency_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_currency_value` decimal(10,8) NOT NULL,
  `order_shippingapi_id` int NOT NULL,
  `order_shippingapi_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_pmethod_id` int NOT NULL COMMENT 'Payment method',
  `order_date_added` datetime NOT NULL,
  `order_date_updated` datetime NOT NULL,
  `order_referrer_user_id` int NOT NULL,
  `order_referrer_reward_points` int NOT NULL,
  `order_referral_reward_points` int NOT NULL,
  `order_affiliate_user_id` int NOT NULL,
  `order_affiliate_total_commission` decimal(10,2) NOT NULL,
  `order_cart_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_renew` tinyint NOT NULL,
  `order_deleted` tinyint(1) NOT NULL,
  `order_rounding_off` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_orders_lang` (
  `orderlang_order_id` bigint NOT NULL,
  `orderlang_lang_id` int NOT NULL,
  `order_shippingapi_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_orders_status` (
  `orderstatus_id` int NOT NULL,
  `orderstatus_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orderstatus_color_class` tinyint DEFAULT NULL COMMENT 'Defined in applicationConstant',
  `orderstatus_type` tinyint NOT NULL,
  `orderstatus_priority` int NOT NULL,
  `orderstatus_is_active` tinyint(1) NOT NULL,
  `orderstatus_is_digital` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_orders_status_history` (
  `oshistory_id` bigint UNSIGNED NOT NULL,
  `oshistory_order_id` bigint NOT NULL,
  `oshistory_op_id` bigint UNSIGNED NOT NULL,
  `oshistory_orderstatus_id` int NOT NULL,
  `oshistory_order_payment_status` int NOT NULL,
  `oshistory_date_added` datetime NOT NULL,
  `oshistory_customer_notified` tinyint(1) NOT NULL,
  `oshistory_tracking_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oshistory_tracking_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oshistory_courier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oshistory_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_orders_status_lang` (
  `orderstatuslang_orderstatus_id` int NOT NULL,
  `orderstatuslang_lang_id` int NOT NULL,
  `orderstatus_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_orders_to_plugin_order` (
  `opo_order_id` bigint NOT NULL,
  `opo_plugin_id` int NOT NULL,
  `opo_plugin_order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_cancel_reasons` (
  `ocreason_id` int NOT NULL,
  `ocreason_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_cancel_reasons_lang` (
  `ocreasonlang_ocreason_id` int NOT NULL,
  `ocreasonlang_lang_id` int NOT NULL,
  `ocreason_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ocreason_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_cancel_requests` (
  `ocrequest_id` int NOT NULL,
  `ocrequest_user_id` int NOT NULL,
  `ocrequest_op_id` bigint UNSIGNED NOT NULL,
  `ocrequest_ocreason_id` int NOT NULL,
  `ocrequest_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ocrequest_date` datetime NOT NULL,
  `ocrequest_status` tinyint NOT NULL,
  `ocrequest_payment_gateway_req_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ocrequest_refund_in_wallet` tinyint(1) NOT NULL COMMENT 'Defined In PaymentMethods Model',
  `ocrequest_admin_comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_extras` (
  `oextra_order_id` bigint NOT NULL,
  `order_ip_address` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_forwarded_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_accept_language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_gift_cards` (
  `ogcards_id` int NOT NULL,
  `ogcards_order_id` int NOT NULL,
  `ogcards_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ogcards_sender_id` int NOT NULL,
  `ogcards_receiver_id` int NOT NULL,
  `ogcards_receiver_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ogcards_receiver_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ogcards_status` tinyint NOT NULL,
  `ogcards_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ogcards_updated_on` datetime NOT NULL,
  `ogcards_usedon` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_payments` (
  `opayment_id` bigint NOT NULL,
  `opayment_order_id` bigint NOT NULL,
  `opayment_method` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opayment_gateway_txn_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opayment_amount` decimal(10,2) NOT NULL,
  `opayment_txn_status` tinyint NOT NULL,
  `opayment_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opayment_gateway_response` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opayment_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_products` (
  `op_id` bigint UNSIGNED NOT NULL,
  `op_order_id` bigint NOT NULL,
  `op_invoice_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_selprod_id` int UNSIGNED NOT NULL,
  `op_is_batch` tinyint(1) NOT NULL,
  `op_selprod_user_id` int NOT NULL,
  `op_selprod_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'code algo defined in seller_products table',
  `op_batch_selprod_id` int UNSIGNED NOT NULL,
  `op_qty` int NOT NULL,
  `op_selprod_price` decimal(10,2) NOT NULL,
  `op_unit_price` decimal(10,2) NOT NULL,
  `op_unit_cost` decimal(10,2) NOT NULL,
  `op_selprod_sku` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_commission_charged` decimal(10,2) NOT NULL,
  `op_commission_percentage` decimal(10,2) NOT NULL,
  `op_affiliate_commission_charged` decimal(10,2) NOT NULL,
  `op_affiliate_commission_percentage` decimal(10,2) NOT NULL,
  `op_selprod_condition` int NOT NULL,
  `op_product_model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_product_type` int NOT NULL COMMENT 'physical,digital defined in model',
  `op_product_length` decimal(10,2) NOT NULL,
  `op_product_width` decimal(10,2) NOT NULL,
  `op_product_height` decimal(10,2) NOT NULL,
  `op_product_dimension_unit` int NOT NULL,
  `op_product_weight` decimal(10,2) NOT NULL,
  `op_product_weight_unit` int NOT NULL,
  `op_shop_id` int NOT NULL,
  `op_shop_owner_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_shop_owner_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_shop_owner_email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_shop_owner_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_shop_owner_phone` bigint NOT NULL,
  `op_sduration_id` int NOT NULL,
  `op_status_id` int NOT NULL,
  `op_refund_qty` int NOT NULL,
  `op_refund_amount` decimal(10,2) NOT NULL,
  `op_refund_commission` decimal(10,2) NOT NULL,
  `op_refund_shipping` decimal(10,2) NOT NULL,
  `op_refund_tax` decimal(10,2) NOT NULL,
  `op_refund_affiliate_commission` decimal(10,2) NOT NULL,
  `op_shipped_date` datetime NOT NULL,
  `op_completion_date` datetime NOT NULL,
  `op_sent_review_reminder` int NOT NULL,
  `op_review_reminder_count` int NOT NULL,
  `op_sent_last_reminder` date NOT NULL,
  `op_selprod_max_download_times` int NOT NULL,
  `op_selprod_download_validity_in_days` int NOT NULL,
  `op_free_ship_upto` int NOT NULL,
  `op_actual_shipping_charges` float NOT NULL,
  `op_tax_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_rounding_off` decimal(4,2) NOT NULL,
  `op_comments` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_products_lang` (
  `oplang_op_id` bigint UNSIGNED NOT NULL,
  `oplang_lang_id` int NOT NULL,
  `op_product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_selprod_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_selprod_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_brand_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_shop_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_shipping_duration_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_shipping_durations` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_products_dimension_unit_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_product_weight_unit_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `op_product_tax_options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_charges` (
  `opcharge_id` int NOT NULL,
  `opcharge_order_type` int NOT NULL,
  `opcharge_op_id` bigint UNSIGNED NOT NULL,
  `opcharge_type` int NOT NULL,
  `opcharge_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_charges_lang` (
  `opchargelang_opcharge_id` int NOT NULL,
  `opchargelang_lang_id` int NOT NULL,
  `opcharge_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_product_digital_download_links` (
  `opddl_link_id` int NOT NULL,
  `opddl_op_id` bigint UNSIGNED NOT NULL,
  `opddl_downloadable_link` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opddl_downloaded_times` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_plugin_specifics` (
  `opps_op_id` bigint UNSIGNED NOT NULL,
  `opps_plugin_id` int NOT NULL,
  `opps_synced` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_product_responses` (
  `opr_op_id` bigint UNSIGNED NOT NULL,
  `opr_type` int NOT NULL,
  `opr_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opr_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_settings` (
  `opsetting_op_id` bigint UNSIGNED NOT NULL,
  `op_commission_include_tax` tinyint(1) NOT NULL,
  `op_commission_include_shipping` tinyint(1) NOT NULL,
  `op_tax_collected_by_seller` tinyint(1) NOT NULL,
  `op_tax_after_discount` tinyint(1) NOT NULL DEFAULT '0',
  `op_product_inclusive_tax` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_shipment` (
  `opship_op_id` bigint UNSIGNED NOT NULL,
  `opship_orderid` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'From third party',
  `opship_order_number` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'From third party',
  `opship_shipment_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opship_tracking_number` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opship_tracking_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opship_tracking_courier_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opship_tracking_plugin_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_shipment_pickup` (
  `opsp_op_id` bigint UNSIGNED NOT NULL,
  `opsp_api_req_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'From third party',
  `opsp_scheduled` tinyint NOT NULL COMMENT 'Scheduled/cancelled',
  `opsp_requested_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'For third party',
  `opsp_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'From third party'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_product_shipping` (
  `opshipping_op_id` bigint UNSIGNED NOT NULL,
  `opshipping_fulfillment_type` tinyint NOT NULL DEFAULT '2' COMMENT 'Defined in model',
  `opshipping_plugin_id` int NOT NULL COMMENT 'plugin use to fetch rates',
  `opshipping_is_seller_plugin` tinyint NOT NULL COMMENT 'is seller plugin use to fetch rates ',
  `opshipping_plugin_charges` decimal(10,2) NOT NULL COMMENT 'shipping rate fetch from plugin',
  `opshipping_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opshipping_rate_id` int NOT NULL,
  `opshipping_by_seller_user_id` int NOT NULL,
  `opshipping_level` int NOT NULL,
  `opshipping_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opshipping_carrier_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opshipping_service_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opshipping_pickup_addr_id` bigint UNSIGNED NOT NULL,
  `opshipping_date` date NOT NULL,
  `opshipping_time_slot_from` time NOT NULL,
  `opshipping_time_slot_to` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_shipping_lang` (
  `opshippinglang_op_id` bigint UNSIGNED NOT NULL,
  `opshippinglang_lang_id` int NOT NULL,
  `opshipping_title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opshipping_duration` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opshipping_duration_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_specifics` (
  `ops_op_id` bigint UNSIGNED NOT NULL,
  `op_selprod_return_age` int NOT NULL COMMENT 'In Days',
  `op_selprod_cancellation_age` int NOT NULL COMMENT 'In Days',
  `op_product_warranty` int NOT NULL COMMENT 'In Days',
  `op_prodcat_id` bigint NOT NULL,
  `op_special_price` decimal(10,2) NOT NULL,
  `op_product_custom_instruction` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_product_to_shipping_users` (
  `optsu_op_id` bigint UNSIGNED NOT NULL,
  `optsu_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_prod_charges_logs` (
  `opchargelog_id` int NOT NULL,
  `opchargelog_op_id` bigint UNSIGNED NOT NULL,
  `opchargelog_type` int NOT NULL,
  `opchargelog_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opchargelog_value` decimal(10,2) NOT NULL,
  `opchargelog_is_percent` tinyint NOT NULL,
  `opchargelog_percentvalue` decimal(10,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_prod_charges_logs_lang` (
  `opchargeloglang_opchargelog_id` int NOT NULL,
  `opchargeloglang_op_id` bigint UNSIGNED NOT NULL,
  `opchargeloglang_lang_id` int NOT NULL,
  `opchargelog_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_return_reasons` (
  `orreason_id` int NOT NULL,
  `orreason_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_return_reasons_lang` (
  `orreasonlang_orreason_id` int NOT NULL,
  `orreasonlang_lang_id` int NOT NULL,
  `orreason_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orreason_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_order_return_requests` (
  `orrequest_id` int NOT NULL,
  `orrequest_user_id` int NOT NULL,
  `orrequest_reference` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orrequest_op_id` bigint UNSIGNED NOT NULL,
  `orrequest_qty` int NOT NULL,
  `orrequest_returnreason_id` int NOT NULL,
  `orrequest_type` int NOT NULL COMMENT 'defined in model',
  `orrequest_date` datetime NOT NULL,
  `orrequest_status` int NOT NULL COMMENT 'defined in model',
  `orrequest_payment_gateway_req_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orrequest_refund_in_wallet` tinyint(1) NOT NULL COMMENT 'Defined In PaymentMethods Model',
  `orrequest_admin_comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_return_request_messages` (
  `orrmsg_id` int NOT NULL,
  `orrmsg_orrequest_id` int NOT NULL,
  `orrmsg_from_user_id` int NOT NULL,
  `orrmsg_from_admin_id` int NOT NULL,
  `orrmsg_msg` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orrmsg_date` datetime NOT NULL,
  `orrmsg_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_seller_subscriptions` (
  `ossubs_id` int NOT NULL,
  `ossubs_type` int NOT NULL,
  `ossubs_plan_id` int NOT NULL,
  `ossubs_order_id` bigint NOT NULL,
  `ossubs_status_id` int NOT NULL,
  `ossubs_images_allowed` int NOT NULL,
  `ossubs_products_allowed` int NOT NULL,
  `ossubs_inventory_allowed` int NOT NULL,
  `ossubs_interval` int NOT NULL,
  `ossubs_frequency` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ossubs_commission` decimal(10,2) NOT NULL,
  `ossubs_invoice_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ossubs_price` decimal(10,2) NOT NULL,
  `ossubs_from_date` date NOT NULL,
  `ossubs_till_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_seller_subscriptions_lang` (
  `ossubslang_ossubs_id` int NOT NULL,
  `ossubslang_lang_id` int NOT NULL,
  `ossubs_subscription_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_order_user_address` (
  `oua_order_id` bigint NOT NULL,
  `oua_op_id` bigint UNSIGNED NOT NULL,
  `oua_type` tinyint NOT NULL COMMENT '1=>Billing Address, 2=> Shipping Address defined in model',
  `oua_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_address1` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_address2` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_state_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_country_code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_country_code_alpha3` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `oua_phone` bigint NOT NULL,
  `oua_zip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_pages_language_data` (
  `plang_id` int NOT NULL,
  `plang_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plang_lang_id` int NOT NULL,
  `plang_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plang_summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plang_warring_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plang_recommendations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plang_replacements` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plang_helping_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_plugins` (
  `plugin_id` int NOT NULL,
  `plugin_identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plugin_type` int NOT NULL,
  `plugin_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plugin_active` tinyint(1) NOT NULL,
  `plugin_display_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_plugins_lang` (
  `pluginlang_plugin_id` int NOT NULL,
  `pluginlang_lang_id` int NOT NULL,
  `plugin_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plugin_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_plugin_settings` (
  `pluginsetting_plugin_id` int NOT NULL,
  `pluginsetting_record_id` int NOT NULL,
  `pluginsetting_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pluginsetting_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_plugin_to_user` (
  `pu_plugin_id` int NOT NULL,
  `pu_user_id` int NOT NULL,
  `pu_active` tinyint NOT NULL,
  `pu_created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_policy_points` (
  `ppoint_id` int NOT NULL,
  `ppoint_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ppoint_type` int NOT NULL,
  `ppoint_display_order` int NOT NULL,
  `ppoint_active` tinyint(1) NOT NULL,
  `ppoint_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_policy_points_lang` (
  `ppointlang_ppoint_id` int NOT NULL,
  `ppointlang_lang_id` int NOT NULL,
  `ppoint_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_polling` (
  `polling_id` int NOT NULL,
  `polling_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `polling_type` int NOT NULL,
  `polling_start_date` datetime NOT NULL,
  `polling_end_date` datetime NOT NULL,
  `polling_active` tinyint(1) NOT NULL,
  `polling_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_polling_feedback` (
  `pollfeedback_id` int NOT NULL,
  `pollfeedback_polling_id` int NOT NULL,
  `pollfeedback_response_type` int NOT NULL,
  `pollfeedback_response_ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pollfeedback_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_polling_lang` (
  `pollinglang_polling_id` int NOT NULL,
  `pollinglang_lang_id` int NOT NULL,
  `polling_question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_polling_to_category` (
  `ptc_polling_id` int NOT NULL,
  `ptc_prodcat_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_polling_to_products` (
  `ptp_polling_id` int NOT NULL,
  `ptp_product_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_prodcat_rating_types` (
  `prt_prodcat_id` bigint NOT NULL,
  `prt_ratingtype_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_products` (
  `product_id` int UNSIGNED NOT NULL,
  `product_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_attrgrp_id` int NOT NULL,
  `product_type` int NOT NULL COMMENT 'Physical, digital. Defined in model',
  `product_attachements_with_inventory` tinyint(1) NOT NULL DEFAULT '0',
  `product_model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_brand_id` int NOT NULL,
  `product_added_by_admin_id` int NOT NULL,
  `product_seller_id` int NOT NULL COMMENT 'used to handle custom products, directly entered by seller',
  `product_is_invoice` tinyint NOT NULL,
  `product_length` decimal(10,2) NOT NULL,
  `product_width` decimal(10,2) NOT NULL,
  `product_height` decimal(10,2) NOT NULL,
  `product_dimension_unit` int NOT NULL,
  `product_weight` decimal(10,2) NOT NULL,
  `product_weight_unit` int NOT NULL,
  `product_added_on` datetime NOT NULL,
  `product_img_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `product_custom_instruction` tinyint NOT NULL,
  `product_featured` tinyint NOT NULL,
  `product_active` tinyint NOT NULL,
  `product_approved` tinyint NOT NULL DEFAULT '0' COMMENT 'needed for custom products mostly',
  `product_fulfillment_type` int NOT NULL,
  `product_upc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_isbn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_ship_country` int NOT NULL,
  `product_ship_free` tinyint NOT NULL,
  `product_cod_enabled` tinyint(1) NOT NULL,
  `product_min_selling_price` decimal(12,4) NOT NULL,
  `product_deleted` tinyint(1) NOT NULL,
  `product_ship_package` int NOT NULL,
  `product_rating` float(10,2) NOT NULL,
  `product_total_reviews` int NOT NULL,
  `product_updated_on` datetime NOT NULL,
  `product_vector_synced` tinyint(1) NOT NULL DEFAULT '0',
  `product_ai_enrichment` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_products_browsing_history` (
  `pbhistory_id` bigint NOT NULL,
  `pbhistory_sessionid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pbhistory_selprod_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pbhistory_swsetting_key` int NOT NULL,
  `pbhistory_user_id` int NOT NULL,
  `pbhistory_product_id` int UNSIGNED NOT NULL,
  `pbhistory_count` int NOT NULL,
  `pbhistory_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_products_lang` (
  `productlang_product_id` int UNSIGNED NOT NULL,
  `productlang_lang_id` int NOT NULL,
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_short_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_tags_string` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_youtube_video` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

(11239, 1, 'Dreamsicle Goat\'s Milk Soap', '', '<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Our nourishing Goat\'s Milk Soap is hand poured and made in small batches. We make only make six soaps of each scent at a time.&nbsp; This means our soap never sits on a shelf for a long period of time and are always fresh.&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Benefits of using Goat\'s Milk:</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Gentle Cleanser</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Rich in good for you nutrients</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Natural Exfoliant</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Ingredients: goat\'s milk soap, skin safe dye, and skin safe fragrance</div>', 'Emerald City Suds', ''),
(11240, 1, 'Rainbow Fruit Slices  Goat\'s Milk Soap ', '', '\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Our nourishing Goat\'s Milk Soap is hand poured and made in small batches. We make only make six soaps of each scent at a time.&nbsp; This means our soap never sits on a shelf for a long period of time and are always fresh.&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Benefits of using Goat\'s Milk:</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Gentle Cleanser</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Rich in good for you nutrients</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Natural Exfoliant</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Ingredients: goat\'s milk soap, skin safe dye, and skin safe fragrance</div>', 'Emerald City Suds', ''),
(11241, 1, 'Spearmint Goat\'s Milk Soap', '', '<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Our nourishing Goat\'s Milk Soap is hand poured and made in small batches. We make only make six soaps of each scent at a time.&nbsp; This means our soap never sits on a shelf for a long period of time and are always fresh.&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Benefits of using Goat\'s Milk:</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Gentle Cleanser</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Rich in good for you nutrients</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Natural Exfoliant</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Ingredients: goat\'s milk soap, skin safe dye, and skin safe fragrance</div>', 'Emerald City Suds', ''),
(11242, 1, 'Green Apple Goat\'s Milk Soap ', '', '\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Our nourishing Goat\'s Milk Soap is hand poured and made in small batches. We make only make six soaps of each scent at a time.&nbsp; This means our soap never sits on a shelf for a long period of time and are always fresh.&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Benefits of using Goat\'s Milk:</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Gentle Cleanser</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Rich in good for you nutrients</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Natural Exfoliant</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Ingredients: goat\'s milk soap, skin safe dye, and skin safe fragrance</div>', 'Emerald City Suds', ''),
(11243, 1, 'Lemoncello  Goat\'s Milk Soap ', '', '\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Our nourishing Goat\'s Milk Soap is hand poured and made in small batches. We make only make six soaps of each scent at a time.&nbsp; This means our soap never sits on a shelf for a long period of time and are always fresh.&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Benefits of using Goat\'s Milk:</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Gentle Cleanser</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Rich in good for you nutrients</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Natural Exfoliant</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Ingredients: goat\'s milk soap, skin safe dye, and skin safe fragrance</div>', 'Emerald City Suds', ''),
(11244, 1, 'Sunshine Passionfruit Goat\'s Milk Soap', '', '<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Our nourishing Goat\'s Milk Soap is hand poured and made in small batches. We make only make six soaps of each scent at a time.&nbsp; This means our soap never sits on a shelf for a long period of time and are always fresh.&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Benefits of using Goat\'s Milk:</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Gentle Cleanser</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Rich in good for you nutrients</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Natural Exfoliant</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Ingredients: goat\'s milk soap, skin safe dye, and skin safe fragrance</div>', 'Emerald City Suds', ''),
(11245, 1, 'Black Ice Goat\'s Milk Soap', '', '<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Our nourishing Goat\'s Milk Soap is hand poured and made in small batches. We make only make six soaps of each scent at a time.&nbsp; This means our soap never sits on a shelf for a long period of time and are always fresh.&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Benefits of using Goat\'s Milk:</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Gentle Cleanser</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Rich in good for you nutrients</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Natural Exfoliant</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">&nbsp;</div>\n <div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 16px; background-color: rgb(255, 255, 255); text-align: center;\">Ingredients: goat\'s milk soap, skin safe dye, and skin safe fragrance</div>', 'Emerald City Suds', '');
(12250, 1, 'Cashmere Sugar car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Experience pure comfort with Cashmere Sugar, a luxurious blend of soft cashmere, warm amber, and spun sugar. Let the soothing scents of jasmine, tea rose, and pink peppercorn transport you to a state of ultimate relaxation.&nbsp;</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12251, 1, 'Sweet Strawberry car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Highlights of fresh, sweet strawberries, berries, and sugar</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12252, 1, 'High Tide car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Discover the captivating scent of High Tide, inspired by the fresh, ozonic ocean tide rolling up a rocky shoreline. Breathe in the revitalizing aroma of ozonic ocean air, layered with notes of citrus zest, jasmine, sea salt, violet petals, powdered musk, and cedar leaf. Feel refreshed and energized with every use.</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12253, 1, 'Fruit Loops car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">A nostalgic and delicious aroma that smells exactly like a bowl of cereal! The kids are going to love it!</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12254, 1, 'Fruit Loops car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">A nostalgic and delicious aroma that smells exactly like a bowl of cereal! The kids are going to love it!</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12255, 1, 'Sugar Cookie car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">A mouthwatering aroma of fresh baked sugar cookies with hints of vanilla and butter.</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12256, 1, 'Cherry Lemonade', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Savor the taste of summer with our Cherry Lemonade. Made with a lively and refreshing blend of tart cherries and freshly squeezed lemon</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12257, 1, 'Cashmere Sugar car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Experience pure comfort with Cashmere Sugar, a luxurious blend of soft cashmere, warm amber, and spun sugar. Let the soothing scents of jasmine, tea rose, and pink peppercorn transport you to a state of ultimate relaxation.</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12258, 1, 'Cosmic Berry car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">This unique blend of beauty berry, blackberry, and raspberry is complemented by smooth coconut, delicate florals, and sugared musk.&nbsp;</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12259, 1, 'Cherry Lemonade car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Savor the taste of summer with our Cherry Lemonade. Made with a lively and refreshing blend of tart cherries and freshly squeezed lemon.</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 15px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12260, 1, 'Summer Linen car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Fresh soft cotton tones and succulent white peach notes intertwine with clean lavender and creamy coconut scents. These blend together to unite this fragrant accord.</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12261, 1, 'Pink Sangria', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Infused with juicy raspberries, has a lusciously sweet finish with a tropical blend of red wine, pineapple, grapefruit, and cherries on top.&nbsp;</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12262, 1, 'Cosmic Berry car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">This unique blend of beauty berry, blackberry, and raspberry is complemented by smooth coconut, delicate florals, and sugared musk.&nbsp;</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12263, 1, 'Pineapple Sunrise car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">A warm, island blend of juicy pineapple, coconut and crisp lime.</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12264, 1, 'Soothing Sea car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Indulge in the refreshing and tranquil experience of our Soothing Sea wax melt. The clean, oceanic scent combines fresh lemon, oranges, and sea salt with hints of jasmine and musk for a perfectly balanced fragrance.</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12265, 1, 'Soothing Sea car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Indulge in the refreshing and tranquil experience of our Soothing Sea wax melt. The clean, oceanic scent combines fresh lemon, oranges, and sea salt with hints of jasmine and musk for a perfectly balanced fragrance</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12266, 1, 'Volcano car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Expertly crafted with a blend of tropical fruits, citrus, and bursting greenery, this scent will transport you to a tropical paradise.&nbsp;</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12267, 1, 'Creme Brulee', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Indulge in the decadent flavors of our Crème Brûl&eacute;e. Experience the perfect combination of sweet and tropical notes with a creamy custard center, elevated by a touch of Rum.&nbsp;</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12268, 1, 'Soothing Sea car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Indulge in the refreshing and tranquil experience of our Soothing Sea wax melt. The clean, oceanic scent combines fresh lemon, oranges, and sea salt with hints of jasmine and musk for a perfectly balanced fragrance</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12269, 1, 'Soothing Sea car freshie', '', '\r\n<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Indulge in the refreshing and tranquil experience of our Soothing Sea wax melt. The clean, oceanic scent combines fresh lemon, oranges, and sea salt with hints of jasmine and musk for a perfectly balanced fragrance</span></div>\r\n<div>&nbsp;</div>\r\n<div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12270, 1, 'Fruit Loops car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">A nostalgic and delicious aroma that smells exactly like a bowl of cereal! The kids are going to love it!</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12271, 1, 'Fruit Loops car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">A nostalgic and delicious aroma that smells exactly like a bowl of cereal! The kids are going to love it!</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12272, 1, 'Volcano car freshie', '', '<div><span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">Expertly crafted with a blend of tropical fruits, citrus, and bursting greenery, this scent will transport you to a tropical paradise.&nbsp;</span></div>\n <div>&nbsp;</div>\n <div><span style=\"color: rgb(33, 37, 41); font-family: Lato; font-size: 14px; background-color: rgb(255, 255, 255);\">Hang these in you car, office, closet, bathroom. Scent can last anywhere from six weeks!</span></div>', 'Doodles Creations', ''),
(12273, 1, 'Bellini Sunrise wax melt crumbles ', '', '\r\n<p style=\"box-sizing: inherit; margin-top: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">Experience the perfect blend of sweet and refreshing with our Bellini Sunrise custom wax melt. Enjoy the aroma of freshly picked peaches, coconut, and violet petals, with hints of orange and vanilla. Immerse yourself in a coastal walk at sunset with notes of lemon, marine air, and sea greens.&nbsp;<br style=\"box-sizing: inherit;\" />\r\n		</span></p>\r\n<p style=\"box-sizing: inherit; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">****PACKAGING WILL VARY</span></p>', 'Doodles Creations', ''),
(12274, 1, 'Ruby Red Martini wax melt crumbles', '', '\r\n<p style=\"box-sizing: inherit; margin-top: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">With bright top notes of ruby red grapefruit, yuzu, and lemon zest, this martini brings a zesty punch. The heart blooms with rosewater, pomegranate, and jasmine petals while the base of musk, amber, and sandalwood ground the luxurious fragrance.&nbsp;<br style=\"box-sizing: inherit;\" />\r\n		</span></p>\r\n<p style=\"box-sizing: inherit; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"font-weight: bold;\"><span style=\"box-sizing: inherit;\">Top notes:</span><span style=\"box-sizing: inherit;\">&nbsp;Ruby Red Grapefruit, Yuzu, Lemon Zest</span></span></p>\r\n<p style=\"box-sizing: inherit; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\"><span style=\"box-sizing: inherit;\">Middle notes:</span>&nbsp;Rosewater, Pomegranate, Jasmine Petals</span></p>\r\n<p style=\"box-sizing: inherit; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"font-weight: bold;\"><span style=\"box-sizing: inherit;\"><span style=\"box-sizing: inherit;\">Base notes:</span>&nbsp;Musk, Amber, Sandalwood</span><span style=\"box-sizing: inherit;\">&nbsp;</span></span></p>\r\n<p style=\"box-sizing: inherit; margin-bottom: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">****PACKAGING WILL VARY</span></p>', 'Doodles Creations', ''),
(12275, 1, 'Saltwater Taffy wax melt crumbles', '', '<p style=\"box-sizing: inherit; margin-top: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">Experience the refreshing scent of a warm summer day with our Saltwater Taffy wax melt. Our custom blend captures the true aroma of fresh, ozonic ocean air and blends it with sweet berries, delicate florals, and playful notes of cotton candy, licorice, and powdered musk.&nbsp;<br style=\"box-sizing: inherit;\" />\n   </span></p>\n <p style=\"box-sizing: inherit; margin-bottom: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">****PACKAGING WILL VERY</span></p>', 'Doodles Creations', ''),
(12276, 1, 'Surfer Girl wax melt crumbles', '', '<p style=\"box-sizing: inherit; margin-top: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">Introducing Surfer Girl, a refreshing blend of tart cherries and fresh squeezed lemons. Experience a perfectly balanced aroma reminiscent of a classic summer refreshment. As you melt this wax, be captivated by the fresh, ozonic scent of ocean tide rolling along a rocky shoreline. Perfect for creating a relaxing beach-like atmosphere at home.</span></p>\n <p style=\"box-sizing: inherit; margin-bottom: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">****PACKAGING WILL VARY</span></p>', 'Doodles Creations', ''),
(12277, 1, 'Summer Market wax melt crumbles', '', '<p style=\"box-sizing: inherit; margin-top: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">Experience the perfect summer blend with Summer Market. Our custom wax melt combines exotic tropical fruits, zesty citrus, and refreshing greenery for a vibrant aroma. Enjoy notes of juicy strawberries, sweet berries, and a touch of sugar - all in one melting sensation.</span></p>\n <p style=\"box-sizing: inherit; margin-bottom: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">****PACKAGING WILL VARY</span></p>', 'Doodles Creations', ''),
(12278, 1, 'Pineapple Sunrise wax melt crumbles', '', '<span style=\"color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226); font-weight: bold;\">A warm, island blend of juicy pineapple, coconut and crisp lime.</span>', 'Doodles Creations', ''),
(12279, 1, 'Scarlet Noir wax melt crumbles', '', '<p style=\"box-sizing: inherit; margin-top: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">Scarlet Noir is an exquisite fragrance with a perfect blend of red currant and wild honey, followed by a touch of smoked coconut and saffron. The base notes of vanilla noir, sandalwood, and white musk add a warm and sensual touch, making it ideal for any occasion.</span></p>\n <p style=\"box-sizing: inherit; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"font-weight: bold;\"><span style=\"box-sizing: inherit;\">Top notes:</span>&nbsp;<span style=\"box-sizing: inherit;\">Red Currant, Wild Honey</span></span></p>\n <p style=\"box-sizing: inherit; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\"><span style=\"box-sizing: inherit;\">Middle notes:</span>&nbsp;Smoked Coconut, Saffron</span></p>\n <p style=\"box-sizing: inherit; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\"><span style=\"box-sizing: inherit;\">Base notes:</span>&nbsp;Vanilla Noir, Sandalwood, White Musk</span></p>\n <p style=\"box-sizing: inherit; margin-bottom: 0px; color: rgba(18, 18, 18, 0.75); font-family: Assistant, sans-serif; font-size: 16px; letter-spacing: 0.6px; background-color: rgb(231, 209, 226);\"><span style=\"box-sizing: inherit; font-weight: bold;\">****PACKAGING WILL VARY</span></p>', 'Doodles Creations', '');
(13312, 1, 'Ghostie', '', '\r\n<div>5” mosaic on wood ghosts</div>\r\n<div>&nbsp;option 1: white ghost with purple, black, green, &amp; orange stripe</div>\r\n<div>&nbsp;option 2: ghost with light blue &amp; pink polka dots</div>\r\n<div>&nbsp;option 3: iridescent white ghost with sparkly purple stripes</div>\r\n<div>&nbsp;option 4: sparkly white &amp; green ghost</div>\r\n<div>&nbsp;</div>\r\n<div>\r\n	<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 17px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Each piece of glass is individually hand-cut and assembled by me, ensuring attention to detail throughout the process. Once completed, the piece is finished with grout and a protective sealant. The wooden bases are sourced from 24HourCrafts.</span></p>\r\n	<p class=\"p2\" style=\"margin: 0px; font-width: normal; font-size: 17px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; min-height: 22px; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\"></span><br />\r\n		</p>\r\n	<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 17px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Custom colors and sizes are available upon request. Pricing is determined by size.</span></p>\r\n	<p class=\"p2\" style=\"margin: 0px; font-width: normal; font-size: 17px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; min-height: 22px; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\"></span><br />\r\n		</p>\r\n	<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 17px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s2\" style=\"font-family: UICTFontTextStyleEmphasizedBody; font-weight: bold;\">Please Note:</span><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;While every effort is made to closely replicate the item shown in the photo, slight variations are inevitable due to the nature of hand-cut glass. No two pieces will ever be identical, making each one a truly unique, one-of-a-kind creation.</span></p></div>  ', 'The Artsy Cat LLC', ''),
(13313, 1, 'Driftwood and Bead Sun Catcher - \"A Nonsense Christmas\" ', '', '\r\n<div><strong data-start=\"133\" data-end=\"217\">Driftwood and Bead Sun Catcher titled \"A Nonsense Christmas\" – Sabrina Carpenter</strong></div>\r\n<div><br />\r\n	</div>Bright pops of holly red, fresh green, and pearl white dance along driftwood foraged from the shores of Narragansett Bay. Finished with whimsical bell flower charms in red and green, this piece is playful and full of holiday cheer. Hang it in a sunny window or gift it to someone who loves a dash of seasonal sparkle.\r\n', 'green | Suncatcher | sun catcher | christmas | hang on design | red | sun | driftwood | Sparkle | beads | holiday', ''),
(13314, 1, 'Driftwood and Bead Sun Catcher - \"Candy Cane Christmas\" ', '', '\r\n<div><strong data-start=\"541\" data-end=\"621\">Driftwood and Bead Sun Catcher titled \"Candy Cane Christmas\" – Darius Rucker</strong></div>\r\n<div><br />\r\n	</div>From deep crimson to shimmering crystal, this strand of bold reds and frosty whites is strung on driftwood foraged from Narragansett Bay. The candy cane charm at the base makes it a sweet nod to the season, perfect for kitchens, porches, or as a stocking stuffer. A cheerful treat for the eyes year after year.\r\n ', 'nautical | hang on design | boho | coastal | rustic | holiday | driftwood sun catcher | bead sun catcher | hanging sun catcher | mobile | Christmas decor | Festive | ocean-inspired', ''),
(13315, 1, 'Driftwood and Bead Sun Catcher - \"Christmas All Over Again\"', '', '\r\n<div><strong data-start=\"938\" data-end=\"1018\">Driftwood and Bead Sun Catcher titled \"Christmas All Over Again\" – Tom Petty</strong></div>\r\n<div><br />\r\n	</div>A jolly mix of red, green, and gold beads drape from driftwood found along Narragansett Bay, ending with a glittering Santa charm. This festive piece captures the warmth of tradition with a touch of sparkle. Great for greeting guests in your entryway or brightening up a holiday display. ', 'green | ocean | hang on design | red | coastal | boho decor | rustic | driftwood sun catcher | bead sun catcher | hanging sun catcher | mobile | Christmas decor | Festive', ''),
(13316, 1, 'Driftwood and Bead Sun Catcher - \"Let It Snow\"', '', '<div><strong data-start=\"1312\" data-end=\"1381\">Driftwood and Bead Sun Catcher titled \"Let It Snow\" – Diana Krall</strong></div>\n<div><br />\n	</div>Snowy whites, evergreen greens, and ruby reds shimmer along driftwood foraged from Narragansett Bay. Finished with a faceted snowman charm, it feels like a cozy winter day captured in beads. Ideal for windows, mantels, or any space that could use a gentle holiday glow.', 'green | ocean | hang on design | red | boho | coastal | rustic | driftwood sun catcher | bead sun catcher | mobile | Christmas decor | Festive', ''),
(13317, 1, 'Fall Vibes - Waffle Weave Towel', '', '<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🍂✨ Bring the cozy season into your kitchen with our \"Fall Vibes” waffle weave towel! 🍂✨</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Perfect for adding a touch of autumn charm, this high-quality microfiber towel features a chic leopard print bow on a pumpkin design that screams stylish fall farmhouse. 🍁</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🧡 Super absorbent &amp; quick drying</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🧡 Vibrant, long-lasting design</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🧡 Great gift for fall lovers or a treat for yourself</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">$10 each – custom designs available upon request!</span></p>\n<div><span style=\"font-kerning: none;\"><br />\n		</span></div>', 'Fall decor | Farmhouse Kitchen | kitchen towel | DESIGNS BY DEVINE | Pumpkin Season | fallvibes | seasonal decor | autumn vibes', ''),
(13318, 1, 'Driftwood and Bead Sun Catcher - \"Lil Snowman\"', '', '\r\n<div><strong data-start=\"1657\" data-end=\"1727\">Driftwood and Bead Sun Catcher titled \"Lil Snowman\" – Mariah Carey</strong></div>\r\n<div><br />\r\n	</div>Soft greens, bright reds, and shimmering whites dangle from handpicked driftwood found along Narragansett Bay. A small snowman charm adds a playful, frosty touch, perfect for bringing joy to kids’ rooms, kitchen windows, or holiday vignettes. A little snowman that works year-round. ', 'green | christmas | ocean | hang on design | red | boho | coastal | rustic | holiday | driftwood sun catcher | bead sun catcher | hanging sun catcher | mobile | Festive', ''),
(13319, 1, 'Driftwood and Bead Sun Catcher - \"Winter Snow\"', '', '\r\n<div><strong data-start=\"2368\" data-end=\"2438\">Driftwood and Bead Sun Catcher titled \"Winter Snow\" – Chris Tomlin</strong></div>\r\n<div><br />\r\n	</div>Frosty blues, icy whites, and touches of silver shimmer from natural driftwood found on the shores of Narragansett Bay. The strand’s cool tones capture the peaceful stillness of a snowy day, while a vintage-style blue bulb charm glows softly in the light. A serene addition to any winter window.\r\n', 'hang on design', ''),
(13320, 1, 'Driftwood and Bead Sun Catcher - \"Winter Things\"', '', '\r\n<div><strong data-start=\"2740\" data-end=\"2813\">Driftwood and Bead Sun Catcher titled \"Winter Things\" – Ariana Grande</strong></div>\r\n<div><br />\r\n	</div>A playful mix of icy blue, snowy white, and deep midnight beads flows from driftwood foraged from Narragansett Bay. The glossy blue light bulb charm at the base adds a retro, cozy-winter feel. Perfect for lovers of frosty mornings and twinkling holiday nights.\r\n', 'green | ocean | hang on design | red | boho | coastal | rustic | holiday | driftwood sun catcher | bead sun catcher | mobile | Christmas decor | Festive', ''),
(13321, 1, 'beautiful kitty trinket dish', '', 'a beautiful dish adorned with kittens playing in the flowers.&nbsp; this dish is approximately 3x4\", perfect for your trinkets and treasures.', 'Trinket | Cat | Kitty | ginger snappy gems | trinket dish', ''),
(13322, 1, 'gorgeous moon shaped trinket  dish', '', 'this beautiful trinket dish features swirls and stars, with dimensions of approx 3\"x4\".', 'Trinket | Moon | ginger snappy gems | trinket dish', ''),
(13323, 1, 'Fall Crescent Moon - Windspinner', '', '<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 20px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🍂✨ Add a touch of autumn magic to your yard!</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 20px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Our 10” Fall WindSpinner features a stunning crescent moon surrounded by pumpkins, sunflowers, and rich fall colors that come alive as it spins in the breeze. Perfect for gardens, porches, or as a unique seasonal gift.</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 20px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🎃 Weather-resistant</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 20px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🌻 Vibrant double-sided design</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 20px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🍁 Ready to hang and enjoy</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 20px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Bring your outdoor space to life this fall — order yours today before they’re gone! 🍂</span></p>\n<div><span style=\"font-kerning: none;\"><br />\n		</span></div>', 'DESIGNS BY DEVINE', ''),
(13324, 1, 'bellyconrad tshirt', '', '<pre data-hook=\"description\" class=\"skK8UF\" style=\"background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box; text-wrap-mode: wrap; overflow-wrap: break-word; word-break: break-word; text-overflow: ellipsis; color: rgb(49, 53, 61); font-size: 14px;\">\n	<p style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box; white-space-collapse: collapse;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">he gave me the moon and the stars. infinity.&nbsp;</span></p>\n	<p style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box; white-space-collapse: collapse;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">&nbsp;</span></p>\n	<p style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box; white-space-collapse: collapse;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">shirt color: light blue</span></p></pre>\n<div>&nbsp;</div>\n<div style=\"font-size: 14px;\">\n	<p style=\"background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; line-height: inherit; color: rgb(49, 53, 61);\"><span style=\"font-weight: bold; font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Details:&nbsp;</span></p>\n	<ul style=\"background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px 0px 0px 1em; outline: 0px; padding: 0px 0px 0px 40px; vertical-align: baseline; list-style: circle; box-sizing: border-box; padding-inline: revert; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; line-height: inherit; color: rgb(49, 53, 61);\">\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Gildan Softstyle 4.5 oz (TShirt)</span></li>\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Unisex Sizing</span></li>\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Made with DTF</span></li>\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Wash with cold water ONLY</span></li>\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Low tumble dry heat, DO NOT iron</span></li>\n	</ul><br />\n	</div>', 'tshirt | tv shows | bymariamichele | tsitp | the summer i turned pretty | bellyconrad | bonrad', ''),
(13325, 1, 'gilmore girls (logos) mousepad', '', '\r\n<div style=\"\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif;\"><span style=\"color: rgb(49, 53, 61);\">a perfect addition to your desk as a gilmore girls stan&nbsp;</span></span></div>\r\n<div style=\"\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif;\"><span style=\"color: rgb(49, 53, 61);\"></span>&nbsp;</span></div>\r\n<div style=\"\">\r\n	<p style=\"background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; line-height: inherit; color: rgb(49, 53, 61);\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px; font-weight: bold;\">Details:&nbsp;</span></p>\r\n	<ul style=\"background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px 0px 0px 1em; outline: 0px; padding: 0px 0px 0px 40px; vertical-align: baseline; list-style: circle; box-sizing: border-box; padding-inline: revert; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; line-height: inherit; color: rgb(49, 53, 61);\">\r\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Mousepad</span></li>\r\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Antislip rubber</span></li>\r\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">9.84 in x 7.87 in</span></li>\r\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Made iwth sublimation ink&nbsp;</span></li>\r\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Colors will vary slightly by product</span></li>\r\n		<li style=\"font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; box-sizing: border-box;\"><span style=\"font-family: \"Palatino Linotype\", \"Book Antiqua\", Palatino, serif; font-size: 14px;\">Mouse image is not pictured to size</span></li>\r\n	</ul><br />\r\n	</div>', 'luke\'s diner | gilmore girls | work supplies | mousepad | bymariamichele | work accessories', '');
(13360, 1, 'Candle Gift Basket', '', '\r\n<div>Gift basket for any occasion.&nbsp;</div>\r\n<div>Contents: 2 Massachusetts candles, 1 bottle spray air freshener, cream pampas picks, Lindor caramel chocolates, whicker basket.&nbsp;</div>', 'Cakes & Beyond By Dawn', ''),
(13361, 1, 'Fall Gift Basket', '', '\r\n<div>Fall Themed Gift basket.&nbsp;</div>\r\n<div>Contents: Various home decor items, whicker basket</div>', 'Cakes & Beyond By Dawn', ''),
(13362, 1, 'Minnie Mouse Gift basket', '', 'Minnie Mouse gift basket for birthday, Easter, Christmas, ect. Contains 12 plus items (minnie ears headband, bubbles, crafts, toys.&nbsp;', 'Cakes & Beyond By Dawn', ''),
(13363, 1, 'Chocolate Dream - 1 Dozen', '', '<div>Chocolate cookie with vanilla icing and chocolate drizzle&nbsp;</div>\n<div><br />\n	</div>', 'Drops of Heaven Cookies', ''),
(13364, 1, 'Strawberry Dream - 1 Dozen ', '', 'Vanilla cookie, strawberry filling, strawberry icing and strawberry chocolate drizzle&nbsp;  ', 'Drops of Heaven Cookies', ''),
(13365, 1, 'Lemon Drop - 1 Dozen ', '', '\r\n<div>Vanilla cookie with lemon icing</div>\r\n<div><br />\r\n	</div>  ', 'Drops of Heaven Cookies', ''),
(13366, 1, 'Smore\'s - 1 Dozen', '', 'Vanilla or chocolate cookie, vanilla icing topped with a mini marshmallow, chocolate bar, graham cracker crust and chocolate drizzle&nbsp;', 'Drops of Heaven Cookies', ''),
(13367, 1, 'Maple Bacon -1 Dozen', '', 'Vanilla cookie, maple icing with real bacon pieces on top  ', 'Drops of Heaven Cookies', ''),
(13368, 1, 'Cheeky Boo-tiful Windspinner', '', '<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">👻🍂 Spooky Season is Here! 🍂👻</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Add a little boo-tiful charm to your fall d&eacute;cor with this 10-inch Boo Windspinner!</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Perfect for porches, gardens, or anywhere you want a touch of Halloween fun. The playful ghost design spins and shimmers in the breeze — cute from the front and cheeky from the back! 😉</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🎃 Weather-resistant &amp; durable</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🎃 Vibrant fall/Halloween vibe</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🎃 Great gift for ghost lovers</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">✨ Limited seasonal item — grab yours before it vanishes!</span></p>\n<div><span style=\"font-kerning: none;\"><br />\n		</span></div>', 'halloween | WindSpinner | DESIGNS BY DEVINE | Boo | ghostdecor | spooky season | halloween vibes', ''),
(13369, 1, 'Fluffanutta  - 1 Dozen ', '', 'Vanilla cookie, fluff middle, peanut butter icing, topped with mini marshmallows      ', 'Drops of Heaven Cookies', ''),
(13370, 1, 'PB&J ', '', 'Vanilla cookie, jelly center with peanut butter icing and peanut butter drizzle&nbsp;    ', 'Drops of Heaven Cookies', ''),
(13371, 1, 'Pumpkin', '', '4” mosaic on wood pumpkins in various shades of orange&nbsp;', 'The Artsy Cat LLC', ''),
(13372, 1, 'Witch Hat', '', '4” mosaic on wood witch hat complete with string for display', 'The Artsy Cat LLC', ''),
(13373, 1, 'Pressed Flower Cross', '', '<div>Beautiful pressed hanging cross frames&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<div>Measure 3.5\"x2.5\"</div>', 'Totally Tara Creations ', ''),
(13374, 1, 'Orange Mushroom Frames', '', 'Bring a touch of woodland magic into your home with this stunning pressed botanical art piece. Encased in an elegant gold metal frame with clear glass panels, it beautifully showcases a delicate arrangement of real dried mushrooms, fiery orange petals, and lush greenery. Each stem and frond is carefully preserved to capture nature’s textures and colors in timeless detail. Perfect for adding warmth to a mantel, shelf, or gallery wall, this one-of-a-kind creation blends rustic charm with modern minimalism. Whether you’re a nature lover, a forager at heart, or simply seeking a conversation-starting accent, this piece turns the quiet beauty of the forest floor into art you can treasure forever.\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<div>Measures 7\"x5\"&nbsp;</div>', 'Totally Tara Creations ', ''),
(13375, 1, 'Purple Mushroom Frame', '', 'Elevate your space with this enchanting pressed botanical display, where whimsical forest fungi meet delicate blooms in a harmonious blend of color and texture. Framed in an elegant arched gold frame with crystal-clear glass, it features real dried mushrooms rising from vibrant tufts of magenta moss, surrounded by airy ferns and soft pink flowers. Each botanical element is hand-pressed and artfully arranged to create a one-of-a-kind composition that feels both modern and timeless. Perfect for brightening a shelf, desk, or wall, this piece brings the serene beauty of a spring meadow and the mystery of the forest right into your home—no green thumb required.\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<div>Measures 7\"x9\"&nbsp;</div>', 'Totally Tara Creations ', ''),
(13376, 1, 'Fall is Proof…. Ceramic Jar with Bamboo Lid', '', '<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🍂 Fall is proof that change is beautiful 🍂</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">This gorgeous ceramic jar with a bamboo lid is the perfect blend of cozy autumn vibes and everyday function. Store cookies, tea, coffee, or little treasures while adding seasonal charm to your space.</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🎃 $14 — functional, decorative, and fall-ready!</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Perfect for gift giving or treating yourself.</span></p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\n	</p>\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">📍 Grab yours before they’re gone — fall won’t last forever, but this beauty can!</span></p>\n<div><span style=\"font-kerning: none;\"><br />\n		</span></div>', 'home decor | Fall decor | Housewarming gift | designsbydevine | DESIGNS BY DEVINE | Pumpkin Season | autumn vibes', ''),
(13377, 1, 'Fall Gnome Trio - 18 oz Dispenser', '', '\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🍂 Fall for This Cute &amp; Functional Find! 🍂</span></p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">This 18 oz pump dispenser is the perfect blend of seasonal charm and everyday function. Whether you fill it with soap, lotion, or hand sanitizer, it adds a cozy autumn touch to any kitchen or bath.</span></p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\r\n	</p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">✨ Features:</span></p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\r\n	</p>\r\n<ul>\r\n	<li style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Holds 18 oz of your favorite product</span></li>\r\n	<li style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Adorable fall gnome + leaf design</span></li>\r\n	<li style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">Customizable your way — add names, colors, or a whole new design</span></li>\r\n</ul>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\r\n	</p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\r\n	</p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">🎁 Great for seasonal decorating or as a thoughtful gift!</span></p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 12px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0); min-height: 13.8px;\"><span style=\"font-kerning: none;\"></span><br />\r\n	</p>\r\n<p style=\"margin: 0px 0px 12px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 19px; line-height: normal; font-family: \"Times New Roman\"; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-stroke-width: 0px; -webkit-text-stroke-color: rgb(0, 0, 0);\"><span style=\"font-kerning: none;\">📦 Order yours today and let’s make it uniquely yours.</span></p>\r\n<div><span style=\"font-kerning: none;\"><br />\r\n		</span></div>', 'Fall decor | DESIGNS BY DEVINE | Pumpkin Season | seasonal decor | autumn vibes | soap dispenser | gnome decor', ''),
(13378, 1, 'Bronze Pumpkin with Leaves Earrings', '', 'Bronze Pumpkin with Leaves Earrings', 'Creativ Quirks', ''),
(13379, 1, 'Silver Pumpkin with Leaves Earrings', '', 'Silver Pumpkin with Leaves Earrings', 'Creativ Quirks', ''),
(13383, 1, 'spirit halloween (25 oz Glass Tumbler)', '', '<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 17px; background-color: rgb(255, 255, 255);\">i like romantic strolls down spirit halloween aisles&nbsp;</div>\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 17px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 17px; background-color: rgb(255, 255, 255);\">\n	<p style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; margin: 0px; font-size: 0.875rem; line-height: inherit; word-break: break-word; color: rgb(49, 53, 61); background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; padding: 0px; vertical-align: baseline; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Glass Tumbler Details:&nbsp;</span></p>\n	<ul style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; padding: 0px 0px 0px 40px; margin: 0px 0px 0px 1em; list-style: circle; color: rgb(49, 53, 61); background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; padding-inline: revert; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; line-height: inherit;\">\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">25oz capacity&nbsp;</span></li>\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Frosted Glass</span></li>\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Straw Included</span></li>\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Bamboo Lid (do not soak, will cause mold)</span></li>\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Made with Sublimation&nbsp;</span></li>\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Colors will vary slightly by product</span></li>\n	</ul></div>', 'halloween | glass tumbler | glass cup | bymariamichele | spooky season', '');
(13402, 1, 'ghostbusters luggage tag', '', '\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 17px; background-color: rgb(255, 255, 255);\">who you gonna call?!</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 17px; background-color: rgb(255, 255, 255);\">&nbsp;</div>\r\n<div style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; color: rgb(33, 37, 41); font-family: Lato; font-size: 17px; background-color: rgb(255, 255, 255);\">\r\n	<p style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; margin: 0px; font-size: 0.875rem; line-height: inherit; word-break: break-word; color: rgb(49, 53, 61); background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; padding: 0px; vertical-align: baseline; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Luggage Tag Details:&nbsp;</span></p>\r\n	<ul style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; padding: 0px 0px 0px 40px; margin: 0px 0px 0px 1em; list-style: circle; color: rgb(49, 53, 61); background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline; padding-inline: revert; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-variant-emoji: inherit; font-stretch: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; line-height: inherit;\">\r\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">4.05 x 2.83 inches</span></li>\r\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Faux Leather</span></li>\r\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Plastic Attachment</span></li>\r\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Note Card Provided</span></li>\r\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Made with Sublimation&nbsp;</span></li>\r\n		<li style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin; position: relative; padding: 0px; margin: 0px; color: inherit; list-style: disc; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; font-optical-sizing: inherit; font-size-adjust: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; border: 0px; outline: 0px; vertical-align: baseline;\"><span palatino=\"\" linotype\",=\"\" \"book=\"\" antiqua\",=\"\" palatino,=\"\" serif;=\"\" font-size:=\"\" 16px;\"=\"\" style=\"box-sizing: border-box; scrollbar-color: rgb(154, 160, 166) transparent; scrollbar-width: thin;\">Colors will vary slightly by product</span></li>\r\n	</ul></div>', 'halloween | luggage tag | bymariamichele | spooky season | ghostbusters | who you gonna call', ''),
(13403, 1, 'Skull Lantern', '', '12” tall solar powered mosaic skull lantern using red &amp; clear glass. All glass is hand cut &amp; placed by me.', 'The Artsy Cat LLC', ''),
(13404, 1, 'Example Product', '', '\r\n', 'Blakes Shop', ''),
(13405, 1, 'Ultra Soft Gloves', '', 'mklmlk', 'custom slates | Blakes Shop | Bag Decor', ''),
(13406, 1, 'Appreciation Tags', '', '<div>These tags are a perfect way to let your customers know not only the price but also that you appreciate them.</div>\n<div><br />\n	</div>', 'CraftsLtd | IT-F', ''),
(13407, 1, 'Winged heart', '', '5x6 permanent vinyl decal, applicator tool and instructions are included.', 'CraftsLtd', ''),
(13408, 1, 'Abstract', '', 'Hand painted on canvas, suitable to hang on the wall.', 'CraftsLtd', ''),
(13409, 1, 'Fall cards', '', 'What you see is what you get. 16 cards with envelopes, 8 green and 8 orange. Fall themed', 'CraftsLtd', ''),
(13410, 1, 'Congrats card', '', '<div>1 congratulations to the mommy to be, card, envelope included.</div>\n<div>standard size.&nbsp;</div>', 'CraftsLtd', '');
(13414, 1, 'Pumpkin with Witches Hat', '', '<div>MADE TO ORDER:</div>\n<div>&nbsp;</div>\n<div>This would be a great addition to your Halloween decorations at home or in your office. &nbsp;<br />\n	</div>\n<div>&nbsp;</div>\n<div>Cute Halloween gift instead of candy or just for fun.&nbsp;<br />\n	<br />\n	Measurements:</div>\n<div>- 6” tall</div>\n<div>- 4” wide</div>\n<div>&nbsp;</div>\n<div>Matterials:</div>\n<div>- 100% polyester yarn&nbsp;</div>\n<div>- 200% polyester polyfil stuffing&nbsp;</div>\n<div>- plastic eyes (on suitable for children under 3)</div>\n<div>&nbsp;</div>\n<div>any questions please message me. &nbsp;Colors can be customized.&nbsp;</div>\n<div><br />\n	</div>', 'gift | halloween | Pumpkin | witch | present | boy | girl | gender neutral | Terry\'s Crochet Cottage Online | Pumpkin Season | decoration', ''),
(13423, 1, 'Happy Pumpkin ', '', '\r\n<div>MADE TO ORDER:</div>\r\n<div>&nbsp;</div>\r\n<div>This would be a great addition to your Halloween decorations at home or in your office. &nbsp;<br />\r\n	</div>\r\n<div>&nbsp;</div>\r\n<div>Cute Halloween gift instead of candy or just for fun.&nbsp;<br />\r\n	<br />\r\n	Measurements:</div>\r\n<div>- 4” tall</div>\r\n<div>- 4” wide</div>\r\n<div>&nbsp;</div>\r\n<div>Matterials:</div>\r\n<div>- 100% polyester yarn&nbsp;</div>\r\n<div>- 100% polyester polyfil stuffing&nbsp;</div>\r\n<div>- plastic eyes (on suitable for children under 3)</div>\r\n<div>&nbsp;</div>\r\n<div>any questions please message me. &nbsp;Colors can be customized.&nbsp;</div>\r\n<div><br />\r\n	</div>', 'gift | halloween decor | halloween | Pumpkin | Children | present | gender neutral | Terry\'s Crochet Cottage Online | Pumpkin Season', ''),
(13424, 1, 'Pumpkin with Witches Hat', '', '<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">MADE TO ORDER:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">This would be a great addition to your Halloween decorations at home or in your office. &nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Cute Halloween gift instead of candy or just for fun.&nbsp;</span></p>\n<p class=\"p2\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; min-height: 29px; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\"></span><br />\n	</p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Measurements:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 6” tall</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 4” wide</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Matterials:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 100% polyester yarn&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 100% polyester polyfil stuffing&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- plastic eyes (on suitable for children under 3)</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">any questions please message me. &nbsp;Colors can be customized.&nbsp;</span></p>', 'handmade | decor | halloween | Children | Girls | boys | gender neutral | crochet | adult | Terry\'s Crochet Cottage Online', ''),
(13426, 1, 'Ghost with Witches Hat', '', '<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">MADE TO ORDER:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">This would be a great addition to your Halloween decorations at home or in your office. &nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Cute Halloween gift instead of candy or just for fun.&nbsp;</span></p>\n<p class=\"p2\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; min-height: 29px; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\"></span><br />\n	</p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Measurements:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 5” tall</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 31/2”wide</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;Size can vary slightly as it’s handmade.&nbsp;<br />\n		<br />\n		</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Matterials:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 100% polyester yarn&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 100% polyester polyfil stuffing&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- plastic eyes (on suitable for children under 3)</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">any questions please message me. &nbsp;Colors can be customized.&nbsp;</span></p>', 'gift | halloween | witch | Children | present | gender neutral | crochet | adult | Terry\'s Crochet Cottage Online | ghosts | Witch hat', ''),
(13433, 1, 'Ghost', '', '<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">MADE TO ORDER:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">This would be a great addition to your Halloween decorations at home or in your office. &nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Cute Halloween gift instead of candy or just for fun.&nbsp;</span></p>\n<p class=\"p2\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; min-height: 29px; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\"></span><br />\n	</p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Measurements:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 3” tall</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 3 1/2 wide</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;Measurements can vary slightly as they are handmade.&nbsp;<br />\n		<br />\n		</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">Matterials:</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 100% polyester yarn&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- 100% polyester polyfil stuffing&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">- plastic eyes (on suitable for children under 3)</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">&nbsp;</span></p>\n<p class=\"p1\" style=\"margin: 0px; font-width: normal; font-size: 23px; line-height: normal; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; -webkit-text-size-adjust: auto;\"><span class=\"s1\" style=\"font-family: UICTFontTextStyleBody;\">any questions please message me. &nbsp;Colors can be customized.&nbsp;</span></p>', 'gift | Girls | boys | gender neutral | Terry\'s Crochet Cottage Online | Ghost', '');

CREATE TABLE `tbl_products_min_price` (
  `pmp_product_id` int UNSIGNED NOT NULL,
  `pmp_selprod_id` int UNSIGNED NOT NULL,
  `pmp_min_price` decimal(10,2) NOT NULL,
  `pmp_max_price` decimal(10,2) NOT NULL,
  `pmp_splprice_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_products_shipped_by_seller` (
  `psbs_product_id` int UNSIGNED NOT NULL,
  `psbs_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_products_shipping` (
  `ps_product_id` int UNSIGNED NOT NULL,
  `ps_user_id` int NOT NULL,
  `ps_from_country_id` int NOT NULL,
  `ps_free` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_products_temp_ids` (
  `pti_product_id` int UNSIGNED NOT NULL,
  `pti_product_temp_id` int NOT NULL,
  `pti_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_products_to_plugin_product` (
  `ptpp_product_id` int UNSIGNED NOT NULL,
  `ptpp_plugin_id` int NOT NULL,
  `ptpp_plugin_product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_ai_enrichment` (
  `pae_id` int NOT NULL,
  `pae_product_id` int NOT NULL,
  `pae_context` longtext COLLATE utf8mb4_general_ci,
  `pae_jobs` json DEFAULT NULL,
  `pae_persona` json DEFAULT NULL,
  `pae_search_queries` json DEFAULT NULL,
  `pae_tags` json DEFAULT NULL,
  `pae_updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_categories` (
  `prodcat_id` int NOT NULL,
  `prodcat_identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodcat_parent` int NOT NULL DEFAULT '0',
  `prodcat_seller_id` int NOT NULL,
  `prodcat_display_order` int NOT NULL DEFAULT '0',
  `prodcat_featured` tinyint NOT NULL,
  `prodcat_has_child` tinyint(1) NOT NULL,
  `prodcat_active` int NOT NULL DEFAULT '1',
  `prodcat_status` tinyint NOT NULL COMMENT 'Defined in productCategory Model',
  `prodcat_deleted` int NOT NULL DEFAULT '0',
  `prodcat_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodcat_ordercode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodcat_updated_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prodcat_requested_on` datetime NOT NULL,
  `prodcat_status_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DELIMITER $$
CREATE TRIGGER `ADDNEWCATEGORY` AFTER INSERT ON `tbl_product_categories` FOR EACH ROW CALL UPDATECATEGORYRELATIONS(new.prodcat_id)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATECATEGORY` AFTER UPDATE ON `tbl_product_categories` FOR EACH ROW IF new.prodcat_parent != old.prodcat_parent THEN 
               CALL UPDATECATEGORYRELATIONS(new.prodcat_id);
               CALL UPDATECATEGORYRELATIONS(old.prodcat_parent);
            END IF
$$
DELIMITER ;

CREATE TABLE `tbl_product_categories_lang` (
  `prodcatlang_prodcat_id` int NOT NULL,
  `prodcatlang_lang_id` int NOT NULL,
  `prodcat_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodcat_content_block` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodcat_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_category_relations` (
  `pcr_prodcat_id` int NOT NULL,
  `pcr_parent_id` int NOT NULL,
  `pcr_level` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_digital_data_relation` (
  `pddr_id` int NOT NULL,
  `pddr_record_id` int NOT NULL COMMENT 'anyone of following: 1) Catalog id (pddr_id) 2) Seller inventory id',
  `pddr_options_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '0 for all options',
  `pddr_type` tinyint NOT NULL COMMENT '0 => Master Catalog, 1 => catalog request'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_digital_links` (
  `pdl_id` int NOT NULL,
  `pdl_record_id` int NOT NULL COMMENT 'anyone of following: 1) Catalog id (pddr_id) 2) Seller inventory id',
  `pdl_lang_id` int NOT NULL,
  `pdl_download_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pdl_preview_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Contains Digital download links which are related to a Catalog product or seller Inventory';

CREATE TABLE `tbl_product_groups` (
  `prodgroup_id` int NOT NULL,
  `prodgroup_user_id` int NOT NULL,
  `prodgroup_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodgroup_price` decimal(10,2) NOT NULL,
  `prodgroup_active` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_product_groups_lang` (
  `prodgrouplang_prodgroup_id` int NOT NULL,
  `prodgrouplang_lang_id` int NOT NULL,
  `prodgroup_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_product_numeric_attributes` (
  `prodnumattr_product_id` int UNSIGNED NOT NULL,
  `prodnumattr_num_1` decimal(10,2) NOT NULL,
  `prodnumattr_num_2` decimal(10,2) NOT NULL,
  `prodnumattr_num_3` decimal(10,2) NOT NULL,
  `prodnumattr_num_4` decimal(10,2) NOT NULL,
  `prodnumattr_num_5` decimal(10,2) NOT NULL,
  `prodnumattr_num_6` decimal(10,2) NOT NULL,
  `prodnumattr_num_7` decimal(10,2) NOT NULL,
  `prodnumattr_num_8` decimal(10,2) NOT NULL,
  `prodnumattr_num_9` decimal(10,2) NOT NULL,
  `prodnumattr_num_10` decimal(10,2) NOT NULL,
  `prodnumattr_num_11` decimal(10,2) NOT NULL,
  `prodnumattr_num_12` decimal(10,2) NOT NULL,
  `prodnumattr_num_13` decimal(10,2) NOT NULL,
  `prodnumattr_num_14` decimal(10,2) NOT NULL,
  `prodnumattr_num_15` decimal(10,2) NOT NULL,
  `prodnumattr_num_16` decimal(10,2) NOT NULL,
  `prodnumattr_num_17` decimal(10,2) NOT NULL,
  `prodnumattr_num_18` decimal(10,2) NOT NULL,
  `prodnumattr_num_19` decimal(10,2) NOT NULL,
  `prodnumattr_num_20` decimal(10,2) NOT NULL,
  `prodnumattr_num_21` decimal(10,2) NOT NULL,
  `prodnumattr_num_22` decimal(10,2) NOT NULL,
  `prodnumattr_num_23` decimal(10,2) NOT NULL,
  `prodnumattr_num_24` decimal(10,2) NOT NULL,
  `prodnumattr_num_25` decimal(10,2) NOT NULL,
  `prodnumattr_num_26` decimal(10,2) NOT NULL,
  `prodnumattr_num_27` decimal(10,2) NOT NULL,
  `prodnumattr_num_28` decimal(10,2) NOT NULL,
  `prodnumattr_num_29` decimal(10,2) NOT NULL,
  `prodnumattr_num_30` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Used for Product Comparison';

CREATE TABLE `tbl_product_product_recommendation` (
  `ppr_viewing_product_id` int UNSIGNED NOT NULL,
  `ppr_recommended_product_id` int UNSIGNED NOT NULL,
  `ppr_weightage` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_product_requests` (
  `preq_id` bigint NOT NULL,
  `preq_user_id` int NOT NULL,
  `preq_prodcat_id` int NOT NULL,
  `preq_brand_id` int NOT NULL,
  `preq_product_identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `preq_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `preq_sel_prod_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `preq_ean_upc_code` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `preq_comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `preq_status` tinyint NOT NULL,
  `preq_submitted_for_approval` tinyint(1) NOT NULL,
  `preq_deleted` tinyint(1) NOT NULL,
  `preq_added_on` datetime NOT NULL,
  `preq_requested_on` datetime NOT NULL,
  `preq_status_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_product_requests_lang` (
  `preqlang_preq_id` bigint NOT NULL,
  `preqlang_lang_id` bigint NOT NULL,
  `preq_lang_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_product_saved_search` (
  `pssearch_id` int NOT NULL,
  `pssearch_user_id` int NOT NULL,
  `pssearch_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pssearch_type` int NOT NULL,
  `pssearch_record_id` int NOT NULL,
  `pssearch_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pssearch_added_on` datetime NOT NULL,
  `pssearch_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_shipping_rates` (
  `pship_id` int NOT NULL,
  `pship_prod_id` bigint NOT NULL,
  `pship_user_id` int NOT NULL,
  `pship_country` int NOT NULL,
  `pship_method` int NOT NULL DEFAULT '1',
  `pship_company` int NOT NULL,
  `pship_duration` int NOT NULL,
  `pship_charges` decimal(10,4) NOT NULL,
  `pship_additional_charges` decimal(10,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_product_special_prices` (
  `splprice_id` int NOT NULL,
  `splprice_selprod_id` int UNSIGNED NOT NULL,
  `splprice_start_date` datetime NOT NULL,
  `splprice_end_date` datetime NOT NULL,
  `splprice_price` decimal(10,2) NOT NULL,
  `splprice_discount_percent` decimal(10,2) NOT NULL,
  `splprice_display_dis_type` int NOT NULL COMMENT 'Only for presentation, Flat or %',
  `splprice_display_dis_val` decimal(10,2) NOT NULL COMMENT 'Only for presentation',
  `splprice_display_list_price` decimal(10,2) NOT NULL COMMENT 'Only for presentation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_specifications` (
  `prodspec_id` int NOT NULL,
  `prodspec_product_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_specifications_lang` (
  `prodspeclang_prodspec_id` int NOT NULL,
  `prodspeclang_lang_id` int NOT NULL,
  `prodspec_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodspec_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodspec_group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_specifics` (
  `ps_product_id` int UNSIGNED NOT NULL,
  `product_warranty` int NOT NULL,
  `product_warranty_unit` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_stock_hold` (
  `pshold_id` bigint NOT NULL,
  `pshold_selprod_id` int UNSIGNED NOT NULL,
  `pshold_user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'varchar, bcoz, it may contain user_id or session_id',
  `pshold_prodgroup_id` int NOT NULL,
  `pshold_selprod_stock` int NOT NULL,
  `pshold_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table used to hold stock of the product are added to cart';

CREATE TABLE `tbl_product_text_attributes` (
  `prodtxtattr_product_id` int UNSIGNED NOT NULL,
  `prodtxtattr_lang_id` int NOT NULL,
  `prodtxtattr_text_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_2` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_3` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_4` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_5` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_6` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_7` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_8` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_9` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_10` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_11` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_12` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_13` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_14` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_15` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_16` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_17` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_18` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_19` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_20` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_21` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_22` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_23` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_24` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_25` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_26` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_27` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_28` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_29` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_30` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_31` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_32` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_33` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_34` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_35` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_36` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_37` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_38` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_39` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prodtxtattr_text_40` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Used for Product Comparison';

CREATE TABLE `tbl_product_to_category` (
  `ptc_product_id` int UNSIGNED NOT NULL,
  `ptc_prodcat_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_to_groups` (
  `ptg_prodgroup_id` int NOT NULL,
  `ptg_selprod_id` int UNSIGNED NOT NULL,
  `ptg_is_main_product` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_product_to_options` (
  `prodoption_product_id` int UNSIGNED NOT NULL,
  `prodoption_option_id` int NOT NULL,
  `prodoption_optionvalue_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_to_tags` (
  `ptt_product_id` int UNSIGNED NOT NULL,
  `ptt_tag_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_to_tax` (
  `ptt_product_id` int UNSIGNED NOT NULL,
  `ptt_taxcat_id` int NOT NULL,
  `ptt_seller_user_id` int NOT NULL COMMENT 'Seller Id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_product_volume_discount` (
  `voldiscount_id` bigint NOT NULL,
  `voldiscount_selprod_id` int UNSIGNED NOT NULL,
  `voldiscount_min_qty` int NOT NULL,
  `voldiscount_percentage` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_promotions` (
  `promotion_id` int NOT NULL,
  `promotion_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `promotion_user_id` int NOT NULL,
  `promotion_type` int NOT NULL,
  `promotion_record_id` int NOT NULL,
  `promotion_budget` decimal(12,2) NOT NULL,
  `promotion_cpc` decimal(10,4) NOT NULL,
  `promotion_duration` tinyint NOT NULL,
  `promotion_start_date` date NOT NULL,
  `promotion_end_date` date NOT NULL,
  `promotion_start_time` time NOT NULL,
  `promotion_end_time` time NOT NULL,
  `promotion_active` tinyint(1) NOT NULL,
  `promotion_added_on` datetime NOT NULL,
  `promotion_approved` tinyint(1) NOT NULL,
  `promotion_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_promotions_charges` (
  `pcharge_id` bigint NOT NULL,
  `pcharge_user_id` int NOT NULL,
  `pcharge_promotion_id` int NOT NULL,
  `pcharge_charged_amount` decimal(10,4) NOT NULL,
  `pcharge_clicks` int NOT NULL,
  `pcharge_date` datetime NOT NULL,
  `pcharge_start_piclick_id` bigint NOT NULL,
  `pcharge_end_piclick_id` bigint NOT NULL,
  `pcharge_start_date` datetime NOT NULL,
  `pcharge_end_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_promotions_clicks` (
  `pclick_id` bigint NOT NULL,
  `pclick_promotion_id` int NOT NULL,
  `pclick_user_id` int NOT NULL,
  `pclick_datetime` datetime NOT NULL,
  `pclick_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pclick_cost` decimal(10,4) NOT NULL,
  `pclick_session_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_promotions_lang` (
  `promotionlang_promotion_id` bigint NOT NULL,
  `promotionlang_lang_id` int NOT NULL,
  `promotion_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_promotions_logs` (
  `plog_promotion_id` int NOT NULL,
  `plog_date` date NOT NULL,
  `plog_impressions` int NOT NULL,
  `plog_clicks` int NOT NULL,
  `plog_orders` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_promotion_item_charges` (
  `picharge_id` bigint NOT NULL,
  `picharge_pclick_id` bigint NOT NULL,
  `picharge_datetime` datetime NOT NULL,
  `picharge_cost` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_push_notifications` (
  `pnotification_id` int NOT NULL,
  `pnotification_type` tinyint(1) NOT NULL,
  `pnotification_lang_id` tinyint NOT NULL,
  `pnotification_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pnotification_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pnotification_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pnotification_notified_on` datetime NOT NULL,
  `pnotification_for_buyer` tinyint(1) NOT NULL,
  `pnotification_for_seller` tinyint(1) NOT NULL,
  `pnotification_user_auth_type` tinyint(1) NOT NULL,
  `pnotification_device_os` tinyint(1) NOT NULL COMMENT 'Defined In User Model',
  `pnotification_uauth_last_access` datetime NOT NULL,
  `pnotification_status` tinyint(1) NOT NULL,
  `pnotification_added_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_push_notification_to_users` (
  `pntu_pnotification_id` int NOT NULL,
  `pntu_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_questionnaires` (
  `questionnaire_id` int NOT NULL,
  `questionnaire_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `questionnaire_start_date` datetime NOT NULL,
  `questionnaire_end_date` datetime NOT NULL,
  `questionnaire_active` tinyint(1) NOT NULL,
  `questionnaire_deleted` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_questionnaires_lang` (
  `questionnairelang_questionnaire_id` int NOT NULL,
  `questionnairelang_lang_id` int NOT NULL,
  `questionnaire_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `questionnaire_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_questionnaires_to_question` (
  `qtq_questionnaire_id` int NOT NULL,
  `qtq_question_id` int NOT NULL,
  `qtq_display_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_questionnaire_feedback` (
  `qfeedback_id` int NOT NULL,
  `qfeedback_questionnaire_id` int NOT NULL,
  `qfeedback_user_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `qfeedback_user_email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `qfeedback_user_gender` int NOT NULL,
  `qfeedback_user_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `qfeedback_lang_id` int NOT NULL,
  `qfeedback_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_questions` (
  `question_id` int NOT NULL,
  `question_qbank_id` int NOT NULL,
  `question_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `question_type` int NOT NULL,
  `question_required` tinyint NOT NULL,
  `question_active` tinyint(1) NOT NULL,
  `question_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_questions_lang` (
  `questionlang_question_id` int NOT NULL,
  `questionlang_lang_id` int NOT NULL,
  `question_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `question_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_question_banks` (
  `qbank_id` int NOT NULL,
  `qbank_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `qbank_active` tinyint(1) NOT NULL,
  `qbank_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_question_banks_lang` (
  `qbanklang_qbank_id` int NOT NULL,
  `qbanklang_lang_id` int NOT NULL,
  `qbank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_question_to_answers` (
  `qta_qfeedback_id` int NOT NULL,
  `qta_question_id` int NOT NULL,
  `qta_answers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_rating_types` (
  `ratingtype_id` bigint NOT NULL,
  `ratingtype_identifier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ratingtype_type` tinyint NOT NULL,
  `ratingtype_default` tinyint NOT NULL,
  `ratingtype_active` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_rating_types_lang` (
  `ratingtypelang_ratingtype_id` bigint NOT NULL,
  `ratingtypelang_lang_id` int NOT NULL,
  `ratingtype_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_recommendation_activity_browsing` (
  `rab_session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rab_user_id` bigint NOT NULL,
  `rab_record_id` bigint NOT NULL,
  `rab_record_type` int NOT NULL,
  `rab_weightage_key` int NOT NULL,
  `rab_weightage` decimal(12,2) NOT NULL,
  `rab_order_id` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rab_last_action_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_related_products` (
  `related_sellerproduct_id` int UNSIGNED NOT NULL,
  `related_recommend_sellerproduct_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_report_reasons` (
  `reportreason_id` int NOT NULL,
  `reportreason_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_report_reasons_lang` (
  `reportreasonlang_reportreason_id` int NOT NULL,
  `reportreasonlang_lang_id` int NOT NULL,
  `reportreason_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `reportreason_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_rewards_on_purchase` (
  `rop_id` int NOT NULL,
  `rop_purchase_upto` decimal(10,2) NOT NULL,
  `rop_reward_point` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_search_items` (
  `searchitem_id` int NOT NULL,
  `searchitem_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `searchitem_count` int NOT NULL DEFAULT '1',
  `searchitem_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_brand_requests` (
  `sbrandreq_id` int NOT NULL,
  `sbrandreq_seller_id` int NOT NULL,
  `sbrandreq_identifier` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sbrandreq_status` int NOT NULL,
  `sbrandreq_deleted` int NOT NULL,
  `sbrandreq_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_brand_requests_lang` (
  `sbrandreqlang_sbrandreq_id` int NOT NULL,
  `sbrandreqlang_lang_id` int NOT NULL,
  `sbrandreq_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_catalog_requests` (
  `scatrequest_id` int NOT NULL,
  `scatrequest_user_id` int NOT NULL,
  `scatrequest_reference` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scatrequest_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scatrequest_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scatrequest_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scatrequest_status` tinyint NOT NULL,
  `scatrequest_date` datetime NOT NULL,
  `scatrequest_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_packages` (
  `spackage_id` int NOT NULL,
  `spackage_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `spackage_type` int NOT NULL,
  `spackage_commission_rate` decimal(10,2) NOT NULL,
  `spackage_products_allowed` int NOT NULL,
  `spackage_inventory_allowed` int NOT NULL,
  `spackage_images_per_product` int NOT NULL,
  `spackage_free_trial_days` int NOT NULL,
  `spackage_display_order` int NOT NULL,
  `spackage_active` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_packages_lang` (
  `spackagelang_spackage_id` int NOT NULL,
  `spackagelang_lang_id` int NOT NULL,
  `spackage_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `spackage_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_packages_plan` (
  `spplan_id` int NOT NULL,
  `spplan_spackage_id` int NOT NULL,
  `spplan_trial_interval` int NOT NULL,
  `spplan_trial_frequency` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `spplan_interval` int NOT NULL,
  `spplan_frequency` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `spplan_price` decimal(10,2) NOT NULL,
  `spplan_display_order` int NOT NULL,
  `spplan_active` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_products` (
  `selprod_id` int UNSIGNED NOT NULL,
  `selprod_user_id` int NOT NULL,
  `selprod_product_id` int NOT NULL,
  `selprod_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'generated by product_id and option value ids associated with this product',
  `selprod_price` decimal(10,2) NOT NULL COMMENT 'Selling Price',
  `selprod_cost` decimal(10,2) NOT NULL,
  `selprod_stock` int NOT NULL,
  `selprod_is_invoice` tinyint NOT NULL,
  `selprod_invoice_hide` tinyint(1) NOT NULL DEFAULT '0',
  `selprod_min_order_qty` int NOT NULL,
  `selprod_subtract_stock` tinyint NOT NULL,
  `selprod_track_inventory` tinyint NOT NULL,
  `selprod_threshold_stock_level` int NOT NULL,
  `selprod_sku` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `selprod_condition` int NOT NULL COMMENT 'defined in product model',
  `selprod_added_on` datetime NOT NULL,
  `selprod_updated_on` datetime NOT NULL,
  `selprod_available_from` datetime NOT NULL,
  `selprod_active` tinyint NOT NULL,
  `selprod_cod_enabled` tinyint(1) NOT NULL,
  `selprod_fulfillment_type` tinyint NOT NULL DEFAULT '-1',
  `selprod_sold_count` int NOT NULL,
  `selprod_url_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `selprod_max_download_times` int NOT NULL,
  `selprod_download_validity_in_days` int NOT NULL,
  `selprod_urlrewrite_id` bigint NOT NULL,
  `selprod_random_order` int NOT NULL,
  `selprod_deleted` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_products_lang` (
  `selprodlang_selprod_id` int UNSIGNED NOT NULL,
  `selprodlang_lang_id` int NOT NULL,
  `selprod_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `selprod_features` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `selprod_warranty` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `selprod_return_policy` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `selprod_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_products_temp_ids` (
  `spti_selprod_id` int UNSIGNED NOT NULL,
  `spti_selprod_temp_id` bigint NOT NULL,
  `spti_user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_products_to_plugin_selprod` (
  `spps_selprod_id` int UNSIGNED NOT NULL,
  `spps_plugin_id` int NOT NULL,
  `spps_plugin_selprod_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_product_options` (
  `selprodoption_selprod_id` int UNSIGNED NOT NULL,
  `selprodoption_option_id` int NOT NULL COMMENT 'Do we really need it?',
  `selprodoption_optionvalue_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_product_policies` (
  `sppolicy_selprod_id` int UNSIGNED NOT NULL,
  `sppolicy_ppoint_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_product_rating` (
  `sprating_spreview_id` int NOT NULL,
  `sprating_ratingtype_id` bigint NOT NULL,
  `sprating_rating` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_product_reviews` (
  `spreview_id` int NOT NULL,
  `spreview_seller_user_id` int NOT NULL,
  `spreview_order_id` bigint NOT NULL,
  `spreview_product_id` int NOT NULL,
  `spreview_selprod_id` int UNSIGNED NOT NULL,
  `spreview_selprod_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `spreview_postedby_user_id` int NOT NULL,
  `spreview_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `spreview_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `spreview_posted_on` datetime NOT NULL,
  `spreview_status` tinyint NOT NULL,
  `spreview_lang_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_seller_product_reviews_abuse` (
  `spra_spreview_id` int NOT NULL,
  `spra_user_id` int NOT NULL,
  `spra_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_product_reviews_helpful` (
  `sprh_spreview_id` int NOT NULL,
  `sprh_user_id` int NOT NULL,
  `sprh_helpful` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_seller_product_specifics` (
  `sps_selprod_id` int UNSIGNED NOT NULL,
  `selprod_return_age` int NOT NULL COMMENT 'In Days',
  `selprod_cancellation_age` int NOT NULL COMMENT 'In Days'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shippingapi_settings` (
  `shipsetting_shippingapi_id` int NOT NULL,
  `shipsetting_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shipsetting_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_shipping_apis` (
  `shippingapi_id` int NOT NULL,
  `shippingapi_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shippingapi_active` tinyint(1) NOT NULL,
  `shippingapi_display_order` int NOT NULL,
  `shippingapi_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_apis_lang` (
  `shippingapilang_shippingapi_id` int NOT NULL,
  `shippingapilang_lang_id` int NOT NULL,
  `shippingapi_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_company` (
  `scompany_id` int NOT NULL,
  `scompany_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scompany_trackingurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scompany_active` tinyint(1) NOT NULL,
  `scompany_display_order` int NOT NULL,
  `scompany_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_shipping_company_lang` (
  `scompanylang_scompany_id` int NOT NULL,
  `scompanylang_lang_id` int NOT NULL,
  `scompany_name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_shipping_durations` (
  `sduration_id` int NOT NULL,
  `sduration_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sduration_from` int NOT NULL,
  `sduration_to` int NOT NULL,
  `sduration_days_or_weeks` tinyint(1) NOT NULL,
  `sduration_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_shipping_durations_lang` (
  `sdurationlang_sduration_id` int NOT NULL,
  `sdurationlang_lang_id` int NOT NULL,
  `sduration_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_shipping_locations` (
  `shiploc_shipzone_id` int NOT NULL,
  `shiploc_zone_id` int NOT NULL,
  `shiploc_country_id` int NOT NULL,
  `shiploc_state_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_packages` (
  `shippack_id` int NOT NULL,
  `shippack_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shippack_length` decimal(10,2) NOT NULL,
  `shippack_width` decimal(10,2) NOT NULL,
  `shippack_height` decimal(10,2) NOT NULL,
  `shippack_units` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_profile` (
  `shipprofile_id` int NOT NULL,
  `shipprofile_user_id` int NOT NULL,
  `shipprofile_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shipprofile_active` tinyint(1) NOT NULL DEFAULT '1',
  `shipprofile_default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_profile_lang` (
  `shipprofilelang_shipprofile_id` int NOT NULL,
  `shipprofilelang_lang_id` int NOT NULL,
  `shipprofile_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_profile_products` (
  `shippro_shipprofile_id` int NOT NULL,
  `shippro_product_id` int NOT NULL,
  `shippro_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_profile_zones` (
  `shipprozone_id` int NOT NULL,
  `shipprozone_shipprofile_id` int NOT NULL,
  `shipprozone_shipzone_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_rates` (
  `shiprate_id` int NOT NULL,
  `shiprate_shipprozone_id` int NOT NULL,
  `shiprate_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shiprate_cost` decimal(10,2) NOT NULL,
  `shiprate_condition_type` int NOT NULL DEFAULT '0',
  `shiprate_min_val` decimal(10,2) NOT NULL DEFAULT '0.00',
  `shiprate_max_val` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_rates_lang` (
  `shipratelang_shiprate_id` int NOT NULL,
  `shipratelang_lang_id` int NOT NULL,
  `shiprate_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shipping_zone` (
  `shipzone_id` int NOT NULL,
  `shipzone_user_id` int NOT NULL,
  `shipzone_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shipzone_active` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shops` (
  `shop_id` int NOT NULL,
  `shop_user_id` int NOT NULL,
  `shop_ltemplate_id` int NOT NULL,
  `shop_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_postalcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_country_id` int NOT NULL,
  `shop_state_id` int NOT NULL,
  `shop_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_phone` bigint NOT NULL,
  `shop_invoice_prefix` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_invoice_suffix` bigint NOT NULL,
  `shop_custom_color_status` tinyint(1) NOT NULL,
  `shop_theme_background_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_theme_header_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_theme_text_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_theme_button_text_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_active` tinyint(1) NOT NULL DEFAULT '1',
  `shop_featured` tinyint(1) NOT NULL,
  `shop_cod_min_wallet_balance` decimal(10,0) NOT NULL DEFAULT '-1',
  `shop_supplier_display_status` tinyint(1) NOT NULL,
  `shop_created_on` datetime NOT NULL,
  `shop_updated_on` datetime NOT NULL,
  `shop_free_ship_upto` int NOT NULL,
  `shop_lat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_lng` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_fulfillment_type` tinyint NOT NULL,
  `shop_ship_by_me` tinyint NOT NULL,
  `shop_avg_rating` float(10,2) NOT NULL,
  `shop_total_reviews` int NOT NULL,
  `shop_has_valid_subscription` tinyint NOT NULL,
  `shop_user_valid` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shops_lang` (
  `shoplang_shop_id` int NOT NULL,
  `shoplang_lang_id` int NOT NULL,
  `shop_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_contact_person` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_address_line_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_address_line_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_city` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_payment_policy` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_delivery_policy` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_refund_policy` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_additional_info` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_seller_info` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shops_to_theme` (
  `stt_id` int NOT NULL,
  `stt_shop_id` int NOT NULL,
  `stt_bg_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stt_header_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stt_text_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_shop_collections` (
  `scollection_id` int NOT NULL,
  `scollection_shop_id` int NOT NULL,
  `scollection_identifier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scollection_active` tinyint(1) NOT NULL,
  `scollection_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shop_collections_lang` (
  `scollectionlang_scollection_id` int NOT NULL,
  `scollectionlang_lang_id` int NOT NULL,
  `scollection_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shop_collection_products` (
  `scp_scollection_id` int NOT NULL,
  `scp_selprod_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shop_reports` (
  `sreport_id` int NOT NULL,
  `sreport_shop_id` int NOT NULL,
  `sreport_reportreason_id` int NOT NULL,
  `sreport_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sreport_user_id` int NOT NULL COMMENT 'user_id, who reported shop as spam',
  `sreport_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shop_specifics` (
  `ss_shop_id` int NOT NULL,
  `shop_return_age` int NOT NULL COMMENT 'In Days',
  `shop_cancellation_age` int NOT NULL COMMENT 'In Days',
  `shop_invoice_codes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_pickup_interval` int NOT NULL COMMENT 'In Hours',
  `shop_use_manual_shipping_rates` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_shop_stats` (
  `sstats_shop_id` int NOT NULL,
  `sstats_avg_rating` decimal(10,2) NOT NULL,
  `sstats_completion_rate` decimal(10,2) NOT NULL,
  `sstats_completed_orders` int NOT NULL,
  `sstats_return_acceptance_rate` decimal(10,2) NOT NULL,
  `sstats_cancellation_rate` decimal(10,2) NOT NULL,
  `sstats_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_slides` (
  `slide_id` int NOT NULL,
  `slide_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slide_type` int NOT NULL,
  `slide_record_id` int NOT NULL,
  `slide_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slide_target` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slide_active` tinyint(1) NOT NULL,
  `slide_display_order` int NOT NULL,
  `slide_img_updated_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_slides_lang` (
  `slidelang_slide_id` int NOT NULL,
  `slidelang_lang_id` int NOT NULL,
  `slide_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_smart_log_actions` (
  `slog_id` bigint NOT NULL,
  `slog_ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slog_datetime` datetime NOT NULL,
  `slog_swsetting_key` int NOT NULL,
  `slog_record_id` bigint NOT NULL,
  `slog_record_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slog_type` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_smart_products_weightage` (
  `spw_product_id` bigint NOT NULL,
  `spw_weightage` decimal(10,2) NOT NULL,
  `spw_custom_weightage` decimal(10,2) NOT NULL,
  `spw_custom_weightage_valid_till` date NOT NULL,
  `spw_is_excluded` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_smart_remommended_products` (
  `tsrp_source_product_id` bigint NOT NULL,
  `tsrp_recommended_product_id` bigint NOT NULL,
  `tsrp_recommendation_weightage` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_smart_user_activity_browsing` (
  `uab_id` int NOT NULL,
  `uab_session_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uab_user_id` int NOT NULL,
  `uab_record_id` int NOT NULL,
  `uab_record_type` int NOT NULL,
  `uab_sub_record_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uab_last_action_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_smart_weightage_settings` (
  `swsetting_key` int NOT NULL COMMENT 'defined in model',
  `swsetting_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `swsetting_weightage` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_sms_archives` (
  `smsarchive_id` int NOT NULL,
  `smsarchive_response_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `smsarchive_to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `smsarchive_tpl_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `smsarchive_body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `smsarchive_sent_on` datetime NOT NULL,
  `smsarchive_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `smsarchive_response` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_sms_templates` (
  `stpl_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stpl_lang_id` int NOT NULL,
  `stpl_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stpl_body` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stpl_replacements` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stpl_status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_social_platforms` (
  `splatform_id` int NOT NULL,
  `splatform_user_id` int NOT NULL,
  `splatform_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `splatform_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `splatform_active` tinyint(1) NOT NULL,
  `splatform_icon_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'defined in model'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_social_platforms_lang` (
  `splatformlang_splatform_id` int NOT NULL,
  `splatformlang_lang_id` int NOT NULL,
  `splatform_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_states` (
  `state_id` int NOT NULL,
  `state_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `state_country_id` int NOT NULL,
  `state_identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `state_active` tinyint(1) NOT NULL,
  `state_updated_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_states_lang` (
  `statelang_state_id` int NOT NULL,
  `statelang_lang_id` int NOT NULL,
  `state_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_success_stories` (
  `sstory_id` int NOT NULL,
  `sstory_user_id` int NOT NULL,
  `sstory_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sstory_site_domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sstory_active` tinyint(1) NOT NULL,
  `sstory_deleted` tinyint(1) NOT NULL,
  `sstory_display_order` int NOT NULL,
  `sstory_added_on` datetime NOT NULL,
  `sstory_featured` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_success_stories_lang` (
  `sstorylang_sstory_id` int NOT NULL,
  `sstorylang_lang_id` int NOT NULL,
  `sstory_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sstory_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sstory_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_system_logs` (
  `slog_id` int NOT NULL,
  `slog_module_type` int NOT NULL,
  `slog_type` int NOT NULL,
  `slog_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slog_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slog_response` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slog_backtrace` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slog_created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tags` (
  `tag_id` int NOT NULL,
  `tag_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tag_lang_id` int NOT NULL,
  `tag_user_id` int NOT NULL COMMENT 'Added by user',
  `tag_admin_id` int NOT NULL COMMENT 'Added by admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tag_product_recommendation` (
  `tpr_tag_id` bigint NOT NULL,
  `tpr_product_id` bigint NOT NULL,
  `tpr_weightage` decimal(12,2) NOT NULL,
  `tpr_custom_weightage` decimal(12,2) NOT NULL,
  `tpr_custom_weightage_valid_till` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_tax_categories` (
  `taxcat_id` int NOT NULL,
  `taxcat_identifier` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `taxcat_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `taxcat_parent` int NOT NULL,
  `taxcat_plugin_id` int NOT NULL,
  `taxcat_active` tinyint(1) NOT NULL,
  `taxcat_deleted` tinyint(1) NOT NULL,
  `taxcat_last_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tax_categories_lang` (
  `taxcatlang_taxcat_id` int NOT NULL,
  `taxcatlang_lang_id` int NOT NULL,
  `taxcat_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tax_rules` (
  `taxrule_id` int NOT NULL,
  `taxrule_taxcat_id` int NOT NULL,
  `taxrule_taxstr_id` int NOT NULL,
  `taxrule_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tax_rule_details` (
  `taxruledet_taxrule_id` int NOT NULL,
  `taxruledet_taxstr_id` int NOT NULL,
  `taxruledet_rate` decimal(10,2) NOT NULL,
  `taxruledet_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_tax_rule_locations` (
  `taxruleloc_taxcat_id` int NOT NULL,
  `taxruleloc_from_country_id` int NOT NULL,
  `taxruleloc_from_state_id` int NOT NULL,
  `taxruleloc_taxrule_id` int NOT NULL,
  `taxruleloc_to_country_id` int NOT NULL,
  `taxruleloc_to_state_id` int NOT NULL,
  `taxruleloc_type` int DEFAULT NULL COMMENT 'including or excluding'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tax_rule_rates` (
  `trr_taxrule_id` int NOT NULL,
  `trr_rate` decimal(10,2) NOT NULL,
  `trr_user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tax_structure` (
  `taxstr_id` int NOT NULL,
  `taxstr_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `taxstr_parent` int NOT NULL,
  `taxstr_is_combined` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tax_structure_lang` (
  `taxstrlang_taxstr_id` int NOT NULL,
  `taxstrlang_lang_id` int NOT NULL,
  `taxstr_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_testimonials` (
  `testimonial_id` int NOT NULL,
  `testimonial_identifier` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `testimonial_active` tinyint(1) NOT NULL,
  `testimonial_deleted` tinyint(1) NOT NULL,
  `testimonial_added_on` datetime NOT NULL,
  `testimonial_user_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_testimonials_lang` (
  `testimoniallang_testimonial_id` int NOT NULL,
  `testimoniallang_lang_id` int NOT NULL,
  `testimonial_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `testimonial_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_threads` (
  `thread_id` bigint NOT NULL,
  `thread_subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `thread_started_by` int NOT NULL COMMENT 'user_id',
  `thread_start_date` date NOT NULL,
  `thread_type` int NOT NULL COMMENT 'defined in model',
  `thread_record_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_thread_messages` (
  `message_id` bigint NOT NULL,
  `message_thread_id` int NOT NULL,
  `message_from` int NOT NULL COMMENT 'user_id',
  `message_to` int NOT NULL COMMENT 'user_id',
  `message_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message_date` datetime NOT NULL,
  `message_is_unread` tinyint(1) NOT NULL DEFAULT '1',
  `message_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_time_slots` (
  `tslot_id` int NOT NULL,
  `tslot_availability` tinyint(1) NOT NULL,
  `tslot_type` int NOT NULL,
  `tslot_record_id` int NOT NULL,
  `tslot_subrecord_id` int NOT NULL,
  `tslot_day` int NOT NULL,
  `tslot_from_time` time NOT NULL,
  `tslot_to_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_tool_tips` (
  `tooltip_id` int NOT NULL,
  `tooltip_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tooltip_default_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_tool_tips_lang` (
  `tooltiplang_tooltip_id` int NOT NULL,
  `tooltiplang_lang_id` int NOT NULL,
  `tooltip_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_tracking_courier_code_relation` (
  `tccr_shipapi_plugin_id` int NOT NULL,
  `tccr_shipapi_courier_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tccr_tracking_plugin_id` int NOT NULL,
  `tccr_tracking_courier_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_unique_check_failed_attempt` (
  `ucfattempt_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ucfattempt_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_upc_codes` (
  `upc_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `upc_product_id` bigint NOT NULL,
  `upc_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_updated_record_log` (
  `urlog_id` bigint NOT NULL,
  `urlog_record_id` int NOT NULL,
  `urlog_subrecord_id` int NOT NULL,
  `urlog_record_type` int NOT NULL,
  `urlog_added_on` datetime NOT NULL,
  `urlog_executed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_upsell_products` (
  `upsell_sellerproduct_id` int NOT NULL,
  `upsell_recommend_sellerproduct_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_url_rewrite` (
  `urlrewrite_id` int NOT NULL,
  `urlrewrite_original` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `urlrewrite_custom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `urlrewrite_lang_id` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_users` (
  `user_id` int NOT NULL,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_phone` bigint DEFAULT NULL,
  `user_dob` date NOT NULL,
  `user_profile_info` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_address1` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_address2` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_zip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_country_id` int NOT NULL,
  `user_state_id` int NOT NULL,
  `user_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_is_buyer` tinyint(1) NOT NULL,
  `user_is_supplier` tinyint(1) NOT NULL,
  `user_parent` int NOT NULL,
  `user_is_advertiser` tinyint NOT NULL,
  `user_is_affiliate` tinyint NOT NULL,
  `user_is_shipping_company` tinyint(1) NOT NULL,
  `user_autorenew_subscription` tinyint NOT NULL,
  `user_fb_access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_referral_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_referrer_user_id` int NOT NULL COMMENT 'Using Share&Earn Module from buyer promotion',
  `user_affiliate_referrer_user_id` int NOT NULL,
  `user_preferred_dashboard` tinyint NOT NULL,
  `user_regdate` datetime NOT NULL,
  `user_company` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_products_services` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_affiliate_commission` decimal(10,2) NOT NULL COMMENT 'filled only when user_is_affiliate = 1',
  `user_registered_initially_for` int NOT NULL COMMENT 'user type defined in user model',
  `user_order_tracking_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_has_valid_subscription` tinyint(1) NOT NULL COMMENT 'For sellers.',
  `user_updated_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_deleted` tinyint(1) NOT NULL,
  `user_is_guest` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DELIMITER $$
CREATE TRIGGER `ON_USERS_UPDATE` AFTER UPDATE ON `tbl_users` FOR EACH ROW BEGIN
                IF NEW.user_deleted != OLD.user_deleted THEN
                    CALL updateShopUserValid(NEW.user_id);
                END IF;      
            END
$$
DELIMITER ;

CREATE TABLE `tbl_user_auth_token` (
  `uauth_user_id` int NOT NULL,
  `uauth_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uauth_fcm_id` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uauth_device_os` tinyint(1) NOT NULL COMMENT 'Defined In User Model',
  `uauth_user_type` tinyint(1) NOT NULL,
  `uauth_expiry` datetime NOT NULL,
  `uauth_browser` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uauth_last_access` datetime NOT NULL,
  `uauth_last_ip` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='To store cookies information';


CREATE TABLE `tbl_user_bank_details` (
  `ub_user_id` int NOT NULL,
  `ub_bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ub_account_holder_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ub_account_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ub_ifsc_swift_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ub_bank_address` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_cart` (
  `usercart_user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usercart_type` int NOT NULL,
  `usercart_details` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usercart_added_date` datetime NOT NULL,
  `usercart_sent_reminder` int NOT NULL,
  `usercart_reminder_date` datetime NOT NULL,
  `usercart_last_used_date` datetime NOT NULL,
  `usercart_last_session_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_collections` (
  `uc_user_id` int NOT NULL,
  `uc_type` int NOT NULL,
  `uc_record_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_user_cookies_preferences` (
  `ucp_user_id` int NOT NULL,
  `ucp_statistical` tinyint(1) NOT NULL,
  `ucp_personalized` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_credentials` (
  `credential_user_id` int NOT NULL,
  `credential_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `credential_email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `credential_password_old` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `credential_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `credential_active` tinyint NOT NULL,
  `credential_verified` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DELIMITER $$
CREATE TRIGGER `ON_USER_CREDENTIALS_INSERT` AFTER INSERT ON `tbl_user_credentials` FOR EACH ROW BEGIN
                CALL updateShopUserValid(NEW.credential_user_id);
            END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ON_USER_CREDENTIALS_UPDATE` AFTER UPDATE ON `tbl_user_credentials` FOR EACH ROW BEGIN
                IF NEW.credential_active != OLD.credential_active OR NEW.credential_verified != OLD.credential_verified THEN
                    CALL updateShopUserValid(NEW.credential_user_id);
                END IF;     
            END
$$
DELIMITER ;

CREATE TABLE `tbl_user_email_verification` (
  `uev_user_id` int NOT NULL,
  `uev_token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uev_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_extras` (
  `uextra_id` int NOT NULL,
  `uextra_user_id` int NOT NULL,
  `uextra_company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uextra_website` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uextra_tax_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uextra_payment_method` int NOT NULL COMMENT 'constant defined in user model',
  `uextra_cheque_payee_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uextra_paypal_email_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_user_favourite_products` (
  `ufp_id` int NOT NULL,
  `ufp_user_id` int NOT NULL,
  `ufp_selprod_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_favourite_shops` (
  `ufs_id` int NOT NULL,
  `ufs_user_id` int NOT NULL,
  `ufs_shop_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_meta` (
  `usermeta_user_id` int NOT NULL,
  `usermeta_key` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usermeta_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_notifications` (
  `unotification_id` bigint NOT NULL,
  `unotification_user_id` int NOT NULL,
  `unotification_body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unotification_date` datetime NOT NULL,
  `unotification_is_read` tinyint(1) NOT NULL,
  `unotification_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unotification_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_password_reset_requests` (
  `uprr_user_id` int NOT NULL,
  `uprr_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uprr_expiry` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_user_permissions` (
  `userperm_user_id` int NOT NULL,
  `userperm_section_id` int NOT NULL,
  `userperm_value` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_phone_verification` (
  `upv_user_id` int NOT NULL,
  `upv_otp` int NOT NULL,
  `upv_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `upv_phone` bigint NOT NULL,
  `upv_expired_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_user_product_recommendation` (
  `upr_user_id` int NOT NULL,
  `upr_product_id` bigint NOT NULL,
  `upr_weightage` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_user_requests_history` (
  `ureq_id` int NOT NULL,
  `ureq_user_id` int NOT NULL,
  `ureq_type` tinyint NOT NULL,
  `ureq_purpose` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ureq_status` tinyint NOT NULL,
  `ureq_date` datetime NOT NULL,
  `ureq_approved_date` datetime NOT NULL,
  `ureq_deleted` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_return_address` (
  `ura_user_id` int NOT NULL,
  `ura_state_id` int NOT NULL,
  `ura_country_id` int NOT NULL,
  `ura_zip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ura_phone_dcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ura_phone` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_return_address_lang` (
  `uralang_user_id` int NOT NULL,
  `uralang_lang_id` int NOT NULL,
  `ura_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ura_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ura_address_line_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ura_address_line_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_reward_points` (
  `urp_id` int NOT NULL,
  `urp_user_id` int NOT NULL,
  `urp_referral_user_id` int NOT NULL,
  `urp_points` int NOT NULL,
  `urp_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `urp_used_order_id` bigint NOT NULL,
  `urp_date_added` datetime NOT NULL,
  `urp_date_expiry` date NOT NULL,
  `urp_used` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_reward_point_breakup` (
  `urpbreakup_id` int NOT NULL,
  `urpbreakup_urp_id` int NOT NULL,
  `urpbreakup_points` int NOT NULL,
  `urpbreakup_expiry` date NOT NULL,
  `urpbreakup_used` tinyint(1) NOT NULL,
  `urpbreakup_referral_user_id` int NOT NULL,
  `urpbreakup_used_order_id` bigint NOT NULL,
  `urpbreakup_used_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_supplier_form_fields` (
  `sformfield_id` int NOT NULL,
  `sformfield_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sformfield_type` int NOT NULL,
  `sformfield_required` tinyint(1) NOT NULL,
  `sformfield_display_order` int NOT NULL,
  `sformfield_mandatory` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_supplier_form_fields_lang` (
  `sformfieldlang_sformfield_id` int NOT NULL,
  `sformfieldlang_lang_id` int NOT NULL,
  `sformfield_caption` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sformfield_comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_supplier_requests` (
  `usuprequest_id` bigint NOT NULL,
  `usuprequest_reference` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usuprequest_user_id` bigint NOT NULL,
  `usuprequest_date` datetime NOT NULL,
  `usuprequest_status` tinyint(1) NOT NULL,
  `usuprequest_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usuprequest_attempts` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_supplier_request_values` (
  `sfreqvalue_id` bigint NOT NULL,
  `sfreqvalue_request_id` int NOT NULL,
  `sfreqvalue_formfield_id` int NOT NULL,
  `sfreqvalue_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_supplier_request_values_lang` (
  `sfreqvaluelang_sfreqvalue_id` int NOT NULL,
  `sfreqvaluelang_lang_id` int NOT NULL,
  `sfreqvalue_sformfield_caption` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_temp_token_requests` (
  `uttr_user_id` int NOT NULL,
  `uttr_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uttr_expiry` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_user_transactions` (
  `utxn_id` bigint NOT NULL,
  `utxn_user_id` int NOT NULL,
  `utxn_date` datetime NOT NULL,
  `utxn_credit` decimal(10,2) NOT NULL,
  `utxn_debit` decimal(10,2) NOT NULL,
  `utxn_gateway_txn_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `utxn_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `utxn_status` tinyint(1) NOT NULL,
  `utxn_order_id` bigint NOT NULL,
  `utxn_op_id` bigint UNSIGNED NOT NULL,
  `utxn_withdrawal_id` int NOT NULL,
  `utxn_type` int NOT NULL COMMENT 'defined in transactions model'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_wish_lists` (
  `uwlist_id` int NOT NULL,
  `uwlist_type` int NOT NULL,
  `uwlist_user_id` int NOT NULL,
  `uwlist_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uwlist_added_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_wish_list_products` (
  `uwlp_uwlist_id` int NOT NULL,
  `uwlp_selprod_id` int UNSIGNED NOT NULL,
  `uwlp_added_on` datetime NOT NULL,
  `uwlp_sent_reminder` int NOT NULL,
  `uwlp_reminder_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_withdrawal_requests` (
  `withdrawal_id` bigint NOT NULL,
  `withdrawal_user_id` int NOT NULL,
  `withdrawal_payment_method` int NOT NULL COMMENT 'defined in user model',
  `withdrawal_amount` decimal(10,2) NOT NULL,
  `withdrawal_bank` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_account_holder_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_account_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_ifc_swift_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_bank_address` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_instructions` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_request_date` datetime NOT NULL,
  `withdrawal_status` tinyint(1) NOT NULL,
  `withdrawal_cheque_payee_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_paypal_email_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `withdrawal_comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_user_withdrawal_requests_specifics` (
  `uwrs_withdrawal_id` int NOT NULL,
  `uwrs_key` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uwrs_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tbl_zones` (
  `zone_id` int NOT NULL,
  `zone_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `zone_active` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `tbl_zones_lang` (
  `zonelang_zone_id` int NOT NULL,
  `zonelang_lang_id` int NOT NULL,
  `zone_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `tbl_abandoned_cart`
  ADD PRIMARY KEY (`abandonedcart_id`);

ALTER TABLE `tbl_abusive_words`
  ADD PRIMARY KEY (`abusive_id`),
  ADD UNIQUE KEY `abusive_word` (`abusive_keyword`,`abusive_lang_id`);

ALTER TABLE `tbl_addresses`
  ADD PRIMARY KEY (`addr_id`);

ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`admin_id`);

ALTER TABLE `tbl_admin_auth_token`
  ADD PRIMARY KEY (`admauth_token`),
  ADD KEY `admrm_admin_id` (`admauth_admin_id`);

ALTER TABLE `tbl_admin_permissions`
  ADD PRIMARY KEY (`admperm_admin_id`,`admperm_section_id`);

ALTER TABLE `tbl_ads_batches`
  ADD PRIMARY KEY (`adsbatch_id`);

ALTER TABLE `tbl_ads_batch_products`
  ADD PRIMARY KEY (`abprod_adsbatch_id`,`abprod_selprod_id`);

ALTER TABLE `tbl_affiliate_commission_settings`
  ADD PRIMARY KEY (`afcommsetting_id`),
  ADD UNIQUE KEY `afcommsetting_prodcat_id` (`afcommsetting_prodcat_id`,`afcommsetting_user_id`);

ALTER TABLE `tbl_affiliate_commission_setting_history`
  ADD PRIMARY KEY (`acsh_id`);

ALTER TABLE `tbl_attached_files`
  ADD PRIMARY KEY (`afile_id`),
  ADD KEY `afile_type` (`afile_type`,`afile_record_id`,`afile_record_subid`,`afile_lang_id`) USING BTREE,
  ADD KEY `afile_display_order` (`afile_display_order`),
  ADD KEY `afile_screen` (`afile_screen`);

ALTER TABLE `tbl_attached_files_temp`
  ADD PRIMARY KEY (`afile_id`),
  ADD KEY `afile_type` (`afile_type`,`afile_record_id`,`afile_record_subid`,`afile_lang_id`) USING BTREE;

ALTER TABLE `tbl_attribute_groups`
  ADD PRIMARY KEY (`attrgrp_id`);

ALTER TABLE `tbl_attribute_group_attributes`
  ADD PRIMARY KEY (`attr_id`),
  ADD UNIQUE KEY `attr_attrgrp_id_2` (`attr_attrgrp_id`,`attr_fld_name`),
  ADD KEY `attr_attrgrp_id` (`attr_attrgrp_id`);

ALTER TABLE `tbl_attribute_group_attributes_lang`
  ADD PRIMARY KEY (`attrlang_attr_id`,`attrlang_lang_id`);

ALTER TABLE `tbl_badges`
  ADD PRIMARY KEY (`badge_id`),
  ADD UNIQUE KEY `badge_identifier` (`badge_identifier`,`badge_type`),
  ADD KEY `badge_active` (`badge_active`);

ALTER TABLE `tbl_badges_lang`
  ADD PRIMARY KEY (`badgelang_badge_id`,`badgelang_lang_id`);

ALTER TABLE `tbl_badge_links`
  ADD PRIMARY KEY (`badgelink_id`),
  ADD UNIQUE KEY `badgelink_blinkcond_id` (`badgelink_blinkcond_id`,`badgelink_record_id`);

ALTER TABLE `tbl_badge_link_conditions`
  ADD PRIMARY KEY (`blinkcond_id`),
  ADD KEY `blinkcond_record_type` (`blinkcond_record_type`),
  ADD KEY `blinkcond_position` (`blinkcond_position`);

ALTER TABLE `tbl_badge_requests`
  ADD PRIMARY KEY (`breq_id`);

ALTER TABLE `tbl_banners`
  ADD PRIMARY KEY (`banner_id`);

ALTER TABLE `tbl_banners_clicks`
  ADD UNIQUE KEY `pbhistory_id` (`bclick_id`),
  ADD UNIQUE KEY `pclick_promotion_id` (`bclick_banner_id`,`bclick_ip`,`bclick_session_id`);

ALTER TABLE `tbl_banners_lang`
  ADD PRIMARY KEY (`bannerlang_banner_id`,`bannerlang_lang_id`);

ALTER TABLE `tbl_banners_logs`
  ADD UNIQUE KEY `lprom_id` (`lbanner_banner_id`,`lbanner_date`);

ALTER TABLE `tbl_banner_locations`
  ADD PRIMARY KEY (`blocation_id`);

ALTER TABLE `tbl_banner_locations_lang`
  ADD PRIMARY KEY (`blocationlang_blocation_id`,`blocationlang_lang_id`);

ALTER TABLE `tbl_banner_location_dimensions`
  ADD PRIMARY KEY (`bldimension_blocation_id`,`bldimension_device_type`);

ALTER TABLE `tbl_blog_contributions`
  ADD PRIMARY KEY (`bcontributions_id`);

ALTER TABLE `tbl_blog_post`
  ADD PRIMARY KEY (`post_id`);

ALTER TABLE `tbl_blog_post_categories`
  ADD PRIMARY KEY (`bpcategory_id`),
  ADD UNIQUE KEY `bpcategory_identifier` (`bpcategory_identifier`);

ALTER TABLE `tbl_blog_post_categories_lang`
  ADD PRIMARY KEY (`bpcategorylang_bpcategory_id`,`bpcategorylang_lang_id`);

ALTER TABLE `tbl_blog_post_comments`
  ADD PRIMARY KEY (`bpcomment_id`);

ALTER TABLE `tbl_blog_post_lang`
  ADD PRIMARY KEY (`postlang_post_id`,`postlang_lang_id`);

ALTER TABLE `tbl_blog_post_to_category`
  ADD PRIMARY KEY (`ptc_bpcategory_id`,`ptc_post_id`);

ALTER TABLE `tbl_brands`
  ADD PRIMARY KEY (`brand_id`),
  ADD UNIQUE KEY `brand_identifier` (`brand_identifier`),
  ADD KEY `brand_active` (`brand_active`),
  ADD KEY `brand_deleted` (`brand_deleted`);

ALTER TABLE `tbl_brands_lang`
  ADD PRIMARY KEY (`brandlang_brand_id`,`brandlang_lang_id`),
  ADD UNIQUE KEY `brandlang_lang_id` (`brandlang_lang_id`,`brand_name`);

ALTER TABLE `tbl_calculative_data`
  ADD PRIMARY KEY (`cd_key`);

ALTER TABLE `tbl_catalog_request_messages`
  ADD PRIMARY KEY (`scatrequestmsg_id`);

ALTER TABLE `tbl_collections`
  ADD PRIMARY KEY (`collection_id`),
  ADD UNIQUE KEY `collection_identifier` (`collection_identifier`);

ALTER TABLE `tbl_collections_lang`
  ADD PRIMARY KEY (`collectionlang_collection_id`,`collectionlang_lang_id`);

ALTER TABLE `tbl_collection_to_records`
  ADD PRIMARY KEY (`ctr_collection_id`,`ctr_record_id`);

ALTER TABLE `tbl_commission_settings`
  ADD PRIMARY KEY (`commsetting_id`),
  ADD UNIQUE KEY `commsetting_id` (`commsetting_id`),
  ADD UNIQUE KEY `commsetting_product_id` (`commsetting_product_id`,`commsetting_user_id`,`commsetting_prodcat_id`);

ALTER TABLE `tbl_commission_setting_history`
  ADD PRIMARY KEY (`csh_id`);

ALTER TABLE `tbl_configurations`
  ADD PRIMARY KEY (`conf_name`);

ALTER TABLE `tbl_content_block_to_category`
  ADD PRIMARY KEY (`cbtc_prodcat_id`,`cbtc_cpage_id`);

ALTER TABLE `tbl_content_pages`
  ADD PRIMARY KEY (`cpage_id`);

ALTER TABLE `tbl_content_pages_block_lang`
  ADD PRIMARY KEY (`cpblocklang_id`),
  ADD UNIQUE KEY `cpblocklang_lang_id` (`cpblocklang_lang_id`,`cpblocklang_cpage_id`,`cpblocklang_block_id`);

ALTER TABLE `tbl_content_pages_lang`
  ADD PRIMARY KEY (`cpagelang_cpage_id`,`cpagelang_lang_id`);

ALTER TABLE `tbl_countries`
  ADD PRIMARY KEY (`country_id`),
  ADD UNIQUE KEY `country_code` (`country_code`);

ALTER TABLE `tbl_countries_lang`
  ADD PRIMARY KEY (`countrylang_country_id`,`countrylang_lang_id`),
  ADD UNIQUE KEY `countrylang_lang_id` (`countrylang_lang_id`,`country_name`);

ALTER TABLE `tbl_coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD UNIQUE KEY `coupon_code` (`coupon_code`);

ALTER TABLE `tbl_coupons_history`
  ADD PRIMARY KEY (`couponhistory_id`);

ALTER TABLE `tbl_coupons_hold`
  ADD PRIMARY KEY (`couponhold_id`),
  ADD UNIQUE KEY `couponhold_coupon_id` (`couponhold_coupon_id`,`couponhold_user_id`);

ALTER TABLE `tbl_coupons_hold_pending_order`
  ADD PRIMARY KEY (`ochold_order_id`,`ochold_coupon_id`);

ALTER TABLE `tbl_coupons_lang`
  ADD PRIMARY KEY (`couponlang_coupon_id`,`couponlang_lang_id`);

ALTER TABLE `tbl_coupon_to_brands`
  ADD UNIQUE KEY `ctp_brand_id` (`ctb_brand_id`,`ctb_coupon_id`);

ALTER TABLE `tbl_coupon_to_category`
  ADD PRIMARY KEY (`ctc_prodcat_id`,`ctc_coupon_id`);

ALTER TABLE `tbl_coupon_to_plan`
  ADD PRIMARY KEY (`ctplan_spplan_id`,`ctplan_coupon_id`);

ALTER TABLE `tbl_coupon_to_products`
  ADD PRIMARY KEY (`ctp_product_id`,`ctp_coupon_id`);

ALTER TABLE `tbl_coupon_to_seller`
  ADD PRIMARY KEY (`cts_user_id`,`cts_coupon_id`);

ALTER TABLE `tbl_coupon_to_shops`
  ADD PRIMARY KEY (`cts_shop_id`,`cts_coupon_id`);

ALTER TABLE `tbl_coupon_to_users`
  ADD PRIMARY KEY (`ctu_user_id`,`ctu_coupon_id`);

ALTER TABLE `tbl_cron_log`
  ADD PRIMARY KEY (`cronlog_id`),
  ADD KEY `cronlog_cron_id` (`cronlog_cron_id`);

ALTER TABLE `tbl_cron_schedules`
  ADD PRIMARY KEY (`cron_id`);

ALTER TABLE `tbl_currency`
  ADD PRIMARY KEY (`currency_id`),
  ADD UNIQUE KEY `currency_code` (`currency_code`);

ALTER TABLE `tbl_currency_lang`
  ADD PRIMARY KEY (`currencylang_currency_id`,`currencylang_lang_id`);

ALTER TABLE `tbl_email_archives`
  ADD PRIMARY KEY (`earch_id`);

ALTER TABLE `tbl_email_templates`
  ADD PRIMARY KEY (`etpl_code`,`etpl_lang_id`);

ALTER TABLE `tbl_empty_cart_items`
  ADD PRIMARY KEY (`emptycartitem_id`);

ALTER TABLE `tbl_empty_cart_items_lang`
  ADD UNIQUE KEY `emptycartitemlang_emptycartitem_id` (`emptycartitemlang_emptycartitem_id`,`emptycartitemlang_lang_id`);

ALTER TABLE `tbl_extra_attributes`
  ADD PRIMARY KEY (`eattribute_id`),
  ADD KEY `eattribute_eattrgroup_id` (`eattribute_eattrgroup_id`);

ALTER TABLE `tbl_extra_attributes_lang`
  ADD UNIQUE KEY `eattribute_eattribute_id` (`eattributelang_eattribute_id`,`eattributelang_lang_id`);

ALTER TABLE `tbl_extra_attribute_groups`
  ADD PRIMARY KEY (`eattrgroup_id`);

ALTER TABLE `tbl_extra_attribute_groups_lang`
  ADD UNIQUE KEY `eattrgrouplang_eattrgroup_id` (`eattrgrouplang_eattrgroup_id`,`eattrgrouplang_lang_id`);

ALTER TABLE `tbl_extra_pages`
  ADD PRIMARY KEY (`epage_id`),
  ADD UNIQUE KEY `epage_type` (`epage_type`);

ALTER TABLE `tbl_extra_pages_lang`
  ADD PRIMARY KEY (`epagelang_epage_id`,`epagelang_lang_id`);

ALTER TABLE `tbl_faqs`
  ADD PRIMARY KEY (`faq_id`);

ALTER TABLE `tbl_faqs_lang`
  ADD PRIMARY KEY (`faqlang_faq_id`,`faqlang_lang_id`);

ALTER TABLE `tbl_faq_categories`
  ADD PRIMARY KEY (`faqcat_id`);

ALTER TABLE `tbl_faq_categories_lang`
  ADD PRIMARY KEY (`faqcatlang_faqcat_id`,`faqcatlang_lang_id`);

ALTER TABLE `tbl_filters`
  ADD PRIMARY KEY (`filter_id`);

ALTER TABLE `tbl_filters_lang`
  ADD PRIMARY KEY (`filterlang_filter_id`,`filterlang_lang_id`);

ALTER TABLE `tbl_filter_groups`
  ADD PRIMARY KEY (`filtergroup_id`);

ALTER TABLE `tbl_filter_groups_lang`
  ADD UNIQUE KEY `filtergrouplang_filtergroup_id` (`filtergrouplang_filtergroup_id`,`filtergrouplang_lang_id`);

ALTER TABLE `tbl_help_center`
  ADD PRIMARY KEY (`hc_id`),
  ADD UNIQUE KEY `hc_user_type` (`hc_user_type`,`hc_controller`,`hc_action`);

ALTER TABLE `tbl_help_center_lang`
  ADD UNIQUE KEY `hclang_hc_id` (`hclang_hc_id`,`hclang_lang_id`);

ALTER TABLE `tbl_import_export_settings`
  ADD PRIMARY KEY (`impexp_setting_key`,`impexp_setting_user_id`);

ALTER TABLE `tbl_languages`
  ADD PRIMARY KEY (`language_id`);

ALTER TABLE `tbl_language_labels`
  ADD PRIMARY KEY (`label_id`),
  ADD UNIQUE KEY `label_key` (`label_key`,`label_lang_id`);

ALTER TABLE `tbl_layout_templates`
  ADD PRIMARY KEY (`ltemplate_id`);

ALTER TABLE `tbl_manual_shipping_api`
  ADD PRIMARY KEY (`mshipapi_id`);

ALTER TABLE `tbl_manual_shipping_api_lang`
  ADD PRIMARY KEY (`mshipapilang_mshipapi_id`,`mshipapilang_lang_id`);

ALTER TABLE `tbl_meta_tags`
  ADD PRIMARY KEY (`meta_id`),
  ADD UNIQUE KEY `meta_controller` (`meta_controller`,`meta_action`,`meta_record_id`,`meta_subrecord_id`) USING BTREE,
  ADD KEY `meta_record_id` (`meta_record_id`),
  ADD KEY `meta_subrecord_id` (`meta_subrecord_id`);

ALTER TABLE `tbl_meta_tags_lang`
  ADD PRIMARY KEY (`metalang_meta_id`,`metalang_lang_id`);

ALTER TABLE `tbl_navigations`
  ADD PRIMARY KEY (`nav_id`),
  ADD UNIQUE KEY `nav_identifier` (`nav_identifier`);

ALTER TABLE `tbl_navigations_lang`
  ADD PRIMARY KEY (`navlang_nav_id`,`navlang_lang_id`);

ALTER TABLE `tbl_navigation_links`
  ADD PRIMARY KEY (`nlink_id`);

ALTER TABLE `tbl_navigation_links_lang`
  ADD PRIMARY KEY (`nlinklang_nlink_id`,`nlinklang_lang_id`);

ALTER TABLE `tbl_notifications`
  ADD PRIMARY KEY (`notification_id`);

ALTER TABLE `tbl_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_identifier` (`option_identifier`);

ALTER TABLE `tbl_options_lang`
  ADD PRIMARY KEY (`optionlang_option_id`,`optionlang_lang_id`);

ALTER TABLE `tbl_option_values`
  ADD PRIMARY KEY (`optionvalue_id`),
  ADD UNIQUE KEY `optionvalue_option_id` (`optionvalue_option_id`,`optionvalue_identifier`);

ALTER TABLE `tbl_option_values_lang`
  ADD PRIMARY KEY (`optionvaluelang_optionvalue_id`,`optionvaluelang_lang_id`);

ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_id` (`order_number`),
  ADD KEY `Index` (`order_user_id`),
  ADD KEY `order_date_added` (`order_date_added`),
  ADD KEY `order_payment_status` (`order_payment_status`);

ALTER TABLE `tbl_orders_lang`
  ADD PRIMARY KEY (`orderlang_order_id`,`orderlang_lang_id`);

ALTER TABLE `tbl_orders_status`
  ADD PRIMARY KEY (`orderstatus_id`),
  ADD UNIQUE KEY `orderstatus_identifier` (`orderstatus_identifier`);

ALTER TABLE `tbl_orders_status_history`
  ADD PRIMARY KEY (`oshistory_id`);

ALTER TABLE `tbl_orders_status_lang`
  ADD PRIMARY KEY (`orderstatuslang_orderstatus_id`,`orderstatuslang_lang_id`);

ALTER TABLE `tbl_orders_to_plugin_order`
  ADD UNIQUE KEY `opo_order_id` (`opo_order_id`,`opo_plugin_id`,`opo_plugin_order_id`);

ALTER TABLE `tbl_order_cancel_reasons`
  ADD PRIMARY KEY (`ocreason_id`),
  ADD UNIQUE KEY `ocreason_identifier` (`ocreason_identifier`);

ALTER TABLE `tbl_order_cancel_reasons_lang`
  ADD PRIMARY KEY (`ocreasonlang_ocreason_id`,`ocreasonlang_lang_id`);

ALTER TABLE `tbl_order_cancel_requests`
  ADD PRIMARY KEY (`ocrequest_id`);

ALTER TABLE `tbl_order_extras`
  ADD PRIMARY KEY (`oextra_order_id`);

ALTER TABLE `tbl_order_gift_cards`
  ADD PRIMARY KEY (`ogcards_id`);

ALTER TABLE `tbl_order_payments`
  ADD PRIMARY KEY (`opayment_id`),
  ADD UNIQUE KEY `opayment_order_id` (`opayment_order_id`,`opayment_gateway_txn_id`),
  ADD KEY `opayment_txn_status` (`opayment_txn_status`);

ALTER TABLE `tbl_order_products`
  ADD PRIMARY KEY (`op_id`),
  ADD UNIQUE KEY `op_invoice_number` (`op_invoice_number`),
  ADD KEY `op_status_id` (`op_status_id`),
  ADD KEY `op_order_id` (`op_order_id`),
  ADD KEY `op_selprod_user_id` (`op_selprod_user_id`);

ALTER TABLE `tbl_order_products_lang`
  ADD PRIMARY KEY (`oplang_op_id`,`oplang_lang_id`);

ALTER TABLE `tbl_order_product_charges`
  ADD PRIMARY KEY (`opcharge_id`),
  ADD KEY `opcharge_op_id_2` (`opcharge_op_id`);

ALTER TABLE `tbl_order_product_charges_lang`
  ADD PRIMARY KEY (`opchargelang_opcharge_id`,`opchargelang_lang_id`);

ALTER TABLE `tbl_order_product_digital_download_links`
  ADD PRIMARY KEY (`opddl_link_id`);

ALTER TABLE `tbl_order_product_plugin_specifics`
  ADD UNIQUE KEY `opps_op_id` (`opps_op_id`,`opps_plugin_id`);

ALTER TABLE `tbl_order_product_responses`
  ADD PRIMARY KEY (`opr_op_id`,`opr_type`);

ALTER TABLE `tbl_order_product_settings`
  ADD UNIQUE KEY `opsetting_op_id` (`opsetting_op_id`);

ALTER TABLE `tbl_order_product_shipment`
  ADD PRIMARY KEY (`opship_op_id`);

ALTER TABLE `tbl_order_product_shipment_pickup`
  ADD UNIQUE KEY `opps_op_id` (`opsp_op_id`);

ALTER TABLE `tbl_order_product_shipping`
  ADD UNIQUE KEY `opshipping_op_id` (`opshipping_op_id`);

ALTER TABLE `tbl_order_product_specifics`
  ADD PRIMARY KEY (`ops_op_id`);

ALTER TABLE `tbl_order_product_to_shipping_users`
  ADD PRIMARY KEY (`optsu_op_id`,`optsu_user_id`);

ALTER TABLE `tbl_order_prod_charges_logs`
  ADD PRIMARY KEY (`opchargelog_id`),
  ADD KEY `opchargelog_op_id` (`opchargelog_op_id`);

ALTER TABLE `tbl_order_return_reasons`
  ADD PRIMARY KEY (`orreason_id`),
  ADD UNIQUE KEY `orreason_identifier` (`orreason_identifier`);

ALTER TABLE `tbl_order_return_reasons_lang`
  ADD PRIMARY KEY (`orreasonlang_orreason_id`,`orreasonlang_lang_id`);

ALTER TABLE `tbl_order_return_requests`
  ADD PRIMARY KEY (`orrequest_id`),
  ADD KEY `orrequest_user_id` (`orrequest_user_id`);

ALTER TABLE `tbl_order_return_request_messages`
  ADD PRIMARY KEY (`orrmsg_id`);

ALTER TABLE `tbl_order_seller_subscriptions`
  ADD PRIMARY KEY (`ossubs_id`),
  ADD KEY `ossubs_invoice_number` (`ossubs_invoice_number`),
  ADD KEY `ossubs_order_id` (`ossubs_order_id`);

ALTER TABLE `tbl_order_seller_subscriptions_lang`
  ADD PRIMARY KEY (`ossubslang_ossubs_id`,`ossubslang_lang_id`);

ALTER TABLE `tbl_order_user_address`
  ADD PRIMARY KEY (`oua_order_id`,`oua_op_id`,`oua_type`);

ALTER TABLE `tbl_pages_language_data`
  ADD PRIMARY KEY (`plang_id`),
  ADD UNIQUE KEY `plang_key` (`plang_key`,`plang_lang_id`);

ALTER TABLE `tbl_plugins`
  ADD PRIMARY KEY (`plugin_id`),
  ADD UNIQUE KEY `plugin_identifier` (`plugin_identifier`),
  ADD UNIQUE KEY `plugin_code` (`plugin_code`),
  ADD KEY `plugin_type` (`plugin_type`,`plugin_active`);

ALTER TABLE `tbl_plugins_lang`
  ADD PRIMARY KEY (`pluginlang_plugin_id`,`pluginlang_lang_id`);

ALTER TABLE `tbl_plugin_settings`
  ADD PRIMARY KEY (`pluginsetting_plugin_id`,`pluginsetting_record_id`,`pluginsetting_key`);

ALTER TABLE `tbl_plugin_to_user`
  ADD PRIMARY KEY (`pu_plugin_id`,`pu_user_id`);

ALTER TABLE `tbl_policy_points`
  ADD PRIMARY KEY (`ppoint_id`),
  ADD UNIQUE KEY `ppoint_identifier` (`ppoint_identifier`);

ALTER TABLE `tbl_policy_points_lang`
  ADD PRIMARY KEY (`ppointlang_ppoint_id`,`ppointlang_lang_id`);

ALTER TABLE `tbl_polling`
  ADD PRIMARY KEY (`polling_id`);

ALTER TABLE `tbl_polling_feedback`
  ADD PRIMARY KEY (`pollfeedback_id`),
  ADD UNIQUE KEY `pollfeedback_polling_id` (`pollfeedback_polling_id`,`pollfeedback_response_ip`);

ALTER TABLE `tbl_polling_lang`
  ADD PRIMARY KEY (`pollinglang_polling_id`,`pollinglang_lang_id`);

ALTER TABLE `tbl_polling_to_category`
  ADD PRIMARY KEY (`ptc_polling_id`,`ptc_prodcat_id`);

ALTER TABLE `tbl_polling_to_products`
  ADD PRIMARY KEY (`ptp_polling_id`,`ptp_product_id`);

ALTER TABLE `tbl_prodcat_rating_types`
  ADD PRIMARY KEY (`prt_prodcat_id`,`prt_ratingtype_id`);

ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `product_identifier` (`product_identifier`),
  ADD KEY `product_seller_id` (`product_seller_id`),
  ADD KEY `product_brand_id` (`product_brand_id`),
  ADD KEY `product_ship_package` (`product_ship_package`),
  ADD KEY `product_ship_package_2` (`product_ship_package`);

ALTER TABLE `tbl_products_browsing_history`
  ADD PRIMARY KEY (`pbhistory_id`),
  ADD UNIQUE KEY `pbhistory_sessionid` (`pbhistory_sessionid`,`pbhistory_selprod_code`,`pbhistory_swsetting_key`);

ALTER TABLE `tbl_products_lang`
  ADD UNIQUE KEY `productlang_product_id` (`productlang_product_id`,`productlang_lang_id`);

ALTER TABLE `tbl_products_min_price`
  ADD PRIMARY KEY (`pmp_product_id`);

ALTER TABLE `tbl_products_shipped_by_seller`
  ADD PRIMARY KEY (`psbs_product_id`,`psbs_user_id`);

ALTER TABLE `tbl_products_shipping`
  ADD PRIMARY KEY (`ps_product_id`,`ps_user_id`);

ALTER TABLE `tbl_products_temp_ids`
  ADD PRIMARY KEY (`pti_product_temp_id`,`pti_user_id`);

ALTER TABLE `tbl_products_to_plugin_product`
  ADD UNIQUE KEY `ptpp_product_id` (`ptpp_product_id`,`ptpp_plugin_id`,`ptpp_plugin_product_id`);

ALTER TABLE `tbl_product_ai_enrichment`
  ADD PRIMARY KEY (`pae_id`),
  ADD UNIQUE KEY `uniq_product` (`pae_product_id`);

ALTER TABLE `tbl_product_categories`
  ADD PRIMARY KEY (`prodcat_id`),
  ADD UNIQUE KEY `prodcat_identifier` (`prodcat_identifier`),
  ADD KEY `prodcat_parent` (`prodcat_parent`),
  ADD KEY `prodcat_code` (`prodcat_code`),
  ADD KEY `prodcat_code_2` (`prodcat_code`);

ALTER TABLE `tbl_product_categories_lang`
  ADD UNIQUE KEY `prodcatlang_prodcat_id` (`prodcatlang_prodcat_id`,`prodcatlang_lang_id`);

ALTER TABLE `tbl_product_category_relations`
  ADD PRIMARY KEY (`pcr_prodcat_id`,`pcr_parent_id`),
  ADD KEY `pcr_parent_id` (`pcr_parent_id`);

ALTER TABLE `tbl_product_digital_data_relation`
  ADD PRIMARY KEY (`pddr_id`),
  ADD UNIQUE KEY `pdd_options_code` (`pddr_record_id`,`pddr_options_code`,`pddr_type`) USING BTREE;

ALTER TABLE `tbl_product_digital_links`
  ADD PRIMARY KEY (`pdl_id`);

ALTER TABLE `tbl_product_groups`
  ADD PRIMARY KEY (`prodgroup_id`);

ALTER TABLE `tbl_product_groups_lang`
  ADD PRIMARY KEY (`prodgrouplang_prodgroup_id`,`prodgrouplang_lang_id`);

ALTER TABLE `tbl_product_numeric_attributes`
  ADD PRIMARY KEY (`prodnumattr_product_id`);

ALTER TABLE `tbl_product_product_recommendation`
  ADD PRIMARY KEY (`ppr_viewing_product_id`,`ppr_recommended_product_id`);

ALTER TABLE `tbl_product_requests`
  ADD PRIMARY KEY (`preq_id`),
  ADD UNIQUE KEY `preq_product_identifier` (`preq_product_identifier`);

ALTER TABLE `tbl_product_requests_lang`
  ADD PRIMARY KEY (`preqlang_preq_id`,`preqlang_lang_id`);

ALTER TABLE `tbl_product_saved_search`
  ADD PRIMARY KEY (`pssearch_id`);

ALTER TABLE `tbl_product_shipping_rates`
  ADD PRIMARY KEY (`pship_id`),
  ADD UNIQUE KEY `pship_prod_id` (`pship_prod_id`,`pship_user_id`,`pship_country`,`pship_company`,`pship_duration`) USING BTREE;

ALTER TABLE `tbl_product_special_prices`
  ADD PRIMARY KEY (`splprice_id`),
  ADD KEY `price_selprod_id` (`splprice_selprod_id`),
  ADD KEY `splprice_price` (`splprice_price`);

ALTER TABLE `tbl_product_specifications`
  ADD PRIMARY KEY (`prodspec_id`),
  ADD KEY `prodspec_product_id` (`prodspec_product_id`);

ALTER TABLE `tbl_product_specifications_lang`
  ADD PRIMARY KEY (`prodspeclang_prodspec_id`,`prodspeclang_lang_id`);

ALTER TABLE `tbl_product_specifics`
  ADD PRIMARY KEY (`ps_product_id`);

ALTER TABLE `tbl_product_stock_hold`
  ADD PRIMARY KEY (`pshold_id`),
  ADD UNIQUE KEY `pshold_selprod_id` (`pshold_selprod_id`,`pshold_user_id`,`pshold_prodgroup_id`);

ALTER TABLE `tbl_product_text_attributes`
  ADD PRIMARY KEY (`prodtxtattr_product_id`,`prodtxtattr_lang_id`);

ALTER TABLE `tbl_product_to_category`
  ADD PRIMARY KEY (`ptc_product_id`,`ptc_prodcat_id`),
  ADD KEY `ptc_product_id` (`ptc_product_id`),
  ADD KEY `ptc_prodcat_id` (`ptc_prodcat_id`);

ALTER TABLE `tbl_product_to_groups`
  ADD PRIMARY KEY (`ptg_prodgroup_id`,`ptg_selprod_id`);

ALTER TABLE `tbl_product_to_options`
  ADD PRIMARY KEY (`prodoption_product_id`,`prodoption_option_id`),
  ADD KEY `prodoption_product_id` (`prodoption_product_id`);

ALTER TABLE `tbl_product_to_tags`
  ADD PRIMARY KEY (`ptt_product_id`,`ptt_tag_id`);

ALTER TABLE `tbl_product_to_tax`
  ADD PRIMARY KEY (`ptt_product_id`,`ptt_seller_user_id`) USING BTREE,
  ADD KEY `ptstax_product_id` (`ptt_product_id`);

ALTER TABLE `tbl_product_volume_discount`
  ADD PRIMARY KEY (`voldiscount_id`),
  ADD UNIQUE KEY `voldiscount_selprod_id` (`voldiscount_selprod_id`,`voldiscount_min_qty`);

ALTER TABLE `tbl_promotions`
  ADD PRIMARY KEY (`promotion_id`),
  ADD KEY `promotion_user_id` (`promotion_user_id`),
  ADD KEY `promotion_active` (`promotion_active`,`promotion_deleted`);

ALTER TABLE `tbl_promotions_charges`
  ADD PRIMARY KEY (`pcharge_id`),
  ADD KEY `pcharge_promotion_id` (`pcharge_promotion_id`),
  ADD KEY `pcharge_end_piclick_id` (`pcharge_end_piclick_id`);

ALTER TABLE `tbl_promotions_clicks`
  ADD PRIMARY KEY (`pclick_id`),
  ADD UNIQUE KEY `pclick_promotion_id` (`pclick_promotion_id`,`pclick_ip`,`pclick_session_id`),
  ADD KEY `pclick_promotion_id_2` (`pclick_promotion_id`);

ALTER TABLE `tbl_promotions_lang`
  ADD UNIQUE KEY `promotionlang_promotion_id` (`promotionlang_promotion_id`,`promotionlang_lang_id`);

ALTER TABLE `tbl_promotions_logs`
  ADD PRIMARY KEY (`plog_promotion_id`,`plog_date`);

ALTER TABLE `tbl_promotion_item_charges`
  ADD PRIMARY KEY (`picharge_id`),
  ADD KEY `picharge_pclick_id` (`picharge_pclick_id`);

ALTER TABLE `tbl_push_notifications`
  ADD PRIMARY KEY (`pnotification_id`);

ALTER TABLE `tbl_push_notification_to_users`
  ADD PRIMARY KEY (`pntu_pnotification_id`,`pntu_user_id`);

ALTER TABLE `tbl_questionnaires`
  ADD PRIMARY KEY (`questionnaire_id`);

ALTER TABLE `tbl_questionnaires_lang`
  ADD PRIMARY KEY (`questionnairelang_questionnaire_id`,`questionnairelang_lang_id`);

ALTER TABLE `tbl_questionnaires_to_question`
  ADD PRIMARY KEY (`qtq_questionnaire_id`,`qtq_question_id`);

ALTER TABLE `tbl_questionnaire_feedback`
  ADD PRIMARY KEY (`qfeedback_id`);

ALTER TABLE `tbl_questions`
  ADD PRIMARY KEY (`question_id`);

ALTER TABLE `tbl_questions_lang`
  ADD PRIMARY KEY (`questionlang_question_id`,`questionlang_lang_id`);

ALTER TABLE `tbl_question_banks`
  ADD PRIMARY KEY (`qbank_id`);

ALTER TABLE `tbl_question_banks_lang`
  ADD PRIMARY KEY (`qbanklang_qbank_id`,`qbanklang_lang_id`);

ALTER TABLE `tbl_question_to_answers`
  ADD PRIMARY KEY (`qta_qfeedback_id`,`qta_question_id`);

ALTER TABLE `tbl_rating_types`
  ADD PRIMARY KEY (`ratingtype_id`),
  ADD UNIQUE KEY `ratingtype_identifier` (`ratingtype_identifier`) USING BTREE;

ALTER TABLE `tbl_rating_types_lang`
  ADD PRIMARY KEY (`ratingtypelang_ratingtype_id`,`ratingtypelang_lang_id`),
  ADD UNIQUE KEY `ratingtype_name` (`ratingtypelang_lang_id`,`ratingtype_name`);

ALTER TABLE `tbl_recommendation_activity_browsing`
  ADD PRIMARY KEY (`rab_session_id`,`rab_user_id`,`rab_record_id`,`rab_record_type`,`rab_weightage_key`);

ALTER TABLE `tbl_related_products`
  ADD PRIMARY KEY (`related_sellerproduct_id`,`related_recommend_sellerproduct_id`),
  ADD KEY `related_sellerproduct_id` (`related_sellerproduct_id`);

ALTER TABLE `tbl_report_reasons`
  ADD PRIMARY KEY (`reportreason_id`),
  ADD UNIQUE KEY `reportreason_identifier` (`reportreason_identifier`);

ALTER TABLE `tbl_report_reasons_lang`
  ADD PRIMARY KEY (`reportreasonlang_reportreason_id`,`reportreasonlang_lang_id`);

ALTER TABLE `tbl_rewards_on_purchase`
  ADD PRIMARY KEY (`rop_id`);

ALTER TABLE `tbl_search_items`
  ADD PRIMARY KEY (`searchitem_id`),
  ADD UNIQUE KEY `searchitem_keyword` (`searchitem_keyword`,`searchitem_date`);

ALTER TABLE `tbl_seller_brand_requests`
  ADD PRIMARY KEY (`sbrandreq_id`);

ALTER TABLE `tbl_seller_brand_requests_lang`
  ADD UNIQUE KEY `sbrandreqlang_sbrandreq_id` (`sbrandreqlang_sbrandreq_id`,`sbrandreqlang_lang_id`);

ALTER TABLE `tbl_seller_catalog_requests`
  ADD PRIMARY KEY (`scatrequest_id`);

ALTER TABLE `tbl_seller_packages`
  ADD PRIMARY KEY (`spackage_id`);

ALTER TABLE `tbl_seller_packages_lang`
  ADD PRIMARY KEY (`spackagelang_spackage_id`,`spackagelang_lang_id`);

ALTER TABLE `tbl_seller_packages_plan`
  ADD PRIMARY KEY (`spplan_id`);

ALTER TABLE `tbl_seller_products`
  ADD PRIMARY KEY (`selprod_id`),
  ADD UNIQUE KEY `selprod_user_id_2` (`selprod_user_id`,`selprod_code`),
  ADD KEY `selprod_product_id` (`selprod_product_id`),
  ADD KEY `selprod_user_id` (`selprod_user_id`);

ALTER TABLE `tbl_seller_products_lang`
  ADD PRIMARY KEY (`selprodlang_selprod_id`,`selprodlang_lang_id`);

ALTER TABLE `tbl_seller_products_temp_ids`
  ADD PRIMARY KEY (`spti_selprod_temp_id`,`spti_user_id`);

ALTER TABLE `tbl_seller_products_to_plugin_selprod`
  ADD UNIQUE KEY `spps_selprod_id` (`spps_selprod_id`,`spps_plugin_id`,`spps_plugin_selprod_id`);

ALTER TABLE `tbl_seller_product_options`
  ADD PRIMARY KEY (`selprodoption_selprod_id`,`selprodoption_option_id`),
  ADD KEY `selprodoption_selprod_id` (`selprodoption_selprod_id`);

ALTER TABLE `tbl_seller_product_policies`
  ADD PRIMARY KEY (`sppolicy_selprod_id`,`sppolicy_ppoint_id`);

ALTER TABLE `tbl_seller_product_rating`
  ADD PRIMARY KEY (`sprating_spreview_id`,`sprating_ratingtype_id`,`sprating_rating`);

ALTER TABLE `tbl_seller_product_reviews`
  ADD PRIMARY KEY (`spreview_id`),
  ADD UNIQUE KEY `spreview_order_id` (`spreview_order_id`,`spreview_selprod_id`);

ALTER TABLE `tbl_seller_product_reviews_abuse`
  ADD PRIMARY KEY (`spra_spreview_id`,`spra_user_id`);

ALTER TABLE `tbl_seller_product_reviews_helpful`
  ADD PRIMARY KEY (`sprh_spreview_id`,`sprh_user_id`);

ALTER TABLE `tbl_seller_product_specifics`
  ADD PRIMARY KEY (`sps_selprod_id`);

ALTER TABLE `tbl_shippingapi_settings`
  ADD PRIMARY KEY (`shipsetting_shippingapi_id`,`shipsetting_key`);

ALTER TABLE `tbl_shipping_apis`
  ADD PRIMARY KEY (`shippingapi_id`),
  ADD UNIQUE KEY `shippingapi_identifier` (`shippingapi_identifier`);

ALTER TABLE `tbl_shipping_apis_lang`
  ADD PRIMARY KEY (`shippingapilang_shippingapi_id`,`shippingapilang_lang_id`);

ALTER TABLE `tbl_shipping_company`
  ADD PRIMARY KEY (`scompany_id`),
  ADD UNIQUE KEY `scompany_identifier` (`scompany_identifier`);

ALTER TABLE `tbl_shipping_company_lang`
  ADD PRIMARY KEY (`scompanylang_scompany_id`,`scompanylang_lang_id`);

ALTER TABLE `tbl_shipping_durations`
  ADD PRIMARY KEY (`sduration_id`),
  ADD UNIQUE KEY `sduration_identifier` (`sduration_identifier`);

ALTER TABLE `tbl_shipping_durations_lang`
  ADD PRIMARY KEY (`sdurationlang_sduration_id`,`sdurationlang_lang_id`);

ALTER TABLE `tbl_shipping_locations`
  ADD UNIQUE KEY `shiploc_shipzone_id` (`shiploc_shipzone_id`,`shiploc_zone_id`,`shiploc_country_id`,`shiploc_state_id`);

ALTER TABLE `tbl_shipping_packages`
  ADD PRIMARY KEY (`shippack_id`),
  ADD UNIQUE KEY `shippack_name` (`shippack_name`);

ALTER TABLE `tbl_shipping_profile`
  ADD PRIMARY KEY (`shipprofile_id`),
  ADD UNIQUE KEY `shipprofile_name` (`shipprofile_identifier`,`shipprofile_user_id`);

ALTER TABLE `tbl_shipping_profile_lang`
  ADD UNIQUE KEY `shipprofilelang_shipprofile_id` (`shipprofilelang_shipprofile_id`,`shipprofilelang_lang_id`);

ALTER TABLE `tbl_shipping_profile_products`
  ADD PRIMARY KEY (`shippro_product_id`,`shippro_user_id`);

ALTER TABLE `tbl_shipping_profile_zones`
  ADD PRIMARY KEY (`shipprozone_id`),
  ADD UNIQUE KEY `shipprozone_shipzone_id` (`shipprozone_shipzone_id`,`shipprozone_shipprofile_id`);

ALTER TABLE `tbl_shipping_rates`
  ADD PRIMARY KEY (`shiprate_id`);

ALTER TABLE `tbl_shipping_rates_lang`
  ADD PRIMARY KEY (`shipratelang_shiprate_id`,`shipratelang_lang_id`);

ALTER TABLE `tbl_shipping_zone`
  ADD PRIMARY KEY (`shipzone_id`);

ALTER TABLE `tbl_shops`
  ADD PRIMARY KEY (`shop_id`),
  ADD UNIQUE KEY `shop_user_id` (`shop_user_id`),
  ADD UNIQUE KEY `shop_identifier` (`shop_identifier`),
  ADD KEY `shop_country_id` (`shop_country_id`),
  ADD KEY `shop_state_id` (`shop_state_id`),
  ADD KEY `shop_user_valid` (`shop_user_valid`),
  ADD KEY `shop_supplier_display_status` (`shop_supplier_display_status`);

ALTER TABLE `tbl_shops_lang`
  ADD PRIMARY KEY (`shoplang_shop_id`,`shoplang_lang_id`);

ALTER TABLE `tbl_shops_to_theme`
  ADD PRIMARY KEY (`stt_id`),
  ADD UNIQUE KEY `stt_shop_id` (`stt_shop_id`);

ALTER TABLE `tbl_shop_collections`
  ADD PRIMARY KEY (`scollection_id`),
  ADD UNIQUE KEY `scollection_identifier` (`scollection_identifier`);

ALTER TABLE `tbl_shop_collections_lang`
  ADD PRIMARY KEY (`scollectionlang_scollection_id`,`scollectionlang_lang_id`);

ALTER TABLE `tbl_shop_collection_products`
  ADD PRIMARY KEY (`scp_scollection_id`,`scp_selprod_id`),
  ADD KEY `scp_shop_id` (`scp_scollection_id`);

ALTER TABLE `tbl_shop_reports`
  ADD PRIMARY KEY (`sreport_id`),
  ADD UNIQUE KEY `sreport_shop_id` (`sreport_shop_id`,`sreport_user_id`);

ALTER TABLE `tbl_shop_specifics`
  ADD PRIMARY KEY (`ss_shop_id`);

ALTER TABLE `tbl_shop_stats`
  ADD PRIMARY KEY (`sstats_shop_id`);

ALTER TABLE `tbl_slides`
  ADD PRIMARY KEY (`slide_id`);

ALTER TABLE `tbl_slides_lang`
  ADD PRIMARY KEY (`slidelang_slide_id`,`slidelang_lang_id`);

ALTER TABLE `tbl_smart_log_actions`
  ADD PRIMARY KEY (`slog_id`);

ALTER TABLE `tbl_smart_products_weightage`
  ADD PRIMARY KEY (`spw_product_id`);

ALTER TABLE `tbl_smart_remommended_products`
  ADD PRIMARY KEY (`tsrp_source_product_id`,`tsrp_recommended_product_id`);

ALTER TABLE `tbl_smart_user_activity_browsing`
  ADD PRIMARY KEY (`uab_id`),
  ADD UNIQUE KEY `uab_user_id` (`uab_user_id`,`uab_record_id`,`uab_record_type`,`uab_sub_record_code`);

ALTER TABLE `tbl_smart_weightage_settings`
  ADD PRIMARY KEY (`swsetting_key`),
  ADD UNIQUE KEY `swsetting_key` (`swsetting_name`);

ALTER TABLE `tbl_sms_archives`
  ADD PRIMARY KEY (`smsarchive_id`);

ALTER TABLE `tbl_sms_templates`
  ADD PRIMARY KEY (`stpl_code`,`stpl_lang_id`);

ALTER TABLE `tbl_social_platforms`
  ADD PRIMARY KEY (`splatform_id`),
  ADD UNIQUE KEY `splatform_user_id` (`splatform_user_id`,`splatform_identifier`);

ALTER TABLE `tbl_social_platforms_lang`
  ADD PRIMARY KEY (`splatformlang_splatform_id`,`splatformlang_lang_id`);

ALTER TABLE `tbl_states`
  ADD PRIMARY KEY (`state_id`),
  ADD UNIQUE KEY `state_country_id` (`state_country_id`,`state_identifier`),
  ADD KEY `state_active` (`state_active`);

ALTER TABLE `tbl_states_lang`
  ADD PRIMARY KEY (`statelang_state_id`,`statelang_lang_id`);

ALTER TABLE `tbl_success_stories`
  ADD PRIMARY KEY (`sstory_id`);

ALTER TABLE `tbl_success_stories_lang`
  ADD PRIMARY KEY (`sstorylang_sstory_id`,`sstorylang_lang_id`);

ALTER TABLE `tbl_system_logs`
  ADD PRIMARY KEY (`slog_id`);

ALTER TABLE `tbl_tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`,`tag_lang_id`);

ALTER TABLE `tbl_tag_product_recommendation`
  ADD PRIMARY KEY (`tpr_tag_id`,`tpr_product_id`);

ALTER TABLE `tbl_tax_categories`
  ADD PRIMARY KEY (`taxcat_id`),
  ADD UNIQUE KEY `taxcat_identifier` (`taxcat_identifier`,`taxcat_plugin_id`);

ALTER TABLE `tbl_tax_categories_lang`
  ADD PRIMARY KEY (`taxcatlang_taxcat_id`,`taxcatlang_lang_id`);

ALTER TABLE `tbl_tax_rules`
  ADD PRIMARY KEY (`taxrule_id`);

ALTER TABLE `tbl_tax_rule_details`
  ADD UNIQUE KEY `taxruledet_taxrule_id` (`taxruledet_taxrule_id`,`taxruledet_taxstr_id`,`taxruledet_user_id`);

ALTER TABLE `tbl_tax_rule_locations`
  ADD UNIQUE KEY `taxruleloc_taxcat_id` (`taxruleloc_taxcat_id`,`taxruleloc_from_country_id`,`taxruleloc_from_state_id`,`taxruleloc_to_country_id`,`taxruleloc_to_state_id`,`taxruleloc_type`);

ALTER TABLE `tbl_tax_rule_rates`
  ADD PRIMARY KEY (`trr_taxrule_id`,`trr_user_id`);

ALTER TABLE `tbl_tax_structure`
  ADD PRIMARY KEY (`taxstr_id`);

ALTER TABLE `tbl_tax_structure_lang`
  ADD PRIMARY KEY (`taxstrlang_taxstr_id`,`taxstrlang_lang_id`);

ALTER TABLE `tbl_testimonials`
  ADD PRIMARY KEY (`testimonial_id`);

ALTER TABLE `tbl_testimonials_lang`
  ADD PRIMARY KEY (`testimoniallang_testimonial_id`,`testimoniallang_lang_id`);

ALTER TABLE `tbl_threads`
  ADD PRIMARY KEY (`thread_id`);

ALTER TABLE `tbl_thread_messages`
  ADD PRIMARY KEY (`message_id`);

ALTER TABLE `tbl_time_slots`
  ADD PRIMARY KEY (`tslot_id`),
  ADD UNIQUE KEY `tslot_type` (`tslot_type`,`tslot_record_id`,`tslot_subrecord_id`,`tslot_day`,`tslot_from_time`,`tslot_to_time`);

ALTER TABLE `tbl_tool_tips`
  ADD PRIMARY KEY (`tooltip_id`);

ALTER TABLE `tbl_tool_tips_lang`
  ADD PRIMARY KEY (`tooltiplang_tooltip_id`,`tooltiplang_lang_id`);

ALTER TABLE `tbl_tracking_courier_code_relation`
  ADD UNIQUE KEY `UNIQUE` (`tccr_shipapi_plugin_id`,`tccr_shipapi_courier_code`,`tccr_tracking_plugin_id`);

ALTER TABLE `tbl_upc_codes`
  ADD KEY `upc_code` (`upc_code`),
  ADD KEY `upc_product_id` (`upc_product_id`);

ALTER TABLE `tbl_updated_record_log`
  ADD PRIMARY KEY (`urlog_id`),
  ADD UNIQUE KEY `urlog_record_id` (`urlog_record_id`,`urlog_subrecord_id`,`urlog_record_type`);

ALTER TABLE `tbl_upsell_products`
  ADD PRIMARY KEY (`upsell_sellerproduct_id`,`upsell_recommend_sellerproduct_id`),
  ADD KEY `upsell_sellerproduct_id` (`upsell_sellerproduct_id`);

ALTER TABLE `tbl_url_rewrite`
  ADD PRIMARY KEY (`urlrewrite_id`),
  ADD UNIQUE KEY `urlrewrite_original` (`urlrewrite_original`,`urlrewrite_lang_id`),
  ADD UNIQUE KEY `urlrewrite_custom` (`urlrewrite_custom`,`urlrewrite_lang_id`),
  ADD KEY `urlrewrite_custom_2` (`urlrewrite_custom`),
  ADD KEY `urlrewrite_original_2` (`urlrewrite_original`);

ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_referral_code` (`user_referral_code`),
  ADD UNIQUE KEY `user_dial_code` (`user_phone_dcode`,`user_phone`),
  ADD KEY `user_deleted` (`user_deleted`),
  ADD KEY `user_is_supplier` (`user_is_supplier`);

ALTER TABLE `tbl_user_auth_token`
  ADD PRIMARY KEY (`uauth_token`),
  ADD KEY `urm_user_id` (`uauth_user_id`);

ALTER TABLE `tbl_user_bank_details`
  ADD PRIMARY KEY (`ub_user_id`);

ALTER TABLE `tbl_user_cart`
  ADD UNIQUE KEY `usercart_user_id` (`usercart_user_id`,`usercart_type`);

ALTER TABLE `tbl_user_collections`
  ADD PRIMARY KEY (`uc_user_id`,`uc_type`,`uc_record_id`);

ALTER TABLE `tbl_user_cookies_preferences`
  ADD PRIMARY KEY (`ucp_user_id`);

ALTER TABLE `tbl_user_credentials`
  ADD PRIMARY KEY (`credential_user_id`),
  ADD UNIQUE KEY `credential_username_2` (`credential_username`),
  ADD UNIQUE KEY `credential_username` (`credential_email`);

ALTER TABLE `tbl_user_email_verification`
  ADD UNIQUE KEY `uev_user_id` (`uev_user_id`);

ALTER TABLE `tbl_user_extras`
  ADD PRIMARY KEY (`uextra_id`),
  ADD UNIQUE KEY `uextra_user_id_2` (`uextra_user_id`),
  ADD KEY `uextra_user_id` (`uextra_user_id`);

ALTER TABLE `tbl_user_favourite_products`
  ADD PRIMARY KEY (`ufp_id`),
  ADD UNIQUE KEY `ufp_user_id` (`ufp_user_id`,`ufp_selprod_id`);

ALTER TABLE `tbl_user_favourite_shops`
  ADD PRIMARY KEY (`ufs_id`),
  ADD UNIQUE KEY `ufs_user_id` (`ufs_user_id`,`ufs_shop_id`);

ALTER TABLE `tbl_user_meta`
  ADD PRIMARY KEY (`usermeta_user_id`,`usermeta_key`);

ALTER TABLE `tbl_user_notifications`
  ADD PRIMARY KEY (`unotification_id`);

ALTER TABLE `tbl_user_password_reset_requests`
  ADD UNIQUE KEY `uprr_user_id` (`uprr_user_id`);

ALTER TABLE `tbl_user_permissions`
  ADD PRIMARY KEY (`userperm_user_id`,`userperm_section_id`);

ALTER TABLE `tbl_user_phone_verification`
  ADD PRIMARY KEY (`upv_user_id`);

ALTER TABLE `tbl_user_product_recommendation`
  ADD PRIMARY KEY (`upr_user_id`,`upr_product_id`);

ALTER TABLE `tbl_user_requests_history`
  ADD PRIMARY KEY (`ureq_id`);

ALTER TABLE `tbl_user_return_address`
  ADD PRIMARY KEY (`ura_user_id`);

ALTER TABLE `tbl_user_return_address_lang`
  ADD PRIMARY KEY (`uralang_user_id`,`uralang_lang_id`);

ALTER TABLE `tbl_user_reward_points`
  ADD PRIMARY KEY (`urp_id`);

ALTER TABLE `tbl_user_reward_point_breakup`
  ADD PRIMARY KEY (`urpbreakup_id`);

ALTER TABLE `tbl_user_supplier_form_fields`
  ADD PRIMARY KEY (`sformfield_id`),
  ADD UNIQUE KEY `sformfield_identifier` (`sformfield_identifier`);

ALTER TABLE `tbl_user_supplier_form_fields_lang`
  ADD PRIMARY KEY (`sformfieldlang_sformfield_id`,`sformfieldlang_lang_id`);

ALTER TABLE `tbl_user_supplier_requests`
  ADD PRIMARY KEY (`usuprequest_user_id`),
  ADD UNIQUE KEY `usuprequest_id` (`usuprequest_id`);

ALTER TABLE `tbl_user_supplier_request_values`
  ADD PRIMARY KEY (`sfreqvalue_id`);

ALTER TABLE `tbl_user_temp_token_requests`
  ADD PRIMARY KEY (`uttr_user_id`);

ALTER TABLE `tbl_user_transactions`
  ADD PRIMARY KEY (`utxn_id`),
  ADD KEY `utxn_user_id` (`utxn_user_id`),
  ADD KEY `utxn_user_id_2` (`utxn_user_id`),
  ADD KEY `utxn_status` (`utxn_status`);

ALTER TABLE `tbl_user_wish_lists`
  ADD PRIMARY KEY (`uwlist_id`),
  ADD KEY `uwlist_user_id` (`uwlist_user_id`);

ALTER TABLE `tbl_user_wish_list_products`
  ADD PRIMARY KEY (`uwlp_uwlist_id`,`uwlp_selprod_id`),
  ADD KEY `uwlp_selprod_id` (`uwlp_selprod_id`);

ALTER TABLE `tbl_user_withdrawal_requests`
  ADD PRIMARY KEY (`withdrawal_id`),
  ADD KEY `withdrawal_status` (`withdrawal_status`),
  ADD KEY `withdrawal_user_id` (`withdrawal_user_id`);

ALTER TABLE `tbl_user_withdrawal_requests_specifics`
  ADD PRIMARY KEY (`uwrs_withdrawal_id`,`uwrs_key`);

ALTER TABLE `tbl_zones`
  ADD PRIMARY KEY (`zone_id`),
  ADD UNIQUE KEY `zone_identifier` (`zone_identifier`);

ALTER TABLE `tbl_zones_lang`
  ADD PRIMARY KEY (`zonelang_zone_id`,`zonelang_lang_id`),
  ADD UNIQUE KEY `zonelang_lang_id` (`zonelang_lang_id`,`zone_name`);

ALTER TABLE `tbl_abandoned_cart`
  MODIFY `abandonedcart_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5397;

ALTER TABLE `tbl_abusive_words`
  MODIFY `abusive_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

ALTER TABLE `tbl_addresses`
  MODIFY `addr_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=829;

ALTER TABLE `tbl_admin`
  MODIFY `admin_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE `tbl_ads_batches`
  MODIFY `adsbatch_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_affiliate_commission_settings`
  MODIFY `afcommsetting_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_affiliate_commission_setting_history`
  MODIFY `acsh_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_attached_files`
  MODIFY `afile_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48110;

ALTER TABLE `tbl_attached_files_temp`
  MODIFY `afile_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8618;

ALTER TABLE `tbl_attribute_groups`
  MODIFY `attrgrp_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_attribute_group_attributes`
  MODIFY `attr_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_badges`
  MODIFY `badge_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

ALTER TABLE `tbl_badge_links`
  MODIFY `badgelink_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=661;

ALTER TABLE `tbl_badge_link_conditions`
  MODIFY `blinkcond_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=209;

ALTER TABLE `tbl_badge_requests`
  MODIFY `breq_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `tbl_banners`
  MODIFY `banner_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tbl_banners_clicks`
  MODIFY `bclick_id` bigint NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_banners_logs`
  MODIFY `lbanner_banner_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_banner_locations`
  MODIFY `blocation_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `tbl_blog_contributions`
  MODIFY `bcontributions_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_blog_post`
  MODIFY `post_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `tbl_blog_post_categories`
  MODIFY `bpcategory_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `tbl_blog_post_comments`
  MODIFY `bpcomment_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_brands`
  MODIFY `brand_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

ALTER TABLE `tbl_catalog_request_messages`
  MODIFY `scatrequestmsg_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_collections`
  MODIFY `collection_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

ALTER TABLE `tbl_commission_settings`
  MODIFY `commsetting_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

ALTER TABLE `tbl_commission_setting_history`
  MODIFY `csh_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE `tbl_content_pages`
  MODIFY `cpage_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

ALTER TABLE `tbl_content_pages_block_lang`
  MODIFY `cpblocklang_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

ALTER TABLE `tbl_countries`
  MODIFY `country_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

ALTER TABLE `tbl_coupons`
  MODIFY `coupon_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

ALTER TABLE `tbl_coupons_history`
  MODIFY `couponhistory_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

ALTER TABLE `tbl_coupons_hold`
  MODIFY `couponhold_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

ALTER TABLE `tbl_cron_log`
  MODIFY `cronlog_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14969;

ALTER TABLE `tbl_cron_schedules`
  MODIFY `cron_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

ALTER TABLE `tbl_currency`
  MODIFY `currency_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `tbl_email_archives`
  MODIFY `earch_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7809;

ALTER TABLE `tbl_empty_cart_items`
  MODIFY `emptycartitem_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `tbl_extra_attributes`
  MODIFY `eattribute_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_extra_attribute_groups`
  MODIFY `eattrgroup_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_extra_pages`
  MODIFY `epage_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

ALTER TABLE `tbl_faqs`
  MODIFY `faq_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

ALTER TABLE `tbl_faq_categories`
  MODIFY `faqcat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `tbl_filters`
  MODIFY `filter_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_filter_groups`
  MODIFY `filtergroup_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_help_center`
  MODIFY `hc_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tbl_languages`
  MODIFY `language_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `tbl_language_labels`
  MODIFY `label_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40695;

ALTER TABLE `tbl_layout_templates`
  MODIFY `ltemplate_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10002;

ALTER TABLE `tbl_manual_shipping_api`
  MODIFY `mshipapi_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_meta_tags`
  MODIFY `meta_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8976;

ALTER TABLE `tbl_navigations`
  MODIFY `nav_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `tbl_navigation_links`
  MODIFY `nlink_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

ALTER TABLE `tbl_notifications`
  MODIFY `notification_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1395;

ALTER TABLE `tbl_options`
  MODIFY `option_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1371;

ALTER TABLE `tbl_option_values`
  MODIFY `optionvalue_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10069;

ALTER TABLE `tbl_orders`
  MODIFY `order_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=985;

ALTER TABLE `tbl_orders_status`
  MODIFY `orderstatus_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

ALTER TABLE `tbl_orders_status_history`
  MODIFY `oshistory_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3757;

ALTER TABLE `tbl_order_cancel_reasons`
  MODIFY `ocreason_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

ALTER TABLE `tbl_order_cancel_requests`
  MODIFY `ocrequest_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_order_gift_cards`
  MODIFY `ogcards_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_order_payments`
  MODIFY `opayment_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=696;

ALTER TABLE `tbl_order_products`
  MODIFY `op_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1995;

ALTER TABLE `tbl_order_product_charges`
  MODIFY `opcharge_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2696;

ALTER TABLE `tbl_order_product_digital_download_links`
  MODIFY `opddl_link_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `tbl_order_prod_charges_logs`
  MODIFY `opchargelog_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1990;

ALTER TABLE `tbl_order_return_reasons`
  MODIFY `orreason_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `tbl_order_return_requests`
  MODIFY `orrequest_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_order_return_request_messages`
  MODIFY `orrmsg_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_order_seller_subscriptions`
  MODIFY `ossubs_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_pages_language_data`
  MODIFY `plang_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=927;

ALTER TABLE `tbl_plugins`
  MODIFY `plugin_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

ALTER TABLE `tbl_policy_points`
  MODIFY `ppoint_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_polling`
  MODIFY `polling_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_polling_feedback`
  MODIFY `pollfeedback_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_products`
  MODIFY `product_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16056;

ALTER TABLE `tbl_products_browsing_history`
  MODIFY `pbhistory_id` bigint NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_product_ai_enrichment`
  MODIFY `pae_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=860;

ALTER TABLE `tbl_product_categories`
  MODIFY `prodcat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8306;

ALTER TABLE `tbl_product_digital_data_relation`
  MODIFY `pddr_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tbl_product_digital_links`
  MODIFY `pdl_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_product_groups`
  MODIFY `prodgroup_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_product_requests`
  MODIFY `preq_id` bigint NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_product_saved_search`
  MODIFY `pssearch_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `tbl_product_shipping_rates`
  MODIFY `pship_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_product_special_prices`
  MODIFY `splprice_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4838;

ALTER TABLE `tbl_product_specifications`
  MODIFY `prodspec_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

ALTER TABLE `tbl_product_stock_hold`
  MODIFY `pshold_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160035;

ALTER TABLE `tbl_product_volume_discount`
  MODIFY `voldiscount_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

ALTER TABLE `tbl_promotions`
  MODIFY `promotion_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_promotions_charges`
  MODIFY `pcharge_id` bigint NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_promotions_clicks`
  MODIFY `pclick_id` bigint NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_promotion_item_charges`
  MODIFY `picharge_id` bigint NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_push_notifications`
  MODIFY `pnotification_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tbl_questionnaires`
  MODIFY `questionnaire_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_questionnaire_feedback`
  MODIFY `qfeedback_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_questions`
  MODIFY `question_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_question_banks`
  MODIFY `qbank_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_rating_types`
  MODIFY `ratingtype_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

ALTER TABLE `tbl_report_reasons`
  MODIFY `reportreason_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `tbl_rewards_on_purchase`
  MODIFY `rop_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5212;

ALTER TABLE `tbl_search_items`
  MODIFY `searchitem_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10544;

ALTER TABLE `tbl_seller_brand_requests`
  MODIFY `sbrandreq_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_seller_catalog_requests`
  MODIFY `scatrequest_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_seller_packages`
  MODIFY `spackage_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_seller_packages_plan`
  MODIFY `spplan_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_seller_products`
  MODIFY `selprod_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83032;

ALTER TABLE `tbl_seller_products_lang`
  MODIFY `selprodlang_selprod_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83032;

ALTER TABLE `tbl_seller_product_reviews`
  MODIFY `spreview_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `tbl_shippingapi_settings`
  MODIFY `shipsetting_shippingapi_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_shipping_apis`
  MODIFY `shippingapi_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `tbl_shipping_company`
  MODIFY `scompany_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_shipping_durations`
  MODIFY `sduration_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_shipping_packages`
  MODIFY `shippack_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

ALTER TABLE `tbl_shipping_profile`
  MODIFY `shipprofile_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=528;

ALTER TABLE `tbl_shipping_profile_zones`
  MODIFY `shipprozone_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1110;

ALTER TABLE `tbl_shipping_rates`
  MODIFY `shiprate_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10012;

ALTER TABLE `tbl_shipping_zone`
  MODIFY `shipzone_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3579;

ALTER TABLE `tbl_shops`
  MODIFY `shop_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;

ALTER TABLE `tbl_shops_to_theme`
  MODIFY `stt_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_shop_collections`
  MODIFY `scollection_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

ALTER TABLE `tbl_shop_reports`
  MODIFY `sreport_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tbl_slides`
  MODIFY `slide_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

ALTER TABLE `tbl_smart_log_actions`
  MODIFY `slog_id` bigint NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_smart_user_activity_browsing`
  MODIFY `uab_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_sms_archives`
  MODIFY `smsarchive_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_social_platforms`
  MODIFY `splatform_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

ALTER TABLE `tbl_states`
  MODIFY `state_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4752;

ALTER TABLE `tbl_success_stories`
  MODIFY `sstory_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_system_logs`
  MODIFY `slog_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13199;

ALTER TABLE `tbl_tags`
  MODIFY `tag_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18678;

ALTER TABLE `tbl_tax_categories`
  MODIFY `taxcat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1704;

ALTER TABLE `tbl_tax_rules`
  MODIFY `taxrule_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

ALTER TABLE `tbl_tax_structure`
  MODIFY `taxstr_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `tbl_testimonials`
  MODIFY `testimonial_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_threads`
  MODIFY `thread_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=441;

ALTER TABLE `tbl_thread_messages`
  MODIFY `message_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=510;

ALTER TABLE `tbl_time_slots`
  MODIFY `tslot_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

ALTER TABLE `tbl_tool_tips`
  MODIFY `tooltip_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_updated_record_log`
  MODIFY `urlog_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=363756;

ALTER TABLE `tbl_url_rewrite`
  MODIFY `urlrewrite_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=500737;

ALTER TABLE `tbl_users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=626;

ALTER TABLE `tbl_user_extras`
  MODIFY `uextra_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_user_favourite_products`
  MODIFY `ufp_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=460;

ALTER TABLE `tbl_user_favourite_shops`
  MODIFY `ufs_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=312;

ALTER TABLE `tbl_user_notifications`
  MODIFY `unotification_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7527;

ALTER TABLE `tbl_user_requests_history`
  MODIFY `ureq_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `tbl_user_reward_points`
  MODIFY `urp_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=571;

ALTER TABLE `tbl_user_reward_point_breakup`
  MODIFY `urpbreakup_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=555;

ALTER TABLE `tbl_user_supplier_form_fields`
  MODIFY `sformfield_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `tbl_user_supplier_requests`
  MODIFY `usuprequest_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

ALTER TABLE `tbl_user_supplier_request_values`
  MODIFY `sfreqvalue_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=899;

ALTER TABLE `tbl_user_temp_token_requests`
  MODIFY `uttr_user_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tbl_user_transactions`
  MODIFY `utxn_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2845;

ALTER TABLE `tbl_user_wish_lists`
  MODIFY `uwlist_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

ALTER TABLE `tbl_user_withdrawal_requests`
  MODIFY `withdrawal_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE `tbl_zones`
  MODIFY `zone_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
