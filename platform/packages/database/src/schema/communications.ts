/**
 * Communications-related tables schema
 * 
 * Messages, notifications, SMS, and social platforms
 */

import { pgTable, text, timestamp, integer, boolean } from 'drizzle-orm/pg-core';
import { users } from './users';

/**
 * Catalog request messages
 * Messages related to catalog requests
 */
export const catalogRequestMessages = pgTable('tbl_catalog_request_messages', {
  scatrequestmsgId: integer('scatrequestmsg_id').primaryKey().generatedAlwaysAsIdentity(),
  scatrequestmsgScatrequestId: integer('scatrequestmsg_scatrequest_id').notNull(),
  scatrequestmsgFromUserId: integer('scatrequestmsg_from_user_id').references(() => users.userId).notNull(),
  scatrequestmsgFromAdminId: integer('scatrequestmsg_from_admin_id').notNull(),
  scatrequestmsgMsg: text('scatrequestmsg_msg').notNull(),
  scatrequestmsgDate: timestamp('scatrequestmsg_date').notNull(),
  scatrequestmsgDeleted: boolean('scatrequestmsg_deleted').notNull(),
});

/**
 * Push notifications
 * Mobile push notifications
 */
export const pushNotifications = pgTable('tbl_push_notifications', {
  pnotificationId: integer('pnotification_id').primaryKey().generatedAlwaysAsIdentity(),
  pnotificationType: integer('pnotification_type').notNull(),
  pnotificationLangId: integer('pnotification_lang_id').notNull(),
  pnotificationTitle: text('pnotification_title').notNull(),
  pnotificationDescription: text('pnotification_description').notNull(),
  pnotificationUrl: text('pnotification_url').notNull(),
  pnotificationNotifiedOn: timestamp('pnotification_notified_on').notNull(),
  pnotificationForBuyer: boolean('pnotification_for_buyer').notNull(),
  pnotificationForSeller: boolean('pnotification_for_seller').notNull(),
  pnotificationUserAuthType: integer('pnotification_user_auth_type').notNull(),
  pnotificationDeviceOs: integer('pnotification_device_os').notNull(), // Defined In User Model
  pnotificationUauthLastAccess: timestamp('pnotification_uauth_last_access').notNull(),
  pnotificationStatus: integer('pnotification_status').notNull(),
  pnotificationAddedOn: timestamp('pnotification_added_on').defaultNow(),
});

/**
 * SMS archives
 * Historical SMS messages
 */
export const smsArchives = pgTable('tbl_sms_archives', {
  smsarchiveId: integer('smsarchive_id').primaryKey().generatedAlwaysAsIdentity(),
  smsarchiveResponseId: text('smsarchive_response_id').notNull(),
  smsarchiveTo: text('smsarchive_to').notNull(),
  smsarchiveTplName: text('smsarchive_tpl_name').notNull(),
  smsarchiveBody: text('smsarchive_body').notNull(),
  smsarchiveSentOn: timestamp('smsarchive_sent_on').notNull(),
  smsarchiveStatus: text('smsarchive_status').notNull(),
  smsarchiveResponse: text('smsarchive_response').notNull(),
});

/**
 * SMS templates
 * SMS message templates
 */
export const smsTemplates = pgTable('tbl_sms_templates', {
  stplCode: text('stpl_code').notNull(),
  stplLangId: integer('stpl_lang_id').notNull(),
  stplName: text('stpl_name').notNull(),
  stplBody: text('stpl_body').notNull(),
  stplReplacements: text('stpl_replacements').notNull(),
  stplStatus: boolean('stpl_status').default(true),
}, (table) => ({
  pk: { primaryKey: { columns: [table.stplCode, table.stplLangId] } },
}));

/**
 * Social platforms
 * User social media links
 */
export const socialPlatforms = pgTable('tbl_social_platforms', {
  splatformId: integer('splatform_id').primaryKey().generatedAlwaysAsIdentity(),
  splatformUserId: integer('splatform_user_id').references(() => users.userId).notNull(),
  splatformIdentifier: text('splatform_identifier').notNull(),
  splatformUrl: text('splatform_url').notNull(),
  splatformActive: boolean('splatform_active').notNull(),
  splatformIconClass: text('splatform_icon_class').notNull(), // defined in model
}, (table) => ({
  uniqueUserPlatform: { unique: [table.splatformUserId, table.splatformIdentifier] },
}));

