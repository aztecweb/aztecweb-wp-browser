/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.3-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: db    Database: wordpress
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `wp_actionscheduler_actions`
--

DROP TABLE IF EXISTS `wp_actionscheduler_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_actions` (
  `action_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `hook` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `scheduled_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  `priority` tinyint unsigned NOT NULL DEFAULT '10',
  `args` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schedule` longtext COLLATE utf8mb4_unicode_520_ci,
  `group_id` bigint unsigned NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `last_attempt_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` datetime DEFAULT '0000-00-00 00:00:00',
  `claim_id` bigint unsigned NOT NULL DEFAULT '0',
  `extended_args` varchar(8000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  KEY `hook_status_scheduled_date_gmt` (`hook`(163),`status`,`scheduled_date_gmt`),
  KEY `status_scheduled_date_gmt` (`status`,`scheduled_date_gmt`),
  KEY `scheduled_date_gmt` (`scheduled_date_gmt`),
  KEY `args` (`args`),
  KEY `group_id` (`group_id`),
  KEY `last_attempt_gmt` (`last_attempt_gmt`),
  KEY `claim_id_status_priority_scheduled_date_gmt` (`claim_id`,`status`,`priority`,`scheduled_date_gmt`),
  KEY `status_last_attempt_gmt` (`status`,`last_attempt_gmt`),
  KEY `status_claim_id` (`status`,`claim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_actionscheduler_actions`
--

LOCK TABLES `wp_actionscheduler_actions` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_actions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_actionscheduler_actions` VALUES
(6,'action_scheduler/migration_hook','pending','2026-03-05 19:18:52','2026-03-05 19:18:52',10,'[]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738332;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738332;}',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(7,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:02','2026-03-05 19:18:02',10,'[10,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738282;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738282;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(8,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:03','2026-03-05 19:18:03',10,'[11,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738283;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738283;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(9,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:04','2026-03-05 19:18:04',10,'[12,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738284;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738284;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(10,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:05','2026-03-05 19:18:05',10,'[13,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738285;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738285;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(11,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:06','2026-03-05 19:18:06',10,'[14,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738286;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738286;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(12,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:06','2026-03-05 19:18:06',10,'[15,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738286;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738286;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(13,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:07','2026-03-05 19:18:07',10,'[16,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738287;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738287;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(14,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:08','2026-03-05 19:18:08',10,'[17,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738288;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738288;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL),
(15,'woocommerce_run_product_attribute_lookup_update_callback','pending','2026-03-05 19:18:09','2026-03-05 19:18:09',10,'[18,1]','O:30:\"ActionScheduler_SimpleSchedule\":2:{s:22:\"\0*\0scheduled_timestamp\";i:1772738289;s:41:\"\0ActionScheduler_SimpleSchedule\0timestamp\";i:1772738289;}',2,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,NULL);
/*!40000 ALTER TABLE `wp_actionscheduler_actions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_actionscheduler_claims`
--

DROP TABLE IF EXISTS `wp_actionscheduler_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_claims` (
  `claim_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date_created_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`claim_id`),
  KEY `date_created_gmt` (`date_created_gmt`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_actionscheduler_claims`
--

LOCK TABLES `wp_actionscheduler_claims` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_claims` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_actionscheduler_claims` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_actionscheduler_groups`
--

DROP TABLE IF EXISTS `wp_actionscheduler_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_groups` (
  `group_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `slug` (`slug`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_actionscheduler_groups`
--

LOCK TABLES `wp_actionscheduler_groups` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_groups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_actionscheduler_groups` VALUES
(1,'action-scheduler-migration'),
(2,'woocommerce-db-updates');
/*!40000 ALTER TABLE `wp_actionscheduler_groups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_actionscheduler_logs`
--

DROP TABLE IF EXISTS `wp_actionscheduler_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_actionscheduler_logs` (
  `log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `action_id` bigint unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `log_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`log_id`),
  KEY `action_id` (`action_id`),
  KEY `log_date_gmt` (`log_date_gmt`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_actionscheduler_logs`
--

LOCK TABLES `wp_actionscheduler_logs` WRITE;
/*!40000 ALTER TABLE `wp_actionscheduler_logs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_actionscheduler_logs` VALUES
(1,6,'action created','2026-03-05 19:17:52','2026-03-05 19:17:52'),
(2,7,'action created','2026-03-05 19:18:01','2026-03-05 19:18:01'),
(3,8,'action created','2026-03-05 19:18:02','2026-03-05 19:18:02'),
(4,9,'action created','2026-03-05 19:18:03','2026-03-05 19:18:03'),
(5,10,'action created','2026-03-05 19:18:04','2026-03-05 19:18:04'),
(6,11,'action created','2026-03-05 19:18:05','2026-03-05 19:18:05'),
(7,12,'action created','2026-03-05 19:18:06','2026-03-05 19:18:06'),
(8,13,'action created','2026-03-05 19:18:06','2026-03-05 19:18:06'),
(9,14,'action created','2026-03-05 19:18:07','2026-03-05 19:18:07'),
(10,15,'action created','2026-03-05 19:18:08','2026-03-05 19:18:08');
/*!40000 ALTER TABLE `wp_actionscheduler_logs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_commentmeta`
--

LOCK TABLES `wp_commentmeta` WRITE;
/*!40000 ALTER TABLE `wp_commentmeta` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10)),
  KEY `woo_idx_comment_type` (`comment_type`),
  KEY `woo_idx_comment_date_type` (`comment_date_gmt`,`comment_type`,`comment_approved`,`comment_post_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_comments`
--

LOCK TABLES `wp_comments` WRITE;
/*!40000 ALTER TABLE `wp_comments` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_comments` VALUES
(1,1,'A WordPress Commenter','wapuu@wordpress.example','https://wordpress.org/','','2026-03-05 19:17:48','2026-03-05 19:17:48','Hi, this is a comment.\nTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\nCommenter avatars come from <a href=\"https://gravatar.com/\">Gravatar</a>.',0,'1','','comment',0,0);
/*!40000 ALTER TABLE `wp_comments` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_links` (
  `link_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint unsigned NOT NULL DEFAULT '1',
  `link_rating` int NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_options` (
  `option_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_options` VALUES
(1,'cron','a:8:{i:1772738332;a:1:{s:26:\"action_scheduler_run_queue\";a:1:{s:32:\"0d04ed39571b55704c122d726248bbac\";a:3:{s:8:\"schedule\";s:12:\"every_minute\";s:4:\"args\";a:1:{i:0;s:7:\"WP Cron\";}s:8:\"interval\";i:60;}}}i:1772741868;a:2:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1772741872;a:2:{s:20:\"jetpack_clean_nonces\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}s:33:\"wc_admin_process_orders_milestone\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1772743668;a:1:{s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1772745468;a:1:{s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1772824668;a:2:{s:30:\"wp_site_health_scheduled_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}s:32:\"recovery_mode_clean_expired_keys\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1772824672;a:1:{s:20:\"jetpack_v2_heartbeat\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}s:7:\"version\";i:2;}','on'),
(2,'siteurl','http://wordpress','on'),
(3,'home','http://wordpress','on'),
(4,'blogname','AztecWP Browser Test Site','on'),
(5,'blogdescription','','on'),
(6,'users_can_register','0','on'),
(7,'admin_email','admin@example.com','on'),
(8,'start_of_week','1','on'),
(9,'use_balanceTags','0','on'),
(10,'use_smilies','1','on'),
(11,'require_name_email','1','on'),
(12,'comments_notify','1','on'),
(13,'posts_per_rss','10','on'),
(14,'rss_use_excerpt','0','on'),
(15,'mailserver_url','mail.example.com','on'),
(16,'mailserver_login','login@example.com','on'),
(17,'mailserver_pass','','on'),
(18,'mailserver_port','110','on'),
(19,'default_category','1','on'),
(20,'default_comment_status','open','on'),
(21,'default_ping_status','open','on'),
(22,'default_pingback_flag','1','on'),
(23,'posts_per_page','10','on'),
(24,'date_format','F j, Y','on'),
(25,'time_format','g:i a','on'),
(26,'links_updated_date_format','F j, Y g:i a','on'),
(27,'comment_moderation','0','on'),
(28,'moderation_notify','1','on'),
(29,'permalink_structure','/%year%/%monthnum%/%day%/%postname%/','on'),
(30,'rewrite_rules','a:190:{s:24:\"^wc-auth/v([1]{1})/(.*)?\";s:63:\"index.php?wc-auth-version=$matches[1]&wc-auth-route=$matches[2]\";s:21:\"^wc/file/transient/?$\";s:33:\"index.php?wc-transient-file-name=\";s:24:\"^wc/file/transient/(.+)$\";s:44:\"index.php?wc-transient-file-name=$matches[1]\";s:22:\"^wc-api/v([1-3]{1})/?$\";s:51:\"index.php?wc-api-version=$matches[1]&wc-api-route=/\";s:24:\"^wc-api/v([1-3]{1})(.*)?\";s:61:\"index.php?wc-api-version=$matches[1]&wc-api-route=$matches[2]\";s:7:\"shop/?$\";s:27:\"index.php?post_type=product\";s:37:\"shop/feed/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?post_type=product&feed=$matches[1]\";s:32:\"shop/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?post_type=product&feed=$matches[1]\";s:24:\"shop/page/([0-9]{1,})/?$\";s:45:\"index.php?post_type=product&paged=$matches[1]\";s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:17:\"^wp-sitemap\\.xml$\";s:23:\"index.php?sitemap=index\";s:17:\"^wp-sitemap\\.xsl$\";s:36:\"index.php?sitemap-stylesheet=sitemap\";s:23:\"^wp-sitemap-index\\.xsl$\";s:34:\"index.php?sitemap-stylesheet=index\";s:48:\"^wp-sitemap-([a-z]+?)-([a-z\\d_-]+?)-(\\d+?)\\.xml$\";s:75:\"index.php?sitemap=$matches[1]&sitemap-subtype=$matches[2]&paged=$matches[3]\";s:34:\"^wp-sitemap-([a-z]+?)-(\\d+?)\\.xml$\";s:47:\"index.php?sitemap=$matches[1]&paged=$matches[2]\";s:15:\"^checkout-link$\";s:28:\"index.php?checkout-link=true\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:43:\"category/(.+?)/wc/file/transient(/(.*))?/?$\";s:65:\"index.php?category_name=$matches[1]&wc/file/transient=$matches[3]\";s:32:\"category/(.+?)/wc-api(/(.*))?/?$\";s:54:\"index.php?category_name=$matches[1]&wc-api=$matches[3]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:40:\"tag/([^/]+)/wc/file/transient(/(.*))?/?$\";s:55:\"index.php?tag=$matches[1]&wc/file/transient=$matches[3]\";s:29:\"tag/([^/]+)/wc-api(/(.*))?/?$\";s:44:\"index.php?tag=$matches[1]&wc-api=$matches[3]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:44:\"brand/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?product_brand=$matches[1]&feed=$matches[2]\";s:39:\"brand/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?product_brand=$matches[1]&feed=$matches[2]\";s:20:\"brand/(.+?)/embed/?$\";s:46:\"index.php?product_brand=$matches[1]&embed=true\";s:32:\"brand/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?product_brand=$matches[1]&paged=$matches[2]\";s:14:\"brand/(.+?)/?$\";s:35:\"index.php?product_brand=$matches[1]\";s:55:\"product-category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_cat=$matches[1]&feed=$matches[2]\";s:50:\"product-category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_cat=$matches[1]&feed=$matches[2]\";s:31:\"product-category/(.+?)/embed/?$\";s:44:\"index.php?product_cat=$matches[1]&embed=true\";s:43:\"product-category/(.+?)/page/?([0-9]{1,})/?$\";s:51:\"index.php?product_cat=$matches[1]&paged=$matches[2]\";s:25:\"product-category/(.+?)/?$\";s:33:\"index.php?product_cat=$matches[1]\";s:52:\"product-tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_tag=$matches[1]&feed=$matches[2]\";s:47:\"product-tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?product_tag=$matches[1]&feed=$matches[2]\";s:28:\"product-tag/([^/]+)/embed/?$\";s:44:\"index.php?product_tag=$matches[1]&embed=true\";s:40:\"product-tag/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?product_tag=$matches[1]&paged=$matches[2]\";s:22:\"product-tag/([^/]+)/?$\";s:33:\"index.php?product_tag=$matches[1]\";s:35:\"product/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:45:\"product/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:65:\"product/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:60:\"product/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:60:\"product/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:41:\"product/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:24:\"product/([^/]+)/embed/?$\";s:40:\"index.php?product=$matches[1]&embed=true\";s:28:\"product/([^/]+)/trackback/?$\";s:34:\"index.php?product=$matches[1]&tb=1\";s:48:\"product/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?product=$matches[1]&feed=$matches[2]\";s:43:\"product/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?product=$matches[1]&feed=$matches[2]\";s:36:\"product/([^/]+)/page/?([0-9]{1,})/?$\";s:47:\"index.php?product=$matches[1]&paged=$matches[2]\";s:43:\"product/([^/]+)/comment-page-([0-9]{1,})/?$\";s:47:\"index.php?product=$matches[1]&cpage=$matches[2]\";s:44:\"product/([^/]+)/wc/file/transient(/(.*))?/?$\";s:59:\"index.php?product=$matches[1]&wc/file/transient=$matches[3]\";s:33:\"product/([^/]+)/wc-api(/(.*))?/?$\";s:48:\"index.php?product=$matches[1]&wc-api=$matches[3]\";s:50:\"product/[^/]+/([^/]+)/wc/file/transient(/(.*))?/?$\";s:62:\"index.php?attachment=$matches[1]&wc/file/transient=$matches[3]\";s:61:\"product/[^/]+/attachment/([^/]+)/wc/file/transient(/(.*))?/?$\";s:62:\"index.php?attachment=$matches[1]&wc/file/transient=$matches[3]\";s:39:\"product/[^/]+/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:50:\"product/[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:32:\"product/([^/]+)(?:/([0-9]+))?/?$\";s:46:\"index.php?product=$matches[1]&page=$matches[2]\";s:24:\"product/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:34:\"product/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:54:\"product/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:49:\"product/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:49:\"product/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:30:\"product/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:13:\"favicon\\.ico$\";s:19:\"index.php?favicon=1\";s:12:\"sitemap\\.xml\";s:24:\"index.php??sitemap=index\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:28:\"wc/file/transient(/(.*))?/?$\";s:40:\"index.php?&wc/file/transient=$matches[2]\";s:17:\"wc-api(/(.*))?/?$\";s:29:\"index.php?&wc-api=$matches[2]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:37:\"comments/wc/file/transient(/(.*))?/?$\";s:40:\"index.php?&wc/file/transient=$matches[2]\";s:26:\"comments/wc-api(/(.*))?/?$\";s:29:\"index.php?&wc-api=$matches[2]\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:40:\"search/(.+)/wc/file/transient(/(.*))?/?$\";s:53:\"index.php?s=$matches[1]&wc/file/transient=$matches[3]\";s:29:\"search/(.+)/wc-api(/(.*))?/?$\";s:42:\"index.php?s=$matches[1]&wc-api=$matches[3]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:43:\"author/([^/]+)/wc/file/transient(/(.*))?/?$\";s:63:\"index.php?author_name=$matches[1]&wc/file/transient=$matches[3]\";s:32:\"author/([^/]+)/wc-api(/(.*))?/?$\";s:52:\"index.php?author_name=$matches[1]&wc-api=$matches[3]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:65:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/wc/file/transient(/(.*))?/?$\";s:93:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&wc/file/transient=$matches[5]\";s:54:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/wc-api(/(.*))?/?$\";s:82:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&wc-api=$matches[5]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:52:\"([0-9]{4})/([0-9]{1,2})/wc/file/transient(/(.*))?/?$\";s:77:\"index.php?year=$matches[1]&monthnum=$matches[2]&wc/file/transient=$matches[4]\";s:41:\"([0-9]{4})/([0-9]{1,2})/wc-api(/(.*))?/?$\";s:66:\"index.php?year=$matches[1]&monthnum=$matches[2]&wc-api=$matches[4]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:39:\"([0-9]{4})/wc/file/transient(/(.*))?/?$\";s:56:\"index.php?year=$matches[1]&wc/file/transient=$matches[3]\";s:28:\"([0-9]{4})/wc-api(/(.*))?/?$\";s:45:\"index.php?year=$matches[1]&wc-api=$matches[3]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:58:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:68:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:88:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:64:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:53:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$\";s:91:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$\";s:85:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1\";s:77:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:65:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]\";s:73:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/wc/file/transient(/(.*))?/?$\";s:110:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&wc/file/transient=$matches[6]\";s:62:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/wc-api(/(.*))?/?$\";s:99:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&wc-api=$matches[6]\";s:73:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/wc/file/transient(/(.*))?/?$\";s:62:\"index.php?attachment=$matches[1]&wc/file/transient=$matches[3]\";s:84:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/wc/file/transient(/(.*))?/?$\";s:62:\"index.php?attachment=$matches[1]&wc/file/transient=$matches[3]\";s:62:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:73:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:61:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]\";s:47:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:57:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:77:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:53:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]\";s:51:\"([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]\";s:38:\"([0-9]{4})/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&cpage=$matches[2]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:36:\"(.?.+?)/wc/file/transient(/(.*))?/?$\";s:60:\"index.php?pagename=$matches[1]&wc/file/transient=$matches[3]\";s:25:\"(.?.+?)/wc-api(/(.*))?/?$\";s:49:\"index.php?pagename=$matches[1]&wc-api=$matches[3]\";s:28:\"(.?.+?)/order-pay(/(.*))?/?$\";s:52:\"index.php?pagename=$matches[1]&order-pay=$matches[3]\";s:33:\"(.?.+?)/order-received(/(.*))?/?$\";s:57:\"index.php?pagename=$matches[1]&order-received=$matches[3]\";s:25:\"(.?.+?)/orders(/(.*))?/?$\";s:49:\"index.php?pagename=$matches[1]&orders=$matches[3]\";s:29:\"(.?.+?)/view-order(/(.*))?/?$\";s:53:\"index.php?pagename=$matches[1]&view-order=$matches[3]\";s:28:\"(.?.+?)/downloads(/(.*))?/?$\";s:52:\"index.php?pagename=$matches[1]&downloads=$matches[3]\";s:31:\"(.?.+?)/edit-account(/(.*))?/?$\";s:55:\"index.php?pagename=$matches[1]&edit-account=$matches[3]\";s:31:\"(.?.+?)/edit-address(/(.*))?/?$\";s:55:\"index.php?pagename=$matches[1]&edit-address=$matches[3]\";s:34:\"(.?.+?)/payment-methods(/(.*))?/?$\";s:58:\"index.php?pagename=$matches[1]&payment-methods=$matches[3]\";s:32:\"(.?.+?)/lost-password(/(.*))?/?$\";s:56:\"index.php?pagename=$matches[1]&lost-password=$matches[3]\";s:34:\"(.?.+?)/customer-logout(/(.*))?/?$\";s:58:\"index.php?pagename=$matches[1]&customer-logout=$matches[3]\";s:37:\"(.?.+?)/add-payment-method(/(.*))?/?$\";s:61:\"index.php?pagename=$matches[1]&add-payment-method=$matches[3]\";s:40:\"(.?.+?)/delete-payment-method(/(.*))?/?$\";s:64:\"index.php?pagename=$matches[1]&delete-payment-method=$matches[3]\";s:45:\"(.?.+?)/set-default-payment-method(/(.*))?/?$\";s:69:\"index.php?pagename=$matches[1]&set-default-payment-method=$matches[3]\";s:42:\".?.+?/([^/]+)/wc/file/transient(/(.*))?/?$\";s:62:\"index.php?attachment=$matches[1]&wc/file/transient=$matches[3]\";s:53:\".?.+?/attachment/([^/]+)/wc/file/transient(/(.*))?/?$\";s:62:\"index.php?attachment=$matches[1]&wc/file/transient=$matches[3]\";s:31:\".?.+?/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:42:\".?.+?/attachment/([^/]+)/wc-api(/(.*))?/?$\";s:51:\"index.php?attachment=$matches[1]&wc-api=$matches[3]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";}','on'),
(31,'hack_file','0','on'),
(32,'blog_charset','UTF-8','on'),
(33,'moderation_keys','','off'),
(34,'active_plugins','a:1:{i:0;s:27:\"woocommerce/woocommerce.php\";}','on'),
(35,'category_base','','on'),
(36,'ping_sites','https://rpc.pingomatic.com/','on'),
(37,'comment_max_links','2','on'),
(38,'gmt_offset','0','on'),
(39,'default_email_category','1','on'),
(40,'recently_edited','','off'),
(41,'template','twentytwentyfive','on'),
(42,'stylesheet','twentytwentyfive','on'),
(43,'comment_registration','0','on'),
(44,'html_type','text/html','on'),
(45,'use_trackback','0','on'),
(46,'default_role','subscriber','on'),
(47,'db_version','60421','on'),
(48,'uploads_use_yearmonth_folders','1','on'),
(49,'upload_path','','on'),
(50,'blog_public','1','on'),
(51,'default_link_category','2','on'),
(52,'show_on_front','posts','on'),
(53,'tag_base','','on'),
(54,'show_avatars','1','on'),
(55,'avatar_rating','G','on'),
(56,'upload_url_path','','on'),
(57,'thumbnail_size_w','150','on'),
(58,'thumbnail_size_h','150','on'),
(59,'thumbnail_crop','1','on'),
(60,'medium_size_w','300','on'),
(61,'medium_size_h','300','on'),
(62,'avatar_default','mystery','on'),
(63,'large_size_w','1024','on'),
(64,'large_size_h','1024','on'),
(65,'image_default_link_type','none','on'),
(66,'image_default_size','','on'),
(67,'image_default_align','','on'),
(68,'close_comments_for_old_posts','0','on'),
(69,'close_comments_days_old','14','on'),
(70,'thread_comments','1','on'),
(71,'thread_comments_depth','5','on'),
(72,'page_comments','0','on'),
(73,'comments_per_page','50','on'),
(74,'default_comments_page','newest','on'),
(75,'comment_order','asc','on'),
(76,'sticky_posts','a:0:{}','on'),
(77,'widget_categories','a:0:{}','on'),
(78,'widget_text','a:0:{}','on'),
(79,'widget_rss','a:0:{}','on'),
(80,'uninstall_plugins','a:0:{}','off'),
(81,'timezone_string','','on'),
(82,'page_for_posts','0','on'),
(83,'page_on_front','0','on'),
(84,'default_post_format','0','on'),
(85,'link_manager_enabled','0','on'),
(86,'finished_splitting_shared_terms','1','on'),
(87,'site_icon','0','on'),
(88,'medium_large_size_w','768','on'),
(89,'medium_large_size_h','0','on'),
(90,'wp_page_for_privacy_policy','3','on'),
(91,'show_comments_cookies_opt_in','1','on'),
(92,'admin_email_lifespan','1788290268','on'),
(93,'disallowed_keys','','off'),
(94,'comment_previously_approved','1','on'),
(95,'auto_plugin_theme_update_emails','a:0:{}','off'),
(96,'auto_update_core_dev','enabled','on'),
(97,'auto_update_core_minor','enabled','on'),
(98,'auto_update_core_major','enabled','on'),
(99,'wp_force_deactivated_plugins','a:0:{}','on'),
(100,'wp_attachment_pages_enabled','0','on'),
(101,'initial_db_version','60421','on'),
(102,'wp_user_roles','a:7:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:115:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;s:18:\"manage_woocommerce\";b:1;s:16:\"create_customers\";b:1;s:24:\"view_woocommerce_reports\";b:1;s:12:\"edit_product\";b:1;s:12:\"read_product\";b:1;s:14:\"delete_product\";b:1;s:13:\"edit_products\";b:1;s:20:\"edit_others_products\";b:1;s:16:\"publish_products\";b:1;s:21:\"read_private_products\";b:1;s:15:\"delete_products\";b:1;s:23:\"delete_private_products\";b:1;s:25:\"delete_published_products\";b:1;s:22:\"delete_others_products\";b:1;s:21:\"edit_private_products\";b:1;s:23:\"edit_published_products\";b:1;s:20:\"manage_product_terms\";b:1;s:18:\"edit_product_terms\";b:1;s:20:\"delete_product_terms\";b:1;s:20:\"assign_product_terms\";b:1;s:15:\"edit_shop_order\";b:1;s:15:\"read_shop_order\";b:1;s:17:\"delete_shop_order\";b:1;s:16:\"edit_shop_orders\";b:1;s:23:\"edit_others_shop_orders\";b:1;s:19:\"publish_shop_orders\";b:1;s:24:\"read_private_shop_orders\";b:1;s:18:\"delete_shop_orders\";b:1;s:26:\"delete_private_shop_orders\";b:1;s:28:\"delete_published_shop_orders\";b:1;s:25:\"delete_others_shop_orders\";b:1;s:24:\"edit_private_shop_orders\";b:1;s:26:\"edit_published_shop_orders\";b:1;s:23:\"manage_shop_order_terms\";b:1;s:21:\"edit_shop_order_terms\";b:1;s:23:\"delete_shop_order_terms\";b:1;s:23:\"assign_shop_order_terms\";b:1;s:16:\"edit_shop_coupon\";b:1;s:16:\"read_shop_coupon\";b:1;s:18:\"delete_shop_coupon\";b:1;s:17:\"edit_shop_coupons\";b:1;s:24:\"edit_others_shop_coupons\";b:1;s:20:\"publish_shop_coupons\";b:1;s:25:\"read_private_shop_coupons\";b:1;s:19:\"delete_shop_coupons\";b:1;s:27:\"delete_private_shop_coupons\";b:1;s:29:\"delete_published_shop_coupons\";b:1;s:26:\"delete_others_shop_coupons\";b:1;s:25:\"edit_private_shop_coupons\";b:1;s:27:\"edit_published_shop_coupons\";b:1;s:24:\"manage_shop_coupon_terms\";b:1;s:22:\"edit_shop_coupon_terms\";b:1;s:24:\"delete_shop_coupon_terms\";b:1;s:24:\"assign_shop_coupon_terms\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}s:8:\"customer\";a:2:{s:4:\"name\";s:8:\"Customer\";s:12:\"capabilities\";a:1:{s:4:\"read\";b:1;}}s:12:\"shop_manager\";a:2:{s:4:\"name\";s:12:\"Shop manager\";s:12:\"capabilities\";a:93:{s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:4:\"read\";b:1;s:18:\"read_private_pages\";b:1;s:18:\"read_private_posts\";b:1;s:10:\"edit_posts\";b:1;s:10:\"edit_pages\";b:1;s:20:\"edit_published_posts\";b:1;s:20:\"edit_published_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"edit_private_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:17:\"edit_others_pages\";b:1;s:13:\"publish_posts\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_posts\";b:1;s:12:\"delete_pages\";b:1;s:20:\"delete_private_pages\";b:1;s:20:\"delete_private_posts\";b:1;s:22:\"delete_published_pages\";b:1;s:22:\"delete_published_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:19:\"delete_others_pages\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:17:\"moderate_comments\";b:1;s:12:\"upload_files\";b:1;s:6:\"export\";b:1;s:6:\"import\";b:1;s:10:\"list_users\";b:1;s:18:\"edit_theme_options\";b:1;s:18:\"manage_woocommerce\";b:1;s:16:\"create_customers\";b:1;s:24:\"view_woocommerce_reports\";b:1;s:12:\"edit_product\";b:1;s:12:\"read_product\";b:1;s:14:\"delete_product\";b:1;s:13:\"edit_products\";b:1;s:20:\"edit_others_products\";b:1;s:16:\"publish_products\";b:1;s:21:\"read_private_products\";b:1;s:15:\"delete_products\";b:1;s:23:\"delete_private_products\";b:1;s:25:\"delete_published_products\";b:1;s:22:\"delete_others_products\";b:1;s:21:\"edit_private_products\";b:1;s:23:\"edit_published_products\";b:1;s:20:\"manage_product_terms\";b:1;s:18:\"edit_product_terms\";b:1;s:20:\"delete_product_terms\";b:1;s:20:\"assign_product_terms\";b:1;s:15:\"edit_shop_order\";b:1;s:15:\"read_shop_order\";b:1;s:17:\"delete_shop_order\";b:1;s:16:\"edit_shop_orders\";b:1;s:23:\"edit_others_shop_orders\";b:1;s:19:\"publish_shop_orders\";b:1;s:24:\"read_private_shop_orders\";b:1;s:18:\"delete_shop_orders\";b:1;s:26:\"delete_private_shop_orders\";b:1;s:28:\"delete_published_shop_orders\";b:1;s:25:\"delete_others_shop_orders\";b:1;s:24:\"edit_private_shop_orders\";b:1;s:26:\"edit_published_shop_orders\";b:1;s:23:\"manage_shop_order_terms\";b:1;s:21:\"edit_shop_order_terms\";b:1;s:23:\"delete_shop_order_terms\";b:1;s:23:\"assign_shop_order_terms\";b:1;s:16:\"edit_shop_coupon\";b:1;s:16:\"read_shop_coupon\";b:1;s:18:\"delete_shop_coupon\";b:1;s:17:\"edit_shop_coupons\";b:1;s:24:\"edit_others_shop_coupons\";b:1;s:20:\"publish_shop_coupons\";b:1;s:25:\"read_private_shop_coupons\";b:1;s:19:\"delete_shop_coupons\";b:1;s:27:\"delete_private_shop_coupons\";b:1;s:29:\"delete_published_shop_coupons\";b:1;s:26:\"delete_others_shop_coupons\";b:1;s:25:\"edit_private_shop_coupons\";b:1;s:27:\"edit_published_shop_coupons\";b:1;s:24:\"manage_shop_coupon_terms\";b:1;s:22:\"edit_shop_coupon_terms\";b:1;s:24:\"delete_shop_coupon_terms\";b:1;s:24:\"assign_shop_coupon_terms\";b:1;}}}','on'),
(103,'fresh_site','1','off'),
(104,'user_count','11','off'),
(105,'widget_block','a:6:{i:2;a:1:{s:7:\"content\";s:19:\"<!-- wp:search /-->\";}i:3;a:1:{s:7:\"content\";s:154:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Posts</h2><!-- /wp:heading --><!-- wp:latest-posts /--></div><!-- /wp:group -->\";}i:4;a:1:{s:7:\"content\";s:227:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Comments</h2><!-- /wp:heading --><!-- wp:latest-comments {\"displayAvatar\":false,\"displayDate\":false,\"displayExcerpt\":false} /--></div><!-- /wp:group -->\";}i:5;a:1:{s:7:\"content\";s:146:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Archives</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->\";}i:6;a:1:{s:7:\"content\";s:150:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Categories</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->\";}s:12:\"_multiwidget\";i:1;}','auto'),
(106,'sidebars_widgets','a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:3:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";}s:9:\"sidebar-2\";a:2:{i:0;s:7:\"block-5\";i:1;s:7:\"block-6\";}s:13:\"array_version\";i:3;}','auto'),
(107,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(108,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(109,'widget_archives','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(110,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(111,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(112,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(113,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(114,'widget_meta','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(115,'widget_search','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(116,'widget_recent-posts','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(117,'widget_recent-comments','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(118,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(119,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(120,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(121,'_transient_wp_core_block_css_files','a:2:{s:7:\"version\";s:5:\"6.8.3\";s:5:\"files\";a:536:{i:0;s:23:\"archives/editor-rtl.css\";i:1;s:27:\"archives/editor-rtl.min.css\";i:2;s:19:\"archives/editor.css\";i:3;s:23:\"archives/editor.min.css\";i:4;s:22:\"archives/style-rtl.css\";i:5;s:26:\"archives/style-rtl.min.css\";i:6;s:18:\"archives/style.css\";i:7;s:22:\"archives/style.min.css\";i:8;s:20:\"audio/editor-rtl.css\";i:9;s:24:\"audio/editor-rtl.min.css\";i:10;s:16:\"audio/editor.css\";i:11;s:20:\"audio/editor.min.css\";i:12;s:19:\"audio/style-rtl.css\";i:13;s:23:\"audio/style-rtl.min.css\";i:14;s:15:\"audio/style.css\";i:15;s:19:\"audio/style.min.css\";i:16;s:19:\"audio/theme-rtl.css\";i:17;s:23:\"audio/theme-rtl.min.css\";i:18;s:15:\"audio/theme.css\";i:19;s:19:\"audio/theme.min.css\";i:20;s:21:\"avatar/editor-rtl.css\";i:21;s:25:\"avatar/editor-rtl.min.css\";i:22;s:17:\"avatar/editor.css\";i:23;s:21:\"avatar/editor.min.css\";i:24;s:20:\"avatar/style-rtl.css\";i:25;s:24:\"avatar/style-rtl.min.css\";i:26;s:16:\"avatar/style.css\";i:27;s:20:\"avatar/style.min.css\";i:28;s:21:\"button/editor-rtl.css\";i:29;s:25:\"button/editor-rtl.min.css\";i:30;s:17:\"button/editor.css\";i:31;s:21:\"button/editor.min.css\";i:32;s:20:\"button/style-rtl.css\";i:33;s:24:\"button/style-rtl.min.css\";i:34;s:16:\"button/style.css\";i:35;s:20:\"button/style.min.css\";i:36;s:22:\"buttons/editor-rtl.css\";i:37;s:26:\"buttons/editor-rtl.min.css\";i:38;s:18:\"buttons/editor.css\";i:39;s:22:\"buttons/editor.min.css\";i:40;s:21:\"buttons/style-rtl.css\";i:41;s:25:\"buttons/style-rtl.min.css\";i:42;s:17:\"buttons/style.css\";i:43;s:21:\"buttons/style.min.css\";i:44;s:22:\"calendar/style-rtl.css\";i:45;s:26:\"calendar/style-rtl.min.css\";i:46;s:18:\"calendar/style.css\";i:47;s:22:\"calendar/style.min.css\";i:48;s:25:\"categories/editor-rtl.css\";i:49;s:29:\"categories/editor-rtl.min.css\";i:50;s:21:\"categories/editor.css\";i:51;s:25:\"categories/editor.min.css\";i:52;s:24:\"categories/style-rtl.css\";i:53;s:28:\"categories/style-rtl.min.css\";i:54;s:20:\"categories/style.css\";i:55;s:24:\"categories/style.min.css\";i:56;s:19:\"code/editor-rtl.css\";i:57;s:23:\"code/editor-rtl.min.css\";i:58;s:15:\"code/editor.css\";i:59;s:19:\"code/editor.min.css\";i:60;s:18:\"code/style-rtl.css\";i:61;s:22:\"code/style-rtl.min.css\";i:62;s:14:\"code/style.css\";i:63;s:18:\"code/style.min.css\";i:64;s:18:\"code/theme-rtl.css\";i:65;s:22:\"code/theme-rtl.min.css\";i:66;s:14:\"code/theme.css\";i:67;s:18:\"code/theme.min.css\";i:68;s:22:\"columns/editor-rtl.css\";i:69;s:26:\"columns/editor-rtl.min.css\";i:70;s:18:\"columns/editor.css\";i:71;s:22:\"columns/editor.min.css\";i:72;s:21:\"columns/style-rtl.css\";i:73;s:25:\"columns/style-rtl.min.css\";i:74;s:17:\"columns/style.css\";i:75;s:21:\"columns/style.min.css\";i:76;s:33:\"comment-author-name/style-rtl.css\";i:77;s:37:\"comment-author-name/style-rtl.min.css\";i:78;s:29:\"comment-author-name/style.css\";i:79;s:33:\"comment-author-name/style.min.css\";i:80;s:29:\"comment-content/style-rtl.css\";i:81;s:33:\"comment-content/style-rtl.min.css\";i:82;s:25:\"comment-content/style.css\";i:83;s:29:\"comment-content/style.min.css\";i:84;s:26:\"comment-date/style-rtl.css\";i:85;s:30:\"comment-date/style-rtl.min.css\";i:86;s:22:\"comment-date/style.css\";i:87;s:26:\"comment-date/style.min.css\";i:88;s:31:\"comment-edit-link/style-rtl.css\";i:89;s:35:\"comment-edit-link/style-rtl.min.css\";i:90;s:27:\"comment-edit-link/style.css\";i:91;s:31:\"comment-edit-link/style.min.css\";i:92;s:32:\"comment-reply-link/style-rtl.css\";i:93;s:36:\"comment-reply-link/style-rtl.min.css\";i:94;s:28:\"comment-reply-link/style.css\";i:95;s:32:\"comment-reply-link/style.min.css\";i:96;s:30:\"comment-template/style-rtl.css\";i:97;s:34:\"comment-template/style-rtl.min.css\";i:98;s:26:\"comment-template/style.css\";i:99;s:30:\"comment-template/style.min.css\";i:100;s:42:\"comments-pagination-numbers/editor-rtl.css\";i:101;s:46:\"comments-pagination-numbers/editor-rtl.min.css\";i:102;s:38:\"comments-pagination-numbers/editor.css\";i:103;s:42:\"comments-pagination-numbers/editor.min.css\";i:104;s:34:\"comments-pagination/editor-rtl.css\";i:105;s:38:\"comments-pagination/editor-rtl.min.css\";i:106;s:30:\"comments-pagination/editor.css\";i:107;s:34:\"comments-pagination/editor.min.css\";i:108;s:33:\"comments-pagination/style-rtl.css\";i:109;s:37:\"comments-pagination/style-rtl.min.css\";i:110;s:29:\"comments-pagination/style.css\";i:111;s:33:\"comments-pagination/style.min.css\";i:112;s:29:\"comments-title/editor-rtl.css\";i:113;s:33:\"comments-title/editor-rtl.min.css\";i:114;s:25:\"comments-title/editor.css\";i:115;s:29:\"comments-title/editor.min.css\";i:116;s:23:\"comments/editor-rtl.css\";i:117;s:27:\"comments/editor-rtl.min.css\";i:118;s:19:\"comments/editor.css\";i:119;s:23:\"comments/editor.min.css\";i:120;s:22:\"comments/style-rtl.css\";i:121;s:26:\"comments/style-rtl.min.css\";i:122;s:18:\"comments/style.css\";i:123;s:22:\"comments/style.min.css\";i:124;s:20:\"cover/editor-rtl.css\";i:125;s:24:\"cover/editor-rtl.min.css\";i:126;s:16:\"cover/editor.css\";i:127;s:20:\"cover/editor.min.css\";i:128;s:19:\"cover/style-rtl.css\";i:129;s:23:\"cover/style-rtl.min.css\";i:130;s:15:\"cover/style.css\";i:131;s:19:\"cover/style.min.css\";i:132;s:22:\"details/editor-rtl.css\";i:133;s:26:\"details/editor-rtl.min.css\";i:134;s:18:\"details/editor.css\";i:135;s:22:\"details/editor.min.css\";i:136;s:21:\"details/style-rtl.css\";i:137;s:25:\"details/style-rtl.min.css\";i:138;s:17:\"details/style.css\";i:139;s:21:\"details/style.min.css\";i:140;s:20:\"embed/editor-rtl.css\";i:141;s:24:\"embed/editor-rtl.min.css\";i:142;s:16:\"embed/editor.css\";i:143;s:20:\"embed/editor.min.css\";i:144;s:19:\"embed/style-rtl.css\";i:145;s:23:\"embed/style-rtl.min.css\";i:146;s:15:\"embed/style.css\";i:147;s:19:\"embed/style.min.css\";i:148;s:19:\"embed/theme-rtl.css\";i:149;s:23:\"embed/theme-rtl.min.css\";i:150;s:15:\"embed/theme.css\";i:151;s:19:\"embed/theme.min.css\";i:152;s:19:\"file/editor-rtl.css\";i:153;s:23:\"file/editor-rtl.min.css\";i:154;s:15:\"file/editor.css\";i:155;s:19:\"file/editor.min.css\";i:156;s:18:\"file/style-rtl.css\";i:157;s:22:\"file/style-rtl.min.css\";i:158;s:14:\"file/style.css\";i:159;s:18:\"file/style.min.css\";i:160;s:23:\"footnotes/style-rtl.css\";i:161;s:27:\"footnotes/style-rtl.min.css\";i:162;s:19:\"footnotes/style.css\";i:163;s:23:\"footnotes/style.min.css\";i:164;s:23:\"freeform/editor-rtl.css\";i:165;s:27:\"freeform/editor-rtl.min.css\";i:166;s:19:\"freeform/editor.css\";i:167;s:23:\"freeform/editor.min.css\";i:168;s:22:\"gallery/editor-rtl.css\";i:169;s:26:\"gallery/editor-rtl.min.css\";i:170;s:18:\"gallery/editor.css\";i:171;s:22:\"gallery/editor.min.css\";i:172;s:21:\"gallery/style-rtl.css\";i:173;s:25:\"gallery/style-rtl.min.css\";i:174;s:17:\"gallery/style.css\";i:175;s:21:\"gallery/style.min.css\";i:176;s:21:\"gallery/theme-rtl.css\";i:177;s:25:\"gallery/theme-rtl.min.css\";i:178;s:17:\"gallery/theme.css\";i:179;s:21:\"gallery/theme.min.css\";i:180;s:20:\"group/editor-rtl.css\";i:181;s:24:\"group/editor-rtl.min.css\";i:182;s:16:\"group/editor.css\";i:183;s:20:\"group/editor.min.css\";i:184;s:19:\"group/style-rtl.css\";i:185;s:23:\"group/style-rtl.min.css\";i:186;s:15:\"group/style.css\";i:187;s:19:\"group/style.min.css\";i:188;s:19:\"group/theme-rtl.css\";i:189;s:23:\"group/theme-rtl.min.css\";i:190;s:15:\"group/theme.css\";i:191;s:19:\"group/theme.min.css\";i:192;s:21:\"heading/style-rtl.css\";i:193;s:25:\"heading/style-rtl.min.css\";i:194;s:17:\"heading/style.css\";i:195;s:21:\"heading/style.min.css\";i:196;s:19:\"html/editor-rtl.css\";i:197;s:23:\"html/editor-rtl.min.css\";i:198;s:15:\"html/editor.css\";i:199;s:19:\"html/editor.min.css\";i:200;s:20:\"image/editor-rtl.css\";i:201;s:24:\"image/editor-rtl.min.css\";i:202;s:16:\"image/editor.css\";i:203;s:20:\"image/editor.min.css\";i:204;s:19:\"image/style-rtl.css\";i:205;s:23:\"image/style-rtl.min.css\";i:206;s:15:\"image/style.css\";i:207;s:19:\"image/style.min.css\";i:208;s:19:\"image/theme-rtl.css\";i:209;s:23:\"image/theme-rtl.min.css\";i:210;s:15:\"image/theme.css\";i:211;s:19:\"image/theme.min.css\";i:212;s:29:\"latest-comments/style-rtl.css\";i:213;s:33:\"latest-comments/style-rtl.min.css\";i:214;s:25:\"latest-comments/style.css\";i:215;s:29:\"latest-comments/style.min.css\";i:216;s:27:\"latest-posts/editor-rtl.css\";i:217;s:31:\"latest-posts/editor-rtl.min.css\";i:218;s:23:\"latest-posts/editor.css\";i:219;s:27:\"latest-posts/editor.min.css\";i:220;s:26:\"latest-posts/style-rtl.css\";i:221;s:30:\"latest-posts/style-rtl.min.css\";i:222;s:22:\"latest-posts/style.css\";i:223;s:26:\"latest-posts/style.min.css\";i:224;s:18:\"list/style-rtl.css\";i:225;s:22:\"list/style-rtl.min.css\";i:226;s:14:\"list/style.css\";i:227;s:18:\"list/style.min.css\";i:228;s:22:\"loginout/style-rtl.css\";i:229;s:26:\"loginout/style-rtl.min.css\";i:230;s:18:\"loginout/style.css\";i:231;s:22:\"loginout/style.min.css\";i:232;s:25:\"media-text/editor-rtl.css\";i:233;s:29:\"media-text/editor-rtl.min.css\";i:234;s:21:\"media-text/editor.css\";i:235;s:25:\"media-text/editor.min.css\";i:236;s:24:\"media-text/style-rtl.css\";i:237;s:28:\"media-text/style-rtl.min.css\";i:238;s:20:\"media-text/style.css\";i:239;s:24:\"media-text/style.min.css\";i:240;s:19:\"more/editor-rtl.css\";i:241;s:23:\"more/editor-rtl.min.css\";i:242;s:15:\"more/editor.css\";i:243;s:19:\"more/editor.min.css\";i:244;s:30:\"navigation-link/editor-rtl.css\";i:245;s:34:\"navigation-link/editor-rtl.min.css\";i:246;s:26:\"navigation-link/editor.css\";i:247;s:30:\"navigation-link/editor.min.css\";i:248;s:29:\"navigation-link/style-rtl.css\";i:249;s:33:\"navigation-link/style-rtl.min.css\";i:250;s:25:\"navigation-link/style.css\";i:251;s:29:\"navigation-link/style.min.css\";i:252;s:33:\"navigation-submenu/editor-rtl.css\";i:253;s:37:\"navigation-submenu/editor-rtl.min.css\";i:254;s:29:\"navigation-submenu/editor.css\";i:255;s:33:\"navigation-submenu/editor.min.css\";i:256;s:25:\"navigation/editor-rtl.css\";i:257;s:29:\"navigation/editor-rtl.min.css\";i:258;s:21:\"navigation/editor.css\";i:259;s:25:\"navigation/editor.min.css\";i:260;s:24:\"navigation/style-rtl.css\";i:261;s:28:\"navigation/style-rtl.min.css\";i:262;s:20:\"navigation/style.css\";i:263;s:24:\"navigation/style.min.css\";i:264;s:23:\"nextpage/editor-rtl.css\";i:265;s:27:\"nextpage/editor-rtl.min.css\";i:266;s:19:\"nextpage/editor.css\";i:267;s:23:\"nextpage/editor.min.css\";i:268;s:24:\"page-list/editor-rtl.css\";i:269;s:28:\"page-list/editor-rtl.min.css\";i:270;s:20:\"page-list/editor.css\";i:271;s:24:\"page-list/editor.min.css\";i:272;s:23:\"page-list/style-rtl.css\";i:273;s:27:\"page-list/style-rtl.min.css\";i:274;s:19:\"page-list/style.css\";i:275;s:23:\"page-list/style.min.css\";i:276;s:24:\"paragraph/editor-rtl.css\";i:277;s:28:\"paragraph/editor-rtl.min.css\";i:278;s:20:\"paragraph/editor.css\";i:279;s:24:\"paragraph/editor.min.css\";i:280;s:23:\"paragraph/style-rtl.css\";i:281;s:27:\"paragraph/style-rtl.min.css\";i:282;s:19:\"paragraph/style.css\";i:283;s:23:\"paragraph/style.min.css\";i:284;s:35:\"post-author-biography/style-rtl.css\";i:285;s:39:\"post-author-biography/style-rtl.min.css\";i:286;s:31:\"post-author-biography/style.css\";i:287;s:35:\"post-author-biography/style.min.css\";i:288;s:30:\"post-author-name/style-rtl.css\";i:289;s:34:\"post-author-name/style-rtl.min.css\";i:290;s:26:\"post-author-name/style.css\";i:291;s:30:\"post-author-name/style.min.css\";i:292;s:26:\"post-author/editor-rtl.css\";i:293;s:30:\"post-author/editor-rtl.min.css\";i:294;s:22:\"post-author/editor.css\";i:295;s:26:\"post-author/editor.min.css\";i:296;s:25:\"post-author/style-rtl.css\";i:297;s:29:\"post-author/style-rtl.min.css\";i:298;s:21:\"post-author/style.css\";i:299;s:25:\"post-author/style.min.css\";i:300;s:33:\"post-comments-form/editor-rtl.css\";i:301;s:37:\"post-comments-form/editor-rtl.min.css\";i:302;s:29:\"post-comments-form/editor.css\";i:303;s:33:\"post-comments-form/editor.min.css\";i:304;s:32:\"post-comments-form/style-rtl.css\";i:305;s:36:\"post-comments-form/style-rtl.min.css\";i:306;s:28:\"post-comments-form/style.css\";i:307;s:32:\"post-comments-form/style.min.css\";i:308;s:26:\"post-content/style-rtl.css\";i:309;s:30:\"post-content/style-rtl.min.css\";i:310;s:22:\"post-content/style.css\";i:311;s:26:\"post-content/style.min.css\";i:312;s:23:\"post-date/style-rtl.css\";i:313;s:27:\"post-date/style-rtl.min.css\";i:314;s:19:\"post-date/style.css\";i:315;s:23:\"post-date/style.min.css\";i:316;s:27:\"post-excerpt/editor-rtl.css\";i:317;s:31:\"post-excerpt/editor-rtl.min.css\";i:318;s:23:\"post-excerpt/editor.css\";i:319;s:27:\"post-excerpt/editor.min.css\";i:320;s:26:\"post-excerpt/style-rtl.css\";i:321;s:30:\"post-excerpt/style-rtl.min.css\";i:322;s:22:\"post-excerpt/style.css\";i:323;s:26:\"post-excerpt/style.min.css\";i:324;s:34:\"post-featured-image/editor-rtl.css\";i:325;s:38:\"post-featured-image/editor-rtl.min.css\";i:326;s:30:\"post-featured-image/editor.css\";i:327;s:34:\"post-featured-image/editor.min.css\";i:328;s:33:\"post-featured-image/style-rtl.css\";i:329;s:37:\"post-featured-image/style-rtl.min.css\";i:330;s:29:\"post-featured-image/style.css\";i:331;s:33:\"post-featured-image/style.min.css\";i:332;s:34:\"post-navigation-link/style-rtl.css\";i:333;s:38:\"post-navigation-link/style-rtl.min.css\";i:334;s:30:\"post-navigation-link/style.css\";i:335;s:34:\"post-navigation-link/style.min.css\";i:336;s:27:\"post-template/style-rtl.css\";i:337;s:31:\"post-template/style-rtl.min.css\";i:338;s:23:\"post-template/style.css\";i:339;s:27:\"post-template/style.min.css\";i:340;s:24:\"post-terms/style-rtl.css\";i:341;s:28:\"post-terms/style-rtl.min.css\";i:342;s:20:\"post-terms/style.css\";i:343;s:24:\"post-terms/style.min.css\";i:344;s:24:\"post-title/style-rtl.css\";i:345;s:28:\"post-title/style-rtl.min.css\";i:346;s:20:\"post-title/style.css\";i:347;s:24:\"post-title/style.min.css\";i:348;s:26:\"preformatted/style-rtl.css\";i:349;s:30:\"preformatted/style-rtl.min.css\";i:350;s:22:\"preformatted/style.css\";i:351;s:26:\"preformatted/style.min.css\";i:352;s:24:\"pullquote/editor-rtl.css\";i:353;s:28:\"pullquote/editor-rtl.min.css\";i:354;s:20:\"pullquote/editor.css\";i:355;s:24:\"pullquote/editor.min.css\";i:356;s:23:\"pullquote/style-rtl.css\";i:357;s:27:\"pullquote/style-rtl.min.css\";i:358;s:19:\"pullquote/style.css\";i:359;s:23:\"pullquote/style.min.css\";i:360;s:23:\"pullquote/theme-rtl.css\";i:361;s:27:\"pullquote/theme-rtl.min.css\";i:362;s:19:\"pullquote/theme.css\";i:363;s:23:\"pullquote/theme.min.css\";i:364;s:39:\"query-pagination-numbers/editor-rtl.css\";i:365;s:43:\"query-pagination-numbers/editor-rtl.min.css\";i:366;s:35:\"query-pagination-numbers/editor.css\";i:367;s:39:\"query-pagination-numbers/editor.min.css\";i:368;s:31:\"query-pagination/editor-rtl.css\";i:369;s:35:\"query-pagination/editor-rtl.min.css\";i:370;s:27:\"query-pagination/editor.css\";i:371;s:31:\"query-pagination/editor.min.css\";i:372;s:30:\"query-pagination/style-rtl.css\";i:373;s:34:\"query-pagination/style-rtl.min.css\";i:374;s:26:\"query-pagination/style.css\";i:375;s:30:\"query-pagination/style.min.css\";i:376;s:25:\"query-title/style-rtl.css\";i:377;s:29:\"query-title/style-rtl.min.css\";i:378;s:21:\"query-title/style.css\";i:379;s:25:\"query-title/style.min.css\";i:380;s:25:\"query-total/style-rtl.css\";i:381;s:29:\"query-total/style-rtl.min.css\";i:382;s:21:\"query-total/style.css\";i:383;s:25:\"query-total/style.min.css\";i:384;s:20:\"query/editor-rtl.css\";i:385;s:24:\"query/editor-rtl.min.css\";i:386;s:16:\"query/editor.css\";i:387;s:20:\"query/editor.min.css\";i:388;s:19:\"quote/style-rtl.css\";i:389;s:23:\"quote/style-rtl.min.css\";i:390;s:15:\"quote/style.css\";i:391;s:19:\"quote/style.min.css\";i:392;s:19:\"quote/theme-rtl.css\";i:393;s:23:\"quote/theme-rtl.min.css\";i:394;s:15:\"quote/theme.css\";i:395;s:19:\"quote/theme.min.css\";i:396;s:23:\"read-more/style-rtl.css\";i:397;s:27:\"read-more/style-rtl.min.css\";i:398;s:19:\"read-more/style.css\";i:399;s:23:\"read-more/style.min.css\";i:400;s:18:\"rss/editor-rtl.css\";i:401;s:22:\"rss/editor-rtl.min.css\";i:402;s:14:\"rss/editor.css\";i:403;s:18:\"rss/editor.min.css\";i:404;s:17:\"rss/style-rtl.css\";i:405;s:21:\"rss/style-rtl.min.css\";i:406;s:13:\"rss/style.css\";i:407;s:17:\"rss/style.min.css\";i:408;s:21:\"search/editor-rtl.css\";i:409;s:25:\"search/editor-rtl.min.css\";i:410;s:17:\"search/editor.css\";i:411;s:21:\"search/editor.min.css\";i:412;s:20:\"search/style-rtl.css\";i:413;s:24:\"search/style-rtl.min.css\";i:414;s:16:\"search/style.css\";i:415;s:20:\"search/style.min.css\";i:416;s:20:\"search/theme-rtl.css\";i:417;s:24:\"search/theme-rtl.min.css\";i:418;s:16:\"search/theme.css\";i:419;s:20:\"search/theme.min.css\";i:420;s:24:\"separator/editor-rtl.css\";i:421;s:28:\"separator/editor-rtl.min.css\";i:422;s:20:\"separator/editor.css\";i:423;s:24:\"separator/editor.min.css\";i:424;s:23:\"separator/style-rtl.css\";i:425;s:27:\"separator/style-rtl.min.css\";i:426;s:19:\"separator/style.css\";i:427;s:23:\"separator/style.min.css\";i:428;s:23:\"separator/theme-rtl.css\";i:429;s:27:\"separator/theme-rtl.min.css\";i:430;s:19:\"separator/theme.css\";i:431;s:23:\"separator/theme.min.css\";i:432;s:24:\"shortcode/editor-rtl.css\";i:433;s:28:\"shortcode/editor-rtl.min.css\";i:434;s:20:\"shortcode/editor.css\";i:435;s:24:\"shortcode/editor.min.css\";i:436;s:24:\"site-logo/editor-rtl.css\";i:437;s:28:\"site-logo/editor-rtl.min.css\";i:438;s:20:\"site-logo/editor.css\";i:439;s:24:\"site-logo/editor.min.css\";i:440;s:23:\"site-logo/style-rtl.css\";i:441;s:27:\"site-logo/style-rtl.min.css\";i:442;s:19:\"site-logo/style.css\";i:443;s:23:\"site-logo/style.min.css\";i:444;s:27:\"site-tagline/editor-rtl.css\";i:445;s:31:\"site-tagline/editor-rtl.min.css\";i:446;s:23:\"site-tagline/editor.css\";i:447;s:27:\"site-tagline/editor.min.css\";i:448;s:26:\"site-tagline/style-rtl.css\";i:449;s:30:\"site-tagline/style-rtl.min.css\";i:450;s:22:\"site-tagline/style.css\";i:451;s:26:\"site-tagline/style.min.css\";i:452;s:25:\"site-title/editor-rtl.css\";i:453;s:29:\"site-title/editor-rtl.min.css\";i:454;s:21:\"site-title/editor.css\";i:455;s:25:\"site-title/editor.min.css\";i:456;s:24:\"site-title/style-rtl.css\";i:457;s:28:\"site-title/style-rtl.min.css\";i:458;s:20:\"site-title/style.css\";i:459;s:24:\"site-title/style.min.css\";i:460;s:26:\"social-link/editor-rtl.css\";i:461;s:30:\"social-link/editor-rtl.min.css\";i:462;s:22:\"social-link/editor.css\";i:463;s:26:\"social-link/editor.min.css\";i:464;s:27:\"social-links/editor-rtl.css\";i:465;s:31:\"social-links/editor-rtl.min.css\";i:466;s:23:\"social-links/editor.css\";i:467;s:27:\"social-links/editor.min.css\";i:468;s:26:\"social-links/style-rtl.css\";i:469;s:30:\"social-links/style-rtl.min.css\";i:470;s:22:\"social-links/style.css\";i:471;s:26:\"social-links/style.min.css\";i:472;s:21:\"spacer/editor-rtl.css\";i:473;s:25:\"spacer/editor-rtl.min.css\";i:474;s:17:\"spacer/editor.css\";i:475;s:21:\"spacer/editor.min.css\";i:476;s:20:\"spacer/style-rtl.css\";i:477;s:24:\"spacer/style-rtl.min.css\";i:478;s:16:\"spacer/style.css\";i:479;s:20:\"spacer/style.min.css\";i:480;s:20:\"table/editor-rtl.css\";i:481;s:24:\"table/editor-rtl.min.css\";i:482;s:16:\"table/editor.css\";i:483;s:20:\"table/editor.min.css\";i:484;s:19:\"table/style-rtl.css\";i:485;s:23:\"table/style-rtl.min.css\";i:486;s:15:\"table/style.css\";i:487;s:19:\"table/style.min.css\";i:488;s:19:\"table/theme-rtl.css\";i:489;s:23:\"table/theme-rtl.min.css\";i:490;s:15:\"table/theme.css\";i:491;s:19:\"table/theme.min.css\";i:492;s:24:\"tag-cloud/editor-rtl.css\";i:493;s:28:\"tag-cloud/editor-rtl.min.css\";i:494;s:20:\"tag-cloud/editor.css\";i:495;s:24:\"tag-cloud/editor.min.css\";i:496;s:23:\"tag-cloud/style-rtl.css\";i:497;s:27:\"tag-cloud/style-rtl.min.css\";i:498;s:19:\"tag-cloud/style.css\";i:499;s:23:\"tag-cloud/style.min.css\";i:500;s:28:\"template-part/editor-rtl.css\";i:501;s:32:\"template-part/editor-rtl.min.css\";i:502;s:24:\"template-part/editor.css\";i:503;s:28:\"template-part/editor.min.css\";i:504;s:27:\"template-part/theme-rtl.css\";i:505;s:31:\"template-part/theme-rtl.min.css\";i:506;s:23:\"template-part/theme.css\";i:507;s:27:\"template-part/theme.min.css\";i:508;s:30:\"term-description/style-rtl.css\";i:509;s:34:\"term-description/style-rtl.min.css\";i:510;s:26:\"term-description/style.css\";i:511;s:30:\"term-description/style.min.css\";i:512;s:27:\"text-columns/editor-rtl.css\";i:513;s:31:\"text-columns/editor-rtl.min.css\";i:514;s:23:\"text-columns/editor.css\";i:515;s:27:\"text-columns/editor.min.css\";i:516;s:26:\"text-columns/style-rtl.css\";i:517;s:30:\"text-columns/style-rtl.min.css\";i:518;s:22:\"text-columns/style.css\";i:519;s:26:\"text-columns/style.min.css\";i:520;s:19:\"verse/style-rtl.css\";i:521;s:23:\"verse/style-rtl.min.css\";i:522;s:15:\"verse/style.css\";i:523;s:19:\"verse/style.min.css\";i:524;s:20:\"video/editor-rtl.css\";i:525;s:24:\"video/editor-rtl.min.css\";i:526;s:16:\"video/editor.css\";i:527;s:20:\"video/editor.min.css\";i:528;s:19:\"video/style-rtl.css\";i:529;s:23:\"video/style-rtl.min.css\";i:530;s:15:\"video/style.css\";i:531;s:19:\"video/style.min.css\";i:532;s:19:\"video/theme-rtl.css\";i:533;s:23:\"video/theme-rtl.min.css\";i:534;s:15:\"video/theme.css\";i:535;s:19:\"video/theme.min.css\";}}','on'),
(122,'_site_transient_timeout_wp_theme_files_patterns-b24c4b64a1fe6f9f73313f730ddfc1cf','1772740068','off'),
(123,'_site_transient_wp_theme_files_patterns-b24c4b64a1fe6f9f73313f730ddfc1cf','a:2:{s:7:\"version\";s:3:\"1.3\";s:8:\"patterns\";a:98:{s:21:\"banner-about-book.php\";a:4:{s:5:\"title\";s:28:\"Banner with book description\";s:4:\"slug\";s:34:\"twentytwentyfive/banner-about-book\";s:11:\"description\";s:66:\"Banner with book description and accompanying image for promotion.\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}}s:28:\"banner-cover-big-heading.php\";a:4:{s:5:\"title\";s:22:\"Cover with big heading\";s:4:\"slug\";s:41:\"twentytwentyfive/banner-cover-big-heading\";s:11:\"description\";s:82:\"A full-width cover section with a large background image and an oversized heading.\";s:10:\"categories\";a:3:{i:0;s:6:\"banner\";i:1;s:5:\"about\";i:2;s:8:\"featured\";}}s:22:\"banner-intro-image.php\";a:4:{s:5:\"title\";s:49:\"Short heading and paragraph and image on the left\";s:4:\"slug\";s:35:\"twentytwentyfive/banner-intro-image\";s:11:\"description\";s:68:\"A Intro pattern with Short heading, paragraph and image on the left.\";s:10:\"categories\";a:2:{i:0;s:6:\"banner\";i:1;s:8:\"featured\";}}s:16:\"banner-intro.php\";a:4:{s:5:\"title\";s:35:\"Intro with left-aligned description\";s:4:\"slug\";s:29:\"twentytwentyfive/banner-intro\";s:11:\"description\";s:66:\"A large left-aligned heading with a brand name emphasized in bold.\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}}s:17:\"banner-poster.php\";a:4:{s:5:\"title\";s:19:\"Poster-like section\";s:4:\"slug\";s:30:\"twentytwentyfive/banner-poster\";s:11:\"description\";s:78:\"A section that can be used as a banner or a landing page to announce an event.\";s:10:\"categories\";a:2:{i:0;s:6:\"banner\";i:1;s:5:\"media\";}}s:43:\"banner-with-description-and-images-grid.php\";a:4:{s:5:\"title\";s:39:\"Banner with description and images grid\";s:4:\"slug\";s:47:\"twentytwentyfive/banner-description-images-grid\";s:11:\"description\";s:75:\"A banner with a short paragraph, and two images displayed in a grid layout.\";s:10:\"categories\";a:2:{i:0;s:6:\"banner\";i:1;s:8:\"featured\";}}s:18:\"binding-format.php\";a:4:{s:5:\"title\";s:16:\"Post format name\";s:4:\"slug\";s:31:\"twentytwentyfive/binding-format\";s:11:\"description\";s:75:\"Prints the name of the post format with the help of the Block Bindings API.\";s:10:\"categories\";a:1:{i:0;s:28:\"twentytwentyfive_post-format\";}}s:12:\"comments.php\";a:5:{s:5:\"title\";s:8:\"Comments\";s:4:\"slug\";s:25:\"twentytwentyfive/comments\";s:11:\"description\";s:63:\"Comments area with comments list, pagination, and comment form.\";s:10:\"categories\";a:1:{i:0;s:4:\"text\";}s:10:\"blockTypes\";a:1:{i:0;s:13:\"core/comments\";}}s:32:\"contact-centered-social-link.php\";a:5:{s:5:\"title\";s:30:\"Centered link and social links\";s:4:\"slug\";s:45:\"twentytwentyfive/contact-centered-social-link\";s:11:\"description\";s:73:\"Centered contact section with a prominent message and social media links.\";s:10:\"categories\";a:1:{i:0;s:7:\"contact\";}s:8:\"keywords\";a:3:{i:0;s:7:\"contact\";i:1;s:3:\"faq\";i:2;s:9:\"questions\";}}s:26:\"contact-info-locations.php\";a:6:{s:5:\"title\";s:27:\"Contact, info and locations\";s:4:\"slug\";s:39:\"twentytwentyfive/contact-info-locations\";s:11:\"description\";s:78:\"Contact section with social media links, email, and multiple location details.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:1:{i:0;s:7:\"contact\";}s:8:\"keywords\";a:2:{i:0;s:7:\"contact\";i:1;s:8:\"location\";}}s:29:\"contact-location-and-link.php\";a:4:{s:5:\"title\";s:25:\"Contact location and link\";s:4:\"slug\";s:42:\"twentytwentyfive/contact-location-and-link\";s:11:\"description\";s:89:\"Contact section with a location address, a directions link, and an image of the location.\";s:10:\"categories\";a:2:{i:0;s:7:\"contact\";i:1;s:8:\"featured\";}}s:18:\"cta-book-links.php\";a:4:{s:5:\"title\";s:30:\"Call to action with book links\";s:4:\"slug\";s:31:\"twentytwentyfive/cta-book-links\";s:11:\"description\";s:74:\"A call to action section with links to get the book in different websites.\";s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}}s:22:\"cta-book-locations.php\";a:4:{s:5:\"title\";s:29:\"Call to action with locations\";s:4:\"slug\";s:35:\"twentytwentyfive/cta-book-locations\";s:11:\"description\";s:82:\"A call to action section with links to get the book in the most popular locations.\";s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}}s:24:\"cta-centered-heading.php\";a:4:{s:5:\"title\";s:16:\"Centered heading\";s:4:\"slug\";s:37:\"twentytwentyfive/cta-centered-heading\";s:11:\"description\";s:53:\"A hero with a centered heading, paragraph and button.\";s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}}s:19:\"cta-events-list.php\";a:4:{s:5:\"title\";s:11:\"Events list\";s:4:\"slug\";s:32:\"twentytwentyfive/cta-events-list\";s:11:\"description\";s:37:\"A list of events with call to action.\";s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}}s:26:\"cta-grid-products-link.php\";a:5:{s:5:\"title\";s:54:\"Call to action with grid layout with products and link\";s:4:\"slug\";s:39:\"twentytwentyfive/cta-grid-products-link\";s:11:\"description\";s:42:\"A call to action featuring product images.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:14:\"call-to-action\";i:1;s:8:\"featured\";}}s:22:\"cta-heading-search.php\";a:4:{s:5:\"title\";s:23:\"Heading and search form\";s:4:\"slug\";s:35:\"twentytwentyfive/cta-heading-search\";s:11:\"description\";s:54:\"Large heading with a search form for quick navigation.\";s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}}s:18:\"cta-newsletter.php\";a:5:{s:5:\"title\";s:18:\"Newsletter sign-up\";s:4:\"slug\";s:31:\"twentytwentyfive/cta-newsletter\";s:11:\"description\";s:0:\"\";s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}s:8:\"keywords\";a:2:{i:0;s:14:\"call-to-action\";i:1;s:10:\"newsletter\";}}s:15:\"event-3-col.php\";a:5:{s:5:\"title\";s:46:\"Events, 3 columns with event images and titles\";s:4:\"slug\";s:28:\"twentytwentyfive/event-3-col\";s:11:\"description\";s:95:\"A header with title and text and three columns that show 3 events with their images and titles.\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}s:8:\"keywords\";a:3:{i:0;s:6:\"events\";i:1;s:7:\"columns\";i:2;s:6:\"images\";}}s:14:\"event-rsvp.php\";a:7:{s:5:\"title\";s:10:\"Event RSVP\";s:4:\"slug\";s:27:\"twentytwentyfive/event-rsvp\";s:11:\"description\";s:64:\"RSVP for an upcoming event with a cover image and event details.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}s:8:\"keywords\";a:3:{i:0;s:14:\"call-to-action\";i:1;s:4:\"rsvp\";i:2;s:5:\"event\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}}s:18:\"event-schedule.php\";a:5:{s:5:\"title\";s:14:\"Event schedule\";s:4:\"slug\";s:31:\"twentytwentyfive/event-schedule\";s:11:\"description\";s:54:\"A section with specified dates and times for an event.\";s:10:\"categories\";a:1:{i:0;s:5:\"about\";}s:8:\"keywords\";a:4:{i:0;s:6:\"events\";i:1;s:6:\"agenda\";i:2;s:8:\"schedule\";i:3;s:8:\"lectures\";}}s:19:\"footer-centered.php\";a:5:{s:5:\"title\";s:15:\"Centered footer\";s:4:\"slug\";s:32:\"twentytwentyfive/footer-centered\";s:11:\"description\";s:44:\"Footer with centered site title and tagline.\";s:10:\"categories\";a:1:{i:0;s:6:\"footer\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/footer\";}}s:18:\"footer-columns.php\";a:5:{s:5:\"title\";s:19:\"Footer with columns\";s:4:\"slug\";s:31:\"twentytwentyfive/footer-columns\";s:11:\"description\";s:45:\"Footer columns with title, tagline and links.\";s:10:\"categories\";a:1:{i:0;s:6:\"footer\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/footer\";}}s:21:\"footer-newsletter.php\";a:5:{s:5:\"title\";s:29:\"Footer with newsletter signup\";s:4:\"slug\";s:34:\"twentytwentyfive/footer-newsletter\";s:11:\"description\";s:51:\"Footer with large site title and newsletter signup.\";s:10:\"categories\";a:1:{i:0;s:6:\"footer\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/footer\";}}s:17:\"footer-social.php\";a:5:{s:5:\"title\";s:33:\"Centered footer with social links\";s:4:\"slug\";s:30:\"twentytwentyfive/footer-social\";s:11:\"description\";s:49:\"Footer with centered site title and social links.\";s:10:\"categories\";a:1:{i:0;s:6:\"footer\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/footer\";}}s:10:\"footer.php\";a:5:{s:5:\"title\";s:6:\"Footer\";s:4:\"slug\";s:23:\"twentytwentyfive/footer\";s:11:\"description\";s:51:\"Footer columns with logo, title, tagline and links.\";s:10:\"categories\";a:1:{i:0;s:6:\"footer\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/footer\";}}s:16:\"format-audio.php\";a:4:{s:5:\"title\";s:12:\"Audio format\";s:4:\"slug\";s:29:\"twentytwentyfive/format-audio\";s:11:\"description\";s:73:\"An audio post format with an image, title, audio player, and description.\";s:10:\"categories\";a:1:{i:0;s:28:\"twentytwentyfive_post-format\";}}s:15:\"format-link.php\";a:4:{s:5:\"title\";s:11:\"Link format\";s:4:\"slug\";s:28:\"twentytwentyfive/format-link\";s:11:\"description\";s:77:\"A link post format with a description and an emphasized link for key content.\";s:10:\"categories\";a:1:{i:0;s:28:\"twentytwentyfive_post-format\";}}s:15:\"grid-videos.php\";a:4:{s:5:\"title\";s:16:\"Grid with videos\";s:4:\"slug\";s:28:\"twentytwentyfive/grid-videos\";s:11:\"description\";s:19:\"A grid with videos.\";s:10:\"categories\";a:1:{i:0;s:5:\"about\";}}s:24:\"grid-with-categories.php\";a:5:{s:5:\"title\";s:20:\"Grid with categories\";s:4:\"slug\";s:37:\"twentytwentyfive/grid-with-categories\";s:11:\"description\";s:41:\"A grid section with different categories.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}}s:19:\"header-centered.php\";a:5:{s:5:\"title\";s:20:\"Centered site header\";s:4:\"slug\";s:32:\"twentytwentyfive/header-centered\";s:11:\"description\";s:52:\"Site header with centered site title and navigation.\";s:10:\"categories\";a:1:{i:0;s:6:\"header\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/header\";}}s:18:\"header-columns.php\";a:5:{s:5:\"title\";s:19:\"Header with columns\";s:4:\"slug\";s:31:\"twentytwentyfive/header-columns\";s:11:\"description\";s:54:\"Site header with site title and navigation in columns.\";s:10:\"categories\";a:1:{i:0;s:6:\"header\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/header\";}}s:22:\"header-large-title.php\";a:5:{s:5:\"title\";s:23:\"Header with large title\";s:4:\"slug\";s:35:\"twentytwentyfive/header-large-title\";s:11:\"description\";s:63:\"Site header with large site title and right-aligned navigation.\";s:10:\"categories\";a:1:{i:0;s:6:\"header\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/header\";}}s:10:\"header.php\";a:5:{s:5:\"title\";s:6:\"Header\";s:4:\"slug\";s:23:\"twentytwentyfive/header\";s:11:\"description\";s:43:\"Site header with site title and navigation.\";s:10:\"categories\";a:1:{i:0;s:6:\"header\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/template-part/header\";}}s:36:\"heading-and-paragraph-with-image.php\";a:4:{s:5:\"title\";s:45:\"Heading and paragraph with image on the right\";s:4:\"slug\";s:49:\"twentytwentyfive/heading-and-paragraph-with-image\";s:11:\"description\";s:89:\"A two-column section with a heading and paragraph on the left, and an image on the right.\";s:10:\"categories\";a:1:{i:0;s:5:\"about\";}}s:13:\"hero-book.php\";a:5:{s:5:\"title\";s:9:\"Hero book\";s:4:\"slug\";s:26:\"twentytwentyfive/hero-book\";s:11:\"description\";s:66:\"A hero section for the book with a description and pre-order link.\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}s:8:\"keywords\";a:3:{i:0;s:7:\"podcast\";i:1;s:4:\"hero\";i:2;s:7:\"stories\";}}s:25:\"hero-full-width-image.php\";a:4:{s:5:\"title\";s:22:\"Hero, full width image\";s:4:\"slug\";s:38:\"twentytwentyfive/hero-full-width-image\";s:11:\"description\";s:68:\"A hero with a full width image, heading, short paragraph and button.\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}}s:41:\"hero-overlapped-book-cover-with-links.php\";a:4:{s:5:\"title\";s:38:\"Hero, overlapped book cover with links\";s:4:\"slug\";s:54:\"twentytwentyfive/hero-overlapped-book-cover-with-links\";s:11:\"description\";s:47:\"A hero with an overlapped book cover and links.\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}}s:16:\"hero-podcast.php\";a:5:{s:5:\"title\";s:12:\"Hero podcast\";s:4:\"slug\";s:29:\"twentytwentyfive/hero-podcast\";s:11:\"description\";s:0:\"\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}s:8:\"keywords\";a:3:{i:0;s:7:\"podcast\";i:1;s:4:\"hero\";i:2;s:7:\"stories\";}}s:14:\"hidden-404.php\";a:4:{s:5:\"title\";s:3:\"404\";s:4:\"slug\";s:27:\"twentytwentyfive/hidden-404\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;}s:23:\"hidden-blog-heading.php\";a:4:{s:5:\"title\";s:19:\"Hidden blog heading\";s:4:\"slug\";s:36:\"twentytwentyfive/hidden-blog-heading\";s:11:\"description\";s:52:\"Hidden heading for the home page and index template.\";s:8:\"inserter\";b:0;}s:17:\"hidden-search.php\";a:4:{s:5:\"title\";s:6:\"Search\";s:4:\"slug\";s:30:\"twentytwentyfive/hidden-search\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;}s:18:\"hidden-sidebar.php\";a:4:{s:5:\"title\";s:7:\"Sidebar\";s:4:\"slug\";s:31:\"twentytwentyfive/hidden-sidebar\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;}s:21:\"hidden-written-by.php\";a:4:{s:5:\"title\";s:10:\"Written by\";s:4:\"slug\";s:34:\"twentytwentyfive/hidden-written-by\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;}s:9:\"logos.php\";a:4:{s:5:\"title\";s:5:\"Logos\";s:4:\"slug\";s:22:\"twentytwentyfive/logos\";s:11:\"description\";s:77:\"Showcasing the podcast\'s clients with a heading and a series of client logos.\";s:10:\"categories\";a:1:{i:0;s:6:\"banner\";}}s:24:\"media-instagram-grid.php\";a:5:{s:5:\"title\";s:14:\"Instagram grid\";s:4:\"slug\";s:37:\"twentytwentyfive/media-instagram-grid\";s:11:\"description\";s:62:\"A grid section with photos and a link to an Instagram profile.\";s:13:\"viewportWidth\";i:1440;s:10:\"categories\";a:3:{i:0;s:5:\"media\";i:1;s:7:\"gallery\";i:2;s:8:\"featured\";}}s:14:\"more-posts.php\";a:5:{s:5:\"title\";s:10:\"More posts\";s:4:\"slug\";s:27:\"twentytwentyfive/more-posts\";s:11:\"description\";s:45:\"Displays a list of posts with title and date.\";s:10:\"categories\";a:1:{i:0;s:5:\"query\";}s:10:\"blockTypes\";a:1:{i:0;s:10:\"core/query\";}}s:21:\"overlapped-images.php\";a:4:{s:5:\"title\";s:41:\"Overlapping images and paragraph on right\";s:4:\"slug\";s:34:\"twentytwentyfive/overlapped-images\";s:11:\"description\";s:53:\"A section with overlapping images, and a description.\";s:10:\"categories\";a:2:{i:0;s:5:\"about\";i:1;s:8:\"featured\";}}s:22:\"page-business-home.php\";a:8:{s:5:\"title\";s:17:\"Business homepage\";s:4:\"slug\";s:35:\"twentytwentyfive/page-business-home\";s:11:\"description\";s:28:\"A business homepage pattern.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:20:\"page-coming-soon.php\";a:8:{s:5:\"title\";s:11:\"Coming soon\";s:4:\"slug\";s:33:\"twentytwentyfive/page-coming-soon\";s:11:\"description\";s:96:\"A full-width cover banner that can be applied to a page or it can work as a single landing page.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:15:\"page-cv-bio.php\";a:7:{s:5:\"title\";s:6:\"CV/bio\";s:4:\"slug\";s:28:\"twentytwentyfive/page-cv-bio\";s:11:\"description\";s:36:\"A pattern for a CV/Bio landing page.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:3:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:5:\"about\";i:2;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}}s:21:\"page-landing-book.php\";a:8:{s:5:\"title\";s:21:\"Landing page for book\";s:4:\"slug\";s:34:\"twentytwentyfive/page-landing-book\";s:11:\"description\";s:104:\"A landing page for the book with a hero section, pre-order links, locations, FAQs and newsletter signup.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:22:\"page-landing-event.php\";a:8:{s:5:\"title\";s:22:\"Landing page for event\";s:4:\"slug\";s:35:\"twentytwentyfive/page-landing-event\";s:11:\"description\";s:87:\"A landing page for the event with a hero section, description, FAQs and call to action.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:24:\"page-landing-podcast.php\";a:8:{s:5:\"title\";s:24:\"Landing page for podcast\";s:4:\"slug\";s:37:\"twentytwentyfive/page-landing-podcast\";s:11:\"description\";s:111:\"A landing page for the podcast with a hero section, description, logos, grid with videos and newsletter signup.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:50:\"page-link-in-bio-heading-paragraph-links-image.php\";a:7:{s:5:\"title\";s:59:\"Link in bio heading, paragraph, links and full-height image\";s:4:\"slug\";s:63:\"twentytwentyfive/page-link-in-bio-heading-paragraph-links-image\";s:11:\"description\";s:84:\"A link in bio landing page with a heading, paragraph, links and a full height image.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:3:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:6:\"banner\";i:2;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}}s:33:\"page-link-in-bio-wide-margins.php\";a:7:{s:5:\"title\";s:48:\"Link in bio with profile, links and wide margins\";s:4:\"slug\";s:46:\"twentytwentyfive/page-link-in-bio-wide-margins\";s:11:\"description\";s:86:\"A link in bio landing page with social links, a profile photo and a brief description.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:3:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:6:\"banner\";i:2;s:8:\"featured\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}}s:39:\"page-link-in-bio-with-tight-margins.php\";a:8:{s:5:\"title\";s:30:\"Link in bio with tight margins\";s:4:\"slug\";s:52:\"twentytwentyfive/page-link-in-bio-with-tight-margins\";s:11:\"description\";s:90:\"A full-width, full-height link in bio section with an image, a paragraph and social links.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:6:\"banner\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:23:\"page-portfolio-home.php\";a:8:{s:5:\"title\";s:18:\"Portfolio homepage\";s:4:\"slug\";s:36:\"twentytwentyfive/page-portfolio-home\";s:11:\"description\";s:29:\"A portfolio homepage pattern.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:21:\"twentytwentyfive_page\";i:1;s:5:\"posts\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:18:\"page-shop-home.php\";a:8:{s:5:\"title\";s:13:\"Shop homepage\";s:4:\"slug\";s:31:\"twentytwentyfive/page-shop-home\";s:11:\"description\";s:24:\"A shop homepage pattern.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:1:{i:0;s:21:\"twentytwentyfive_page\";}s:8:\"keywords\";a:1:{i:0;s:7:\"starter\";}s:10:\"blockTypes\";a:1:{i:0;s:17:\"core/post-content\";}s:9:\"postTypes\";a:2:{i:0;s:4:\"page\";i:1;s:11:\"wp_template\";}}s:19:\"post-navigation.php\";a:5:{s:5:\"title\";s:15:\"Post navigation\";s:4:\"slug\";s:32:\"twentytwentyfive/post-navigation\";s:11:\"description\";s:29:\"Next and previous post links.\";s:10:\"categories\";a:1:{i:0;s:4:\"text\";}s:10:\"blockTypes\";a:1:{i:0;s:25:\"core/post-navigation-link\";}}s:17:\"pricing-2-col.php\";a:5:{s:5:\"title\";s:18:\"Pricing, 2 columns\";s:4:\"slug\";s:30:\"twentytwentyfive/pricing-2-col\";s:11:\"description\";s:88:\"Pricing section with two columns, pricing plan, description, and call-to-action buttons.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:1:{i:0;s:14:\"call-to-action\";}}s:17:\"pricing-3-col.php\";a:4:{s:5:\"title\";s:18:\"Pricing, 3 columns\";s:4:\"slug\";s:30:\"twentytwentyfive/pricing-3-col\";s:11:\"description\";s:100:\"A three-column boxed pricing table designed to showcase services, descriptions, and pricing options.\";s:10:\"categories\";a:3:{i:0;s:14:\"call-to-action\";i:1;s:6:\"banner\";i:2;s:8:\"services\";}}s:18:\"services-3-col.php\";a:4:{s:5:\"title\";s:19:\"Services, 3 columns\";s:4:\"slug\";s:31:\"twentytwentyfive/services-3-col\";s:11:\"description\";s:56:\"Three columns with images and text to showcase services.\";s:10:\"categories\";a:3:{i:0;s:14:\"call-to-action\";i:1;s:6:\"banner\";i:2;s:8:\"services\";}}s:36:\"services-subscriber-only-section.php\";a:4:{s:5:\"title\";s:33:\"Services, subscriber only section\";s:4:\"slug\";s:49:\"twentytwentyfive/services-subscriber-only-section\";s:11:\"description\";s:72:\"A subscriber-only section highlighting exclusive services and offerings.\";s:10:\"categories\";a:2:{i:0;s:14:\"call-to-action\";i:1;s:8:\"services\";}}s:24:\"services-team-photos.php\";a:4:{s:5:\"title\";s:21:\"Services, team photos\";s:4:\"slug\";s:37:\"twentytwentyfive/services-team-photos\";s:11:\"description\";s:59:\"Display team photos in a services section with grid layout.\";s:10:\"categories\";a:3:{i:0;s:6:\"banner\";i:1;s:14:\"call-to-action\";i:2;s:8:\"featured\";}}s:37:\"template-404-vertical-header-blog.php\";a:5:{s:5:\"title\";s:17:\"Right-aligned 404\";s:4:\"slug\";s:50:\"twentytwentyfive/template-404-vertical-header-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:13:\"templateTypes\";a:1:{i:0;s:3:\"404\";}}s:30:\"template-archive-news-blog.php\";a:6:{s:5:\"title\";s:17:\"News blog archive\";s:4:\"slug\";s:43:\"twentytwentyfive/template-archive-news-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:7:\"archive\";}}s:31:\"template-archive-photo-blog.php\";a:6:{s:5:\"title\";s:18:\"Photo blog archive\";s:4:\"slug\";s:44:\"twentytwentyfive/template-archive-photo-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:7:\"archive\";}}s:30:\"template-archive-text-blog.php\";a:6:{s:5:\"title\";s:17:\"Text blog archive\";s:4:\"slug\";s:43:\"twentytwentyfive/template-archive-text-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:7:\"archive\";}}s:41:\"template-archive-vertical-header-blog.php\";a:6:{s:5:\"title\";s:21:\"Right-aligned archive\";s:4:\"slug\";s:54:\"twentytwentyfive/template-archive-vertical-header-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:7:\"archive\";}}s:27:\"template-home-news-blog.php\";a:6:{s:5:\"title\";s:14:\"News blog home\";s:4:\"slug\";s:40:\"twentytwentyfive/template-home-news-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:3:{i:0;s:10:\"front-page\";i:1;s:5:\"index\";i:2;s:4:\"home\";}}s:28:\"template-home-photo-blog.php\";a:6:{s:5:\"title\";s:15:\"Photo blog home\";s:4:\"slug\";s:41:\"twentytwentyfive/template-home-photo-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:3:{i:0;s:10:\"front-page\";i:1;s:5:\"index\";i:2;s:4:\"home\";}}s:38:\"template-home-posts-grid-news-blog.php\";a:5:{s:5:\"title\";s:34:\"News blog with featured posts grid\";s:4:\"slug\";s:51:\"twentytwentyfive/template-home-posts-grid-news-blog\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:3:{i:0;s:10:\"front-page\";i:1;s:5:\"index\";i:2;s:4:\"home\";}}s:27:\"template-home-text-blog.php\";a:6:{s:5:\"title\";s:14:\"Text blog home\";s:4:\"slug\";s:40:\"twentytwentyfive/template-home-text-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:2:{i:0;s:10:\"front-page\";i:1;s:4:\"home\";}}s:38:\"template-home-vertical-header-blog.php\";a:6:{s:5:\"title\";s:18:\"Right-aligned home\";s:4:\"slug\";s:51:\"twentytwentyfive/template-home-vertical-header-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:3:{i:0;s:10:\"front-page\";i:1;s:5:\"index\";i:2;s:4:\"home\";}}s:40:\"template-home-with-sidebar-news-blog.php\";a:6:{s:5:\"title\";s:22:\"News blog with sidebar\";s:4:\"slug\";s:53:\"twentytwentyfive/template-home-with-sidebar-news-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:3:{i:0;s:10:\"front-page\";i:1;s:5:\"index\";i:2;s:4:\"home\";}}s:28:\"template-page-photo-blog.php\";a:5:{s:5:\"title\";s:15:\"Photo blog page\";s:4:\"slug\";s:41:\"twentytwentyfive/template-page-photo-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:13:\"templateTypes\";a:1:{i:0;s:4:\"page\";}}s:38:\"template-page-vertical-header-blog.php\";a:5:{s:5:\"title\";s:18:\"Right-aligned page\";s:4:\"slug\";s:51:\"twentytwentyfive/template-page-vertical-header-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:13:\"templateTypes\";a:1:{i:0;s:4:\"page\";}}s:33:\"template-query-loop-news-blog.php\";a:4:{s:5:\"title\";s:20:\"News blog query loop\";s:4:\"slug\";s:46:\"twentytwentyfive/template-query-loop-news-blog\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;}s:34:\"template-query-loop-photo-blog.php\";a:6:{s:5:\"title\";s:16:\"Photo blog posts\";s:4:\"slug\";s:47:\"twentytwentyfive/template-query-loop-photo-blog\";s:11:\"description\";s:54:\"A list of posts, 3 columns, with only featured images.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:1:{i:0;s:5:\"query\";}s:10:\"blockTypes\";a:1:{i:0;s:10:\"core/query\";}}s:33:\"template-query-loop-text-blog.php\";a:4:{s:5:\"title\";s:20:\"Text blog query loop\";s:4:\"slug\";s:46:\"twentytwentyfive/template-query-loop-text-blog\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;}s:44:\"template-query-loop-vertical-header-blog.php\";a:4:{s:5:\"title\";s:24:\"Right-aligned query loop\";s:4:\"slug\";s:57:\"twentytwentyfive/template-query-loop-vertical-header-blog\";s:11:\"description\";s:0:\"\";s:8:\"inserter\";b:0;}s:23:\"template-query-loop.php\";a:5:{s:5:\"title\";s:23:\"List of posts, 1 column\";s:4:\"slug\";s:36:\"twentytwentyfive/template-query-loop\";s:11:\"description\";s:61:\"A list of posts, 1 column, with featured image and post date.\";s:10:\"categories\";a:1:{i:0;s:5:\"query\";}s:10:\"blockTypes\";a:1:{i:0;s:10:\"core/query\";}}s:29:\"template-search-news-blog.php\";a:6:{s:5:\"title\";s:24:\"News blog search results\";s:4:\"slug\";s:42:\"twentytwentyfive/template-search-news-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:6:\"search\";}}s:30:\"template-search-photo-blog.php\";a:6:{s:5:\"title\";s:25:\"Photo blog search results\";s:4:\"slug\";s:43:\"twentytwentyfive/template-search-photo-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:6:\"search\";}}s:29:\"template-search-text-blog.php\";a:6:{s:5:\"title\";s:24:\"Text blog search results\";s:4:\"slug\";s:42:\"twentytwentyfive/template-search-text-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:6:\"search\";}}s:40:\"template-search-vertical-header-blog.php\";a:6:{s:5:\"title\";s:26:\"Right-aligned blog, search\";s:4:\"slug\";s:53:\"twentytwentyfive/template-search-vertical-header-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:1:{i:0;s:6:\"search\";}}s:40:\"template-single-left-aligned-content.php\";a:6:{s:5:\"title\";s:30:\"Post with left-aligned content\";s:4:\"slug\";s:47:\"twentytwentyfive/post-with-left-aligned-content\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:2:{i:0;s:5:\"posts\";i:1;s:6:\"single\";}}s:29:\"template-single-news-blog.php\";a:6:{s:5:\"title\";s:34:\"News blog single post with sidebar\";s:4:\"slug\";s:42:\"twentytwentyfive/template-single-news-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:2:{i:0;s:5:\"posts\";i:1;s:6:\"single\";}}s:26:\"template-single-offset.php\";a:6:{s:5:\"title\";s:34:\"Offset post without featured image\";s:4:\"slug\";s:39:\"twentytwentyfive/template-single-offset\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:2:{i:0;s:5:\"posts\";i:1;s:6:\"single\";}}s:30:\"template-single-photo-blog.php\";a:6:{s:5:\"title\";s:22:\"Photo blog single post\";s:4:\"slug\";s:43:\"twentytwentyfive/template-single-photo-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:2:{i:0;s:5:\"posts\";i:1;s:6:\"single\";}}s:29:\"template-single-text-blog.php\";a:6:{s:5:\"title\";s:21:\"Text blog single post\";s:4:\"slug\";s:42:\"twentytwentyfive/template-single-text-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:2:{i:0;s:5:\"posts\";i:1;s:6:\"single\";}}s:40:\"template-single-vertical-header-blog.php\";a:6:{s:5:\"title\";s:25:\"Right-aligned single post\";s:4:\"slug\";s:53:\"twentytwentyfive/template-single-vertical-header-blog\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";i:1400;s:8:\"inserter\";b:0;s:13:\"templateTypes\";a:2:{i:0;s:5:\"posts\";i:1;s:6:\"single\";}}s:22:\"testimonials-2-col.php\";a:5:{s:5:\"title\";s:21:\"2 columns with avatar\";s:4:\"slug\";s:35:\"twentytwentyfive/testimonials-2-col\";s:11:\"description\";s:42:\"Two columns with testimonials and avatars.\";s:10:\"categories\";a:1:{i:0;s:12:\"testimonials\";}s:8:\"keywords\";a:1:{i:0;s:11:\"testimonial\";}}s:22:\"testimonials-6-col.php\";a:5:{s:5:\"title\";s:35:\"3 column layout with 6 testimonials\";s:4:\"slug\";s:35:\"twentytwentyfive/testimonials-6-col\";s:11:\"description\";s:86:\"A section with three columns and two rows, each containing a testimonial and citation.\";s:10:\"categories\";a:1:{i:0;s:12:\"testimonials\";}s:8:\"keywords\";a:1:{i:0;s:11:\"testimonial\";}}s:22:\"testimonials-large.php\";a:5:{s:5:\"title\";s:32:\"Review with large image on right\";s:4:\"slug\";s:35:\"twentytwentyfive/testimonials-large\";s:11:\"description\";s:46:\"A testimonial with a large image on the right.\";s:10:\"categories\";a:1:{i:0;s:12:\"testimonials\";}s:8:\"keywords\";a:1:{i:0;s:11:\"testimonial\";}}s:13:\"text-faqs.php\";a:6:{s:5:\"title\";s:4:\"FAQs\";s:4:\"slug\";s:26:\"twentytwentyfive/text-faqs\";s:11:\"description\";s:68:\"A FAQs section with a FAQ heading and list of questions and answers.\";s:13:\"viewportWidth\";i:1400;s:10:\"categories\";a:2:{i:0;s:4:\"text\";i:1;s:5:\"about\";}s:8:\"keywords\";a:5:{i:0;s:3:\"faq\";i:1;s:5:\"about\";i:2;s:10:\"frequently\";i:3;s:5:\"asked\";i:4;s:9:\"questions\";}}s:19:\"vertical-header.php\";a:6:{s:5:\"title\";s:20:\"Vertical site header\";s:4:\"slug\";s:32:\"twentytwentyfive/vertical-header\";s:11:\"description\";s:52:\"Vertical site header with site title and navigation.\";s:13:\"viewportWidth\";i:300;s:10:\"categories\";a:1:{i:0;s:6:\"header\";}s:10:\"blockTypes\";a:1:{i:0;s:34:\"core/template-part/vertical-header\";}}}}','off'),
(125,'recovery_keys','a:0:{}','off'),
(126,'theme_mods_twentytwentyfive','a:1:{s:18:\"custom_css_post_id\";i:-1;}','auto'),
(127,'_transient_wp_styles_for_blocks','a:2:{s:4:\"hash\";s:32:\"995febb4f4fef6e5500e6199916c745b\";s:6:\"blocks\";a:52:{s:11:\"core/button\";s:0:\"\";s:14:\"core/site-logo\";s:0:\"\";s:18:\"core/post-template\";s:0:\"\";s:12:\"core/columns\";s:769:\":root :where(.wp-block-columns-is-layout-flow) > :first-child{margin-block-start: 0;}:root :where(.wp-block-columns-is-layout-flow) > :last-child{margin-block-end: 0;}:root :where(.wp-block-columns-is-layout-flow) > *{margin-block-start: var(--wp--preset--spacing--50);margin-block-end: 0;}:root :where(.wp-block-columns-is-layout-constrained) > :first-child{margin-block-start: 0;}:root :where(.wp-block-columns-is-layout-constrained) > :last-child{margin-block-end: 0;}:root :where(.wp-block-columns-is-layout-constrained) > *{margin-block-start: var(--wp--preset--spacing--50);margin-block-end: 0;}:root :where(.wp-block-columns-is-layout-flex){gap: var(--wp--preset--spacing--50);}:root :where(.wp-block-columns-is-layout-grid){gap: var(--wp--preset--spacing--50);}\";s:14:\"core/pullquote\";s:306:\":root :where(.wp-block-pullquote){font-size: var(--wp--preset--font-size--xx-large);font-weight: 300;line-height: 1.2;padding-top: var(--wp--preset--spacing--30);padding-bottom: var(--wp--preset--spacing--30);}:root :where(.wp-block-pullquote p:last-of-type){margin-bottom: var(--wp--preset--spacing--30);}\";s:32:\"c48738dcb285a3f6ab83acff204fc486\";s:106:\":root :where(.wp-block-pullquote cite){font-size: var(--wp--preset--font-size--small);font-style: normal;}\";s:11:\"core/avatar\";s:57:\":root :where(.wp-block-avatar img){border-radius: 100px;}\";s:12:\"core/buttons\";s:665:\":root :where(.wp-block-buttons-is-layout-flow) > :first-child{margin-block-start: 0;}:root :where(.wp-block-buttons-is-layout-flow) > :last-child{margin-block-end: 0;}:root :where(.wp-block-buttons-is-layout-flow) > *{margin-block-start: 16px;margin-block-end: 0;}:root :where(.wp-block-buttons-is-layout-constrained) > :first-child{margin-block-start: 0;}:root :where(.wp-block-buttons-is-layout-constrained) > :last-child{margin-block-end: 0;}:root :where(.wp-block-buttons-is-layout-constrained) > *{margin-block-start: 16px;margin-block-end: 0;}:root :where(.wp-block-buttons-is-layout-flex){gap: 16px;}:root :where(.wp-block-buttons-is-layout-grid){gap: 16px;}\";s:9:\"core/code\";s:427:\":root :where(.wp-block-code){background-color: var(--wp--preset--color--accent-5);color: var(--wp--preset--color--contrast);font-family: var(--wp--preset--font-family--fira-code);font-size: var(--wp--preset--font-size--medium);font-weight: 300;padding-top: var(--wp--preset--spacing--40);padding-right: var(--wp--preset--spacing--40);padding-bottom: var(--wp--preset--spacing--40);padding-left: var(--wp--preset--spacing--40);}\";s:24:\"core/comment-author-name\";s:169:\":root :where(.wp-block-comment-author-name){color: var(--wp--preset--color--accent-4);font-size: var(--wp--preset--font-size--small);margin-top: 5px;margin-bottom: 0px;}\";s:32:\"c0002c260f8238c4212f3e4c369fc4f7\";s:143:\":root :where(.wp-block-comment-author-name a:where(:not(.wp-element-button))){color: var(--wp--preset--color--accent-4);text-decoration: none;}\";s:32:\"1e7c38b45537b325dbbbaec17a301676\";s:112:\":root :where(.wp-block-comment-author-name a:where(:not(.wp-element-button)):hover){text-decoration: underline;}\";s:20:\"core/comment-content\";s:178:\":root :where(.wp-block-comment-content){font-size: var(--wp--preset--font-size--medium);margin-top: var(--wp--preset--spacing--30);margin-bottom: var(--wp--preset--spacing--30);}\";s:17:\"core/comment-date\";s:127:\":root :where(.wp-block-comment-date){color: var(--wp--preset--color--contrast);font-size: var(--wp--preset--font-size--small);}\";s:32:\"c83ca7b3e52884c70f7830c54f99b318\";s:114:\":root :where(.wp-block-comment-date a:where(:not(.wp-element-button))){color: var(--wp--preset--color--contrast);}\";s:22:\"core/comment-edit-link\";s:90:\":root :where(.wp-block-comment-edit-link){font-size: var(--wp--preset--font-size--small);}\";s:32:\"41d70710612536a90e368c12bcb0efea\";s:119:\":root :where(.wp-block-comment-edit-link a:where(:not(.wp-element-button))){color: var(--wp--preset--color--contrast);}\";s:23:\"core/comment-reply-link\";s:91:\":root :where(.wp-block-comment-reply-link){font-size: var(--wp--preset--font-size--small);}\";s:32:\"13c96340dbf37700add1f4c5cae19f3e\";s:120:\":root :where(.wp-block-comment-reply-link a:where(:not(.wp-element-button))){color: var(--wp--preset--color--contrast);}\";s:23:\"core/post-comments-form\";s:565:\":root :where(.wp-block-post-comments-form){font-size: var(--wp--preset--font-size--medium);padding-top: var(--wp--preset--spacing--40);padding-bottom: var(--wp--preset--spacing--40);}:root :where(.wp-block-post-comments-form textarea, .wp-block-post-comments-form input:not([type=submit])){border-radius:.25rem; border-color: var(--wp--preset--color--accent-6) !important;}:root :where(.wp-block-post-comments-form input[type=checkbox]){margin:0 .2rem 0 0 !important;}:root :where(.wp-block-post-comments-form label){font-size: var(--wp--preset--font-size--small);}\";s:24:\"core/comments-pagination\";s:182:\":root :where(.wp-block-comments-pagination){font-size: var(--wp--preset--font-size--medium);margin-top: var(--wp--preset--spacing--40);margin-bottom: var(--wp--preset--spacing--40);}\";s:29:\"core/comments-pagination-next\";s:98:\":root :where(.wp-block-comments-pagination-next){font-size: var(--wp--preset--font-size--medium);}\";s:32:\"core/comments-pagination-numbers\";s:101:\":root :where(.wp-block-comments-pagination-numbers){font-size: var(--wp--preset--font-size--medium);}\";s:33:\"core/comments-pagination-previous\";s:102:\":root :where(.wp-block-comments-pagination-previous){font-size: var(--wp--preset--font-size--medium);}\";s:14:\"core/post-date\";s:124:\":root :where(.wp-block-post-date){color: var(--wp--preset--color--accent-4);font-size: var(--wp--preset--font-size--small);}\";s:32:\"ac0d4e00f5ec22d14451759983e5bd43\";s:133:\":root :where(.wp-block-post-date a:where(:not(.wp-element-button))){color: var(--wp--preset--color--accent-4);text-decoration: none;}\";s:32:\"0ae6ffd1b886044c2da62d75d05ab13d\";s:102:\":root :where(.wp-block-post-date a:where(:not(.wp-element-button)):hover){text-decoration: underline;}\";s:25:\"core/post-navigation-link\";s:94:\":root :where(.wp-block-post-navigation-link){font-size: var(--wp--preset--font-size--medium);}\";s:15:\"core/post-terms\";s:158:\":root :where(.wp-block-post-terms){font-size: var(--wp--preset--font-size--small);font-weight: 600;}:root :where(.wp-block-post-terms a){white-space: nowrap;}\";s:15:\"core/post-title\";s:0:\"\";s:32:\"bb496d3fcd9be3502ce57ff8281e5687\";s:92:\":root :where(.wp-block-post-title a:where(:not(.wp-element-button))){text-decoration: none;}\";s:32:\"12380ab98fdc81351bb32a39bbfc9249\";s:103:\":root :where(.wp-block-post-title a:where(:not(.wp-element-button)):hover){text-decoration: underline;}\";s:10:\"core/quote\";s:1315:\":root :where(.wp-block-quote){border-color: currentColor;border-width: 0 0 0 2px;border-style: solid;font-size: var(--wp--preset--font-size--large);font-weight: 300;margin-right: 0;margin-left: 0;padding-top: var(--wp--preset--spacing--30);padding-right: var(--wp--preset--spacing--40);padding-bottom: var(--wp--preset--spacing--30);padding-left: var(--wp--preset--spacing--40);}:root :where(.wp-block-quote-is-layout-flow) > :first-child{margin-block-start: 0;}:root :where(.wp-block-quote-is-layout-flow) > :last-child{margin-block-end: 0;}:root :where(.wp-block-quote-is-layout-flow) > *{margin-block-start: var(--wp--preset--spacing--30);margin-block-end: 0;}:root :where(.wp-block-quote-is-layout-constrained) > :first-child{margin-block-start: 0;}:root :where(.wp-block-quote-is-layout-constrained) > :last-child{margin-block-end: 0;}:root :where(.wp-block-quote-is-layout-constrained) > *{margin-block-start: var(--wp--preset--spacing--30);margin-block-end: 0;}:root :where(.wp-block-quote-is-layout-flex){gap: var(--wp--preset--spacing--30);}:root :where(.wp-block-quote-is-layout-grid){gap: var(--wp--preset--spacing--30);}:root :where(.wp-block-quote.has-text-align-right ){border-width: 0 2px 0 0;}:root :where(.wp-block-quote.has-text-align-center ){border-width: 0;border-inline: 0; padding-inline: 0;}\";s:32:\"1de7a22e22013106efc5be82788cb6c0\";s:176:\":root :where(.wp-block-quote cite){font-size: var(--wp--preset--font-size--small);font-style: normal;font-weight: 300;}:root :where(.wp-block-quote cite sub){font-size: 0.65em}\";s:21:\"core/query-pagination\";s:107:\":root :where(.wp-block-query-pagination){font-size: var(--wp--preset--font-size--medium);font-weight: 500;}\";s:11:\"core/search\";s:380:\":root :where(.wp-block-search .wp-block-search__label, .wp-block-search .wp-block-search__input, .wp-block-search .wp-block-search__button){font-size: var(--wp--preset--font-size--medium);line-height: 1.6;}:root :where(.wp-block-search .wp-block-search__input){border-radius:3.125rem;padding-left:1.5625rem;padding-right:1.5625rem;border-color:var(--wp--preset--color--accent-6);}\";s:32:\"14fa6a3d0cfbde171cbc0fb04aa8a6cf\";s:138:\":root :where(.wp-block-search .wp-element-button,.wp-block-search  .wp-block-button__link){border-radius: 3.125rem;margin-left: 1.125rem;}\";s:32:\"05993ee2f3de94b5d1350998a7e9b6b0\";s:130:\":root :where(.wp-block-search .wp-element-button:hover,.wp-block-search  .wp-block-button__link:hover){border-color: transparent;}\";s:14:\"core/separator\";s:148:\":root :where(.wp-block-separator){border-color: currentColor;border-width: 0 0 1px 0;border-style: solid;color: var(--wp--preset--color--accent-6);}\";s:17:\"core/site-tagline\";s:86:\":root :where(.wp-block-site-tagline){font-size: var(--wp--preset--font-size--medium);}\";s:15:\"core/site-title\";s:75:\":root :where(.wp-block-site-title){font-weight: 700;letter-spacing: -.5px;}\";s:32:\"f513d889cf971b13995cc3fffed2f39b\";s:92:\":root :where(.wp-block-site-title a:where(:not(.wp-element-button))){text-decoration: none;}\";s:32:\"22c37a317cc0ebd50155b5ad78564f37\";s:103:\":root :where(.wp-block-site-title a:where(:not(.wp-element-button)):hover){text-decoration: underline;}\";s:21:\"core/term-description\";s:90:\":root :where(.wp-block-term-description){font-size: var(--wp--preset--font-size--medium);}\";s:15:\"core/navigation\";s:84:\":root :where(.wp-block-navigation){font-size: var(--wp--preset--font-size--medium);}\";s:32:\"25289a01850f5a0264ddb79a9a3baf3d\";s:92:\":root :where(.wp-block-navigation a:where(:not(.wp-element-button))){text-decoration: none;}\";s:32:\"026c04da08398d655a95047f1f235d97\";s:103:\":root :where(.wp-block-navigation a:where(:not(.wp-element-button)):hover){text-decoration: underline;}\";s:9:\"core/list\";s:52:\":root :where(.wp-block-list li){margin-top: 0.5rem;}\";s:12:\"core/heading\";s:0:\"\";s:14:\"core/paragraph\";s:0:\"\";s:10:\"core/group\";s:0:\"\";s:11:\"core/column\";s:0:\"\";}}','on'),
(128,'action_scheduler_hybrid_store_demarkation','5','auto'),
(129,'schema-ActionScheduler_StoreSchema','8.0.1772738269','auto'),
(130,'schema-ActionScheduler_LoggerSchema','3.0.1772738269','auto'),
(131,'_transient_timeout_as-post-store-dependencies-met','1772824669','off'),
(132,'_transient_as-post-store-dependencies-met','yes','off'),
(135,'woocommerce_newly_installed','yes','auto'),
(136,'woocommerce_order_stats_has_fulfillment_column','no','off'),
(137,'woocommerce_schema_version','920','auto'),
(138,'woocommerce_store_address','Av. Paulista, 1000','on'),
(139,'woocommerce_store_address_2','','on'),
(140,'woocommerce_store_city','São Paulo','on'),
(141,'woocommerce_default_country','BR:SP','on'),
(142,'woocommerce_store_postcode','01310-100','on'),
(143,'woocommerce_allowed_countries','all','on'),
(144,'woocommerce_all_except_countries','','on'),
(145,'woocommerce_specific_allowed_countries','','on'),
(146,'woocommerce_ship_to_countries','','on'),
(147,'woocommerce_specific_ship_to_countries','','on'),
(148,'woocommerce_default_customer_address','base','on'),
(149,'woocommerce_address_autocomplete_enabled','no','on'),
(150,'woocommerce_calc_taxes','no','on'),
(151,'woocommerce_enable_coupons','yes','on'),
(152,'woocommerce_calc_discounts_sequentially','no','off'),
(153,'woocommerce_currency','BRL','on'),
(154,'woocommerce_currency_pos','left','on'),
(155,'woocommerce_price_thousand_sep','.','on'),
(156,'woocommerce_price_decimal_sep',',','on'),
(157,'woocommerce_price_num_decimals','2','on'),
(158,'woocommerce_shop_page_id','5','on'),
(159,'woocommerce_cart_redirect_after_add','no','on'),
(160,'woocommerce_enable_ajax_add_to_cart','yes','on'),
(161,'woocommerce_placeholder_image','0','on'),
(162,'woocommerce_weight_unit','kg','on'),
(163,'woocommerce_dimension_unit','cm','on'),
(164,'woocommerce_enable_reviews','yes','on'),
(165,'woocommerce_review_rating_verification_label','yes','off'),
(166,'woocommerce_review_rating_verification_required','no','off'),
(167,'woocommerce_enable_review_rating','yes','on'),
(168,'woocommerce_review_rating_required','yes','off'),
(169,'woocommerce_manage_stock','yes','on'),
(170,'woocommerce_hold_stock_minutes','60','off'),
(171,'woocommerce_notify_low_stock','yes','off'),
(172,'woocommerce_notify_no_stock','yes','off'),
(173,'woocommerce_stock_email_recipient','admin@example.com','off'),
(174,'woocommerce_notify_low_stock_amount','2','off'),
(175,'woocommerce_notify_no_stock_amount','0','on'),
(176,'woocommerce_hide_out_of_stock_items','no','on'),
(177,'woocommerce_stock_format','','on'),
(178,'woocommerce_file_download_method','force','off'),
(179,'woocommerce_downloads_redirect_fallback_allowed','no','off'),
(180,'woocommerce_downloads_require_login','no','off'),
(181,'woocommerce_downloads_grant_access_after_payment','yes','off'),
(182,'woocommerce_downloads_deliver_inline','','off'),
(183,'woocommerce_downloads_add_hash_to_filename','yes','on'),
(184,'woocommerce_downloads_count_partial','yes','on'),
(186,'woocommerce_attribute_lookup_direct_updates','no','on'),
(187,'woocommerce_attribute_lookup_optimized_updates','no','on'),
(188,'woocommerce_product_match_featured_image_by_sku','no','on'),
(189,'woocommerce_prices_include_tax','no','on'),
(190,'woocommerce_tax_based_on','shipping','on'),
(191,'woocommerce_shipping_tax_class','inherit','on'),
(192,'woocommerce_tax_round_at_subtotal','no','on'),
(193,'woocommerce_tax_classes','','on'),
(194,'woocommerce_tax_display_shop','excl','on'),
(195,'woocommerce_tax_display_cart','excl','on'),
(196,'woocommerce_price_display_suffix','','on'),
(197,'woocommerce_tax_total_display','itemized','off'),
(198,'woocommerce_enable_shipping_calc','yes','off'),
(199,'woocommerce_shipping_cost_requires_address','no','on'),
(200,'woocommerce_shipping_hide_rates_when_free','no','off'),
(201,'woocommerce_ship_to_destination','billing','off'),
(202,'woocommerce_shipping_debug_mode','no','on'),
(203,'woocommerce_enable_guest_checkout','yes','off'),
(204,'woocommerce_enable_checkout_login_reminder','no','off'),
(205,'woocommerce_enable_delayed_account_creation','no','off'),
(206,'woocommerce_enable_signup_and_login_from_checkout','no','off'),
(207,'woocommerce_enable_myaccount_registration','no','off'),
(208,'woocommerce_registration_generate_password','yes','off'),
(209,'woocommerce_registration_generate_username','yes','off'),
(210,'woocommerce_erasure_request_removes_order_data','no','off'),
(211,'woocommerce_erasure_request_removes_download_data','no','off'),
(212,'woocommerce_allow_bulk_remove_personal_data','no','off'),
(213,'woocommerce_registration_privacy_policy_text','Your personal data will be used to support your experience throughout this website, to manage access to your account, and for other purposes described in our [privacy_policy].','on'),
(214,'woocommerce_checkout_privacy_policy_text','Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our [privacy_policy].','on'),
(215,'woocommerce_delete_inactive_accounts','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','off'),
(216,'woocommerce_trash_pending_orders','','off'),
(217,'woocommerce_trash_failed_orders','','off'),
(218,'woocommerce_trash_cancelled_orders','','off'),
(219,'woocommerce_anonymize_refunded_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','off'),
(220,'woocommerce_anonymize_completed_orders','a:2:{s:6:\"number\";s:0:\"\";s:4:\"unit\";s:6:\"months\";}','off'),
(221,'woocommerce_email_from_address','admin@example.com','off'),
(222,'woocommerce_email_header_image','','off'),
(223,'woocommerce_email_header_image_width','120','on'),
(224,'woocommerce_email_header_alignment','left','on'),
(225,'woocommerce_email_font_family','Helvetica','on'),
(226,'woocommerce_email_footer_text','{site_title}<br />{store_address}','off'),
(227,'woocommerce_email_base_color','#720eec','off'),
(228,'woocommerce_email_background_color','#f7f7f7','off'),
(229,'woocommerce_email_body_background_color','#ffffff','off'),
(230,'woocommerce_email_text_color','#3c3c3c','off'),
(231,'woocommerce_email_footer_text_color','#3c3c3c','off'),
(232,'woocommerce_email_auto_sync_with_theme','no','off'),
(233,'woocommerce_pos_store_name','AztecWP Browser Test Site','on'),
(234,'woocommerce_pos_store_address','','on'),
(235,'woocommerce_pos_store_phone','','on'),
(236,'woocommerce_pos_store_email','admin@example.com','on'),
(237,'woocommerce_pos_refund_returns_policy','','on'),
(238,'woocommerce_cart_page_id','6','off'),
(239,'woocommerce_checkout_page_id','7','off'),
(240,'woocommerce_myaccount_page_id','8','off'),
(241,'woocommerce_terms_page_id','','off'),
(242,'woocommerce_force_ssl_checkout','no','on'),
(243,'woocommerce_unforce_ssl_checkout','no','on'),
(244,'woocommerce_checkout_pay_endpoint','order-pay','on'),
(245,'woocommerce_checkout_order_received_endpoint','order-received','on'),
(246,'woocommerce_myaccount_add_payment_method_endpoint','add-payment-method','on'),
(247,'woocommerce_myaccount_delete_payment_method_endpoint','delete-payment-method','on'),
(248,'woocommerce_myaccount_set_default_payment_method_endpoint','set-default-payment-method','on'),
(249,'woocommerce_myaccount_orders_endpoint','orders','on'),
(250,'woocommerce_myaccount_view_order_endpoint','view-order','on'),
(251,'woocommerce_myaccount_downloads_endpoint','downloads','on'),
(252,'woocommerce_myaccount_edit_account_endpoint','edit-account','on'),
(253,'woocommerce_myaccount_edit_address_endpoint','edit-address','on'),
(254,'woocommerce_myaccount_payment_methods_endpoint','payment-methods','on'),
(255,'woocommerce_myaccount_lost_password_endpoint','lost-password','on'),
(256,'woocommerce_logout_endpoint','customer-logout','on'),
(257,'woocommerce_api_enabled','no','on'),
(258,'woocommerce_allow_tracking','no','on'),
(259,'woocommerce_show_marketplace_suggestions','yes','off'),
(260,'woocommerce_custom_orders_table_enabled','yes','on'),
(261,'woocommerce_analytics_enabled','yes','on'),
(262,'woocommerce_feature_rate_limit_checkout_enabled','no','on'),
(263,'woocommerce_feature_order_attribution_enabled','yes','on'),
(264,'woocommerce_feature_site_visibility_badge_enabled','yes','on'),
(265,'woocommerce_hpos_datastore_caching_enabled','no','on'),
(266,'woocommerce_feature_remote_logging_enabled','yes','on'),
(267,'woocommerce_feature_email_improvements_enabled','no','on'),
(268,'_transient_timeout_wc_settings_email_improvements_reverted','1772738286','off'),
(269,'_transient_wc_settings_email_improvements_reverted','yes','off'),
(270,'woocommerce_email_improvements_disabled_count','1','auto'),
(271,'woocommerce_email_improvements_first_disabled_at','2026-03-05 19:17:51','auto'),
(272,'woocommerce_email_improvements_last_disabled_at','2026-03-05 19:17:51','auto'),
(273,'woocommerce_feature_blueprint_enabled','yes','on'),
(274,'woocommerce_feature_cost_of_goods_sold_enabled','no','on'),
(275,'woocommerce_hpos_fts_index_enabled','no','on'),
(276,'woocommerce_feature_block_email_editor_enabled','no','on'),
(277,'woocommerce_feature_point_of_sale_enabled','yes','on'),
(278,'woocommerce_feature_mcp_integration_enabled','no','on'),
(279,'woocommerce_feature_destroy-empty-sessions_enabled','no','on'),
(280,'woocommerce_feature_rest_api_caching_enabled','no','on'),
(281,'woocommerce_feature_product_instance_caching_enabled','no','on'),
(282,'woocommerce_single_image_width','600','on'),
(283,'woocommerce_thumbnail_image_width','300','on'),
(284,'woocommerce_checkout_highlight_required_fields','yes','on'),
(285,'woocommerce_demo_store','no','off'),
(286,'wc_downloads_approved_directories_mode','enabled','auto'),
(287,'woocommerce_permalinks','a:5:{s:12:\"product_base\";s:7:\"product\";s:13:\"category_base\";s:16:\"product-category\";s:8:\"tag_base\";s:11:\"product-tag\";s:14:\"attribute_base\";s:0:\"\";s:22:\"use_verbose_page_rules\";b:0;}','auto'),
(288,'current_theme_supports_woocommerce','yes','auto'),
(289,'woocommerce_queue_flush_rewrite_rules','no','auto'),
(290,'_transient_wc_attribute_taxonomies','a:0:{}','on'),
(293,'product_cat_children','a:0:{}','auto'),
(294,'default_product_cat','15','auto'),
(295,'woocommerce_refund_returns_page_id','9','auto'),
(296,'_transient_timeout__wc_activation_redirect','1772738301','off'),
(297,'_transient__wc_activation_redirect','1','off'),
(298,'woocommerce_paypal_settings','a:25:{s:7:\"enabled\";s:2:\"no\";s:5:\"title\";s:6:\"PayPal\";s:11:\"description\";s:85:\"Pay via PayPal; you can pay with your credit card if you don\'t have a PayPal account.\";s:5:\"email\";s:17:\"admin@example.com\";s:8:\"advanced\";s:0:\"\";s:8:\"testmode\";s:2:\"no\";s:13:\"paymentaction\";s:4:\"sale\";s:14:\"paypal_buttons\";s:3:\"yes\";s:14:\"invoice_prefix\";s:3:\"WC-\";s:13:\"send_shipping\";s:3:\"yes\";s:16:\"address_override\";s:2:\"no\";s:5:\"debug\";s:2:\"no\";s:9:\"image_url\";s:0:\"\";s:16:\"ipn_notification\";s:3:\"yes\";s:14:\"receiver_email\";s:17:\"admin@example.com\";s:14:\"identity_token\";s:0:\"\";s:11:\"api_details\";s:0:\"\";s:12:\"api_username\";s:0:\"\";s:12:\"api_password\";s:0:\"\";s:13:\"api_signature\";s:0:\"\";s:20:\"sandbox_api_username\";s:0:\"\";s:20:\"sandbox_api_password\";s:0:\"\";s:21:\"sandbox_api_signature\";s:0:\"\";s:28:\"transact_onboarding_complete\";s:2:\"no\";s:12:\"_should_load\";s:2:\"no\";}','on'),
(299,'woocommerce_version','10.5.3','auto'),
(300,'woocommerce_db_version','10.5.3','auto'),
(301,'woocommerce_store_id','c9bddb96-1c61-456f-a658-725a210b1078','auto'),
(302,'woocommerce_admin_install_timestamp','1772738271','auto'),
(303,'woocommerce_inbox_variant_assignment','9','auto'),
(304,'woocommerce_remote_variant_assignment','105','auto'),
(305,'woocommerce_attribute_lookup_enabled','no','auto'),
(307,'_transient_timeout__woocommerce_upload_directory_status','1772824671','off'),
(308,'_transient__woocommerce_upload_directory_status','protected','off'),
(309,'_transient_woocommerce_activated_plugin','woocommerce/woocommerce.php','on'),
(310,'_transient_jetpack_autoloader_plugin_paths','a:1:{i:0;s:29:\"{{WP_PLUGIN_DIR}}/woocommerce\";}','on'),
(311,'woocommerce_admin_notices','a:2:{i:0;s:20:\"no_secure_connection\";i:1;s:14:\"template_files\";}','auto'),
(312,'woocommerce_maxmind_geolocation_settings','a:1:{s:15:\"database_prefix\";s:32:\"HAWF5VlUe7hEAPfbbkCNq9yUcyFiiF9v\";}','on'),
(313,'_transient_woocommerce_webhook_ids_status_active','a:0:{}','on'),
(314,'widget_woocommerce_widget_cart','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(315,'widget_woocommerce_layered_nav_filters','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(316,'widget_woocommerce_layered_nav','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(317,'widget_woocommerce_price_filter','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(318,'widget_woocommerce_product_categories','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(319,'widget_woocommerce_product_search','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(320,'widget_woocommerce_product_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(321,'widget_woocommerce_products','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(322,'widget_woocommerce_recently_viewed_products','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(323,'widget_woocommerce_top_rated_products','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(324,'widget_woocommerce_recent_reviews','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(325,'widget_woocommerce_rating_filter','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(326,'widget_wc_brands_brand_description','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(327,'widget_woocommerce_brand_nav','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(328,'widget_wc_brands_brand_thumbnails','a:1:{s:12:\"_multiwidget\";i:1;}','auto'),
(329,'_site_transient_timeout_woocommerce_blocks_patterns','1775330272','off'),
(330,'_site_transient_woocommerce_blocks_patterns','a:2:{s:7:\"version\";s:6:\"10.5.3\";s:8:\"patterns\";a:41:{i:0;a:11:{s:5:\"title\";s:6:\"Banner\";s:4:\"slug\";s:25:\"woocommerce-blocks/banner\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:10:\"banner.php\";}i:1;a:11:{s:5:\"title\";s:23:\"Coming Soon Entire Site\";s:4:\"slug\";s:35:\"woocommerce/coming-soon-entire-site\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:17:\"launch-your-store\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:27:\"coming-soon-entire-site.php\";}i:2;a:11:{s:5:\"title\";s:22:\"Coming Soon Store Only\";s:4:\"slug\";s:34:\"woocommerce/coming-soon-store-only\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:17:\"launch-your-store\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:26:\"coming-soon-store-only.php\";}i:3;a:11:{s:5:\"title\";s:11:\"Coming Soon\";s:4:\"slug\";s:23:\"woocommerce/coming-soon\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:17:\"launch-your-store\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:15:\"coming-soon.php\";}i:4;a:11:{s:5:\"title\";s:29:\"Content right with image left\";s:4:\"slug\";s:48:\"woocommerce-blocks/content-right-with-image-left\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:18:\"WooCommerce, About\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:28:\"content-right-image-left.php\";}i:5;a:11:{s:5:\"title\";s:29:\"Featured Category Cover Image\";s:4:\"slug\";s:48:\"woocommerce-blocks/featured-category-cover-image\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:18:\"WooCommerce, Intro\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:33:\"featured-category-cover-image.php\";}i:6;a:11:{s:5:\"title\";s:24:\"Featured Category Triple\";s:4:\"slug\";s:43:\"woocommerce-blocks/featured-category-triple\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:28:\"featured-category-triple.php\";}i:7;a:11:{s:5:\"title\";s:12:\"Large Footer\";s:4:\"slug\";s:31:\"woocommerce-blocks/footer-large\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/footer\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:16:\"footer-large.php\";}i:8;a:11:{s:5:\"title\";s:23:\"Footer with Simple Menu\";s:4:\"slug\";s:37:\"woocommerce-blocks/footer-simple-menu\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/footer\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:22:\"footer-simple-menu.php\";}i:9;a:11:{s:5:\"title\";s:17:\"Footer with menus\";s:4:\"slug\";s:38:\"woocommerce-blocks/footer-with-3-menus\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/footer\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:23:\"footer-with-3-menus.php\";}i:10;a:11:{s:5:\"title\";s:28:\"Four Image Grid Content Left\";s:4:\"slug\";s:47:\"woocommerce-blocks/form-image-grid-content-left\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:18:\"WooCommerce, About\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:32:\"four-image-grid-content-left.php\";}i:11;a:11:{s:5:\"title\";s:20:\"Centered Header Menu\";s:4:\"slug\";s:39:\"woocommerce-blocks/header-centered-menu\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/header\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:27:\"header-centered-pattern.php\";}i:12;a:11:{s:5:\"title\";s:23:\"Distraction Free Header\";s:4:\"slug\";s:42:\"woocommerce-blocks/header-distraction-free\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/header\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:27:\"header-distraction-free.php\";}i:13;a:11:{s:5:\"title\";s:16:\"Essential Header\";s:4:\"slug\";s:35:\"woocommerce-blocks/header-essential\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/header\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:20:\"header-essential.php\";}i:14;a:11:{s:5:\"title\";s:12:\"Large Header\";s:4:\"slug\";s:31:\"woocommerce-blocks/header-large\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/header\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:16:\"header-large.php\";}i:15;a:11:{s:5:\"title\";s:14:\"Minimal Header\";s:4:\"slug\";s:33:\"woocommerce-blocks/header-minimal\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:25:\"core/template-part/header\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:18:\"header-minimal.php\";}i:16;a:11:{s:5:\"title\";s:47:\"Heading with three columns of content with link\";s:4:\"slug\";s:66:\"woocommerce-blocks/heading-with-three-columns-of-content-with-link\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:21:\"WooCommerce, Services\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:51:\"heading-with-three-columns-of-content-with-link.php\";}i:17;a:11:{s:5:\"title\";s:20:\"Hero Product 3 Split\";s:4:\"slug\";s:39:\"woocommerce-blocks/hero-product-3-split\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:24:\"hero-product-3-split.php\";}i:18;a:11:{s:5:\"title\";s:23:\"Hero Product Chessboard\";s:4:\"slug\";s:42:\"woocommerce-blocks/hero-product-chessboard\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:27:\"hero-product-chessboard.php\";}i:19;a:11:{s:5:\"title\";s:18:\"Hero Product Split\";s:4:\"slug\";s:37:\"woocommerce-blocks/hero-product-split\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:18:\"WooCommerce, Intro\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:22:\"hero-product-split.php\";}i:20;a:11:{s:5:\"title\";s:33:\"Centered content with image below\";s:4:\"slug\";s:52:\"woocommerce-blocks/centered-content-with-image-below\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:18:\"WooCommerce, Intro\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:43:\"intro-centered-content-with-image-below.php\";}i:21;a:11:{s:5:\"title\";s:22:\"Just Arrived Full Hero\";s:4:\"slug\";s:41:\"woocommerce-blocks/just-arrived-full-hero\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:18:\"WooCommerce, Intro\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:26:\"just-arrived-full-hero.php\";}i:22;a:11:{s:5:\"title\";s:33:\"No Products Found - Clear Filters\";s:4:\"slug\";s:43:\"woocommerce/no-products-found-clear-filters\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:2:\"no\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:29:\"no-products-found-filters.php\";}i:23;a:11:{s:5:\"title\";s:17:\"No Products Found\";s:4:\"slug\";s:29:\"woocommerce/no-products-found\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:2:\"no\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:21:\"no-products-found.php\";}i:24;a:11:{s:5:\"title\";s:19:\"Default Coming Soon\";s:4:\"slug\";s:36:\"woocommerce/page-coming-soon-default\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:11:\"coming-soon\";s:6:\"source\";s:28:\"page-coming-soon-default.php\";}i:25;a:11:{s:5:\"title\";s:25:\"Coming Soon Image Gallery\";s:4:\"slug\";s:42:\"woocommerce/page-coming-soon-image-gallery\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:11:\"coming-soon\";s:6:\"source\";s:34:\"page-coming-soon-image-gallery.php\";}i:26;a:11:{s:5:\"title\";s:30:\"Coming Soon Minimal Left Image\";s:4:\"slug\";s:47:\"woocommerce/page-coming-soon-minimal-left-image\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:11:\"coming-soon\";s:6:\"source\";s:39:\"page-coming-soon-minimal-left-image.php\";}i:27;a:11:{s:5:\"title\";s:24:\"Coming Soon Modern Black\";s:4:\"slug\";s:41:\"woocommerce/page-coming-soon-modern-black\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:11:\"coming-soon\";s:6:\"source\";s:33:\"page-coming-soon-modern-black.php\";}i:28;a:11:{s:5:\"title\";s:29:\"Coming Soon Split Right Image\";s:4:\"slug\";s:46:\"woocommerce/page-coming-soon-split-right-image\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:11:\"coming-soon\";s:6:\"source\";s:38:\"page-coming-soon-split-right-image.php\";}i:29;a:11:{s:5:\"title\";s:34:\"Coming Soon With Header and Footer\";s:4:\"slug\";s:47:\"woocommerce/page-coming-soon-with-header-footer\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:11:\"coming-soon\";s:6:\"source\";s:39:\"page-coming-soon-with-header-footer.php\";}i:30;a:11:{s:5:\"title\";s:28:\"Product Collection 3 Columns\";s:4:\"slug\";s:47:\"woocommerce-blocks/product-collection-3-columns\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:32:\"product-collection-3-columns.php\";}i:31;a:11:{s:5:\"title\";s:28:\"Product Collection 4 Columns\";s:4:\"slug\";s:47:\"woocommerce-blocks/product-collection-4-columns\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:32:\"product-collection-4-columns.php\";}i:32;a:11:{s:5:\"title\";s:28:\"Product Collection 5 Columns\";s:4:\"slug\";s:47:\"woocommerce-blocks/product-collection-5-columns\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:32:\"product-collection-5-columns.php\";}i:33;a:11:{s:5:\"title\";s:47:\"Product Collection: Featured Products 5 Columns\";s:4:\"slug\";s:65:\"woocommerce-blocks/product-collection-featured-products-5-columns\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:50:\"product-collection-featured-products-5-columns.php\";}i:34;a:11:{s:5:\"title\";s:15:\"Product Gallery\";s:4:\"slug\";s:48:\"woocommerce-blocks/product-query-product-gallery\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:29:\"WooCommerce, featured-selling\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:36:\"core/query/woocommerce/product-query\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:33:\"product-query-product-gallery.php\";}i:35;a:11:{s:5:\"title\";s:14:\"Product Search\";s:4:\"slug\";s:31:\"woocommerce/product-search-form\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:2:\"no\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:23:\"product-search-form.php\";}i:36;a:11:{s:5:\"title\";s:16:\"Related Products\";s:4:\"slug\";s:35:\"woocommerce-blocks/related-products\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:11:\"WooCommerce\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:5:\"false\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:20:\"related-products.php\";}i:37;a:11:{s:5:\"title\";s:33:\"Social: Follow us on social media\";s:4:\"slug\";s:51:\"woocommerce-blocks/social-follow-us-in-social-media\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:25:\"WooCommerce, social-media\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:36:\"social-follow-us-in-social-media.php\";}i:38;a:11:{s:5:\"title\";s:22:\"Testimonials 3 Columns\";s:4:\"slug\";s:41:\"woocommerce-blocks/testimonials-3-columns\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:20:\"WooCommerce, Reviews\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:26:\"testimonials-3-columns.php\";}i:39;a:11:{s:5:\"title\";s:19:\"Testimonials Single\";s:4:\"slug\";s:38:\"woocommerce-blocks/testimonials-single\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:20:\"WooCommerce, Reviews\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:23:\"testimonials-single.php\";}i:40;a:11:{s:5:\"title\";s:37:\"Three columns with images and content\";s:4:\"slug\";s:56:\"woocommerce-blocks/three-columns-with-images-and-content\";s:11:\"description\";s:0:\"\";s:13:\"viewportWidth\";s:0:\"\";s:10:\"categories\";s:21:\"WooCommerce, Services\";s:8:\"keywords\";s:0:\"\";s:10:\"blockTypes\";s:0:\"\";s:8:\"inserter\";s:0:\"\";s:11:\"featureFlag\";s:0:\"\";s:13:\"templateTypes\";s:0:\"\";s:6:\"source\";s:41:\"three-columns-with-images-and-content.php\";}}}','off'),
(332,'jetpack_options','a:1:{s:14:\"last_heartbeat\";i:1772738272;}','auto'),
(333,'_transient_timeout_woocommerce_blocks_asset_api_script_data','1775330273','off'),
(334,'_transient_woocommerce_blocks_asset_api_script_data','{\"script_data\":{\"assets\\/client\\/blocks\\/wc-settings.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-settings.js\",\"version\":\"508473c3c2ece9af8f8f\",\"dependencies\":[\"wc-types\",\"wp-hooks\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-types.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-types.js\",\"version\":\"f0cc692c0367e0930c80\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-entities.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-entities.js\",\"version\":\"cdb01de69fb7dbbbb30f\",\"dependencies\":[\"wc-settings\",\"wp-core-data\",\"wp-data\",\"wp-i18n\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-middleware.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-middleware.js\",\"version\":\"d79dedade2f2e4dc9df4\",\"dependencies\":[\"wp-api-fetch\",\"wp-polyfill\",\"wp-url\"]},\"assets\\/client\\/blocks\\/wc-blocks-data.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-data.js\",\"version\":\"cb3e0de73209d78c5dc0\",\"dependencies\":[\"wc-blocks-checkout-events\",\"wc-blocks-registry\",\"wc-settings\",\"wc-types\",\"wp-api-fetch\",\"wp-data\",\"wp-data-controls\",\"wp-deprecated\",\"wp-dom\",\"wp-element\",\"wp-hooks\",\"wp-html-entities\",\"wp-i18n\",\"wp-is-shallow-equal\",\"wp-notices\",\"wp-polyfill\",\"wp-url\"]},\"assets\\/client\\/blocks\\/wc-blocks-vendors.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-vendors.js\",\"version\":\"1155eafae09ee832d59f\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-registry.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-registry.js\",\"version\":\"a16aa912ffa0a15063f1\",\"dependencies\":[\"react-jsx-runtime\",\"wc-settings\",\"wp-data\",\"wp-deprecated\",\"wp-element\",\"wp-hooks\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks.js\",\"version\":\"0db759a8a6e010732c50\",\"dependencies\":[\"react-jsx-runtime\",\"wp-blocks\",\"wp-compose\",\"wp-element\",\"wp-hooks\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-shared-context.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-shared-context.js\",\"version\":\"621353d8a3a7c8d44b41\",\"dependencies\":[\"react-jsx-runtime\",\"wp-element\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-shared-hocs.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-shared-hocs.js\",\"version\":\"c18bbb2325f333897e6b\",\"dependencies\":[\"react-jsx-runtime\",\"wc-blocks-data-store\",\"wc-blocks-shared-context\",\"wc-types\",\"wp-data\",\"wp-element\",\"wp-is-shallow-equal\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/price-format.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/price-format.js\",\"version\":\"0df720e448f7ab3c5d0d\",\"dependencies\":[\"wc-settings\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-blocks-frontend-vendors-frontend.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-blocks-frontend-vendors-frontend.js\",\"version\":\"00b931bcc27024fa60ca\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-cart-checkout-vendors-frontend.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-cart-checkout-vendors-frontend.js\",\"version\":\"bcad3fab21852551edee\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/wc-cart-checkout-base-frontend.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-cart-checkout-base-frontend.js\",\"version\":\"7a3e5664185d4651f7f9\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/blocks-checkout.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/blocks-checkout.js\",\"version\":\"fd501851f2904ac6131a\",\"dependencies\":[\"wc-cart-checkout-base\",\"wc-cart-checkout-vendors\",\"react\",\"react-dom\",\"react-jsx-runtime\",\"wc-blocks-components\",\"wc-blocks-data-store\",\"wc-blocks-registry\",\"wc-sanitize\",\"wc-settings\",\"wc-types\",\"wp-a11y\",\"wp-compose\",\"wp-data\",\"wp-deprecated\",\"wp-element\",\"wp-html-entities\",\"wp-i18n\",\"wp-is-shallow-equal\",\"wp-notices\",\"wp-polyfill\",\"wp-primitives\",\"wp-warning\"]},\"assets\\/client\\/blocks\\/blocks-checkout-events.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/blocks-checkout-events.js\",\"version\":\"2d0fd4590f6cc663947c\",\"dependencies\":[\"wc-types\",\"wp-polyfill\"]},\"assets\\/client\\/blocks\\/blocks-components.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/blocks-components.js\",\"version\":\"8b64025baef8d338aa5e\",\"dependencies\":[\"wc-cart-checkout-base\",\"wc-cart-checkout-vendors\",\"react\",\"react-dom\",\"react-jsx-runtime\",\"wc-blocks-data-store\",\"wc-sanitize\",\"wc-settings\",\"wc-types\",\"wp-a11y\",\"wp-compose\",\"wp-data\",\"wp-deprecated\",\"wp-element\",\"wp-html-entities\",\"wp-i18n\",\"wp-notices\",\"wp-polyfill\",\"wp-primitives\"]},\"assets\\/client\\/blocks\\/wc-schema-parser.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/blocks\\/wc-schema-parser.js\",\"version\":\"f762078aeb4207fe9c3d\",\"dependencies\":[\"wp-polyfill\"]},\"assets\\/client\\/admin\\/sanitize\\/index.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/admin\\/sanitize\\/index.js\",\"version\":\"c7a741f8dc5bec166999\",\"dependencies\":[]},\"assets\\/client\\/admin\\/customer-effort-score\\/index.js\":{\"src\":\"http:\\/\\/wordpress\\/wp-content\\/plugins\\/woocommerce\\/assets\\/client\\/admin\\/customer-effort-score\\/index.js\",\"version\":\"ebdc0b2d7487174621e6\",\"dependencies\":[\"react\",\"wc-experimental\",\"wc-navigation\",\"wc-store-data\",\"wc-tracks\",\"wp-api-fetch\",\"wp-components\",\"wp-compose\",\"wp-data\",\"wp-data-controls\",\"wp-element\",\"wp-i18n\"]}},\"version\":\"wc-10.5.3\",\"hash\":\"f47c0ce9a551bc7dad79dca7c575ee62\"}','off'),
(335,'woocommerce_checkout_phone_field','optional','auto'),
(336,'woocommerce_checkout_company_field','hidden','auto'),
(337,'woocommerce_checkout_address_2_field','optional','auto'),
(338,'woocommerce_custom_orders_table_created','yes','auto'),
(341,'_transient_product_query-transient-version','1772738288','on'),
(344,'_transient_product-transient-version','1772738288','on'),
(345,'_transient_woocommerce_product_task_has_product_transient','yes','on'),
(346,'woocommerce_task_list_tracked_completed_tasks','a:1:{i:0;s:8:\"products\";}','auto'),
(347,'_transient_timeout_wc_related_10','1772824711','off'),
(348,'_transient_wc_related_10','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=10\";a:8:{i:0;s:2:\"11\";i:1;s:2:\"12\";i:2;s:2:\"13\";i:3;s:2:\"14\";i:4;s:2:\"15\";i:5;s:2:\"16\";i:6;s:2:\"17\";i:7;s:2:\"18\";}}','off'),
(351,'_transient_timeout_wc_related_11','1772824711','off'),
(352,'_transient_wc_related_11','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=11\";a:8:{i:0;s:2:\"10\";i:1;s:2:\"12\";i:2;s:2:\"13\";i:3;s:2:\"14\";i:4;s:2:\"15\";i:5;s:2:\"16\";i:6;s:2:\"17\";i:7;s:2:\"18\";}}','off'),
(355,'_transient_timeout_wc_related_12','1772824711','off'),
(356,'_transient_wc_related_12','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=12\";a:8:{i:0;s:2:\"10\";i:1;s:2:\"11\";i:2;s:2:\"13\";i:3;s:2:\"14\";i:4;s:2:\"15\";i:5;s:2:\"16\";i:6;s:2:\"17\";i:7;s:2:\"18\";}}','off'),
(359,'_transient_timeout_wc_related_13','1772824711','off'),
(360,'_transient_wc_related_13','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=13\";a:8:{i:0;s:2:\"10\";i:1;s:2:\"11\";i:2;s:2:\"12\";i:3;s:2:\"14\";i:4;s:2:\"15\";i:5;s:2:\"16\";i:6;s:2:\"17\";i:7;s:2:\"18\";}}','off'),
(363,'_transient_timeout_wc_related_14','1772824711','off'),
(364,'_transient_wc_related_14','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=14\";a:8:{i:0;s:2:\"10\";i:1;s:2:\"11\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"15\";i:5;s:2:\"16\";i:6;s:2:\"17\";i:7;s:2:\"18\";}}','off'),
(367,'_transient_timeout_wc_related_15','1772824686','off'),
(368,'_transient_wc_related_15','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=15\";a:5:{i:0;s:2:\"10\";i:1;s:2:\"11\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";}}','off'),
(371,'_transient_timeout_wc_related_16','1772824686','off'),
(372,'_transient_wc_related_16','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=16\";a:6:{i:0;s:2:\"10\";i:1;s:2:\"11\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";i:5;s:2:\"15\";}}','off'),
(375,'_transient_timeout_wc_related_17','1772824687','off'),
(376,'_transient_wc_related_17','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=17\";a:7:{i:0;s:2:\"10\";i:1;s:2:\"11\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";i:5;s:2:\"15\";i:6;s:2:\"16\";}}','off'),
(377,'_transient_timeout_wc_term_counts','1775330288','off'),
(378,'_transient_wc_term_counts','a:1:{s:14:\"15_product_cat\";i:9;}','off'),
(379,'_transient_timeout_wc_related_18','1772824688','off'),
(380,'_transient_wc_related_18','a:1:{s:50:\"limit=5&exclude_ids%5B0%5D=0&exclude_ids%5B1%5D=18\";a:8:{i:0;s:2:\"10\";i:1;s:2:\"11\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";i:5;s:2:\"15\";i:6;s:2:\"16\";i:7;s:2:\"17\";}}','off');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_postmeta` VALUES
(1,2,'_wp_page_template','default'),
(2,3,'_wp_page_template','default'),
(3,10,'_sku','EXT-001'),
(4,10,'_regular_price','129.00'),
(5,10,'total_sales','0'),
(6,10,'_tax_status','taxable'),
(7,10,'_tax_class',''),
(8,10,'_manage_stock','no'),
(9,10,'_backorders','no'),
(10,10,'_sold_individually','no'),
(11,10,'_virtual','no'),
(12,10,'_downloadable','no'),
(13,10,'_download_limit','-1'),
(14,10,'_download_expiry','-1'),
(15,10,'_stock',NULL),
(16,10,'_stock_status','instock'),
(17,10,'_wc_average_rating','0'),
(18,10,'_wc_review_count','0'),
(19,10,'_product_version','10.5.3'),
(20,10,'_price','129.00'),
(21,11,'_sku','EXT-002'),
(22,11,'_regular_price','180.00'),
(23,11,'total_sales','0'),
(24,11,'_tax_status','taxable'),
(25,11,'_tax_class',''),
(26,11,'_manage_stock','no'),
(27,11,'_backorders','no'),
(28,11,'_sold_individually','no'),
(29,11,'_virtual','no'),
(30,11,'_downloadable','no'),
(31,11,'_download_limit','-1'),
(32,11,'_download_expiry','-1'),
(33,11,'_stock',NULL),
(34,11,'_stock_status','instock'),
(35,11,'_wc_average_rating','0'),
(36,11,'_wc_review_count','0'),
(37,11,'_product_version','10.5.3'),
(38,11,'_price','180.00'),
(39,12,'_sku','EXT-003'),
(40,12,'_regular_price','159.00'),
(41,12,'total_sales','0'),
(42,12,'_tax_status','taxable'),
(43,12,'_tax_class',''),
(44,12,'_manage_stock','no'),
(45,12,'_backorders','no'),
(46,12,'_sold_individually','no'),
(47,12,'_virtual','no'),
(48,12,'_downloadable','no'),
(49,12,'_download_limit','-1'),
(50,12,'_download_expiry','-1'),
(51,12,'_stock',NULL),
(52,12,'_stock_status','instock'),
(53,12,'_wc_average_rating','0'),
(54,12,'_wc_review_count','0'),
(55,12,'_product_version','10.5.3'),
(56,12,'_price','159.00'),
(57,13,'_sku','EXT-004'),
(58,13,'_regular_price','149.00'),
(59,13,'total_sales','0'),
(60,13,'_tax_status','taxable'),
(61,13,'_tax_class',''),
(62,13,'_manage_stock','no'),
(63,13,'_backorders','no'),
(64,13,'_sold_individually','no'),
(65,13,'_virtual','no'),
(66,13,'_downloadable','no'),
(67,13,'_download_limit','-1'),
(68,13,'_download_expiry','-1'),
(69,13,'_stock',NULL),
(70,13,'_stock_status','instock'),
(71,13,'_wc_average_rating','0'),
(72,13,'_wc_review_count','0'),
(73,13,'_product_version','10.5.3'),
(74,13,'_price','149.00'),
(75,14,'_sku','EXT-005'),
(76,14,'_regular_price','139.00'),
(77,14,'total_sales','0'),
(78,14,'_tax_status','taxable'),
(79,14,'_tax_class',''),
(80,14,'_manage_stock','no'),
(81,14,'_backorders','no'),
(82,14,'_sold_individually','no'),
(83,14,'_virtual','no'),
(84,14,'_downloadable','no'),
(85,14,'_download_limit','-1'),
(86,14,'_download_expiry','-1'),
(87,14,'_stock',NULL),
(88,14,'_stock_status','instock'),
(89,14,'_wc_average_rating','0'),
(90,14,'_wc_review_count','0'),
(91,14,'_product_version','10.5.3'),
(92,14,'_price','139.00'),
(93,15,'_sku','FORM-001'),
(94,15,'_regular_price','1500.00'),
(95,15,'total_sales','0'),
(96,15,'_tax_status','taxable'),
(97,15,'_tax_class',''),
(98,15,'_manage_stock','no'),
(99,15,'_backorders','no'),
(100,15,'_sold_individually','no'),
(101,15,'_virtual','no'),
(102,15,'_downloadable','no'),
(103,15,'_download_limit','-1'),
(104,15,'_download_expiry','-1'),
(105,15,'_stock',NULL),
(106,15,'_stock_status','instock'),
(107,15,'_wc_average_rating','0'),
(108,15,'_wc_review_count','0'),
(109,15,'_product_version','10.5.3'),
(110,15,'_price','1500.00'),
(111,16,'_sku','FORM-002'),
(112,16,'_regular_price','2200.00'),
(113,16,'total_sales','0'),
(114,16,'_tax_status','taxable'),
(115,16,'_tax_class',''),
(116,16,'_manage_stock','no'),
(117,16,'_backorders','no'),
(118,16,'_sold_individually','no'),
(119,16,'_virtual','no'),
(120,16,'_downloadable','no'),
(121,16,'_download_limit','-1'),
(122,16,'_download_expiry','-1'),
(123,16,'_stock',NULL),
(124,16,'_stock_status','instock'),
(125,16,'_wc_average_rating','0'),
(126,16,'_wc_review_count','0'),
(127,16,'_product_version','10.5.3'),
(128,16,'_price','2200.00'),
(129,17,'_sku','FORM-003'),
(130,17,'_regular_price','3500.00'),
(131,17,'total_sales','0'),
(132,17,'_tax_status','taxable'),
(133,17,'_tax_class',''),
(134,17,'_manage_stock','no'),
(135,17,'_backorders','no'),
(136,17,'_sold_individually','no'),
(137,17,'_virtual','no'),
(138,17,'_downloadable','no'),
(139,17,'_download_limit','-1'),
(140,17,'_download_expiry','-1'),
(141,17,'_stock',NULL),
(142,17,'_stock_status','instock'),
(143,17,'_wc_average_rating','0'),
(144,17,'_wc_review_count','0'),
(145,17,'_product_version','10.5.3'),
(146,17,'_price','3500.00'),
(147,18,'_sku','FREE-001'),
(148,18,'_regular_price','0.00'),
(149,18,'total_sales','0'),
(150,18,'_tax_status','taxable'),
(151,18,'_tax_class',''),
(152,18,'_manage_stock','no'),
(153,18,'_backorders','no'),
(154,18,'_sold_individually','no'),
(155,18,'_virtual','no'),
(156,18,'_downloadable','no'),
(157,18,'_download_limit','-1'),
(158,18,'_download_expiry','-1'),
(159,18,'_stock',NULL),
(160,18,'_stock_status','instock'),
(161,18,'_wc_average_rating','0'),
(162,18,'_wc_review_count','0'),
(163,18,'_product_version','10.5.3'),
(164,18,'_price','0.00');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_posts` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_posts` VALUES
(1,1,'2026-03-05 19:17:48','2026-03-05 19:17:48','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','publish','open','open','','hello-world','','','2026-03-05 19:17:48','2026-03-05 19:17:48','',0,'http://wordpress/?p=1',0,'post','',1),
(2,1,'2026-03-05 19:17:48','2026-03-05 19:17:48','<!-- wp:paragraph -->\n<p>This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...or something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>As a new WordPress user, you should go to <a href=\"http://wordpress/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\n<!-- /wp:paragraph -->','Sample Page','','publish','closed','open','','sample-page','','','2026-03-05 19:17:48','2026-03-05 19:17:48','',0,'http://wordpress/?page_id=2',0,'page','',0),
(3,1,'2026-03-05 19:17:48','2026-03-05 19:17:48','<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we are</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Our website address is: http://wordpress.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Comments</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Media</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Cookies</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Embedded content from other websites</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we share your data with</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you request a password reset, your IP address will be included in the reset email.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">How long we retain your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">What rights you have over your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Where your data is sent</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Visitor comments may be checked through an automated spam detection service.</p>\n<!-- /wp:paragraph -->\n','Privacy Policy','','draft','closed','open','','privacy-policy','','','2026-03-05 19:17:48','2026-03-05 19:17:48','',0,'http://wordpress/?page_id=3',0,'page','',0),
(4,0,'2026-03-05 19:17:48','2026-03-05 19:17:48','<!-- wp:page-list /-->','Navigation','','publish','closed','closed','','navigation','','','2026-03-05 19:17:48','2026-03-05 19:17:48','',0,'http://wordpress/2026/03/05/navigation/',0,'wp_navigation','',0),
(5,1,'2026-03-05 19:17:51','2026-03-05 19:17:51','','Shop','','publish','closed','closed','','shop','','','2026-03-05 19:17:51','2026-03-05 19:17:51','',0,'http://wordpress/shop/',0,'page','',0),
(6,1,'2026-03-05 19:17:51','2026-03-05 19:17:51','<!-- wp:woocommerce/cart -->\n<div class=\"wp-block-woocommerce-cart alignwide is-loading\"><!-- wp:woocommerce/filled-cart-block -->\n<div class=\"wp-block-woocommerce-filled-cart-block\"><!-- wp:woocommerce/cart-items-block -->\n<div class=\"wp-block-woocommerce-cart-items-block\"><!-- wp:woocommerce/cart-line-items-block -->\n<div class=\"wp-block-woocommerce-cart-line-items-block\"></div>\n<!-- /wp:woocommerce/cart-line-items-block -->\n\n<!-- wp:woocommerce/product-collection {\"queryId\":0,\"query\":{\"perPage\":3,\"pages\":1,\"offset\":0,\"postType\":\"product\",\"order\":\"asc\",\"orderBy\":\"title\",\"search\":\"\",\"exclude\":[],\"inherit\":false,\"taxQuery\":{},\"isProductCollectionBlock\":true,\"featured\":false,\"woocommerceOnSale\":false,\"woocommerceStockStatus\":[\"instock\",\"outofstock\",\"onbackorder\"],\"woocommerceAttributes\":[],\"woocommerceHandPickedProducts\":[],\"filterable\":false,\"relatedBy\":{\"categories\":true,\"tags\":true}},\"tagName\":\"div\",\"displayLayout\":{\"type\":\"flex\",\"columns\":3,\"shrinkColumns\":true},\"dimensions\":{\"widthType\":\"fill\"},\"collection\":\"woocommerce/product-collection/cross-sells\",\"hideControls\":[\"filterable\"],\"queryContextIncludes\":[\"collection\"],\"__privatePreviewState\":{\"isPreview\":true,\"previewMessage\":\"Actual products will vary depending on the page being viewed.\"}} -->\n<div class=\"wp-block-woocommerce-product-collection\"><!-- wp:heading {\"textAlign\":\"left\",\"style\":{\"spacing\":{\"margin\":{\"bottom\":\"1rem\"}}}} -->\n<h2 class=\"wp-block-heading has-text-align-left\" style=\"margin-bottom:1rem\">You may be interested in&hellip;</h2>\n\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-template -->\n<!-- wp:woocommerce/product-image {\"showSaleBadge\":false,\"imageSizing\":\"thumbnail\",\"isDescendentOfQueryLoop\":true} -->\n<!-- wp:woocommerce/product-sale-badge {\"align\":\"right\"} /-->\n<!-- /wp:woocommerce/product-image -->\n\n<!-- wp:post-title {\"textAlign\":\"center\",\"isLink\":true,\"style\":{\"spacing\":{\"margin\":{\"bottom\":\"0.75rem\",\"top\":\"0\"}},\"typography\":{\"lineHeight\":\"1.4\"}},\"fontSize\":\"medium\",\"__woocommerceNamespace\":\"woocommerce/product-collection/product-title\"} /-->\n\n<!-- wp:woocommerce/product-price {\"isDescendentOfQueryLoop\":true,\"textAlign\":\"center\",\"fontSize\":\"small\"} /-->\n\n<!-- wp:woocommerce/product-button {\"textAlign\":\"center\",\"isDescendentOfQueryLoop\":true,\"fontSize\":\"small\"} /-->\n<!-- /wp:woocommerce/product-template --></div>\n<!-- /wp:woocommerce/product-collection --></div>\n\n<!-- /wp:woocommerce/cart-items-block -->\n\n<!-- wp:woocommerce/cart-totals-block -->\n<div class=\"wp-block-woocommerce-cart-totals-block\"><!-- wp:woocommerce/cart-order-summary-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-block\"><!-- wp:woocommerce/cart-order-summary-heading-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-heading-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-heading-block -->\n\n<!-- wp:woocommerce/cart-order-summary-coupon-form-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-coupon-form-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-coupon-form-block -->\n\n<!-- wp:woocommerce/cart-order-summary-subtotal-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-subtotal-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-subtotal-block -->\n\n<!-- wp:woocommerce/cart-order-summary-fee-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-fee-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-fee-block -->\n\n<!-- wp:woocommerce/cart-order-summary-discount-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-discount-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-discount-block -->\n\n<!-- wp:woocommerce/cart-order-summary-shipping-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-shipping-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-shipping-block -->\n\n<!-- wp:woocommerce/cart-order-summary-taxes-block -->\n<div class=\"wp-block-woocommerce-cart-order-summary-taxes-block\"></div>\n<!-- /wp:woocommerce/cart-order-summary-taxes-block --></div>\n<!-- /wp:woocommerce/cart-order-summary-block -->\n\n<!-- wp:woocommerce/cart-express-payment-block -->\n<div class=\"wp-block-woocommerce-cart-express-payment-block\"></div>\n<!-- /wp:woocommerce/cart-express-payment-block -->\n\n<!-- wp:woocommerce/proceed-to-checkout-block -->\n<div class=\"wp-block-woocommerce-proceed-to-checkout-block\"></div>\n<!-- /wp:woocommerce/proceed-to-checkout-block -->\n\n<!-- wp:woocommerce/cart-accepted-payment-methods-block -->\n<div class=\"wp-block-woocommerce-cart-accepted-payment-methods-block\"></div>\n<!-- /wp:woocommerce/cart-accepted-payment-methods-block --></div>\n<!-- /wp:woocommerce/cart-totals-block --></div>\n<!-- /wp:woocommerce/filled-cart-block -->\n\n<!-- wp:woocommerce/empty-cart-block -->\n<div class=\"wp-block-woocommerce-empty-cart-block\"><!-- wp:heading {\"textAlign\":\"center\",\"className\":\"with-empty-cart-icon wc-block-cart__empty-cart__title\"} -->\n<h2 class=\"wp-block-heading has-text-align-center with-empty-cart-icon wc-block-cart__empty-cart__title\">Your cart is currently empty!</h2>\n<!-- /wp:heading -->\n\n<!-- wp:separator {\"className\":\"is-style-dots\"} -->\n<hr class=\"wp-block-separator has-alpha-channel-opacity is-style-dots\"/>\n<!-- /wp:separator -->\n\n<!-- wp:heading {\"textAlign\":\"center\"} -->\n<h2 class=\"wp-block-heading has-text-align-center\">New in store</h2>\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-new {\"columns\":4,\"rows\":1} /--></div>\n<!-- /wp:woocommerce/empty-cart-block --></div>\n<!-- /wp:woocommerce/cart -->','Cart','','publish','closed','closed','','cart','','','2026-03-05 19:17:51','2026-03-05 19:17:51','',0,'http://wordpress/cart/',0,'page','',0),
(7,1,'2026-03-05 19:17:51','2026-03-05 19:17:51','<!-- wp:woocommerce/checkout -->\n<div class=\"wp-block-woocommerce-checkout alignwide wc-block-checkout is-loading\"><!-- wp:woocommerce/checkout-fields-block -->\n<div class=\"wp-block-woocommerce-checkout-fields-block\"><!-- wp:woocommerce/checkout-express-payment-block -->\n<div class=\"wp-block-woocommerce-checkout-express-payment-block\"></div>\n<!-- /wp:woocommerce/checkout-express-payment-block -->\n\n<!-- wp:woocommerce/checkout-contact-information-block -->\n<div class=\"wp-block-woocommerce-checkout-contact-information-block\"></div>\n<!-- /wp:woocommerce/checkout-contact-information-block -->\n\n<!-- wp:woocommerce/checkout-shipping-method-block -->\n<div class=\"wp-block-woocommerce-checkout-shipping-method-block\"></div>\n<!-- /wp:woocommerce/checkout-shipping-method-block -->\n\n<!-- wp:woocommerce/checkout-pickup-options-block -->\n<div class=\"wp-block-woocommerce-checkout-pickup-options-block\"></div>\n<!-- /wp:woocommerce/checkout-pickup-options-block -->\n\n<!-- wp:woocommerce/checkout-shipping-address-block -->\n<div class=\"wp-block-woocommerce-checkout-shipping-address-block\"></div>\n<!-- /wp:woocommerce/checkout-shipping-address-block -->\n\n<!-- wp:woocommerce/checkout-billing-address-block -->\n<div class=\"wp-block-woocommerce-checkout-billing-address-block\"></div>\n<!-- /wp:woocommerce/checkout-billing-address-block -->\n\n<!-- wp:woocommerce/checkout-shipping-methods-block -->\n<div class=\"wp-block-woocommerce-checkout-shipping-methods-block\"></div>\n<!-- /wp:woocommerce/checkout-shipping-methods-block -->\n\n<!-- wp:woocommerce/checkout-payment-block -->\n<div class=\"wp-block-woocommerce-checkout-payment-block\"></div>\n<!-- /wp:woocommerce/checkout-payment-block -->\n\n<!-- wp:woocommerce/checkout-additional-information-block -->\n<div class=\"wp-block-woocommerce-checkout-additional-information-block\"></div>\n<!-- /wp:woocommerce/checkout-additional-information-block -->\n\n<!-- wp:woocommerce/checkout-order-note-block -->\n<div class=\"wp-block-woocommerce-checkout-order-note-block\"></div>\n<!-- /wp:woocommerce/checkout-order-note-block -->\n\n<!-- wp:woocommerce/checkout-terms-block -->\n<div class=\"wp-block-woocommerce-checkout-terms-block\"></div>\n<!-- /wp:woocommerce/checkout-terms-block -->\n\n<!-- wp:woocommerce/checkout-actions-block -->\n<div class=\"wp-block-woocommerce-checkout-actions-block\"></div>\n<!-- /wp:woocommerce/checkout-actions-block --></div>\n<!-- /wp:woocommerce/checkout-fields-block -->\n\n<!-- wp:woocommerce/checkout-totals-block -->\n<div class=\"wp-block-woocommerce-checkout-totals-block\"><!-- wp:woocommerce/checkout-order-summary-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-block\"><!-- wp:woocommerce/checkout-order-summary-cart-items-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-cart-items-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-cart-items-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-coupon-form-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-coupon-form-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-coupon-form-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-subtotal-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-subtotal-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-subtotal-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-fee-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-fee-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-fee-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-discount-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-discount-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-discount-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-shipping-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-shipping-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-shipping-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-taxes-block -->\n<div class=\"wp-block-woocommerce-checkout-order-summary-taxes-block\"></div>\n<!-- /wp:woocommerce/checkout-order-summary-taxes-block --></div>\n<!-- /wp:woocommerce/checkout-order-summary-block --></div>\n<!-- /wp:woocommerce/checkout-totals-block --></div>\n<!-- /wp:woocommerce/checkout -->','Checkout','','publish','closed','closed','','checkout','','','2026-03-05 19:17:51','2026-03-05 19:17:51','',0,'http://wordpress/checkout/',0,'page','',0),
(8,1,'2026-03-05 19:17:51','2026-03-05 19:17:51','<!-- wp:shortcode -->[woocommerce_my_account]<!-- /wp:shortcode -->','My account','','publish','closed','closed','','my-account','','','2026-03-05 19:17:51','2026-03-05 19:17:51','',0,'http://wordpress/my-account/',0,'page','',0),
(9,1,'2026-03-05 19:17:51','0000-00-00 00:00:00','<!-- wp:paragraph -->\n<p><b>This is a sample page.</b></p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Overview</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Our refund and returns policy lasts 30 days. If 30 days have passed since your purchase, we can’t offer you a full refund or exchange.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>To be eligible for a return, your item must be unused and in the same condition that you received it. It must also be in the original packaging.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Several types of goods are exempt from being returned. Perishable goods such as food, flowers, newspapers or magazines cannot be returned. We also do not accept products that are intimate or sanitary goods, hazardous materials, or flammable liquids or gases.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Additional non-returnable items:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:list -->\n<ul>\n<li>Gift cards</li>\n<li>Downloadable software products</li>\n<li>Some health and personal care items</li>\n</ul>\n<!-- /wp:list -->\n\n<!-- wp:paragraph -->\n<p>To complete your return, we require a receipt or proof of purchase.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Please do not send your purchase back to the manufacturer.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>There are certain situations where only partial refunds are granted:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:list -->\n<ul>\n<li>Book with obvious signs of use</li>\n<li>CD, DVD, VHS tape, software, video game, cassette tape, or vinyl record that has been opened.</li>\n<li>Any item not in its original condition, is damaged or missing parts for reasons not due to our error.</li>\n<li>Any item that is returned more than 30 days after delivery</li>\n</ul>\n<!-- /wp:list -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Refunds</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your refund.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you are approved, then your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain amount of days.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading {\"level\":3} -->\n<h3 class=\"wp-block-heading\">Late or missing refunds</h3>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>If you haven’t received a refund yet, first check your bank account again.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Then contact your credit card company, it may take some time before your refund is officially posted.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Next contact your bank. There is often some processing time before a refund is posted.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you’ve done all of this and you still have not received your refund yet, please contact us at {email address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading {\"level\":3} -->\n<h3 class=\"wp-block-heading\">Sale items</h3>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Only regular priced items may be refunded. Sale items cannot be refunded.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Exchanges</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>We only replace items if they are defective or damaged. If you need to exchange it for the same item, send us an email at {email address} and send your item to: {physical address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Gifts</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>If the item was marked as a gift when purchased and shipped directly to you, you’ll receive a gift credit for the value of your return. Once the returned item is received, a gift certificate will be mailed to you.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If the item wasn’t marked as a gift when purchased, or the gift giver had the order shipped to themselves to give to you later, we will send a refund to the gift giver and they will find out about your return.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Shipping returns</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>To return your product, you should mail your product to: {physical address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>You will be responsible for paying for your own shipping costs for returning your item. Shipping costs are non-refundable. If you receive a refund, the cost of return shipping will be deducted from your refund.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Depending on where you live, the time it may take for your exchanged product to reach you may vary.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you are returning more expensive items, you may consider using a trackable shipping service or purchasing shipping insurance. We don’t guarantee that we will receive your returned item.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Need help?</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Contact us at {email} for questions related to refunds and returns.</p>\n<!-- /wp:paragraph -->','Refund and Returns Policy','','draft','closed','closed','','refund_returns','','','2026-03-05 19:17:51','0000-00-00 00:00:00','',0,'http://wordpress/?page_id=9',0,'page','',0),
(10,1,'2026-03-05 19:18:01','2026-03-05 19:18:01','Curso de extensão em Gestão do Conhecimento organizacional','Gestão do Conhecimento','Aprenda a gerenciar conhecimento na sua empresa','publish','open','closed','','gestao-do-conhecimento','','','2026-03-05 19:18:01','2026-03-05 19:18:01','',0,'http://wordpress/product/gestao-do-conhecimento/',0,'product','',0),
(11,1,'2026-03-05 19:18:02','2026-03-05 19:18:02','Curso de extensão em Auditoria em Saúde','Auditoria em Saúde','Técnicas de auditoria no setor de saúde','publish','open','closed','','auditoria-em-saude','','','2026-03-05 19:18:02','2026-03-05 19:18:02','',0,'http://wordpress/product/auditoria-em-saude/',0,'product','',0),
(12,1,'2026-03-05 19:18:03','2026-03-05 19:18:03','Curso de extensão em Marketing Digital','Marketing Digital Avançado','Domine as estratégias de marketing digital','publish','open','closed','','marketing-digital-avancado','','','2026-03-05 19:18:03','2026-03-05 19:18:03','',0,'http://wordpress/product/marketing-digital-avancado/',0,'product','',0),
(13,1,'2026-03-05 19:18:04','2026-03-05 19:18:04','Curso de extensão em Excel','Excel Avançado para Negócios','Domine o Excel para ambiente corporativo','publish','open','closed','','excel-avancado-para-negocios','','','2026-03-05 19:18:04','2026-03-05 19:18:04','',0,'http://wordpress/product/excel-avancado-para-negocios/',0,'product','',0),
(14,1,'2026-03-05 19:18:05','2026-03-05 19:18:05','Curso de extensão em Comunicação','Comunicação Assertiva','Melhore sua comunicação profissional','publish','open','closed','','comunicacao-assertiva','','','2026-03-05 19:18:05','2026-03-05 19:18:05','',0,'http://wordpress/product/comunicacao-assertiva/',0,'product','',0),
(15,1,'2026-03-05 19:18:05','2026-03-05 19:18:05','Formação completa em desenvolvimento front-end','Formação Front-end Developer','Torne-se um desenvolvedor front-end','publish','open','closed','','formacao-front-end-developer','','','2026-03-05 19:18:05','2026-03-05 19:18:05','',0,'http://wordpress/product/formacao-front-end-developer/',0,'product','',0),
(16,1,'2026-03-05 19:18:06','2026-03-05 19:18:06','Formação completa em Ciência de Dados','Formação Data Science','Domine análise de dados e machine learning','publish','open','closed','','formacao-data-science','','','2026-03-05 19:18:06','2026-03-05 19:18:06','',0,'http://wordpress/product/formacao-data-science/',0,'product','',0),
(17,1,'2026-03-05 19:18:07','2026-03-05 19:18:07','Formação completa em desenvolvimento full-stack','Formação Full-stack Developer','Domine front-end e back-end','publish','open','closed','','formacao-full-stack-developer','','','2026-03-05 19:18:07','2026-03-05 19:18:07','',0,'http://wordpress/product/formacao-full-stack-developer/',0,'product','',0),
(18,1,'2026-03-05 19:18:08','2026-03-05 19:18:08','Curso gratuito de introdução','Curso Degustação - Introdução','Conheça nossa metodologia','publish','open','closed','','curso-degustacao-introducao','','','2026-03-05 19:18:08','2026-03-05 19:18:08','',0,'http://wordpress/product/curso-degustacao-introducao/',0,'product','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_term_relationships` VALUES
(1,1,0),
(10,2,0),
(10,15,0),
(11,2,0),
(11,15,0),
(12,2,0),
(12,15,0),
(13,2,0),
(13,15,0),
(14,2,0),
(14,15,0),
(15,2,0),
(15,15,0),
(16,2,0),
(16,15,0),
(17,2,0),
(17,15,0),
(18,2,0),
(18,15,0);
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint unsigned NOT NULL DEFAULT '0',
  `count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_term_taxonomy` VALUES
(1,1,'category','',0,1),
(2,2,'product_type','',0,9),
(3,3,'product_type','',0,0),
(4,4,'product_type','',0,0),
(5,5,'product_type','',0,0),
(6,6,'product_visibility','',0,0),
(7,7,'product_visibility','',0,0),
(8,8,'product_visibility','',0,0),
(9,9,'product_visibility','',0,0),
(10,10,'product_visibility','',0,0),
(11,11,'product_visibility','',0,0),
(12,12,'product_visibility','',0,0),
(13,13,'product_visibility','',0,0),
(14,14,'product_visibility','',0,0),
(15,15,'product_cat','',0,9);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_termmeta` VALUES
(1,15,'product_count_product_cat','9');
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_terms` VALUES
(1,'Uncategorized','uncategorized',0),
(2,'simple','simple',0),
(3,'grouped','grouped',0),
(4,'variable','variable',0),
(5,'external','external',0),
(6,'exclude-from-search','exclude-from-search',0),
(7,'exclude-from-catalog','exclude-from-catalog',0),
(8,'featured','featured',0),
(9,'outofstock','outofstock',0),
(10,'rated-1','rated-1',0),
(11,'rated-2','rated-2',0),
(12,'rated-3','rated-3',0),
(13,'rated-4','rated-4',0),
(14,'rated-5','rated-5',0),
(15,'Uncategorized','uncategorized',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usermeta`
--

LOCK TABLES `wp_usermeta` WRITE;
/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_usermeta` VALUES
(1,1,'nickname','admin'),
(2,1,'first_name',''),
(3,1,'last_name',''),
(4,1,'description',''),
(5,1,'rich_editing','true'),
(6,1,'syntax_highlighting','true'),
(7,1,'comment_shortcuts','false'),
(8,1,'admin_color','fresh'),
(9,1,'use_ssl','0'),
(10,1,'show_admin_bar_front','true'),
(11,1,'locale',''),
(12,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}'),
(13,1,'wp_user_level','10'),
(14,1,'dismissed_wp_pointers',''),
(15,1,'show_welcome_panel','1'),
(16,1,'_woocommerce_persistent_cart_1','a:1:{s:4:\"cart\";a:0:{}}'),
(17,2,'nickname','maria.silva'),
(18,2,'first_name','Maria'),
(19,2,'last_name','Silva'),
(20,2,'description',''),
(21,2,'rich_editing','true'),
(22,2,'syntax_highlighting','true'),
(23,2,'comment_shortcuts','false'),
(24,2,'admin_color','fresh'),
(25,2,'use_ssl','0'),
(26,2,'show_admin_bar_front','true'),
(27,2,'locale',''),
(28,2,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(29,2,'wp_user_level','0'),
(30,2,'dismissed_wp_pointers',''),
(31,3,'nickname','joao.santos'),
(32,3,'first_name','João'),
(33,3,'last_name','Santos'),
(34,3,'description',''),
(35,3,'rich_editing','true'),
(36,3,'syntax_highlighting','true'),
(37,3,'comment_shortcuts','false'),
(38,3,'admin_color','fresh'),
(39,3,'use_ssl','0'),
(40,3,'show_admin_bar_front','true'),
(41,3,'locale',''),
(42,3,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(43,3,'wp_user_level','0'),
(44,3,'dismissed_wp_pointers',''),
(45,4,'nickname','ana.oliveira'),
(46,4,'first_name','Ana'),
(47,4,'last_name','Oliveira'),
(48,4,'description',''),
(49,4,'rich_editing','true'),
(50,4,'syntax_highlighting','true'),
(51,4,'comment_shortcuts','false'),
(52,4,'admin_color','fresh'),
(53,4,'use_ssl','0'),
(54,4,'show_admin_bar_front','true'),
(55,4,'locale',''),
(56,4,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(57,4,'wp_user_level','0'),
(58,4,'dismissed_wp_pointers',''),
(59,5,'nickname','carlos.souza'),
(60,5,'first_name','Carlos'),
(61,5,'last_name','Souza'),
(62,5,'description',''),
(63,5,'rich_editing','true'),
(64,5,'syntax_highlighting','true'),
(65,5,'comment_shortcuts','false'),
(66,5,'admin_color','fresh'),
(67,5,'use_ssl','0'),
(68,5,'show_admin_bar_front','true'),
(69,5,'locale',''),
(70,5,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(71,5,'wp_user_level','0'),
(72,5,'dismissed_wp_pointers',''),
(73,6,'nickname','fernanda.costa'),
(74,6,'first_name','Fernanda'),
(75,6,'last_name','Costa'),
(76,6,'description',''),
(77,6,'rich_editing','true'),
(78,6,'syntax_highlighting','true'),
(79,6,'comment_shortcuts','false'),
(80,6,'admin_color','fresh'),
(81,6,'use_ssl','0'),
(82,6,'show_admin_bar_front','true'),
(83,6,'locale',''),
(84,6,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(85,6,'wp_user_level','0'),
(86,6,'dismissed_wp_pointers',''),
(87,7,'nickname','pedro.lima'),
(88,7,'first_name','Pedro'),
(89,7,'last_name','Lima'),
(90,7,'description',''),
(91,7,'rich_editing','true'),
(92,7,'syntax_highlighting','true'),
(93,7,'comment_shortcuts','false'),
(94,7,'admin_color','fresh'),
(95,7,'use_ssl','0'),
(96,7,'show_admin_bar_front','true'),
(97,7,'locale',''),
(98,7,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(99,7,'wp_user_level','0'),
(100,7,'dismissed_wp_pointers',''),
(101,8,'nickname','juliana.ferreira'),
(102,8,'first_name','Juliana'),
(103,8,'last_name','Ferreira'),
(104,8,'description',''),
(105,8,'rich_editing','true'),
(106,8,'syntax_highlighting','true'),
(107,8,'comment_shortcuts','false'),
(108,8,'admin_color','fresh'),
(109,8,'use_ssl','0'),
(110,8,'show_admin_bar_front','true'),
(111,8,'locale',''),
(112,8,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(113,8,'wp_user_level','0'),
(114,8,'dismissed_wp_pointers',''),
(115,9,'nickname','lucas.almeida'),
(116,9,'first_name','Lucas'),
(117,9,'last_name','Almeida'),
(118,9,'description',''),
(119,9,'rich_editing','true'),
(120,9,'syntax_highlighting','true'),
(121,9,'comment_shortcuts','false'),
(122,9,'admin_color','fresh'),
(123,9,'use_ssl','0'),
(124,9,'show_admin_bar_front','true'),
(125,9,'locale',''),
(126,9,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(127,9,'wp_user_level','0'),
(128,9,'dismissed_wp_pointers',''),
(129,10,'nickname','camila.ribeiro'),
(130,10,'first_name','Camila'),
(131,10,'last_name','Ribeiro'),
(132,10,'description',''),
(133,10,'rich_editing','true'),
(134,10,'syntax_highlighting','true'),
(135,10,'comment_shortcuts','false'),
(136,10,'admin_color','fresh'),
(137,10,'use_ssl','0'),
(138,10,'show_admin_bar_front','true'),
(139,10,'locale',''),
(140,10,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(141,10,'wp_user_level','0'),
(142,10,'dismissed_wp_pointers',''),
(143,11,'nickname','ricardo.pereira'),
(144,11,'first_name','Ricardo'),
(145,11,'last_name','Pereira'),
(146,11,'description',''),
(147,11,'rich_editing','true'),
(148,11,'syntax_highlighting','true'),
(149,11,'comment_shortcuts','false'),
(150,11,'admin_color','fresh'),
(151,11,'use_ssl','0'),
(152,11,'show_admin_bar_front','true'),
(153,11,'locale',''),
(154,11,'wp_capabilities','a:1:{s:8:\"customer\";b:1;}'),
(155,11,'wp_user_level','0'),
(156,11,'dismissed_wp_pointers','');
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_users` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_users` VALUES
(1,'admin','$wp$2y$12$D.q9HF0EEg3EZawOL3BlSeSj6GscOaeuRmegzRw35qsRmZiEXfX5K','admin','admin@example.com','http://wordpress','2026-03-05 19:17:48','',0,'admin'),
(2,'maria.silva','$wp$2y$12$n1I7mo3xkpbgTkdxInQSOOpWeyhuFumw8P/mu/dsCHLLUUKEohDBa','maria-silva','maria.silva123@gmail.com','','2026-03-05 19:18:09','',0,'Maria Silva'),
(3,'joao.santos','$wp$2y$12$ZZMDat9D/DFHdZX1hS5sjexlVnYpSrzA1fIbvRDTRHdJsqew.VRtG','joao-santos','joaosantos@outlook.com','','2026-03-05 19:18:10','',0,'João Santos'),
(4,'ana.oliveira','$wp$2y$12$GtwV77QiGnWLXSLwcrmndOLDfZ8uFMFLUdimqfszCC9pbxS1t2e.G','ana-oliveira','ana.oliveira45@hotmail.com','','2026-03-05 19:18:10','',0,'Ana Oliveira'),
(5,'carlos.souza','$wp$2y$12$tpqYa0Le9Q7CQ3vbsezf1uWaj2Is4hKRk0NnXFF5d5HdVOZhH2Rai','carlos-souza','carlos.souza@bol.com.br','','2026-03-05 19:18:11','',0,'Carlos Souza'),
(6,'fernanda.costa','$wp$2y$12$JJ0J620XaV9pqALEpV6EleFA0BM9DGT6ek4FcTYzlCgHE1er85BwW','fernanda-costa','fernanda.costa@gmail.com','','2026-03-05 19:18:12','',0,'Fernanda Costa'),
(7,'pedro.lima','$wp$2y$12$Mo2pYN.ID.0Eh.BSkR2Oh.uZzqWPD5azTegHbgaugTyxdDEd0WDue','pedro-lima','pedro.lima@outlook.com','','2026-03-05 19:18:13','',0,'Pedro Lima'),
(8,'juliana.ferreira','$wp$2y$12$cVqIONKHZtuRcM287lpVEeFbHVQfcwg.qhRiAOT68WOz6f2noLYt.','juliana-ferreira','juliana.ferreira@hotmail.com','','2026-03-05 19:18:14','',0,'Juliana Ferreira'),
(9,'lucas.almeida','$wp$2y$12$OGTaUr0fvrIryJYqhtu5SuIW81wx6dTP8aga0rbzWHdHhxC87HXqG','lucas-almeida','lucas.almeida@gmail.com','','2026-03-05 19:18:15','',0,'Lucas Almeida'),
(10,'camila.ribeiro','$wp$2y$12$Uno7JrYTXv7eHQPyas60kOu.CYzVta9zSBjXEJGgB2fhLTw2K/4xO','camila-ribeiro','camila.ribeiro@bol.com.br','','2026-03-05 19:18:16','',0,'Camila Ribeiro'),
(11,'ricardo.pereira','$wp$2y$12$47aRo9i9YHXYq7Xx2C8DLuEvjVy1YuEWlKwdKLgOyPi135Mw.AYSO','ricardo-pereira','ricardo.pereira@outlook.com','','2026-03-05 19:18:17','',0,'Ricardo Pereira');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_admin_note_actions`
--

DROP TABLE IF EXISTS `wp_wc_admin_note_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_admin_note_actions` (
  `action_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `note_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `query` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `actioned_text` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonce_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `nonce_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  KEY `note_id` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_admin_note_actions`
--

LOCK TABLES `wp_wc_admin_note_actions` WRITE;
/*!40000 ALTER TABLE `wp_wc_admin_note_actions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_admin_note_actions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_admin_notes`
--

DROP TABLE IF EXISTS `wp_wc_admin_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_admin_notes` (
  `note_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `locale` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `title` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content_data` longtext COLLATE utf8mb4_unicode_520_ci,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_reminder` datetime DEFAULT NULL,
  `is_snoozable` tinyint(1) NOT NULL DEFAULT '0',
  `layout` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `image` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `icon` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'info',
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_admin_notes`
--

LOCK TABLES `wp_wc_admin_notes` WRITE;
/*!40000 ALTER TABLE `wp_wc_admin_notes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_admin_notes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_category_lookup`
--

DROP TABLE IF EXISTS `wp_wc_category_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_category_lookup` (
  `category_tree_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`category_tree_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_category_lookup`
--

LOCK TABLES `wp_wc_category_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_category_lookup` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_category_lookup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_customer_lookup`
--

DROP TABLE IF EXISTS `wp_wc_customer_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_customer_lookup` (
  `customer_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `username` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `first_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_last_active` timestamp NULL DEFAULT NULL,
  `date_registered` timestamp NULL DEFAULT NULL,
  `country` char(2) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `postcode` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `city` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `state` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_customer_lookup`
--

LOCK TABLES `wp_wc_customer_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_customer_lookup` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_customer_lookup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_download_log`
--

DROP TABLE IF EXISTS `wp_wc_download_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_download_log` (
  `download_log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `permission_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `user_ip_address` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  PRIMARY KEY (`download_log_id`),
  KEY `permission_id` (`permission_id`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_download_log`
--

LOCK TABLES `wp_wc_download_log` WRITE;
/*!40000 ALTER TABLE `wp_wc_download_log` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_download_log` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_order_addresses`
--

DROP TABLE IF EXISTS `wp_wc_order_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `address_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `first_name` text COLLATE utf8mb4_unicode_520_ci,
  `last_name` text COLLATE utf8mb4_unicode_520_ci,
  `company` text COLLATE utf8mb4_unicode_520_ci,
  `address_1` text COLLATE utf8mb4_unicode_520_ci,
  `address_2` text COLLATE utf8mb4_unicode_520_ci,
  `city` text COLLATE utf8mb4_unicode_520_ci,
  `state` text COLLATE utf8mb4_unicode_520_ci,
  `postcode` text COLLATE utf8mb4_unicode_520_ci,
  `country` text COLLATE utf8mb4_unicode_520_ci,
  `email` varchar(320) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_type_order_id` (`address_type`,`order_id`),
  KEY `order_id` (`order_id`),
  KEY `email` (`email`(191)),
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_order_addresses`
--

LOCK TABLES `wp_wc_order_addresses` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_addresses` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_wc_order_addresses` VALUES
(1,1001,'billing','Maria','Silva',NULL,'Rua das Flores',NULL,'São Paulo','SP','01310-000','BR','maria.silva123@gmail.com','(11) 98765-4321'),
(2,1002,'billing','João','Santos',NULL,'Avenida Brasil',NULL,'Rio de Janeiro','RJ','20040-020','BR','joaosantos@outlook.com','(21) 99876-5432'),
(3,1003,'billing','Ana','Oliveira',NULL,'Rua Augusta',NULL,'São Paulo','SP','01305-000','BR','ana.oliveira45@hotmail.com','(11) 97654-3210'),
(4,1004,'billing','Carlos','Souza',NULL,'Rua Sete de Setembro',NULL,'Curitiba','PR','80020-010','BR','carlos.souza@bol.com.br','(41) 96543-2109'),
(5,1005,'billing','Fernanda','Costa',NULL,'Rua Oscar Freire',NULL,'São Paulo','SP','01426-001','BR','fernanda.costa@gmail.com','(11) 95432-1098'),
(6,1006,'billing','Pedro','Lima',NULL,'Avenida Paulista',NULL,'São Paulo','SP','01310-100','BR','pedro.lima@outlook.com','(11) 94321-0987'),
(7,1007,'billing','Juliana','Ferreira',NULL,'Rua XV de Novembro',NULL,'Florianópolis','SC','88010-400','BR','juliana.ferreira@hotmail.com','(48) 93210-9876'),
(8,1008,'billing','Lucas','Almeida',NULL,'Avenida Atlântica',NULL,'Rio de Janeiro','RJ','22021-001','BR','lucas.almeida@gmail.com','(21) 92109-8765'),
(9,1009,'billing','Camila','Ribeiro',NULL,'Rua da Praia',NULL,'Porto Alegre','RS','90040-000','BR','camila.ribeiro@bol.com.br','(51) 91098-7654'),
(10,1010,'billing','Ricardo','Pereira',NULL,'Avenida Afonso Pena',NULL,'Belo Horizonte','MG','30130-007','BR','ricardo.pereira@outlook.com','(31) 90987-6543'),
(11,1011,'billing','Roberto','Guest',NULL,'Rua Teste',NULL,'Brasília','DF','70040-010','BR','guest@example.com','(61) 99876-5432'),
(12,1012,'billing','João','Santos',NULL,'Avenida Brasil',NULL,'Rio de Janeiro','RJ','20040-020','BR','joaosantos@outlook.com','(21) 99876-5432'),
(13,1013,'billing','Ana','Oliveira',NULL,'Rua Augusta',NULL,'São Paulo','SP','01305-000','BR','ana.oliveira45@hotmail.com','(11) 97654-3210'),
(14,1014,'billing','Carlos','Souza',NULL,'Rua Sete de Setembro',NULL,'Curitiba','PR','80020-010','BR','carlos.souza@bol.com.br','(41) 96543-2109'),
(15,1015,'billing','Fernanda','Costa',NULL,'Rua Oscar Freire',NULL,'São Paulo','SP','01426-001','BR','fernanda.costa@gmail.com','(11) 95432-1098');
/*!40000 ALTER TABLE `wp_wc_order_addresses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_order_coupon_lookup`
--

DROP TABLE IF EXISTS `wp_wc_order_coupon_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_coupon_lookup` (
  `order_id` bigint unsigned NOT NULL,
  `coupon_id` bigint NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `discount_amount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`,`coupon_id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_order_coupon_lookup`
--

LOCK TABLES `wp_wc_order_coupon_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_coupon_lookup` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_order_coupon_lookup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_order_operational_data`
--

DROP TABLE IF EXISTS `wp_wc_order_operational_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_operational_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned DEFAULT NULL,
  `created_via` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `woocommerce_version` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `prices_include_tax` tinyint(1) DEFAULT NULL,
  `coupon_usages_are_counted` tinyint(1) DEFAULT NULL,
  `download_permission_granted` tinyint(1) DEFAULT NULL,
  `cart_hash` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `new_order_email_sent` tinyint(1) DEFAULT NULL,
  `order_key` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_stock_reduced` tinyint(1) DEFAULT NULL,
  `date_paid_gmt` datetime DEFAULT NULL,
  `date_completed_gmt` datetime DEFAULT NULL,
  `shipping_tax_amount` decimal(26,8) DEFAULT NULL,
  `shipping_total_amount` decimal(26,8) DEFAULT NULL,
  `discount_tax_amount` decimal(26,8) DEFAULT NULL,
  `discount_total_amount` decimal(26,8) DEFAULT NULL,
  `recorded_sales` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `order_key` (`order_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_order_operational_data`
--

LOCK TABLES `wp_wc_order_operational_data` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_operational_data` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_order_operational_data` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_order_product_lookup`
--

DROP TABLE IF EXISTS `wp_wc_order_product_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_product_lookup` (
  `order_item_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `variation_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_qty` int NOT NULL,
  `product_net_revenue` double NOT NULL DEFAULT '0',
  `product_gross_revenue` double NOT NULL DEFAULT '0',
  `coupon_amount` double NOT NULL DEFAULT '0',
  `tax_amount` double NOT NULL DEFAULT '0',
  `shipping_amount` double NOT NULL DEFAULT '0',
  `shipping_tax_amount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_item_id`,`order_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `customer_id` (`customer_id`),
  KEY `date_created` (`date_created`),
  KEY `customer_product_date` (`customer_id`,`product_id`,`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_order_product_lookup`
--

LOCK TABLES `wp_wc_order_product_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_product_lookup` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_order_product_lookup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_order_stats`
--

DROP TABLE IF EXISTS `wp_wc_order_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_stats` (
  `order_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_paid` datetime DEFAULT '0000-00-00 00:00:00',
  `date_completed` datetime DEFAULT '0000-00-00 00:00:00',
  `num_items_sold` int NOT NULL DEFAULT '0',
  `total_sales` double NOT NULL DEFAULT '0',
  `tax_total` double NOT NULL DEFAULT '0',
  `shipping_total` double NOT NULL DEFAULT '0',
  `net_total` double NOT NULL DEFAULT '0',
  `returning_customer` tinyint(1) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `date_created` (`date_created`),
  KEY `customer_id` (`customer_id`),
  KEY `status` (`status`),
  KEY `idx_date_paid_status_parent` (`date_paid`,`status`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_order_stats`
--

LOCK TABLES `wp_wc_order_stats` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_stats` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_order_stats` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_order_tax_lookup`
--

DROP TABLE IF EXISTS `wp_wc_order_tax_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_order_tax_lookup` (
  `order_id` bigint unsigned NOT NULL,
  `tax_rate_id` bigint unsigned NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `shipping_tax` double NOT NULL DEFAULT '0',
  `order_tax` double NOT NULL DEFAULT '0',
  `total_tax` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`,`tax_rate_id`),
  KEY `tax_rate_id` (`tax_rate_id`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_order_tax_lookup`
--

LOCK TABLES `wp_wc_order_tax_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_order_tax_lookup` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_order_tax_lookup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_orders`
--

DROP TABLE IF EXISTS `wp_wc_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_orders` (
  `id` bigint unsigned NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `tax_amount` decimal(26,8) DEFAULT NULL,
  `total_amount` decimal(26,8) DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `billing_email` varchar(320) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_created_gmt` datetime DEFAULT NULL,
  `date_updated_gmt` datetime DEFAULT NULL,
  `parent_order_id` bigint unsigned DEFAULT NULL,
  `payment_method` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_method_title` text COLLATE utf8mb4_unicode_520_ci,
  `transaction_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ip_address` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_520_ci,
  `customer_note` text COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `date_created` (`date_created_gmt`),
  KEY `customer_id_billing_email` (`customer_id`,`billing_email`(171)),
  KEY `billing_email` (`billing_email`(191)),
  KEY `type_status_date` (`type`,`status`,`date_created_gmt`),
  KEY `parent_order_id` (`parent_order_id`),
  KEY `date_updated` (`date_updated_gmt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_orders`
--

LOCK TABLES `wp_wc_orders` WRITE;
/*!40000 ALTER TABLE `wp_wc_orders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_wc_orders` VALUES
(1001,'wc-completed','BRL','shop_order',0.00000000,129.00000000,2,'maria.silva123@gmail.com','2026-03-05 19:18:17','2026-03-05 19:18:17',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1002,'wc-completed','BRL','shop_order',0.00000000,1500.00000000,3,'joaosantos@outlook.com','2026-03-05 19:18:17','2026-03-05 19:18:17',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1003,'wc-cancelled','BRL','shop_order',0.00000000,180.00000000,4,'ana.oliveira45@hotmail.com','2026-03-05 19:18:18','2026-03-05 19:18:18',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1004,'wc-failed','BRL','shop_order',0.00000000,2200.00000000,5,'carlos.souza@bol.com.br','2026-03-05 19:18:19','2026-03-05 19:18:19',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1005,'wc-pending','BRL','shop_order',0.00000000,0.00000000,6,'fernanda.costa@gmail.com','2026-03-05 19:18:20','2026-03-05 19:18:20',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1006,'wc-completed','BRL','shop_order',0.00000000,288.00000000,7,'pedro.lima@outlook.com','2026-03-05 19:18:20','2026-03-05 19:18:20',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1007,'wc-refunded','BRL','shop_order',0.00000000,139.00000000,8,'juliana.ferreira@hotmail.com','2026-03-05 19:18:21','2026-03-05 19:18:21',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1008,'wc-completed','BRL','shop_order',0.00000000,3500.00000000,9,'lucas.almeida@gmail.com','2026-03-05 19:18:22','2026-03-05 19:18:22',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1009,'wc-completed','BRL','shop_order',0.00000000,149.00000000,10,'camila.ribeiro@bol.com.br','2026-03-05 19:18:23','2026-03-05 19:18:23',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1010,'wc-completed','BRL','shop_order',0.00000000,180.00000000,11,'ricardo.pereira@outlook.com','2026-03-05 19:18:24','2026-03-05 19:18:24',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1011,'wc-on-hold','BRL','shop_order',0.00000000,159.00000000,0,'guest@example.com','2026-03-05 19:18:25','2026-03-05 19:18:25',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1012,'wc-processing','BRL','shop_order',0.00000000,2200.00000000,3,'joaosantos@outlook.com','2026-03-05 19:18:25','2026-03-05 19:18:25',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1013,'wc-completed','BRL','shop_order',0.00000000,417.00000000,4,'ana.oliveira45@hotmail.com','2026-03-05 19:18:26','2026-03-05 19:18:26',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1014,'wc-cancelled','BRL','shop_order',0.00000000,3500.00000000,5,'carlos.souza@bol.com.br','2026-03-05 19:18:27','2026-03-05 19:18:27',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL),
(1015,'wc-completed','BRL','shop_order',0.00000000,0.00000000,6,'fernanda.costa@gmail.com','2026-03-05 19:18:28','2026-03-05 19:18:28',NULL,'manual','Pagamento Manual',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `wp_wc_orders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_orders_meta`
--

DROP TABLE IF EXISTS `wp_wc_orders_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_orders_meta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned DEFAULT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`id`),
  KEY `meta_key_value` (`meta_key`(100),`meta_value`(82)),
  KEY `order_id_meta_key_meta_value` (`order_id`,`meta_key`(100),`meta_value`(82))
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_orders_meta`
--

LOCK TABLES `wp_wc_orders_meta` WRITE;
/*!40000 ALTER TABLE `wp_wc_orders_meta` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_wc_orders_meta` VALUES
(1,1001,'_billing_number','123'),
(2,1001,'_billing_neighborhood','Centro'),
(3,1001,'_billing_cellphone','(11) 98765-4321'),
(4,1001,'_billing_cpf','123.456.789-00'),
(5,1001,'_billing_persontype','1'),
(6,1001,'_payment_method','manual'),
(7,1001,'_payment_method_title','Pagamento Manual'),
(8,1001,'_recorded_sales','yes'),
(9,1001,'_recorded_coupon_usage','yes'),
(10,1002,'_billing_number','1500'),
(11,1002,'_billing_neighborhood','Centro'),
(12,1002,'_billing_cellphone','(21) 99876-5432'),
(13,1002,'_billing_cpf','987.654.321-00'),
(14,1002,'_billing_persontype','1'),
(15,1002,'_payment_method','manual'),
(16,1002,'_payment_method_title','Pagamento Manual'),
(17,1002,'_recorded_sales','yes'),
(18,1002,'_recorded_coupon_usage','yes'),
(19,1003,'_billing_number','500'),
(20,1003,'_billing_neighborhood','Consolação'),
(21,1003,'_billing_cellphone','(11) 97654-3210'),
(22,1003,'_billing_cpf','456.789.123-00'),
(23,1003,'_billing_persontype','1'),
(24,1003,'_payment_method','manual'),
(25,1003,'_payment_method_title','Pagamento Manual'),
(26,1003,'_recorded_sales','yes'),
(27,1003,'_recorded_coupon_usage','yes'),
(28,1004,'_billing_number','789'),
(29,1004,'_billing_neighborhood','Centro'),
(30,1004,'_billing_cellphone','(41) 96543-2109'),
(31,1004,'_billing_cpf','789.123.456-00'),
(32,1004,'_billing_persontype','1'),
(33,1004,'_payment_method','manual'),
(34,1004,'_payment_method_title','Pagamento Manual'),
(35,1004,'_recorded_sales','yes'),
(36,1004,'_recorded_coupon_usage','yes'),
(37,1005,'_billing_number','321'),
(38,1005,'_billing_neighborhood','Jardins'),
(39,1005,'_billing_cellphone','(11) 95432-1098'),
(40,1005,'_billing_cpf','321.654.987-00'),
(41,1005,'_billing_persontype','1'),
(42,1005,'_payment_method','manual'),
(43,1005,'_payment_method_title','Pagamento Manual'),
(44,1005,'_recorded_sales','yes'),
(45,1005,'_recorded_coupon_usage','yes'),
(46,1006,'_billing_number','1000'),
(47,1006,'_billing_neighborhood','Bela Vista'),
(48,1006,'_billing_cellphone','(11) 94321-0987'),
(49,1006,'_billing_cpf','654.987.321-00'),
(50,1006,'_billing_persontype','1'),
(51,1006,'_payment_method','manual'),
(52,1006,'_payment_method_title','Pagamento Manual'),
(53,1006,'_recorded_sales','yes'),
(54,1006,'_recorded_coupon_usage','yes'),
(55,1007,'_billing_number','200'),
(56,1007,'_billing_neighborhood','Centro'),
(57,1007,'_billing_cellphone','(48) 93210-9876'),
(58,1007,'_billing_cpf','987.321.654-00'),
(59,1007,'_billing_persontype','1'),
(60,1007,'_payment_method','manual'),
(61,1007,'_payment_method_title','Pagamento Manual'),
(62,1007,'_recorded_sales','yes'),
(63,1007,'_recorded_coupon_usage','yes'),
(64,1008,'_billing_number','500'),
(65,1008,'_billing_neighborhood','Copacabana'),
(66,1008,'_billing_cellphone','(21) 92109-8765'),
(67,1008,'_billing_cpf','321.987.654-00'),
(68,1008,'_billing_persontype','1'),
(69,1008,'_payment_method','manual'),
(70,1008,'_payment_method_title','Pagamento Manual'),
(71,1008,'_recorded_sales','yes'),
(72,1008,'_recorded_coupon_usage','yes'),
(73,1009,'_billing_number','150'),
(74,1009,'_billing_neighborhood','Centro Histórico'),
(75,1009,'_billing_cellphone','(51) 91098-7654'),
(76,1009,'_billing_cpf','654.321.987-00'),
(77,1009,'_billing_persontype','1'),
(78,1009,'_payment_method','manual'),
(79,1009,'_payment_method_title','Pagamento Manual'),
(80,1009,'_recorded_sales','yes'),
(81,1009,'_recorded_coupon_usage','yes'),
(82,1010,'_billing_number','1001'),
(83,1010,'_billing_neighborhood','Centro'),
(84,1010,'_billing_cellphone','(31) 90987-6543'),
(85,1010,'_billing_cpf','987.654.321-00'),
(86,1010,'_billing_persontype','1'),
(87,1010,'_payment_method','manual'),
(88,1010,'_payment_method_title','Pagamento Manual'),
(89,1010,'_recorded_sales','yes'),
(90,1010,'_recorded_coupon_usage','yes'),
(91,1011,'_billing_number','100'),
(92,1011,'_billing_neighborhood','Asa Sul'),
(93,1011,'_billing_cellphone','(61) 99876-5432'),
(94,1011,'_billing_cpf','111.222.333-44'),
(95,1011,'_billing_persontype','1'),
(96,1011,'_payment_method','manual'),
(97,1011,'_payment_method_title','Pagamento Manual'),
(98,1011,'_recorded_sales','yes'),
(99,1011,'_recorded_coupon_usage','yes'),
(100,1012,'_billing_number','1500'),
(101,1012,'_billing_neighborhood','Centro'),
(102,1012,'_billing_cellphone','(21) 99876-5432'),
(103,1012,'_billing_cpf','987.654.321-00'),
(104,1012,'_billing_persontype','1'),
(105,1012,'_payment_method','manual'),
(106,1012,'_payment_method_title','Pagamento Manual'),
(107,1012,'_recorded_sales','yes'),
(108,1012,'_recorded_coupon_usage','yes'),
(109,1013,'_billing_number','500'),
(110,1013,'_billing_neighborhood','Consolação'),
(111,1013,'_billing_cellphone','(11) 97654-3210'),
(112,1013,'_billing_cpf','456.789.123-00'),
(113,1013,'_billing_persontype','1'),
(114,1013,'_payment_method','manual'),
(115,1013,'_payment_method_title','Pagamento Manual'),
(116,1013,'_recorded_sales','yes'),
(117,1013,'_recorded_coupon_usage','yes'),
(118,1014,'_billing_number','789'),
(119,1014,'_billing_neighborhood','Centro'),
(120,1014,'_billing_cellphone','(41) 96543-2109'),
(121,1014,'_billing_cpf','789.123.456-00'),
(122,1014,'_billing_persontype','1'),
(123,1014,'_payment_method','manual'),
(124,1014,'_payment_method_title','Pagamento Manual'),
(125,1014,'_recorded_sales','yes'),
(126,1014,'_recorded_coupon_usage','yes'),
(127,1015,'_billing_number','321'),
(128,1015,'_billing_neighborhood','Jardins'),
(129,1015,'_billing_cellphone','(11) 95432-1098'),
(130,1015,'_billing_cpf','321.654.987-00'),
(131,1015,'_billing_persontype','1'),
(132,1015,'_payment_method','manual'),
(133,1015,'_payment_method_title','Pagamento Manual'),
(134,1015,'_recorded_sales','yes'),
(135,1015,'_recorded_coupon_usage','yes');
/*!40000 ALTER TABLE `wp_wc_orders_meta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_product_attributes_lookup`
--

DROP TABLE IF EXISTS `wp_wc_product_attributes_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_product_attributes_lookup` (
  `product_id` bigint NOT NULL,
  `product_or_parent_id` bigint NOT NULL,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `term_id` bigint NOT NULL,
  `is_variation_attribute` tinyint(1) NOT NULL,
  `in_stock` tinyint(1) NOT NULL,
  PRIMARY KEY (`product_or_parent_id`,`term_id`,`product_id`,`taxonomy`),
  KEY `is_variation_attribute_term_id` (`is_variation_attribute`,`term_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_product_attributes_lookup`
--

LOCK TABLES `wp_wc_product_attributes_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_product_attributes_lookup` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_product_attributes_lookup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_product_download_directories`
--

DROP TABLE IF EXISTS `wp_wc_product_download_directories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_product_download_directories` (
  `url_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(256) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`url_id`),
  KEY `url` (`url`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_product_download_directories`
--

LOCK TABLES `wp_wc_product_download_directories` WRITE;
/*!40000 ALTER TABLE `wp_wc_product_download_directories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_wc_product_download_directories` VALUES
(1,'file:///var/www/html/wp-content/uploads/woocommerce_uploads/',1),
(2,'http://wordpress/wp-content/uploads/woocommerce_uploads/',1);
/*!40000 ALTER TABLE `wp_wc_product_download_directories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_product_meta_lookup`
--

DROP TABLE IF EXISTS `wp_wc_product_meta_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_product_meta_lookup` (
  `product_id` bigint NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `global_unique_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `virtual` tinyint(1) DEFAULT '0',
  `downloadable` tinyint(1) DEFAULT '0',
  `min_price` decimal(19,4) DEFAULT NULL,
  `max_price` decimal(19,4) DEFAULT NULL,
  `onsale` tinyint(1) DEFAULT '0',
  `stock_quantity` double DEFAULT NULL,
  `stock_status` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'instock',
  `rating_count` bigint DEFAULT '0',
  `average_rating` decimal(3,2) DEFAULT '0.00',
  `total_sales` bigint DEFAULT '0',
  `tax_status` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'taxable',
  `tax_class` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  PRIMARY KEY (`product_id`),
  KEY `virtual` (`virtual`),
  KEY `downloadable` (`downloadable`),
  KEY `stock_status` (`stock_status`),
  KEY `stock_quantity` (`stock_quantity`),
  KEY `onsale` (`onsale`),
  KEY `min_max_price` (`min_price`,`max_price`),
  KEY `sku` (`sku`(50))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_product_meta_lookup`
--

LOCK TABLES `wp_wc_product_meta_lookup` WRITE;
/*!40000 ALTER TABLE `wp_wc_product_meta_lookup` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_wc_product_meta_lookup` VALUES
(10,'EXT-001','',0,0,129.0000,129.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(11,'EXT-002','',0,0,180.0000,180.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(12,'EXT-003','',0,0,159.0000,159.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(13,'EXT-004','',0,0,149.0000,149.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(14,'EXT-005','',0,0,139.0000,139.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(15,'FORM-001','',0,0,1500.0000,1500.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(16,'FORM-002','',0,0,2200.0000,2200.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(17,'FORM-003','',0,0,3500.0000,3500.0000,0,NULL,'instock',0,0.00,0,'taxable',''),
(18,'FREE-001','',0,0,0.0000,0.0000,0,NULL,'instock',0,0.00,0,'taxable','');
/*!40000 ALTER TABLE `wp_wc_product_meta_lookup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_rate_limits`
--

DROP TABLE IF EXISTS `wp_wc_rate_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_rate_limits` (
  `rate_limit_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rate_limit_key` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rate_limit_expiry` bigint unsigned NOT NULL,
  `rate_limit_remaining` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`rate_limit_id`),
  UNIQUE KEY `rate_limit_key` (`rate_limit_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_rate_limits`
--

LOCK TABLES `wp_wc_rate_limits` WRITE;
/*!40000 ALTER TABLE `wp_wc_rate_limits` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_rate_limits` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_reserved_stock`
--

DROP TABLE IF EXISTS `wp_wc_reserved_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_reserved_stock` (
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `stock_quantity` double NOT NULL DEFAULT '0',
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`order_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_reserved_stock`
--

LOCK TABLES `wp_wc_reserved_stock` WRITE;
/*!40000 ALTER TABLE `wp_wc_reserved_stock` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_reserved_stock` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_tax_rate_classes`
--

DROP TABLE IF EXISTS `wp_wc_tax_rate_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_tax_rate_classes` (
  `tax_rate_class_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_rate_class_id`),
  UNIQUE KEY `slug` (`slug`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_tax_rate_classes`
--

LOCK TABLES `wp_wc_tax_rate_classes` WRITE;
/*!40000 ALTER TABLE `wp_wc_tax_rate_classes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_wc_tax_rate_classes` VALUES
(1,'Reduced rate','reduced-rate'),
(2,'Zero rate','zero-rate');
/*!40000 ALTER TABLE `wp_wc_tax_rate_classes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_wc_webhooks`
--

DROP TABLE IF EXISTS `wp_wc_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_wc_webhooks` (
  `webhook_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `delivery_url` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secret` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `api_version` smallint NOT NULL,
  `failure_count` smallint NOT NULL DEFAULT '0',
  `pending_delivery` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`webhook_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wc_webhooks`
--

LOCK TABLES `wp_wc_webhooks` WRITE;
/*!40000 ALTER TABLE `wp_wc_webhooks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_wc_webhooks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_api_keys`
--

DROP TABLE IF EXISTS `wp_woocommerce_api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_api_keys` (
  `key_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permissions` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_key` char(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_secret` char(43) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonces` longtext COLLATE utf8mb4_unicode_520_ci,
  `truncated_key` char(7) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_access` datetime DEFAULT NULL,
  PRIMARY KEY (`key_id`),
  KEY `consumer_key` (`consumer_key`),
  KEY `consumer_secret` (`consumer_secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_api_keys`
--

LOCK TABLES `wp_woocommerce_api_keys` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_api_keys` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_api_keys` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_attribute_taxonomies`
--

DROP TABLE IF EXISTS `wp_woocommerce_attribute_taxonomies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_attribute_taxonomies` (
  `attribute_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_label` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `attribute_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_orderby` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_public` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`attribute_id`),
  KEY `attribute_name` (`attribute_name`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_attribute_taxonomies`
--

LOCK TABLES `wp_woocommerce_attribute_taxonomies` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_attribute_taxonomies` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_attribute_taxonomies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_downloadable_product_permissions`
--

DROP TABLE IF EXISTS `wp_woocommerce_downloadable_product_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_downloadable_product_permissions` (
  `permission_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `download_id` varchar(36) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned NOT NULL DEFAULT '0',
  `order_key` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_email` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `downloads_remaining` varchar(9) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `access_granted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_expires` datetime DEFAULT NULL,
  `download_count` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_id`),
  KEY `download_order_key_product` (`product_id`,`order_id`,`order_key`(16),`download_id`),
  KEY `download_order_product` (`download_id`,`order_id`,`product_id`),
  KEY `order_id` (`order_id`),
  KEY `user_order_remaining_expires` (`user_id`,`order_id`,`downloads_remaining`,`access_expires`),
  KEY `idx_user_email` (`user_email`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_downloadable_product_permissions`
--

LOCK TABLES `wp_woocommerce_downloadable_product_permissions` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_downloadable_product_permissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_downloadable_product_permissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_log`
--

DROP TABLE IF EXISTS `wp_woocommerce_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_log` (
  `log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `level` smallint NOT NULL,
  `source` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `context` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`log_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_log`
--

LOCK TABLES `wp_woocommerce_log` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_log` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_log` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_order_itemmeta`
--

DROP TABLE IF EXISTS `wp_woocommerce_order_itemmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_order_itemmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_item_id` bigint unsigned NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `meta_key` (`meta_key`(32))
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_order_itemmeta`
--

LOCK TABLES `wp_woocommerce_order_itemmeta` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_order_itemmeta` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_woocommerce_order_itemmeta` VALUES
(1,1,'_product_id','10'),
(2,1,'_variation_id','0'),
(3,1,'_qty','1'),
(4,1,'_tax_class',''),
(5,1,'_line_subtotal','129.00'),
(6,1,'_line_subtotal_tax','0'),
(7,1,'_line_total','129.00'),
(8,1,'_line_tax','0'),
(9,1,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(10,2,'_product_id','15'),
(11,2,'_variation_id','0'),
(12,2,'_qty','1'),
(13,2,'_tax_class',''),
(14,2,'_line_subtotal','1500.00'),
(15,2,'_line_subtotal_tax','0'),
(16,2,'_line_total','1500.00'),
(17,2,'_line_tax','0'),
(18,2,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(19,3,'_product_id','11'),
(20,3,'_variation_id','0'),
(21,3,'_qty','1'),
(22,3,'_tax_class',''),
(23,3,'_line_subtotal','180.00'),
(24,3,'_line_subtotal_tax','0'),
(25,3,'_line_total','180.00'),
(26,3,'_line_tax','0'),
(27,3,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(28,4,'_product_id','16'),
(29,4,'_variation_id','0'),
(30,4,'_qty','1'),
(31,4,'_tax_class',''),
(32,4,'_line_subtotal','2200.00'),
(33,4,'_line_subtotal_tax','0'),
(34,4,'_line_total','2200.00'),
(35,4,'_line_tax','0'),
(36,4,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(37,5,'_product_id','18'),
(38,5,'_variation_id','0'),
(39,5,'_qty','1'),
(40,5,'_tax_class',''),
(41,5,'_line_subtotal','0.00'),
(42,5,'_line_subtotal_tax','0'),
(43,5,'_line_total','0.00'),
(44,5,'_line_tax','0'),
(45,5,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(46,6,'_product_id','10'),
(47,6,'_variation_id','0'),
(48,6,'_qty','1'),
(49,6,'_tax_class',''),
(50,6,'_line_subtotal','129.00'),
(51,6,'_line_subtotal_tax','0'),
(52,6,'_line_total','129.00'),
(53,6,'_line_tax','0'),
(54,6,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(55,7,'_product_id','12'),
(56,7,'_variation_id','0'),
(57,7,'_qty','1'),
(58,7,'_tax_class',''),
(59,7,'_line_subtotal','159.00'),
(60,7,'_line_subtotal_tax','0'),
(61,7,'_line_total','159.00'),
(62,7,'_line_tax','0'),
(63,7,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(64,8,'_product_id','14'),
(65,8,'_variation_id','0'),
(66,8,'_qty','1'),
(67,8,'_tax_class',''),
(68,8,'_line_subtotal','139.00'),
(69,8,'_line_subtotal_tax','0'),
(70,8,'_line_total','139.00'),
(71,8,'_line_tax','0'),
(72,8,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(73,9,'_product_id','17'),
(74,9,'_variation_id','0'),
(75,9,'_qty','1'),
(76,9,'_tax_class',''),
(77,9,'_line_subtotal','3500.00'),
(78,9,'_line_subtotal_tax','0'),
(79,9,'_line_total','3500.00'),
(80,9,'_line_tax','0'),
(81,9,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(82,10,'_product_id','13'),
(83,10,'_variation_id','0'),
(84,10,'_qty','1'),
(85,10,'_tax_class',''),
(86,10,'_line_subtotal','149.00'),
(87,10,'_line_subtotal_tax','0'),
(88,10,'_line_total','149.00'),
(89,10,'_line_tax','0'),
(90,10,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(91,11,'_product_id','11'),
(92,11,'_variation_id','0'),
(93,11,'_qty','1'),
(94,11,'_tax_class',''),
(95,11,'_line_subtotal','180.00'),
(96,11,'_line_subtotal_tax','0'),
(97,11,'_line_total','180.00'),
(98,11,'_line_tax','0'),
(99,11,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(100,12,'_product_id','12'),
(101,12,'_variation_id','0'),
(102,12,'_qty','1'),
(103,12,'_tax_class',''),
(104,12,'_line_subtotal','159.00'),
(105,12,'_line_subtotal_tax','0'),
(106,12,'_line_total','159.00'),
(107,12,'_line_tax','0'),
(108,12,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(109,13,'_product_id','16'),
(110,13,'_variation_id','0'),
(111,13,'_qty','1'),
(112,13,'_tax_class',''),
(113,13,'_line_subtotal','2200.00'),
(114,13,'_line_subtotal_tax','0'),
(115,13,'_line_total','2200.00'),
(116,13,'_line_tax','0'),
(117,13,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(118,14,'_product_id','10'),
(119,14,'_variation_id','0'),
(120,14,'_qty','1'),
(121,14,'_tax_class',''),
(122,14,'_line_subtotal','129.00'),
(123,14,'_line_subtotal_tax','0'),
(124,14,'_line_total','129.00'),
(125,14,'_line_tax','0'),
(126,14,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(127,15,'_product_id','13'),
(128,15,'_variation_id','0'),
(129,15,'_qty','1'),
(130,15,'_tax_class',''),
(131,15,'_line_subtotal','149.00'),
(132,15,'_line_subtotal_tax','0'),
(133,15,'_line_total','149.00'),
(134,15,'_line_tax','0'),
(135,15,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(136,16,'_product_id','14'),
(137,16,'_variation_id','0'),
(138,16,'_qty','1'),
(139,16,'_tax_class',''),
(140,16,'_line_subtotal','139.00'),
(141,16,'_line_subtotal_tax','0'),
(142,16,'_line_total','139.00'),
(143,16,'_line_tax','0'),
(144,16,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(145,17,'_product_id','17'),
(146,17,'_variation_id','0'),
(147,17,'_qty','1'),
(148,17,'_tax_class',''),
(149,17,'_line_subtotal','3500.00'),
(150,17,'_line_subtotal_tax','0'),
(151,17,'_line_total','3500.00'),
(152,17,'_line_tax','0'),
(153,17,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}'),
(154,18,'_product_id','18'),
(155,18,'_variation_id','0'),
(156,18,'_qty','1'),
(157,18,'_tax_class',''),
(158,18,'_line_subtotal','0.00'),
(159,18,'_line_subtotal_tax','0'),
(160,18,'_line_total','0.00'),
(161,18,'_line_tax','0'),
(162,18,'_line_tax_data','a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}');
/*!40000 ALTER TABLE `wp_woocommerce_order_itemmeta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_order_items`
--

DROP TABLE IF EXISTS `wp_woocommerce_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_order_items` (
  `order_item_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_item_name` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `order_item_type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `order_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_order_items`
--

LOCK TABLES `wp_woocommerce_order_items` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_order_items` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_woocommerce_order_items` VALUES
(1,'Gestão do Conhecimento','line_item',1001),
(2,'Formação Front-end Developer','line_item',1002),
(3,'Auditoria em Saúde','line_item',1003),
(4,'Formação Data Science','line_item',1004),
(5,'Curso Degustação - Introdução','line_item',1005),
(6,'Gestão do Conhecimento','line_item',1006),
(7,'Marketing Digital Avançado','line_item',1006),
(8,'Comunicação Assertiva','line_item',1007),
(9,'Formação Full-stack Developer','line_item',1008),
(10,'Excel Avançado para Negócios','line_item',1009),
(11,'Auditoria em Saúde','line_item',1010),
(12,'Marketing Digital Avançado','line_item',1011),
(13,'Formação Data Science','line_item',1012),
(14,'Gestão do Conhecimento','line_item',1013),
(15,'Excel Avançado para Negócios','line_item',1013),
(16,'Comunicação Assertiva','line_item',1013),
(17,'Formação Full-stack Developer','line_item',1014),
(18,'Curso Degustação - Introdução','line_item',1015);
/*!40000 ALTER TABLE `wp_woocommerce_order_items` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_payment_tokenmeta`
--

DROP TABLE IF EXISTS `wp_woocommerce_payment_tokenmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_payment_tokenmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_token_id` bigint unsigned NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `payment_token_id` (`payment_token_id`),
  KEY `meta_key` (`meta_key`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_payment_tokenmeta`
--

LOCK TABLES `wp_woocommerce_payment_tokenmeta` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokenmeta` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokenmeta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_payment_tokens`
--

DROP TABLE IF EXISTS `wp_woocommerce_payment_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_payment_tokens` (
  `token_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gateway_id` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`token_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_payment_tokens`
--

LOCK TABLES `wp_woocommerce_payment_tokens` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_payment_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_sessions`
--

DROP TABLE IF EXISTS `wp_woocommerce_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_sessions` (
  `session_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_key` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_expiry` bigint unsigned NOT NULL,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_key` (`session_key`),
  KEY `session_expiry` (`session_expiry`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_sessions`
--

LOCK TABLES `wp_woocommerce_sessions` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_sessions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `wp_woocommerce_sessions` VALUES
(1,'1','a:1:{s:8:\"customer\";s:760:\"a:28:{s:2:\"id\";s:1:\"1\";s:13:\"date_modified\";s:0:\"\";s:10:\"first_name\";s:0:\"\";s:9:\"last_name\";s:0:\"\";s:7:\"company\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:5:\"email\";s:17:\"admin@example.com\";s:7:\"address\";s:0:\"\";s:9:\"address_1\";s:0:\"\";s:9:\"address_2\";s:0:\"\";s:4:\"city\";s:0:\"\";s:5:\"state\";s:2:\"SP\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:2:\"BR\";s:19:\"shipping_first_name\";s:0:\"\";s:18:\"shipping_last_name\";s:0:\"\";s:16:\"shipping_company\";s:0:\"\";s:14:\"shipping_phone\";s:0:\"\";s:16:\"shipping_address\";s:0:\"\";s:18:\"shipping_address_1\";s:0:\"\";s:18:\"shipping_address_2\";s:0:\"\";s:13:\"shipping_city\";s:0:\"\";s:14:\"shipping_state\";s:2:\"SP\";s:17:\"shipping_postcode\";s:0:\"\";s:16:\"shipping_country\";s:2:\"BR\";s:13:\"is_vat_exempt\";s:0:\"\";s:19:\"calculated_shipping\";s:0:\"\";s:9:\"meta_data\";a:0:{}}\";}',1773343081);
/*!40000 ALTER TABLE `wp_woocommerce_sessions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_shipping_zone_locations`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zone_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_shipping_zone_locations` (
  `location_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `zone_id` bigint unsigned NOT NULL,
  `location_code` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `zone_id` (`zone_id`),
  KEY `location_type_code` (`location_type`(10),`location_code`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_shipping_zone_locations`
--

LOCK TABLES `wp_woocommerce_shipping_zone_locations` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_locations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_locations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_shipping_zone_methods`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zone_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_shipping_zone_methods` (
  `zone_id` bigint unsigned NOT NULL,
  `instance_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `method_id` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `method_order` bigint unsigned NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_shipping_zone_methods`
--

LOCK TABLES `wp_woocommerce_shipping_zone_methods` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_methods` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zone_methods` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_shipping_zones`
--

DROP TABLE IF EXISTS `wp_woocommerce_shipping_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_shipping_zones` (
  `zone_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `zone_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `zone_order` bigint unsigned NOT NULL,
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_shipping_zones`
--

LOCK TABLES `wp_woocommerce_shipping_zones` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zones` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_shipping_zones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_tax_rate_locations`
--

DROP TABLE IF EXISTS `wp_woocommerce_tax_rate_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_tax_rate_locations` (
  `location_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `location_code` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tax_rate_id` bigint unsigned NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `tax_rate_id` (`tax_rate_id`),
  KEY `location_type_code` (`location_type`(10),`location_code`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_tax_rate_locations`
--

LOCK TABLES `wp_woocommerce_tax_rate_locations` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rate_locations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rate_locations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `wp_woocommerce_tax_rates`
--

DROP TABLE IF EXISTS `wp_woocommerce_tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_woocommerce_tax_rates` (
  `tax_rate_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_rate_country` varchar(2) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_state` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate` varchar(8) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_priority` bigint unsigned NOT NULL,
  `tax_rate_compound` int NOT NULL DEFAULT '0',
  `tax_rate_shipping` int NOT NULL DEFAULT '1',
  `tax_rate_order` bigint unsigned NOT NULL,
  `tax_rate_class` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_rate_id`),
  KEY `tax_rate_country` (`tax_rate_country`),
  KEY `tax_rate_state` (`tax_rate_state`(2)),
  KEY `tax_rate_class` (`tax_rate_class`(10)),
  KEY `tax_rate_priority` (`tax_rate_priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_woocommerce_tax_rates`
--

LOCK TABLES `wp_woocommerce_tax_rates` WRITE;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `wp_woocommerce_tax_rates` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-03-05 19:18:32
