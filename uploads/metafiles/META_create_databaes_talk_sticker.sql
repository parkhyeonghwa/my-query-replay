
--
-- Current Database: `talk_stickershop`
--
DROP DATABASE `talk_stickershop` ;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `talk_stickershop` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `talk_stickershop`;

--
-- Table structure for table `BATCH_JOB_EXECUTION`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  `JOB_CONFIGURATION_LOCATION` varchar(2500) DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `BATCH_JOB_INSTANCE` (`JOB_INSTANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_EXECUTION_CONTEXT`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_CONTEXT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION_CONTEXT` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_EXECUTION_PARAMS`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_PARAMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION_PARAMS` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `TYPE_CD` varchar(6) NOT NULL,
  `KEY_NAME` varchar(100) NOT NULL,
  `STRING_VAL` varchar(250) DEFAULT NULL,
  `DATE_VAL` datetime DEFAULT NULL,
  `LONG_VAL` bigint(20) DEFAULT NULL,
  `DOUBLE_VAL` double DEFAULT NULL,
  `IDENTIFYING` char(1) NOT NULL,
  KEY `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_EXECUTION_SEQ`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_SEQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION_SEQ` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_INSTANCE`
--

DROP TABLE IF EXISTS `BATCH_JOB_INSTANCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_INSTANCE` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_KEY` varchar(32) NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_SEQ`
--

DROP TABLE IF EXISTS `BATCH_JOB_SEQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_SEQ` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_STEP_EXECUTION`
--

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_STEP_EXECUTION` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `STEP_NAME` varchar(100) NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `COMMIT_COUNT` bigint(20) DEFAULT NULL,
  `READ_COUNT` bigint(20) DEFAULT NULL,
  `FILTER_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_COUNT` bigint(20) DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(20) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_STEP_EXECUTION_CONTEXT`
--

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION_CONTEXT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_STEP_EXECUTION_CONTEXT` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `BATCH_STEP_EXECUTION` (`STEP_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_STEP_EXECUTION_SEQ`
--

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION_SEQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_STEP_EXECUTION_SEQ` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `author_id` bigint(11) NOT NULL,
  `language` varchar(5) NOT NULL,
  `display_name` varchar(200) NOT NULL,
  PRIMARY KEY (`author_id`,`language`),
  KEY `ix_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_meta`
--

DROP TABLE IF EXISTS `author_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_meta` (
  `author_id` bigint(20) NOT NULL,
  `subtype` int(11) NOT NULL DEFAULT '0',
  `last_edit_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner` (
  `banner_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `banner_seq` bigint(20) NOT NULL,
  `publish_since` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `publish_until` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_type` int(11) NOT NULL,
  `link_to` text NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `last_editor` varchar(45) DEFAULT NULL,
  `last_edit_date` timestamp NULL DEFAULT NULL,
  `on_air` tinyint(1) NOT NULL DEFAULT '0',
  `sale_area_type` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`banner_id`),
  UNIQUE KEY `banner_seq_UNIQUE` (`banner_seq`),
  KEY `ix_link_type` (`link_type`),
  KEY `ix_on_air_banner_id` (`on_air`,`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1929 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banner_display_area`
--

DROP TABLE IF EXISTS `banner_display_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner_display_area` (
  `banner_id` bigint(20) NOT NULL,
  `display_area` int(11) NOT NULL,
  PRIMARY KEY (`banner_id`,`display_area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banner_flag`
--

DROP TABLE IF EXISTS `banner_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner_flag` (
  `banner_id` bigint(20) NOT NULL,
  `flg_name` varchar(100) NOT NULL,
  PRIMARY KEY (`banner_id`,`flg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banner_image`
--

DROP TABLE IF EXISTS `banner_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner_image` (
  `banner_id` bigint(20) NOT NULL,
  `language` varchar(5) NOT NULL,
  `device_type` varchar(20) NOT NULL,
  `image` longblob,
  `image_tmp` longblob,
  PRIMARY KEY (`banner_id`,`language`,`device_type`),
  KEY `ix_device_type_language` (`device_type`,`language`),
  KEY `ix_language_device_type` (`language`,`device_type`),
  KEY `ix_banner_id_device_type` (`banner_id`,`device_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banner_sale_area`
--

DROP TABLE IF EXISTS `banner_sale_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner_sale_area` (
  `banner_id` bigint(20) NOT NULL,
  `locale` char(2) NOT NULL,
  PRIMARY KEY (`banner_id`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `basic_rate`
--

DROP TABLE IF EXISTS `basic_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basic_rate` (
  `locale` char(2) NOT NULL,
  `currency` char(3) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `symbol` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`locale`),
  UNIQUE KEY `currency` (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `sort_order` bigint(20) NOT NULL,
  `enabled` tinyint(4) NOT NULL,
  `country_flag_type` tinyint(4) NOT NULL,
  `new_flag` tinyint(4) NOT NULL,
  `last_editor` varchar(20) NOT NULL,
  `last_edit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000074 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_attribute`
--

DROP TABLE IF EXISTS `category_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_attribute` (
  `category_id` bigint(20) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`category_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_country_flag`
--

DROP TABLE IF EXISTS `category_country_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_country_flag` (
  `category_id` bigint(20) NOT NULL,
  `country` char(2) NOT NULL,
  PRIMARY KEY (`category_id`,`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_flag`
--

DROP TABLE IF EXISTS `category_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_flag` (
  `category_id` bigint(20) NOT NULL,
  `flag` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`,`flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_image`
--

DROP TABLE IF EXISTS `category_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_image` (
  `category_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `device_type` varchar(20) NOT NULL DEFAULT '',
  `image_binary` blob NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_list`
--

DROP TABLE IF EXISTS `category_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_list` (
  `category_list_id` int(11) NOT NULL,
  `key` varchar(32) NOT NULL,
  PRIMARY KEY (`category_list_id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_list_category`
--

DROP TABLE IF EXISTS `category_list_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_list_category` (
  `category_list_id` int(11) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `sort_order` bigint(20) NOT NULL,
  PRIMARY KEY (`category_list_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_name`
--

DROP TABLE IF EXISTS `category_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_name` (
  `category_id` bigint(11) NOT NULL,
  `language` varchar(20) NOT NULL,
  `category_name` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`category_id`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_product`
--

DROP TABLE IF EXISTS `category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_product` (
  `category_id` bigint(20) NOT NULL,
  `package_id` bigint(20) NOT NULL,
  PRIMARY KEY (`category_id`,`package_id`),
  KEY `ix_package_id` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_ui_definition`
--

DROP TABLE IF EXISTS `cms_ui_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_ui_definition` (
  `ui_name` varchar(45) NOT NULL,
  `language` varchar(5) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `label` varchar(45) NOT NULL DEFAULT '',
  `sort_order` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ui_name`,`language`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries_popular_list_ranked_regionally`
--

DROP TABLE IF EXISTS `countries_popular_list_ranked_regionally`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries_popular_list_ranked_regionally` (
  `country` char(2) NOT NULL,
  `use_self_ranking` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(45) DEFAULT NULL,
  `last_update_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `new_release_ranking`
--

DROP TABLE IF EXISTS `new_release_ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `new_release_ranking` (
  `ranking` bigint(20) NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) NOT NULL,
  `category_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`package_id`),
  KEY `ix_category_id` (`category_id`),
  KEY `IX_ranking` (`ranking`)
) ENGINE=InnoDB AUTO_INCREMENT=272715 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_app_store_order`
--

DROP TABLE IF EXISTS `org_app_store_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_app_store_order` (
  `confirm_id` bigint(20) NOT NULL,
  `org_app_store_order_no` varchar(50) NOT NULL,
  `org_app_store_order_date` timestamp NULL DEFAULT NULL,
  `user_hash` char(32) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`confirm_id`),
  KEY `ix_org_app_store_order_no` (`org_app_store_order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `popular_ranking`
--

DROP TABLE IF EXISTS `popular_ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popular_ranking` (
  `ranking` bigint(20) NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) NOT NULL,
  `category_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ranking`),
  UNIQUE KEY `package_id_UNIQUE` (`package_id`),
  KEY `ix_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=378023 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `popular_ranking_by_country`
--

DROP TABLE IF EXISTS `popular_ranking_by_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popular_ranking_by_country` (
  `ranking` bigint(20) NOT NULL,
  `package_id` bigint(11) NOT NULL,
  `country` char(2) NOT NULL,
  `category_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ranking`,`country`),
  UNIQUE KEY `uix_package_id_country_UNIQUE` (`package_id`,`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `popup_product_image`
--

DROP TABLE IF EXISTS `popup_product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popup_product_image` (
  `package_id` bigint(11) NOT NULL,
  `width` smallint(5) unsigned NOT NULL,
  `height` smallint(5) unsigned NOT NULL,
  `valign` enum('TOP','CENTER','BOTTOM') NOT NULL,
  `scale_type` enum('FIT','FILL','NONE') NOT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `popup_product_image_history`
--

DROP TABLE IF EXISTS `popup_product_image_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popup_product_image_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) NOT NULL,
  `width` smallint(5) unsigned NOT NULL,
  `height` smallint(5) unsigned NOT NULL,
  `valign` enum('TOP','CENTER','BOTTOM') NOT NULL,
  `scale_type` enum('FIT','FILL','NONE') NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `idx_package_id` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `popup_sticker_image`
--

DROP TABLE IF EXISTS `popup_sticker_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popup_sticker_image` (
  `sticker_id` bigint(20) NOT NULL,
  `width` smallint(5) unsigned NOT NULL,
  `height` smallint(5) unsigned NOT NULL,
  `valign` enum('TOP','CENTER','BOTTOM') NOT NULL,
  `scale_type` enum('FIT','FILL','NONE') NOT NULL,
  PRIMARY KEY (`sticker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `popup_sticker_image_history`
--

DROP TABLE IF EXISTS `popup_sticker_image_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popup_sticker_image_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `sticker_id` bigint(20) NOT NULL,
  `width` smallint(5) unsigned NOT NULL,
  `height` smallint(5) unsigned NOT NULL,
  `valign` enum('TOP','CENTER','BOTTOM') NOT NULL,
  `scale_type` enum('FIT','FILL','NONE') NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `idx_sticker_id` (`sticker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3689 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `price_tier`
--

DROP TABLE IF EXISTS `price_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_tier` (
  `tier` int(11) NOT NULL,
  `country` char(2) NOT NULL,
  `currency` char(3) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  PRIMARY KEY (`country`,`tier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `package_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` varchar(20) NOT NULL DEFAULT '',
  `billing_cpid` varchar(10) NOT NULL DEFAULT 'st_shop',
  `channel_id` varchar(45) DEFAULT NULL,
  `author_id` bigint(11) NOT NULL,
  `publish_since` timestamp NULL DEFAULT NULL,
  `publish_until` timestamp NULL DEFAULT NULL,
  `on_sale` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'on sale = 1, not = 0 ',
  `default_title` varchar(200) DEFAULT NULL,
  `default_description` text,
  `price_tier` int(11) DEFAULT NULL,
  `last_editor` varchar(20) DEFAULT NULL,
  `last_edit_date` timestamp NULL DEFAULT NULL,
  `tags` varchar(200) DEFAULT NULL,
  `category_id` bigint(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `valid_days` int(11) DEFAULT NULL,
  `sale_type` int(11) NOT NULL DEFAULT '0',
  `copy_right` varchar(100) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `current_editor` varchar(20) DEFAULT NULL,
  `sale_area_type` int(11) NOT NULL DEFAULT '0',
  `event_type` int(11) NOT NULL DEFAULT '0',
  `new_flag` tinyint(1) NOT NULL DEFAULT '0',
  `stage_flag` int(11) NOT NULL DEFAULT '0',
  `dummy_flag` int(11) NOT NULL DEFAULT '0',
  `available_for_present` tinyint(1) NOT NULL DEFAULT '1',
  `available_for_myself` tinyint(1) NOT NULL DEFAULT '1',
  `has_animation` tinyint(4) DEFAULT '0',
  `has_sound` tinyint(4) DEFAULT '0',
  `has_popup` tinyint(1) NOT NULL DEFAULT '0',
  `subtype` int(11) NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`package_id`),
  KEY `ix_onsale_subtype` (`on_sale`,`subtype`),
  KEY `ix_packageid` (`package_id`,`on_sale`,`price_tier`,`sale_area_type`),
  KEY `ix_authorid` (`author_id`,`on_sale`,`publish_since`)
) ENGINE=InnoDB AUTO_INCREMENT=2000040 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_access_permission`
--

DROP TABLE IF EXISTS `product_access_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_access_permission` (
  `package_id` bigint(11) NOT NULL,
  `permission_info` varchar(100) NOT NULL,
  `permission_type` varchar(20) NOT NULL,
  PRIMARY KEY (`package_id`,`permission_info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_deployment_log`
--

DROP TABLE IF EXISTS `product_deployment_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_deployment_log` (
  `product_id` varchar(20) NOT NULL,
  `deployment_status` varchar(100) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`,`deployment_status`,`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_event`
--

DROP TABLE IF EXISTS `product_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_event` (
  `package_id` bigint(11) NOT NULL,
  `data_name` varchar(50) NOT NULL,
  `data_value` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`package_id`,`data_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_event_history`
--

DROP TABLE IF EXISTS `product_event_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_event_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) NOT NULL,
  `data_name` varchar(50) NOT NULL,
  `data_value` varchar(2000) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47057 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_flag`
--

DROP TABLE IF EXISTS `product_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_flag` (
  `package_id` bigint(11) NOT NULL,
  `flg_name` varchar(100) NOT NULL,
  PRIMARY KEY (`package_id`,`flg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_history`
--

DROP TABLE IF EXISTS `product_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) DEFAULT NULL,
  `product_id` varchar(20) NOT NULL,
  `billing_cpid` varchar(10) DEFAULT NULL,
  `channel_id` varchar(45) DEFAULT NULL,
  `author_id` bigint(11) DEFAULT NULL,
  `publish_since` timestamp NULL DEFAULT NULL,
  `publish_until` timestamp NULL DEFAULT NULL,
  `on_sale` tinyint(1) DEFAULT '0',
  `default_title` varchar(200) DEFAULT NULL,
  `default_description` text,
  `price_tier` int(11) DEFAULT NULL,
  `last_editor` varchar(20) DEFAULT NULL,
  `last_edit_date` timestamp NULL DEFAULT NULL,
  `tags` varchar(200) DEFAULT NULL,
  `category_id` bigint(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `valid_days` int(11) DEFAULT NULL,
  `sale_type` int(11) NOT NULL DEFAULT '0',
  `copy_right` varchar(100) DEFAULT NULL,
  `sale_area_type` int(11) NOT NULL DEFAULT '0',
  `event_type` int(11) NOT NULL DEFAULT '0',
  `new_flag` tinyint(1) DEFAULT '0',
  `stage_flag` int(11) NOT NULL DEFAULT '0',
  `dummy_flag` int(11) NOT NULL DEFAULT '0',
  `available_for_present` tinyint(1) DEFAULT NULL,
  `available_for_myself` tinyint(1) DEFAULT NULL,
  `has_animation` tinyint(4) DEFAULT '0',
  `has_sound` tinyint(4) DEFAULT '0',
  `has_popup` tinyint(1) NOT NULL DEFAULT '0',
  `subtype` int(11) DEFAULT NULL,
  `published` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `ix_package_id_on_sale` (`package_id`,`on_sale`),
  KEY `ix_product_id_package_id` (`product_id`,`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2740980 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_image` (
  `package_id` bigint(11) NOT NULL,
  `device_type` varchar(20) NOT NULL,
  `image_type` varchar(20) NOT NULL,
  `suffix` varchar(10) NOT NULL DEFAULT 'png',
  PRIMARY KEY (`package_id`,`device_type`,`image_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_image_history`
--

DROP TABLE IF EXISTS `product_image_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_image_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) NOT NULL,
  `device_type` varchar(20) NOT NULL,
  `image_type` varchar(20) NOT NULL,
  `suffix` varchar(10) DEFAULT 'png',
  `version` bigint(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2962292 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_keywords`
--

DROP TABLE IF EXISTS `product_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_keywords` (
  `package_id` bigint(20) NOT NULL,
  `language` varchar(20) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`package_id`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_locale_name`
--

DROP TABLE IF EXISTS `product_locale_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_locale_name` (
  `package_id` bigint(11) NOT NULL,
  `language` varchar(20) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL,
  `description` text,
  PRIMARY KEY (`package_id`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_locale_name_history`
--

DROP TABLE IF EXISTS `product_locale_name_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_locale_name_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) NOT NULL,
  `language` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8687253 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_locale_price`
--

DROP TABLE IF EXISTS `product_locale_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_locale_price` (
  `package_id` bigint(11) NOT NULL,
  `locale` char(2) NOT NULL,
  `currency` char(3) NOT NULL,
  `symbol` varchar(10) NOT NULL DEFAULT '￥',
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`package_id`,`locale`,`currency`),
  KEY `ix_package_id_currency` (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_locale_price_history`
--

DROP TABLE IF EXISTS `product_locale_price_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_locale_price_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint(11) NOT NULL,
  `locale` char(2) NOT NULL,
  `currency` char(3) NOT NULL,
  `symbol` varchar(10) NOT NULL DEFAULT '￥',
  `price` decimal(10,2) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15811805 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_sales`
--

DROP TABLE IF EXISTS `product_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_sales` (
  `aggregate_datetime` datetime NOT NULL,
  `package_id` bigint(11) NOT NULL,
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aggregate_datetime`,`package_id`),
  KEY `ix_package_id` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_sales_by_country`
--

DROP TABLE IF EXISTS `product_sales_by_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_sales_by_country` (
  `aggregate_datetime` datetime NOT NULL,
  `package_id` bigint(11) NOT NULL,
  `country` varchar(2) NOT NULL,
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aggregate_datetime`,`package_id`,`country`),
  KEY `ix_country_package_id` (`country`,`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ranking_weight`
--

DROP TABLE IF EXISTS `ranking_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ranking_weight` (
  `package_id` bigint(20) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ranking_weight_by_country`
--

DROP TABLE IF EXISTS `ranking_weight_by_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ranking_weight_by_country` (
  `package_id` bigint(20) NOT NULL,
  `country` char(2) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`package_id`,`country`),
  UNIQUE KEY `ix_country_package_id` (`country`,`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sale_area`
--

DROP TABLE IF EXISTS `sale_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_area` (
  `package_id` bigint(11) NOT NULL,
  `locale` char(2) NOT NULL,
  PRIMARY KEY (`package_id`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serial_fail`
--

DROP TABLE IF EXISTS `serial_fail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serial_fail` (
  `user_hash` char(32) NOT NULL,
  `count` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`user_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serial_set_name`
--

DROP TABLE IF EXISTS `serial_set_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serial_set_name` (
  `serial_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `status` int(1) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `serial_record_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`serial_set_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serial_set_number`
--

DROP TABLE IF EXISTS `serial_set_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serial_set_number` (
  `serial_set_id` int(11) NOT NULL,
  `serial_number` varchar(32) NOT NULL,
  `consume_user_hash` char(32) DEFAULT NULL,
  `order_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`serial_set_id`,`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sticker_image`
--

DROP TABLE IF EXISTS `sticker_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sticker_image` (
  `sticker_id` bigint(20) NOT NULL,
  `device_type` varchar(20) NOT NULL,
  `is_key` tinyint(1) NOT NULL,
  `package_id` bigint(11) NOT NULL,
  `width` int(4) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `width_tmp` int(4) DEFAULT NULL,
  `height_tmp` int(4) DEFAULT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`sticker_id`,`device_type`,`is_key`),
  KEY `ix_package_id` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sticker_image_history`
--

DROP TABLE IF EXISTS `sticker_image_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sticker_image_history` (
  `history_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `sticker_id` bigint(20) NOT NULL,
  `device_type` varchar(20) NOT NULL,
  `is_key` tinyint(1) DEFAULT NULL,
  `width` int(4) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `image_binary` longblob,
  `package_id` bigint(11) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `suffix` varchar(10) NOT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6080940 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sticker_products_sales_stats`
--

DROP TABLE IF EXISTS `sticker_products_sales_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sticker_products_sales_stats` (
  `aggregate_datetime` datetime NOT NULL,
  `package_id` bigint(11) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aggregate_datetime`,`package_id`,`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stickershop_sequence`
--

DROP TABLE IF EXISTS `stickershop_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stickershop_sequence` (
  `sequence_name` varchar(50) NOT NULL DEFAULT '',
  `next_val` bigint(20) NOT NULL,
  PRIMARY KEY (`sequence_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `sort_order` bigint(20) NOT NULL,
  `display_status` enum('DISABLED','DISPLAY_CREATORS','DISPLAY_SHOP') DEFAULT NULL,
  `tag_type` enum('CHARACTER','TASTE') DEFAULT NULL,
  `last_editor` varchar(20) NOT NULL,
  `last_edit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag_name`
--

DROP TABLE IF EXISTS `tag_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_name` (
  `tag_id` bigint(11) NOT NULL,
  `language` varchar(20) NOT NULL,
  `tag_name` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`tag_id`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag_product`
--

DROP TABLE IF EXISTS `tag_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_product` (
  `tag_id` bigint(20) NOT NULL,
  `package_id` bigint(20) NOT NULL,
  PRIMARY KEY (`tag_id`,`package_id`),
  KEY `package_id` (`package_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `update_download_error`
--

DROP TABLE IF EXISTS `update_download_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update_download_error` (
  `seq` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_hash` varchar(32) NOT NULL,
  `package_id` bigint(11) NOT NULL,
  `download_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_updated` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`seq`),
  UNIQUE KEY `ix_user_hash_package_id` (`user_hash`,`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_mission`
--

DROP TABLE IF EXISTS `user_mission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_mission` (
  `user_hash` char(32) NOT NULL DEFAULT '',
  `package_id` bigint(20) NOT NULL,
  `channel_id` varchar(32) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_hash`,`package_id`,`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'talk_stickershop'
--
