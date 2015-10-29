-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: asset
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-11 16:02:25
CREATE DATABASE  IF NOT EXISTS `fitman` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `fitman`;
-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: fitman
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookmarksentry`
--

DROP TABLE IF EXISTS `bookmarksentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarksentry` (
  `uuid_` varchar(75) DEFAULT NULL,
  `entryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `resourceBlockId` bigint(20) DEFAULT NULL,
  `folderId` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` longtext,
  `description` longtext,
  `visits` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`entryId`),
  UNIQUE KEY `IX_EAA02A91` (`uuid_`,`groupId`),
  KEY `IX_E52FF7EF` (`groupId`),
  KEY `IX_5200100C` (`groupId`,`folderId`),
  KEY `IX_E2E9F129` (`groupId`,`userId`),
  KEY `IX_E848278F` (`resourceBlockId`),
  KEY `IX_B670BA39` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarksentry`
--

LOCK TABLES `bookmarksentry` WRITE;
/*!40000 ALTER TABLE `bookmarksentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmarksentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layoutsetbranch`
--

DROP TABLE IF EXISTS `layoutsetbranch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layoutsetbranch` (
  `layoutSetBranchId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `privateLayout` tinyint(4) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `master` tinyint(4) DEFAULT NULL,
  `logo` tinyint(4) DEFAULT NULL,
  `logoId` bigint(20) DEFAULT NULL,
  `themeId` varchar(75) DEFAULT NULL,
  `colorSchemeId` varchar(75) DEFAULT NULL,
  `wapThemeId` varchar(75) DEFAULT NULL,
  `wapColorSchemeId` varchar(75) DEFAULT NULL,
  `css` longtext,
  `settings_` longtext,
  `layoutSetPrototypeUuid` varchar(75) DEFAULT NULL,
  `layoutSetPrototypeLinkEnabled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`layoutSetBranchId`),
  UNIQUE KEY `IX_5FF18552` (`groupId`,`privateLayout`,`name`),
  KEY `IX_8FF5D6EA` (`groupId`),
  KEY `IX_C4079FD3` (`groupId`,`privateLayout`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layoutsetbranch`
--

LOCK TABLES `layoutsetbranch` WRITE;
/*!40000 ALTER TABLE `layoutsetbranch` DISABLE KEYS */;
/*!40000 ALTER TABLE `layoutsetbranch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdrrulegroupinstance`
--

DROP TABLE IF EXISTS `mdrrulegroupinstance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdrrulegroupinstance` (
  `uuid_` varchar(75) DEFAULT NULL,
  `ruleGroupInstanceId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `ruleGroupId` bigint(20) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`ruleGroupInstanceId`),
  UNIQUE KEY `IX_808A0036` (`classNameId`,`classPK`,`ruleGroupId`),
  UNIQUE KEY `IX_9CBC6A39` (`uuid_`,`groupId`),
  KEY `IX_C95A08D8` (`classNameId`,`classPK`),
  KEY `IX_AFF28547` (`groupId`),
  KEY `IX_22DAB85C` (`groupId`,`classNameId`,`classPK`),
  KEY `IX_BF3E642B` (`ruleGroupId`),
  KEY `IX_B6A6BD91` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdrrulegroupinstance`
--

LOCK TABLES `mdrrulegroupinstance` WRITE;
/*!40000 ALTER TABLE `mdrrulegroupinstance` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdrrulegroupinstance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmarksfolder`
--

DROP TABLE IF EXISTS `bookmarksfolder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarksfolder` (
  `uuid_` varchar(75) DEFAULT NULL,
  `folderId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `resourceBlockId` bigint(20) DEFAULT NULL,
  `parentFolderId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`folderId`),
  UNIQUE KEY `IX_DC2F8927` (`uuid_`,`groupId`),
  KEY `IX_2ABA25D7` (`companyId`),
  KEY `IX_7F703619` (`groupId`),
  KEY `IX_967799C0` (`groupId`,`parentFolderId`),
  KEY `IX_28A49BB9` (`resourceBlockId`),
  KEY `IX_451E7AE3` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarksfolder`
--

LOCK TABLES `bookmarksfolder` WRITE;
/*!40000 ALTER TABLE `bookmarksfolder` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmarksfolder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbdiscussion`
--

DROP TABLE IF EXISTS `mbdiscussion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbdiscussion` (
  `discussionId` bigint(20) NOT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `threadId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`discussionId`),
  UNIQUE KEY `IX_33A4DE38` (`classNameId`,`classPK`),
  UNIQUE KEY `IX_B5CA2DC` (`threadId`),
  KEY `IX_79D0120B` (`classNameId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbdiscussion`
--

LOCK TABLES `mbdiscussion` WRITE;
/*!40000 ALTER TABLE `mbdiscussion` DISABLE KEYS */;
INSERT INTO `mbdiscussion` VALUES (10178,10002,10174,10176),(10318,10002,10313,10315),(10327,10002,10323,10325),(10336,10002,10332,10334),(10350,10002,10346,10348),(10356,10002,10352,10354),(10362,10002,10358,10360),(10376,10002,10372,10374),(10384,10002,10380,10382),(10390,10002,10386,10388),(10396,10002,10392,10394),(10430,10010,10419,10428),(10440,10010,10433,10438),(10450,10010,10444,10448),(10459,10010,10452,10457),(10475,10010,10465,10473),(10487,10010,10477,10485),(10499,10010,10493,10497),(10511,10010,10505,10509),(10527,10010,10517,10525),(10539,10010,10530,10537),(10551,10010,10542,10549),(10563,10010,10553,10561),(10575,10010,10566,10573),(10588,10108,10582,10586),(10602,10108,10596,10600),(10610,10108,10604,10608),(10615,10002,10611,10613),(18110,10002,18106,18108),(11506,10002,11502,11504),(18115,10002,18111,18113),(11619,10010,11613,11617),(11627,10010,11621,11625),(11636,10010,11630,11634),(11644,10010,11638,11642),(11655,10010,11646,11652),(11667,10010,11658,11662),(11675,10010,11669,11673),(11709,10108,11703,11707),(11723,10108,11717,11721),(11731,10108,11725,11729),(11739,10108,11733,11737),(11750,10108,11744,11748),(11763,10108,11755,11761),(11778,10108,11772,11776),(11783,10002,11779,11781),(11811,10108,11805,11809),(12115,10002,12111,12113),(12120,10002,12116,12118),(13125,10010,13119,13123),(13142,10010,13136,13140),(13158,10010,13152,13156),(13178,10108,13172,13176),(13193,10010,13187,13191),(13282,10010,13276,13280),(18307,10010,18301,18305),(13316,10108,13310,13314),(13353,10010,13347,13351),(14105,10002,14101,14103),(15228,10108,15222,15226),(15238,10108,15232,15236),(15248,10108,15242,15246),(15258,10108,15252,15256),(18105,10002,18101,18103),(15304,10010,15298,15302),(15319,10108,15313,15317),(15329,10108,15323,15327),(15339,10108,15333,15337),(15349,10108,15343,15347),(15359,10108,15353,15357),(15369,10108,15363,15367),(15381,10108,15375,15379),(15391,10108,15385,15389),(15406,10108,15400,15404),(16321,10002,16317,16319),(16326,10002,16322,16324),(16415,10002,16411,16413),(16420,10002,16416,16418),(16435,10002,16431,16433),(16440,10002,16436,16438),(16455,10002,16451,16453),(16460,10002,16456,16458),(16475,10002,16471,16473),(16480,10002,16476,16478),(16486,10002,16482,16484),(16491,10002,16487,16489);
/*!40000 ALTER TABLE `mbdiscussion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_`
--

DROP TABLE IF EXISTS `resource_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_` (
  `resourceId` bigint(20) NOT NULL,
  `codeId` bigint(20) DEFAULT NULL,
  `primKey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`resourceId`),
  UNIQUE KEY `IX_67DE7856` (`codeId`,`primKey`),
  KEY `IX_2578FBD3` (`codeId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_`
--

LOCK TABLES `resource_` WRITE;
/*!40000 ALTER TABLE `resource_` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_usergroups`
--

DROP TABLE IF EXISTS `users_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_usergroups` (
  `userGroupId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY (`userGroupId`,`userId`),
  KEY `IX_66FF2503` (`userGroupId`),
  KEY `IX_BE8102D6` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_usergroups`
--

LOCK TABLES `users_usergroups` WRITE;
/*!40000 ALTER TABLE `users_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratingsstats`
--

DROP TABLE IF EXISTS `ratingsstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratingsstats` (
  `statsId` bigint(20) NOT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `totalEntries` int(11) DEFAULT NULL,
  `totalScore` double DEFAULT NULL,
  `averageScore` double DEFAULT NULL,
  PRIMARY KEY (`statsId`),
  UNIQUE KEY `IX_A6E99284` (`classNameId`,`classPK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratingsstats`
--

LOCK TABLES `ratingsstats` WRITE;
/*!40000 ALTER TABLE `ratingsstats` DISABLE KEYS */;
INSERT INTO `ratingsstats` VALUES (17806,10010,13119,0,0,0);
/*!40000 ALTER TABLE `ratingsstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_orgs`
--

DROP TABLE IF EXISTS `users_orgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_orgs` (
  `userId` bigint(20) NOT NULL,
  `organizationId` bigint(20) NOT NULL,
  PRIMARY KEY (`userId`,`organizationId`),
  KEY `IX_7EF4EC0E` (`organizationId`),
  KEY `IX_FB646CA6` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_orgs`
--

LOCK TABLES `users_orgs` WRITE;
/*!40000 ALTER TABLE `users_orgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_orgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pollsquestion`
--

DROP TABLE IF EXISTS `pollsquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pollsquestion` (
  `uuid_` varchar(75) DEFAULT NULL,
  `questionId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `title` longtext,
  `description` longtext,
  `expirationDate` datetime DEFAULT NULL,
  `lastVoteDate` datetime DEFAULT NULL,
  PRIMARY KEY (`questionId`),
  UNIQUE KEY `IX_F3C9F36` (`uuid_`,`groupId`),
  KEY `IX_9FF342EA` (`groupId`),
  KEY `IX_51F087F4` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pollsquestion`
--

LOCK TABLES `pollsquestion` WRITE;
/*!40000 ALTER TABLE `pollsquestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `pollsquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `browsertracker`
--

DROP TABLE IF EXISTS `browsertracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `browsertracker` (
  `browserTrackerId` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `browserKey` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`browserTrackerId`),
  UNIQUE KEY `IX_E7B95510` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `browsertracker`
--

LOCK TABLES `browsertracker` WRITE;
/*!40000 ALTER TABLE `browsertracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `browsertracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scframeworkversi_scproductvers`
--

DROP TABLE IF EXISTS `scframeworkversi_scproductvers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scframeworkversi_scproductvers` (
  `frameworkVersionId` bigint(20) NOT NULL,
  `productVersionId` bigint(20) NOT NULL,
  PRIMARY KEY (`frameworkVersionId`,`productVersionId`),
  KEY `IX_3BB93ECA` (`frameworkVersionId`),
  KEY `IX_E8D33FF9` (`productVersionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scframeworkversi_scproductvers`
--

LOCK TABLES `scframeworkversi_scproductvers` WRITE;
/*!40000 ALTER TABLE `scframeworkversi_scproductvers` DISABLE KEYS */;
/*!40000 ALTER TABLE `scframeworkversi_scproductvers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout`
--

DROP TABLE IF EXISTS `layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layout` (
  `uuid_` varchar(75) DEFAULT NULL,
  `plid` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `privateLayout` tinyint(4) DEFAULT NULL,
  `layoutId` bigint(20) DEFAULT NULL,
  `parentLayoutId` bigint(20) DEFAULT NULL,
  `name` longtext,
  `title` longtext,
  `description` longtext,
  `keywords` longtext,
  `robots` longtext,
  `type_` varchar(75) DEFAULT NULL,
  `typeSettings` longtext,
  `hidden_` tinyint(4) DEFAULT NULL,
  `friendlyURL` varchar(255) DEFAULT NULL,
  `iconImage` tinyint(4) DEFAULT NULL,
  `iconImageId` bigint(20) DEFAULT NULL,
  `themeId` varchar(75) DEFAULT NULL,
  `colorSchemeId` varchar(75) DEFAULT NULL,
  `wapThemeId` varchar(75) DEFAULT NULL,
  `wapColorSchemeId` varchar(75) DEFAULT NULL,
  `css` longtext,
  `priority` int(11) DEFAULT NULL,
  `layoutPrototypeUuid` varchar(75) DEFAULT NULL,
  `layoutPrototypeLinkEnabled` tinyint(4) DEFAULT NULL,
  `sourcePrototypeLayoutUuid` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`plid`),
  UNIQUE KEY `IX_BC2C4231` (`groupId`,`privateLayout`,`friendlyURL`),
  UNIQUE KEY `IX_7162C27C` (`groupId`,`privateLayout`,`layoutId`),
  UNIQUE KEY `IX_CED31606` (`uuid_`,`groupId`),
  KEY `IX_C7FBC998` (`companyId`),
  KEY `IX_C099D61A` (`groupId`),
  KEY `IX_705F5AA3` (`groupId`,`privateLayout`),
  KEY `IX_6DE88B06` (`groupId`,`privateLayout`,`parentLayoutId`),
  KEY `IX_8CE8C0D9` (`groupId`,`privateLayout`,`sourcePrototypeLayoutUuid`),
  KEY `IX_1A1B61D2` (`groupId`,`privateLayout`,`type_`),
  KEY `IX_23922F7D` (`iconImageId`),
  KEY `IX_B529BFD3` (`layoutPrototypeUuid`),
  KEY `IX_D0822724` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout`
--

LOCK TABLES `layout` WRITE;
/*!40000 ALTER TABLE `layout` DISABLE KEYS */;
INSERT INTO `layout` VALUES ('ec151719-ef6f-41cf-a536-24b676bd95c6',10174,10171,10153,'2012-09-10 08:56:28','2012-09-10 08:56:28',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Control Panel</Name></root>','','','','','control_panel','',0,'/manage',0,0,'','','','','',0,'',0,''),('7edfca60-0bfe-4b70-9fad-f17d8ec97d9a',10313,10310,10153,'2012-09-10 08:56:38','2012-09-10 08:56:38',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Blog</Name></root>','','','','','portlet','layout-template-id=2_columns_iii\ncolumn-2=148_INSTANCE_09Cw8dOe6ahN,114,\ncolumn-1=33,',0,'/layout',0,0,'','','','','',0,'',0,''),('f6e073b6-c347-4f3b-a9e0-285508085422',10323,10320,10153,'2012-09-10 08:56:39','2012-09-10 08:56:39',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Content Display Page</Name></root>','','','','','portlet','default-asset-publisher-portlet-id=101_INSTANCE_Bc4wRUvzfejz\nlayout-template-id=2_columns_ii\ncolumn-2=3,101_INSTANCE_Bc4wRUvzfejz,\ncolumn-1=141_INSTANCE_xcONX87j3IcH,122_INSTANCE_e1Lv45aLNVTw,',0,'/layout',0,0,'','','','','',0,'',0,''),('1190f260-ece2-442d-b56c-a19cb60b6670',10332,10329,10153,'2012-09-10 08:56:39','2012-09-10 08:56:40',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Wiki</Name></root>','','','','','portlet','layout-template-id=2_columns_iii\ncolumn-2=122_INSTANCE_4P3b9TD49dbc,141_INSTANCE_A0YMQ8tReclT,\ncolumn-1=36,',0,'/layout',0,0,'','','','','',0,'',0,''),('d23bf6ba-354c-4253-b752-3438f5c1f501',10346,10338,10153,'2012-09-10 08:56:45','2012-09-10 08:56:45',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Home</Name></root>','','','','','portlet','layout-template-id=2_columns_iii\ncolumn-2=3,59_INSTANCE_S8bG0X5Iao4q,180,\ncolumn-1=19,',0,'/home',0,0,'','','','','',0,'',0,''),('ea0e74b9-9cf5-4b79-8fe8-b945943cc8d3',10352,10338,10153,'2012-09-10 08:56:45','2012-09-10 08:56:45',1,2,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Calendar</Name></root>','','','','','portlet','layout-template-id=2_columns_iii\ncolumn-2=101_INSTANCE_kHMCf5UxnMQo,\ncolumn-1=8,',0,'/calendar',0,0,'','','','','',1,'',0,''),('710635be-5949-4a62-a624-188d1c94f69d',10358,10338,10153,'2012-09-10 08:56:45','2012-09-10 08:56:45',1,3,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Wiki</Name></root>','','','','','portlet','layout-template-id=2_columns_iii\ncolumn-2=122_INSTANCE_7VRZYDPpWwYx,148_INSTANCE_srr4NksaMm9u,\ncolumn-1=36,',0,'/wiki',0,0,'','','','','',2,'',0,''),('5bf9ed55-906c-4adf-b968-d43b9135a7a5',10372,10364,10153,'2012-09-10 08:56:46','2012-09-10 08:56:46',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Home</Name></root>','','','','','portlet','layout-template-id=2_columns_i\ncolumn-2=3,82,101_INSTANCE_q0npoXTagYSA,\ncolumn-1=116,',0,'/home',0,0,'','','','','',0,'',0,''),('5847b05b-fc82-4c8e-9c67-e4a8172b5f48',10380,10364,10153,'2012-09-10 08:56:46','2012-09-10 08:56:46',1,2,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Documents and Media</Name></root>','','','','','portlet','layout-template-id=1_column\ncolumn-1=20,',0,'/documents',0,0,'','','','','',1,'',0,''),('1423864f-18c8-49ed-b171-633ecbff78a7',10386,10364,10153,'2012-09-10 08:56:46','2012-09-10 08:56:46',1,3,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Calendar</Name></root>','','','','','portlet','layout-template-id=2_columns_iii\ncolumn-2=101_INSTANCE_5H5pmfQIY2uX,\ncolumn-1=8,',0,'/calendar',0,0,'','','','','',2,'',0,''),('3e09c0f1-e735-412c-a5ed-7e58f474b69c',10392,10364,10153,'2012-09-10 08:56:46','2012-09-10 08:56:46',1,4,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">News</Name></root>','','','','','portlet','layout-template-id=2_columns_iii\ncolumn-2=39_INSTANCE_qtfkHRhc3UFs,\ncolumn-1=39_INSTANCE_f7mpMOkPEN2r,',0,'/news',0,0,'','','','','',3,'',0,''),('3db132ff-d108-4ec3-8fcc-5a182142a0cc',10611,10179,10153,'2012-09-10 08:57:01','2014-01-03 09:33:02',0,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Home</Name></root>','','','','','portlet','column-3-customizable=false\nsitemap-changefreq=daily\nlayout-template-id=1_2_1_columns\nshow-alternate-links=true\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-4-customizable=false\ncolumn-1-customizable=false\nurl=http://ecrn.eng.it:8180/openrdf-workbench\ncolumn-1=56_INSTANCE_TO4ossIXPkhm,\n',0,'/fitman-home',0,0,'FITMAN_Theme_WAR_FITMAN_Themetheme','01','classic','','',0,'',0,''),('57710aac-eb13-4060-b25c-ec3b944dd2a9',18101,10179,10153,'2014-01-03 11:21:41','2014-01-31 15:21:06',0,37,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Asset</Name></root>','','','','','portlet','sitemap-changefreq=daily\nshow-alternate-links=true\nlayout-template-id=1_column\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-1-customizable=false\ncolumn-1=Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_Ub0mcEGAEtTs\n',0,'/asset',0,0,'FITMAN_Theme_WAR_FITMAN_Themetheme','01','classic','','',3,'',0,''),('b84c9a09-237d-46a5-bc99-f79ac413e014',11502,10179,10153,'2012-09-26 09:52:15','2013-12-16 13:51:41',0,7,26,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Idea Management</Name></root>','','','','','url','sitemap-changefreq=daily\nlayout-template-id=2_columns_ii\nshow-alternate-links=true\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-1-customizable=false\nurl=http://localhost:8080/ipms/?q=user/logout\n',1,'/idea-management',0,0,'classic','','classic','','',0,'',0,''),('9c68d913-05a6-48ca-8ac1-1a04f63901b2',11779,11605,10153,'2012-09-26 15:45:47','2012-09-26 15:45:47',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Home</Name></root>','','','','','portlet','layout-template-id=2_columns_ii',0,'/home',0,0,'','','','','',0,'',0,''),('fde5489f-4ef6-4007-81df-95aba20f2198',12111,12104,10153,'2012-10-04 14:56:41','2013-09-27 17:31:58',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688,OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021,OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6\ncolumn-1=OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0,OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95,\n',0,'/home',0,0,'','','','','',0,'',0,''),('19231450-ca07-4acb-b327-7cdaad3a0641',12116,12104,10153,'2012-10-04 14:56:41','2013-09-27 12:54:46',0,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=33,\ncolumn-1=82,3,\n',0,'/home',0,0,'','','','','',0,'',0,''),('b00598cc-c0f8-4378-9d3a-40bbc2495cb1',14101,10179,10153,'2013-04-03 10:51:46','2014-01-03 11:24:00',0,13,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Compel</Name></root>','','','','','portlet','sitemap-changefreq=daily\nshow-alternate-links=true\nlayout-template-id=1_column\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-1-customizable=false\ncolumn-1=48_INSTANCE_57K85xxkzz0p\n',1,'/processes',0,0,'FITMAN_Theme_WAR_FITMAN_Themetheme','01','classic','','',2,'',0,''),('477e7aaa-df79-4219-9d5c-0144c8cdb9ba',18106,10179,10153,'2014-01-03 11:22:06','2014-01-03 11:26:27',0,38,37,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Asset Repository</Name></root>','','','','','portlet','sitemap-changefreq=daily\nshow-alternate-links=true\nlayout-template-id=1_column\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-1-customizable=false\ncolumn-1=Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_HnbYWtIepvG6\n',0,'/asset-repository',0,0,'FITMAN_Theme_WAR_FITMAN_Themetheme','01','classic','','',0,'',0,''),('695a9a28-2a08-4001-b58b-23122d809104',18111,10179,10153,'2014-01-03 11:22:46','2014-01-03 14:24:37',0,39,37,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Asset as a Service</Name></root>','','','','','portlet','sitemap-changefreq=daily\nshow-alternate-links=true\nlayout-template-id=1_column\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-1-customizable=false\ncolumn-1=Asset_View_Service_WAR_Asset_Viewer_Service_Rep_INSTANCE_lnon2b9YXZh7\n',0,'/asset-as-a-service',0,0,'FITMAN_Theme_WAR_FITMAN_Themetheme','01','classic','','',1,'',0,''),('7ed62d47-21cc-4a7a-97eb-1f2027bdd901',16317,16310,10153,'2013-11-15 10:35:33','2013-11-15 10:35:33',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=29,8,\ncolumn-1=82,23,11,\n',0,'/home',0,0,'','','','','',0,'',0,''),('444bd734-55b1-4336-960c-e7142e035255',16322,16310,10153,'2013-11-15 10:35:33','2013-11-15 10:35:33',0,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=33,\ncolumn-1=82,3,\n',0,'/home',0,0,'','','','','',0,'',0,''),('b44ed160-c950-4429-915d-a01513281383',16411,16404,10153,'2013-11-18 15:32:47','2013-11-18 15:32:47',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=29,8,\ncolumn-1=82,23,11,\n',0,'/home',0,0,'','','','','',0,'',0,''),('8a8b5ee4-aa58-4f1f-9294-e5b9056d8abe',16416,16404,10153,'2013-11-18 15:32:47','2013-11-18 15:32:47',0,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=33,\ncolumn-1=82,3,\n',0,'/home',0,0,'','','','','',0,'',0,''),('de1554ad-8772-426b-a70c-55fbfe861cfd',16431,16424,10153,'2013-11-18 15:34:35','2013-11-18 15:34:35',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=29,8,\ncolumn-1=82,23,11,\n',0,'/home',0,0,'','','','','',0,'',0,''),('5a3f4941-8345-402b-a1ac-75c85f33fb79',16436,16424,10153,'2013-11-18 15:34:35','2013-11-18 15:34:35',0,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=33,\ncolumn-1=82,3,\n',0,'/home',0,0,'','','','','',0,'',0,''),('d9812b29-9ff8-46af-9a27-46591c849d11',16451,16444,10153,'2013-11-18 15:37:19','2013-11-18 15:37:19',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=29,8,\ncolumn-1=82,23,11,\n',0,'/home',0,0,'','','','','',0,'',0,''),('da55b357-8078-4210-90be-08a72d69f244',16456,16444,10153,'2013-11-18 15:37:19','2013-11-18 15:37:19',0,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=33,\ncolumn-1=82,3,\n',0,'/home',0,0,'','','','','',0,'',0,''),('e4cc4500-57a3-4509-a0d6-b72b06aaff8b',16471,16464,10153,'2013-11-18 15:39:15','2013-11-18 15:39:15',1,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=29,8,\ncolumn-1=82,23,11,\n',0,'/home',0,0,'','','','','',0,'',0,''),('89e21299-aa67-424f-a534-89b748a4e537',16476,16464,10153,'2013-11-18 15:39:15','2013-11-18 15:39:15',0,1,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\ncolumn-2=33,\ncolumn-1=82,3,\n',0,'/home',0,0,'','','','','',0,'',0,''),('ab18b266-cb96-49c0-8a7f-cb365c62aa12',16482,10179,10153,'2013-11-19 13:24:22','2013-12-16 13:51:34',0,26,0,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Innovation</Name></root>','','','','','portlet','layout-template-id=2_columns_ii\nshow-alternate-links=true\nsitemap-changefreq=daily\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-1-customizable=false\n',1,'/innovation',0,0,'classic','','classic','','',1,'',0,''),('83d6f141-447c-4e38-9cc9-7f5a6c603588',16487,10179,10153,'2013-11-19 13:25:18','2013-12-16 13:51:16',0,27,26,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Change Management</Name></root>','','','','','portlet','layout-template-id=1_column\nshow-alternate-links=true\nsitemap-changefreq=daily\nsitemap-include=1\nlayoutUpdateable=true\ncolumn-2-customizable=false\ncolumn-1-customizable=false\ncolumn-1=48_INSTANCE_C8iz5NUdy1gW\n',1,'/change-management',0,0,'classic','','classic','','',1,'',0,'');
/*!40000 ALTER TABLE `layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clustergroup`
--

DROP TABLE IF EXISTS `clustergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clustergroup` (
  `clusterGroupId` bigint(20) NOT NULL,
  `name` varchar(75) DEFAULT NULL,
  `clusterNodeIds` varchar(75) DEFAULT NULL,
  `wholeCluster` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`clusterGroupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clustergroup`
--

LOCK TABLES `clustergroup` WRITE;
/*!40000 ALTER TABLE `clustergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `clustergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_triggers`
--

DROP TABLE IF EXISTS `quartz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(20) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(20) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(20) NOT NULL,
  `END_TIME` bigint(20) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` int(11) DEFAULT NULL,
  `JOB_DATA` longblob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IX_186442A4` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IX_1BA1F9DC` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IX_91CA7CCE` (`SCHED_NAME`,`TRIGGER_GROUP`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`,`MISFIRE_INSTR`),
  KEY `IX_D219AFDE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IX_A85822A0` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IX_8AA50BE1` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IX_EEFE382A` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IX_F026CF4C` (`SCHED_NAME`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IX_F2DD7C7E` (`SCHED_NAME`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`,`MISFIRE_INSTR`),
  KEY `IX_1F92813C` (`SCHED_NAME`,`NEXT_FIRE_TIME`,`MISFIRE_INSTR`),
  KEY `IX_99108B6E` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IX_CD7132D0` (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_triggers`
--

LOCK TABLES `quartz_triggers` WRITE;
/*!40000 ALTER TABLE `quartz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingcart`
--

DROP TABLE IF EXISTS `shoppingcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingcart` (
  `cartId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `itemIds` longtext,
  `couponCodes` varchar(75) DEFAULT NULL,
  `altShipping` int(11) DEFAULT NULL,
  `insure` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`cartId`),
  UNIQUE KEY `IX_FC46FE16` (`groupId`,`userId`),
  KEY `IX_C28B41DC` (`groupId`),
  KEY `IX_54101CC8` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingcart`
--

LOCK TABLES `shoppingcart` WRITE;
/*!40000 ALTER TABLE `shoppingcart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layoutset`
--

DROP TABLE IF EXISTS `layoutset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layoutset` (
  `layoutSetId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `privateLayout` tinyint(4) DEFAULT NULL,
  `logo` tinyint(4) DEFAULT NULL,
  `logoId` bigint(20) DEFAULT NULL,
  `themeId` varchar(75) DEFAULT NULL,
  `colorSchemeId` varchar(75) DEFAULT NULL,
  `wapThemeId` varchar(75) DEFAULT NULL,
  `wapColorSchemeId` varchar(75) DEFAULT NULL,
  `css` longtext,
  `pageCount` int(11) DEFAULT NULL,
  `settings_` longtext,
  `layoutSetPrototypeUuid` varchar(75) DEFAULT NULL,
  `layoutSetPrototypeLinkEnabled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`layoutSetId`),
  UNIQUE KEY `IX_48550691` (`groupId`,`privateLayout`),
  KEY `IX_A40B8BEC` (`groupId`),
  KEY `IX_72BBA8B7` (`layoutSetPrototypeUuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layoutset`
--

LOCK TABLES `layoutset` WRITE;
/*!40000 ALTER TABLE `layoutset` DISABLE KEYS */;
INSERT INTO `layoutset` VALUES (10172,10171,10153,'2012-09-10 08:56:28','2012-09-10 08:56:28',1,0,0,'classic','01','mobile','01','',1,'','',0),(10173,10171,10153,'2012-09-10 08:56:28','2012-09-10 08:56:28',0,0,0,'classic','01','mobile','01','',0,'','',0),(10180,10179,10153,'2012-09-10 08:56:30','2012-09-10 08:56:30',1,0,0,'classic','01','mobile','01','',0,'','',0),(10181,10179,10153,'2012-09-10 08:56:30','2014-01-03 11:22:46',0,0,0,'EngBrochure_WAR_EngBrochuretheme','01','mobile','01','',8,'lfr-theme:regular:portlet-setup-show-borders-default=true\n','',0),(10189,10188,10153,'2012-09-10 08:56:31','2012-09-10 08:56:31',1,0,0,'classic','01','mobile','01','',0,'','',0),(10190,10188,10153,'2012-09-10 08:56:31','2012-09-10 08:56:31',0,0,0,'classic','01','mobile','01','',0,'','',0),(10192,10191,10153,'2012-09-10 08:56:32','2012-09-10 08:56:32',1,0,0,'classic','01','mobile','01','',0,'','',0),(10193,10191,10153,'2012-09-10 08:56:32','2012-09-10 08:56:32',0,0,0,'classic','01','mobile','01','',0,'','',0),(10311,10310,10153,'2012-09-10 08:56:38','2012-09-10 08:56:38',1,0,0,'classic','01','mobile','01','',1,'','',0),(10312,10310,10153,'2012-09-10 08:56:38','2012-09-10 08:56:38',0,0,0,'classic','01','mobile','01','',0,'','',0),(10321,10320,10153,'2012-09-10 08:56:38','2012-09-10 08:56:39',1,0,0,'classic','01','mobile','01','',1,'','',0),(10322,10320,10153,'2012-09-10 08:56:39','2012-09-10 08:56:39',0,0,0,'classic','01','mobile','01','',0,'','',0),(10330,10329,10153,'2012-09-10 08:56:39','2012-09-10 08:56:39',1,0,0,'classic','01','mobile','01','',1,'','',0),(10331,10329,10153,'2012-09-10 08:56:39','2012-09-10 08:56:39',0,0,0,'classic','01','mobile','01','',0,'','',0),(10339,10338,10153,'2012-09-10 08:56:44','2012-09-10 08:56:45',1,0,0,'classic','01','mobile','01','',3,'','',0),(10340,10338,10153,'2012-09-10 08:56:44','2012-09-10 08:56:44',0,0,0,'classic','01','mobile','01','',0,'','',0),(10365,10364,10153,'2012-09-10 08:56:45','2012-09-10 08:56:46',1,0,0,'classic','01','mobile','01','',4,'','',0),(10366,10364,10153,'2012-09-10 08:56:45','2012-09-10 08:56:45',0,0,0,'classic','01','mobile','01','',0,'','',0),(11606,11605,10153,'2012-09-26 15:45:36','2012-09-26 15:45:47',1,0,0,'EngBrochure_WAR_EngBrochuretheme','01','mobile','01','',1,'','',0),(11607,11605,10153,'2012-09-26 15:45:36','2012-09-26 15:45:36',0,0,0,'classic','01','mobile','01','',0,'','',0),(12105,12104,10153,'2012-10-04 14:55:24','2012-10-04 14:56:41',1,0,0,'classic','01','mobile','01','',1,'','',0),(12106,12104,10153,'2012-10-04 14:55:24','2012-10-04 14:56:41',0,0,0,'classic','01','mobile','01','',1,'','',0),(16311,16310,10153,'2013-11-15 10:34:11','2013-11-15 10:35:33',1,0,0,'classic','01','mobile','01','',1,'','',0),(16312,16310,10153,'2013-11-15 10:34:11','2013-11-15 10:35:33',0,0,0,'classic','01','mobile','01','',1,'','',0),(16405,16404,10153,'2013-11-18 15:32:17','2013-11-18 15:32:47',1,0,0,'classic','01','mobile','01','',1,'','',0),(16406,16404,10153,'2013-11-18 15:32:17','2013-11-18 15:32:47',0,0,0,'classic','01','mobile','01','',1,'','',0),(16425,16424,10153,'2013-11-18 15:33:57','2013-11-18 15:34:35',1,0,0,'classic','01','mobile','01','',1,'','',0),(16426,16424,10153,'2013-11-18 15:33:57','2013-11-18 15:34:35',0,0,0,'classic','01','mobile','01','',1,'','',0),(16445,16444,10153,'2013-11-18 15:36:42','2013-11-18 15:37:19',1,0,0,'classic','01','mobile','01','',1,'','',0),(16446,16444,10153,'2013-11-18 15:36:42','2013-11-18 15:37:19',0,0,0,'classic','01','mobile','01','',1,'','',0),(16465,16464,10153,'2013-11-18 15:38:39','2013-11-18 15:39:15',1,0,0,'classic','01','mobile','01','',1,'','',0),(16466,16464,10153,'2013-11-18 15:38:39','2013-11-18 15:39:15',0,0,0,'classic','01','mobile','01','',1,'','',0),(17506,17505,10153,'2013-12-19 15:52:05','2013-12-19 15:52:05',1,0,0,'classic','01','mobile','01','',0,'','',0),(17507,17505,10153,'2013-12-19 15:52:05','2013-12-19 15:52:05',0,0,0,'classic','01','mobile','01','',0,'','',0),(17606,17605,10153,'2013-12-19 16:08:43','2013-12-19 16:08:43',1,0,0,'classic','01','mobile','01','',0,'','',0),(17607,17605,10153,'2013-12-19 16:08:43','2013-12-19 16:08:43',0,0,0,'classic','01','mobile','01','',0,'','',0);
/*!40000 ALTER TABLE `layoutset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetentries_assettags`
--

DROP TABLE IF EXISTS `assetentries_assettags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetentries_assettags` (
  `entryId` bigint(20) NOT NULL,
  `tagId` bigint(20) NOT NULL,
  PRIMARY KEY (`entryId`,`tagId`),
  KEY `IX_2ED82CAD` (`entryId`),
  KEY `IX_B2A61B55` (`tagId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetentries_assettags`
--

LOCK TABLES `assetentries_assettags` WRITE;
/*!40000 ALTER TABLE `assetentries_assettags` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetentries_assettags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourceblockpermission`
--

DROP TABLE IF EXISTS `resourceblockpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourceblockpermission` (
  `resourceBlockPermissionId` bigint(20) NOT NULL,
  `resourceBlockId` bigint(20) DEFAULT NULL,
  `roleId` bigint(20) DEFAULT NULL,
  `actionIds` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`resourceBlockPermissionId`),
  UNIQUE KEY `IX_D63D20BB` (`resourceBlockId`,`roleId`),
  KEY `IX_4AB3756` (`resourceBlockId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourceblockpermission`
--

LOCK TABLES `resourceblockpermission` WRITE;
/*!40000 ALTER TABLE `resourceblockpermission` DISABLE KEYS */;
/*!40000 ALTER TABLE `resourceblockpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cyrususer`
--

DROP TABLE IF EXISTS `cyrususer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cyrususer` (
  `userId` varchar(75) NOT NULL,
  `password_` varchar(75) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cyrususer`
--

LOCK TABLES `cyrususer` WRITE;
/*!40000 ALTER TABLE `cyrususer` DISABLE KEYS */;
/*!40000 ALTER TABLE `cyrususer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfileversion`
--

DROP TABLE IF EXISTS `dlfileversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfileversion` (
  `uuid_` varchar(75) DEFAULT NULL,
  `fileVersionId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `repositoryId` bigint(20) DEFAULT NULL,
  `folderId` bigint(20) DEFAULT NULL,
  `fileEntryId` bigint(20) DEFAULT NULL,
  `extension` varchar(75) DEFAULT NULL,
  `mimeType` varchar(75) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext,
  `changeLog` varchar(75) DEFAULT NULL,
  `extraSettings` longtext,
  `fileEntryTypeId` bigint(20) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  `size_` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`fileVersionId`),
  UNIQUE KEY `IX_E2815081` (`fileEntryId`,`version`),
  UNIQUE KEY `IX_C99B2650` (`uuid_`,`groupId`),
  KEY `IX_C68DC967` (`fileEntryId`),
  KEY `IX_D47BB14D` (`fileEntryId`,`status`),
  KEY `IX_DFD809D3` (`groupId`,`folderId`,`status`),
  KEY `IX_9BE769ED` (`groupId`,`folderId`,`title`,`version`),
  KEY `IX_4BFABB9A` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfileversion`
--

LOCK TABLES `dlfileversion` WRITE;
/*!40000 ALTER TABLE `dlfileversion` DISABLE KEYS */;
INSERT INTO `dlfileversion` VALUES ('323b5f3c-17d0-4a00-b7f4-0af7c188d991',10424,10179,10153,10157,'','2012-09-10 08:56:53','2012-09-10 08:56:53',10179,0,10419,'jpg','image/jpeg','welcome_bg_3.jpg','','','',0,'1.0',65684,0,10157,'','2012-09-10 08:56:54'),('5c8bf638-7999-437f-95ba-cabdf5822053',10434,10179,10153,10157,'','2012-09-10 08:56:55','2012-09-10 08:56:55',10179,0,10433,'jpg','image/jpeg','welcome_bg_11.jpg','','','',0,'1.0',43583,0,10157,'','2012-09-10 08:56:55'),('ff21a12e-8841-4776-bf44-29011f786d84',10445,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10179,0,10444,'jpg','image/jpeg','welcome_bg_12.jpg','','','',0,'1.0',46446,0,10157,'','2012-09-10 08:56:56'),('b1b6b3d7-ade9-4946-bbb3-1947b468b74b',10453,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10179,0,10452,'png','image/png','welcome_bg_10.png','','','',0,'1.0',27139,0,10157,'','2012-09-10 08:56:56'),('82df38fb-8aae-4310-8570-f9a34d56e058',10466,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10179,0,10465,'jpg','image/jpeg','welcome_bg_2.jpg','','','',0,'1.0',72911,0,10157,'','2012-09-10 08:56:57'),('6794889f-afc7-4d02-acfd-d2356454c0ee',10479,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10179,0,10477,'jpg','image/jpeg','welcome_bg_9.jpg','','','',0,'1.0',50215,0,10157,'','2012-09-10 08:56:57'),('201b09b4-03b5-4196-a052-eb891620d342',10494,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10179,0,10493,'jpg','image/jpeg','welcome_bg_4.jpg','','','',0,'1.0',62483,0,10157,'','2012-09-10 08:56:57'),('0e76a478-853c-4c8c-a96c-2179b32507ef',10506,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10179,0,10505,'jpg','image/jpeg','welcome_bg_6.jpg','','','',0,'1.0',45456,0,10157,'','2012-09-10 08:56:58'),('56d615e6-9ecb-4a84-b271-adf79bb0e271',10518,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10179,0,10517,'jpg','image/jpeg','welcome_bg_7.jpg','','','',0,'1.0',68705,0,10157,'','2012-09-10 08:56:58'),('294820c9-73f1-47ec-88b1-8772a0eca772',10531,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,10530,'jpg','image/jpeg','welcome_bg_5.jpg','','','',0,'1.0',40022,0,10157,'','2012-09-10 08:56:59'),('9d579a5d-6756-4a31-8fd1-d106b58c1752',10543,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,10542,'jpg','image/jpeg','welcome_bg_13.jpg','','','',0,'1.0',33632,0,10157,'','2012-09-10 08:56:59'),('5b455d1a-986e-430d-b6b3-d49b1b49077d',10555,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,10553,'jpg','image/jpeg','welcome_bg_1.jpg','','','',0,'1.0',54277,0,10157,'','2012-09-10 08:56:59'),('370eff75-33c3-4158-9aed-6ca58e1f1294',10567,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,10566,'jpg','image/jpeg','welcome_bg_8.jpg','','','',0,'1.0',43664,0,10157,'','2012-09-10 08:56:59'),('73300f15-b459-4449-a4e7-b14719f65292',11614,11605,10153,10157,'','2012-09-26 15:45:38','2012-09-26 15:45:38',11605,0,11613,'png','image/png','trophy_icon.png','','','',0,'1.0',2314,0,10157,'','2012-09-26 15:45:39'),('159ce5da-f529-4ae2-8d0d-915884036e18',11622,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',11605,0,11621,'png','image/png','image3.png','','','',0,'1.0',365175,0,10157,'','2012-09-26 15:45:40'),('6ad3b6e1-51ad-4ef3-949d-ccc2086c7a7d',11631,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',11605,0,11630,'png','image/png','download_icon.png','','','',0,'1.0',2876,0,10157,'','2012-09-26 15:45:40'),('f17d271e-7767-42ea-9327-944a194cb47a',11639,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',11605,0,11638,'png','image/png','image2.png','','','',0,'1.0',207501,0,10157,'','2012-09-26 15:45:41'),('40cb73aa-419c-4f42-9c5a-dc0b7de10dd3',11647,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',11605,0,11646,'png','image/png','image1.png','','','',0,'1.0',198611,0,10157,'','2012-09-26 15:45:41'),('c602f24d-a929-4e27-ac13-7f2c11304b35',11659,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',11605,0,11658,'png','image/png','strategy_icon.png','','','',0,'1.0',3804,0,10157,'','2012-09-26 15:45:42'),('a01dd1a5-7e51-40ea-8d92-c701d3ffa041',11670,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',11605,0,11669,'png','image/png','gears_icon.png','','','',0,'1.0',3233,0,10157,'','2012-09-26 15:45:42'),('a509c9fe-d139-4d61-8bb5-c90ff568edb3',13120,10191,10153,12102,'Admin Amin','2012-11-29 11:49:58','2012-11-29 11:49:58',10191,0,13119,'jpg','image/jpeg','SouthAmerica.jpg','','','',0,'1.0',4190,0,12102,'Admin Amin','2012-11-29 11:49:59'),('ebc5b872-825a-4a47-93ed-21ce3da09e07',13137,10191,10153,12102,'Admin Amin','2012-11-29 11:57:30','2012-11-29 11:57:30',10191,0,13136,'jpeg','image/jpeg','M&S.jpeg','','','',0,'1.0',8125,0,12102,'Admin Amin','2012-11-29 11:57:31'),('f7f762c7-e5ad-4abb-ad96-c2c18320970d',13153,10191,10153,12102,'Admin Amin','2012-11-29 12:09:56','2012-11-29 12:09:56',10191,0,13152,'jpeg','image/jpeg','configurator.jpeg','','','',0,'1.0',9324,0,12102,'Admin Amin','2012-11-29 12:09:56'),('16d57c36-9547-41b5-8c18-7c021f834663',13188,10191,10153,12102,'Admin Amin','2012-11-29 13:58:27','2012-11-29 13:58:27',10191,0,13187,'png','image/png','upload-textile-machinery.png','','','',0,'1.0',241315,0,12102,'Admin Amin','2012-11-29 13:58:27'),('7da3dc11-6eea-44a8-9af6-f1faaf39c5c3',13277,10191,10153,12102,'Admin Amin','2012-11-29 14:28:41','2012-11-29 14:28:41',10191,0,13276,'png','image/png','europe-partners.png','','','',0,'1.0',304275,0,12102,'Admin Amin','2012-11-29 14:28:41'),('13dca1f9-a3e0-4384-9c4e-9c3c72fc2ab6',13348,10191,10153,12102,'Admin Amin','2012-11-29 14:36:17','2012-11-29 14:36:17',10191,0,13347,'png','image/png','europe-partners1.png','','','',0,'1.0',322760,0,12102,'Admin Amin','2012-11-29 14:36:17'),('2436d20e-45ef-4bb5-a986-75fe5cc601d2',15299,10191,10153,12102,'Admin Amin','2013-05-10 13:38:58','2013-05-10 13:38:58',10191,0,15298,'png','image/png','MantAPP.png','','','',0,'1.0',39092,0,12102,'Admin Amin','2013-05-10 13:38:58'),('bc1b22ac-2e7e-43ff-8c70-763434c1bb8f',18302,10191,10153,12102,'Admin Admin','2014-03-04 08:49:43','2014-03-04 08:49:43',10191,0,18301,'jpg','image/jpeg','bkg-index.jpg','','','',0,'1.0',132922,0,12102,'Admin Admin','2014-03-04 08:49:43');
/*!40000 ALTER TABLE `dlfileversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journaltemplate`
--

DROP TABLE IF EXISTS `journaltemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journaltemplate` (
  `uuid_` varchar(75) DEFAULT NULL,
  `id_` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `templateId` varchar(75) DEFAULT NULL,
  `structureId` varchar(75) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `xsl` longtext,
  `langType` varchar(75) DEFAULT NULL,
  `cacheable` tinyint(4) DEFAULT NULL,
  `smallImage` tinyint(4) DEFAULT NULL,
  `smallImageId` bigint(20) DEFAULT NULL,
  `smallImageURL` longtext,
  PRIMARY KEY (`id_`),
  UNIQUE KEY `IX_E802AA3C` (`groupId`,`templateId`),
  UNIQUE KEY `IX_62D1B3AD` (`uuid_`,`groupId`),
  KEY `IX_77923653` (`groupId`),
  KEY `IX_1701CB2B` (`groupId`,`structureId`),
  KEY `IX_25FFB6FA` (`smallImageId`),
  KEY `IX_45F5A7C7` (`structureId`),
  KEY `IX_1B12CA20` (`templateId`),
  KEY `IX_2857419D` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journaltemplate`
--

LOCK TABLES `journaltemplate` WRITE;
/*!40000 ALTER TABLE `journaltemplate` DISABLE KEYS */;
INSERT INTO `journaltemplate` VALUES ('6fe5cb1f-91b7-447d-9cf4-450eb429c67b',10593,10179,10153,10157,'','2012-09-10 08:57:00','2012-09-10 08:57:00','10592','10590','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome Content Template</Name></root>','','<div class=\"navigation-wrapper\">\n	<header class=\"content-head content-head-liferay-portal\">\n		<hgroup>\n			<h1>$page-title.data</h1>\n\n			<hr />\n		</hgroup>\n\n		<nav>\n			<ul id=\"contentNav\">\n				#foreach($link in $links.siblings)\n					#if($velocityCount == 1)\n						<li class=\"selected\"><a href=\"#pageId$velocityCount\">$link.data</a></li>\n					#else\n						<li><a href=\"#pageId$velocityCount\">$link.data</a></li>\n					#end\n				#end\n			</ul>\n		</nav>\n	</header>\n\n	<div class=\"content-area-wrapper\">\n		#foreach($link in $links.siblings)\n			#if($velocityCount == 1)\n				<style type=\"text/css\">\n					.content-area {\n						background: url($link.bg-image.data) 100% 0 no-repeat;\n					}\n				</style>\n\n				<div class=\"content-area selected\" data-bannerImage=\"$link.bg-image.data\" id=\"pageId$velocityCount\">\n					$link.data\n\n					<a href=\"$link.action-link-url.data\" id=\"marketplace\">&nbsp;</a>\n				</div>\n			#else\n				<div class=\"content-area\" data-bannerImage=\"$link.bg-image.data\" id=\"pageId$velocityCount\">\n					$link.data\n\n					<a href=\"$link.action-link-url.data\" id=\"marketplace\">&nbsp;</a>\n				</div>\n			#end\n		#end\n	</div>\n</div>\n\n<script charset=\"utf-8\" type=\"text/javascript\">\n	AUI().ready(\n		\'aui-base\',\n		function(A) {\n			var hash = null;\n\n			var selectContent = function(href) {\n				var div = A.one(href);\n\n				if (div) {\n					div.radioClass(\'selected\');\n\n					div.setStyle(\'background\', \'url(\' + div.attr(\'data-bannerImage\')+\') 100% 0 no-repeat\');\n\n					hash = href;\n				}\n			};\n\n			var selectNavItem = function(hash) {\n				if (hash) {\n					A.one(\'#contentNav a[href$=\"\'+ hash +\'\"]\').ancestor().radioClass(\'selected\');\n				}\n			};\n\n			var select = function(hash) {\n				selectContent(hash);\n				selectNavItem(hash);\n			};\n\n			var currentHash = location.hash;\n\n			if (currentHash) {\n				select(currentHash);\n			}\n\n			setInterval(\n				function() {\n					var currentHash = location.hash;\n\n					if (currentHash != hash) {\n						select(currentHash);\n					}\n				},\n				200\n			);\n\n			A.one(\'#contentNav\').delegate(\n				\'click\',\n				function(event) {\n					var a = event.currentTarget;\n\n					a.ancestor().radioClass(\'selected\');\n\n					selectContent(a.attr(\'hash\'));\n				},\n				\'a\'\n			);\n		}\n	);\n</script>','vm',0,0,10594,''),('3bdb0d80-690a-4965-b8a5-162fdb75e282',11688,11605,10153,10157,'','2012-09-26 15:45:43','2012-09-26 15:45:43','11687','11681','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Main Content</Name></root>','','#set ($col_count = 0)\n\n#if ($col-one.data != \"\")\n	#set ($col_count = $col_count + 1)\n#end\n\n#if ($col-two.data != \"\")\n	#set ($col_count = $col_count + 1)\n#end\n\n#if ($col-three.data != \"\")\n	#set ($col_count = $col_count + 1)\n#end\n\n<div class=\"page-content\">\n	#if ($title.data != \"\")\n		<h1 class=\"innovation-title\">\n			$title.data\n		</h1>\n\n		<div class=\"divider\"></div>\n	#end\n\n	<div class=\"aui-layout-content content-text\">\n		#if ($col_count == 1 && $col-one.data != \"\")\n			<div class=\"aui-column aui-w100\">\n				<div class=\"aui-column-content\">\n					$col-one.data\n				</div>\n			</div>\n		#end\n\n		#if ($col_count == 2 && $col-one.data != \"\" && $col-two.data != \"\")\n			<div class=\"aui-column aui-column-first aui-w50\">\n				<div class=\"aui-column-content\">\n					$col-one.data\n				</div>\n			</div>\n\n			<div class=\"aui-column aui-column-last aui-w50\">\n				<div class=\"aui-column-content\">\n					$col-two.data\n				</div>\n			</div>\n		#end\n\n		#if ($col_count == 3 && $col-one.data != \"\" && $col-two.data != \"\" && $col-three.data != \"\")\n			<div class=\"aui-column aui-column-first aui-w33\">\n				<div class=\"aui-column-content\">\n					$col-one.data\n				</div>\n			</div>\n\n			<div class=\"aui-column aui-w33 center\">\n				<div class=\"aui-column-content\">\n					$col-two.data\n				</div>\n			</div>\n\n			<div class=\"aui-column aui-column-last aui-w33\">\n				<div class=\"aui-column-content\">\n					$col-three.data\n				</div>\n			</div>\n		#end\n	</div>\n</div>','vm',0,0,11689,''),('8f1946a8-ebd3-4735-8b20-3d61fa188975',11714,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44','11713','11711','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Featured Content</Name></root>','','<div class=\"pod\">\n	#if ($image.data != \"\")\n		<img class=\"pod-image\" src=\"$image.data\" />\n	#end\n\n	<div class=\"pod-text\">\n		#if ($title.data != \"\")\n			<h5>\n				$title.data\n			</h5>\n		#end\n\n		$description.data\n	</div>\n\n	<div class=\"divider\"></div>\n</div>\n\n#if ($content.data != \"\")\n	<div class=\"column-text\">\n		$content.data\n	</div>\n#end','vm',0,0,11715,''),('345ad5cd-9f57-4094-9b7c-477744f2eec4',11741,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45','11740','11711','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Pod</Name></root>','','<div class=\"pod button\">\n	#if ($link.data != \"\")\n		<a href=\"$link.data\">\n	#end\n\n	#if ($image.data != \"\")\n		<img class=\"pod-image\" src=\"$image.data\" />\n	#end\n\n	<div class=\"pod-text\">\n		#if ($title.data != \"\")\n			<h5>\n				$title.data\n			</h5>\n		#end\n\n		#if ($description.data != \"\")\n			<span class=\"description\">\n				$description.data\n			</span>\n		#end\n	</div>\n\n	#if ($link.data != \"\")\n		</a>\n	#end\n</div>','vm',0,0,11742,''),('f7023a4d-1e8e-4d59-b263-31d41107a3da',11752,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45','11751','11711','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Heading Featured Content</Name></root>','','<div class=\"featured-text\">\n	#if ($title.data != \"\")\n		<h3>\n			$title.data\n		</h3>\n	#end\n\n	#if ($content.data != \"\")\n		<div class=\"featured-content\">\n			$content.data\n		</div>\n	#end\n</div>','vm',0,0,11753,''),('414fdaf5-de4d-4749-bd1e-f5baa96be5f5',11769,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45','11768','11766','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Carousel</Name></root>','','#set ($content_id = $reserved-article-id.getData())\n#set ($content_class = \"multiple-items-\" + $content_id + \"-carousel\")\n\n<style type=\"text/css\">\n	#${content_class} {\n		height: ${height.getData()}px;\n		position: relative;\n		width: ${width.getData()}px;\n	}\n\n	#${content_class} .carousel-item {\n		height: ${height.getData()}px;\n		overflow: hidden;\n		position: absolute;\n		top: 0;\n		width: ${width.getData()}px;\n	}\n\n	#if ($controls.data)\n		#${content_class} menu {\n			display: none;\n		}\n	#end\n</style>\n\n<div id=\"$content_class\">\n	#foreach ($item in $image.getSiblings())\n		<div class=\"carousel-item\">\n			#if ($item.getData())\n				#if ($item.link.url-location.data != \"\")\n					<a href=\"$item.link.url-location.data\">\n				#end\n\n				<img alt=\"$item.link.data\" src=\"$item.getData()\" title=\"$item.link.data\" />\n\n				#if ($item.link.url-location.data != \"\")\n					</a>\n				#end\n			#end\n		</div>\n	#end\n</div>\n\n<script type=\"text/javascript\">\n	AUI().ready(\n		\'aui-carousel\',\n		function(A) {\n			new A.Carousel(\n				{\n					activeIndex: \'rand\',\n					contentBox: \'#${content_class}\',\n					height: $height.getData(),\n					intervalTime: $duration.getData(),\n					width: $width.getData()\n				}\n			).render();\n		}\n	);\n</script>','vm',0,0,11770,'');
/*!40000 ALTER TABLE `journaltemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourceaction`
--

DROP TABLE IF EXISTS `resourceaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourceaction` (
  `resourceActionId` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `actionId` varchar(75) DEFAULT NULL,
  `bitwiseValue` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`resourceActionId`),
  UNIQUE KEY `IX_EDB9986E` (`name`,`actionId`),
  KEY `IX_81F2DB09` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourceaction`
--

LOCK TABLES `resourceaction` WRITE;
/*!40000 ALTER TABLE `resourceaction` DISABLE KEYS */;
INSERT INTO `resourceaction` VALUES (1,'1_WAR_marketplaceportlet','VIEW',1),(2,'1_WAR_marketplaceportlet','ADD_TO_PAGE',2),(3,'1_WAR_marketplaceportlet','ACCESS_IN_CONTROL_PANEL',4),(4,'1_WAR_marketplaceportlet','CONFIGURATION',8),(5,'1_WAR_marketplaceportlet','PERMISSIONS',16),(6,'2_WAR_marketplaceportlet','VIEW',1),(7,'2_WAR_marketplaceportlet','ADD_TO_PAGE',2),(8,'2_WAR_marketplaceportlet','ACCESS_IN_CONTROL_PANEL',4),(9,'2_WAR_marketplaceportlet','CONFIGURATION',8),(10,'2_WAR_marketplaceportlet','PERMISSIONS',16),(101,'98','ACCESS_IN_CONTROL_PANEL',2),(102,'98','ADD_TO_PAGE',4),(103,'98','CONFIGURATION',8),(104,'98','VIEW',1),(105,'98','PERMISSIONS',16),(106,'com.liferay.portlet.softwarecatalog.model.SCFrameworkVersion','DELETE',2),(107,'com.liferay.portlet.softwarecatalog.model.SCFrameworkVersion','PERMISSIONS',4),(108,'com.liferay.portlet.softwarecatalog.model.SCFrameworkVersion','UPDATE',8),(109,'com.liferay.portlet.softwarecatalog','ADD_FRAMEWORK_VERSION',2),(110,'com.liferay.portlet.softwarecatalog','ADD_PRODUCT_ENTRY',4),(111,'com.liferay.portlet.softwarecatalog','PERMISSIONS',8),(112,'com.liferay.portlet.softwarecatalog.model.SCLicense','DELETE',2),(113,'com.liferay.portlet.softwarecatalog.model.SCLicense','PERMISSIONS',4),(114,'com.liferay.portlet.softwarecatalog.model.SCLicense','UPDATE',8),(115,'com.liferay.portlet.softwarecatalog.model.SCLicense','VIEW',1),(116,'com.liferay.portlet.softwarecatalog.model.SCProductEntry','ADD_DISCUSSION',2),(117,'com.liferay.portlet.softwarecatalog.model.SCProductEntry','DELETE',4),(118,'com.liferay.portlet.softwarecatalog.model.SCProductEntry','DELETE_DISCUSSION',8),(119,'com.liferay.portlet.softwarecatalog.model.SCProductEntry','PERMISSIONS',16),(120,'com.liferay.portlet.softwarecatalog.model.SCProductEntry','UPDATE',32),(121,'com.liferay.portlet.softwarecatalog.model.SCProductEntry','UPDATE_DISCUSSION',64),(122,'com.liferay.portlet.softwarecatalog.model.SCProductEntry','VIEW',1),(123,'66','VIEW',1),(124,'66','ADD_TO_PAGE',2),(125,'66','CONFIGURATION',4),(126,'66','PERMISSIONS',8),(127,'156','VIEW',1),(128,'156','ADD_TO_PAGE',2),(129,'156','ACCESS_IN_CONTROL_PANEL',4),(130,'156','CONFIGURATION',8),(131,'156','PERMISSIONS',16),(132,'180','VIEW',1),(133,'180','ADD_TO_PAGE',2),(134,'180','CONFIGURATION',4),(135,'180','PERMISSIONS',8),(136,'152','ACCESS_IN_CONTROL_PANEL',2),(137,'152','CONFIGURATION',4),(138,'152','VIEW',1),(139,'152','PERMISSIONS',8),(140,'27','VIEW',1),(141,'27','ADD_TO_PAGE',2),(142,'27','CONFIGURATION',4),(143,'27','PERMISSIONS',8),(144,'88','VIEW',1),(145,'88','ADD_TO_PAGE',2),(146,'88','CONFIGURATION',4),(147,'88','PERMISSIONS',8),(148,'87','VIEW',1),(149,'87','ADD_TO_PAGE',2),(150,'87','CONFIGURATION',4),(151,'87','PERMISSIONS',8),(152,'134','ACCESS_IN_CONTROL_PANEL',2),(153,'134','CONFIGURATION',4),(154,'134','VIEW',1),(155,'134','PERMISSIONS',8),(156,'com.liferay.portal.model.Layout','ADD_DISCUSSION',2),(157,'com.liferay.portal.model.Layout','ADD_LAYOUT',4),(158,'com.liferay.portal.model.Layout','CONFIGURE_PORTLETS',8),(159,'com.liferay.portal.model.Layout','CUSTOMIZE',16),(160,'com.liferay.portal.model.Layout','DELETE',32),(161,'com.liferay.portal.model.Layout','DELETE_DISCUSSION',64),(162,'com.liferay.portal.model.Layout','PERMISSIONS',128),(163,'com.liferay.portal.model.Layout','UPDATE',256),(164,'com.liferay.portal.model.Layout','UPDATE_DISCUSSION',512),(165,'com.liferay.portal.model.Layout','VIEW',1),(166,'com.liferay.portal.model.LayoutBranch','DELETE',2),(167,'com.liferay.portal.model.LayoutBranch','PERMISSIONS',4),(168,'com.liferay.portal.model.LayoutBranch','UPDATE',8),(169,'com.liferay.portal.model.LayoutSetBranch','DELETE',2),(170,'com.liferay.portal.model.LayoutSetBranch','MERGE',4),(171,'com.liferay.portal.model.LayoutSetBranch','PERMISSIONS',8),(172,'com.liferay.portal.model.LayoutSetBranch','UPDATE',16),(173,'com.liferay.portal.model.Team','ASSIGN_MEMBERS',2),(174,'com.liferay.portal.model.Team','DELETE',4),(175,'com.liferay.portal.model.Team','PERMISSIONS',8),(176,'com.liferay.portal.model.Team','UPDATE',16),(177,'com.liferay.portal.model.Team','VIEW',1),(178,'com.liferay.portal.model.Group','ADD_LAYOUT',2),(179,'com.liferay.portal.model.Group','ADD_LAYOUT_BRANCH',4),(180,'com.liferay.portal.model.Group','ADD_LAYOUT_SET_BRANCH',8),(181,'com.liferay.portal.model.Group','ASSIGN_MEMBERS',16),(182,'com.liferay.portal.model.Group','ASSIGN_USER_ROLES',32),(183,'com.liferay.portal.model.Group','CONFIGURE_PORTLETS',64),(184,'com.liferay.portal.model.Group','DELETE',128),(185,'com.liferay.portal.model.Group','EXPORT_IMPORT_LAYOUTS',256),(186,'com.liferay.portal.model.Group','EXPORT_IMPORT_PORTLET_INFO',512),(187,'com.liferay.portal.model.Group','MANAGE_ANNOUNCEMENTS',1024),(188,'com.liferay.portal.model.Group','MANAGE_ARCHIVED_SETUPS',2048),(189,'com.liferay.portal.model.Group','MANAGE_LAYOUTS',4096),(190,'com.liferay.portal.model.Group','MANAGE_STAGING',8192),(191,'com.liferay.portal.model.Group','MANAGE_TEAMS',16384),(192,'com.liferay.portal.model.Group','PERMISSIONS',32768),(193,'com.liferay.portal.model.Group','PUBLISH_STAGING',65536),(194,'com.liferay.portal.model.Group','PUBLISH_TO_REMOTE',131072),(195,'com.liferay.portal.model.Group','UPDATE',262144),(196,'com.liferay.portal.model.Group','VIEW',1),(197,'com.liferay.portal.model.Group','VIEW_MEMBERS',524288),(198,'com.liferay.portal.model.Group','VIEW_STAGING',1048576),(199,'130','ACCESS_IN_CONTROL_PANEL',2),(200,'130','CONFIGURATION',4),(201,'130','VIEW',1),(202,'130','PERMISSIONS',8),(203,'122','VIEW',1),(204,'122','ADD_TO_PAGE',2),(205,'122','CONFIGURATION',4),(206,'122','PERMISSIONS',8),(207,'36','ADD_TO_PAGE',2),(208,'36','CONFIGURATION',4),(209,'36','VIEW',1),(210,'36','PERMISSIONS',8),(211,'com.liferay.portlet.wiki.model.WikiPage','ADD_DISCUSSION',2),(212,'com.liferay.portlet.wiki.model.WikiPage','DELETE',4),(213,'com.liferay.portlet.wiki.model.WikiPage','DELETE_DISCUSSION',8),(214,'com.liferay.portlet.wiki.model.WikiPage','PERMISSIONS',16),(215,'com.liferay.portlet.wiki.model.WikiPage','SUBSCRIBE',32),(216,'com.liferay.portlet.wiki.model.WikiPage','UPDATE',64),(217,'com.liferay.portlet.wiki.model.WikiPage','UPDATE_DISCUSSION',128),(218,'com.liferay.portlet.wiki.model.WikiPage','VIEW',1),(219,'com.liferay.portlet.wiki.model.WikiNode','ADD_ATTACHMENT',2),(220,'com.liferay.portlet.wiki.model.WikiNode','ADD_PAGE',4),(221,'com.liferay.portlet.wiki.model.WikiNode','DELETE',8),(222,'com.liferay.portlet.wiki.model.WikiNode','IMPORT',16),(223,'com.liferay.portlet.wiki.model.WikiNode','PERMISSIONS',32),(224,'com.liferay.portlet.wiki.model.WikiNode','SUBSCRIBE',64),(225,'com.liferay.portlet.wiki.model.WikiNode','UPDATE',128),(226,'com.liferay.portlet.wiki.model.WikiNode','VIEW',1),(227,'com.liferay.portlet.wiki','ADD_NODE',2),(228,'com.liferay.portlet.wiki','PERMISSIONS',4),(229,'26','VIEW',1),(230,'26','ADD_TO_PAGE',2),(231,'26','CONFIGURATION',4),(232,'26','PERMISSIONS',8),(233,'104','VIEW',1),(234,'104','ADD_TO_PAGE',2),(235,'104','ACCESS_IN_CONTROL_PANEL',4),(236,'104','CONFIGURATION',8),(237,'104','PERMISSIONS',16),(238,'175','VIEW',1),(239,'175','ADD_TO_PAGE',2),(240,'175','CONFIGURATION',4),(241,'175','PERMISSIONS',8),(242,'64','VIEW',1),(243,'64','ADD_TO_PAGE',2),(244,'64','CONFIGURATION',4),(245,'64','PERMISSIONS',8),(246,'153','ACCESS_IN_CONTROL_PANEL',2),(247,'153','ADD_TO_PAGE',4),(248,'153','CONFIGURATION',8),(249,'153','VIEW',1),(250,'153','PERMISSIONS',16),(251,'129','ACCESS_IN_CONTROL_PANEL',2),(252,'129','CONFIGURATION',4),(253,'129','VIEW',1),(254,'129','PERMISSIONS',8),(255,'com.liferay.portal.model.PasswordPolicy','ASSIGN_MEMBERS',2),(256,'com.liferay.portal.model.PasswordPolicy','DELETE',4),(257,'com.liferay.portal.model.PasswordPolicy','PERMISSIONS',8),(258,'com.liferay.portal.model.PasswordPolicy','UPDATE',16),(259,'com.liferay.portal.model.PasswordPolicy','VIEW',1),(260,'179','VIEW',1),(261,'179','ADD_TO_PAGE',2),(262,'179','ACCESS_IN_CONTROL_PANEL',4),(263,'179','CONFIGURATION',8),(264,'179','PERMISSIONS',16),(265,'173','VIEW',1),(266,'173','ADD_TO_PAGE',2),(267,'173','ACCESS_IN_CONTROL_PANEL',4),(268,'173','CONFIGURATION',8),(269,'173','PERMISSIONS',16),(270,'100','VIEW',1),(271,'100','ADD_TO_PAGE',2),(272,'100','CONFIGURATION',4),(273,'100','PERMISSIONS',8),(274,'157','ACCESS_IN_CONTROL_PANEL',2),(275,'157','CONFIGURATION',4),(276,'157','VIEW',1),(277,'157','PERMISSIONS',8),(278,'19','ADD_TO_PAGE',2),(279,'19','CONFIGURATION',4),(280,'19','VIEW',1),(281,'19','PERMISSIONS',8),(282,'com.liferay.portlet.messageboards.model.MBCategory','ADD_FILE',2),(283,'com.liferay.portlet.messageboards.model.MBCategory','ADD_MESSAGE',4),(284,'com.liferay.portlet.messageboards.model.MBCategory','ADD_SUBCATEGORY',8),(285,'com.liferay.portlet.messageboards.model.MBCategory','DELETE',16),(286,'com.liferay.portlet.messageboards.model.MBCategory','LOCK_THREAD',32),(287,'com.liferay.portlet.messageboards.model.MBCategory','MOVE_THREAD',64),(288,'com.liferay.portlet.messageboards.model.MBCategory','PERMISSIONS',128),(289,'com.liferay.portlet.messageboards.model.MBCategory','REPLY_TO_MESSAGE',256),(290,'com.liferay.portlet.messageboards.model.MBCategory','SUBSCRIBE',512),(291,'com.liferay.portlet.messageboards.model.MBCategory','UPDATE',1024),(292,'com.liferay.portlet.messageboards.model.MBCategory','UPDATE_THREAD_PRIORITY',2048),(293,'com.liferay.portlet.messageboards.model.MBCategory','VIEW',1),(294,'com.liferay.portlet.messageboards','ADD_CATEGORY',2),(295,'com.liferay.portlet.messageboards','ADD_FILE',4),(296,'com.liferay.portlet.messageboards','ADD_MESSAGE',8),(297,'com.liferay.portlet.messageboards','BAN_USER',16),(298,'com.liferay.portlet.messageboards','MOVE_THREAD',32),(299,'com.liferay.portlet.messageboards','LOCK_THREAD',64),(300,'com.liferay.portlet.messageboards','PERMISSIONS',128),(301,'com.liferay.portlet.messageboards','REPLY_TO_MESSAGE',256),(302,'com.liferay.portlet.messageboards','SUBSCRIBE',512),(303,'com.liferay.portlet.messageboards','UPDATE_THREAD_PRIORITY',1024),(304,'com.liferay.portlet.messageboards','VIEW',1),(305,'com.liferay.portlet.messageboards.model.MBThread','SUBSCRIBE',2),(306,'com.liferay.portlet.messageboards.model.MBThread','PERMISSIONS',4),(307,'com.liferay.portlet.messageboards.model.MBMessage','DELETE',2),(308,'com.liferay.portlet.messageboards.model.MBMessage','PERMISSIONS',4),(309,'com.liferay.portlet.messageboards.model.MBMessage','SUBSCRIBE',8),(310,'com.liferay.portlet.messageboards.model.MBMessage','UPDATE',16),(311,'com.liferay.portlet.messageboards.model.MBMessage','VIEW',1),(312,'160','VIEW',1),(313,'160','ADD_TO_PAGE',2),(314,'160','CONFIGURATION',4),(315,'160','PERMISSIONS',8),(316,'128','ACCESS_IN_CONTROL_PANEL',2),(317,'128','CONFIGURATION',4),(318,'128','VIEW',1),(319,'128','PERMISSIONS',8),(320,'com.liferay.portal.model.Role','ASSIGN_MEMBERS',2),(321,'com.liferay.portal.model.Role','DEFINE_PERMISSIONS',4),(322,'com.liferay.portal.model.Role','DELETE',8),(323,'com.liferay.portal.model.Role','MANAGE_ANNOUNCEMENTS',16),(324,'com.liferay.portal.model.Role','PERMISSIONS',32),(325,'com.liferay.portal.model.Role','UPDATE',64),(326,'com.liferay.portal.model.Role','VIEW',1),(327,'181','VIEW',1),(328,'181','ADD_TO_PAGE',2),(329,'181','CONFIGURATION',4),(330,'181','PERMISSIONS',8),(331,'86','VIEW',1),(332,'86','ADD_TO_PAGE',2),(333,'86','CONFIGURATION',4),(334,'86','PERMISSIONS',8),(335,'154','ACCESS_IN_CONTROL_PANEL',2),(336,'154','CONFIGURATION',4),(337,'154','VIEW',1),(338,'154','PERMISSIONS',8),(339,'148','VIEW',1),(340,'148','ADD_TO_PAGE',2),(341,'148','CONFIGURATION',4),(342,'148','PERMISSIONS',8),(343,'11','ADD_TO_PAGE',2),(344,'11','CONFIGURATION',4),(345,'11','VIEW',1),(346,'11','PERMISSIONS',8),(347,'29','ADD_TO_PAGE',2),(348,'29','CONFIGURATION',4),(349,'29','VIEW',1),(350,'29','PERMISSIONS',8),(351,'174','VIEW',1),(352,'174','ADD_TO_PAGE',2),(353,'174','ACCESS_IN_CONTROL_PANEL',4),(354,'174','CONFIGURATION',8),(355,'174','PERMISSIONS',16),(356,'158','ACCESS_IN_CONTROL_PANEL',2),(357,'158','ADD_TO_PAGE',4),(358,'158','CONFIGURATION',8),(359,'158','VIEW',1),(360,'158','PERMISSIONS',16),(361,'178','VIEW',1),(362,'178','ADD_TO_PAGE',2),(363,'178','ACCESS_IN_CONTROL_PANEL',4),(364,'178','CONFIGURATION',8),(365,'178','PERMISSIONS',16),(366,'124','VIEW',1),(367,'124','ADD_TO_PAGE',2),(368,'124','CONFIGURATION',4),(369,'124','PERMISSIONS',8),(370,'8','ACCESS_IN_CONTROL_PANEL',2),(371,'8','ADD_TO_PAGE',4),(372,'8','CONFIGURATION',8),(373,'8','VIEW',1),(374,'8','PERMISSIONS',16),(375,'com.liferay.portlet.calendar','ADD_EVENT',2),(376,'com.liferay.portlet.calendar','EXPORT_ALL_EVENTS',4),(377,'com.liferay.portlet.calendar','PERMISSIONS',8),(378,'com.liferay.portlet.calendar.model.CalEvent','ADD_DISCUSSION',2),(379,'com.liferay.portlet.calendar.model.CalEvent','DELETE',4),(380,'com.liferay.portlet.calendar.model.CalEvent','DELETE_DISCUSSION',8),(381,'com.liferay.portlet.calendar.model.CalEvent','PERMISSIONS',16),(382,'com.liferay.portlet.calendar.model.CalEvent','UPDATE',32),(383,'com.liferay.portlet.calendar.model.CalEvent','UPDATE_DISCUSSION',64),(384,'com.liferay.portlet.calendar.model.CalEvent','VIEW',1),(385,'58','ADD_TO_PAGE',2),(386,'58','CONFIGURATION',4),(387,'58','VIEW',1),(388,'58','PERMISSIONS',8),(389,'97','VIEW',1),(390,'97','ADD_TO_PAGE',2),(391,'97','CONFIGURATION',4),(392,'97','PERMISSIONS',8),(393,'71','ADD_TO_PAGE',2),(394,'71','CONFIGURATION',4),(395,'71','VIEW',1),(396,'71','PERMISSIONS',8),(397,'39','VIEW',1),(398,'39','ADD_TO_PAGE',2),(399,'39','CONFIGURATION',4),(400,'39','PERMISSIONS',8),(401,'177','CONFIGURATION',2),(402,'177','VIEW',1),(403,'177','ADD_TO_PAGE',4),(404,'177','PERMISSIONS',8),(405,'177','ACCESS_IN_CONTROL_PANEL',16),(406,'com.liferay.portlet.mobiledevicerules','ADD_RULE_GROUP',2),(407,'com.liferay.portlet.mobiledevicerules','ADD_RULE_GROUP_INSTANCE',4),(408,'com.liferay.portlet.mobiledevicerules','CONFIGURATION',8),(409,'com.liferay.portlet.mobiledevicerules','VIEW',1),(410,'com.liferay.portlet.mobiledevicerules','PERMISSIONS',16),(411,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroup','DELETE',2),(412,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroup','PERMISSIONS',4),(413,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroup','UPDATE',8),(414,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroup','VIEW',1),(415,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroupInstance','DELETE',2),(416,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroupInstance','PERMISSIONS',4),(417,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroupInstance','UPDATE',8),(418,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroupInstance','VIEW',1),(419,'170','VIEW',1),(420,'170','ADD_TO_PAGE',2),(421,'170','CONFIGURATION',4),(422,'170','PERMISSIONS',8),(423,'85','ADD_TO_PAGE',2),(424,'85','CONFIGURATION',4),(425,'85','VIEW',1),(426,'85','PERMISSIONS',8),(427,'118','VIEW',1),(428,'118','ADD_TO_PAGE',2),(429,'118','CONFIGURATION',4),(430,'118','PERMISSIONS',8),(431,'107','VIEW',1),(432,'107','ADD_TO_PAGE',2),(433,'107','CONFIGURATION',4),(434,'107','PERMISSIONS',8),(435,'30','VIEW',1),(436,'30','ADD_TO_PAGE',2),(437,'30','CONFIGURATION',4),(438,'30','PERMISSIONS',8),(439,'147','ACCESS_IN_CONTROL_PANEL',2),(440,'147','CONFIGURATION',4),(441,'147','VIEW',1),(442,'147','PERMISSIONS',8),(443,'com.liferay.portlet.asset','ADD_TAG',2),(444,'com.liferay.portlet.asset','PERMISSIONS',4),(445,'com.liferay.portlet.asset','ADD_CATEGORY',8),(446,'com.liferay.portlet.asset','ADD_VOCABULARY',16),(447,'com.liferay.portlet.asset.model.AssetCategory','ADD_CATEGORY',2),(448,'com.liferay.portlet.asset.model.AssetCategory','DELETE',4),(449,'com.liferay.portlet.asset.model.AssetCategory','PERMISSIONS',8),(450,'com.liferay.portlet.asset.model.AssetCategory','UPDATE',16),(451,'com.liferay.portlet.asset.model.AssetCategory','VIEW',1),(452,'com.liferay.portlet.asset.model.AssetVocabulary','DELETE',2),(453,'com.liferay.portlet.asset.model.AssetVocabulary','PERMISSIONS',4),(454,'com.liferay.portlet.asset.model.AssetVocabulary','UPDATE',8),(455,'com.liferay.portlet.asset.model.AssetVocabulary','VIEW',1),(456,'48','VIEW',1),(457,'48','ADD_TO_PAGE',2),(458,'48','CONFIGURATION',4),(459,'48','PERMISSIONS',8),(460,'125','ACCESS_IN_CONTROL_PANEL',2),(461,'125','CONFIGURATION',4),(462,'125','EXPORT_USER',8),(463,'125','VIEW',1),(464,'125','PERMISSIONS',16),(465,'com.liferay.portal.model.User','DELETE',2),(466,'com.liferay.portal.model.User','IMPERSONATE',4),(467,'com.liferay.portal.model.User','PERMISSIONS',8),(468,'com.liferay.portal.model.User','UPDATE',16),(469,'com.liferay.portal.model.User','VIEW',1),(470,'com.liferay.portal.model.UserGroup','ASSIGN_MEMBERS',2),(471,'com.liferay.portal.model.UserGroup','DELETE',4),(472,'com.liferay.portal.model.UserGroup','MANAGE_ANNOUNCEMENTS',8),(473,'com.liferay.portal.model.UserGroup','PERMISSIONS',16),(474,'com.liferay.portal.model.UserGroup','UPDATE',32),(475,'com.liferay.portal.model.UserGroup','VIEW',1),(476,'com.liferay.portal.model.Organization','ASSIGN_MEMBERS',2),(477,'com.liferay.portal.model.Organization','ASSIGN_USER_ROLES',4),(478,'com.liferay.portal.model.Organization','DELETE',8),(479,'com.liferay.portal.model.Organization','MANAGE_ANNOUNCEMENTS',16),(480,'com.liferay.portal.model.Organization','MANAGE_SUBORGANIZATIONS',32),(481,'com.liferay.portal.model.Organization','MANAGE_USERS',64),(482,'com.liferay.portal.model.Organization','PERMISSIONS',128),(483,'com.liferay.portal.model.Organization','UPDATE',256),(484,'com.liferay.portal.model.Organization','VIEW',1),(485,'161','ACCESS_IN_CONTROL_PANEL',2),(486,'161','CONFIGURATION',4),(487,'161','VIEW',1),(488,'161','PERMISSIONS',8),(489,'144','VIEW',1),(490,'144','ADD_TO_PAGE',2),(491,'144','CONFIGURATION',4),(492,'144','PERMISSIONS',8),(493,'146','ACCESS_IN_CONTROL_PANEL',2),(494,'146','CONFIGURATION',4),(495,'146','VIEW',1),(496,'146','PERMISSIONS',8),(497,'com.liferay.portal.model.LayoutPrototype','DELETE',2),(498,'com.liferay.portal.model.LayoutPrototype','PERMISSIONS',4),(499,'com.liferay.portal.model.LayoutPrototype','UPDATE',8),(500,'com.liferay.portal.model.LayoutPrototype','VIEW',1),(501,'62','VIEW',1),(502,'62','ADD_TO_PAGE',2),(503,'62','CONFIGURATION',4),(504,'62','PERMISSIONS',8),(505,'162','ACCESS_IN_CONTROL_PANEL',2),(506,'162','CONFIGURATION',4),(507,'162','VIEW',1),(508,'162','PERMISSIONS',8),(509,'176','VIEW',1),(510,'176','ADD_TO_PAGE',2),(511,'176','ACCESS_IN_CONTROL_PANEL',4),(512,'176','CONFIGURATION',8),(513,'176','PERMISSIONS',16),(514,'172','VIEW',1),(515,'172','ADD_TO_PAGE',2),(516,'172','CONFIGURATION',4),(517,'172','PERMISSIONS',8),(518,'108','VIEW',1),(519,'108','ADD_TO_PAGE',2),(520,'108','CONFIGURATION',4),(521,'108','PERMISSIONS',8),(522,'139','ACCESS_IN_CONTROL_PANEL',2),(523,'139','ADD_EXPANDO',4),(524,'139','CONFIGURATION',8),(525,'139','VIEW',1),(526,'139','PERMISSIONS',16),(527,'com.liferay.portlet.expando.model.ExpandoColumn','DELETE',2),(528,'com.liferay.portlet.expando.model.ExpandoColumn','PERMISSIONS',4),(529,'com.liferay.portlet.expando.model.ExpandoColumn','UPDATE',8),(530,'com.liferay.portlet.expando.model.ExpandoColumn','VIEW',1),(531,'84','ADD_ENTRY',2),(532,'84','ADD_TO_PAGE',4),(533,'84','CONFIGURATION',8),(534,'84','VIEW',1),(535,'84','PERMISSIONS',16),(536,'com.liferay.portlet.announcements.model.AnnouncementsEntry','DELETE',2),(537,'com.liferay.portlet.announcements.model.AnnouncementsEntry','UPDATE',4),(538,'com.liferay.portlet.announcements.model.AnnouncementsEntry','VIEW',1),(539,'com.liferay.portlet.announcements.model.AnnouncementsEntry','PERMISSIONS',8),(540,'101','VIEW',1),(541,'101','ADD_TO_PAGE',2),(542,'101','CONFIGURATION',4),(543,'101','PERMISSIONS',8),(544,'121','VIEW',1),(545,'121','ADD_TO_PAGE',2),(546,'121','CONFIGURATION',4),(547,'121','PERMISSIONS',8),(548,'49','VIEW',1),(549,'49','ADD_TO_PAGE',2),(550,'49','CONFIGURATION',4),(551,'49','PERMISSIONS',8),(552,'143','VIEW',1),(553,'143','ADD_TO_PAGE',2),(554,'143','CONFIGURATION',4),(555,'143','PERMISSIONS',8),(556,'167','ACCESS_IN_CONTROL_PANEL',2),(557,'167','ADD_TO_PAGE',4),(558,'167','CONFIGURATION',8),(559,'167','VIEW',1),(560,'167','PERMISSIONS',16),(561,'com.liferay.portlet.dynamicdatalists','ADD_RECORD_SET',2),(562,'com.liferay.portlet.dynamicdatalists','ADD_STRUCTURE',4),(563,'com.liferay.portlet.dynamicdatalists','ADD_TEMPLATE',8),(564,'com.liferay.portlet.dynamicdatalists','PERMISSIONS',16),(565,'com.liferay.portlet.dynamicdatalists.model.DDLRecordSet','ADD_RECORD',2),(566,'com.liferay.portlet.dynamicdatalists.model.DDLRecordSet','DELETE',4),(567,'com.liferay.portlet.dynamicdatalists.model.DDLRecordSet','PERMISSIONS',8),(568,'com.liferay.portlet.dynamicdatalists.model.DDLRecordSet','UPDATE',16),(569,'com.liferay.portlet.dynamicdatalists.model.DDLRecordSet','VIEW',1),(570,'77','VIEW',1),(571,'77','ADD_TO_PAGE',2),(572,'77','CONFIGURATION',4),(573,'77','PERMISSIONS',8),(574,'115','VIEW',1),(575,'115','ADD_TO_PAGE',2),(576,'115','CONFIGURATION',4),(577,'115','PERMISSIONS',8),(578,'56','ADD_TO_PAGE',2),(579,'56','CONFIGURATION',4),(580,'56','VIEW',1),(581,'56','PERMISSIONS',8),(582,'142','VIEW',1),(583,'142','ADD_TO_PAGE',2),(584,'142','CONFIGURATION',4),(585,'142','PERMISSIONS',8),(586,'111','VIEW',1),(587,'111','ADD_TO_PAGE',2),(588,'111','CONFIGURATION',4),(589,'111','PERMISSIONS',8),(590,'16','PREFERENCES',2),(591,'16','GUEST_PREFERENCES',4),(592,'16','VIEW',1),(593,'16','ADD_TO_PAGE',8),(594,'16','CONFIGURATION',16),(595,'16','PERMISSIONS',32),(596,'3','VIEW',1),(597,'3','ADD_TO_PAGE',2),(598,'3','CONFIGURATION',4),(599,'3','PERMISSIONS',8),(600,'20','ACCESS_IN_CONTROL_PANEL',2),(601,'20','ADD_TO_PAGE',4),(602,'20','CONFIGURATION',8),(603,'20','VIEW',1),(604,'20','PERMISSIONS',16),(605,'com.liferay.portlet.documentlibrary.model.DLFolder','ACCESS',2),(606,'com.liferay.portlet.documentlibrary.model.DLFolder','ADD_DOCUMENT',4),(607,'com.liferay.portlet.documentlibrary.model.DLFolder','ADD_SHORTCUT',8),(608,'com.liferay.portlet.documentlibrary.model.DLFolder','ADD_SUBFOLDER',16),(609,'com.liferay.portlet.documentlibrary.model.DLFolder','DELETE',32),(610,'com.liferay.portlet.documentlibrary.model.DLFolder','PERMISSIONS',64),(611,'com.liferay.portlet.documentlibrary.model.DLFolder','UPDATE',128),(612,'com.liferay.portlet.documentlibrary.model.DLFolder','VIEW',1),(613,'com.liferay.portlet.documentlibrary','ADD_DOCUMENT',2),(614,'com.liferay.portlet.documentlibrary','ADD_DOCUMENT_TYPE',4),(615,'com.liferay.portlet.documentlibrary','ADD_FOLDER',8),(616,'com.liferay.portlet.documentlibrary','ADD_REPOSITORY',16),(617,'com.liferay.portlet.documentlibrary','ADD_STRUCTURE',32),(618,'com.liferay.portlet.documentlibrary','ADD_SHORTCUT',64),(619,'com.liferay.portlet.documentlibrary','PERMISSIONS',128),(620,'com.liferay.portlet.documentlibrary','UPDATE',256),(621,'com.liferay.portlet.documentlibrary','VIEW',1),(622,'com.liferay.portlet.documentlibrary.model.DLFileEntry','ADD_DISCUSSION',2),(623,'com.liferay.portlet.documentlibrary.model.DLFileEntry','DELETE',4),(624,'com.liferay.portlet.documentlibrary.model.DLFileEntry','DELETE_DISCUSSION',8),(625,'com.liferay.portlet.documentlibrary.model.DLFileEntry','PERMISSIONS',16),(626,'com.liferay.portlet.documentlibrary.model.DLFileEntry','UPDATE',32),(627,'com.liferay.portlet.documentlibrary.model.DLFileEntry','UPDATE_DISCUSSION',64),(628,'com.liferay.portlet.documentlibrary.model.DLFileEntry','VIEW',1),(629,'com.liferay.portlet.documentlibrary.model.DLFileShortcut','ADD_DISCUSSION',2),(630,'com.liferay.portlet.documentlibrary.model.DLFileShortcut','DELETE',4),(631,'com.liferay.portlet.documentlibrary.model.DLFileShortcut','DELETE_DISCUSSION',8),(632,'com.liferay.portlet.documentlibrary.model.DLFileShortcut','PERMISSIONS',16),(633,'com.liferay.portlet.documentlibrary.model.DLFileShortcut','UPDATE',32),(634,'com.liferay.portlet.documentlibrary.model.DLFileShortcut','UPDATE_DISCUSSION',64),(635,'com.liferay.portlet.documentlibrary.model.DLFileShortcut','VIEW',1),(636,'com.liferay.portlet.documentlibrary.model.DLFileEntryType','DELETE',2),(637,'com.liferay.portlet.documentlibrary.model.DLFileEntryType','PERMISSIONS',4),(638,'com.liferay.portlet.documentlibrary.model.DLFileEntryType','UPDATE',8),(639,'com.liferay.portlet.documentlibrary.model.DLFileEntryType','VIEW',1),(640,'23','VIEW',1),(641,'23','ADD_TO_PAGE',2),(642,'23','CONFIGURATION',4),(643,'23','PERMISSIONS',8),(644,'145','VIEW',1),(645,'145','ADD_TO_PAGE',2),(646,'145','CONFIGURATION',4),(647,'145','PERMISSIONS',8),(648,'83','ADD_ENTRY',2),(649,'83','ADD_TO_PAGE',4),(650,'83','CONFIGURATION',8),(651,'83','VIEW',1),(652,'83','PERMISSIONS',16),(653,'99','ACCESS_IN_CONTROL_PANEL',2),(654,'99','CONFIGURATION',4),(655,'99','VIEW',1),(656,'99','PERMISSIONS',8),(657,'com.liferay.portlet.asset.model.AssetTag','DELETE',2),(658,'com.liferay.portlet.asset.model.AssetTag','PERMISSIONS',4),(659,'com.liferay.portlet.asset.model.AssetTag','UPDATE',8),(660,'com.liferay.portlet.asset.model.AssetTag','VIEW',1),(661,'70','VIEW',1),(662,'70','ADD_TO_PAGE',2),(663,'70','CONFIGURATION',4),(664,'70','PERMISSIONS',8),(665,'164','VIEW',1),(666,'164','ADD_TO_PAGE',2),(667,'164','CONFIGURATION',4),(668,'164','PERMISSIONS',8),(669,'141','VIEW',1),(670,'141','ADD_TO_PAGE',2),(671,'141','CONFIGURATION',4),(672,'141','PERMISSIONS',8),(673,'9','VIEW',1),(674,'9','ADD_TO_PAGE',2),(675,'9','CONFIGURATION',4),(676,'9','PERMISSIONS',8),(677,'137','ACCESS_IN_CONTROL_PANEL',2),(678,'137','CONFIGURATION',4),(679,'137','VIEW',1),(680,'137','PERMISSIONS',8),(681,'28','ACCESS_IN_CONTROL_PANEL',2),(682,'28','ADD_TO_PAGE',4),(683,'28','CONFIGURATION',8),(684,'28','VIEW',1),(685,'28','PERMISSIONS',16),(686,'com.liferay.portlet.bookmarks.model.BookmarksFolder','ACCESS',2),(687,'com.liferay.portlet.bookmarks.model.BookmarksFolder','ADD_ENTRY',4),(688,'com.liferay.portlet.bookmarks.model.BookmarksFolder','ADD_SUBFOLDER',8),(689,'com.liferay.portlet.bookmarks.model.BookmarksFolder','DELETE',16),(690,'com.liferay.portlet.bookmarks.model.BookmarksFolder','PERMISSIONS',32),(691,'com.liferay.portlet.bookmarks.model.BookmarksFolder','UPDATE',64),(692,'com.liferay.portlet.bookmarks.model.BookmarksFolder','VIEW',1),(693,'com.liferay.portlet.bookmarks','ADD_ENTRY',2),(694,'com.liferay.portlet.bookmarks','ADD_FOLDER',4),(695,'com.liferay.portlet.bookmarks','PERMISSIONS',8),(696,'com.liferay.portlet.bookmarks','VIEW',1),(697,'com.liferay.portlet.bookmarks.model.BookmarksEntry','DELETE',2),(698,'com.liferay.portlet.bookmarks.model.BookmarksEntry','PERMISSIONS',4),(699,'com.liferay.portlet.bookmarks.model.BookmarksEntry','UPDATE',8),(700,'com.liferay.portlet.bookmarks.model.BookmarksEntry','VIEW',1),(701,'133','VIEW',1),(702,'133','ADD_TO_PAGE',2),(703,'133','CONFIGURATION',4),(704,'133','PERMISSIONS',8),(705,'116','VIEW',1),(706,'116','ADD_TO_PAGE',2),(707,'116','CONFIGURATION',4),(708,'116','PERMISSIONS',8),(709,'15','ACCESS_IN_CONTROL_PANEL',2),(710,'15','ADD_TO_PAGE',4),(711,'15','CONFIGURATION',8),(712,'15','VIEW',1),(713,'15','PERMISSIONS',16),(714,'com.liferay.portlet.journal.model.JournalFeed','DELETE',2),(715,'com.liferay.portlet.journal.model.JournalFeed','PERMISSIONS',4),(716,'com.liferay.portlet.journal.model.JournalFeed','UPDATE',8),(717,'com.liferay.portlet.journal.model.JournalFeed','VIEW',1),(718,'com.liferay.portlet.journal.model.JournalArticle','ADD_DISCUSSION',2),(719,'com.liferay.portlet.journal.model.JournalArticle','DELETE',4),(720,'com.liferay.portlet.journal.model.JournalArticle','DELETE_DISCUSSION',8),(721,'com.liferay.portlet.journal.model.JournalArticle','EXPIRE',16),(722,'com.liferay.portlet.journal.model.JournalArticle','PERMISSIONS',32),(723,'com.liferay.portlet.journal.model.JournalArticle','UPDATE',64),(724,'com.liferay.portlet.journal.model.JournalArticle','UPDATE_DISCUSSION',128),(725,'com.liferay.portlet.journal.model.JournalArticle','VIEW',1),(726,'com.liferay.portlet.journal','ADD_ARTICLE',2),(727,'com.liferay.portlet.journal','ADD_FEED',4),(728,'com.liferay.portlet.journal','ADD_STRUCTURE',8),(729,'com.liferay.portlet.journal','ADD_TEMPLATE',16),(730,'com.liferay.portlet.journal','SUBSCRIBE',32),(731,'com.liferay.portlet.journal','PERMISSIONS',64),(732,'com.liferay.portlet.journal.model.JournalStructure','DELETE',2),(733,'com.liferay.portlet.journal.model.JournalStructure','PERMISSIONS',4),(734,'com.liferay.portlet.journal.model.JournalStructure','UPDATE',8),(735,'com.liferay.portlet.journal.model.JournalStructure','VIEW',1),(736,'com.liferay.portlet.journal.model.JournalTemplate','DELETE',2),(737,'com.liferay.portlet.journal.model.JournalTemplate','PERMISSIONS',4),(738,'com.liferay.portlet.journal.model.JournalTemplate','UPDATE',8),(739,'com.liferay.portlet.journal.model.JournalTemplate','VIEW',1),(740,'47','VIEW',1),(741,'47','ADD_TO_PAGE',2),(742,'47','CONFIGURATION',4),(743,'47','PERMISSIONS',8),(744,'82','VIEW',1),(745,'82','ADD_TO_PAGE',2),(746,'82','CONFIGURATION',4),(747,'82','PERMISSIONS',8),(748,'103','VIEW',1),(749,'103','ADD_TO_PAGE',2),(750,'103','CONFIGURATION',4),(751,'103','PERMISSIONS',8),(752,'151','ACCESS_IN_CONTROL_PANEL',2),(753,'151','CONFIGURATION',4),(754,'151','VIEW',1),(755,'151','PERMISSIONS',8),(756,'140','ACCESS_IN_CONTROL_PANEL',2),(757,'140','CONFIGURATION',4),(758,'140','VIEW',1),(759,'140','PERMISSIONS',8),(760,'54','VIEW',1),(761,'54','ADD_TO_PAGE',2),(762,'54','CONFIGURATION',4),(763,'54','PERMISSIONS',8),(764,'169','VIEW',1),(765,'169','ADD_TO_PAGE',2),(766,'169','CONFIGURATION',4),(767,'169','PERMISSIONS',8),(768,'132','ACCESS_IN_CONTROL_PANEL',2),(769,'132','CONFIGURATION',4),(770,'132','VIEW',1),(771,'132','PERMISSIONS',8),(772,'34','ADD_TO_PAGE',2),(773,'34','CONFIGURATION',4),(774,'34','VIEW',1),(775,'34','PERMISSIONS',8),(776,'com.liferay.portlet.shopping','ADD_CATEGORY',2),(777,'com.liferay.portlet.shopping','ADD_ITEM',4),(778,'com.liferay.portlet.shopping','MANAGE_COUPONS',8),(779,'com.liferay.portlet.shopping','MANAGE_ORDERS',16),(780,'com.liferay.portlet.shopping','PERMISSIONS',32),(781,'com.liferay.portlet.shopping','VIEW',1),(782,'com.liferay.portlet.shopping.model.ShoppingCategory','ADD_ITEM',2),(783,'com.liferay.portlet.shopping.model.ShoppingCategory','ADD_SUBCATEGORY',4),(784,'com.liferay.portlet.shopping.model.ShoppingCategory','DELETE',8),(785,'com.liferay.portlet.shopping.model.ShoppingCategory','PERMISSIONS',16),(786,'com.liferay.portlet.shopping.model.ShoppingCategory','UPDATE',32),(787,'com.liferay.portlet.shopping.model.ShoppingCategory','VIEW',1),(788,'com.liferay.portlet.shopping.model.ShoppingOrder','DELETE',2),(789,'com.liferay.portlet.shopping.model.ShoppingOrder','PERMISSIONS',4),(790,'com.liferay.portlet.shopping.model.ShoppingOrder','UPDATE',8),(791,'com.liferay.portlet.shopping.model.ShoppingOrder','VIEW',1),(792,'com.liferay.portlet.shopping.model.ShoppingItem','DELETE',2),(793,'com.liferay.portlet.shopping.model.ShoppingItem','PERMISSIONS',4),(794,'com.liferay.portlet.shopping.model.ShoppingItem','UPDATE',8),(795,'com.liferay.portlet.shopping.model.ShoppingItem','VIEW',1),(796,'61','VIEW',1),(797,'61','ADD_TO_PAGE',2),(798,'61','CONFIGURATION',4),(799,'61','PERMISSIONS',8),(800,'73','ADD_TO_PAGE',2),(801,'73','CONFIGURATION',4),(802,'73','VIEW',1),(803,'73','PERMISSIONS',8),(804,'31','VIEW',1),(805,'31','ADD_TO_PAGE',2),(806,'31','CONFIGURATION',4),(807,'31','PERMISSIONS',8),(808,'165','VIEW',1),(809,'165','ADD_TO_PAGE',2),(810,'165','ACCESS_IN_CONTROL_PANEL',4),(811,'165','CONFIGURATION',8),(812,'165','PERMISSIONS',16),(813,'136','ACCESS_IN_CONTROL_PANEL',2),(814,'136','CONFIGURATION',4),(815,'136','VIEW',1),(816,'136','PERMISSIONS',8),(817,'127','VIEW',1),(818,'127','ADD_TO_PAGE',2),(819,'127','ACCESS_IN_CONTROL_PANEL',4),(820,'127','CONFIGURATION',8),(821,'127','PERMISSIONS',16),(822,'50','VIEW',1),(823,'50','ADD_TO_PAGE',2),(824,'50','CONFIGURATION',4),(825,'50','PERMISSIONS',8),(826,'25','ACCESS_IN_CONTROL_PANEL',2),(827,'25','CONFIGURATION',4),(828,'25','VIEW',1),(829,'25','PERMISSIONS',8),(830,'com.liferay.portlet.polls','ADD_QUESTION',2),(831,'com.liferay.portlet.polls','PERMISSIONS',4),(832,'com.liferay.portlet.polls.model.PollsQuestion','ADD_VOTE',2),(833,'com.liferay.portlet.polls.model.PollsQuestion','DELETE',4),(834,'com.liferay.portlet.polls.model.PollsQuestion','PERMISSIONS',8),(835,'com.liferay.portlet.polls.model.PollsQuestion','UPDATE',16),(836,'com.liferay.portlet.polls.model.PollsQuestion','VIEW',1),(837,'166','ACCESS_IN_CONTROL_PANEL',2),(838,'166','ADD_TO_PAGE',4),(839,'166','CONFIGURATION',8),(840,'166','VIEW',1),(841,'166','PERMISSIONS',16),(842,'com.liferay.portlet.dynamicdatamapping.model.DDMTemplate','DELETE',2),(843,'com.liferay.portlet.dynamicdatamapping.model.DDMTemplate','PERMISSIONS',4),(844,'com.liferay.portlet.dynamicdatamapping.model.DDMTemplate','UPDATE',8),(845,'com.liferay.portlet.dynamicdatamapping.model.DDMTemplate','VIEW',1),(846,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure','DELETE',2),(847,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure','PERMISSIONS',4),(848,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure','UPDATE',8),(849,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure','VIEW',1),(850,'90','ADD_COMMUNITY',2),(851,'90','ADD_LAYOUT_PROTOTYPE',4),(852,'90','ADD_LAYOUT_SET_PROTOTYPE',8),(853,'90','ADD_LICENSE',16),(854,'90','ADD_ORGANIZATION',32),(855,'90','ADD_PASSWORD_POLICY',64),(856,'90','ADD_ROLE',128),(857,'90','ADD_USER',256),(858,'90','ADD_USER_GROUP',512),(859,'90','CONFIGURATION',1024),(860,'90','EXPORT_USER',2048),(861,'90','IMPERSONATE',4096),(862,'90','UNLINK_LAYOUT_SET_PROTOTYPE',8192),(863,'90','VIEW_CONTROL_PANEL',16384),(864,'90','ADD_TO_PAGE',32768),(865,'90','PERMISSIONS',65536),(866,'90','VIEW',1),(867,'150','ACCESS_IN_CONTROL_PANEL',2),(868,'150','CONFIGURATION',4),(869,'150','VIEW',1),(870,'150','PERMISSIONS',8),(871,'113','VIEW',1),(872,'113','ADD_TO_PAGE',2),(873,'113','CONFIGURATION',4),(874,'113','PERMISSIONS',8),(875,'33','ADD_TO_PAGE',2),(876,'33','CONFIGURATION',4),(877,'33','VIEW',1),(878,'33','PERMISSIONS',8),(879,'com.liferay.portlet.blogs','ADD_ENTRY',2),(880,'com.liferay.portlet.blogs','PERMISSIONS',4),(881,'com.liferay.portlet.blogs','SUBSCRIBE',8),(882,'com.liferay.portlet.blogs.model.BlogsEntry','ADD_DISCUSSION',2),(883,'com.liferay.portlet.blogs.model.BlogsEntry','DELETE',4),(884,'com.liferay.portlet.blogs.model.BlogsEntry','DELETE_DISCUSSION',8),(885,'com.liferay.portlet.blogs.model.BlogsEntry','PERMISSIONS',16),(886,'com.liferay.portlet.blogs.model.BlogsEntry','UPDATE',32),(887,'com.liferay.portlet.blogs.model.BlogsEntry','UPDATE_DISCUSSION',64),(888,'com.liferay.portlet.blogs.model.BlogsEntry','VIEW',1),(889,'2','ACCESS_IN_CONTROL_PANEL',2),(890,'2','CONFIGURATION',4),(891,'2','VIEW',1),(892,'2','PERMISSIONS',8),(893,'119','VIEW',1),(894,'119','ADD_TO_PAGE',2),(895,'119','CONFIGURATION',4),(896,'119','PERMISSIONS',8),(897,'114','VIEW',1),(898,'114','ADD_TO_PAGE',2),(899,'114','CONFIGURATION',4),(900,'114','PERMISSIONS',8),(901,'149','ACCESS_IN_CONTROL_PANEL',2),(902,'149','CONFIGURATION',4),(903,'149','VIEW',1),(904,'149','PERMISSIONS',8),(905,'com.liferay.portal.model.LayoutSetPrototype','DELETE',2),(906,'com.liferay.portal.model.LayoutSetPrototype','PERMISSIONS',4),(907,'com.liferay.portal.model.LayoutSetPrototype','UPDATE',8),(908,'com.liferay.portal.model.LayoutSetPrototype','VIEW',1),(909,'67','VIEW',1),(910,'67','ADD_TO_PAGE',2),(911,'67','CONFIGURATION',4),(912,'67','PERMISSIONS',8),(913,'110','VIEW',1),(914,'110','ADD_TO_PAGE',2),(915,'110','CONFIGURATION',4),(916,'110','PERMISSIONS',8),(917,'135','ACCESS_IN_CONTROL_PANEL',2),(918,'135','CONFIGURATION',4),(919,'135','VIEW',1),(920,'135','PERMISSIONS',8),(921,'59','VIEW',1),(922,'59','ADD_TO_PAGE',2),(923,'59','CONFIGURATION',4),(924,'59','PERMISSIONS',8),(925,'131','ACCESS_IN_CONTROL_PANEL',2),(926,'131','CONFIGURATION',4),(927,'131','VIEW',1),(928,'131','PERMISSIONS',8),(929,'102','VIEW',1),(930,'102','ADD_TO_PAGE',2),(931,'102','CONFIGURATION',4),(932,'102','PERMISSIONS',8),(1001,'ProcessToolTasks_WAR_aperteworkflow','VIEW',1),(1002,'ProcessToolTasks_WAR_aperteworkflow','ADD_TO_PAGE',2),(1003,'ProcessToolTasks_WAR_aperteworkflow','CONFIGURATION',4),(1004,'ProcessToolTasks_WAR_aperteworkflow','PERMISSIONS',8),(1005,'ProcessToolQueues_WAR_aperteworkflow','VIEW',1),(1006,'ProcessToolQueues_WAR_aperteworkflow','ADD_TO_PAGE',2),(1007,'ProcessToolQueues_WAR_aperteworkflow','CONFIGURATION',4),(1008,'ProcessToolQueues_WAR_aperteworkflow','PERMISSIONS',8),(1009,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow','VIEW',1),(1010,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow','ADD_TO_PAGE',2),(1011,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow','ACCESS_IN_CONTROL_PANEL',4),(1012,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow','CONFIGURATION',8),(1013,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow','PERMISSIONS',16),(1014,'ProcessToolUserSubstitutions_WAR_aperteworkflow','VIEW',1),(1015,'ProcessToolUserSubstitutions_WAR_aperteworkflow','ADD_TO_PAGE',2),(1016,'ProcessToolUserSubstitutions_WAR_aperteworkflow','CONFIGURATION',4),(1017,'ProcessToolUserSubstitutions_WAR_aperteworkflow','PERMISSIONS',8),(1018,'ProcessToolDictionaries_WAR_aperteworkflow','VIEW',1),(1019,'ProcessToolDictionaries_WAR_aperteworkflow','ADD_TO_PAGE',2),(1020,'ProcessToolDictionaries_WAR_aperteworkflow','CONFIGURATION',4),(1021,'ProcessToolDictionaries_WAR_aperteworkflow','PERMISSIONS',8),(1022,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow','VIEW',1),(1023,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow','ADD_TO_PAGE',2),(1024,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow','ACCESS_IN_CONTROL_PANEL',4),(1025,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow','CONFIGURATION',8),(1026,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow','PERMISSIONS',16),(1027,'AperteWorkflowPluginManager_WAR_aperteworkflow','VIEW',1),(1028,'AperteWorkflowPluginManager_WAR_aperteworkflow','ADD_TO_PAGE',2),(1029,'AperteWorkflowPluginManager_WAR_aperteworkflow','ACCESS_IN_CONTROL_PANEL',4),(1030,'AperteWorkflowPluginManager_WAR_aperteworkflow','CONFIGURATION',8),(1031,'AperteWorkflowPluginManager_WAR_aperteworkflow','PERMISSIONS',16),(1032,'ProcessToolActivities_WAR_aperteworkflow','VIEW',1),(1033,'ProcessToolActivities_WAR_aperteworkflow','ADD_TO_PAGE',2),(1034,'ProcessToolActivities_WAR_aperteworkflow','CONFIGURATION',4),(1035,'ProcessToolActivities_WAR_aperteworkflow','PERMISSIONS',8),(1101,'AperteWorkflowAdminPortlet_WAR_aperteworkflow','VIEW',1),(1102,'AperteWorkflowAdminPortlet_WAR_aperteworkflow','ADD_TO_PAGE',2),(1103,'AperteWorkflowAdminPortlet_WAR_aperteworkflow','ACCESS_IN_CONTROL_PANEL',4),(1104,'AperteWorkflowAdminPortlet_WAR_aperteworkflow','CONFIGURATION',8),(1105,'AperteWorkflowAdminPortlet_WAR_aperteworkflow','PERMISSIONS',16),(1106,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow','VIEW',1),(1107,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow','ADD_TO_PAGE',2),(1108,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow','ACCESS_IN_CONTROL_PANEL',4),(1109,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow','CONFIGURATION',8),(1110,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow','PERMISSIONS',16),(1111,'AperteWorkflowUserPortlet_WAR_aperteworkflow','PREFERENCES',2),(1112,'AperteWorkflowUserPortlet_WAR_aperteworkflow','VIEW',1),(1113,'AperteWorkflowUserPortlet_WAR_aperteworkflow','ADD_TO_PAGE',4),(1114,'AperteWorkflowUserPortlet_WAR_aperteworkflow','CONFIGURATION',8),(1115,'AperteWorkflowUserPortlet_WAR_aperteworkflow','PERMISSIONS',16),(1201,'4_WAR_opensocialportlet','ACCESS_IN_CONTROL_PANEL',2),(1202,'4_WAR_opensocialportlet','CONFIGURATION',4),(1203,'4_WAR_opensocialportlet','VIEW',1),(1204,'4_WAR_opensocialportlet','PERMISSIONS',8),(1205,'2_WAR_opensocialportlet','ADD_TO_PAGE',2),(1206,'2_WAR_opensocialportlet','CONFIGURATION',4),(1207,'2_WAR_opensocialportlet','VIEW',1),(1208,'2_WAR_opensocialportlet','PERMISSIONS',8),(1209,'1_WAR_opensocialportlet','ACCESS_IN_CONTROL_PANEL',2),(1210,'1_WAR_opensocialportlet','CONFIGURATION',4),(1211,'1_WAR_opensocialportlet','VIEW',1),(1212,'1_WAR_opensocialportlet','PERMISSIONS',8),(1213,'com.liferay.opensocial.model.Gadget','DELETE',2),(1214,'com.liferay.opensocial.model.Gadget','PERMISSIONS',4),(1215,'com.liferay.opensocial.model.Gadget','UPDATE',8),(1216,'com.liferay.opensocial.model.Gadget','VIEW',1),(1217,'com.liferay.opensocial','PERMISSIONS',2),(1218,'com.liferay.opensocial','PUBLISH_GADGET',4),(1219,'3_WAR_opensocialportlet','ADD_TO_PAGE',2),(1220,'3_WAR_opensocialportlet','CONFIGURATION',4),(1221,'3_WAR_opensocialportlet','VIEW',1),(1222,'3_WAR_opensocialportlet','PERMISSIONS',8),(1223,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf','VIEW',1),(1224,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf','ADD_TO_PAGE',2),(1225,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf','CONFIGURATION',4),(1226,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf','PERMISSIONS',8),(1227,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965','VIEW',1),(1228,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965','ADD_TO_PAGE',2),(1229,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965','CONFIGURATION',4),(1230,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965','PERMISSIONS',8),(1231,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6','VIEW',1),(1232,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6','ADD_TO_PAGE',2),(1233,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6','CONFIGURATION',4),(1234,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6','PERMISSIONS',8),(1235,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153','VIEW',1),(1236,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153','ADD_TO_PAGE',2),(1237,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153','CONFIGURATION',4),(1238,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153','PERMISSIONS',8),(1301,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1','VIEW',1),(1302,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1','ADD_TO_PAGE',2),(1303,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1','CONFIGURATION',4),(1304,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1','PERMISSIONS',8),(1305,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc','VIEW',1),(1306,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc','ADD_TO_PAGE',2),(1307,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc','CONFIGURATION',4),(1308,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc','PERMISSIONS',8),(1309,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688','VIEW',1),(1310,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688','ADD_TO_PAGE',2),(1311,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688','CONFIGURATION',4),(1312,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688','PERMISSIONS',8),(1401,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552','VIEW',1),(1402,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552','ADD_TO_PAGE',2),(1403,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552','CONFIGURATION',4),(1404,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552','PERMISSIONS',8),(1501,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0','VIEW',1),(1502,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0','ADD_TO_PAGE',2),(1503,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0','CONFIGURATION',4),(1504,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0','PERMISSIONS',8),(1601,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95','VIEW',1),(1602,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95','ADD_TO_PAGE',2),(1603,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95','CONFIGURATION',4),(1604,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95','PERMISSIONS',8),(1701,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021','VIEW',1),(1702,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021','ADD_TO_PAGE',2),(1703,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021','CONFIGURATION',4),(1704,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021','PERMISSIONS',8),(1801,'VirtualEnterpriseManagerApplicationportlet_WAR_VirtualEnterpriseManager_portlet','VIEW',1),(1802,'VirtualEnterpriseManagerApplicationportlet_WAR_VirtualEnterpriseManager_portlet','ADD_TO_PAGE',2),(1803,'VirtualEnterpriseManagerApplicationportlet_WAR_VirtualEnterpriseManager_portlet','CONFIGURATION',4),(1804,'VirtualEnterpriseManagerApplicationportlet_WAR_VirtualEnterpriseManager_portlet','PERMISSIONS',8),(1901,'VirtualEnterpriseManagementApplicationportlet_WAR_MSEE_VirtualEnterpriseRegistry_portlet','VIEW',1),(1902,'VirtualEnterpriseManagementApplicationportlet_WAR_MSEE_VirtualEnterpriseRegistry_portlet','ADD_TO_PAGE',2),(1903,'VirtualEnterpriseManagementApplicationportlet_WAR_MSEE_VirtualEnterpriseRegistry_portlet','CONFIGURATION',4),(1904,'VirtualEnterpriseManagementApplicationportlet_WAR_MSEE_VirtualEnterpriseRegistry_portlet','PERMISSIONS',8),(2001,'Msee_Asset_View_WAR_MSEE_Asset_View','VIEW',1),(2002,'Msee_Asset_View_WAR_MSEE_Asset_View','ADD_TO_PAGE',2),(2003,'Msee_Asset_View_WAR_MSEE_Asset_View','CONFIGURATION',4),(2004,'Msee_Asset_View_WAR_MSEE_Asset_View','PERMISSIONS',8),(2005,'AssetComposing_WAR_MSEE_Asset_View','VIEW',1),(2006,'AssetComposing_WAR_MSEE_Asset_View','ADD_TO_PAGE',2),(2007,'AssetComposing_WAR_MSEE_Asset_View','CONFIGURATION',4),(2008,'AssetComposing_WAR_MSEE_Asset_View','PERMISSIONS',8),(2009,'Msee_Asset_View_WAR_MSEE_Asset_View1','VIEW',1),(2010,'Msee_Asset_View_WAR_MSEE_Asset_View1','ADD_TO_PAGE',2),(2011,'Msee_Asset_View_WAR_MSEE_Asset_View1','CONFIGURATION',4),(2012,'Msee_Asset_View_WAR_MSEE_Asset_View1','PERMISSIONS',8),(2013,'AssetComposing_WAR_MSEE_Asset_View1','VIEW',1),(2014,'AssetComposing_WAR_MSEE_Asset_View1','ADD_TO_PAGE',2),(2015,'AssetComposing_WAR_MSEE_Asset_View1','CONFIGURATION',4),(2016,'AssetComposing_WAR_MSEE_Asset_View1','PERMISSIONS',8),(2101,'MSEE_PerformanceIndicatorRegistry_Portlet_WAR_MSEE_PerformanceIndicatorRegistry_Portlet','VIEW',1),(2102,'MSEE_PerformanceIndicatorRegistry_Portlet_WAR_MSEE_PerformanceIndicatorRegistry_Portlet','ADD_TO_PAGE',2),(2103,'MSEE_PerformanceIndicatorRegistry_Portlet_WAR_MSEE_PerformanceIndicatorRegistry_Portlet','CONFIGURATION',4),(2104,'MSEE_PerformanceIndicatorRegistry_Portlet_WAR_MSEE_PerformanceIndicatorRegistry_Portlet','PERMISSIONS',8),(2201,'AssetComposing_WAR_MSEE_Asset_View_Service','VIEW',1),(2202,'AssetComposing_WAR_MSEE_Asset_View_Service','ADD_TO_PAGE',2),(2203,'AssetComposing_WAR_MSEE_Asset_View_Service','CONFIGURATION',4),(2204,'AssetComposing_WAR_MSEE_Asset_View_Service','PERMISSIONS',8),(2301,'Asset_View_WAR_Asset_Viewer_Rep','VIEW',1),(2302,'Asset_View_WAR_Asset_Viewer_Rep','ADD_TO_PAGE',2),(2303,'Asset_View_WAR_Asset_Viewer_Rep','CONFIGURATION',4),(2304,'Asset_View_WAR_Asset_Viewer_Rep','PERMISSIONS',8),(2305,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep','VIEW',1),(2306,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep','ADD_TO_PAGE',2),(2307,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep','CONFIGURATION',4),(2308,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep','PERMISSIONS',8);
/*!40000 ALTER TABLE `resourceaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repositoryentry`
--

DROP TABLE IF EXISTS `repositoryentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repositoryentry` (
  `uuid_` varchar(75) DEFAULT NULL,
  `repositoryEntryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `repositoryId` bigint(20) DEFAULT NULL,
  `mappedId` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`repositoryEntryId`),
  UNIQUE KEY `IX_9BDCF489` (`repositoryId`,`mappedId`),
  UNIQUE KEY `IX_354AA664` (`uuid_`,`groupId`),
  KEY `IX_B7034B27` (`repositoryId`),
  KEY `IX_B9B1506` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repositoryentry`
--

LOCK TABLES `repositoryentry` WRITE;
/*!40000 ALTER TABLE `repositoryentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `repositoryentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddmstructurelink`
--

DROP TABLE IF EXISTS `ddmstructurelink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddmstructurelink` (
  `structureLinkId` bigint(20) NOT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `structureId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`structureLinkId`),
  UNIQUE KEY `IX_C803899D` (`classPK`),
  KEY `IX_D43E4208` (`classNameId`),
  KEY `IX_17692B58` (`structureId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddmstructurelink`
--

LOCK TABLES `ddmstructurelink` WRITE;
/*!40000 ALTER TABLE `ddmstructurelink` DISABLE KEYS */;
INSERT INTO `ddmstructurelink` VALUES (10454,10089,10435,10308),(10464,10089,10461,10308),(10470,10089,10467,10308),(10482,10089,10478,10308),(10492,10089,10489,10308),(10504,10089,10501,10308),(10516,10089,10513,10308),(10522,10089,10519,10308),(10534,10089,10529,10308),(10546,10089,10541,10308),(10558,10089,10554,10308),(10570,10089,10565,10308),(10580,10089,10577,10308),(11654,10089,11629,10308),(11666,10089,11657,10308),(11680,10089,11677,10308),(11686,10089,11683,10308),(11693,10089,11690,10308),(11697,10089,11694,10308),(11701,10089,11698,10308),(13130,10089,13127,10308),(13147,10089,13144,10308),(13163,10089,13160,10308),(13198,10089,13195,10308),(13287,10089,13284,10308),(13358,10089,13355,10308),(15309,10089,15306,10308),(18312,10089,18309,10308);
/*!40000 ALTER TABLE `ddmstructurelink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlsync`
--

DROP TABLE IF EXISTS `dlsync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlsync` (
  `syncId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `fileId` bigint(20) DEFAULT NULL,
  `fileUuid` varchar(75) DEFAULT NULL,
  `repositoryId` bigint(20) DEFAULT NULL,
  `parentFolderId` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` longtext,
  `event` varchar(75) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`syncId`),
  UNIQUE KEY `IX_F9821AB4` (`fileId`),
  KEY `IX_B53EC783` (`companyId`,`modifiedDate`,`repositoryId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlsync`
--

LOCK TABLES `dlsync` WRITE;
/*!40000 ALTER TABLE `dlsync` DISABLE KEYS */;
INSERT INTO `dlsync` VALUES (10432,10153,'2012-09-10 08:56:54','2012-09-10 08:56:54',10419,'068f742f-ddac-4214-96c0-70f51b14e43b',10179,0,'welcome_bg_3.jpg','','add','file','1.0'),(10441,10153,'2012-09-10 08:56:55','2012-09-10 08:56:55',10433,'ba3cd525-bf69-4d62-b116-52bb08e6e83d',10179,0,'welcome_bg_11.jpg','','add','file','1.0'),(10451,10153,'2012-09-10 08:56:56','2012-09-10 08:56:56',10444,'0107fbe8-7216-415f-b52a-4ccc58b1ed94',10179,0,'welcome_bg_12.jpg','','add','file','1.0'),(10460,10153,'2012-09-10 08:56:56','2012-09-10 08:56:56',10452,'5f6a7b5d-40f5-44f7-9374-4b8e6a761ab5',10179,0,'welcome_bg_10.png','','add','file','1.0'),(10476,10153,'2012-09-10 08:56:57','2012-09-10 08:56:57',10465,'d5c27f88-fd99-4b14-b799-a8693f91cd73',10179,0,'welcome_bg_2.jpg','','add','file','1.0'),(10488,10153,'2012-09-10 08:56:57','2012-09-10 08:56:57',10477,'a4deb9c1-ce55-4c8d-a4a9-cd61bc9ad1c5',10179,0,'welcome_bg_9.jpg','','add','file','1.0'),(10500,10153,'2012-09-10 08:56:57','2012-09-10 08:56:57',10493,'f02472f3-8d71-4305-a26e-92884af82fef',10179,0,'welcome_bg_4.jpg','','add','file','1.0'),(10512,10153,'2012-09-10 08:56:58','2012-09-10 08:56:58',10505,'2fa90a9b-c8b2-4083-80a5-d0dbe8cae6de',10179,0,'welcome_bg_6.jpg','','add','file','1.0'),(10528,10153,'2012-09-10 08:56:58','2012-09-10 08:56:58',10517,'e6f1975c-5f13-4ace-ab23-378458c3d7be',10179,0,'welcome_bg_7.jpg','','add','file','1.0'),(10540,10153,'2012-09-10 08:56:59','2012-09-10 08:56:59',10530,'b7e62e15-d2cf-428e-ba1a-fe95ed129375',10179,0,'welcome_bg_5.jpg','','add','file','1.0'),(10552,10153,'2012-09-10 08:56:59','2012-09-10 08:56:59',10542,'2b98a30e-b5f7-4afa-8b0e-f220c318d8d4',10179,0,'welcome_bg_13.jpg','','add','file','1.0'),(10564,10153,'2012-09-10 08:56:59','2012-09-10 08:56:59',10553,'d25df879-c9eb-4fbc-8dc1-fad3589dfae2',10179,0,'welcome_bg_1.jpg','','add','file','1.0'),(10576,10153,'2012-09-10 08:56:59','2012-09-10 08:56:59',10566,'5b6cf4a9-eb60-471d-804c-7d45660670b2',10179,0,'welcome_bg_8.jpg','','add','file','1.0'),(11620,10153,'2012-09-26 15:45:39','2012-09-26 15:45:39',11613,'d1ec5a7d-7a2d-4441-95db-4139d93c51c2',11605,0,'trophy_icon.png','','add','file','1.0'),(11628,10153,'2012-09-26 15:45:40','2012-09-26 15:45:40',11621,'89e0fc78-6945-4566-849d-91e6a2e88944',11605,0,'image3.png','','add','file','1.0'),(11637,10153,'2012-09-26 15:45:40','2012-09-26 15:45:40',11630,'945d2d6b-b3ee-4fa4-b94b-26fec1bd94c9',11605,0,'download_icon.png','','add','file','1.0'),(11645,10153,'2012-09-26 15:45:41','2012-09-26 15:45:41',11638,'64faafc9-fe6d-4ef8-bed0-49a99da3cc60',11605,0,'image2.png','','add','file','1.0'),(11656,10153,'2012-09-26 15:45:42','2012-09-26 15:45:42',11646,'428bed71-cec0-4e6b-be48-c7a2b1d7cd61',11605,0,'image1.png','','add','file','1.0'),(11668,10153,'2012-09-26 15:45:42','2012-09-26 15:45:42',11658,'db0dce92-e663-495b-9e34-a87a912d6638',11605,0,'strategy_icon.png','','add','file','1.0'),(11676,10153,'2012-09-26 15:45:42','2012-09-26 15:45:42',11669,'fed7a05f-fd0a-4126-8944-4f1fabccb73a',11605,0,'gears_icon.png','','add','file','1.0'),(12002,10153,'2012-10-02 08:17:44','2012-10-02 08:17:44',12001,'8fbf48f5-7113-4e31-a670-2c65acd8c83c',10179,0,'Documents','Documents root folder','add','folder','-1'),(13126,10153,'2012-11-29 11:49:59','2012-11-29 11:49:59',13119,'fa67ae45-0000-4b0c-bdc6-660450a826af',10191,0,'SouthAmerica.jpg','','add','file','1.0'),(13143,10153,'2012-11-29 11:57:31','2012-11-29 11:57:31',13136,'5f8df2be-67f4-4573-908b-6ed37bddd4c6',10191,0,'M&S.jpeg','','add','file','1.0'),(13159,10153,'2012-11-29 12:09:56','2012-11-29 12:09:56',13152,'93dd05f8-fae4-4cd2-9a43-de40a73e9249',10191,0,'configurator.jpeg','','add','file','1.0'),(13194,10153,'2012-11-29 13:58:27','2012-11-29 13:58:27',13187,'114d0615-8445-4cb2-871d-99ef6559128e',10191,0,'upload-textile-machinery.png','','add','file','1.0'),(13283,10153,'2012-11-29 14:28:41','2012-11-29 14:28:41',13276,'985ba964-426c-4193-9456-6b8c64be1f85',10191,0,'europe-partners.png','','add','file','1.0'),(13354,10153,'2012-11-29 14:36:17','2012-11-29 14:36:17',13347,'e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5',10191,0,'europe-partners1.png','','add','file','1.0'),(15218,10153,'2013-05-10 08:38:38','2013-05-10 08:38:38',15217,'fd608006-14b2-4a0f-abfc-3a3d1631b33f',12104,0,'OpenSocial Gadgets','','add','folder','-1'),(15305,10153,'2013-05-10 13:38:58','2013-05-10 13:38:58',15298,'d4feb609-4aea-4861-9b05-7365cb91ab5b',10191,0,'MantAPP.png','','add','file','1.0'),(18308,10153,'2014-03-04 08:49:43','2014-03-04 08:49:43',18301,'2f96a36c-df13-4aba-b148-ff0b95d3cd53',10191,0,'bkg-index.jpg','','add','file','1.0');
/*!40000 ALTER TABLE `dlsync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourceblock`
--

DROP TABLE IF EXISTS `resourceblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourceblock` (
  `resourceBlockId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `permissionsHash` varchar(75) DEFAULT NULL,
  `referenceCount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`resourceBlockId`),
  UNIQUE KEY `IX_AEEA209C` (`companyId`,`groupId`,`name`,`permissionsHash`),
  KEY `IX_DA30B086` (`companyId`,`groupId`,`name`),
  KEY `IX_2D4CC782` (`companyId`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourceblock`
--

LOCK TABLES `resourceblock` WRITE;
/*!40000 ALTER TABLE `resourceblock` DISABLE KEYS */;
/*!40000 ALTER TABLE `resourceblock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_simprop_triggers`
--

DROP TABLE IF EXISTS `quartz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` tinyint(4) DEFAULT NULL,
  `BOOL_PROP_2` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_simprop_triggers`
--

LOCK TABLES `quartz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `quartz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcecode`
--

DROP TABLE IF EXISTS `resourcecode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcecode` (
  `codeId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scope` int(11) DEFAULT NULL,
  PRIMARY KEY (`codeId`),
  UNIQUE KEY `IX_A32C097E` (`companyId`,`name`,`scope`),
  KEY `IX_717FDD47` (`companyId`),
  KEY `IX_AACAFF40` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcecode`
--

LOCK TABLES `resourcecode` WRITE;
/*!40000 ALTER TABLE `resourcecode` DISABLE KEYS */;
/*!40000 ALTER TABLE `resourcecode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `ticketId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `key_` varchar(75) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `extraInfo` longtext,
  `expirationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ticketId`),
  KEY `IX_B2468446` (`key_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcementsentry`
--

DROP TABLE IF EXISTS `announcementsentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcementsentry` (
  `uuid_` varchar(75) DEFAULT NULL,
  `entryId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `title` varchar(75) DEFAULT NULL,
  `content` longtext,
  `url` longtext,
  `type_` varchar(75) DEFAULT NULL,
  `displayDate` datetime DEFAULT NULL,
  `expirationDate` datetime DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `alert` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`entryId`),
  KEY `IX_A6EF0B81` (`classNameId`,`classPK`),
  KEY `IX_14F06A6B` (`classNameId`,`classPK`,`alert`),
  KEY `IX_D49C2E66` (`userId`),
  KEY `IX_1AFBDE08` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcementsentry`
--

LOCK TABLES `announcementsentry` WRITE;
/*!40000 ALTER TABLE `announcementsentry` DISABLE KEYS */;
INSERT INTO `announcementsentry` VALUES ('bfd8b0e1-2b2b-425f-8836-a99e61322708',13109,10153,12102,'Admin Amin','2012-11-29 11:32:22','2012-11-29 15:10:07',0,0,'Partnership with Marks&Spencer','<p>\n	<img alt=\"\" src=\"/documents/10191/0/M%26S.jpeg/5f8df2be-67f4-4573-908b-6ed37bddd4c6?t=1354190250997\" style=\"width: 100px; height: 38px; float: left;\" /></p>\n<p style=\"text-align: justify;\">\n	Marks&amp;Spences launched new on-line shirt configuration system based on the Bivolino configurator. The configurator is fully integrated in the M&amp;S on-line shop. Soon M&amp;S will be followed by other e-retailers, who are currently working with the Bivolino IT team to the finalization of the technical details.</p>','','news','2012-11-29 11:31:00','2012-12-29 11:31:00',0,0),('1ce1c849-2a6d-40e3-8274-dca124451907',13105,10153,12102,'Admin Amin','2012-11-29 11:29:29','2012-11-29 15:10:32',0,0,'New agreement with micro-plants in South America.','<p style=\"text-align: justify;\">\n	<img alt=\"\" src=\"/documents/10191/0/SouthAmerica.jpg/fa67ae45-0000-4b0c-bdc6-660450a826af?t=1354189798778\" style=\"width: 50px; height: 69px; float: left;\" />The new network of micro-plants in Brazil is highly integrated with a logistics multimodal platform that allows cutting delivery costs and time for the new market of South America. This new partnership is a key advancement towards the strategic entrance in the big and very attractive market of Brazil and of the whole South-Central America.</p>','','news','2012-11-29 11:27:00','2012-12-29 11:27:00',0,0),('1a32c6e5-057e-40f8-a1a5-103f2c895fee',13165,10153,12102,'Admin Amin','2012-11-29 12:13:06','2012-11-29 12:13:06',0,0,'Bivolino configurator for e-retailers.','<p>\n	&nbsp;</p>\n<p>\n	<img alt=\"\" src=\"/documents/10191/0/configurator.jpeg/93dd05f8-fae4-4cd2-9a43-de40a73e9249?t=1354190996293\" style=\"width: 100px; height: 74px; float: left;\" />Bivolino’s shirt configurator can be embedded into third party e-retailer portals through the iFrame technology. See how to&nbsp;<u>integrate the Bivolino’s shirt configurator</u>&nbsp;or&nbsp;<u>ask for support</u>. Embedding the shirt configurayor is easy and requires not more than 10 days for cistomizing the look&amp;feel and for configuring technical and business characteristics of the tool.</p>','','general','2012-11-29 12:06:00','2012-12-29 12:06:00',0,1);
/*!40000 ALTER TABLE `announcementsentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orggrouprole`
--

DROP TABLE IF EXISTS `orggrouprole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orggrouprole` (
  `organizationId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`organizationId`,`groupId`,`roleId`),
  KEY `IX_4A527DD3` (`groupId`),
  KEY `IX_AB044D1C` (`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orggrouprole`
--

LOCK TABLES `orggrouprole` WRITE;
/*!40000 ALTER TABLE `orggrouprole` DISABLE KEYS */;
/*!40000 ALTER TABLE `orggrouprole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_simple_triggers`
--

DROP TABLE IF EXISTS `quartz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(20) NOT NULL,
  `REPEAT_INTERVAL` bigint(20) NOT NULL,
  `TIMES_TRIGGERED` bigint(20) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_simple_triggers`
--

LOCK TABLES `quartz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `quartz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layoutsetprototype`
--

DROP TABLE IF EXISTS `layoutsetprototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layoutsetprototype` (
  `uuid_` varchar(75) DEFAULT NULL,
  `layoutSetPrototypeId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `settings_` longtext,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`layoutSetPrototypeId`),
  KEY `IX_55F63D98` (`companyId`),
  KEY `IX_9178FC71` (`companyId`,`active_`),
  KEY `IX_C5D69B24` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layoutsetprototype`
--

LOCK TABLES `layoutsetprototype` WRITE;
/*!40000 ALTER TABLE `layoutsetprototype` DISABLE KEYS */;
INSERT INTO `layoutsetprototype` VALUES ('0337634b-1f13-49ac-9e08-2ceb8c5b15e7',10337,10153,'2012-09-10 08:56:44','2012-09-10 08:56:45','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Community Site</Name></root>','Site with Forums, Calendar and Wiki','layoutsUpdateable=true',1),('32945cc5-38c0-44ab-bac1-e491d70b9eeb',10363,10153,'2012-09-10 08:56:45','2012-09-10 08:56:46','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Intranet Site</Name></root>','Site with Documents, Calendar and News','layoutsUpdateable=true',1),('f37908ee-c1e5-4911-adcb-6929be1993f4',11604,10153,'2012-09-26 15:45:36','2012-09-26 15:45:47','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Eng Brochure Theme</Name></root>','','layoutsUpdateable=true',1);
/*!40000 ALTER TABLE `layoutsetprototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcementsdelivery`
--

DROP TABLE IF EXISTS `announcementsdelivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcementsdelivery` (
  `deliveryId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `email` tinyint(4) DEFAULT NULL,
  `sms` tinyint(4) DEFAULT NULL,
  `website` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`deliveryId`),
  UNIQUE KEY `IX_BA4413D5` (`userId`,`type_`),
  KEY `IX_6EDB9600` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcementsdelivery`
--

LOCK TABLES `announcementsdelivery` WRITE;
/*!40000 ALTER TABLE `announcementsdelivery` DISABLE KEYS */;
INSERT INTO `announcementsdelivery` VALUES (12108,10153,12102,'general',0,0,0),(12109,10153,12102,'news',0,0,0),(12110,10153,12102,'test',0,0,0),(16315,10153,16308,'news',0,0,0),(16314,10153,16308,'general',0,0,0),(16316,10153,16308,'test',0,0,0),(16408,10153,16402,'general',0,0,0),(16409,10153,16402,'news',0,0,0),(16410,10153,16402,'test',0,0,0),(16428,10153,16422,'general',0,0,0),(16429,10153,16422,'news',0,0,0),(16430,10153,16422,'test',0,0,0),(16448,10153,16442,'general',0,0,0),(16449,10153,16442,'news',0,0,0),(16450,10153,16442,'test',0,0,0),(16468,10153,16462,'general',0,0,0),(16469,10153,16462,'news',0,0,0),(16470,10153,16462,'test',0,0,0);
/*!40000 ALTER TABLE `announcementsdelivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webdavprops`
--

DROP TABLE IF EXISTS `webdavprops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webdavprops` (
  `webDavPropsId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `props` longtext,
  PRIMARY KEY (`webDavPropsId`),
  UNIQUE KEY `IX_97DFA146` (`classNameId`,`classPK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webdavprops`
--

LOCK TABLES `webdavprops` WRITE;
/*!40000 ALTER TABLE `webdavprops` DISABLE KEYS */;
/*!40000 ALTER TABLE `webdavprops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expandocolumn`
--

DROP TABLE IF EXISTS `expandocolumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expandocolumn` (
  `columnId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `tableId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `defaultData` longtext,
  `typeSettings` longtext,
  PRIMARY KEY (`columnId`),
  UNIQUE KEY `IX_FEFC8DA7` (`tableId`,`name`),
  KEY `IX_A8C0CBE8` (`tableId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expandocolumn`
--

LOCK TABLES `expandocolumn` WRITE;
/*!40000 ALTER TABLE `expandocolumn` DISABLE KEYS */;
INSERT INTO `expandocolumn` VALUES (10412,10153,10411,'client-id',15,'',''),(15023,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_N3xkLRbsSbRk_12111',15,'',''),(15025,10153,15009,'USER_PREFS__OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf_12111',15,'',''),(15031,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_opml1TukpeyK_12111',15,'',''),(15033,10153,15009,'USER_PREFS__OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6_12111',15,'',''),(15035,10153,15009,'USER_PREFS__OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965_12111',15,'',''),(15040,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_IbQuHOqjyst9_10611',15,'',''),(15042,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_7psHTkjiwfhC_10611',15,'',''),(15088,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_x8rkY1wJKnI8_12111',15,'',''),(15090,10153,15009,'USER_PREFS__OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965_15059',15,'',''),(15092,10153,15009,'USER_PREFS__OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6_15059',15,'',''),(15264,10153,15009,'USER_PREFS__OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1_12111',15,'',''),(15268,10153,15009,'USER_PREFS__OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc_12111',15,'',''),(15273,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_DtkCXD7AhoVY_12111',15,'',''),(15624,10153,15009,'USER_PREFS__OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552_12111',15,'',''),(15632,10153,15009,'USER_PREFS__OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153_12111',15,'',''),(15634,10153,15009,'USER_PREFS__OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688_12111',15,'',''),(15636,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_YYcJw0ZpZ8gZ_12111',15,'',''),(15704,10153,15009,'USER_PREFS__OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0_12111',15,'',''),(15706,10153,15009,'USER_PREFS__OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0_15059',15,'',''),(15709,10153,15009,'USER_PREFS__OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153_15059',15,'',''),(15712,10153,15009,'USER_PREFS__OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688_15059',15,'',''),(16032,10153,15009,'USER_PREFS__OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153_15996',15,'',''),(16036,10153,15009,'USER_PREFS__OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021_12111',15,'',''),(16039,10153,15009,'USER_PREFS__OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021_12116',15,'',''),(16041,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_bM5AZc9nQir5_12111',15,'',''),(16043,10153,15009,'USER_PREFS__3_WAR_opensocialportlet_INSTANCE_axFdIw1LU7Oy_12111',15,'',''),(16047,10153,15009,'USER_PREFS__OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95_12111',15,'',''),(16049,10153,15009,'USER_PREFS__OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0_15996',15,'',''),(16051,10153,15009,'USER_PREFS__OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6_15996',15,'',''),(16053,10153,15009,'USER_PREFS__OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021_15996',15,'',''),(16055,10153,15009,'USER_PREFS__OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95_15996',15,'',''),(16061,10153,15009,'USER_PREFS__OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688_15996',15,'',''),(16072,10153,15009,'USER_PREFS__OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0_16007',15,'',''),(16074,10153,15009,'USER_PREFS__OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6_16007',15,'',''),(16076,10153,15009,'USER_PREFS__OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021_16007',15,'',''),(16078,10153,15009,'USER_PREFS__OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688_16007',15,'',''),(16080,10153,15009,'USER_PREFS__OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95_16007',15,'','');
/*!40000 ALTER TABLE `expandocolumn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddmstoragelink`
--

DROP TABLE IF EXISTS `ddmstoragelink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddmstoragelink` (
  `uuid_` varchar(75) DEFAULT NULL,
  `storageLinkId` bigint(20) NOT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `structureId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`storageLinkId`),
  UNIQUE KEY `IX_702D1AD5` (`classPK`),
  KEY `IX_81776090` (`structureId`),
  KEY `IX_32A18526` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddmstoragelink`
--

LOCK TABLES `ddmstoragelink` WRITE;
/*!40000 ALTER TABLE `ddmstoragelink` DISABLE KEYS */;
INSERT INTO `ddmstoragelink` VALUES ('330397fd-80c3-4a1c-aac7-a5d81d3e5cba',10443,10099,10442,10308),('d27bbc4b-46d6-4429-9d2b-2f64f9cff59a',10463,10099,10462,10308),('f03b386b-cd4a-4dca-bc4c-031210809689',10469,10099,10468,10308),('9a0ab95b-7789-4506-8b58-c9bd66cdcab6',10481,10099,10480,10308),('4d6399f3-4ea9-4104-8702-4f6e5f20e89e',10491,10099,10490,10308),('730bfd3e-caa2-4498-b306-cf1b627aa459',10503,10099,10502,10308),('bd5bff58-00a0-4d74-8de1-50f55f7c2f8b',10515,10099,10514,10308),('e5c9fc9a-1c68-4d9e-81ab-4ae3193e1dae',10521,10099,10520,10308),('83560449-f7f3-4b76-a3d9-263d99e67200',10533,10099,10532,10308),('cc8e8c1b-1373-4351-9461-922d9bae5ca3',10545,10099,10544,10308),('339bd5b6-dadf-4117-a5c7-5d124d56536f',10557,10099,10556,10308),('91b257d0-b22c-46a1-902d-bf2bbba50b3d',10569,10099,10568,10308),('77eb2d57-c6c5-4c6c-937c-12e2c3e16946',10579,10099,10578,10308),('fd3c9bd9-7783-4e78-a633-0a1806edcaae',11650,10099,11648,10308),('28237d1a-99b9-45a9-af0e-fea2dbff7df1',11664,10099,11663,10308),('c60f25cf-20a7-49e7-a82d-290125478582',11679,10099,11678,10308),('72528445-c8bb-4faf-9211-76c7e7eff5ae',11685,10099,11684,10308),('85b3a46d-c45e-45a7-82b1-9e74ef3c3da9',11692,10099,11691,10308),('a23b4b75-986d-4eca-890e-26f6192f5ec0',11696,10099,11695,10308),('bf0bea3d-d88b-4e93-8dc1-51f184556b92',11700,10099,11699,10308),('e4e9cea0-a2f7-44f9-ba39-e15284648fe0',13129,10099,13128,10308),('bd63a4de-be8a-4daa-8ade-0a55ff621408',13146,10099,13145,10308),('f6666bd6-d8f3-494f-8d92-a968044a2a25',13162,10099,13161,10308),('1a77820d-3a2c-4180-94ee-a8397f603668',13197,10099,13196,10308),('4cc1d4ad-0e9d-4d60-8409-5055750f185f',13286,10099,13285,10308),('4016a367-d8ae-4ee2-b5f6-393e49fa1772',13357,10099,13356,10308),('a9ff753b-e526-4285-89b0-d8ddb0baead6',15308,10099,15307,10308),('1b260b84-6dea-4dbb-ba36-16196ad5c567',18311,10099,18310,10308);
/*!40000 ALTER TABLE `ddmstoragelink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_`
--

DROP TABLE IF EXISTS `permission_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_` (
  `permissionId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `actionId` varchar(75) DEFAULT NULL,
  `resourceId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`permissionId`),
  UNIQUE KEY `IX_4D19C2B8` (`actionId`,`resourceId`),
  KEY `IX_F090C113` (`resourceId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_`
--

LOCK TABLES `permission_` WRITE;
/*!40000 ALTER TABLE `permission_` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cyrusvirtual`
--

DROP TABLE IF EXISTS `cyrusvirtual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cyrusvirtual` (
  `emailAddress` varchar(75) NOT NULL,
  `userId` varchar(75) NOT NULL,
  PRIMARY KEY (`emailAddress`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cyrusvirtual`
--

LOCK TABLES `cyrusvirtual` WRITE;
/*!40000 ALTER TABLE `cyrusvirtual` DISABLE KEYS */;
/*!40000 ALTER TABLE `cyrusvirtual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `teamId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`teamId`),
  UNIQUE KEY `IX_143DC786` (`groupId`,`name`),
  KEY `IX_AE6E9907` (`groupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlcontent`
--

DROP TABLE IF EXISTS `dlcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlcontent` (
  `contentId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `repositoryId` bigint(20) DEFAULT NULL,
  `path_` varchar(255) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  `data_` longblob,
  `size_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`contentId`),
  UNIQUE KEY `IX_FDD1AAA8` (`companyId`,`repositoryId`,`path_`,`version`),
  KEY `IX_6A83A66A` (`companyId`,`repositoryId`),
  KEY `IX_EB531760` (`companyId`,`repositoryId`,`path_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlcontent`
--

LOCK TABLES `dlcontent` WRITE;
/*!40000 ALTER TABLE `dlcontent` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlcontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddmstructure`
--

DROP TABLE IF EXISTS `ddmstructure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddmstructure` (
  `uuid_` varchar(75) DEFAULT NULL,
  `structureId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `structureKey` varchar(75) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `xsd` longtext,
  `storageType` varchar(75) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  PRIMARY KEY (`structureId`),
  UNIQUE KEY `IX_490E7A1E` (`groupId`,`structureKey`),
  UNIQUE KEY `IX_85C7EBE2` (`uuid_`,`groupId`),
  KEY `IX_31817A62` (`classNameId`),
  KEY `IX_C8419FBE` (`groupId`),
  KEY `IX_E61809C8` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddmstructure`
--

LOCK TABLES `ddmstructure` WRITE;
/*!40000 ALTER TABLE `ddmstructure` DISABLE KEYS */;
INSERT INTO `ddmstructure` VALUES ('9fe4b2c4-ea8c-4581-9519-d18e97af7b87',10297,10191,10153,10157,'','2012-09-10 08:56:37','2012-09-10 08:56:37',10089,'Learning Module Metadata','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Learning Module Metadata</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Learning Module Metadata</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"select2235\" type=\"select\">\n		<dynamic-element name=\"home_edition\" type=\"option\" value=\"HE\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Home Edition]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"business_edition\" type=\"option\" value=\"BE\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Business Edition]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"enterprise_edition\" type=\"option\" value=\"EE\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Enterprise Edition]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Product]]></entry>\n			<entry name=\"multiple\"><![CDATA[true]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select3212\" type=\"select\">\n		<dynamic-element name=\"1_0\" type=\"option\" value=\"1\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[1.0]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"2_0\" type=\"option\" value=\"2\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[2.0]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"3_0\" type=\"option\" value=\"3\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[3.0]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Version]]></entry>\n			<entry name=\"multiple\"><![CDATA[true]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select4115\" type=\"select\">\n		<dynamic-element name=\"administration\" type=\"option\" value=\"admin\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Administration]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"installation\" type=\"option\" value=\"install\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Installation]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"configuration\" type=\"option\" value=\"config\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Configuration]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Topics]]></entry>\n			<entry name=\"multiple\"><![CDATA[true]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select5069\" type=\"select\">\n		<dynamic-element name=\"beginner\" type=\"option\" value=\"beginner\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Beginner]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"intermediate\" type=\"option\" value=\"intermediate\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Intermediate]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"advanced\" type=\"option\" value=\"advanced\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Advanced]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Level]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('8bc4ad24-2231-44f1-8f2f-31fee46142c4',10298,10191,10153,10157,'','2012-09-10 08:56:37','2012-09-10 08:56:37',10089,'Marketing Campaign Theme Metadata','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Marketing Campaign Theme Metadata</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Marketing Campaign Theme Metadata</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"select2305\" type=\"select\">\n		<dynamic-element name=\"strong_company\" type=\"option\" value=\"strong\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Strong Company]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"new_product_launch\" type=\"option\" value=\"product\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[New Product Launch]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"company_philosophy\" type=\"option\" value=\"philosophy\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Company Philosophy]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Select]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select3229\" type=\"select\">\n		<dynamic-element name=\"your_trusted_advisor\" type=\"option\" value=\"advisor\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Your Trusted Advisor]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"10_years_of_customer_solutions\" type=\"option\" value=\"solutions\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[10 Years of Customer Solutions]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"making_a_difference\" type=\"option\" value=\"difference\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Making a Difference]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Campaign Theme]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select4282\" type=\"select\">\n		<dynamic-element name=\"awareness\" type=\"option\" value=\"awareness\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Awareness]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"lead_generation\" type=\"option\" value=\"leads\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Lead Generation]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"customer_service\" type=\"option\" value=\"service\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Customer Service]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Business Goal]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('78170c99-dbdf-4e41-b7a6-36139898dbe6',10299,10191,10153,10157,'','2012-09-10 08:56:37','2012-09-10 08:56:37',10089,'Meeting Metadata','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Meeting Metadata</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Metadata for meeting</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"ddm-date3054\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text2217\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Meeting Name]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text4569\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Time]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text5638\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Location]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"textarea6584\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"textarea7502\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Participants]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('b2279f23-f525-4954-a456-6cd31f1b7611',10301,10191,10153,10157,'','2012-09-10 08:56:37','2012-09-10 08:56:37',10089,'auto_452345aa-7ce6-4cf6-ba78-4a6548002c03','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Contract</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Legal Contracts</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"ddm-date18949\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Effective Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"ddm-date20127\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Expiration Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select10264\" type=\"select\">\n		<dynamic-element name=\"nda\" type=\"option\" value=\"NDA\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[NDA]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"msa\" type=\"option\" value=\"MSA\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[MSA]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"license_agreement\" type=\"option\" value=\"License\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[License Agreement]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Contract Type]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select4893\" type=\"select\">\n		<dynamic-element name=\"draft\" type=\"option\" value=\"Draft\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Draft]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"in_review\" type=\"option\" value=\"Review\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[In Review]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"suspended\" type=\"option\" value=\"Suspended\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Suspended]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"signed\" type=\"option\" value=\"Signed\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Signed]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Status]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text14822\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Legal Reviewer]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text17700\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Signing Authority]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text2087\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Deal Name]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',1),('3942910a-c2be-4b38-9de8-d9366e6a5ea5',10303,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38',10089,'auto_f9b6ce1d-3d5a-47f9-875e-ffc5fa6fef85','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Marketing Banner</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Marketing Banner</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"radio5547\" type=\"radio\">\n		<dynamic-element name=\"yes\" type=\"option\" value=\"yes\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Yes]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"no\" type=\"option\" value=\"no\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[No]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Needs Legal Review]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text2033\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Banner Name]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"textarea2873\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',1),('b4873f70-cc80-4db1-98c6-fd050144e31b',10305,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38',10089,'auto_241ef81a-7550-4bf6-988f-1a6e488e9d0a','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Online Training</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Online Training</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"text2082\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Lesson Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text2979\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Author]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',1),('d81d580c-0f85-46e0-87df-23c03c47ed9e',10307,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38',10089,'auto_b3fe7d43-d1e7-4e7c-9993-f9ee030d4a55','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Sales Presentation</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Sales Presentation</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"select2890\" type=\"select\">\n		<dynamic-element name=\"home_edition\" type=\"option\" value=\"HE\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Home Edition]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"business_edition\" type=\"option\" value=\"BE\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Business Edition]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"enterprise_edition\" type=\"option\" value=\"EE\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Enterprise Edition]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Product]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select3864\" type=\"select\">\n		<dynamic-element name=\"1_0\" type=\"option\" value=\"1\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[1.0]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"2_0\" type=\"option\" value=\"2\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[2.0]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"3_0\" type=\"option\" value=\"3\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[3.0]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Version]]></entry>\n			<entry name=\"multiple\"><![CDATA[false]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select4831\" type=\"select\">\n		<dynamic-element name=\"website\" type=\"option\" value=\"website\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Website]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"collaboration\" type=\"option\" value=\"collaboration\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Collaboration]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"intranet\" type=\"option\" value=\"intranet\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Intranet]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Areas of Interest]]></entry>\n			<entry name=\"multiple\"><![CDATA[true]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"select5929\" type=\"select\">\n		<dynamic-element name=\"acme\" type=\"option\" value=\"acme\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[ACME]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"sevencogs\" type=\"option\" value=\"sevencogs\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[SevenCogs]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"freeplus\" type=\"option\" value=\"freeplus\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[FreePlus]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"displayChildLabelAsValue\"><![CDATA[true]]></entry>\n			<entry name=\"label\"><![CDATA[Competitors]]></entry>\n			<entry name=\"multiple\"><![CDATA[true]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"text1993\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Prospect Name]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"readOnly\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',1),('f622c14a-dbf2-4f58-9f48-b56710c5301b',10308,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38',10010,'TikaRawMetadata','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">TikaRawMetadata</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">TikaRawMetadata</Description></root>','<root available-locales=\"en_US\" default-locale=\"en_US\"><dynamic-element dataType=\"string\" name=\"ClimateForcast_PROGRAM_ID\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.PROGRAM_ID]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_COMMAND_LINE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.COMMAND_LINE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_HISTORY\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.HISTORY]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_TABLE_ID\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.TABLE_ID]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_INSTITUTION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.INSTITUTION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_SOURCE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.SOURCE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_CONTACT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.CONTACT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_PROJECT_ID\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.PROJECT_ID]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_CONVENTIONS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.CONVENTIONS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_REFERENCES\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.REFERENCES]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_ACKNOWLEDGEMENT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.ACKNOWLEDGEMENT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_REALIZATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.REALIZATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_EXPERIMENT_ID\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.EXPERIMENT_ID]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_COMMENT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.COMMENT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"ClimateForcast_MODEL_NAME_ENGLISH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.ClimateForcast.MODEL_NAME_ENGLISH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"CreativeCommons_LICENSE_URL\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.CreativeCommons.LICENSE_URL]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"CreativeCommons_LICENSE_LOCATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.CreativeCommons.LICENSE_LOCATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"CreativeCommons_WORK_TYPE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.CreativeCommons.WORK_TYPE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_FORMAT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.FORMAT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_IDENTIFIER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.IDENTIFIER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_MODIFIED\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.MODIFIED]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_CONTRIBUTOR\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.CONTRIBUTOR]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_COVERAGE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.COVERAGE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_CREATOR\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.CREATOR]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_DESCRIPTION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.DESCRIPTION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_LANGUAGE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.LANGUAGE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_PUBLISHER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.PUBLISHER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_RELATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.RELATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_RIGHTS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.RIGHTS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_SOURCE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.SOURCE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_SUBJECT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.SUBJECT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_TITLE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.TITLE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"DublinCore_TYPE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.DublinCore.TYPE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Geographic_LATITUDE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Geographic.LATITUDE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Geographic_LONGITUDE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Geographic.LONGITUDE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Geographic_ALTITUDE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Geographic.ALTITUDE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_CONTENT_ENCODING\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.CONTENT_ENCODING]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_CONTENT_LANGUAGE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.CONTENT_LANGUAGE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_CONTENT_LENGTH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.CONTENT_LENGTH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_CONTENT_LOCATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.CONTENT_LOCATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_CONTENT_DISPOSITION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.CONTENT_DISPOSITION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_CONTENT_MD5\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.CONTENT_MD5]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_CONTENT_TYPE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.CONTENT_TYPE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_LAST_MODIFIED\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.LAST_MODIFIED]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"HttpHeaders_LOCATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.HttpHeaders.LOCATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Message_MESSAGE_RECIPIENT_ADDRESS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Message.MESSAGE_RECIPIENT_ADDRESS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Message_MESSAGE_FROM\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Message.MESSAGE_FROM]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Message_MESSAGE_TO\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Message.MESSAGE_TO]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Message_MESSAGE_CC\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Message.MESSAGE_CC]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"Message_MESSAGE_BCC\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.Message.MESSAGE_BCC]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_KEYWORDS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.KEYWORDS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_COMMENTS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.COMMENTS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_LAST_AUTHOR\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.LAST_AUTHOR]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_APPLICATION_NAME\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.APPLICATION_NAME]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_CHARACTER_COUNT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.CHARACTER_COUNT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_LAST_PRINTED\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.LAST_PRINTED]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_LAST_SAVED\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.LAST_SAVED]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_PAGE_COUNT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.PAGE_COUNT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_REVISION_NUMBER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.REVISION_NUMBER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_WORD_COUNT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.WORD_COUNT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_TEMPLATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.TEMPLATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_AUTHOR\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.AUTHOR]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_TOTAL_TIME\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.TOTAL_TIME]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_SLIDE_COUNT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.SLIDE_COUNT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_PRESENTATION_FORMAT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.PRESENTATION_FORMAT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_PARAGRAPH_COUNT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.PARAGRAPH_COUNT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_NOTES\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.NOTES]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_MANAGER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.MANAGER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_LINE_COUNT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.LINE_COUNT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_CHARACTER_COUNT_WITH_SPACES\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.CHARACTER_COUNT_WITH_SPACES]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_APPLICATION_VERSION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.APPLICATION_VERSION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_VERSION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.VERSION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_CONTENT_STATUS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.CONTENT_STATUS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_CATEGORY\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.CATEGORY]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_COMPANY\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.COMPANY]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_SECURITY\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.SECURITY]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_EDIT_TIME\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.EDIT_TIME]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"MSOffice_CREATION_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.MSOffice.CREATION_DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_BITS_PER_SAMPLE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.BITS_PER_SAMPLE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_IMAGE_LENGTH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.IMAGE_LENGTH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_IMAGE_WIDTH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.IMAGE_WIDTH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_SAMPLES_PER_PIXEL\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.SAMPLES_PER_PIXEL]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_FLASH_FIRED\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.FLASH_FIRED]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_EXPOSURE_TIME\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.EXPOSURE_TIME]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_F_NUMBER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.F_NUMBER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_FOCAL_LENGTH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.FOCAL_LENGTH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_ISO_SPEED_RATINGS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.ISO_SPEED_RATINGS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_EQUIPMENT_MAKE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.EQUIPMENT_MAKE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_EQUIPMENT_MODEL\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.EQUIPMENT_MODEL]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_SOFTWARE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.SOFTWARE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_ORIENTATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.ORIENTATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_RESOLUTION_HORIZONTAL\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.RESOLUTION_HORIZONTAL]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_RESOLUTION_VERTICAL\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.RESOLUTION_VERTICAL]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_RESOLUTION_UNIT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.RESOLUTION_UNIT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TIFF_ORIGINAL_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TIFF.ORIGINAL_DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TikaMetadataKeys_RESOURCE_NAME_KEY\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TikaMetadataKeys.RESOURCE_NAME_KEY]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TikaMetadataKeys_PROTECTED\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TikaMetadataKeys.PROTECTED]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TikaMimeKeys_TIKA_MIME_FILE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TikaMimeKeys.TIKA_MIME_FILE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"TikaMimeKeys_MIME_TYPE_MAGIC\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.TikaMimeKeys.MIME_TYPE_MAGIC]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_DURATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.DURATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_ABS_PEAK_AUDIO_FILE_PATH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.ABS_PEAK_AUDIO_FILE_PATH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_ALBUM\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.ALBUM]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_ALT_TAPE_NAME\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.ALT_TAPE_NAME]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_ARTIST\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.ARTIST]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_AUDIO_MOD_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.AUDIO_MOD_DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_AUDIO_SAMPLE_RATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.AUDIO_SAMPLE_RATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_AUDIO_SAMPLE_TYPE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.AUDIO_SAMPLE_TYPE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_AUDIO_CHANNEL_TYPE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.AUDIO_CHANNEL_TYPE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_AUDIO_COMPRESSOR\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.AUDIO_COMPRESSOR]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_COMPOSER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.COMPOSER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_COPYRIGHT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.COPYRIGHT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_ENGINEER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.ENGINEER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_FILE_DATA_RATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.FILE_DATA_RATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_GENRE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.GENRE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_INSTRUMENT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.INSTRUMENT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_KEY\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.KEY]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_LOG_COMMENT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.LOG_COMMENT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_LOOP\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.LOOP]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_NUMBER_OF_BEATS\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.NUMBER_OF_BEATS]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_METADATA_MOD_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.METADATA_MOD_DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_PULL_DOWN\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.PULL_DOWN]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_RELATIVE_PEAK_AUDIO_FILE_PATH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.RELATIVE_PEAK_AUDIO_FILE_PATH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_RELEASE_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.RELEASE_DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_SCALE_TYPE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.SCALE_TYPE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_SCENE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.SCENE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_SHOT_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.SHOT_DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_SHOT_LOCATION\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.SHOT_LOCATION]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_SHOT_NAME\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.SHOT_NAME]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_SPEAKER_PLACEMENT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.SPEAKER_PLACEMENT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_STRETCH_MODE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.STRETCH_MODE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_TAPE_NAME\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.TAPE_NAME]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_TEMPO\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.TEMPO]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_TIME_SIGNATURE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.TIME_SIGNATURE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_TRACK_NUMBER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.TRACK_NUMBER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_ALPHA_MODE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_ALPHA_MODE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_ALPHA_UNITY_IS_TRANSPARENT\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_ALPHA_UNITY_IS_TRANSPARENT]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_COLOR_SPACE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_COLOR_SPACE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_COMPRESSOR\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_COMPRESSOR]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_FIELD_ORDER\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_FIELD_ORDER]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_FRAME_RATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_FRAME_RATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_MOD_DATE\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_MOD_DATE]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_PIXEL_DEPTH\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_PIXEL_DEPTH]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element><dynamic-element dataType=\"string\" name=\"XMPDM_VIDEO_PIXEL_ASPECT_RATIO\" type=\"text\"><meta-data locale=\"en_US\"><entry name=\"label\"><![CDATA[metadata.XMPDM.VIDEO_PIXEL_ASPECT_RATIO]]></entry><entry name=\"predefinedValue\"><![CDATA[]]></entry><entry name=\"required\"><![CDATA[false]]></entry><entry name=\"showLabel\"><![CDATA[true]]></entry></meta-data></dynamic-element></root>','xml',0),('0f2a89f6-6c07-45f9-87ab-ac64f5fbd590',10399,10179,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10097,'Contacts','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Contacts</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Contacts</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"company\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Company]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"email\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Email]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"firstName\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[First Name]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"imService\" type=\"select\">\n		<dynamic-element name=\"aol\" type=\"option\" value=\"aol\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[AOL]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"yahoo\" type=\"option\" value=\"yahoo\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Yahoo]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"gtalk\" type=\"option\" value=\"gtalk\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[GTalk]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Instant Messenger Service]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[[\"gtalk\"]]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"imUserName\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Instant Messenger]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"jobTitle\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Job Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"lastName\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Last Name]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"notes\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Notes]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"phoneMobile\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Phone (Mobile)]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"phoneOffice\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Phone (Office)]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('cd7f0ccb-e888-4655-8d55-47c311eb7339',10400,10179,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10097,'Events','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Events</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Events</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"file-upload\" fieldNamespace=\"ddm\" name=\"attachment\" type=\"ddm-fileupload\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"acceptFiles\"><![CDATA[*]]></entry>\n			<entry name=\"folder\"><![CDATA[{\"folderId\":0,\"folderName\":\"Documents Home\"}]]></entry>\n			<entry name=\"label\"><![CDATA[Attachment]]></entry>\n			<entry name=\"name\"><![CDATA[attachment]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[Upload documents no larger than 3,000k.]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-fileupload]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"double\" fieldNamespace=\"ddm\" name=\"cost\" type=\"ddm-number\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Cost]]></entry>\n			<entry name=\"name\"><![CDATA[cost]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-number]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"description\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"name\"><![CDATA[description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[textarea]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"eventDate\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Date]]></entry>\n			<entry name=\"name\"><![CDATA[eventDate]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-date]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"eventName\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Event Name]]></entry>\n			<entry name=\"name\"><![CDATA[eventName]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[text]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"eventTime\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Time]]></entry>\n			<entry name=\"name\"><![CDATA[eventTime]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[text]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"location\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Location]]></entry>\n			<entry name=\"name\"><![CDATA[location]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[text]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('647c7904-c059-48ba-a973-b3fcdc47815a',10401,10179,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10097,'Inventory','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Inventory</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Inventory</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"description\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"style\"><![CDATA[]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"item\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Item]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"style\"><![CDATA[]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"location\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Location]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"style\"><![CDATA[]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"purchaseDate\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Purchase Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"style\"><![CDATA[]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"double\" fieldNamespace=\"ddm\" name=\"purchasePrice\" type=\"ddm-number\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Purchase Price]]></entry>\n			<entry name=\"name\"><![CDATA[purchasePrice]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-number]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"double\" fieldNamespace=\"ddm\" name=\"quantity\" type=\"ddm-number\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Quantity]]></entry>\n			<entry name=\"name\"><![CDATA[quantity]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-number]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('c10ceded-f9f4-4a14-a745-14dd90889abb',10402,10179,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10097,'Issues Tracking','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Issues Tracking</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Issue Tracking</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"assignedTo\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Assigned To]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"file-upload\" fieldNamespace=\"ddm\" name=\"attachment\" type=\"ddm-fileupload\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"acceptFiles\"><![CDATA[*]]></entry>\n			<entry name=\"folder\"><![CDATA[{\"folderId\":0,\"folderName\":\"Documents Home\"}]]></entry>\n			<entry name=\"label\"><![CDATA[Attachment]]></entry>\n			<entry name=\"name\"><![CDATA[attachment]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[Upload documents no larger than 3,000k.]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-fileupload]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"comments\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Comments]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"description\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"dueDate\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Due Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"issueId\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[Issue ID]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"severity\" type=\"select\">\n		<dynamic-element name=\"critical\" type=\"option\" value=\"critical\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Critical]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"major\" type=\"option\" value=\"major\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Major]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"minor\" type=\"option\" value=\"minor\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Minor]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"trivial\" type=\"option\" value=\"trivial\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Trivial]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Severity]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[[\"minor\"]]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"status\" type=\"select\">\n		<dynamic-element name=\"open\" type=\"option\" value=\"open\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Open]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"pending\" type=\"option\" value=\"pending\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Pending]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"completed\" type=\"option\" value=\"completed\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Completed]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Status]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[[\"open\"]]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"title\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('6c3e98fd-8b08-441d-be5a-e77e6b67b165',10403,10179,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10097,'Meeting Minutes','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Meeting Minutes</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Meeting Minutes</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"file-upload\" fieldNamespace=\"ddm\" name=\"attachment\" type=\"ddm-fileupload\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"acceptFiles\"><![CDATA[*]]></entry>\n			<entry name=\"folder\"><![CDATA[{\"folderId\":0,\"folderName\":\"Documents Home\"}]]></entry>\n			<entry name=\"label\"><![CDATA[Attachment]]></entry>\n			<entry name=\"name\"><![CDATA[attachment]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[Upload documents no larger than 3,000k.]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-fileupload]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"author\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Author]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"description\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"duration\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Meeting Duration]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"meetingDate\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Meeting Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"minutes\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Minutes]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"title\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0),('7a180747-8aa8-4230-acb3-d3077a837f02',10404,10179,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10097,'To Do','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">To Do</Name></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">To Do</Description></root>','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element dataType=\"string\" name=\"assignedTo\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Assigned To]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"file-upload\" fieldNamespace=\"ddm\" name=\"attachment\" type=\"ddm-fileupload\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"acceptFiles\"><![CDATA[*]]></entry>\n			<entry name=\"folder\"><![CDATA[{\"folderId\":0,\"folderName\":\"Documents Home\"}]]></entry>\n			<entry name=\"label\"><![CDATA[Attachment]]></entry>\n			<entry name=\"name\"><![CDATA[attachment]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[Upload documents no larger than 3,000k.]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-fileupload]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"comments\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Comments]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"description\" type=\"textarea\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w100]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[100]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"endDate\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[End Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"integer\" fieldNamespace=\"ddm\" name=\"percentComplete\" type=\"ddm-integer\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w25]]></entry>\n			<entry name=\"label\"><![CDATA[% Complete]]></entry>\n			<entry name=\"name\"><![CDATA[percentComplete]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[0]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"tip\"><![CDATA[]]></entry>\n			<entry name=\"type\"><![CDATA[ddm-integer]]></entry>\n			<entry name=\"width\"><![CDATA[25]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"severity\" type=\"select\">\n		<dynamic-element name=\"critical\" type=\"option\" value=\"critical\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Critical]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"major\" type=\"option\" value=\"major\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Major]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"minor\" type=\"option\" value=\"minor\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Minor]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"trivial\" type=\"option\" value=\"trivial\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Trivial]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Severity]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[[\"minor\"]]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"date\" fieldNamespace=\"ddm\" name=\"startDate\" type=\"ddm-date\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Start Date]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"status\" type=\"select\">\n		<dynamic-element name=\"open\" type=\"option\" value=\"open\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Open]]></entry>\n				<entry name=\"multiple\"><![CDATA[false]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"pending\" type=\"option\" value=\"pending\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Pending]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"completed\" type=\"option\" value=\"completed\">\n			<meta-data locale=\"en_US\">\n				<entry name=\"label\"><![CDATA[Completed]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<meta-data locale=\"en_US\">\n			<entry name=\"label\"><![CDATA[Status]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[[\"open\"]]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element dataType=\"string\" name=\"title\" type=\"text\">\n		<meta-data locale=\"en_US\">\n			<entry name=\"fieldCssClass\"><![CDATA[aui-w50]]></entry>\n			<entry name=\"label\"><![CDATA[Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"showLabel\"><![CDATA[true]]></entry>\n			<entry name=\"width\"><![CDATA[50]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>','xml',0);
/*!40000 ALTER TABLE `ddmstructure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddmcontent`
--

DROP TABLE IF EXISTS `ddmcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddmcontent` (
  `uuid_` varchar(75) DEFAULT NULL,
  `contentId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `xml` longtext,
  PRIMARY KEY (`contentId`),
  UNIQUE KEY `IX_EB9BDE28` (`uuid_`,`groupId`),
  KEY `IX_E3BAF436` (`companyId`),
  KEY `IX_50BF1038` (`groupId`),
  KEY `IX_AE4B50C2` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddmcontent`
--

LOCK TABLES `ddmcontent` WRITE;
/*!40000 ALTER TABLE `ddmcontent` DISABLE KEYS */;
INSERT INTO `ddmcontent` VALUES ('a097183b-87e0-4b82-82a7-a58b5859ea9e',10442,10179,10153,10157,'','2012-09-10 08:56:55','2012-09-10 08:56:55','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('247a65a8-3ed2-492a-8c36-7957d20a23e2',10462,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('839b44fd-f49f-4f33-8cad-647d6594f36b',10468,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('1b3b0822-1b24-4dbf-8d97-9ed5a0ee383b',10480,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[700]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[304]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('6b7f34f3-9752-499f-9099-3f3071ac399f',10490,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('ccfc89bf-6746-421b-82ec-b7dc6eee4eb1',10502,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('eab30b0a-da0b-43de-b735-3290b88d40e7',10514,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('87641eb2-d523-4a82-a18c-00a9aefa09bb',10520,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('17097831-a494-4536-9529-88ed54df5ba3',10532,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('86d55ead-bf52-4c82-b6a9-5da5bc0a3af6',10544,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('b9dd13ac-dc4f-4fab-8557-a44730296643',10556,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('0cbe0b5b-2e72-4976-af72-abf284793910',10568,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('017e0bc9-c678-4a30-9566-798c30b91f9d',10578,10179,10153,10157,'','2012-09-10 08:57:00','2012-09-10 08:57:00','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[460]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[303]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('02b5417f-09ca-4e49-b2d6-9c07ae1e8a3f',11648,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[58]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[73]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('9006a8c3-937f-47ae-84f6-70bce0d7f686',11663,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[964]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[260]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('caf73420-1df5-4c20-a43e-e9a541079c7d',11678,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[76]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[76]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('0c57c0a3-cdc4-4481-bf20-a73f50f99cb4',11684,11605,10153,10157,'','2012-09-26 15:45:43','2012-09-26 15:45:43','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[964]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[260]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('01ec0dcf-9b5b-48a2-b59d-a3b93d7b66c1',11691,11605,10153,10157,'','2012-09-26 15:45:43','2012-09-26 15:45:43','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[964]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[260]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('6b66d70e-5bc5-4727-8296-ae0f5adb088e',11695,11605,10153,10157,'','2012-09-26 15:45:43','2012-09-26 15:45:43','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[83]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[73]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('dc3b21a8-4c8f-4335-b591-2ac93e76ee42',11699,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[69]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[77]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('0f370eda-e817-484c-8d09-adb03f4439d5',13128,10191,10153,12102,'Admin Amin','2012-11-29 11:50:00','2012-11-29 11:50:00','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[118]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[164]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('79dc04fb-f65d-4d1a-a264-eacb885ef56c',13145,10191,10153,12102,'Admin Amin','2012-11-29 11:57:31','2012-11-29 11:57:31','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[363]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[139]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('fb7bbea6-eb60-4eec-83e1-4e1ad690ebad',13161,10191,10153,12102,'Admin Amin','2012-11-29 12:09:56','2012-11-29 12:09:56','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[261]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[193]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('a80c4e2e-54e5-4873-a772-c45d6954a387',13196,10191,10153,12102,'Admin Amin','2012-11-29 13:58:28','2012-11-29 13:58:28','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[711]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[451]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('f2d05ee9-de0c-4616-93a1-f5d0a9abc577',13285,10191,10153,12102,'Admin Amin','2012-11-29 14:28:41','2012-11-29 14:28:41','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[924]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[722]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('f2bb95ad-9bf9-4bb1-9294-b0b2875ae811',13356,10191,10153,12102,'Admin Amin','2012-11-29 14:36:17','2012-11-29 14:36:17','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[1052]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[806]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('16b540e6-6e5a-4733-bc34-aeebd68c3dc8',15307,10191,10153,12102,'Admin Amin','2013-05-10 13:38:59','2013-05-10 13:38:59','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[1432]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/png]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[548]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8 8 8]]></dynamic-content>\n	</dynamic-element>\n</root>'),('7073c812-c6b2-497c-a7d6-875b7c8e7f80',18310,10191,10153,12102,'Admin Admin','2014-03-04 08:49:45','2014-03-04 08:49:45','com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"TIFF_IMAGE_WIDTH\">\n		<dynamic-content><![CDATA[1156]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"HttpHeaders_CONTENT_TYPE\">\n		<dynamic-content><![CDATA[image/jpeg]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_IMAGE_LENGTH\">\n		<dynamic-content><![CDATA[531]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element name=\"TIFF_BITS_PER_SAMPLE\">\n		<dynamic-content><![CDATA[8]]></dynamic-content>\n	</dynamic-element>\n</root>');
/*!40000 ALTER TABLE `ddmcontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_job_details`
--

DROP TABLE IF EXISTS `quartz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` tinyint(4) NOT NULL,
  `IS_NONCONCURRENT` tinyint(4) NOT NULL,
  `IS_UPDATE_DATA` tinyint(4) NOT NULL,
  `REQUESTS_RECOVERY` tinyint(4) NOT NULL,
  `JOB_DATA` longblob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IX_88328984` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IX_779BCA37` (`SCHED_NAME`,`REQUESTS_RECOVERY`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_job_details`
--

LOCK TABLES `quartz_job_details` WRITE;
/*!40000 ALTER TABLE `quartz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usernotificationevent`
--

DROP TABLE IF EXISTS `usernotificationevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usernotificationevent` (
  `uuid_` varchar(75) DEFAULT NULL,
  `userNotificationEventId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  `deliverBy` bigint(20) DEFAULT NULL,
  `payload` longtext,
  `archived` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`userNotificationEventId`),
  KEY `IX_3E5D78C4` (`userId`),
  KEY `IX_3DBB361A` (`userId`,`archived`),
  KEY `IX_ECD8CFEA` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usernotificationevent`
--

LOCK TABLES `usernotificationevent` WRITE;
/*!40000 ALTER TABLE `usernotificationevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `usernotificationevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_`
--

DROP TABLE IF EXISTS `contact_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_` (
  `contactId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `accountId` bigint(20) DEFAULT NULL,
  `parentContactId` bigint(20) DEFAULT NULL,
  `firstName` varchar(75) DEFAULT NULL,
  `middleName` varchar(75) DEFAULT NULL,
  `lastName` varchar(75) DEFAULT NULL,
  `prefixId` int(11) DEFAULT NULL,
  `suffixId` int(11) DEFAULT NULL,
  `male` tinyint(4) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `smsSn` varchar(75) DEFAULT NULL,
  `aimSn` varchar(75) DEFAULT NULL,
  `facebookSn` varchar(75) DEFAULT NULL,
  `icqSn` varchar(75) DEFAULT NULL,
  `jabberSn` varchar(75) DEFAULT NULL,
  `msnSn` varchar(75) DEFAULT NULL,
  `mySpaceSn` varchar(75) DEFAULT NULL,
  `skypeSn` varchar(75) DEFAULT NULL,
  `twitterSn` varchar(75) DEFAULT NULL,
  `ymSn` varchar(75) DEFAULT NULL,
  `employeeStatusId` varchar(75) DEFAULT NULL,
  `employeeNumber` varchar(75) DEFAULT NULL,
  `jobTitle` varchar(100) DEFAULT NULL,
  `jobClass` varchar(75) DEFAULT NULL,
  `hoursOfOperation` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`contactId`),
  KEY `IX_66D496A3` (`companyId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_`
--

LOCK TABLES `contact_` WRITE;
/*!40000 ALTER TABLE `contact_` DISABLE KEYS */;
INSERT INTO `contact_` VALUES (10158,10153,10157,'','2012-09-10 08:56:28','2012-09-10 08:56:28',10155,0,'','','',0,0,1,'2012-09-10 08:56:28','','','','','','','','','','','','','','',''),(12103,10153,10195,'Test Test','2012-10-04 14:55:24','2013-12-19 14:01:08',10155,0,'Admin','','Admin',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','',''),(16309,10153,12102,'Admin Amin','2013-11-15 10:34:11','2013-12-20 11:58:40',10155,0,'fitman_guest','','',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','',''),(16403,10153,12102,'Admin Amin','2013-11-18 15:32:17','2013-11-18 15:32:29',10155,0,'MSEE','','Admin',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','',''),(16423,10153,12102,'Admin Amin','2013-11-18 15:33:56','2013-11-18 15:35:41',10155,0,'MSEE','','Businessexpert',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','',''),(16443,10153,12102,'Admin Amin','2013-11-18 15:36:42','2013-11-18 15:37:01',10155,0,'MSEE','','Employee',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','',''),(16463,10153,12102,'Admin Amin','2013-11-18 15:38:39','2013-11-18 15:38:58',10155,0,'MSEE','','Itexpert',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','',''),(17504,10153,12102,'Admin Admin','2013-12-19 15:52:04','2013-12-19 15:52:04',10155,0,'user','','',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','',''),(17604,10153,12102,'Admin Admin','2013-12-19 16:08:43','2013-12-19 16:08:43',10155,0,'user','','',0,0,1,'1970-01-01 00:00:00','','','','','','','','','','','','','','','');
/*!40000 ALTER TABLE `contact_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scframeworkversion`
--

DROP TABLE IF EXISTS `scframeworkversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scframeworkversion` (
  `frameworkVersionId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `url` longtext,
  `active_` tinyint(4) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`frameworkVersionId`),
  KEY `IX_C98C0D78` (`companyId`),
  KEY `IX_272991FA` (`groupId`),
  KEY `IX_6E1764F` (`groupId`,`active_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scframeworkversion`
--

LOCK TABLES `scframeworkversion` WRITE;
/*!40000 ALTER TABLE `scframeworkversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `scframeworkversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflowinstancelink`
--

DROP TABLE IF EXISTS `workflowinstancelink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflowinstancelink` (
  `workflowInstanceLinkId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `workflowInstanceId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`workflowInstanceLinkId`),
  KEY `IX_415A7007` (`groupId`,`companyId`,`classNameId`,`classPK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflowinstancelink`
--

LOCK TABLES `workflowinstancelink` WRITE;
/*!40000 ALTER TABLE `workflowinstancelink` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflowinstancelink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergrouprole`
--

DROP TABLE IF EXISTS `usergrouprole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergrouprole` (
  `userId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`userId`,`groupId`,`roleId`),
  KEY `IX_1B988D7A` (`groupId`),
  KEY `IX_871412DF` (`groupId`,`roleId`),
  KEY `IX_887A2C95` (`roleId`),
  KEY `IX_887BE56A` (`userId`),
  KEY `IX_4D040680` (`userId`,`groupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergrouprole`
--

LOCK TABLES `usergrouprole` WRITE;
/*!40000 ALTER TABLE `usergrouprole` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergrouprole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialrequest`
--

DROP TABLE IF EXISTS `socialrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialrequest` (
  `uuid_` varchar(75) DEFAULT NULL,
  `requestId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createDate` bigint(20) DEFAULT NULL,
  `modifiedDate` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `extraData` longtext,
  `receiverUserId` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`requestId`),
  UNIQUE KEY `IX_36A90CA7` (`userId`,`classNameId`,`classPK`,`type_`,`receiverUserId`),
  UNIQUE KEY `IX_4F973EFE` (`uuid_`,`groupId`),
  KEY `IX_D3425487` (`classNameId`,`classPK`,`type_`,`receiverUserId`,`status`),
  KEY `IX_A90FE5A0` (`companyId`),
  KEY `IX_32292ED1` (`receiverUserId`),
  KEY `IX_D9380CB7` (`receiverUserId`,`status`),
  KEY `IX_80F7A9C2` (`userId`),
  KEY `IX_CC86A444` (`userId`,`classNameId`,`classPK`,`type_`,`status`),
  KEY `IX_AB5906A8` (`userId`,`status`),
  KEY `IX_49D5872C` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialrequest`
--

LOCK TABLES `socialrequest` WRITE;
/*!40000 ALTER TABLE `socialrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertrackerpath`
--

DROP TABLE IF EXISTS `usertrackerpath`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertrackerpath` (
  `userTrackerPathId` bigint(20) NOT NULL,
  `userTrackerId` bigint(20) DEFAULT NULL,
  `path_` longtext,
  `pathDate` datetime DEFAULT NULL,
  PRIMARY KEY (`userTrackerPathId`),
  KEY `IX_14D8BCC0` (`userTrackerId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertrackerpath`
--

LOCK TABLES `usertrackerpath` WRITE;
/*!40000 ALTER TABLE `usertrackerpath` DISABLE KEYS */;
/*!40000 ALTER TABLE `usertrackerpath` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wikipage`
--

DROP TABLE IF EXISTS `wikipage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wikipage` (
  `uuid_` varchar(75) DEFAULT NULL,
  `pageId` bigint(20) NOT NULL,
  `resourcePrimKey` bigint(20) DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `nodeId` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `version` double DEFAULT NULL,
  `minorEdit` tinyint(4) DEFAULT NULL,
  `content` longtext,
  `summary` longtext,
  `format` varchar(75) DEFAULT NULL,
  `head` tinyint(4) DEFAULT NULL,
  `parentTitle` varchar(255) DEFAULT NULL,
  `redirectTitle` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`pageId`),
  UNIQUE KEY `IX_3D4AF476` (`nodeId`,`title`,`version`),
  UNIQUE KEY `IX_2CD67C81` (`resourcePrimKey`,`nodeId`,`version`),
  UNIQUE KEY `IX_899D3DFB` (`uuid_`,`groupId`),
  KEY `IX_A2001730` (`format`),
  KEY `IX_C8A9C476` (`nodeId`),
  KEY `IX_E7F635CA` (`nodeId`,`head`),
  KEY `IX_65E84AF4` (`nodeId`,`head`,`parentTitle`),
  KEY `IX_9F7655DA` (`nodeId`,`head`,`parentTitle`,`status`),
  KEY `IX_432F0AB0` (`nodeId`,`head`,`status`),
  KEY `IX_46EEF3C8` (`nodeId`,`parentTitle`),
  KEY `IX_1ECC7656` (`nodeId`,`redirectTitle`),
  KEY `IX_546F2D5C` (`nodeId`,`status`),
  KEY `IX_997EEDD2` (`nodeId`,`title`),
  KEY `IX_E745EA26` (`nodeId`,`title`,`head`),
  KEY `IX_BEA33AB8` (`nodeId`,`title`,`status`),
  KEY `IX_B771D67` (`resourcePrimKey`,`nodeId`),
  KEY `IX_94D1054D` (`resourcePrimKey`,`nodeId`,`status`),
  KEY `IX_FBBE7C96` (`userId`,`nodeId`,`status`),
  KEY `IX_9C0E478F` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wikipage`
--

LOCK TABLES `wikipage` WRITE;
/*!40000 ALTER TABLE `wikipage` DISABLE KEYS */;
/*!40000 ALTER TABLE `wikipage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingorder`
--

DROP TABLE IF EXISTS `shoppingorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingorder` (
  `orderId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `number_` varchar(75) DEFAULT NULL,
  `tax` double DEFAULT NULL,
  `shipping` double DEFAULT NULL,
  `altShipping` varchar(75) DEFAULT NULL,
  `requiresShipping` tinyint(4) DEFAULT NULL,
  `insure` tinyint(4) DEFAULT NULL,
  `insurance` double DEFAULT NULL,
  `couponCodes` varchar(75) DEFAULT NULL,
  `couponDiscount` double DEFAULT NULL,
  `billingFirstName` varchar(75) DEFAULT NULL,
  `billingLastName` varchar(75) DEFAULT NULL,
  `billingEmailAddress` varchar(75) DEFAULT NULL,
  `billingCompany` varchar(75) DEFAULT NULL,
  `billingStreet` varchar(75) DEFAULT NULL,
  `billingCity` varchar(75) DEFAULT NULL,
  `billingState` varchar(75) DEFAULT NULL,
  `billingZip` varchar(75) DEFAULT NULL,
  `billingCountry` varchar(75) DEFAULT NULL,
  `billingPhone` varchar(75) DEFAULT NULL,
  `shipToBilling` tinyint(4) DEFAULT NULL,
  `shippingFirstName` varchar(75) DEFAULT NULL,
  `shippingLastName` varchar(75) DEFAULT NULL,
  `shippingEmailAddress` varchar(75) DEFAULT NULL,
  `shippingCompany` varchar(75) DEFAULT NULL,
  `shippingStreet` varchar(75) DEFAULT NULL,
  `shippingCity` varchar(75) DEFAULT NULL,
  `shippingState` varchar(75) DEFAULT NULL,
  `shippingZip` varchar(75) DEFAULT NULL,
  `shippingCountry` varchar(75) DEFAULT NULL,
  `shippingPhone` varchar(75) DEFAULT NULL,
  `ccName` varchar(75) DEFAULT NULL,
  `ccType` varchar(75) DEFAULT NULL,
  `ccNumber` varchar(75) DEFAULT NULL,
  `ccExpMonth` int(11) DEFAULT NULL,
  `ccExpYear` int(11) DEFAULT NULL,
  `ccVerNumber` varchar(75) DEFAULT NULL,
  `comments` longtext,
  `ppTxnId` varchar(75) DEFAULT NULL,
  `ppPaymentStatus` varchar(75) DEFAULT NULL,
  `ppPaymentGross` double DEFAULT NULL,
  `ppReceiverEmail` varchar(75) DEFAULT NULL,
  `ppPayerEmail` varchar(75) DEFAULT NULL,
  `sendOrderEmail` tinyint(4) DEFAULT NULL,
  `sendShippingEmail` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  UNIQUE KEY `IX_D7D6E87A` (`number_`),
  KEY `IX_1D15553E` (`groupId`),
  KEY `IX_119B5630` (`groupId`,`userId`,`ppPaymentStatus`),
  KEY `IX_F474FD89` (`ppTxnId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingorder`
--

LOCK TABLES `shoppingorder` WRITE;
/*!40000 ALTER TABLE `shoppingorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scproductversion`
--

DROP TABLE IF EXISTS `scproductversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scproductversion` (
  `productVersionId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `productEntryId` bigint(20) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  `changeLog` longtext,
  `downloadPageURL` longtext,
  `directDownloadURL` varchar(2000) DEFAULT NULL,
  `repoStoreArtifact` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`productVersionId`),
  KEY `IX_7020130F` (`directDownloadURL`(1000)),
  KEY `IX_8377A211` (`productEntryId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scproductversion`
--

LOCK TABLES `scproductversion` WRITE;
/*!40000 ALTER TABLE `scproductversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `scproductversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluginsetting`
--

DROP TABLE IF EXISTS `pluginsetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluginsetting` (
  `pluginSettingId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `pluginId` varchar(75) DEFAULT NULL,
  `pluginType` varchar(75) DEFAULT NULL,
  `roles` longtext,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`pluginSettingId`),
  UNIQUE KEY `IX_7171B2E8` (`companyId`,`pluginId`,`pluginType`),
  KEY `IX_B9746445` (`companyId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluginsetting`
--

LOCK TABLES `pluginsetting` WRITE;
/*!40000 ALTER TABLE `pluginsetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `pluginsetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettag`
--

DROP TABLE IF EXISTS `assettag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettag` (
  `tagId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `assetCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`tagId`),
  KEY `IX_7C9E46BA` (`groupId`),
  KEY `IX_D63322F9` (`groupId`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettag`
--

LOCK TABLES `assettag` WRITE;
/*!40000 ALTER TABLE `assettag` DISABLE KEYS */;
INSERT INTO `assettag` VALUES (14213,10191,10153,12102,'Admin Amin','2013-04-15 14:59:52','2013-04-15 14:59:52','e-commerce clothing',0),(14226,10191,10153,12102,'Admin Amin','2013-04-15 15:05:37','2013-04-15 15:05:37','multichannel  retail',0);
/*!40000 ALTER TABLE `assettag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layoutprototype`
--

DROP TABLE IF EXISTS `layoutprototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layoutprototype` (
  `uuid_` varchar(75) DEFAULT NULL,
  `layoutPrototypeId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `settings_` longtext,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`layoutPrototypeId`),
  KEY `IX_30616AAA` (`companyId`),
  KEY `IX_557A639F` (`companyId`,`active_`),
  KEY `IX_CEF72136` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layoutprototype`
--

LOCK TABLES `layoutprototype` WRITE;
/*!40000 ALTER TABLE `layoutprototype` DISABLE KEYS */;
INSERT INTO `layoutprototype` VALUES ('878f1992-57b7-4b7e-a04d-3002d1d0a3c5',10309,10153,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Blog</Name></root>','Create, edit, and view blogs from this page. Explore topics using tags, and connect with other members that blog.','',1),('eb5db8dd-7b1f-4a30-8104-fb4bba2e51c9',10319,10153,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Content Display Page</Name></root>','Create, edit, and explore web content with this page. Search available content, explore related content with tags, and browse content categories.','',1),('006148f9-e096-48da-a57b-5d3b88911386',10328,10153,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Wiki</Name></root>','Collaborate with members through the wiki on this page. Discover related content through tags, and navigate quickly and easily with categories.','',1);
/*!40000 ALTER TABLE `layoutprototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_permissions`
--

DROP TABLE IF EXISTS `roles_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_permissions` (
  `roleId` bigint(20) NOT NULL,
  `permissionId` bigint(20) NOT NULL,
  PRIMARY KEY (`roleId`,`permissionId`),
  KEY `IX_7A3619C6` (`permissionId`),
  KEY `IX_E04E486D` (`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_permissions`
--

LOCK TABLES `roles_permissions` WRITE;
/*!40000 ALTER TABLE `roles_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingorderitem`
--

DROP TABLE IF EXISTS `shoppingorderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingorderitem` (
  `orderItemId` bigint(20) NOT NULL,
  `orderId` bigint(20) DEFAULT NULL,
  `itemId` varchar(75) DEFAULT NULL,
  `sku` varchar(75) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` longtext,
  `properties` longtext,
  `price` double DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `shippedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`orderItemId`),
  KEY `IX_B5F82C7A` (`orderId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingorderitem`
--

LOCK TABLES `shoppingorderitem` WRITE;
/*!40000 ALTER TABLE `shoppingorderitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingorderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogsentry`
--

DROP TABLE IF EXISTS `blogsentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blogsentry` (
  `uuid_` varchar(75) DEFAULT NULL,
  `entryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `urlTitle` varchar(150) DEFAULT NULL,
  `description` varchar(75) DEFAULT NULL,
  `content` longtext,
  `displayDate` datetime DEFAULT NULL,
  `allowPingbacks` tinyint(4) DEFAULT NULL,
  `allowTrackbacks` tinyint(4) DEFAULT NULL,
  `trackbacks` longtext,
  `smallImage` tinyint(4) DEFAULT NULL,
  `smallImageId` bigint(20) DEFAULT NULL,
  `smallImageURL` longtext,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`entryId`),
  UNIQUE KEY `IX_DB780A20` (`groupId`,`urlTitle`),
  UNIQUE KEY `IX_1B1040FD` (`uuid_`,`groupId`),
  KEY `IX_72EF6041` (`companyId`),
  KEY `IX_430D791F` (`companyId`,`displayDate`),
  KEY `IX_BB0C2905` (`companyId`,`displayDate`,`status`),
  KEY `IX_EB2DCE27` (`companyId`,`status`),
  KEY `IX_8CACE77B` (`companyId`,`userId`),
  KEY `IX_A5F57B61` (`companyId`,`userId`,`status`),
  KEY `IX_2672F77F` (`displayDate`,`status`),
  KEY `IX_81A50303` (`groupId`),
  KEY `IX_621E19D` (`groupId`,`displayDate`),
  KEY `IX_F0E73383` (`groupId`,`displayDate`,`status`),
  KEY `IX_1EFD8EE9` (`groupId`,`status`),
  KEY `IX_FBDE0AA3` (`groupId`,`userId`,`displayDate`),
  KEY `IX_DA04F689` (`groupId`,`userId`,`displayDate`,`status`),
  KEY `IX_49E15A23` (`groupId`,`userId`,`status`),
  KEY `IX_69157A4D` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogsentry`
--

LOCK TABLES `blogsentry` WRITE;
/*!40000 ALTER TABLE `blogsentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogsentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingcategory`
--

DROP TABLE IF EXISTS `shoppingcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingcategory` (
  `categoryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `parentCategoryId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`categoryId`),
  KEY `IX_5F615D3E` (`groupId`),
  KEY `IX_1E6464F5` (`groupId`,`parentCategoryId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingcategory`
--

LOCK TABLES `shoppingcategory` WRITE;
/*!40000 ALTER TABLE `shoppingcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbmailinglist`
--

DROP TABLE IF EXISTS `mbmailinglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbmailinglist` (
  `uuid_` varchar(75) DEFAULT NULL,
  `mailingListId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `categoryId` bigint(20) DEFAULT NULL,
  `emailAddress` varchar(75) DEFAULT NULL,
  `inProtocol` varchar(75) DEFAULT NULL,
  `inServerName` varchar(75) DEFAULT NULL,
  `inServerPort` int(11) DEFAULT NULL,
  `inUseSSL` tinyint(4) DEFAULT NULL,
  `inUserName` varchar(75) DEFAULT NULL,
  `inPassword` varchar(75) DEFAULT NULL,
  `inReadInterval` int(11) DEFAULT NULL,
  `outEmailAddress` varchar(75) DEFAULT NULL,
  `outCustom` tinyint(4) DEFAULT NULL,
  `outServerName` varchar(75) DEFAULT NULL,
  `outServerPort` int(11) DEFAULT NULL,
  `outUseSSL` tinyint(4) DEFAULT NULL,
  `outUserName` varchar(75) DEFAULT NULL,
  `outPassword` varchar(75) DEFAULT NULL,
  `allowAnonymous` tinyint(4) DEFAULT NULL,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`mailingListId`),
  UNIQUE KEY `IX_76CE9CDD` (`groupId`,`categoryId`),
  UNIQUE KEY `IX_E858F170` (`uuid_`,`groupId`),
  KEY `IX_BFEB984F` (`active_`),
  KEY `IX_4115EC7A` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbmailinglist`
--

LOCK TABLES `mbmailinglist` WRITE;
/*!40000 ALTER TABLE `mbmailinglist` DISABLE KEYS */;
/*!40000 ALTER TABLE `mbmailinglist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repository`
--

DROP TABLE IF EXISTS `repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repository` (
  `uuid_` varchar(75) DEFAULT NULL,
  `repositoryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `portletId` varchar(75) DEFAULT NULL,
  `typeSettings` longtext,
  `dlFolderId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`repositoryId`),
  UNIQUE KEY `IX_11641E26` (`uuid_`,`groupId`),
  KEY `IX_5253B1FA` (`groupId`),
  KEY `IX_74C17B04` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repository`
--

LOCK TABLES `repository` WRITE;
/*!40000 ALTER TABLE `repository` DISABLE KEYS */;
/*!40000 ALTER TABLE `repository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marketplace_module`
--

DROP TABLE IF EXISTS `marketplace_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketplace_module` (
  `uuid_` varchar(75) DEFAULT NULL,
  `moduleId` bigint(20) NOT NULL,
  `appId` bigint(20) DEFAULT NULL,
  `contextName` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`moduleId`),
  KEY `IX_7DC16D26` (`appId`),
  KEY `IX_C6938724` (`appId`,`contextName`),
  KEY `IX_F2F1E964` (`contextName`),
  KEY `IX_A7EFD80E` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketplace_module`
--

LOCK TABLES `marketplace_module` WRITE;
/*!40000 ALTER TABLE `marketplace_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `marketplace_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetlink`
--

DROP TABLE IF EXISTS `assetlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetlink` (
  `linkId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `entryId1` bigint(20) DEFAULT NULL,
  `entryId2` bigint(20) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  PRIMARY KEY (`linkId`),
  UNIQUE KEY `IX_8F542794` (`entryId1`,`entryId2`,`type_`),
  KEY `IX_128516C8` (`entryId1`),
  KEY `IX_56E0AB21` (`entryId1`,`entryId2`),
  KEY `IX_14D5A20D` (`entryId1`,`type_`),
  KEY `IX_12851A89` (`entryId2`),
  KEY `IX_91F132C` (`entryId2`,`type_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetlink`
--

LOCK TABLES `assetlink` WRITE;
/*!40000 ALTER TABLE `assetlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdrrule`
--

DROP TABLE IF EXISTS `mdrrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdrrule` (
  `uuid_` varchar(75) DEFAULT NULL,
  `ruleId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `ruleGroupId` bigint(20) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `type_` varchar(255) DEFAULT NULL,
  `typeSettings` longtext,
  PRIMARY KEY (`ruleId`),
  UNIQUE KEY `IX_F3EFDCB3` (`uuid_`,`groupId`),
  KEY `IX_4F4293F1` (`ruleGroupId`),
  KEY `IX_EA63B9D7` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdrrule`
--

LOCK TABLES `mdrrule` WRITE;
/*!40000 ALTER TABLE `mdrrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdrrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialactivitylimit`
--

DROP TABLE IF EXISTS `socialactivitylimit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialactivitylimit` (
  `activityLimitId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `activityType` int(11) DEFAULT NULL,
  `activityCounterName` varchar(75) DEFAULT NULL,
  `value` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`activityLimitId`),
  UNIQUE KEY `IX_F1C1A617` (`groupId`,`userId`,`classNameId`,`classPK`,`activityType`,`activityCounterName`),
  KEY `IX_B15863FA` (`classNameId`,`classPK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialactivitylimit`
--

LOCK TABLES `socialactivitylimit` WRITE;
/*!40000 ALTER TABLE `socialactivitylimit` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialactivitylimit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expandorow`
--

DROP TABLE IF EXISTS `expandorow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expandorow` (
  `rowId_` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `tableId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`rowId_`),
  UNIQUE KEY `IX_81EFBFF5` (`tableId`,`classPK`),
  KEY `IX_D3F5D7AE` (`tableId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expandorow`
--

LOCK TABLES `expandorow` WRITE;
/*!40000 ALTER TABLE `expandorow` DISABLE KEYS */;
/*!40000 ALTER TABLE `expandorow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `addressId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `street1` varchar(75) DEFAULT NULL,
  `street2` varchar(75) DEFAULT NULL,
  `street3` varchar(75) DEFAULT NULL,
  `city` varchar(75) DEFAULT NULL,
  `zip` varchar(75) DEFAULT NULL,
  `regionId` bigint(20) DEFAULT NULL,
  `countryId` bigint(20) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `mailing` tinyint(4) DEFAULT NULL,
  `primary_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`addressId`),
  KEY `IX_93D5AD4E` (`companyId`),
  KEY `IX_ABD7DAC0` (`companyId`,`classNameId`),
  KEY `IX_71CB1123` (`companyId`,`classNameId`,`classPK`),
  KEY `IX_923BD178` (`companyId`,`classNameId`,`classPK`,`mailing`),
  KEY `IX_9226DBB4` (`companyId`,`classNameId`,`classPK`,`primary_`),
  KEY `IX_5BC8B0D4` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portletpreferences`
--

DROP TABLE IF EXISTS `portletpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portletpreferences` (
  `portletPreferencesId` bigint(20) NOT NULL,
  `ownerId` bigint(20) DEFAULT NULL,
  `ownerType` int(11) DEFAULT NULL,
  `plid` bigint(20) DEFAULT NULL,
  `portletId` varchar(200) DEFAULT NULL,
  `preferences` longtext,
  PRIMARY KEY (`portletPreferencesId`),
  UNIQUE KEY `IX_C7057FF7` (`ownerId`,`ownerType`,`plid`,`portletId`),
  KEY `IX_E4F13E6E` (`ownerId`,`ownerType`,`plid`),
  KEY `IX_D5EDA3A1` (`ownerType`,`plid`,`portletId`),
  KEY `IX_F15C1C4F` (`plid`),
  KEY `IX_D340DB76` (`plid`,`portletId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portletpreferences`
--

LOCK TABLES `portletpreferences` WRITE;
/*!40000 ALTER TABLE `portletpreferences` DISABLE KEYS */;
INSERT INTO `portletpreferences` VALUES (10351,0,3,10346,'3','<portlet-preferences><preference><name>portletSetupShowBorders</name><value>false</value></preference></portlet-preferences>'),(10357,0,3,10352,'101_INSTANCE_kHMCf5UxnMQo','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>anyAssetType</name><value>false</value></preference><preference><name>classNameIds</name><value>10009</value></preference><preference><name>portletSetupTitle_en_US</name><value>Upcoming Events</value></preference></portlet-preferences>'),(10377,0,3,10372,'3','<portlet-preferences><preference><name>portletSetupShowBorders</name><value>false</value></preference></portlet-preferences>'),(10378,0,3,10372,'82','<portlet-preferences><preference><name>displayStyle</name><value>3</value></preference></portlet-preferences>'),(10379,0,3,10372,'101_INSTANCE_q0npoXTagYSA','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>portletSetupTitle_en_US</name><value>Recent Content</value></preference></portlet-preferences>'),(10385,0,3,10380,'20','<portlet-preferences><preference><name>portletSetupShowBorders</name><value>false</value></preference></portlet-preferences>'),(10391,0,3,10386,'101_INSTANCE_5H5pmfQIY2uX','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>anyAssetType</name><value>false</value></preference><preference><name>classNameIds</name><value>10009</value></preference><preference><name>portletSetupTitle_en_US</name><value>Upcoming Events</value></preference></portlet-preferences>'),(10397,0,3,10392,'39_INSTANCE_f7mpMOkPEN2r','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>expandedEntriesPerFeed</name><value>3</value></preference><preference><name>urls</name><value>http://partners.userland.com/nytRss/technology.xml</value></preference><preference><name>items-per-channel</name><value>2</value></preference><preference><name>portletSetupTitle_en_US</name><value>Technology news</value></preference></portlet-preferences>'),(10398,0,3,10392,'39_INSTANCE_qtfkHRhc3UFs','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>expandedEntriesPerFeed</name><value>0</value></preference><preference><name>urls</name><value>http://www.liferay.com/en/about-us/news/-/blogs/rss</value></preference><preference><name>titles</name><value>Liferay Press Releases</value></preference><preference><name>items-per-channel</name><value>2</value></preference><preference><name>portletSetupTitle_en_US</name><value>Liferay news</value></preference></portlet-preferences>'),(10589,10179,2,0,'15','<portlet-preferences />'),(10629,0,3,10611,'145','<portlet-preferences />'),(10630,0,3,10611,'terms-of-use','<portlet-preferences />'),(10631,0,3,10611,'new-password','<portlet-preferences />'),(10632,0,3,10611,'password-reminder','<portlet-preferences />'),(13572,0,3,10611,'58','<portlet-preferences />'),(10634,0,3,10611,'103','<portlet-preferences />'),(10636,0,3,10611,'87','<portlet-preferences />'),(10638,0,3,10174,'2','<portlet-preferences />'),(10639,0,3,10174,'160','<portlet-preferences />'),(10641,0,3,10174,'145','<portlet-preferences />'),(10642,0,3,10174,'130','<portlet-preferences />'),(10801,0,3,10611,'49','<portlet-preferences />'),(10807,10198,2,0,'8','<portlet-preferences />'),(10815,0,3,10611,'88','<portlet-preferences />'),(10823,0,3,10174,'88','<portlet-preferences />'),(10826,0,3,10174,'AperteWorkflowPluginManager_WAR_aperteworkflow','<portlet-preferences />'),(10838,0,3,10174,'125','<portlet-preferences />'),(10863,10841,2,0,'8','<portlet-preferences />'),(10901,0,3,10611,'status','<portlet-preferences />'),(11002,10841,2,0,'33','<portlet-preferences />'),(11012,10198,2,0,'33','<portlet-preferences />'),(18128,0,3,18111,'86','<portlet-preferences />'),(18127,0,3,18111,'113','<portlet-preferences />'),(17805,0,3,10174,'20','<portlet-preferences />'),(18202,0,3,18101,'Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_Ub0mcEGAEtTs','<portlet-preferences />'),(18129,0,3,18101,'103','<portlet-preferences />'),(18130,0,3,18101,'145','<portlet-preferences />'),(18201,0,3,18101,'87','<portlet-preferences />'),(11202,0,3,10174,'86','<portlet-preferences />'),(11203,0,3,10174,'134','<portlet-preferences />'),(11204,0,3,10174,'149','<portlet-preferences />'),(11205,0,3,10174,'156','<portlet-preferences />'),(14106,0,3,14101,'103','<portlet-preferences />'),(14107,0,3,14101,'145','<portlet-preferences />'),(14108,0,3,14101,'87','<portlet-preferences />'),(11301,0,3,10174,'128','<portlet-preferences />'),(11303,0,3,10174,'127','<portlet-preferences />'),(11401,0,3,10174,'137','<portlet-preferences />'),(11507,0,3,11502,'103','<portlet-preferences />'),(11508,0,3,11502,'145','<portlet-preferences />'),(18123,0,3,18111,'87','<portlet-preferences />'),(18124,0,3,18111,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep_INSTANCE_lnon2b9YXZh7','<portlet-preferences><preference><name>lfrWapInitialWindowState</name><value>NORMAL</value></preference><preference><name>portletSetupUseCustomTitle</name><value>false</value></preference><preference><name>lfrWapTitle</name><value></value></preference><preference><name>portletSetupCss</name><value>{&#034;wapData&#034;:{&#034;title&#034;:&#034;&#034;,&#034;initialWindowState&#034;:&#034;NORMAL&#034;},&#034;spacingData&#034;:{&#034;margin&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;padding&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;borderData&#034;:{&#034;borderStyle&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;hidden&#034;},&#034;borderColor&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;&#034;},&#034;borderWidth&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;textData&#034;:{&#034;fontWeight&#034;:&#034;&#034;,&#034;lineHeight&#034;:&#034;&#034;,&#034;textDecoration&#034;:&#034;&#034;,&#034;letterSpacing&#034;:&#034;&#034;,&#034;color&#034;:&#034;&#034;,&#034;textAlign&#034;:&#034;&#034;,&#034;fontStyle&#034;:&#034;&#034;,&#034;fontFamily&#034;:&#034;&#034;,&#034;wordSpacing&#034;:&#034;&#034;,&#034;fontSize&#034;:&#034;&#034;},&#034;bgData&#034;:{&#034;backgroundPosition&#034;:{&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;backgroundColor&#034;:&#034;&#034;,&#034;backgroundRepeat&#034;:&#034;&#034;,&#034;backgroundImage&#034;:&#034;&#034;,&#034;useBgImage&#034;:false},&#034;advancedData&#034;:{&#034;customCSS&#034;:&#034;&#034;,&#034;customCSSClassName&#034;:&#034;&#034;}}</value></preference><preference><name>portletSetupShowBorders</name><value>false</value></preference></portlet-preferences>'),(18125,0,3,18106,'113','<portlet-preferences />'),(18126,0,3,18106,'86','<portlet-preferences />'),(11525,0,3,10174,'49','<portlet-preferences />'),(11526,0,3,10174,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow','<portlet-preferences />'),(11527,0,3,10174,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow','<portlet-preferences />'),(11601,0,3,10174,'136','<portlet-preferences />'),(11602,0,3,10174,'1_WAR_marketplaceportlet','<portlet-preferences />'),(11603,0,3,10174,'104','<portlet-preferences />'),(11710,11605,2,0,'15','<portlet-preferences />'),(13102,10153,1,0,'84','<portlet-preferences />'),(13114,0,3,10611,'113','<portlet-preferences />'),(11813,0,3,10611,'86','<portlet-preferences />'),(11915,10179,2,0,'19','<portlet-preferences xmlns=\"http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd\">\n			<preference>\n				<name>priorities</name>\n				<value>Urgent,/message_boards/priority_urgent.png,3.0</value>\n				<value>Sticky,/message_boards/priority_sticky.png,2.0</value>\n				<value>Announcement,/message_boards/priority_announcement.png,1.0</value>\n			</preference>\n			<preference>\n				<name>ranks</name>\n				<value>Youngling=0</value>\n				<value>Padawan=25</value>\n				<value>Jedi Knight=100</value>\n				<value>Jedi Master=250</value>\n				<value>Jedi Council Member=500</value>\n				<value>Yoda=1000</value>\n				<value>Moderator=organization:Message Boards Administrator</value>\n				<value>Moderator=organization-role:Message Boards Administrator</value>\n				<value>Moderator=regular-role:Message Boards Administrator</value>\n				<value>Moderator=site-role:Message Boards Administrator</value>\n				<value>Moderator=user-group:Message Boards Administrator</value>\n			</preference>\n		</portlet-preferences>'),(13551,0,3,10174,'132','<portlet-preferences />'),(11922,0,3,10174,'131','<portlet-preferences />'),(12201,0,3,10174,'174','<portlet-preferences />'),(12301,0,3,10174,'165','<portlet-preferences />'),(12302,0,3,10174,'173','<portlet-preferences xmlns=\"http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd\">\n			<preference>\n				<name>assetVocabularyId</name>\n				<value>-1</value>\n			</preference>\n			<preference>\n				<name>delta</name>\n				<value>5</value>\n			</preference>\n			<preference>\n				<name>displayStyle</name>\n				<value>title-list</value>\n			</preference>\n		</portlet-preferences>'),(12303,0,3,10174,'139','<portlet-preferences />'),(12304,10179,2,0,'25','<portlet-preferences />'),(12305,0,3,10174,'25','<portlet-preferences />'),(12306,10179,2,0,'8','<portlet-preferences />'),(12307,0,3,10174,'8','<portlet-preferences />'),(12308,0,3,10174,'28','<portlet-preferences />'),(12309,10179,2,0,'28','<portlet-preferences />'),(13010,0,3,12116,'103','<portlet-preferences />'),(12501,0,3,10174,'status','<portlet-preferences />'),(12822,0,3,10174,'15','<portlet-preferences />'),(13011,12104,2,0,'33','<portlet-preferences />'),(13012,0,3,12116,'33','<portlet-preferences />'),(13013,0,3,12116,'82','<portlet-preferences />'),(13014,0,3,12116,'3','<portlet-preferences />'),(13015,0,3,12116,'145','<portlet-preferences />'),(13018,0,3,10174,'140','<portlet-preferences />'),(13019,12912,2,0,'154','<portlet-preferences />'),(13021,0,3,10174,'154','<portlet-preferences />'),(13211,0,3,10611,'56_INSTANCE_TO4ossIXPkhm','<portlet-preferences><preference><name>lfrWapInitialWindowState</name><value>NORMAL</value></preference><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>articleId</name><value>13308</value></preference><preference><name>lfrWapTitle</name><value></value></preference><preference><name>portletSetupCss</name><value>{&#034;wapData&#034;:{&#034;title&#034;:&#034;&#034;,&#034;initialWindowState&#034;:&#034;NORMAL&#034;},&#034;hasCssValue&#034;:true,&#034;spacingData&#034;:{&#034;margin&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;padding&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;borderData&#034;:{&#034;borderStyle&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;hidden&#034;},&#034;borderColor&#034;:{&#034;sameForAll&#034;:false,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;&#034;},&#034;borderWidth&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;textData&#034;:{&#034;fontWeight&#034;:&#034;&#034;,&#034;lineHeight&#034;:&#034;&#034;,&#034;textDecoration&#034;:&#034;&#034;,&#034;letterSpacing&#034;:&#034;&#034;,&#034;color&#034;:&#034;&#034;,&#034;textAlign&#034;:&#034;&#034;,&#034;fontStyle&#034;:&#034;&#034;,&#034;fontFamily&#034;:&#034;&#034;,&#034;wordSpacing&#034;:&#034;&#034;,&#034;fontSize&#034;:&#034;&#034;},&#034;bgData&#034;:{&#034;backgroundPosition&#034;:{&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;backgroundColor&#034;:&#034;&#034;,&#034;backgroundRepeat&#034;:&#034;&#034;,&#034;backgroundImage&#034;:&#034;&#034;,&#034;useBgImage&#034;:false},&#034;advancedData&#034;:{&#034;customCSS&#034;:&#034;&#034;,&#034;customCSSClassName&#034;:&#034;&#034;}}</value></preference><preference><name>portletSetupShowBorders</name><value>false</value></preference><preference><name>groupId</name><value>10179</value></preference><preference><name>portletSetupTitle_en_US</name><value>FITMAN Home</value></preference></portlet-preferences>'),(13801,0,3,10174,'146','<portlet-preferences />'),(13901,0,3,10174,'AperteWorkflowAdminPortlet_WAR_aperteworkflow','<portlet-preferences />'),(13902,0,3,10174,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow','<portlet-preferences />'),(14109,0,3,14101,'48_INSTANCE_57K85xxkzz0p','<portlet-preferences><preference><name>passwordField</name><value></value></preference><preference><name>authType</name><value>basic</value></preference><preference><name>form-method</name><value>post</value></preference><preference><name>formMethod</name><value>get</value></preference><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>lfrWapInitialWindowState</name><value>NORMAL</value></preference><preference><name>formPassword</name><value></value></preference><preference><name>width</name><value>100%</value></preference><preference><name>userNameField</name><value></value></preference><preference><name>alt</name><value></value></preference><preference><name>basicPassword</name><value></value></preference><preference><name>hspace</name><value>0</value></preference><preference><name>formUserName</name><value></value></preference><preference><name>resizeAutomatically</name><value>false</value></preference><preference><name>hiddenVariables</name><value></value></preference><preference><name>heightMaximized</name><value>600</value></preference><preference><name>border</name><value>0</value></preference><preference><name>user-name</name><value></value></preference><preference><name>lfrWapTitle</name><value></value></preference><preference><name>scrolling</name><value>auto</value></preference><preference><name>src</name><value>http://localhost:80/ActivitiCompelExplorer2</value></preference><preference><name>hidden-variables</name><value>var1=hello;var2=world</value></preference><preference><name>vspace</name><value>0</value></preference><preference><name>frameborder</name><value>0</value></preference><preference><name>bordercolor</name><value>#000000</value></preference><preference><name>auth-type</name><value>basic</value></preference><preference><name>portletSetupCss</name><value>{&#034;wapData&#034;:{&#034;title&#034;:&#034;&#034;,&#034;initialWindowState&#034;:&#034;NORMAL&#034;},&#034;hasCssValue&#034;:true,&#034;spacingData&#034;:{&#034;margin&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;padding&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;borderData&#034;:{&#034;borderStyle&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;hidden&#034;},&#034;borderColor&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;&#034;},&#034;borderWidth&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;textData&#034;:{&#034;fontWeight&#034;:&#034;&#034;,&#034;lineHeight&#034;:&#034;&#034;,&#034;textDecoration&#034;:&#034;&#034;,&#034;letterSpacing&#034;:&#034;&#034;,&#034;color&#034;:&#034;&#034;,&#034;textAlign&#034;:&#034;&#034;,&#034;fontStyle&#034;:&#034;&#034;,&#034;fontFamily&#034;:&#034;&#034;,&#034;wordSpacing&#034;:&#034;&#034;,&#034;fontSize&#034;:&#034;&#034;},&#034;bgData&#034;:{&#034;backgroundPosition&#034;:{&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;backgroundColor&#034;:&#034;&#034;,&#034;backgroundRepeat&#034;:&#034;&#034;,&#034;backgroundImage&#034;:&#034;&#034;,&#034;useBgImage&#034;:false},&#034;advancedData&#034;:{&#034;customCSS&#034;:&#034;&#034;,&#034;customCSSClassName&#034;:&#034;&#034;}}</value></preference><preference><name>title</name><value></value></preference><preference><name>auth</name><value>false</value></preference><preference><name>portletSetupShowBorders</name><value>false</value></preference><preference><name>relative</name><value>false</value></preference><preference><name>password</name><value></value></preference><preference><name>basicUserName</name><value></value></preference><preference><name>longdesc</name><value></value></preference><preference><name>heightNormal</name><value>600</value></preference><preference><name>portletSetupTitle_en_US</name><value>Activiti Compel</value></preference><preference><name>htmlAttributes</name><value>alt=[$NEW_LINE$]border=0[$NEW_LINE$]bordercolor=#000000[$NEW_LINE$]frameborder=0[$NEW_LINE$]hspace=0[$NEW_LINE$]longdesc=[$NEW_LINE$]scrolling=auto[$NEW_LINE$]title=[$NEW_LINE$]vspace=0</value></preference></portlet-preferences>'),(14110,0,3,14101,'86','<portlet-preferences />'),(14111,0,3,14101,'113','<portlet-preferences />'),(14572,0,3,10174,'129','<portlet-preferences />'),(14672,0,3,10174,'terms-of-use','<portlet-preferences />'),(14701,0,3,10174,'new-password','<portlet-preferences />'),(15010,0,3,10174,'1_WAR_opensocialportlet','<portlet-preferences />'),(15011,0,3,12111,'103','<portlet-preferences />'),(15015,12104,2,0,'8','<portlet-preferences />'),(15021,0,3,12111,'87','<portlet-preferences />'),(15018,0,3,12111,'145','<portlet-preferences />'),(15037,0,3,12111,'113','<portlet-preferences />'),(15038,0,3,12111,'86','<portlet-preferences />'),(15622,0,3,10611,'','<portlet-preferences />'),(15044,0,3,12111,'49','<portlet-preferences />'),(15045,0,3,11502,'88','<portlet-preferences />'),(18118,0,3,18111,'103','<portlet-preferences />'),(18117,0,3,18106,'145','<portlet-preferences />'),(18116,0,3,18106,'103','<portlet-preferences />'),(15216,0,3,10174,'4_WAR_opensocialportlet','<portlet-preferences />'),(16612,0,3,16487,'113','<portlet-preferences />'),(15287,0,3,14101,'88','<portlet-preferences />'),(15501,0,3,14101,'49','<portlet-preferences />'),(16537,0,3,16482,'103','<portlet-preferences />'),(16538,0,3,16482,'145','<portlet-preferences />'),(16607,0,3,16487,'103','<portlet-preferences />'),(16608,0,3,16487,'145','<portlet-preferences />'),(16609,0,3,16487,'87','<portlet-preferences />'),(16610,0,3,16487,'48_INSTANCE_C8iz5NUdy1gW','<portlet-preferences><preference><name>passwordField</name><value></value></preference><preference><name>authType</name><value>basic</value></preference><preference><name>form-method</name><value>post</value></preference><preference><name>formMethod</name><value>get</value></preference><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>lfrWapInitialWindowState</name><value>NORMAL</value></preference><preference><name>formPassword</name><value></value></preference><preference><name>width</name><value>100%</value></preference><preference><name>userNameField</name><value></value></preference><preference><name>alt</name><value></value></preference><preference><name>basicPassword</name><value></value></preference><preference><name>hspace</name><value>0</value></preference><preference><name>formUserName</name><value></value></preference><preference><name>resizeAutomatically</name><value>true</value></preference><preference><name>user-name</name><value></value></preference><preference><name>hiddenVariables</name><value></value></preference><preference><name>heightMaximized</name><value>600</value></preference><preference><name>border</name><value>0</value></preference><preference><name>lfrWapTitle</name><value></value></preference><preference><name>scrolling</name><value>auto</value></preference><preference><name>src</name><value>http://localhost:8080/changeManagementWizard/</value></preference><preference><name>hidden-variables</name><value>var1=hello;var2=world</value></preference><preference><name>vspace</name><value>0</value></preference><preference><name>frameborder</name><value>0</value></preference><preference><name>bordercolor</name><value>#000000</value></preference><preference><name>auth-type</name><value>basic</value></preference><preference><name>portletSetupCss</name><value>{&#034;wapData&#034;:{&#034;title&#034;:&#034;&#034;,&#034;initialWindowState&#034;:&#034;NORMAL&#034;},&#034;spacingData&#034;:{&#034;margin&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;padding&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;borderData&#034;:{&#034;borderStyle&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;&#034;},&#034;borderColor&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;&#034;},&#034;borderWidth&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;textData&#034;:{&#034;fontWeight&#034;:&#034;&#034;,&#034;lineHeight&#034;:&#034;&#034;,&#034;textDecoration&#034;:&#034;&#034;,&#034;letterSpacing&#034;:&#034;&#034;,&#034;color&#034;:&#034;&#034;,&#034;textAlign&#034;:&#034;&#034;,&#034;fontStyle&#034;:&#034;&#034;,&#034;fontFamily&#034;:&#034;&#034;,&#034;wordSpacing&#034;:&#034;&#034;,&#034;fontSize&#034;:&#034;&#034;},&#034;bgData&#034;:{&#034;backgroundPosition&#034;:{&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;backgroundColor&#034;:&#034;&#034;,&#034;backgroundRepeat&#034;:&#034;&#034;,&#034;backgroundImage&#034;:&#034;&#034;,&#034;useBgImage&#034;:false},&#034;advancedData&#034;:{&#034;customCSS&#034;:&#034;&#034;,&#034;customCSSClassName&#034;:&#034;&#034;}}</value></preference><preference><name>title</name><value></value></preference><preference><name>auth</name><value>false</value></preference><preference><name>relative</name><value>false</value></preference><preference><name>password</name><value></value></preference><preference><name>basicUserName</name><value></value></preference><preference><name>heightNormal</name><value>600</value></preference><preference><name>longdesc</name><value></value></preference><preference><name>portletSetupTitle_en_US</name><value>Change Management Wizard</value></preference><preference><name>htmlAttributes</name><value>alt=[$NEW_LINE$]border=0[$NEW_LINE$]bordercolor=#000000[$NEW_LINE$]frameborder=0[$NEW_LINE$]hspace=0[$NEW_LINE$]longdesc=[$NEW_LINE$]scrolling=auto[$NEW_LINE$]title=[$NEW_LINE$]vspace=0</value></preference></portlet-preferences>'),(16611,0,3,16487,'86','<portlet-preferences />'),(16057,0,3,12111,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688','<portlet-preferences />'),(16701,0,3,10174,'161','<portlet-preferences />'),(18122,0,3,18106,'49','<portlet-preferences />'),(18121,0,3,18106,'Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_HnbYWtIepvG6','<portlet-preferences><preference><name>lfrWapInitialWindowState</name><value>NORMAL</value></preference><preference><name>portletSetupUseCustomTitle</name><value>false</value></preference><preference><name>lfrWapTitle</name><value></value></preference><preference><name>portletSetupCss</name><value>{&#034;wapData&#034;:{&#034;title&#034;:&#034;&#034;,&#034;initialWindowState&#034;:&#034;NORMAL&#034;},&#034;spacingData&#034;:{&#034;margin&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;padding&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;borderData&#034;:{&#034;borderStyle&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;hidden&#034;},&#034;borderColor&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:&#034;&#034;,&#034;left&#034;:&#034;&#034;,&#034;right&#034;:&#034;&#034;,&#034;top&#034;:&#034;&#034;},&#034;borderWidth&#034;:{&#034;sameForAll&#034;:true,&#034;bottom&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;right&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}}},&#034;textData&#034;:{&#034;fontWeight&#034;:&#034;&#034;,&#034;lineHeight&#034;:&#034;&#034;,&#034;textDecoration&#034;:&#034;&#034;,&#034;letterSpacing&#034;:&#034;&#034;,&#034;color&#034;:&#034;&#034;,&#034;textAlign&#034;:&#034;&#034;,&#034;fontStyle&#034;:&#034;&#034;,&#034;fontFamily&#034;:&#034;&#034;,&#034;wordSpacing&#034;:&#034;&#034;,&#034;fontSize&#034;:&#034;&#034;},&#034;bgData&#034;:{&#034;backgroundPosition&#034;:{&#034;left&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;},&#034;top&#034;:{&#034;unit&#034;:&#034;px&#034;,&#034;value&#034;:&#034;&#034;}},&#034;backgroundColor&#034;:&#034;&#034;,&#034;backgroundRepeat&#034;:&#034;&#034;,&#034;backgroundImage&#034;:&#034;&#034;,&#034;useBgImage&#034;:false},&#034;advancedData&#034;:{&#034;customCSS&#034;:&#034;&#034;,&#034;customCSSClassName&#034;:&#034;&#034;}}</value></preference><preference><name>portletSetupShowBorders</name><value>false</value></preference></portlet-preferences>'),(16806,0,3,10174,'111','<portlet-preferences />'),(18120,0,3,18106,'87','<portlet-preferences />'),(18119,0,3,18111,'145','<portlet-preferences />'),(17001,0,3,10174,'98','<portlet-preferences />'),(16066,15926,2,0,'8','<portlet-preferences />'),(16035,0,3,12111,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>portletSetupTitle_en_US</name><value></value></preference></portlet-preferences>'),(16044,0,3,12111,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>portletSetupTitle_en_US</name><value></value></preference></portlet-preferences>'),(16025,15969,2,0,'8','<portlet-preferences />'),(16037,0,3,12116,'87','<portlet-preferences />'),(16045,0,3,12111,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6','<portlet-preferences><preference><name>portletSetupUseCustomTitle</name><value>true</value></preference><preference><name>portletSetupTitle_en_US</name><value></value></preference></portlet-preferences>'),(16046,0,3,12111,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95','<portlet-preferences />'),(15707,0,3,10611,'error','<portlet-preferences />'),(16302,15969,2,0,'33','<portlet-preferences />'),(17401,0,3,10611,'125','<portlet-preferences />'),(17501,10179,2,0,'154','<portlet-preferences />');
/*!40000 ALTER TABLE `portletpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orglabor`
--

DROP TABLE IF EXISTS `orglabor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orglabor` (
  `orgLaborId` bigint(20) NOT NULL,
  `organizationId` bigint(20) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `sunOpen` int(11) DEFAULT NULL,
  `sunClose` int(11) DEFAULT NULL,
  `monOpen` int(11) DEFAULT NULL,
  `monClose` int(11) DEFAULT NULL,
  `tueOpen` int(11) DEFAULT NULL,
  `tueClose` int(11) DEFAULT NULL,
  `wedOpen` int(11) DEFAULT NULL,
  `wedClose` int(11) DEFAULT NULL,
  `thuOpen` int(11) DEFAULT NULL,
  `thuClose` int(11) DEFAULT NULL,
  `friOpen` int(11) DEFAULT NULL,
  `friClose` int(11) DEFAULT NULL,
  `satOpen` int(11) DEFAULT NULL,
  `satClose` int(11) DEFAULT NULL,
  PRIMARY KEY (`orgLaborId`),
  KEY `IX_6AF0D434` (`organizationId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orglabor`
--

LOCK TABLES `orglabor` WRITE;
/*!40000 ALTER TABLE `orglabor` DISABLE KEYS */;
INSERT INTO `orglabor` VALUES (14331,14301,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(15902,14259,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14227,14201,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14246,14228,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14324,14315,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14328,14273,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14329,14287,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14330,14247,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14346,14332,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14400,14385,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14366,14348,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14382,14369,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14418,14403,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(15076,15069,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(14439,14421,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),(15901,14214,12012,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
/*!40000 ALTER TABLE `orglabor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_permissions`
--

DROP TABLE IF EXISTS `groups_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_permissions` (
  `groupId` bigint(20) NOT NULL,
  `permissionId` bigint(20) NOT NULL,
  PRIMARY KEY (`groupId`,`permissionId`),
  KEY `IX_C48736B` (`groupId`),
  KEY `IX_EC97689D` (`permissionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_permissions`
--

LOCK TABLES `groups_permissions` WRITE;
/*!40000 ALTER TABLE `groups_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sclicense`
--

DROP TABLE IF EXISTS `sclicense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sclicense` (
  `licenseId` bigint(20) NOT NULL,
  `name` varchar(75) DEFAULT NULL,
  `url` longtext,
  `openSource` tinyint(4) DEFAULT NULL,
  `active_` tinyint(4) DEFAULT NULL,
  `recommended` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`licenseId`),
  KEY `IX_1C841592` (`active_`),
  KEY `IX_5327BB79` (`active_`,`recommended`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sclicense`
--

LOCK TABLES `sclicense` WRITE;
/*!40000 ALTER TABLE `sclicense` DISABLE KEYS */;
/*!40000 ALTER TABLE `sclicense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepermission`
--

DROP TABLE IF EXISTS `resourcepermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepermission` (
  `resourcePermissionId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scope` int(11) DEFAULT NULL,
  `primKey` varchar(255) DEFAULT NULL,
  `roleId` bigint(20) DEFAULT NULL,
  `ownerId` bigint(20) DEFAULT NULL,
  `actionIds` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`resourcePermissionId`),
  KEY `IX_88705859` (`companyId`,`name`,`primKey`,`ownerId`),
  KEY `IX_C94C7708` (`companyId`,`name`,`primKey`,`roleId`,`actionIds`),
  KEY `IX_60B99860` (`companyId`,`name`,`scope`),
  KEY `IX_2200AA69` (`companyId`,`name`,`scope`,`primKey`),
  KEY `IX_8D83D0CE` (`companyId`,`name`,`scope`,`primKey`,`roleId`),
  KEY `IX_D2E2B644` (`companyId`,`name`,`scope`,`primKey`,`roleId`,`actionIds`),
  KEY `IX_4A1F4402` (`companyId`,`name`,`scope`,`primKey`,`roleId`,`ownerId`,`actionIds`),
  KEY `IX_26284944` (`companyId`,`primKey`),
  KEY `IX_A37A0588` (`roleId`),
  KEY `IX_F4555981` (`scope`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepermission`
--

LOCK TABLES `resourcepermission` WRITE;
/*!40000 ALTER TABLE `resourcepermission` DISABLE KEYS */;
INSERT INTO `resourcepermission` VALUES (164,10153,'100',1,'10153',10163,0,2),(165,10153,'100',1,'10153',10164,0,2),(29,10153,'100',2,'10188',10164,0,1),(214,10153,'101',1,'10153',10161,0,2),(215,10153,'101',1,'10153',10163,0,2),(216,10153,'101',1,'10153',10164,0,2),(60,10153,'101',2,'10188',10164,0,1),(344,10153,'101',4,'10323_LAYOUT_101_INSTANCE_Bc4wRUvzfejz',10161,0,1),(342,10153,'101',4,'10323_LAYOUT_101_INSTANCE_Bc4wRUvzfejz',10162,0,15),(343,10153,'101',4,'10323_LAYOUT_101_INSTANCE_Bc4wRUvzfejz',10169,0,1),(301,10153,'102',1,'10153',10161,0,2),(302,10153,'102',1,'10153',10163,0,2),(303,10153,'102',1,'10153',10164,0,2),(106,10153,'102',2,'10188',10164,0,1),(6701,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'18301',10162,12102,127),(448,10153,'103',4,'10611_LAYOUT_103',10161,0,1),(446,10153,'103',4,'10611_LAYOUT_103',10162,0,15),(447,10153,'103',4,'10611_LAYOUT_103',10169,0,1),(5414,10153,'com.liferay.portal.model.Layout',4,'16482',10164,0,1),(1209,10153,'103',4,'11502_LAYOUT_103',10161,0,1),(1207,10153,'103',4,'11502_LAYOUT_103',10162,0,15),(1208,10153,'103',4,'11502_LAYOUT_103',10169,0,1),(152,10153,'104',1,'10153',10160,0,2),(22,10153,'104',2,'10188',10164,0,1),(1309,10153,'104',4,'10174_LAYOUT_104',10161,0,1),(1307,10153,'104',4,'10174_LAYOUT_104',10162,0,31),(1308,10153,'104',4,'10174_LAYOUT_104',10169,0,1),(201,10153,'107',1,'10153',10163,0,2),(202,10153,'107',1,'10153',10164,0,2),(48,10153,'107',2,'10188',10164,0,1),(210,10153,'108',1,'10153',10163,0,2),(211,10153,'108',1,'10153',10164,0,2),(58,10153,'108',2,'10188',10164,0,1),(174,10153,'11',1,'10153',10163,0,2),(175,10153,'11',1,'10153',10164,0,2),(36,10153,'11',2,'10188',10164,0,1),(297,10153,'110',1,'10153',10163,0,2),(298,10153,'110',1,'10153',10164,0,2),(102,10153,'110',2,'10188',10164,0,1),(236,10153,'111',1,'10153',10160,0,2),(68,10153,'111',2,'10188',10164,0,1),(292,10153,'114',1,'10153',10161,0,2),(293,10153,'114',1,'10153',10163,0,2),(294,10153,'114',1,'10153',10164,0,2),(99,10153,'114',2,'10188',10164,0,1),(329,10153,'114',4,'10313_LAYOUT_114',10161,0,1),(327,10153,'114',4,'10313_LAYOUT_114',10162,0,15),(328,10153,'114',4,'10313_LAYOUT_114',10169,0,1),(228,10153,'115',1,'10153',10161,0,2),(229,10153,'115',1,'10153',10163,0,2),(230,10153,'115',1,'10153',10164,0,2),(65,10153,'115',2,'10188',10164,0,1),(263,10153,'116',1,'10153',10161,0,2),(264,10153,'116',1,'10153',10163,0,2),(265,10153,'116',1,'10153',10164,0,2),(82,10153,'116',2,'10188',10164,0,1),(198,10153,'118',1,'10153',10161,0,2),(199,10153,'118',1,'10153',10163,0,2),(200,10153,'118',1,'10153',10164,0,2),(47,10153,'118',2,'10188',10164,0,1),(217,10153,'121',1,'10153',10161,0,2),(218,10153,'121',1,'10153',10163,0,2),(219,10153,'121',1,'10153',10164,0,2),(61,10153,'121',2,'10188',10164,0,1),(145,10153,'122',1,'10153',10161,0,2),(146,10153,'122',1,'10153',10163,0,2),(147,10153,'122',1,'10153',10164,0,2),(19,10153,'122',2,'10188',10164,0,1),(338,10153,'122',4,'10323_LAYOUT_122_INSTANCE_e1Lv45aLNVTw',10161,0,1),(336,10153,'122',4,'10323_LAYOUT_122_INSTANCE_e1Lv45aLNVTw',10162,0,15),(337,10153,'122',4,'10323_LAYOUT_122_INSTANCE_e1Lv45aLNVTw',10169,0,1),(354,10153,'122',4,'10332_LAYOUT_122_INSTANCE_4P3b9TD49dbc',10161,0,1),(352,10153,'122',4,'10332_LAYOUT_122_INSTANCE_4P3b9TD49dbc',10162,0,15),(353,10153,'122',4,'10332_LAYOUT_122_INSTANCE_4P3b9TD49dbc',10169,0,1),(52,10153,'125',2,'10188',10164,0,1),(577,10153,'125',4,'10174_LAYOUT_125',10161,0,1),(575,10153,'125',4,'10174_LAYOUT_125',10162,0,31),(576,10153,'125',4,'10174_LAYOUT_125',10163,0,1),(286,10153,'127',1,'10153',10160,0,2),(94,10153,'127',2,'10188',10164,0,1),(1007,10153,'127',4,'10174_LAYOUT_127',10161,0,1),(1005,10153,'127',4,'10174_LAYOUT_127',10162,0,31),(1006,10153,'127',4,'10174_LAYOUT_127',10169,0,1),(32,10153,'128',2,'10188',10164,0,1),(1003,10153,'128',4,'10174_LAYOUT_128',10161,0,1),(1001,10153,'128',4,'10174_LAYOUT_128',10162,0,15),(1002,10153,'128',4,'10174_LAYOUT_128',10169,0,1),(26,10153,'129',2,'10188',10164,0,1),(18,10153,'130',2,'10188',10164,0,1),(470,10153,'130',4,'10174_LAYOUT_130',10161,0,1),(468,10153,'130',4,'10174_LAYOUT_130',10162,0,15),(469,10153,'130',4,'10174_LAYOUT_130',10169,0,1),(105,10153,'131',2,'10188',10164,0,1),(1549,10153,'131',4,'10174_LAYOUT_131',10161,0,1),(1547,10153,'131',4,'10174_LAYOUT_131',10162,0,15),(1548,10153,'131',4,'10174_LAYOUT_131',10169,0,1),(88,10153,'132',2,'10188',10164,0,1),(17,10153,'134',2,'10188',10164,0,1),(906,10153,'134',4,'10174_LAYOUT_134',10161,0,1),(904,10153,'134',4,'10174_LAYOUT_134',10162,0,15),(905,10153,'134',4,'10174_LAYOUT_134',10163,0,1),(104,10153,'135',2,'10188',10164,0,1),(92,10153,'136',2,'10188',10164,0,1),(1303,10153,'136',4,'10174_LAYOUT_136',10161,0,1),(1301,10153,'136',4,'10174_LAYOUT_136',10162,0,15),(1302,10153,'136',4,'10174_LAYOUT_136',10169,0,1),(79,10153,'137',2,'10188',10164,0,1),(1103,10153,'137',4,'10174_LAYOUT_137',10161,0,1),(1101,10153,'137',4,'10174_LAYOUT_137',10162,0,15),(1102,10153,'137',4,'10174_LAYOUT_137',10169,0,1),(1907,10153,'139',4,'10174_LAYOUT_139',10162,0,31),(2,10153,'140',1,'10153',10164,0,2),(252,10153,'141',1,'10153',10161,0,2),(253,10153,'141',1,'10153',10163,0,2),(254,10153,'141',1,'10153',10164,0,2),(76,10153,'141',2,'10188',10164,0,1),(335,10153,'141',4,'10323_LAYOUT_141_INSTANCE_xcONX87j3IcH',10161,0,1),(333,10153,'141',4,'10323_LAYOUT_141_INSTANCE_xcONX87j3IcH',10162,0,15),(334,10153,'141',4,'10323_LAYOUT_141_INSTANCE_xcONX87j3IcH',10169,0,1),(357,10153,'141',4,'10332_LAYOUT_141_INSTANCE_A0YMQ8tReclT',10161,0,1),(355,10153,'141',4,'10332_LAYOUT_141_INSTANCE_A0YMQ8tReclT',10162,0,15),(356,10153,'141',4,'10332_LAYOUT_141_INSTANCE_A0YMQ8tReclT',10169,0,1),(220,10153,'143',1,'10153',10161,0,2),(221,10153,'143',1,'10153',10163,0,2),(222,10153,'143',1,'10153',10164,0,2),(62,10153,'143',2,'10188',10164,0,1),(467,10153,'145',4,'10174_LAYOUT_145',10161,0,1),(465,10153,'145',4,'10174_LAYOUT_145',10162,0,15),(466,10153,'145',4,'10174_LAYOUT_145',10169,0,1),(6606,10153,'Asset_View_WAR_Asset_Viewer_Rep',4,'18101_LAYOUT_Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_Ub0mcEGAEtTs',10161,0,1),(445,10153,'145',4,'10611_LAYOUT_145',10161,0,1),(443,10153,'145',4,'10611_LAYOUT_145',10162,0,15),(444,10153,'145',4,'10611_LAYOUT_145',10169,0,1),(5413,10153,'com.liferay.portal.model.Layout',4,'10611',10164,0,1),(1212,10153,'145',4,'11502_LAYOUT_145',10161,0,1),(1210,10153,'145',4,'11502_LAYOUT_145',10162,0,15),(1211,10153,'145',4,'11502_LAYOUT_145',10169,0,1),(54,10153,'146',2,'10188',10164,0,1),(117,10153,'147',2,'10188',10163,0,2),(50,10153,'147',2,'10188',10164,0,1),(171,10153,'148',1,'10153',10161,0,2),(172,10153,'148',1,'10153',10163,0,2),(173,10153,'148',1,'10153',10164,0,2),(35,10153,'148',2,'10188',10164,0,1),(326,10153,'148',4,'10313_LAYOUT_148_INSTANCE_09Cw8dOe6ahN',10161,0,1),(324,10153,'148',4,'10313_LAYOUT_148_INSTANCE_09Cw8dOe6ahN',10162,0,15),(325,10153,'148',4,'10313_LAYOUT_148_INSTANCE_09Cw8dOe6ahN',10169,0,1),(100,10153,'149',2,'10188',10164,0,1),(909,10153,'149',4,'10174_LAYOUT_149',10161,0,1),(907,10153,'149',4,'10174_LAYOUT_149',10162,0,15),(908,10153,'149',4,'10174_LAYOUT_149',10163,0,1),(261,10153,'15',1,'10153',10163,0,4),(262,10153,'15',1,'10153',10164,0,4),(124,10153,'15',2,'10188',10163,0,2),(81,10153,'15',2,'10188',10164,0,1),(1412,10153,'15',4,'10611_LAYOUT_15',10161,0,1),(1410,10153,'15',4,'10611_LAYOUT_15',10162,0,31),(1411,10153,'15',4,'10611_LAYOUT_15',10169,0,1),(98,10153,'150',2,'10188',10164,0,1),(84,10153,'151',2,'10188',10164,0,1),(111,10153,'152',2,'10188',10163,0,2),(16,10153,'152',2,'10188',10164,0,1),(156,10153,'153',1,'10153',10163,0,4),(4,10153,'153',1,'10153',10164,0,2),(24,10153,'153',2,'10188',10164,0,1),(114,10153,'154',2,'10188',10163,0,2),(34,10153,'154',2,'10188',10164,0,1),(912,10153,'156',4,'10174_LAYOUT_156',10161,0,1),(910,10153,'156',4,'10174_LAYOUT_156',10162,0,31),(911,10153,'156',4,'10174_LAYOUT_156',10163,0,1),(31,10153,'157',2,'10188',10164,0,1),(178,10153,'158',1,'10153',10163,0,4),(3,10153,'158',1,'10153',10164,0,2),(38,10153,'158',2,'10188',10164,0,1),(234,10153,'16',1,'10153',10163,0,8),(235,10153,'16',1,'10153',10164,0,8),(67,10153,'16',2,'10188',10164,0,1),(462,10153,'160',4,'10174_LAYOUT_160',10161,0,1),(463,10153,'160',4,'10174_LAYOUT_160',10161,0,1),(458,10153,'160',4,'10174_LAYOUT_160',10162,0,15),(459,10153,'160',4,'10174_LAYOUT_160',10162,0,15),(460,10153,'160',4,'10174_LAYOUT_160',10169,0,1),(461,10153,'160',4,'10174_LAYOUT_160',10169,0,1),(118,10153,'161',2,'10188',10163,0,2),(53,10153,'161',2,'10188',10164,0,1),(119,10153,'162',2,'10188',10163,0,2),(56,10153,'162',2,'10188',10164,0,1),(247,10153,'164',1,'10153',10161,0,2),(248,10153,'164',1,'10153',10163,0,2),(249,10153,'164',1,'10153',10164,0,2),(73,10153,'164',2,'10188',10164,0,1),(1903,10153,'165',4,'10174_LAYOUT_165',10161,0,1),(1901,10153,'165',4,'10174_LAYOUT_165',10162,0,31),(1902,10153,'165',4,'10174_LAYOUT_165',10169,0,1),(287,10153,'166',1,'10153',10163,0,4),(288,10153,'166',1,'10153',10164,0,4),(96,10153,'166',2,'10188',10164,0,1),(226,10153,'167',1,'10153',10163,0,4),(227,10153,'167',1,'10153',10164,0,4),(120,10153,'167',2,'10188',10163,0,2),(64,10153,'167',2,'10188',10164,0,1),(273,10153,'169',1,'10153',10163,0,2),(274,10153,'169',1,'10153',10164,0,2),(87,10153,'169',2,'10188',10164,0,1),(161,10153,'173',1,'10153',10161,0,2),(162,10153,'173',1,'10153',10163,0,2),(163,10153,'173',1,'10153',10164,0,2),(113,10153,'173',2,'10188',10163,0,4),(28,10153,'173',2,'10188',10164,0,1),(1906,10153,'173',4,'10174_LAYOUT_173',10161,0,1),(1904,10153,'173',4,'10174_LAYOUT_173',10162,0,31),(1905,10153,'173',4,'10174_LAYOUT_173',10169,0,1),(1803,10153,'174',4,'10174_LAYOUT_174',10161,0,1),(1801,10153,'174',4,'10174_LAYOUT_174',10162,0,31),(1802,10153,'174',4,'10174_LAYOUT_174',10169,0,1),(153,10153,'175',1,'10153',10161,0,2),(154,10153,'175',1,'10153',10163,0,2),(155,10153,'175',1,'10153',10164,0,2),(23,10153,'175',2,'10188',10164,0,1),(209,10153,'176',1,'10153',10160,0,2),(57,10153,'176',2,'10188',10164,0,1),(193,10153,'177',1,'10153',10163,0,4),(194,10153,'177',1,'10153',10164,0,4),(45,10153,'177',2,'10188',10164,0,1),(179,10153,'178',1,'10153',10163,0,2),(180,10153,'178',1,'10153',10164,0,2),(115,10153,'178',2,'10188',10163,0,4),(39,10153,'178',2,'10188',10164,0,1),(160,10153,'179',1,'10153',10160,0,2),(112,10153,'179',2,'10188',10163,0,4),(27,10153,'179',2,'10188',10164,0,1),(140,10153,'180',1,'10153',10161,0,2),(141,10153,'180',1,'10153',10163,0,2),(142,10153,'180',1,'10153',10164,0,2),(14,10153,'180',2,'10188',10164,0,1),(168,10153,'181',1,'10153',10161,0,2),(169,10153,'181',1,'10153',10163,0,2),(170,10153,'181',1,'10153',10164,0,2),(33,10153,'181',2,'10188',10164,0,1),(166,10153,'19',1,'10153',10163,0,2),(167,10153,'19',1,'10153',10164,0,2),(30,10153,'19',2,'10188',10164,0,1),(1306,10153,'1_WAR_marketplaceportlet',4,'10174_LAYOUT_1_WAR_marketplaceportlet',10161,0,1),(1304,10153,'1_WAR_marketplaceportlet',4,'10174_LAYOUT_1_WAR_marketplaceportlet',10162,0,31),(1305,10153,'1_WAR_marketplaceportlet',4,'10174_LAYOUT_1_WAR_marketplaceportlet',10169,0,1),(1,10153,'2',1,'10153',10164,0,2),(464,10153,'2',4,'10174_LAYOUT_2',10162,0,15),(242,10153,'20',1,'10153',10161,0,4),(243,10153,'20',1,'10153',10163,0,4),(244,10153,'20',1,'10153',10164,0,4),(121,10153,'20',2,'10188',10163,0,2),(71,10153,'20',2,'10188',10164,0,1),(240,10153,'23',1,'10153',10163,0,2),(241,10153,'23',1,'10153',10164,0,2),(70,10153,'23',2,'10188',10164,0,1),(125,10153,'25',2,'10188',10163,0,2),(95,10153,'25',2,'10188',10164,0,1),(1910,10153,'25',4,'10174_LAYOUT_25',10161,0,1),(1908,10153,'25',4,'10174_LAYOUT_25',10162,0,15),(1909,10153,'25',4,'10174_LAYOUT_25',10169,0,1),(150,10153,'26',1,'10153',10163,0,2),(151,10153,'26',1,'10153',10164,0,2),(21,10153,'26',2,'10188',10164,0,1),(143,10153,'27',1,'10153',10163,0,2),(144,10153,'27',1,'10153',10164,0,2),(15,10153,'27',2,'10188',10164,0,1),(256,10153,'28',1,'10153',10163,0,4),(257,10153,'28',1,'10153',10164,0,4),(123,10153,'28',2,'10188',10163,0,2),(78,10153,'28',2,'10188',10164,0,1),(1918,10153,'28',4,'10174_LAYOUT_28',10161,0,1),(1916,10153,'28',4,'10174_LAYOUT_28',10162,0,31),(1917,10153,'28',4,'10174_LAYOUT_28',10169,0,1),(176,10153,'29',1,'10153',10163,0,2),(177,10153,'29',1,'10153',10164,0,2),(37,10153,'29',2,'10188',10164,0,1),(237,10153,'3',1,'10153',10161,0,2),(238,10153,'3',1,'10153',10163,0,2),(239,10153,'3',1,'10153',10164,0,2),(69,10153,'3',2,'10188',10164,0,1),(341,10153,'3',4,'10323_LAYOUT_3',10161,0,1),(339,10153,'3',4,'10323_LAYOUT_3',10162,0,15),(340,10153,'3',4,'10323_LAYOUT_3',10169,0,1),(6605,10153,'Asset_View_WAR_Asset_Viewer_Rep',4,'18101_LAYOUT_Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_Ub0mcEGAEtTs',10169,0,1),(203,10153,'30',1,'10153',10163,0,2),(204,10153,'30',1,'10153',10164,0,2),(49,10153,'30',2,'10188',10164,0,1),(280,10153,'31',1,'10153',10161,0,2),(281,10153,'31',1,'10153',10163,0,2),(282,10153,'31',1,'10153',10164,0,2),(91,10153,'31',2,'10188',10164,0,1),(289,10153,'33',1,'10153',10161,0,2),(290,10153,'33',1,'10153',10163,0,2),(291,10153,'33',1,'10153',10164,0,2),(97,10153,'33',2,'10188',10164,0,1),(322,10153,'33',4,'10313_LAYOUT_33',10161,0,1),(320,10153,'33',4,'10313_LAYOUT_33',10162,0,15),(321,10153,'33',4,'10313_LAYOUT_33',10169,0,1),(6604,10153,'Asset_View_WAR_Asset_Viewer_Rep',4,'18101_LAYOUT_Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_Ub0mcEGAEtTs',10162,0,15),(6603,10153,'87',4,'18101_LAYOUT_87',10161,0,1),(271,10153,'34',1,'10153',10163,0,2),(272,10153,'34',1,'10153',10164,0,2),(86,10153,'34',2,'10188',10164,0,1),(148,10153,'36',1,'10153',10163,0,2),(149,10153,'36',1,'10153',10164,0,2),(20,10153,'36',2,'10188',10164,0,1),(350,10153,'36',4,'10332_LAYOUT_36',10161,0,1),(348,10153,'36',4,'10332_LAYOUT_36',10162,0,15),(349,10153,'36',4,'10332_LAYOUT_36',10169,0,1),(191,10153,'39',1,'10153',10163,0,2),(192,10153,'39',1,'10153',10164,0,2),(44,10153,'39',2,'10188',10164,0,1),(258,10153,'47',1,'10153',10161,0,2),(259,10153,'47',1,'10153',10163,0,2),(260,10153,'47',1,'10153',10164,0,2),(80,10153,'47',2,'10188',10164,0,1),(205,10153,'48',1,'10153',10163,0,2),(206,10153,'48',1,'10153',10164,0,2),(51,10153,'48',2,'10188',10164,0,1),(1241,10153,'49',4,'10174_LAYOUT_49',10161,0,1),(1239,10153,'49',4,'10174_LAYOUT_49',10162,0,15),(1240,10153,'49',4,'10174_LAYOUT_49',10169,0,1),(6602,10153,'87',4,'18101_LAYOUT_87',10169,0,1),(503,10153,'49',4,'10611_LAYOUT_49',10161,0,1),(501,10153,'49',4,'10611_LAYOUT_49',10162,0,15),(502,10153,'49',4,'10611_LAYOUT_49',10169,0,1),(283,10153,'50',1,'10153',10161,0,2),(284,10153,'50',1,'10153',10163,0,2),(285,10153,'50',1,'10153',10164,0,2),(93,10153,'50',2,'10188',10164,0,1),(269,10153,'54',1,'10153',10163,0,2),(270,10153,'54',1,'10153',10164,0,2),(85,10153,'54',2,'10188',10164,0,1),(231,10153,'56',1,'10153',10161,0,2),(232,10153,'56',1,'10153',10163,0,2),(233,10153,'56',1,'10153',10164,0,2),(66,10153,'56',2,'10188',10164,0,1),(183,10153,'58',1,'10153',10161,0,2),(184,10153,'58',1,'10153',10163,0,2),(185,10153,'58',1,'10153',10164,0,2),(41,10153,'58',2,'10188',10164,0,1),(299,10153,'59',1,'10153',10163,0,2),(300,10153,'59',1,'10153',10164,0,2),(103,10153,'59',2,'10188',10164,0,1),(275,10153,'61',1,'10153',10163,0,2),(276,10153,'61',1,'10153',10164,0,2),(89,10153,'61',2,'10188',10164,0,1),(207,10153,'62',1,'10153',10163,0,2),(208,10153,'62',1,'10153',10164,0,2),(55,10153,'62',2,'10188',10164,0,1),(157,10153,'64',1,'10153',10161,0,2),(158,10153,'64',1,'10153',10163,0,2),(159,10153,'64',1,'10153',10164,0,2),(25,10153,'64',2,'10188',10164,0,1),(138,10153,'66',1,'10153',10163,0,2),(139,10153,'66',1,'10153',10164,0,2),(13,10153,'66',2,'10188',10164,0,1),(295,10153,'67',1,'10153',10163,0,2),(296,10153,'67',1,'10153',10164,0,2),(101,10153,'67',2,'10188',10164,0,1),(250,10153,'70',1,'10153',10163,0,2),(251,10153,'70',1,'10153',10164,0,2),(75,10153,'70',2,'10188',10164,0,1),(186,10153,'71',1,'10153',10161,0,2),(187,10153,'71',1,'10153',10163,0,2),(188,10153,'71',1,'10153',10164,0,2),(42,10153,'71',2,'10188',10164,0,1),(277,10153,'73',1,'10153',10161,0,2),(278,10153,'73',1,'10153',10163,0,2),(279,10153,'73',1,'10153',10164,0,2),(90,10153,'73',2,'10188',10164,0,1),(223,10153,'77',1,'10153',10161,0,2),(224,10153,'77',1,'10153',10163,0,2),(225,10153,'77',1,'10153',10164,0,2),(63,10153,'77',2,'10188',10164,0,1),(181,10153,'8',1,'10153',10163,0,4),(182,10153,'8',1,'10153',10164,0,4),(116,10153,'8',2,'10188',10163,0,2),(40,10153,'8',2,'10188',10164,0,1),(1914,10153,'8',4,'10174_LAYOUT_8',10161,0,1),(1912,10153,'8',4,'10174_LAYOUT_8',10162,0,31),(1913,10153,'8',4,'10174_LAYOUT_8',10169,0,1),(266,10153,'82',1,'10153',10161,0,2),(267,10153,'82',1,'10153',10163,0,2),(268,10153,'82',1,'10153',10164,0,2),(83,10153,'82',2,'10188',10164,0,1),(6703,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'18301',10161,0,3),(6548,10153,'145',4,'18101_LAYOUT_145',10161,0,1),(6547,10153,'145',4,'18101_LAYOUT_145',10169,0,1),(245,10153,'83',1,'10153',10163,0,4),(246,10153,'83',1,'10153',10164,0,4),(72,10153,'83',2,'10188',10164,0,1),(212,10153,'84',1,'10153',10163,0,4),(213,10153,'84',1,'10153',10164,0,4),(59,10153,'84',2,'10188',10164,0,1),(195,10153,'85',1,'10153',10161,0,2),(196,10153,'85',1,'10153',10163,0,2),(197,10153,'85',1,'10153',10164,0,2),(46,10153,'85',2,'10188',10164,0,1),(903,10153,'86',4,'10174_LAYOUT_86',10161,0,1),(901,10153,'86',4,'10174_LAYOUT_86',10162,0,15),(902,10153,'86',4,'10174_LAYOUT_86',10169,0,1),(6521,10153,'145',4,'18111_LAYOUT_145',10161,0,1),(454,10153,'87',4,'10611_LAYOUT_87',10161,0,1),(452,10153,'87',4,'10611_LAYOUT_87',10162,0,15),(453,10153,'87',4,'10611_LAYOUT_87',10169,0,1),(6520,10153,'145',4,'18111_LAYOUT_145',10169,0,1),(546,10153,'88',4,'10174_LAYOUT_88',10161,0,1),(544,10153,'88',4,'10174_LAYOUT_88',10162,0,15),(545,10153,'88',4,'10174_LAYOUT_88',10163,0,1),(255,10153,'9',1,'10153',10160,0,2),(77,10153,'9',2,'10188',10164,0,1),(11,10153,'90',1,'10153',10164,0,16384),(189,10153,'97',1,'10153',10163,0,2),(190,10153,'97',1,'10153',10164,0,2),(43,10153,'97',2,'10188',10164,0,1),(136,10153,'98',1,'10153',10163,0,4),(137,10153,'98',1,'10153',10164,0,4),(110,10153,'98',2,'10188',10163,0,2),(12,10153,'98',2,'10188',10164,0,1),(122,10153,'99',2,'10188',10163,0,2),(74,10153,'99',2,'10188',10164,0,1),(555,10153,'AperteWorkflowPluginManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowPluginManager_WAR_aperteworkflow',10161,0,1),(553,10153,'AperteWorkflowPluginManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowPluginManager_WAR_aperteworkflow',10162,0,31),(554,10153,'AperteWorkflowPluginManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowPluginManager_WAR_aperteworkflow',10163,0,1),(1249,10153,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',10161,0,1),(1247,10153,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',10162,0,31),(1248,10153,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',10169,0,1),(1246,10153,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',10161,0,1),(1244,10153,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',10162,0,31),(1245,10153,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',10169,0,1),(126,10153,'com.liferay.portal.model.Group',2,'10188',10163,0,4096),(107,10153,'com.liferay.portal.model.Layout',2,'10188',10164,0,1),(7,10153,'com.liferay.portal.model.Layout',4,'10174',10161,0,1),(5,10153,'com.liferay.portal.model.Layout',4,'10174',10162,10157,1023),(6,10153,'com.liferay.portal.model.Layout',4,'10174',10169,0,19),(317,10153,'com.liferay.portal.model.Layout',4,'10313',10162,10157,1023),(318,10153,'com.liferay.portal.model.Layout',4,'10313',10169,0,19),(331,10153,'com.liferay.portal.model.Layout',4,'10323',10162,10157,1023),(332,10153,'com.liferay.portal.model.Layout',4,'10323',10169,0,19),(346,10153,'com.liferay.portal.model.Layout',4,'10332',10162,10157,1023),(347,10153,'com.liferay.portal.model.Layout',4,'10332',10169,0,19),(364,10153,'com.liferay.portal.model.Layout',4,'10346',10161,0,1),(362,10153,'com.liferay.portal.model.Layout',4,'10346',10162,10157,1023),(363,10153,'com.liferay.portal.model.Layout',4,'10346',10169,0,19),(367,10153,'com.liferay.portal.model.Layout',4,'10352',10161,0,1),(365,10153,'com.liferay.portal.model.Layout',4,'10352',10162,10157,1023),(366,10153,'com.liferay.portal.model.Layout',4,'10352',10169,0,19),(370,10153,'com.liferay.portal.model.Layout',4,'10358',10161,0,1),(368,10153,'com.liferay.portal.model.Layout',4,'10358',10162,10157,1023),(369,10153,'com.liferay.portal.model.Layout',4,'10358',10169,0,19),(377,10153,'com.liferay.portal.model.Layout',4,'10372',10161,0,1),(375,10153,'com.liferay.portal.model.Layout',4,'10372',10162,10157,1023),(376,10153,'com.liferay.portal.model.Layout',4,'10372',10169,0,19),(380,10153,'com.liferay.portal.model.Layout',4,'10380',10161,0,1),(378,10153,'com.liferay.portal.model.Layout',4,'10380',10162,10157,1023),(379,10153,'com.liferay.portal.model.Layout',4,'10380',10169,0,19),(383,10153,'com.liferay.portal.model.Layout',4,'10386',10161,0,1),(381,10153,'com.liferay.portal.model.Layout',4,'10386',10162,10157,1023),(382,10153,'com.liferay.portal.model.Layout',4,'10386',10169,0,19),(386,10153,'com.liferay.portal.model.Layout',4,'10392',10161,0,1),(384,10153,'com.liferay.portal.model.Layout',4,'10392',10162,10157,1023),(385,10153,'com.liferay.portal.model.Layout',4,'10392',10169,0,19),(6702,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'18301',10164,0,3),(6546,10153,'145',4,'18101_LAYOUT_145',10162,0,15),(6545,10153,'103',4,'18101_LAYOUT_103',10161,0,1),(6544,10153,'103',4,'18101_LAYOUT_103',10169,0,1),(436,10153,'com.liferay.portal.model.Layout',4,'10611',10161,0,1),(434,10153,'com.liferay.portal.model.Layout',4,'10611',10162,10157,1023),(435,10153,'com.liferay.portal.model.Layout',4,'10611',10169,0,19),(1206,10153,'com.liferay.portal.model.Layout',4,'11502',10161,0,0),(1204,10153,'com.liferay.portal.model.Layout',4,'11502',10162,10195,1023),(1243,10153,'com.liferay.portal.model.Layout',4,'11502',10164,0,1),(1205,10153,'com.liferay.portal.model.Layout',4,'11502',10169,0,1),(6516,10153,'103',4,'18111_LAYOUT_103',10162,0,15),(6517,10153,'103',4,'18111_LAYOUT_103',10169,0,1),(6518,10153,'103',4,'18111_LAYOUT_103',10161,0,1),(6519,10153,'145',4,'18111_LAYOUT_145',10162,0,15),(1339,10153,'com.liferay.portal.model.Layout',4,'11779',10161,0,1),(1337,10153,'com.liferay.portal.model.Layout',4,'11779',10162,10157,1023),(1338,10153,'com.liferay.portal.model.Layout',4,'11779',10169,0,19),(2719,10153,'132',4,'10174_LAYOUT_132',10161,0,1),(2718,10153,'132',4,'10174_LAYOUT_132',10169,0,1),(2717,10153,'132',4,'10174_LAYOUT_132',10162,0,15),(1702,10153,'com.liferay.portal.model.Layout',4,'12111',10162,12102,1023),(1705,10153,'com.liferay.portal.model.Layout',4,'12116',10161,0,1),(1703,10153,'com.liferay.portal.model.Layout',4,'12116',10162,12102,1023),(1704,10153,'com.liferay.portal.model.Layout',4,'12116',10163,0,19),(316,10153,'com.liferay.portal.model.LayoutPrototype',4,'10309',10162,10157,15),(330,10153,'com.liferay.portal.model.LayoutPrototype',4,'10319',10162,10157,15),(345,10153,'com.liferay.portal.model.LayoutPrototype',4,'10328',10162,10157,15),(358,10153,'com.liferay.portal.model.LayoutSetPrototype',4,'10337',10162,10157,15),(371,10153,'com.liferay.portal.model.LayoutSetPrototype',4,'10363',10162,10157,15),(1310,10153,'com.liferay.portal.model.LayoutSetPrototype',4,'11604',10162,10157,15),(1004,10153,'com.liferay.portal.model.Role',4,'11302',10162,10195,127),(1238,10153,'com.liferay.portal.model.Role',4,'11524',10162,10195,127),(1701,10153,'com.liferay.portal.model.User',4,'12102',10162,10195,31),(127,10153,'com.liferay.portlet.asset',2,'10188',10163,0,30),(319,10153,'com.liferay.portlet.asset.model.AssetVocabulary',4,'10316',10162,10157,15),(128,10153,'com.liferay.portlet.blogs',2,'10188',10163,0,14),(108,10153,'com.liferay.portlet.blogs',2,'10188',10164,0,14),(323,10153,'com.liferay.portlet.blogs',4,'10310',10162,0,14),(129,10153,'com.liferay.portlet.bookmarks',2,'10188',10163,0,15),(1921,10153,'com.liferay.portlet.bookmarks',4,'10179',10161,0,1),(1919,10153,'com.liferay.portlet.bookmarks',4,'10179',10162,0,15),(1920,10153,'com.liferay.portlet.bookmarks',4,'10179',10169,0,3),(130,10153,'com.liferay.portlet.calendar',2,'10188',10163,0,14),(109,10153,'com.liferay.portlet.calendar',2,'10188',10164,0,14),(1915,10153,'com.liferay.portlet.calendar',4,'10179',10162,0,14),(6543,10153,'103',4,'18101_LAYOUT_103',10162,0,15),(6406,10153,'com.liferay.portlet.documentlibrary',4,'10191',10161,0,1),(131,10153,'com.liferay.portlet.documentlibrary',2,'10188',10163,0,511),(1406,10153,'com.liferay.portlet.documentlibrary',4,'10179',10161,0,1),(1404,10153,'com.liferay.portlet.documentlibrary',4,'10179',10162,0,511),(1405,10153,'com.liferay.portlet.documentlibrary',4,'10179',10169,0,75),(399,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10419',10161,0,3),(398,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10419',10162,10157,127),(401,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10433',10161,0,3),(400,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10433',10162,10157,127),(403,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10444',10161,0,3),(402,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10444',10162,10157,127),(405,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10452',10161,0,3),(404,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10452',10162,10157,127),(407,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10465',10161,0,3),(406,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10465',10162,10157,127),(409,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10477',10161,0,3),(408,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10477',10162,10157,127),(411,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10493',10161,0,3),(410,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10493',10162,10157,127),(413,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10505',10161,0,3),(412,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10505',10162,10157,127),(415,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10517',10161,0,3),(414,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10517',10162,10157,127),(417,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10530',10161,0,3),(416,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10530',10162,10157,127),(419,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10542',10161,0,3),(418,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10542',10162,10157,127),(421,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10553',10161,0,3),(420,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10553',10162,10157,127),(423,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10566',10161,0,3),(422,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'10566',10162,10157,127),(1314,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'11613',10162,10157,127),(1315,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'11621',10162,10157,127),(1316,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'11630',10162,10157,127),(1317,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'11638',10162,10157,127),(1318,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'11646',10162,10157,127),(1319,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'11658',10162,10157,127),(1320,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'11669',10162,10157,127),(308,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntryType',4,'10300',10162,10157,15),(310,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntryType',4,'10302',10162,10157,15),(312,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntryType',4,'10304',10162,10157,15),(314,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntryType',4,'10306',10162,10157,15),(1601,10153,'com.liferay.portlet.documentlibrary.model.DLFolder',4,'12001',10162,10195,255),(1602,10153,'com.liferay.portlet.documentlibrary.model.DLFolder',4,'12001',10169,0,29),(304,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10297',10162,10157,15),(305,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10298',10162,10157,15),(306,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10299',10162,10157,15),(307,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10301',10162,10157,15),(309,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10303',10162,10157,15),(311,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10305',10162,10157,15),(313,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10307',10162,10157,15),(315,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10308',10162,10157,15),(387,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10399',10162,10157,15),(388,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10400',10162,10157,15),(389,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10401',10162,10157,15),(390,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10402',10162,10157,15),(391,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10403',10162,10157,15),(392,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',4,'10404',10162,10157,15),(393,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'10412',10162,0,15),(1413,10153,'com.liferay.portlet.journal',4,'10179',10162,0,126),(425,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'10582',10161,0,3),(424,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'10582',10162,10157,255),(431,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'10596',10161,0,3),(430,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'10596',10162,10157,255),(433,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'10604',10161,0,3),(432,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'10604',10162,10157,255),(1323,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11703',10162,10157,255),(1326,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11717',10162,10157,255),(1327,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11725',10162,10157,255),(1328,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11733',10162,10157,255),(1330,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11744',10162,10157,255),(1332,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11755',10162,10157,255),(1336,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11772',10162,10157,255),(1416,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11805',10161,0,3),(1414,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11805',10162,10195,255),(1415,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'11805',10169,0,3),(427,10153,'com.liferay.portlet.journal.model.JournalStructure',4,'10591',10161,0,1),(426,10153,'com.liferay.portlet.journal.model.JournalStructure',4,'10591',10162,10157,15),(1321,10153,'com.liferay.portlet.journal.model.JournalStructure',4,'11682',10162,10157,15),(1324,10153,'com.liferay.portlet.journal.model.JournalStructure',4,'11712',10162,10157,15),(1333,10153,'com.liferay.portlet.journal.model.JournalStructure',4,'11765',10162,10157,15),(1334,10153,'com.liferay.portlet.journal.model.JournalStructure',4,'11767',10162,10157,15),(429,10153,'com.liferay.portlet.journal.model.JournalTemplate',4,'10593',10161,0,1),(428,10153,'com.liferay.portlet.journal.model.JournalTemplate',4,'10593',10162,10157,15),(1322,10153,'com.liferay.portlet.journal.model.JournalTemplate',4,'11688',10162,10157,15),(1325,10153,'com.liferay.portlet.journal.model.JournalTemplate',4,'11714',10162,10157,15),(1329,10153,'com.liferay.portlet.journal.model.JournalTemplate',4,'11741',10162,10157,15),(1331,10153,'com.liferay.portlet.journal.model.JournalTemplate',4,'11752',10162,10157,15),(1335,10153,'com.liferay.portlet.journal.model.JournalTemplate',4,'11769',10162,10157,15),(132,10153,'com.liferay.portlet.messageboards',2,'10188',10163,0,2047),(1533,10153,'com.liferay.portlet.messageboards',4,'10179',10161,0,1),(1531,10153,'com.liferay.portlet.messageboards',4,'10179',10162,0,2047),(1532,10153,'com.liferay.portlet.messageboards',4,'10179',10169,0,781),(133,10153,'com.liferay.portlet.polls',2,'10188',10163,0,6),(1911,10153,'com.liferay.portlet.polls',4,'10179',10162,0,6),(134,10153,'com.liferay.portlet.wiki',2,'10188',10163,0,6),(351,10153,'com.liferay.portlet.wiki',4,'10329',10162,0,6),(2306,10153,'15',4,'10174_LAYOUT_15',10162,0,31),(2307,10153,'15',4,'10174_LAYOUT_15',10169,0,1),(2308,10153,'15',4,'10174_LAYOUT_15',10161,0,1),(2309,10153,'com.liferay.portal.model.Role',4,'10160',10162,0,127),(2502,10153,'103',4,'12116_LAYOUT_103',10162,0,15),(2503,10153,'103',4,'12116_LAYOUT_103',10163,0,1),(2504,10153,'103',4,'12116_LAYOUT_103',10161,0,1),(2505,10153,'33',4,'12116_LAYOUT_33',10162,0,15),(2506,10153,'33',4,'12116_LAYOUT_33',10163,0,1),(2507,10153,'33',4,'12116_LAYOUT_33',10161,0,1),(2508,10153,'com.liferay.portlet.blogs',4,'12104',10162,0,14),(2509,10153,'82',4,'12116_LAYOUT_82',10162,0,15),(2510,10153,'82',4,'12116_LAYOUT_82',10163,0,1),(2511,10153,'82',4,'12116_LAYOUT_82',10161,0,1),(2512,10153,'3',4,'12116_LAYOUT_3',10162,0,15),(2513,10153,'3',4,'12116_LAYOUT_3',10163,0,1),(2514,10153,'3',4,'12116_LAYOUT_3',10161,0,1),(2515,10153,'145',4,'12116_LAYOUT_145',10162,0,15),(2516,10153,'145',4,'12116_LAYOUT_145',10163,0,1),(2517,10153,'145',4,'12116_LAYOUT_145',10161,0,1),(2518,10153,'AperteWorkflowPluginManager_WAR_aperteworkflow',1,'10153',11524,0,0),(2519,10153,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',1,'10153',11524,0,0),(2520,10153,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',1,'10153',11524,0,0),(2521,10153,'ProcessToolActivities_WAR_aperteworkflow',1,'10153',11524,0,0),(2522,10153,'ProcessToolDictionaries_WAR_aperteworkflow',1,'10153',11524,0,0),(2523,10153,'ProcessToolQueues_WAR_aperteworkflow',1,'10153',11524,0,0),(2524,10153,'ProcessToolTasks_WAR_aperteworkflow',1,'10153',11524,0,0),(2526,10153,'140',4,'10174_LAYOUT_140',10162,0,15),(2527,10153,'154',4,'10174_LAYOUT_154',10162,0,15),(2601,10153,'com.liferay.portal.model.Role',4,'13101',10162,12102,127),(2607,10153,'86',4,'10611_LAYOUT_86',10162,0,15),(2608,10153,'86',4,'10611_LAYOUT_86',10169,0,1),(2606,10153,'com.liferay.portlet.announcements.model.AnnouncementsEntry',4,'13105',10162,12102,15),(2609,10153,'86',4,'10611_LAYOUT_86',10161,0,1),(2613,10153,'com.liferay.portlet.announcements.model.AnnouncementsEntry',4,'13109',10162,12102,15),(2614,10153,'113',4,'10611_LAYOUT_113',10162,0,15),(2615,10153,'113',4,'10611_LAYOUT_113',10169,0,1),(2616,10153,'113',4,'10611_LAYOUT_113',10161,0,1),(2617,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13119',10162,12102,127),(2618,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13119',10164,0,3),(2619,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13119',10161,0,3),(2620,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13136',10162,12102,127),(2621,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13136',10164,0,3),(2622,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13136',10161,0,3),(2640,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13187',10164,0,3),(2639,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13187',10162,12102,127),(2626,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13152',10162,12102,127),(2627,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13152',10164,0,3),(2628,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13152',10161,0,3),(2629,10153,'com.liferay.portlet.announcements.model.AnnouncementsEntry',4,'13165',10162,12102,15),(2636,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'13172',10162,12102,255),(2637,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'13172',10169,0,3),(2638,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'13172',10161,0,3),(2641,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13187',10161,0,3),(2643,10153,'56',4,'10611_LAYOUT_56_INSTANCE_TO4ossIXPkhm',10162,0,15),(2644,10153,'56',4,'10611_LAYOUT_56_INSTANCE_TO4ossIXPkhm',10169,0,1),(2645,10153,'56',4,'10611_LAYOUT_56_INSTANCE_TO4ossIXPkhm',10161,0,1),(2653,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13276',10162,12102,127),(2654,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13276',10164,0,3),(2655,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13276',10161,0,3),(6404,10153,'com.liferay.portlet.documentlibrary',4,'10191',10162,0,511),(6401,10153,'20',4,'10174_LAYOUT_20',10162,0,31),(6402,10153,'20',4,'10174_LAYOUT_20',10169,0,1),(6403,10153,'20',4,'10174_LAYOUT_20',10161,0,1),(2660,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'13310',10162,12102,255),(2661,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'13310',10169,0,3),(2662,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'13310',10161,0,3),(2666,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13347',10162,12102,127),(2667,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13347',10164,0,3),(2668,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'13347',10161,0,3),(2901,10153,'58',4,'10611_LAYOUT_58',10162,0,15),(2902,10153,'58',4,'10611_LAYOUT_58',10169,0,1),(2903,10153,'58',4,'10611_LAYOUT_58',10161,0,1),(3001,10153,'146',4,'10174_LAYOUT_146',10162,0,15),(3002,10153,'146',4,'10174_LAYOUT_146',10169,0,1),(3003,10153,'146',4,'10174_LAYOUT_146',10161,0,1),(3101,10153,'AperteWorkflowAdminPortlet_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowAdminPortlet_WAR_aperteworkflow',10162,0,31),(3102,10153,'AperteWorkflowAdminPortlet_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowAdminPortlet_WAR_aperteworkflow',10169,0,1),(3103,10153,'AperteWorkflowAdminPortlet_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowAdminPortlet_WAR_aperteworkflow',10161,0,1),(3104,10153,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowUserSubstitutions_WAR_aperteworkflow',10162,0,31),(3105,10153,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowUserSubstitutions_WAR_aperteworkflow',10169,0,1),(3106,10153,'AperteWorkflowUserSubstitutions_WAR_aperteworkflow',4,'10174_LAYOUT_AperteWorkflowUserSubstitutions_WAR_aperteworkflow',10161,0,1),(3301,10153,'com.liferay.portal.model.Layout',4,'14101',10162,12102,1023),(3302,10153,'com.liferay.portal.model.Layout',4,'14101',10169,0,0),(3303,10153,'com.liferay.portal.model.Layout',4,'14101',10161,0,0),(3304,10153,'103',4,'14101_LAYOUT_103',10162,0,15),(3305,10153,'103',4,'14101_LAYOUT_103',10169,0,1),(3306,10153,'103',4,'14101_LAYOUT_103',10161,0,1),(3307,10153,'145',4,'14101_LAYOUT_145',10162,0,15),(3308,10153,'145',4,'14101_LAYOUT_145',10169,0,1),(3309,10153,'145',4,'14101_LAYOUT_145',10161,0,1),(3310,10153,'87',4,'14101_LAYOUT_87',10162,0,15),(3311,10153,'87',4,'14101_LAYOUT_87',10169,0,1),(3312,10153,'87',4,'14101_LAYOUT_87',10161,0,1),(3313,10153,'48',4,'14101_LAYOUT_48_INSTANCE_57K85xxkzz0p',10162,0,15),(3314,10153,'48',4,'14101_LAYOUT_48_INSTANCE_57K85xxkzz0p',10169,0,1),(3315,10153,'48',4,'14101_LAYOUT_48_INSTANCE_57K85xxkzz0p',10161,0,1),(3316,10153,'86',4,'14101_LAYOUT_86',10162,0,15),(3317,10153,'86',4,'14101_LAYOUT_86',10169,0,1),(3318,10153,'86',4,'14101_LAYOUT_86',10161,0,1),(3319,10153,'113',4,'14101_LAYOUT_113',10162,0,15),(3320,10153,'113',4,'14101_LAYOUT_113',10169,0,1),(3321,10153,'113',4,'14101_LAYOUT_113',10161,0,1),(3403,10153,'com.liferay.portlet.asset.model.AssetTag',4,'14213',10162,12102,15),(3404,10153,'com.liferay.portlet.asset.model.AssetTag',4,'14213',10164,0,1),(3405,10153,'com.liferay.portlet.asset.model.AssetTag',4,'14213',10161,0,1),(3408,10153,'com.liferay.portlet.asset.model.AssetTag',4,'14226',10162,12102,15),(3409,10153,'com.liferay.portlet.asset.model.AssetTag',4,'14226',10164,0,1),(3410,10153,'com.liferay.portlet.asset.model.AssetTag',4,'14226',10161,0,1),(3413,10153,'com.liferay.portlet.asset.model.AssetVocabulary',4,'14236',10162,10157,15),(3452,10153,'129',4,'10174_LAYOUT_129',10162,0,15),(3453,10153,'129',4,'10174_LAYOUT_129',10169,0,1),(3454,10153,'129',4,'10174_LAYOUT_129',10161,0,1),(3459,10153,'com.liferay.portal.model.Role',4,'14610',10162,12102,127),(3462,10153,'com.liferay.portal.model.Role',4,'14613',10162,12102,127),(3463,10153,'90',1,'10153',14610,0,131071),(3464,10153,'com.liferay.portal.model.PasswordPolicy',1,'10153',14610,0,31),(3465,10153,'com.liferay.portal.model.Role',1,'10153',14610,0,127),(3466,10153,'com.liferay.portal.model.Layout',1,'10153',14610,0,707),(3467,10153,'com.liferay.portal.model.LayoutBranch',1,'10153',14610,0,4),(3468,10153,'com.liferay.portal.model.LayoutSetBranch',1,'10153',14610,0,8),(3469,10153,'com.liferay.portal.model.Team',1,'10153',14610,0,31),(3470,10153,'com.liferay.portal.model.Group',1,'10153',14610,0,49),(3471,10153,'com.liferay.portal.model.User',1,'10153',14610,0,31),(3472,10153,'com.liferay.portal.model.UserGroup',1,'10153',14610,0,63),(3473,10153,'com.liferay.portal.model.Organization',1,'10153',14610,0,511),(3474,10153,'com.liferay.portlet.announcements.model.AnnouncementsEntry',1,'10153',14610,0,15),(3475,10153,'com.liferay.portlet.blogs',1,'10153',14610,0,14),(3476,10153,'com.liferay.portlet.blogs.model.BlogsEntry',1,'10153',14610,0,127),(3477,10153,'com.liferay.portlet.bookmarks',1,'10153',14610,0,15),(3478,10153,'com.liferay.portlet.calendar',1,'10153',14610,0,14),(3479,10153,'com.liferay.portlet.calendar.model.CalEvent',1,'10153',14610,0,127),(3480,10153,'com.liferay.portlet.asset',1,'10153',14610,0,30),(3481,10153,'com.liferay.portlet.asset.model.AssetCategory',1,'10153',14610,0,31),(3482,10153,'com.liferay.portlet.asset.model.AssetVocabulary',1,'10153',14610,0,15),(3483,10153,'com.liferay.portlet.expando.model.ExpandoColumn',1,'10153',14610,0,15),(3484,10153,'com.liferay.portlet.documentlibrary.model.DLFolder',1,'10153',14610,0,255),(3485,10153,'com.liferay.portlet.documentlibrary',1,'10153',14610,0,511),(3486,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',1,'10153',14610,0,127),(3487,10153,'com.liferay.portlet.documentlibrary.model.DLFileShortcut',1,'10153',14610,0,127),(3488,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntryType',1,'10153',14610,0,15),(3489,10153,'com.liferay.portlet.dynamicdatalists',1,'10153',14610,0,30),(3490,10153,'com.liferay.portlet.dynamicdatalists.model.DDLRecordSet',1,'10153',14610,0,31),(3491,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMTemplate',1,'10153',14610,0,15),(3492,10153,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure',1,'10153',14610,0,15),(3493,10153,'com.liferay.portlet.messageboards.model.MBCategory',1,'10153',14610,0,4095),(3494,10153,'com.liferay.portlet.messageboards',1,'10153',14610,0,2047),(3495,10153,'com.liferay.portlet.messageboards.model.MBMessage',1,'10153',14610,0,31),(3496,10153,'com.liferay.portlet.messageboards.model.MBThread',1,'10153',14610,0,6),(3497,10153,'com.liferay.portlet.mobiledevicerules',1,'10153',14610,0,31),(3498,10153,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroup',1,'10153',14610,0,15),(3499,10153,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroupInstance',1,'10153',14610,0,15),(3500,10153,'com.liferay.portal.model.LayoutPrototype',1,'10153',14610,0,15),(3501,10153,'com.liferay.portlet.polls',1,'10153',14610,0,6),(3502,10153,'com.liferay.portlet.polls.model.PollsQuestion',1,'10153',14610,0,31),(3503,10153,'com.liferay.portlet.shopping',1,'10153',14610,0,63),(3504,10153,'com.liferay.portlet.shopping.model.ShoppingCategory',1,'10153',14610,0,63),(3505,10153,'com.liferay.portlet.shopping.model.ShoppingOrder',1,'10153',14610,0,15),(3506,10153,'com.liferay.portlet.shopping.model.ShoppingItem',1,'10153',14610,0,15),(3507,10153,'com.liferay.portal.model.LayoutSetPrototype',1,'10153',14610,0,15),(3508,10153,'com.liferay.portlet.softwarecatalog',1,'10153',14610,0,14),(3509,10153,'com.liferay.portlet.softwarecatalog.model.SCFrameworkVersion',1,'10153',14610,0,14),(3510,10153,'com.liferay.portlet.softwarecatalog.model.SCLicense',1,'10153',14610,0,15),(3511,10153,'com.liferay.portlet.softwarecatalog.model.SCProductEntry',1,'10153',14610,0,127),(3512,10153,'com.liferay.portlet.asset.model.AssetTag',1,'10153',14610,0,15),(3513,10153,'com.liferay.portlet.journal',1,'10153',14610,0,126),(3514,10153,'com.liferay.portlet.journal.model.JournalArticle',1,'10153',14610,0,255),(3515,10153,'com.liferay.portlet.journal.model.JournalFeed',1,'10153',14610,0,15),(3516,10153,'com.liferay.portlet.journal.model.JournalStructure',1,'10153',14610,0,15),(3517,10153,'com.liferay.portlet.journal.model.JournalTemplate',1,'10153',14610,0,15),(3518,10153,'com.liferay.portlet.wiki',1,'10153',14610,0,6),(3519,10153,'com.liferay.portlet.wiki.model.WikiNode',1,'10153',14610,0,255),(3520,10153,'com.liferay.portlet.wiki.model.WikiPage',1,'10153',14610,0,255),(3521,10153,'116',1,'10153',14610,0,15),(3522,10153,'83',1,'10153',14610,0,31),(3523,10153,'67',1,'10153',14610,0,15),(3524,10153,'84',1,'10153',14610,0,31),(3525,10153,'ProcessToolActivities_WAR_aperteworkflow',1,'10153',14610,0,15),(3526,10153,'ProcessToolDictionaries_WAR_aperteworkflow',1,'10153',14610,0,15),(3527,10153,'ProcessToolQueues_WAR_aperteworkflow',1,'10153',14610,0,15),(3528,10153,'ProcessToolTasks_WAR_aperteworkflow',1,'10153',14610,0,0),(3529,10153,'ProcessToolUserSubstitutions_WAR_aperteworkflow',1,'10153',14610,0,15),(3530,10153,'101',1,'10153',14610,0,0),(3531,10153,'33',1,'10153',14610,0,15),(3532,10153,'115',1,'10153',14610,0,15),(3533,10153,'28',1,'10153',14610,0,31),(3534,10153,'8',1,'10153',14610,0,31),(3535,10153,'147',1,'10153',14610,0,15),(3536,10153,'20',1,'10153',14610,0,31),(3537,10153,'167',1,'10153',14610,0,31),(3538,10153,'162',1,'10153',14610,0,15),(3539,10153,'178',1,'10153',14610,0,31),(3540,10153,'25',1,'10153',14610,0,15),(3541,10153,'173',1,'10153',14610,0,31),(3542,10153,'174',1,'10153',14610,0,31),(3543,10153,'156',1,'10153',14610,0,31),(3544,10153,'165',1,'10153',14610,0,31),(3545,10153,'179',1,'10153',14610,0,31),(3546,10153,'98',1,'10153',14610,0,31),(3547,10153,'99',1,'10153',14610,0,15),(3548,10153,'15',1,'10153',14610,0,31),(3549,10153,'154',1,'10153',14610,0,15),(3550,10153,'152',1,'10153',14610,0,15),(3551,10153,'AperteWorkflowPluginManager_WAR_aperteworkflow',1,'10153',14610,0,31),(3552,10153,'AperteWorkflowProcessDefinitionManager_WAR_aperteworkflow',1,'10153',14610,0,31),(3553,10153,'AperteWorkflowProcessInstanceManager_WAR_aperteworkflow',1,'10153',14610,0,31),(3554,10153,'139',1,'10153',14610,0,31),(3555,10153,'177',1,'10153',14610,0,31),(3556,10153,'131',1,'10153',14610,0,15),(3557,10153,'146',1,'10153',14610,0,15),(3558,10153,'129',1,'10153',14610,0,15),(3559,10153,'132',1,'10153',14610,0,15),(3560,10153,'130',1,'10153',14610,0,15),(3561,10153,'128',1,'10153',14610,0,15),(3562,10153,'149',1,'10153',14610,0,15),(3563,10153,'134',1,'10153',14610,0,15),(3564,10153,'127',1,'10153',14610,0,31),(3565,10153,'125',1,'10153',14610,0,31),(3566,10153,'151',1,'10153',14610,0,15),(3701,10153,'90',1,'10153',14613,0,0),(3702,10153,'com.liferay.portal.model.Layout',1,'10153',14613,0,0),(3703,10153,'com.liferay.portal.model.Team',1,'10153',14613,0,0),(3704,10153,'com.liferay.portal.model.Group',1,'10153',14613,0,0),(3705,10153,'ProcessToolQueues_WAR_aperteworkflow',1,'10153',14613,0,0),(3706,10153,'ProcessToolActivities_WAR_aperteworkflow',1,'10153',14613,0,0),(3707,10153,'ProcessToolDictionaries_WAR_aperteworkflow',1,'10153',14613,0,0),(3708,10153,'ProcessToolTasks_WAR_aperteworkflow',1,'10153',14613,0,0),(3709,10153,'2',1,'10153',14613,0,13),(3710,10153,'140',1,'10153',14613,0,13),(3711,10153,'158',1,'10153',14613,0,0),(3712,10153,'153',1,'10153',14613,0,0),(4001,10153,'2_WAR_opensocialportlet',1,'10153',10160,0,2),(4002,10153,'2_WAR_opensocialportlet',1,'10153',10161,0,2),(4003,10153,'2_WAR_opensocialportlet',1,'10153',10163,0,2),(4004,10153,'2_WAR_opensocialportlet',1,'10153',10164,0,2),(4005,10153,'3_WAR_opensocialportlet',1,'10153',10160,0,2),(4006,10153,'3_WAR_opensocialportlet',1,'10153',10161,0,2),(4007,10153,'3_WAR_opensocialportlet',1,'10153',10163,0,2),(4008,10153,'3_WAR_opensocialportlet',1,'10153',10164,0,2),(4009,10153,'1_WAR_opensocialportlet',4,'10174_LAYOUT_1_WAR_opensocialportlet',10162,0,15),(4010,10153,'1_WAR_opensocialportlet',4,'10174_LAYOUT_1_WAR_opensocialportlet',10169,0,1),(4011,10153,'com.liferay.opensocial',4,'10179',10162,0,6),(4012,10153,'com.liferay.opensocial',4,'10179',10169,0,4),(4013,10153,'103',4,'12111_LAYOUT_103',10162,0,15),(4014,10153,'103',4,'12111_LAYOUT_103',10163,0,1),(4015,10153,'103',4,'12111_LAYOUT_103',10161,0,1),(4056,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',1,'10153',10160,0,2),(4057,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',1,'10153',10161,0,2),(4058,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',1,'10153',10163,0,2),(4039,10153,'87',4,'12111_LAYOUT_87',10161,0,1),(4037,10153,'87',4,'12111_LAYOUT_87',10162,0,15),(4038,10153,'87',4,'12111_LAYOUT_87',10163,0,1),(4026,10153,'com.liferay.portlet.calendar',4,'12104',10162,0,14),(4055,10153,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965',1,'10153',10164,0,2),(4030,10153,'145',4,'12111_LAYOUT_145',10162,0,15),(4031,10153,'145',4,'12111_LAYOUT_145',10163,0,1),(4032,10153,'145',4,'12111_LAYOUT_145',10161,0,1),(4033,10153,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf',1,'10153',10160,0,2),(4034,10153,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf',1,'10153',10161,0,2),(4035,10153,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf',1,'10153',10163,0,2),(4036,10153,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf',1,'10153',10164,0,2),(4043,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15023',10162,0,15),(4044,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15023',10164,0,9),(4054,10153,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965',1,'10153',10163,0,2),(4050,10153,'com.liferay.opensocial',4,'12104',10162,0,6),(4051,10153,'com.liferay.opensocial',4,'12104',10163,0,4),(4052,10153,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965',1,'10153',10160,0,2),(4053,10153,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965',1,'10153',10161,0,2),(4048,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15025',10162,0,15),(4049,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15025',10164,0,9),(4059,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',1,'10153',10164,0,2),(4909,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',4,'12111_LAYOUT_OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',10163,0,1),(4910,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',4,'12111_LAYOUT_OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',10161,0,1),(4063,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15031',10162,0,15),(4064,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15031',10164,0,9),(4883,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',4,'12111_LAYOUT_OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',10161,0,1),(4068,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15033',10162,0,15),(4069,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15033',10164,0,9),(4259,10153,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1',1,'10153',10160,0,2),(4260,10153,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1',1,'10153',10161,0,2),(4261,10153,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1',1,'10153',10163,0,2),(4262,10153,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1',1,'10153',10164,0,2),(4073,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15035',10162,0,15),(4074,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15035',10164,0,9),(4078,10153,'113',4,'12111_LAYOUT_113',10162,0,15),(4079,10153,'113',4,'12111_LAYOUT_113',10163,0,1),(4080,10153,'113',4,'12111_LAYOUT_113',10161,0,1),(4094,10153,'49',4,'12111_LAYOUT_49',10161,0,1),(4092,10153,'49',4,'12111_LAYOUT_49',10162,0,15),(4093,10153,'49',4,'12111_LAYOUT_49',10163,0,1),(4091,10153,'com.liferay.portal.model.Role',4,'15043',10162,12102,127),(4084,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15040',10162,0,15),(4085,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15040',10164,0,9),(4089,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15042',10162,0,15),(4090,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15042',10164,0,9),(4131,10153,'86',4,'12111_LAYOUT_86',10162,0,15),(4132,10153,'86',4,'12111_LAYOUT_86',10163,0,1),(4133,10153,'86',4,'12111_LAYOUT_86',10161,0,1),(4137,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15088',10162,0,15),(4138,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15088',10164,0,9),(4142,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15090',10162,0,15),(4143,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15090',10164,0,9),(4147,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15092',10162,0,15),(4148,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15092',10164,0,9),(4156,10153,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153',1,'10153',10160,0,2),(4157,10153,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153',1,'10153',10161,0,2),(4158,10153,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153',1,'10153',10163,0,2),(4159,10153,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153',1,'10153',10164,0,2),(4232,10153,'4_WAR_opensocialportlet',4,'10174_LAYOUT_4_WAR_opensocialportlet',10162,0,15),(4233,10153,'4_WAR_opensocialportlet',4,'10174_LAYOUT_4_WAR_opensocialportlet',10163,0,1),(4234,10153,'4_WAR_opensocialportlet',4,'10174_LAYOUT_4_WAR_opensocialportlet',10161,0,1),(4235,10153,'com.liferay.portlet.documentlibrary.model.DLFolder',4,'15217',10162,12102,255),(4236,10153,'com.liferay.portlet.documentlibrary.model.DLFolder',4,'15217',10163,0,29),(4237,10153,'com.liferay.portlet.documentlibrary.model.DLFolder',4,'15217',10161,0,1),(4244,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15222',10162,12102,255),(4245,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15222',10169,0,3),(4246,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15222',10161,0,3),(4247,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15232',10162,12102,255),(4248,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15232',10169,0,3),(4249,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15232',10161,0,3),(4250,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15242',10162,12102,255),(4251,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15242',10169,0,3),(4252,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15242',10161,0,3),(4253,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15252',10162,12102,255),(4254,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15252',10169,0,3),(4255,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15252',10161,0,3),(4271,10153,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc',1,'10153',10164,0,2),(4268,10153,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc',1,'10153',10160,0,2),(4269,10153,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc',1,'10153',10161,0,2),(4270,10153,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc',1,'10153',10163,0,2),(4266,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15264',10162,0,15),(4267,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15264',10164,0,9),(4528,10153,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552',1,'10153',10160,0,2),(4284,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15273',10162,0,15),(4275,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15268',10162,0,15),(4276,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15268',10164,0,9),(4277,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',1,'10153',10160,0,2),(4278,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',1,'10153',10161,0,2),(4279,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',1,'10153',10163,0,2),(4280,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',1,'10153',10164,0,2),(4285,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15273',10164,0,9),(6501,10153,'com.liferay.portal.model.Layout',4,'18101',10162,12102,1023),(6502,10153,'com.liferay.portal.model.Layout',4,'18101',10169,0,19),(6503,10153,'com.liferay.portal.model.Layout',4,'18101',10161,0,0),(6504,10153,'com.liferay.portal.model.Layout',4,'18106',10162,12102,1023),(6513,10153,'145',4,'18106_LAYOUT_145',10162,0,15),(6512,10153,'103',4,'18106_LAYOUT_103',10161,0,1),(6511,10153,'103',4,'18106_LAYOUT_103',10169,0,1),(6508,10153,'com.liferay.portal.model.Layout',4,'18111',10169,0,19),(5359,10153,'103',4,'16482_LAYOUT_103',10161,0,1),(5358,10153,'103',4,'16482_LAYOUT_103',10169,0,1),(5357,10153,'103',4,'16482_LAYOUT_103',10162,0,15),(6510,10153,'103',4,'18106_LAYOUT_103',10162,0,15),(6509,10153,'com.liferay.portal.model.Layout',4,'18111',10161,0,0),(6601,10153,'87',4,'18101_LAYOUT_87',10162,0,15),(6515,10153,'145',4,'18106_LAYOUT_145',10161,0,1),(6514,10153,'145',4,'18106_LAYOUT_145',10169,0,1),(4328,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'15298',10162,12102,127),(4329,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'15298',10164,0,3),(4330,10153,'com.liferay.portlet.documentlibrary.model.DLFileEntry',4,'15298',10161,0,3),(4331,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15313',10162,12102,255),(4332,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15313',10169,0,3),(4333,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15313',10161,0,3),(4334,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15323',10162,12102,255),(4335,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15323',10169,0,3),(4336,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15323',10161,0,3),(4337,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15333',10162,12102,255),(4338,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15333',10169,0,3),(4339,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15333',10161,0,3),(4340,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15343',10162,12102,255),(4341,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15343',10169,0,3),(4342,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15343',10161,0,3),(4343,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15353',10162,12102,255),(4344,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15353',10169,0,3),(4345,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15353',10161,0,3),(4346,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15363',10162,12102,255),(4347,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15363',10169,0,3),(4348,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15363',10161,0,3),(4355,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15375',10162,12102,255),(4356,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15375',10169,0,3),(4357,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15375',10161,0,3),(4358,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15385',10162,12102,255),(4359,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15385',10169,0,3),(4360,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15385',10161,0,3),(4364,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15400',10162,12102,255),(4365,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15400',10169,0,3),(4366,10153,'com.liferay.portlet.journal.model.JournalArticle',4,'15400',10161,0,3),(4401,10153,'49',4,'14101_LAYOUT_49',10162,0,15),(4402,10153,'49',4,'14101_LAYOUT_49',10169,0,1),(4403,10153,'49',4,'14101_LAYOUT_49',10161,0,1),(4529,10153,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552',1,'10153',10161,0,2),(4530,10153,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552',1,'10153',10163,0,2),(4531,10153,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552',1,'10153',10164,0,2),(4601,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',1,'10153',10160,0,2),(4568,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15636',10162,0,15),(4604,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',1,'10153',10164,0,2),(4603,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',1,'10153',10163,0,2),(4602,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',1,'10153',10161,0,2),(4535,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15624',10162,0,15),(4536,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15624',10164,0,9),(4882,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',4,'12111_LAYOUT_OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',10163,0,1),(4881,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',4,'12111_LAYOUT_OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',10162,0,15),(4558,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15632',10162,0,15),(4559,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15632',10164,0,9),(4563,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15634',10162,0,15),(4564,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15634',10164,0,9),(4569,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15636',10164,0,9),(4608,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15704',10162,0,15),(4609,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15704',10164,0,9),(4613,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15706',10162,0,15),(4614,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15706',10164,0,9),(4618,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15709',10162,0,15),(4619,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15709',10164,0,9),(4626,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15712',10162,0,15),(4627,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'15712',10164,0,9),(4701,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',1,'10153',10160,0,2),(4702,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',1,'10153',10161,0,2),(4703,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',1,'10153',10163,0,2),(4704,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',1,'10153',10164,0,2),(4705,10153,'com.liferay.portlet.asset.model.AssetVocabulary',4,'15803',10162,10157,15),(4908,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',4,'12111_LAYOUT_OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0',10162,0,15),(4923,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16049',10164,0,9),(4922,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16049',10162,0,15),(4871,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16032',10162,0,15),(4872,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16032',10164,0,9),(4873,10153,'com.liferay.opensocial.model.Gadget',4,'15105',10162,0,15),(4874,10153,'com.liferay.opensocial.model.Gadget',4,'15105',10163,0,1),(4875,10153,'com.liferay.opensocial.model.Gadget',4,'15105',10161,0,1),(4876,10153,'com.liferay.opensocial.model.Gadget',4,'15105',14610,0,1),(4877,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',1,'10153',10160,0,2),(4878,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',1,'10153',10161,0,2),(4879,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',1,'10153',10163,0,2),(4880,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021',1,'10153',10164,0,2),(4884,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16036',10162,0,15),(4885,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16036',10164,0,9),(4886,10153,'87',4,'12116_LAYOUT_87',10162,0,15),(4887,10153,'87',4,'12116_LAYOUT_87',10163,0,1),(4888,10153,'87',4,'12116_LAYOUT_87',10161,0,1),(4897,10153,'com.liferay.opensocial.model.Gadget',4,'16033',14610,0,9),(4894,10153,'com.liferay.opensocial.model.Gadget',4,'16033',10162,0,15),(4895,10153,'com.liferay.opensocial.model.Gadget',4,'16033',10169,0,1),(4896,10153,'com.liferay.opensocial.model.Gadget',4,'16033',10161,0,1),(4892,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16039',10162,0,15),(4893,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16039',10164,0,9),(4911,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',4,'12111_LAYOUT_OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',10162,0,15),(4912,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',4,'12111_LAYOUT_OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',10163,0,1),(4901,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16041',10162,0,15),(4902,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16041',10164,0,9),(4906,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16043',10162,0,15),(4907,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16043',10164,0,9),(4913,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',4,'12111_LAYOUT_OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6',10161,0,1),(4914,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',4,'12111_LAYOUT_OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',10162,0,15),(4915,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',4,'12111_LAYOUT_OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',10163,0,1),(4916,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',4,'12111_LAYOUT_OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95',10161,0,1),(4917,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16047',10162,0,15),(4918,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16047',10164,0,9),(4927,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16051',10162,0,15),(4928,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16051',10164,0,9),(4932,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16053',10162,0,15),(4933,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16053',10164,0,9),(4937,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16055',10162,0,15),(4938,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16055',10164,0,9),(4939,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',4,'12111_LAYOUT_OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',10162,0,15),(4940,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',4,'12111_LAYOUT_OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',10163,0,1),(4941,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',4,'12111_LAYOUT_OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688',10161,0,1),(4951,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16061',10162,0,15),(4952,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16061',10164,0,9),(4979,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16072',10162,0,15),(4980,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16072',10164,0,9),(4984,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16074',10162,0,15),(4985,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16074',10164,0,9),(4989,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16076',10162,0,15),(4990,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16076',10164,0,9),(4994,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16078',10162,0,15),(4995,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16078',10164,0,9),(4999,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16080',10162,0,15),(5000,10153,'com.liferay.portlet.expando.model.ExpandoColumn',4,'16080',10164,0,9),(5360,10153,'145',4,'16482_LAYOUT_145',10162,0,15),(5361,10153,'145',4,'16482_LAYOUT_145',10169,0,1),(5362,10153,'145',4,'16482_LAYOUT_145',10161,0,1),(5220,10153,'com.liferay.portal.model.User',4,'16308',10162,12102,31),(5221,10153,'com.liferay.portal.model.Layout',4,'16317',10162,16308,1023),(5222,10153,'com.liferay.portal.model.Layout',4,'16322',10162,16308,1023),(5223,10153,'com.liferay.portal.model.Layout',4,'16322',10163,0,19),(5224,10153,'com.liferay.portal.model.Layout',4,'16322',10161,0,1),(5304,10153,'com.liferay.portal.model.User',4,'16402',10162,12102,31),(5305,10153,'com.liferay.portal.model.Layout',4,'16411',10162,16402,1023),(5306,10153,'com.liferay.portal.model.Layout',4,'16416',10162,16402,1023),(5307,10153,'com.liferay.portal.model.Layout',4,'16416',10163,0,19),(5308,10153,'com.liferay.portal.model.Layout',4,'16416',10161,0,1),(5309,10153,'com.liferay.portal.model.User',4,'16422',10162,12102,31),(5310,10153,'com.liferay.portal.model.Layout',4,'16431',10162,16422,1023),(5311,10153,'com.liferay.portal.model.Layout',4,'16436',10162,16422,1023),(5312,10153,'com.liferay.portal.model.Layout',4,'16436',10163,0,19),(5313,10153,'com.liferay.portal.model.Layout',4,'16436',10161,0,1),(5314,10153,'com.liferay.portal.model.User',4,'16442',10162,12102,31),(5315,10153,'com.liferay.portal.model.Layout',4,'16451',10162,16442,1023),(5316,10153,'com.liferay.portal.model.Layout',4,'16456',10162,16442,1023),(5317,10153,'com.liferay.portal.model.Layout',4,'16456',10163,0,19),(5318,10153,'com.liferay.portal.model.Layout',4,'16456',10161,0,1),(5319,10153,'com.liferay.portal.model.User',4,'16462',10162,12102,31),(5320,10153,'com.liferay.portal.model.Layout',4,'16471',10162,16462,1023),(5321,10153,'com.liferay.portal.model.Layout',4,'16476',10162,16462,1023),(5322,10153,'com.liferay.portal.model.Layout',4,'16476',10163,0,19),(5323,10153,'com.liferay.portal.model.Layout',4,'16476',10161,0,1),(5324,10153,'com.liferay.portal.model.Layout',4,'16482',10162,12102,1023),(5325,10153,'com.liferay.portal.model.Layout',4,'16482',10169,0,1),(5326,10153,'com.liferay.portal.model.Layout',4,'16482',10161,0,0),(5327,10153,'com.liferay.portal.model.Layout',4,'16487',10162,12102,1023),(5328,10153,'com.liferay.portal.model.Layout',4,'16487',10169,0,1),(5329,10153,'com.liferay.portal.model.Layout',4,'16487',10161,0,0),(5415,10153,'com.liferay.portal.model.Layout',4,'16487',10164,0,1),(6505,10153,'com.liferay.portal.model.Layout',4,'18106',10169,0,19),(6506,10153,'com.liferay.portal.model.Layout',4,'18106',10161,0,0),(6507,10153,'com.liferay.portal.model.Layout',4,'18111',10162,12102,1023),(5461,10153,'103',4,'16487_LAYOUT_103',10162,0,15),(5462,10153,'103',4,'16487_LAYOUT_103',10169,0,1),(5463,10153,'103',4,'16487_LAYOUT_103',10161,0,1),(5464,10153,'145',4,'16487_LAYOUT_145',10162,0,15),(5465,10153,'145',4,'16487_LAYOUT_145',10169,0,1),(5466,10153,'145',4,'16487_LAYOUT_145',10161,0,1),(5467,10153,'87',4,'16487_LAYOUT_87',10162,0,15),(5468,10153,'87',4,'16487_LAYOUT_87',10169,0,1),(5469,10153,'87',4,'16487_LAYOUT_87',10161,0,1),(5470,10153,'48',4,'16487_LAYOUT_48_INSTANCE_C8iz5NUdy1gW',10162,0,15),(5471,10153,'48',4,'16487_LAYOUT_48_INSTANCE_C8iz5NUdy1gW',10169,0,1),(5472,10153,'48',4,'16487_LAYOUT_48_INSTANCE_C8iz5NUdy1gW',10161,0,1),(5473,10153,'86',4,'16487_LAYOUT_86',10162,0,15),(5474,10153,'86',4,'16487_LAYOUT_86',10169,0,1),(5475,10153,'86',4,'16487_LAYOUT_86',10161,0,1),(5476,10153,'113',4,'16487_LAYOUT_113',10162,0,15),(5477,10153,'113',4,'16487_LAYOUT_113',10169,0,1),(5478,10153,'113',4,'16487_LAYOUT_113',10161,0,1),(5501,10153,'161',4,'10174_LAYOUT_161',10162,0,15),(5502,10153,'161',4,'10174_LAYOUT_161',10169,0,1),(5503,10153,'161',4,'10174_LAYOUT_161',10161,0,1),(6531,10153,'87',4,'18111_LAYOUT_87',10162,0,15),(6530,10153,'49',4,'18106_LAYOUT_49',10161,0,1),(6529,10153,'49',4,'18106_LAYOUT_49',10169,0,1),(6528,10153,'49',4,'18106_LAYOUT_49',10162,0,15),(6527,10153,'Asset_View_WAR_Asset_Viewer_Rep',4,'18106_LAYOUT_Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_HnbYWtIepvG6',10161,0,1),(6542,10153,'113',4,'18111_LAYOUT_113',10161,0,1),(6541,10153,'113',4,'18111_LAYOUT_113',10169,0,1),(6537,10153,'113',4,'18106_LAYOUT_113',10162,0,15),(5613,10153,'111',4,'10174_LAYOUT_111',10162,0,15),(5614,10153,'111',4,'10174_LAYOUT_111',10169,0,1),(5615,10153,'111',4,'10174_LAYOUT_111',10161,0,1),(6535,10153,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep',4,'18111_LAYOUT_Asset_View_Service_WAR_Asset_Viewer_Service_Rep_INSTANCE_lnon2b9YXZh7',10169,0,1),(6536,10153,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep',4,'18111_LAYOUT_Asset_View_Service_WAR_Asset_Viewer_Service_Rep_INSTANCE_lnon2b9YXZh7',10161,0,1),(6534,10153,'Asset_View_Service_WAR_Asset_Viewer_Service_Rep',4,'18111_LAYOUT_Asset_View_Service_WAR_Asset_Viewer_Service_Rep_INSTANCE_lnon2b9YXZh7',10162,0,15),(6532,10153,'87',4,'18111_LAYOUT_87',10169,0,1),(6533,10153,'87',4,'18111_LAYOUT_87',10161,0,1),(6526,10153,'Asset_View_WAR_Asset_Viewer_Rep',4,'18106_LAYOUT_Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_HnbYWtIepvG6',10169,0,1),(6524,10153,'87',4,'18106_LAYOUT_87',10161,0,1),(6525,10153,'Asset_View_WAR_Asset_Viewer_Rep',4,'18106_LAYOUT_Asset_View_WAR_Asset_Viewer_Rep_INSTANCE_HnbYWtIepvG6',10162,0,15),(6522,10153,'87',4,'18106_LAYOUT_87',10162,0,15),(6523,10153,'87',4,'18106_LAYOUT_87',10169,0,1),(5801,10153,'98',4,'10174_LAYOUT_98',10162,0,31),(5802,10153,'98',4,'10174_LAYOUT_98',10169,0,1),(5803,10153,'98',4,'10174_LAYOUT_98',10161,0,1),(5804,10153,'com.liferay.portlet.softwarecatalog',4,'10179',10162,0,14),(6540,10153,'113',4,'18111_LAYOUT_113',10162,0,15),(6539,10153,'113',4,'18106_LAYOUT_113',10161,0,1),(6538,10153,'113',4,'18106_LAYOUT_113',10169,0,1),(6201,10153,'com.liferay.portlet.wiki.model.WikiNode',4,'17502',10162,10157,255),(6202,10153,'com.liferay.portlet.wiki.model.WikiNode',4,'17502',10169,0,71),(6203,10153,'com.liferay.portlet.wiki.model.WikiNode',4,'17502',10161,0,1),(6204,10153,'com.liferay.portal.model.User',4,'17503',10162,12102,31),(6301,10153,'com.liferay.portal.model.User',4,'17603',10162,12102,31),(6405,10153,'com.liferay.portlet.documentlibrary',4,'10191',10164,0,75);
/*!40000 ALTER TABLE `resourcepermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbthreadflag`
--

DROP TABLE IF EXISTS `mbthreadflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbthreadflag` (
  `threadFlagId` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `threadId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`threadFlagId`),
  KEY `IX_8CB0A24A` (`threadId`),
  KEY `IX_A28004B` (`userId`),
  KEY `IX_33781904` (`userId`,`threadId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbthreadflag`
--

LOCK TABLES `mbthreadflag` WRITE;
/*!40000 ALTER TABLE `mbthreadflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `mbthreadflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetentries_assetcategories`
--

DROP TABLE IF EXISTS `assetentries_assetcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetentries_assetcategories` (
  `entryId` bigint(20) NOT NULL,
  `categoryId` bigint(20) NOT NULL,
  PRIMARY KEY (`entryId`,`categoryId`),
  KEY `IX_A188F560` (`categoryId`),
  KEY `IX_E119938A` (`entryId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetentries_assetcategories`
--

LOCK TABLES `assetentries_assetcategories` WRITE;
/*!40000 ALTER TABLE `assetentries_assetcategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetentries_assetcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `regionId` bigint(20) NOT NULL,
  `countryId` bigint(20) DEFAULT NULL,
  `regionCode` varchar(75) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`regionId`),
  UNIQUE KEY `IX_A2635F5C` (`countryId`,`regionCode`),
  KEY `IX_2D9A426F` (`active_`),
  KEY `IX_16D87CA7` (`countryId`),
  KEY `IX_11FB3E42` (`countryId`,`active_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (1001,1,'AB','Alberta',1),(1002,1,'BC','British Columbia',1),(1003,1,'MB','Manitoba',1),(1004,1,'NB','New Brunswick',1),(1005,1,'NL','Newfoundland and Labrador',1),(1006,1,'NT','Northwest Territories',1),(1007,1,'NS','Nova Scotia',1),(1008,1,'NU','Nunavut',1),(1009,1,'ON','Ontario',1),(1010,1,'PE','Prince Edward Island',1),(1011,1,'QC','Quebec',1),(1012,1,'SK','Saskatchewan',1),(1013,1,'YT','Yukon',1),(2001,2,'CN-34','Anhui',1),(2002,2,'CN-92','Aomen',1),(2003,2,'CN-11','Beijing',1),(2004,2,'CN-50','Chongqing',1),(2005,2,'CN-35','Fujian',1),(2006,2,'CN-62','Gansu',1),(2007,2,'CN-44','Guangdong',1),(2008,2,'CN-45','Guangxi',1),(2009,2,'CN-52','Guizhou',1),(2010,2,'CN-46','Hainan',1),(2011,2,'CN-13','Hebei',1),(2012,2,'CN-23','Heilongjiang',1),(2013,2,'CN-41','Henan',1),(2014,2,'CN-42','Hubei',1),(2015,2,'CN-43','Hunan',1),(2016,2,'CN-32','Jiangsu',1),(2017,2,'CN-36','Jiangxi',1),(2018,2,'CN-22','Jilin',1),(2019,2,'CN-21','Liaoning',1),(2020,2,'CN-15','Nei Mongol',1),(2021,2,'CN-64','Ningxia',1),(2022,2,'CN-63','Qinghai',1),(2023,2,'CN-61','Shaanxi',1),(2024,2,'CN-37','Shandong',1),(2025,2,'CN-31','Shanghai',1),(2026,2,'CN-14','Shanxi',1),(2027,2,'CN-51','Sichuan',1),(2028,2,'CN-71','Taiwan',1),(2029,2,'CN-12','Tianjin',1),(2030,2,'CN-91','Xianggang',1),(2031,2,'CN-65','Xinjiang',1),(2032,2,'CN-54','Xizang',1),(2033,2,'CN-53','Yunnan',1),(2034,2,'CN-33','Zhejiang',1),(3001,3,'A','Alsace',1),(3002,3,'B','Aquitaine',1),(3003,3,'C','Auvergne',1),(3004,3,'P','Basse-Normandie',1),(3005,3,'D','Bourgogne',1),(3006,3,'E','Bretagne',1),(3007,3,'F','Centre',1),(3008,3,'G','Champagne-Ardenne',1),(3009,3,'H','Corse',1),(3010,3,'GF','Guyane',1),(3011,3,'I','Franche Comté',1),(3012,3,'GP','Guadeloupe',1),(3013,3,'Q','Haute-Normandie',1),(3014,3,'J','Île-de-France',1),(3015,3,'K','Languedoc-Roussillon',1),(3016,3,'L','Limousin',1),(3017,3,'M','Lorraine',1),(3018,3,'MQ','Martinique',1),(3019,3,'N','Midi-Pyrénées',1),(3020,3,'O','Nord Pas de Calais',1),(3021,3,'R','Pays de la Loire',1),(3022,3,'S','Picardie',1),(3023,3,'T','Poitou-Charentes',1),(3024,3,'U','Provence-Alpes-Côte-d\'Azur',1),(3025,3,'RE','Réunion',1),(3026,3,'V','Rhône-Alpes',1),(4001,4,'BW','Baden-Württemberg',1),(4002,4,'BY','Bayern',1),(4003,4,'BE','Berlin',1),(4004,4,'BR','Brandenburg',1),(4005,4,'HB','Bremen',1),(4006,4,'HH','Hamburg',1),(4007,4,'HE','Hessen',1),(4008,4,'MV','Mecklenburg-Vorpommern',1),(4009,4,'NI','Niedersachsen',1),(4010,4,'NW','Nordrhein-Westfalen',1),(4011,4,'RP','Rheinland-Pfalz',1),(4012,4,'SL','Saarland',1),(4013,4,'SN','Sachsen',1),(4014,4,'ST','Sachsen-Anhalt',1),(4015,4,'SH','Schleswig-Holstein',1),(4016,4,'TH','Thüringen',1),(8001,8,'AG','Agrigento',1),(8002,8,'AL','Alessandria',1),(8003,8,'AN','Ancona',1),(8004,8,'AO','Aosta',1),(8005,8,'AR','Arezzo',1),(8006,8,'AP','Ascoli Piceno',1),(8007,8,'AT','Asti',1),(8008,8,'AV','Avellino',1),(8009,8,'BA','Bari',1),(8010,8,'BT','Barletta-Andria-Trani',1),(8011,8,'BL','Belluno',1),(8012,8,'BN','Benevento',1),(8013,8,'BG','Bergamo',1),(8014,8,'BI','Biella',1),(8015,8,'BO','Bologna',1),(8016,8,'BZ','Bolzano',1),(8017,8,'BS','Brescia',1),(8018,8,'BR','Brindisi',1),(8019,8,'CA','Cagliari',1),(8020,8,'CL','Caltanissetta',1),(8021,8,'CB','Campobasso',1),(8022,8,'CI','Carbonia-Iglesias',1),(8023,8,'CE','Caserta',1),(8024,8,'CT','Catania',1),(8025,8,'CZ','Catanzaro',1),(8026,8,'CH','Chieti',1),(8027,8,'CO','Como',1),(8028,8,'CS','Cosenza',1),(8029,8,'CR','Cremona',1),(8030,8,'KR','Crotone',1),(8031,8,'CN','Cuneo',1),(8032,8,'EN','Enna',1),(8033,8,'FM','Fermo',1),(8034,8,'FE','Ferrara',1),(8035,8,'FI','Firenze',1),(8036,8,'FG','Foggia',1),(8037,8,'FC','Forli-Cesena',1),(8038,8,'FR','Frosinone',1),(8039,8,'GE','Genova',1),(8040,8,'GO','Gorizia',1),(8041,8,'GR','Grosseto',1),(8042,8,'IM','Imperia',1),(8043,8,'IS','Isernia',1),(8044,8,'AQ','L\'Aquila',1),(8045,8,'SP','La Spezia',1),(8046,8,'LT','Latina',1),(8047,8,'LE','Lecce',1),(8048,8,'LC','Lecco',1),(8049,8,'LI','Livorno',1),(8050,8,'LO','Lodi',1),(8051,8,'LU','Lucca',1),(8052,8,'MC','Macerata',1),(8053,8,'MN','Mantova',1),(8054,8,'MS','Massa-Carrara',1),(8055,8,'MT','Matera',1),(8056,8,'MA','Medio Campidano',1),(8057,8,'ME','Messina',1),(8058,8,'MI','Milano',1),(8059,8,'MO','Modena',1),(8060,8,'MZ','Monza',1),(8061,8,'NA','Napoli',1),(8062,8,'NO','Novara',1),(8063,8,'NU','Nuoro',1),(8064,8,'OG','Ogliastra',1),(8065,8,'OT','Olbia-Tempio',1),(8066,8,'OR','Oristano',1),(8067,8,'PD','Padova',1),(8068,8,'PA','Palermo',1),(8069,8,'PR','Parma',1),(8070,8,'PV','Pavia',1),(8071,8,'PG','Perugia',1),(8072,8,'PU','Pesaro e Urbino',1),(8073,8,'PE','Pescara',1),(8074,8,'PC','Piacenza',1),(8075,8,'PI','Pisa',1),(8076,8,'PT','Pistoia',1),(8077,8,'PN','Pordenone',1),(8078,8,'PZ','Potenza',1),(8079,8,'PO','Prato',1),(8080,8,'RG','Ragusa',1),(8081,8,'RA','Ravenna',1),(8082,8,'RC','Reggio Calabria',1),(8083,8,'RE','Reggio Emilia',1),(8084,8,'RI','Rieti',1),(8085,8,'RN','Rimini',1),(8086,8,'RM','Roma',1),(8087,8,'RO','Rovigo',1),(8088,8,'SA','Salerno',1),(8089,8,'SS','Sassari',1),(8090,8,'SV','Savona',1),(8091,8,'SI','Siena',1),(8092,8,'SR','Siracusa',1),(8093,8,'SO','Sondrio',1),(8094,8,'TA','Taranto',1),(8095,8,'TE','Teramo',1),(8096,8,'TR','Terni',1),(8097,8,'TO','Torino',1),(8098,8,'TP','Trapani',1),(8099,8,'TN','Trento',1),(8100,8,'TV','Treviso',1),(8101,8,'TS','Trieste',1),(8102,8,'UD','Udine',1),(8103,8,'VA','Varese',1),(8104,8,'VE','Venezia',1),(8105,8,'VB','Verbano-Cusio-Ossola',1),(8106,8,'VC','Vercelli',1),(8107,8,'VR','Verona',1),(8108,8,'VV','Vibo Valentia',1),(8109,8,'VI','Vicenza',1),(8110,8,'VT','Viterbo',1),(11001,11,'DR','Drenthe',1),(11002,11,'FL','Flevoland',1),(11003,11,'FR','Friesland',1),(11004,11,'GE','Gelderland',1),(11005,11,'GR','Groningen',1),(11006,11,'LI','Limburg',1),(11007,11,'NB','Noord-Brabant',1),(11008,11,'NH','Noord-Holland',1),(11009,11,'OV','Overijssel',1),(11010,11,'UT','Utrecht',1),(11011,11,'ZE','Zeeland',1),(11012,11,'ZH','Zuid-Holland',1),(15001,15,'AN','Andalusia',1),(15002,15,'AR','Aragon',1),(15003,15,'AS','Asturias',1),(15004,15,'IB','Balearic Islands',1),(15005,15,'PV','Basque Country',1),(15006,15,'CN','Canary Islands',1),(15007,15,'CB','Cantabria',1),(15008,15,'CL','Castile and Leon',1),(15009,15,'CM','Castile-La Mancha',1),(15010,15,'CT','Catalonia',1),(15011,15,'CE','Ceuta',1),(15012,15,'EX','Extremadura',1),(15013,15,'GA','Galicia',1),(15014,15,'LO','La Rioja',1),(15015,15,'M','Madrid',1),(15016,15,'ML','Melilla',1),(15017,15,'MU','Murcia',1),(15018,15,'NA','Navarra',1),(15019,15,'VC','Valencia',1),(19001,19,'AL','Alabama',1),(19002,19,'AK','Alaska',1),(19003,19,'AZ','Arizona',1),(19004,19,'AR','Arkansas',1),(19005,19,'CA','California',1),(19006,19,'CO','Colorado',1),(19007,19,'CT','Connecticut',1),(19008,19,'DC','District of Columbia',1),(19009,19,'DE','Delaware',1),(19010,19,'FL','Florida',1),(19011,19,'GA','Georgia',1),(19012,19,'HI','Hawaii',1),(19013,19,'ID','Idaho',1),(19014,19,'IL','Illinois',1),(19015,19,'IN','Indiana',1),(19016,19,'IA','Iowa',1),(19017,19,'KS','Kansas',1),(19018,19,'KY','Kentucky',1),(19019,19,'LA','Louisiana',1),(19020,19,'ME','Maine',1),(19021,19,'MD','Maryland',1),(19022,19,'MA','Massachusetts',1),(19023,19,'MI','Michigan',1),(19024,19,'MN','Minnesota',1),(19025,19,'MS','Mississippi',1),(19026,19,'MO','Missouri',1),(19027,19,'MT','Montana',1),(19028,19,'NE','Nebraska',1),(19029,19,'NV','Nevada',1),(19030,19,'NH','New Hampshire',1),(19031,19,'NJ','New Jersey',1),(19032,19,'NM','New Mexico',1),(19033,19,'NY','New York',1),(19034,19,'NC','North Carolina',1),(19035,19,'ND','North Dakota',1),(19036,19,'OH','Ohio',1),(19037,19,'OK','Oklahoma',1),(19038,19,'OR','Oregon',1),(19039,19,'PA','Pennsylvania',1),(19040,19,'PR','Puerto Rico',1),(19041,19,'RI','Rhode Island',1),(19042,19,'SC','South Carolina',1),(19043,19,'SD','South Dakota',1),(19044,19,'TN','Tennessee',1),(19045,19,'TX','Texas',1),(19046,19,'UT','Utah',1),(19047,19,'VT','Vermont',1),(19048,19,'VA','Virginia',1),(19049,19,'WA','Washington',1),(19050,19,'WV','West Virginia',1),(19051,19,'WI','Wisconsin',1),(19052,19,'WY','Wyoming',1),(32001,32,'ACT','Australian Capital Territory',1),(32002,32,'NSW','New South Wales',1),(32003,32,'NT','Northern Territory',1),(32004,32,'QLD','Queensland',1),(32005,32,'SA','South Australia',1),(32006,32,'TAS','Tasmania',1),(32007,32,'VIC','Victoria',1),(32008,32,'WA','Western Australia',1),(144001,144,'MX-AGS','Aguascalientes',1),(144002,144,'MX-BCN','Baja California',1),(144003,144,'MX-BCS','Baja California Sur',1),(144004,144,'MX-CAM','Campeche',1),(144005,144,'MX-CHP','Chiapas',1),(144006,144,'MX-CHI','Chihuahua',1),(144007,144,'MX-COA','Coahuila',1),(144008,144,'MX-COL','Colima',1),(144009,144,'MX-DUR','Durango',1),(144010,144,'MX-GTO','Guanajuato',1),(144011,144,'MX-GRO','Guerrero',1),(144012,144,'MX-HGO','Hidalgo',1),(144013,144,'MX-JAL','Jalisco',1),(144014,144,'MX-MEX','Mexico',1),(144015,144,'MX-MIC','Michoacan',1),(144016,144,'MX-MOR','Morelos',1),(144017,144,'MX-NAY','Nayarit',1),(144018,144,'MX-NLE','Nuevo Leon',1),(144019,144,'MX-OAX','Oaxaca',1),(144020,144,'MX-PUE','Puebla',1),(144021,144,'MX-QRO','Queretaro',1),(144023,144,'MX-ROO','Quintana Roo',1),(144024,144,'MX-SLP','San Luis Potosí',1),(144025,144,'MX-SIN','Sinaloa',1),(144026,144,'MX-SON','Sonora',1),(144027,144,'MX-TAB','Tabasco',1),(144028,144,'MX-TAM','Tamaulipas',1),(144029,144,'MX-TLX','Tlaxcala',1),(144030,144,'MX-VER','Veracruz',1),(144031,144,'MX-YUC','Yucatan',1),(144032,144,'MX-ZAC','Zacatecas',1),(164001,164,'01','Østfold',1),(164002,164,'02','Akershus',1),(164003,164,'03','Oslo',1),(164004,164,'04','Hedmark',1),(164005,164,'05','Oppland',1),(164006,164,'06','Buskerud',1),(164007,164,'07','Vestfold',1),(164008,164,'08','Telemark',1),(164009,164,'09','Aust-Agder',1),(164010,164,'10','Vest-Agder',1),(164011,164,'11','Rogaland',1),(164012,164,'12','Hordaland',1),(164013,164,'14','Sogn og Fjordane',1),(164014,164,'15','Møre of Romsdal',1),(164015,164,'16','Sør-Trøndelag',1),(164016,164,'17','Nord-Trøndelag',1),(164017,164,'18','Nordland',1),(164018,164,'19','Troms',1),(164019,164,'20','Finnmark',1),(202001,202,'AG','Aargau',1),(202002,202,'AR','Appenzell Ausserrhoden',1),(202003,202,'AI','Appenzell Innerrhoden',1),(202004,202,'BL','Basel-Landschaft',1),(202005,202,'BS','Basel-Stadt',1),(202006,202,'BE','Bern',1),(202007,202,'FR','Fribourg',1),(202008,202,'GE','Geneva',1),(202009,202,'GL','Glarus',1),(202010,202,'GR','Graubünden',1),(202011,202,'JU','Jura',1),(202012,202,'LU','Lucerne',1),(202013,202,'NE','Neuchâtel',1),(202014,202,'NW','Nidwalden',1),(202015,202,'OW','Obwalden',1),(202016,202,'SH','Schaffhausen',1),(202017,202,'SZ','Schwyz',1),(202018,202,'SO','Solothurn',1),(202019,202,'SG','St. Gallen',1),(202020,202,'TG','Thurgau',1),(202021,202,'TI','Ticino',1),(202022,202,'UR','Uri',1),(202023,202,'VS','Valais',1),(202024,202,'VD','Vaud',1),(202025,202,'ZG','Zug',1),(202026,202,'ZH','Zürich',1);
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expandovalue`
--

DROP TABLE IF EXISTS `expandovalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expandovalue` (
  `valueId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `tableId` bigint(20) DEFAULT NULL,
  `columnId` bigint(20) DEFAULT NULL,
  `rowId_` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `data_` longtext,
  PRIMARY KEY (`valueId`),
  UNIQUE KEY `IX_9DDD21E5` (`columnId`,`rowId_`),
  UNIQUE KEY `IX_D27B03E7` (`tableId`,`columnId`,`classPK`),
  KEY `IX_B29FEF17` (`classNameId`,`classPK`),
  KEY `IX_F7DD0987` (`columnId`),
  KEY `IX_9112A7A0` (`rowId_`),
  KEY `IX_F0566A77` (`tableId`),
  KEY `IX_1BD3F4C` (`tableId`,`classPK`),
  KEY `IX_CA9AFB7C` (`tableId`,`columnId`),
  KEY `IX_B71E92D5` (`tableId`,`rowId_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expandovalue`
--

LOCK TABLES `expandovalue` WRITE;
/*!40000 ALTER TABLE `expandovalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `expandovalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflowdefinitionlink`
--

DROP TABLE IF EXISTS `workflowdefinitionlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflowdefinitionlink` (
  `workflowDefinitionLinkId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `typePK` bigint(20) DEFAULT NULL,
  `workflowDefinitionName` varchar(75) DEFAULT NULL,
  `workflowDefinitionVersion` int(11) DEFAULT NULL,
  PRIMARY KEY (`workflowDefinitionLinkId`),
  KEY `IX_A8B0D276` (`companyId`),
  KEY `IX_A4DB1F0F` (`companyId`,`workflowDefinitionName`,`workflowDefinitionVersion`),
  KEY `IX_B6EE8C9E` (`groupId`,`companyId`,`classNameId`),
  KEY `IX_1E5B9905` (`groupId`,`companyId`,`classNameId`,`classPK`),
  KEY `IX_705B40EE` (`groupId`,`companyId`,`classNameId`,`classPK`,`typePK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflowdefinitionlink`
--

LOCK TABLES `workflowdefinitionlink` WRITE;
/*!40000 ALTER TABLE `workflowdefinitionlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflowdefinitionlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingitemfield`
--

DROP TABLE IF EXISTS `shoppingitemfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingitemfield` (
  `itemFieldId` bigint(20) NOT NULL,
  `itemId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `values_` longtext,
  `description` longtext,
  PRIMARY KEY (`itemFieldId`),
  KEY `IX_6D5F9B87` (`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingitemfield`
--

LOCK TABLES `shoppingitemfield` WRITE;
/*!40000 ALTER TABLE `shoppingitemfield` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingitemfield` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddlrecordset`
--

DROP TABLE IF EXISTS `ddlrecordset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddlrecordset` (
  `uuid_` varchar(75) DEFAULT NULL,
  `recordSetId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `DDMStructureId` bigint(20) DEFAULT NULL,
  `recordSetKey` varchar(75) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `minDisplayRows` int(11) DEFAULT NULL,
  `scope` int(11) DEFAULT NULL,
  PRIMARY KEY (`recordSetId`),
  UNIQUE KEY `IX_56DAB121` (`groupId`,`recordSetKey`),
  UNIQUE KEY `IX_270BA5E1` (`uuid_`,`groupId`),
  KEY `IX_4FA5969F` (`groupId`),
  KEY `IX_561E44E9` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddlrecordset`
--

LOCK TABLES `ddlrecordset` WRITE;
/*!40000 ALTER TABLE `ddlrecordset` DISABLE KEYS */;
/*!40000 ALTER TABLE `ddlrecordset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_`
--

DROP TABLE IF EXISTS `group_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_` (
  `groupId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `creatorUserId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `parentGroupId` bigint(20) DEFAULT NULL,
  `liveGroupId` bigint(20) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `description` longtext,
  `type_` int(11) DEFAULT NULL,
  `typeSettings` longtext,
  `friendlyURL` varchar(100) DEFAULT NULL,
  `site` tinyint(4) DEFAULT NULL,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`groupId`),
  UNIQUE KEY `IX_D0D5E397` (`companyId`,`classNameId`,`classPK`),
  UNIQUE KEY `IX_5DE0BE11` (`companyId`,`classNameId`,`liveGroupId`,`name`),
  UNIQUE KEY `IX_5BDDB872` (`companyId`,`friendlyURL`),
  UNIQUE KEY `IX_BBCA55B` (`companyId`,`liveGroupId`,`name`),
  UNIQUE KEY `IX_5AA68501` (`companyId`,`name`),
  KEY `IX_ABA5CEC2` (`companyId`),
  KEY `IX_16218A38` (`liveGroupId`),
  KEY `IX_7B590A7A` (`type_`,`active_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_`
--

LOCK TABLES `group_` WRITE;
/*!40000 ALTER TABLE `group_` DISABLE KEYS */;
INSERT INTO `group_` VALUES (10171,10153,10157,10001,10171,0,0,'Control Panel','',3,'','/control_panel',1,1),(10179,10153,10157,10001,10179,0,0,'Guest','FITMAN Portal',1,'false-robots.txt=User-Agent: *_SAFE_NEWLINE_CHARACTER_Disallow:_SAFE_NEWLINE_CHARACTER_Sitemap: http://localhost/sitemap.xml\nmergeGuestPublicPages=false\n','/guest',1,1),(10188,10153,10157,10187,10157,0,0,'User Personal Site','',3,'','/personal_site',0,1),(10191,10153,10157,10021,10153,0,0,'10153','',0,'','/null',0,1),(10310,10153,10157,10027,10309,0,0,'10309','',0,'','/template-10309',0,1),(10320,10153,10157,10027,10319,0,0,'10319','',0,'','/template-10319',0,1),(10329,10153,10157,10027,10328,0,0,'10328','',0,'','/template-10328',0,1),(10338,10153,10157,10031,10337,0,0,'10337','',0,'','/template-10337',0,1),(10364,10153,10157,10031,10363,0,0,'10363','',0,'','/template-10363',0,1),(11605,10153,10157,10031,11604,0,0,'11604','',0,'','/template-11604',0,1),(12104,10153,12102,10005,12102,0,0,'12102','',0,'','/admin',0,1),(16310,10153,16308,10005,16308,0,0,'16308','',0,'','/fitman-guest',0,1),(16404,10153,16402,10005,16402,0,0,'16402','',0,'','/mseeadmin',0,1),(16424,10153,16422,10005,16422,0,0,'16422','',0,'','/mseebusinessexpert',0,1),(16444,10153,16442,10005,16442,0,0,'16442','',0,'','/mseeemployee',0,1),(16464,10153,16462,10005,16462,0,0,'16462','',0,'','/mseeitexpert',0,1),(17505,10153,17503,10005,17503,0,0,'17503','',0,'','/user',0,1),(17605,10153,17603,10005,17603,0,0,'17603','',0,'','/userfitman',0,1);
/*!40000 ALTER TABLE `group_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passwordpolicyrel`
--

DROP TABLE IF EXISTS `passwordpolicyrel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `passwordpolicyrel` (
  `passwordPolicyRelId` bigint(20) NOT NULL,
  `passwordPolicyId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`passwordPolicyRelId`),
  KEY `IX_C3A17327` (`classNameId`,`classPK`),
  KEY `IX_CD25266E` (`passwordPolicyId`),
  KEY `IX_ED7CF243` (`passwordPolicyId`,`classNameId`,`classPK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passwordpolicyrel`
--

LOCK TABLES `passwordpolicyrel` WRITE;
/*!40000 ALTER TABLE `passwordpolicyrel` DISABLE KEYS */;
/*!40000 ALTER TABLE `passwordpolicyrel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layoutbranch`
--

DROP TABLE IF EXISTS `layoutbranch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layoutbranch` (
  `LayoutBranchId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `layoutSetBranchId` bigint(20) DEFAULT NULL,
  `plid` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `master` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`LayoutBranchId`),
  UNIQUE KEY `IX_FD57097D` (`layoutSetBranchId`,`plid`,`name`),
  KEY `IX_6C226433` (`layoutSetBranchId`),
  KEY `IX_2C42603E` (`layoutSetBranchId`,`plid`),
  KEY `IX_A705FF94` (`layoutSetBranchId`,`plid`,`master`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layoutbranch`
--

LOCK TABLES `layoutbranch` WRITE;
/*!40000 ALTER TABLE `layoutbranch` DISABLE KEYS */;
/*!40000 ALTER TABLE `layoutbranch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_usergroups`
--

DROP TABLE IF EXISTS `groups_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_usergroups` (
  `groupId` bigint(20) NOT NULL,
  `userGroupId` bigint(20) NOT NULL,
  PRIMARY KEY (`groupId`,`userGroupId`),
  KEY `IX_31FB749A` (`groupId`),
  KEY `IX_3B69160F` (`userGroupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_usergroups`
--

LOCK TABLES `groups_usergroups` WRITE;
/*!40000 ALTER TABLE `groups_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdraction`
--

DROP TABLE IF EXISTS `mdraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdraction` (
  `uuid_` varchar(75) DEFAULT NULL,
  `actionId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `ruleGroupInstanceId` bigint(20) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `type_` varchar(255) DEFAULT NULL,
  `typeSettings` longtext,
  PRIMARY KEY (`actionId`),
  UNIQUE KEY `IX_75BE36AD` (`uuid_`,`groupId`),
  KEY `IX_FD90786C` (`ruleGroupInstanceId`),
  KEY `IX_77BB5E9D` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdraction`
--

LOCK TABLES `mdraction` WRITE;
/*!40000 ALTER TABLE `mdraction` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `imageId` bigint(20) NOT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `text_` longtext,
  `type_` varchar(75) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `size_` int(11) DEFAULT NULL,
  PRIMARY KEY (`imageId`),
  KEY `IX_6A925A4D` (`size_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialactivityachievement`
--

DROP TABLE IF EXISTS `socialactivityachievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialactivityachievement` (
  `activityAchievementId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createDate` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `firstInGroup` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`activityAchievementId`),
  UNIQUE KEY `IX_D4390CAA` (`groupId`,`userId`,`name`),
  KEY `IX_E14B1F1` (`groupId`),
  KEY `IX_83E16F2F` (`groupId`,`firstInGroup`),
  KEY `IX_8F6408F0` (`groupId`,`name`),
  KEY `IX_C8FD892B` (`groupId`,`userId`),
  KEY `IX_AABC18E9` (`groupId`,`userId`,`firstInGroup`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialactivityachievement`
--

LOCK TABLES `socialactivityachievement` WRITE;
/*!40000 ALTER TABLE `socialactivityachievement` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialactivityachievement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wikipageresource`
--

DROP TABLE IF EXISTS `wikipageresource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wikipageresource` (
  `uuid_` varchar(75) DEFAULT NULL,
  `resourcePrimKey` bigint(20) NOT NULL,
  `nodeId` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`resourcePrimKey`),
  UNIQUE KEY `IX_21277664` (`nodeId`,`title`),
  KEY `IX_BE898221` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wikipageresource`
--

LOCK TABLES `wikipageresource` WRITE;
/*!40000 ALTER TABLE `wikipageresource` DISABLE KEYS */;
/*!40000 ALTER TABLE `wikipageresource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcementsflag`
--

DROP TABLE IF EXISTS `announcementsflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcementsflag` (
  `flagId` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `entryId` bigint(20) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  PRIMARY KEY (`flagId`),
  UNIQUE KEY `IX_4539A99C` (`userId`,`entryId`,`value`),
  KEY `IX_9C7EB9F` (`entryId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcementsflag`
--

LOCK TABLES `announcementsflag` WRITE;
/*!40000 ALTER TABLE `announcementsflag` DISABLE KEYS */;
INSERT INTO `announcementsflag` VALUES (13419,10157,'2012-11-29 15:12:02',13109,1),(13445,13239,'2012-11-29 15:13:11',13109,1),(13431,13230,'2012-11-29 15:12:28',13105,1),(13166,12102,'2012-11-29 12:13:13',13165,1),(13132,12102,'2012-11-29 11:55:18',0,1),(13457,13248,'2012-11-29 15:13:57',13105,1),(13418,10157,'2012-11-29 15:12:02',13105,1),(13168,10157,'2012-11-29 12:23:13',13165,1),(13184,12910,'2012-11-29 13:45:35',13165,1),(13444,13239,'2012-11-29 15:13:11',13105,1),(13417,13221,'2012-11-29 15:11:41',13109,1),(13432,13230,'2012-11-29 15:12:28',13109,1),(13416,13221,'2012-11-29 15:11:41',13105,1),(13403,12102,'2012-11-29 15:10:17',13109,1),(13404,12102,'2012-11-29 15:10:36',13105,1),(13458,13248,'2012-11-29 15:13:57',13109,1),(13470,13258,'2012-11-29 15:14:48',13105,1),(13471,13258,'2012-11-29 15:14:48',13109,1),(13483,13267,'2012-11-29 15:16:01',13105,1),(13484,13267,'2012-11-29 15:16:01',13109,1),(13496,13289,'2012-11-29 15:16:51',13105,1),(13497,13289,'2012-11-29 15:16:51',13109,1),(13509,13318,'2012-11-29 15:17:42',13105,1),(13510,13318,'2012-11-29 15:17:42',13109,1),(13522,13327,'2012-11-29 15:18:54',13105,1),(13523,13327,'2012-11-29 15:18:54',13109,1),(13535,13338,'2012-11-29 15:21:16',13105,1),(13536,13338,'2012-11-29 15:21:16',13109,1),(13537,12910,'2012-11-29 15:25:42',13105,1),(13538,12910,'2012-11-29 15:25:42',13109,1),(13539,12901,'2012-11-29 15:38:07',13105,1),(13540,12901,'2012-11-29 15:38:07',13109,1),(13541,13202,'2012-11-30 09:53:25',13105,1),(13542,13202,'2012-11-30 09:53:25',13109,1),(13543,13212,'2012-11-30 09:56:55',13105,1),(13544,13212,'2012-11-30 09:56:55',13109,1),(13573,13552,'2012-11-30 17:02:12',13105,1),(13574,13552,'2012-11-30 17:02:12',13109,1),(13701,13338,'2012-12-03 13:15:47',13109,2),(13722,13702,'2012-12-05 11:23:38',13105,1),(13723,13702,'2012-12-05 11:23:38',13109,1),(13724,12801,'2012-12-10 13:41:31',13105,1),(13725,12801,'2012-12-10 13:41:31',13109,1);
/*!40000 ALTER TABLE `announcementsflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroup`
--

DROP TABLE IF EXISTS `usergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroup` (
  `userGroupId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `parentUserGroupId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `addedByLDAPImport` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`userGroupId`),
  UNIQUE KEY `IX_23EAD0D` (`companyId`,`name`),
  KEY `IX_524FEFCE` (`companyId`),
  KEY `IX_69771487` (`companyId`,`parentUserGroupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroup`
--

LOCK TABLES `usergroup` WRITE;
/*!40000 ALTER TABLE `usergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opensocial_gadget`
--

DROP TABLE IF EXISTS `opensocial_gadget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opensocial_gadget` (
  `uuid_` varchar(75) DEFAULT NULL,
  `gadgetId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `url` longtext,
  `portletCategoryNames` longtext,
  PRIMARY KEY (`gadgetId`),
  KEY `IX_729869EE` (`companyId`),
  KEY `IX_E1F8627A` (`uuid_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opensocial_gadget`
--

LOCK TABLES `opensocial_gadget` WRITE;
/*!40000 ALTER TABLE `opensocial_gadget` DISABLE KEYS */;
INSERT INTO `opensocial_gadget` VALUES ('d31e75ef-96fe-4094-8b00-ddb873e622f6',15028,10153,'2013-05-07 14:27:31','2013-05-07 14:27:31','Named Individual Properties','http://demos.txt.it/gadgets/AssetsEcosystemNamedIndividualRepository/gadget.xml','root//category.gadgets'),('4dbcf984-6462-4c1c-ac90-6761b366d688',15270,10153,'2013-05-10 12:39:56','2013-05-10 12:39:56','VirtualRoomGadget','http://demos.txt.it/gadgets/VirtualRoomGadget/gadget.xml','root//category.gadgets'),('e916fdc0-aa8d-434e-b0ff-fc63b6137eb0',15701,10153,'2013-05-13 08:00:01','2013-05-13 08:00:01','AssetsEcosystemRepository','http://demos.txt.it/gadgets/AssetsEcosystemRepository/gadget.xml','root//category.gadgets'),('21917435-b9d8-4586-a315-639ed79bfd95',15801,10153,'2013-09-03 12:37:57','2013-09-03 12:37:57','VirtualRoomListGadget','http://demos.txt.it/gadgets/VirtualRoomListGadget/gadget.xml','root//category.gadgets'),('6da598d7-0aaa-4b1f-bfe2-41edd18db021',16033,10153,'2013-09-27 12:52:32','2013-09-27 12:52:32','PPAdminGadget','http://demos.txt.it/gadgets/PPAdminGadget/gadget.xml','root//category.gadgets,root//category.social');
/*!40000 ALTER TABLE `opensocial_gadget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfilerank`
--

DROP TABLE IF EXISTS `dlfilerank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfilerank` (
  `fileRankId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `fileEntryId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`fileRankId`),
  UNIQUE KEY `IX_38F0315` (`companyId`,`userId`,`fileEntryId`),
  KEY `IX_A65A1F8B` (`fileEntryId`),
  KEY `IX_BAFB116E` (`groupId`,`userId`),
  KEY `IX_EED06670` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfilerank`
--

LOCK TABLES `dlfilerank` WRITE;
/*!40000 ALTER TABLE `dlfilerank` DISABLE KEYS */;
INSERT INTO `dlfilerank` VALUES (18313,10191,10153,12102,'2014-03-04 08:49:52',18301),(10701,10179,10153,10157,'2012-09-10 12:39:01',10553),(18318,10191,10153,10157,'2015-04-03 11:18:14',18301),(13131,10191,10153,12102,'2013-12-23 12:06:34',13119),(13364,10191,10153,10157,'2013-12-18 15:05:59',13187),(13164,10191,10153,12102,'2013-12-17 10:56:46',13152),(13181,10191,10153,10157,'2012-12-26 17:24:36',13136),(13180,10191,10153,10157,'2013-12-18 15:05:59',13152),(13199,10191,10153,12102,'2013-12-17 10:56:46',13187),(13359,10191,10153,12102,'2013-12-17 10:56:46',13347),(13365,10191,10153,10157,'2013-12-23 10:48:36',13347),(16805,10191,10153,16308,'2013-11-23 13:56:10',13347);
/*!40000 ALTER TABLE `dlfilerank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_fired_triggers`
--

DROP TABLE IF EXISTS `quartz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(20) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` tinyint(4) DEFAULT NULL,
  `REQUESTS_RECOVERY` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IX_BE3835E5` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IX_4BD722BM` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IX_204D31E8` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IX_339E078M` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IX_5005E3AF` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IX_BC2F03B0` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_fired_triggers`
--

LOCK TABLES `quartz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `quartz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettagproperty`
--

DROP TABLE IF EXISTS `assettagproperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettagproperty` (
  `tagPropertyId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `tagId` bigint(20) DEFAULT NULL,
  `key_` varchar(75) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tagPropertyId`),
  UNIQUE KEY `IX_2C944354` (`tagId`,`key_`),
  KEY `IX_DFF1F063` (`companyId`),
  KEY `IX_13805BF7` (`companyId`,`key_`),
  KEY `IX_3269E180` (`tagId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettagproperty`
--

LOCK TABLES `assettagproperty` WRITE;
/*!40000 ALTER TABLE `assettagproperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettagproperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_calendars`
--

DROP TABLE IF EXISTS `quartz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` longblob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_calendars`
--

LOCK TABLES `quartz_calendars` WRITE;
/*!40000 ALTER TABLE `quartz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_permissions`
--

DROP TABLE IF EXISTS `users_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_permissions` (
  `userId` bigint(20) NOT NULL,
  `permissionId` bigint(20) NOT NULL,
  PRIMARY KEY (`userId`,`permissionId`),
  KEY `IX_8AE58A91` (`permissionId`),
  KEY `IX_C26AA64D` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_permissions`
--

LOCK TABLES `users_permissions` WRITE;
/*!40000 ALTER TABLE `users_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_orgs`
--

DROP TABLE IF EXISTS `groups_orgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_orgs` (
  `groupId` bigint(20) NOT NULL,
  `organizationId` bigint(20) NOT NULL,
  PRIMARY KEY (`groupId`,`organizationId`),
  KEY `IX_75267DCA` (`groupId`),
  KEY `IX_6BBB7682` (`organizationId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_orgs`
--

LOCK TABLES `groups_orgs` WRITE;
/*!40000 ALTER TABLE `groups_orgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_orgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passwordpolicy`
--

DROP TABLE IF EXISTS `passwordpolicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `passwordpolicy` (
  `passwordPolicyId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `defaultPolicy` tinyint(4) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `changeable` tinyint(4) DEFAULT NULL,
  `changeRequired` tinyint(4) DEFAULT NULL,
  `minAge` bigint(20) DEFAULT NULL,
  `checkSyntax` tinyint(4) DEFAULT NULL,
  `allowDictionaryWords` tinyint(4) DEFAULT NULL,
  `minAlphanumeric` int(11) DEFAULT NULL,
  `minLength` int(11) DEFAULT NULL,
  `minLowerCase` int(11) DEFAULT NULL,
  `minNumbers` int(11) DEFAULT NULL,
  `minSymbols` int(11) DEFAULT NULL,
  `minUpperCase` int(11) DEFAULT NULL,
  `history` tinyint(4) DEFAULT NULL,
  `historyCount` int(11) DEFAULT NULL,
  `expireable` tinyint(4) DEFAULT NULL,
  `maxAge` bigint(20) DEFAULT NULL,
  `warningTime` bigint(20) DEFAULT NULL,
  `graceLimit` int(11) DEFAULT NULL,
  `lockout` tinyint(4) DEFAULT NULL,
  `maxFailure` int(11) DEFAULT NULL,
  `lockoutDuration` bigint(20) DEFAULT NULL,
  `requireUnlock` tinyint(4) DEFAULT NULL,
  `resetFailureCount` bigint(20) DEFAULT NULL,
  `resetTicketMaxAge` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`passwordPolicyId`),
  UNIQUE KEY `IX_3FBFA9F4` (`companyId`,`name`),
  KEY `IX_2C1142E` (`companyId`,`defaultPolicy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passwordpolicy`
--

LOCK TABLES `passwordpolicy` WRITE;
/*!40000 ALTER TABLE `passwordpolicy` DISABLE KEYS */;
INSERT INTO `passwordpolicy` VALUES (10194,10153,10157,'','2012-09-10 08:56:32','2012-09-10 08:56:32',1,'Default Password Policy','Default Password Policy',1,1,0,0,1,0,6,0,1,0,1,0,6,0,8640000,86400,0,0,3,0,1,600,86400);
/*!40000 ALTER TABLE `passwordpolicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailaddress`
--

DROP TABLE IF EXISTS `emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailaddress` (
  `emailAddressId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `address` varchar(75) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `primary_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`emailAddressId`),
  KEY `IX_1BB072CA` (`companyId`),
  KEY `IX_49D2DEC4` (`companyId`,`classNameId`),
  KEY `IX_551A519F` (`companyId`,`classNameId`,`classPK`),
  KEY `IX_2A2CB130` (`companyId`,`classNameId`,`classPK`,`primary_`),
  KEY `IX_7B43CD8` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailaddress`
--

LOCK TABLES `emailaddress` WRITE;
/*!40000 ALTER TABLE `emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfileentrytype`
--

DROP TABLE IF EXISTS `dlfileentrytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfileentrytype` (
  `uuid_` varchar(75) DEFAULT NULL,
  `fileEntryTypeId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`fileEntryTypeId`),
  UNIQUE KEY `IX_E9B6A85B` (`groupId`,`name`),
  UNIQUE KEY `IX_1399D844` (`uuid_`,`groupId`),
  KEY `IX_4501FD9C` (`groupId`),
  KEY `IX_90724726` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfileentrytype`
--

LOCK TABLES `dlfileentrytype` WRITE;
/*!40000 ALTER TABLE `dlfileentrytype` DISABLE KEYS */;
INSERT INTO `dlfileentrytype` VALUES ('ce128511-0eb2-4e3a-9f3e-330a74913e05',0,0,0,0,'','2012-09-10 08:56:27','2012-09-10 08:56:27','Basic Document',''),('452345aa-7ce6-4cf6-ba78-4a6548002c03',10300,10191,10153,10157,'','2012-09-10 08:56:37','2012-09-10 08:56:37','Contract','Legal Contracts'),('f9b6ce1d-3d5a-47f9-875e-ffc5fa6fef85',10302,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38','Marketing Banner','Marketing Banner'),('241ef81a-7550-4bf6-988f-1a6e488e9d0a',10304,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38','Online Training','Online Training'),('b3fe7d43-d1e7-4e7c-9993-f9ee030d4a55',10306,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38','Sales Presentation','Sales Presentation');
/*!40000 ALTER TABLE `dlfileentrytype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `userId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `IX_C19E5F31` (`roleId`),
  KEY `IX_C1A01806` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (10157,10161),(12102,10160),(12102,10163),(12102,10164),(12102,11302),(12102,11524),(16308,10164),(16402,10164),(16402,14610),(16422,10164),(16442,10164),(16442,14613),(16462,10164),(17503,10163),(17503,10164),(17603,10163),(17603,10164);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_`
--

DROP TABLE IF EXISTS `account_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_` (
  `accountId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `parentAccountId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `legalName` varchar(75) DEFAULT NULL,
  `legalId` varchar(75) DEFAULT NULL,
  `legalType` varchar(75) DEFAULT NULL,
  `sicCode` varchar(75) DEFAULT NULL,
  `tickerSymbol` varchar(75) DEFAULT NULL,
  `industry` varchar(75) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `size_` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`accountId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_`
--

LOCK TABLES `account_` WRITE;
/*!40000 ALTER TABLE `account_` DISABLE KEYS */;
INSERT INTO `account_` VALUES (10155,10153,0,'','2012-09-10 08:56:28','2014-03-04 10:55:48',0,'FITMAN Portal','','','','','','','','');
/*!40000 ALTER TABLE `account_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettagstats`
--

DROP TABLE IF EXISTS `assettagstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettagstats` (
  `tagStatsId` bigint(20) NOT NULL,
  `tagId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `assetCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`tagStatsId`),
  UNIQUE KEY `IX_56682CC4` (`tagId`,`classNameId`),
  KEY `IX_50702693` (`classNameId`),
  KEY `IX_9464CA` (`tagId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettagstats`
--

LOCK TABLES `assettagstats` WRITE;
/*!40000 ALTER TABLE `assettagstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettagstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfileentrymetadata`
--

DROP TABLE IF EXISTS `dlfileentrymetadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfileentrymetadata` (
  `uuid_` varchar(75) DEFAULT NULL,
  `fileEntryMetadataId` bigint(20) NOT NULL,
  `DDMStorageId` bigint(20) DEFAULT NULL,
  `DDMStructureId` bigint(20) DEFAULT NULL,
  `fileEntryTypeId` bigint(20) DEFAULT NULL,
  `fileEntryId` bigint(20) DEFAULT NULL,
  `fileVersionId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`fileEntryMetadataId`),
  UNIQUE KEY `IX_7332B44F` (`DDMStructureId`,`fileVersionId`),
  KEY `IX_4F40FE5E` (`fileEntryId`),
  KEY `IX_A44636C9` (`fileEntryId`,`fileVersionId`),
  KEY `IX_F8E90438` (`fileEntryTypeId`),
  KEY `IX_1FE9C04` (`fileVersionId`),
  KEY `IX_D49AB5D1` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfileentrymetadata`
--

LOCK TABLES `dlfileentrymetadata` WRITE;
/*!40000 ALTER TABLE `dlfileentrymetadata` DISABLE KEYS */;
INSERT INTO `dlfileentrymetadata` VALUES ('ef77a7f8-cfff-44a6-af52-f1cc11162bbf',10435,10442,10308,0,10419,10424),('83c44d25-9a44-4494-942b-05a040583956',10461,10462,10308,0,10433,10434),('b0dbbbd3-0f88-47eb-b4d4-1c99477e324a',10467,10468,10308,0,10444,10445),('519cac8c-4229-48d8-bdd4-69bd28c68b66',10478,10480,10308,0,10452,10453),('b9179592-828c-491a-8d28-404616d964cd',10489,10490,10308,0,10465,10466),('09fa1730-3fba-4b6a-a973-2c199ce7cf27',10501,10502,10308,0,10477,10479),('dc2620e4-3811-424b-bd6c-9d6c05fe9d83',10513,10514,10308,0,10493,10494),('74d7f651-ec27-4d39-8ea6-1d2f1b361a99',10519,10520,10308,0,10505,10506),('0978d995-e52e-40f6-ad62-c50c968fdd00',10529,10532,10308,0,10517,10518),('6b6b2229-79dc-4785-9cfd-c04b58e87785',10541,10544,10308,0,10530,10531),('42e251a3-411b-4514-bf11-764fe8226ceb',10554,10556,10308,0,10542,10543),('552ca2e5-4ce4-42e4-97a8-ee52f36c51ca',10565,10568,10308,0,10553,10555),('6fabd072-4127-4ba5-8ea2-13567af72858',10577,10578,10308,0,10566,10567),('3a3be80e-2e3c-4992-9c2a-5c00a403b14f',11629,11648,10308,0,11613,11614),('7faf77a7-3bf1-4664-a3dc-dcc08139c4d4',11657,11663,10308,0,11621,11622),('812dbda3-415c-4436-8f5a-aa158b44053b',11677,11678,10308,0,11630,11631),('ab3d79ea-6fdf-447b-9561-07ba0daf6dd0',11683,11684,10308,0,11638,11639),('1f46ea47-cf5f-4193-b4f3-92018be602b7',11690,11691,10308,0,11646,11647),('0f8c57d5-bb43-4061-85d1-f59f957f3429',11694,11695,10308,0,11658,11659),('50b746a8-7a7d-4e76-b820-aa08ac61fb52',11698,11699,10308,0,11669,11670),('e865f35e-4cc3-4cc4-870a-e6672a5bc109',13127,13128,10308,0,13119,13120),('8f697f30-9851-4dc3-a8a0-a11d13c86e41',13144,13145,10308,0,13136,13137),('671a7de1-0d4c-4b7e-98e5-4a4c033f5461',13160,13161,10308,0,13152,13153),('198b61ca-9f6b-42cc-803e-0129e462703c',13195,13196,10308,0,13187,13188),('a585f157-398c-48bb-be26-8b811586059b',13284,13285,10308,0,13276,13277),('c91c27b8-6f19-4fdf-a9c5-7b61e2b4455f',13355,13356,10308,0,13347,13348),('77b5b493-0e29-4963-bc56-22198515e539',15306,15307,10308,0,15298,15299),('a24182a4-9b88-4be0-b8ce-b40f0ce2ad0a',18309,18310,10308,0,18301,18302);
/*!40000 ALTER TABLE `dlfileentrymetadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingitem`
--

DROP TABLE IF EXISTS `shoppingitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingitem` (
  `itemId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `categoryId` bigint(20) DEFAULT NULL,
  `sku` varchar(75) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` longtext,
  `properties` longtext,
  `fields_` tinyint(4) DEFAULT NULL,
  `fieldsQuantities` longtext,
  `minQuantity` int(11) DEFAULT NULL,
  `maxQuantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `taxable` tinyint(4) DEFAULT NULL,
  `shipping` double DEFAULT NULL,
  `useShippingFormula` tinyint(4) DEFAULT NULL,
  `requiresShipping` tinyint(4) DEFAULT NULL,
  `stockQuantity` int(11) DEFAULT NULL,
  `featured_` tinyint(4) DEFAULT NULL,
  `sale_` tinyint(4) DEFAULT NULL,
  `smallImage` tinyint(4) DEFAULT NULL,
  `smallImageId` bigint(20) DEFAULT NULL,
  `smallImageURL` longtext,
  `mediumImage` tinyint(4) DEFAULT NULL,
  `mediumImageId` bigint(20) DEFAULT NULL,
  `mediumImageURL` longtext,
  `largeImage` tinyint(4) DEFAULT NULL,
  `largeImageId` bigint(20) DEFAULT NULL,
  `largeImageURL` longtext,
  PRIMARY KEY (`itemId`),
  UNIQUE KEY `IX_1C717CA6` (`companyId`,`sku`),
  KEY `IX_FEFE7D76` (`groupId`,`categoryId`),
  KEY `IX_903DC750` (`largeImageId`),
  KEY `IX_D217AB30` (`mediumImageId`),
  KEY `IX_FF203304` (`smallImageId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingitem`
--

LOCK TABLES `shoppingitem` WRITE;
/*!40000 ALTER TABLE `shoppingitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website`
--

DROP TABLE IF EXISTS `website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `website` (
  `websiteId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `url` longtext,
  `typeId` int(11) DEFAULT NULL,
  `primary_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`websiteId`),
  KEY `IX_96F07007` (`companyId`),
  KEY `IX_4F0F0CA7` (`companyId`,`classNameId`),
  KEY `IX_F960131C` (`companyId`,`classNameId`,`classPK`),
  KEY `IX_1AA07A6D` (`companyId`,`classNameId`,`classPK`,`primary_`),
  KEY `IX_F75690BB` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website`
--

LOCK TABLES `website` WRITE;
/*!40000 ALTER TABLE `website` DISABLE KEYS */;
/*!40000 ALTER TABLE `website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membershiprequest`
--

DROP TABLE IF EXISTS `membershiprequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membershiprequest` (
  `membershipRequestId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `comments` longtext,
  `replyComments` longtext,
  `replyDate` datetime DEFAULT NULL,
  `replierUserId` bigint(20) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  PRIMARY KEY (`membershipRequestId`),
  KEY `IX_8A1CC4B` (`groupId`),
  KEY `IX_C28C72EC` (`groupId`,`statusId`),
  KEY `IX_35AA8FA6` (`groupId`,`userId`,`statusId`),
  KEY `IX_66D70879` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membershiprequest`
--

LOCK TABLES `membershiprequest` WRITE;
/*!40000 ALTER TABLE `membershiprequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `membershiprequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbmessage`
--

DROP TABLE IF EXISTS `mbmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbmessage` (
  `uuid_` varchar(75) DEFAULT NULL,
  `messageId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `categoryId` bigint(20) DEFAULT NULL,
  `threadId` bigint(20) DEFAULT NULL,
  `rootMessageId` bigint(20) DEFAULT NULL,
  `parentMessageId` bigint(20) DEFAULT NULL,
  `subject` varchar(75) DEFAULT NULL,
  `body` longtext,
  `format` varchar(75) DEFAULT NULL,
  `attachments` tinyint(4) DEFAULT NULL,
  `anonymous` tinyint(4) DEFAULT NULL,
  `priority` double DEFAULT NULL,
  `allowPingbacks` tinyint(4) DEFAULT NULL,
  `answer` tinyint(4) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`messageId`),
  UNIQUE KEY `IX_8D12316E` (`uuid_`,`groupId`),
  KEY `IX_51A8D44D` (`classNameId`,`classPK`),
  KEY `IX_F6687633` (`classNameId`,`classPK`,`status`),
  KEY `IX_B1432D30` (`companyId`),
  KEY `IX_1AD93C16` (`companyId`,`status`),
  KEY `IX_5B153FB2` (`groupId`),
  KEY `IX_1073AB9F` (`groupId`,`categoryId`),
  KEY `IX_4257DB85` (`groupId`,`categoryId`,`status`),
  KEY `IX_B674AB58` (`groupId`,`categoryId`,`threadId`),
  KEY `IX_CBFDBF0A` (`groupId`,`categoryId`,`threadId`,`answer`),
  KEY `IX_385E123E` (`groupId`,`categoryId`,`threadId`,`status`),
  KEY `IX_ED39AC98` (`groupId`,`status`),
  KEY `IX_8EB8C5EC` (`groupId`,`userId`),
  KEY `IX_377858D2` (`groupId`,`userId`,`status`),
  KEY `IX_75B95071` (`threadId`),
  KEY `IX_9D7C3B23` (`threadId`,`answer`),
  KEY `IX_A7038CD7` (`threadId`,`parentMessageId`),
  KEY `IX_9DC8E57` (`threadId`,`status`),
  KEY `IX_7A040C32` (`userId`),
  KEY `IX_59F9CE5C` (`userId`,`classNameId`),
  KEY `IX_ABEB6D07` (`userId`,`classNameId`,`classPK`),
  KEY `IX_4A4BB4ED` (`userId`,`classNameId`,`classPK`,`status`),
  KEY `IX_3321F142` (`userId`,`classNameId`,`status`),
  KEY `IX_C57B16BC` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbmessage`
--

LOCK TABLES `mbmessage` WRITE;
/*!40000 ALTER TABLE `mbmessage` DISABLE KEYS */;
INSERT INTO `mbmessage` VALUES ('0b9d6f2d-57ea-41f0-9457-27437ac641f8',10175,10171,10153,10157,'','2012-09-10 08:56:28','2012-09-10 08:56:28',10002,10174,-1,10176,10175,0,'10174','10174','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:30'),('a4d10364-c621-45d9-b908-c197eae636f6',10314,10310,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38',10002,10313,-1,10315,10314,0,'10313','10313','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:38'),('2c515e4a-475f-43ee-b845-2f1692e0f08f',10324,10320,10153,10157,'','2012-09-10 08:56:39','2012-09-10 08:56:39',10002,10323,-1,10325,10324,0,'10323','10323','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:39'),('8cd658de-d5ef-40c1-90cb-6b272412015f',10333,10329,10153,10157,'','2012-09-10 08:56:39','2012-09-10 08:56:39',10002,10332,-1,10334,10333,0,'10332','10332','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:39'),('30aa2add-c068-47c8-912a-bb0d70587bf8',10347,10338,10153,10157,'','2012-09-10 08:56:45','2012-09-10 08:56:45',10002,10346,-1,10348,10347,0,'10346','10346','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:45'),('8f423061-446f-4c7d-b522-35ac8326e5a2',10353,10338,10153,10157,'','2012-09-10 08:56:45','2012-09-10 08:56:45',10002,10352,-1,10354,10353,0,'10352','10352','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:45'),('f0dd6772-164f-4c12-a04c-e2490306fb6a',10359,10338,10153,10157,'','2012-09-10 08:56:45','2012-09-10 08:56:45',10002,10358,-1,10360,10359,0,'10358','10358','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:45'),('cda5718c-a96c-4de4-96bb-c48dc8047712',10373,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10002,10372,-1,10374,10373,0,'10372','10372','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:46'),('6df5d5c4-44c2-4acc-a62e-e8a10033feb4',10381,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10002,10380,-1,10382,10381,0,'10380','10380','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:46'),('8ef3b62e-c426-47ba-acab-bd6b1a31c295',10387,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10002,10386,-1,10388,10387,0,'10386','10386','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:46'),('0f45fefc-4d59-48d9-9c09-b984eb37722f',10393,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10002,10392,-1,10394,10393,0,'10392','10392','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:46'),('caaadc21-a70c-4145-8d02-8f67ae8c4bea',10427,10179,10153,10157,'','2012-09-10 08:56:54','2012-09-10 08:56:54',10010,10419,-1,10428,10427,0,'10419','10419','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:54'),('a47f8bc9-7fc6-4557-a294-9b4eed8f8d0c',10437,10179,10153,10157,'','2012-09-10 08:56:55','2012-09-10 08:56:55',10010,10433,-1,10438,10437,0,'10433','10433','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:55'),('0baffd11-8b46-43c5-ba63-0acc110208ca',10447,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10010,10444,-1,10448,10447,0,'10444','10444','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:56'),('4dba900f-65d2-4648-9f3c-c423515dc512',10456,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10010,10452,-1,10457,10456,0,'10452','10452','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:56'),('de2d682a-494f-426c-a8d2-8887b97af335',10472,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10010,10465,-1,10473,10472,0,'10465','10465','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:57'),('75d9b05b-0135-43cf-bf5d-b0394e66b309',10484,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10010,10477,-1,10485,10484,0,'10477','10477','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:57'),('2f26e317-f5c5-47b0-90dc-8b6cdbbe4b8f',10496,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10010,10493,-1,10497,10496,0,'10493','10493','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:57'),('5c63da0d-56ea-4e19-bb2f-34a62b177532',10508,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10010,10505,-1,10509,10508,0,'10505','10505','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:58'),('0b26b96d-6214-4b93-85a4-af51c3e64f83',10524,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10010,10517,-1,10525,10524,0,'10517','10517','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:58'),('58b4d5bb-68fd-4b90-9e3f-8115c5e15f22',10536,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10530,-1,10537,10536,0,'10530','10530','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:59'),('5e623edd-785e-472c-b7d0-57de0965868c',10548,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10542,-1,10549,10548,0,'10542','10542','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:59'),('e9491e11-4ed2-4b7d-9e29-85a07882c772',10560,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10553,-1,10561,10560,0,'10553','10553','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:59'),('4647e70c-57fe-431a-a7de-270ebd37136b',10572,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10566,-1,10573,10572,0,'10566','10566','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:56:59'),('b89f9d9e-b294-4953-a972-098941ec66ed',10585,10179,10153,10157,'','2012-09-10 08:57:00','2012-09-10 08:57:00',10108,10582,-1,10586,10585,0,'10582','10582','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:57:00'),('c8c23e32-51eb-41ed-ae79-defd4c08570b',10599,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10108,10596,-1,10600,10599,0,'10596','10596','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:57:01'),('b1e96876-0a45-4d99-89fd-10967952071f',10607,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10108,10604,-1,10608,10607,0,'10604','10604','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:57:01'),('77a588a7-7edd-4098-aabc-b685811b807c',10612,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10002,10611,-1,10613,10612,0,'10611','10611','bbcode',0,1,0,0,0,0,10157,'','2012-09-10 08:57:01'),('b9f28045-219b-4318-80c1-64bd87966ba6',18107,10179,10153,12102,'Admin Admin','2014-01-03 11:22:06','2014-01-03 11:22:06',10002,18106,-1,18108,18107,0,'18106','18106','bbcode',0,0,0,0,0,0,12102,'Admin Admin','2014-01-03 11:22:06'),('240c693e-d00d-4e45-96a1-702707bfe4a0',18112,10179,10153,12102,'Admin Admin','2014-01-03 11:22:46','2014-01-03 11:22:46',10002,18111,-1,18113,18112,0,'18111','18111','bbcode',0,0,0,0,0,0,12102,'Admin Admin','2014-01-03 11:22:46'),('9d55e46f-bf10-45a9-add8-5fce26479e9a',11503,10179,10153,10195,'Test Test','2012-09-26 09:52:15','2012-09-26 09:52:15',10002,11502,-1,11504,11503,0,'11502','11502','bbcode',0,0,0,0,0,0,10195,'Test Test','2012-09-26 09:52:16'),('e9c2a481-a924-45b6-a3b3-5c5d56b1d1ba',18304,10191,10153,12102,'Admin Admin','2014-03-04 08:49:43','2014-03-04 08:49:43',10010,18301,-1,18305,18304,0,'18301','18301','bbcode',0,0,0,0,0,0,12102,'Admin Admin','2014-03-04 08:49:43'),('9a537ff1-6c5b-4970-a3b8-61bf97bcd4b2',11616,11605,10153,10157,'','2012-09-26 15:45:39','2012-09-26 15:45:39',10010,11613,-1,11617,11616,0,'11613','11613','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:39'),('d9e80adf-27a0-4918-92f3-a6755e175f67',11624,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',10010,11621,-1,11625,11624,0,'11621','11621','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:40'),('eb0ec6aa-98b8-4bc7-88aa-291c36644262',11633,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',10010,11630,-1,11634,11633,0,'11630','11630','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:40'),('edc809ca-3b46-4e4f-bede-d7a4c78ecba8',11641,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',10010,11638,-1,11642,11641,0,'11638','11638','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:41'),('388367fe-c83a-4716-9ce7-4a7b2ea02056',11651,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',10010,11646,-1,11652,11651,0,'11646','11646','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:41'),('bedd8adb-1d54-4fb7-9f1f-d1cd6fb9b1a6',11661,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',10010,11658,-1,11662,11661,0,'11658','11658','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:42'),('e6f86b61-0253-4b40-b9e6-a15f14597d9a',11672,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',10010,11669,-1,11673,11672,0,'11669','11669','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:42'),('c5860997-007f-478a-8b28-14d9f07bcc57',11706,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10108,11703,-1,11707,11706,0,'11703','11703','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:44'),('cf57f0a2-c57e-4699-9493-66152fe6284c',11720,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10108,11717,-1,11721,11720,0,'11717','11717','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:44'),('20b2fb15-df9f-430c-bcb6-141893e54a41',11728,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10108,11725,-1,11729,11728,0,'11725','11725','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:44'),('909c194e-e41c-42ee-aaff-87de67346657',11736,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10108,11733,-1,11737,11736,0,'11733','11733','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:45'),('d30b9533-a204-49b2-ac54-ee811b6ae19e',11747,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10108,11744,-1,11748,11747,0,'11744','11744','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:45'),('a5483515-66ad-4ffe-b7d3-2a848af3b1bd',11760,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10108,11755,-1,11761,11760,0,'11755','11755','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:45'),('67bb51d3-b115-4f46-9cb3-71ed6724ab71',11775,11605,10153,10157,'','2012-09-26 15:45:46','2012-09-26 15:45:46',10108,11772,-1,11776,11775,0,'11772','11772','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:46'),('671d1b6d-fb23-4b2e-921c-6451db017a36',11780,11605,10153,10157,'','2012-09-26 15:45:48','2012-09-26 15:45:48',10002,11779,-1,11781,11780,0,'11779','11779','bbcode',0,1,0,0,0,0,10157,'','2012-09-26 15:45:48'),('d1572ca2-bca8-4e09-9154-0a48df2b94d6',11808,10179,10153,10195,'Test Test','2012-09-27 08:55:18','2012-09-27 08:55:18',10108,11805,-1,11809,11808,0,'11805','11805','bbcode',0,0,0,0,0,0,10195,'Test Test','2012-09-27 08:55:18'),('8c81d1b9-e899-4411-b08d-dbd44731b28c',12112,12104,10153,12102,'Admin Amin','2012-10-04 14:56:41','2012-10-04 14:56:41',10002,12111,-1,12113,12112,0,'12111','12111','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-10-04 14:56:41'),('8fe13f3b-5907-4a96-bb3c-9f927564eb24',12117,12104,10153,12102,'Admin Amin','2012-10-04 14:56:41','2012-10-04 14:56:41',10002,12116,-1,12118,12117,0,'12116','12116','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-10-04 14:56:41'),('228b7711-e887-4711-98c5-f3197841a832',13122,10191,10153,12102,'Admin Amin','2012-11-29 11:49:59','2012-11-29 11:49:59',10010,13119,-1,13123,13122,0,'13119','13119','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 11:49:59'),('e35c0bc9-93e9-48e3-9bda-4ac1c5421183',13139,10191,10153,12102,'Admin Amin','2012-11-29 11:57:31','2012-11-29 11:57:31',10010,13136,-1,13140,13139,0,'13136','13136','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 11:57:31'),('e978a26a-53a8-47b5-ba58-f872ddb238b9',13155,10191,10153,12102,'Admin Amin','2012-11-29 12:09:56','2012-11-29 12:09:56',10010,13152,-1,13156,13155,0,'13152','13152','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 12:09:56'),('7c497b7a-be0f-4881-aa22-6970b38bf790',13175,10179,10153,12102,'Admin Amin','2012-11-29 13:38:24','2012-11-29 13:38:24',10108,13172,-1,13176,13175,0,'13172','13172','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 13:38:24'),('b9c5368b-9f58-4a80-946b-7d2ae33f08e7',13190,10191,10153,12102,'Admin Amin','2012-11-29 13:58:27','2012-11-29 13:58:27',10010,13187,-1,13191,13190,0,'13187','13187','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 13:58:27'),('12697732-3368-4dc3-a2ca-40dfd8bd8ed3',13279,10191,10153,12102,'Admin Amin','2012-11-29 14:28:41','2012-11-29 14:28:41',10010,13276,-1,13280,13279,0,'13276','13276','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 14:28:41'),('244cc0ba-5f38-4801-beff-e14f4de49336',13313,10179,10153,12102,'Admin Amin','2012-11-29 14:30:26','2012-11-29 14:30:26',10108,13310,-1,13314,13313,0,'13310','13310','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 14:30:26'),('f239f5e0-2b4f-4759-bc2b-734c3afed345',13350,10191,10153,12102,'Admin Amin','2012-11-29 14:36:17','2012-11-29 14:36:17',10010,13347,-1,13351,13350,0,'13347','13347','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2012-11-29 14:36:17'),('b90a270d-c222-41db-abab-1e2ea93bcddd',14102,10179,10153,12102,'Admin Amin','2013-04-03 10:51:46','2013-04-03 10:51:46',10002,14101,-1,14103,14102,0,'14101','14101','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-04-03 10:51:46'),('145577d0-21b6-4c89-9c36-2533aa306a50',15225,10179,10153,12102,'Admin Amin','2013-05-10 08:47:02','2013-05-10 08:47:02',10108,15222,-1,15226,15225,0,'15222','15222','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 08:47:02'),('f08f5f68-e8b2-4863-88f4-63de1ed73de6',15235,10179,10153,12102,'Admin Amin','2013-05-10 08:47:07','2013-05-10 08:47:07',10108,15232,-1,15236,15235,0,'15232','15232','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 08:47:07'),('a15178e9-d4f4-48dc-a4ce-616f394627ae',15245,10179,10153,12102,'Admin Amin','2013-05-10 08:47:15','2013-05-10 08:47:15',10108,15242,-1,15246,15245,0,'15242','15242','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 08:47:15'),('e223480c-4b5f-4066-83e0-457a07adfb65',15255,10179,10153,12102,'Admin Amin','2013-05-10 08:47:25','2013-05-10 08:47:25',10108,15252,-1,15256,15255,0,'15252','15252','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 08:47:25'),('e760e790-c17d-4be7-b95d-130e5ae649f8',18102,10179,10153,12102,'Admin Admin','2014-01-03 11:21:41','2014-01-03 11:21:41',10002,18101,-1,18103,18102,0,'18101','18101','bbcode',0,0,0,0,0,0,12102,'Admin Admin','2014-01-03 11:21:41'),('90870fac-f851-4f6c-a497-df6a6436d4c3',15301,10191,10153,12102,'Admin Amin','2013-05-10 13:38:58','2013-05-10 13:38:58',10010,15298,-1,15302,15301,0,'15298','15298','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:38:58'),('af4486c7-ac79-4ca9-b393-1ccbb604f910',15316,10179,10153,12102,'Admin Amin','2013-05-10 13:39:27','2013-05-10 13:39:27',10108,15313,-1,15317,15316,0,'15313','15313','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:39:27'),('68ddd62a-f8eb-494f-982d-98e93277399c',15326,10179,10153,12102,'Admin Amin','2013-05-10 13:41:54','2013-05-10 13:41:54',10108,15323,-1,15327,15326,0,'15323','15323','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:41:54'),('1dbb92ba-dcda-42af-a7ac-c70a2ae74a71',15336,10179,10153,12102,'Admin Amin','2013-05-10 13:42:02','2013-05-10 13:42:02',10108,15333,-1,15337,15336,0,'15333','15333','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:42:02'),('b5269c1d-231c-47a4-9acd-844e9df1007f',15346,10179,10153,12102,'Admin Amin','2013-05-10 13:55:31','2013-05-10 13:55:31',10108,15343,-1,15347,15346,0,'15343','15343','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:55:31'),('48aebf7d-61f6-49e4-a81e-8e20ace490ad',15356,10179,10153,12102,'Admin Amin','2013-05-10 13:56:28','2013-05-10 13:56:28',10108,15353,-1,15357,15356,0,'15353','15353','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:56:28'),('3f67d40d-f8aa-448f-ade1-5a172bf0cb6d',15366,10179,10153,12102,'Admin Amin','2013-05-10 13:56:31','2013-05-10 13:56:31',10108,15363,-1,15367,15366,0,'15363','15363','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:56:31'),('5fbb1747-a493-4516-bd8c-1e0ef1be585e',15378,10179,10153,12102,'Admin Amin','2013-05-10 13:57:47','2013-05-10 13:57:47',10108,15375,-1,15379,15378,0,'15375','15375','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:57:47'),('43e2e979-3e67-4170-836b-155aa4083dac',15388,10179,10153,12102,'Admin Amin','2013-05-10 13:59:38','2013-05-10 13:59:38',10108,15385,-1,15389,15388,0,'15385','15385','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 13:59:38'),('12753dee-e784-4252-b367-92b5204a93f3',15403,10179,10153,12102,'Admin Amin','2013-05-10 14:09:26','2013-05-10 14:09:26',10108,15400,-1,15404,15403,0,'15400','15400','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-05-10 14:09:26'),('3c79277c-649b-4d5d-b60d-79084f191a5c',16318,16310,10153,16308,'msee_guest','2013-11-15 10:35:33','2013-11-15 10:35:33',10002,16317,-1,16319,16318,0,'16317','16317','bbcode',0,0,0,0,0,0,16308,'msee_guest','2013-11-15 10:35:33'),('78775d50-fdd7-455c-bd9b-8b97f4ff74dc',16323,16310,10153,16308,'msee_guest','2013-11-15 10:35:33','2013-11-15 10:35:33',10002,16322,-1,16324,16323,0,'16322','16322','bbcode',0,0,0,0,0,0,16308,'msee_guest','2013-11-15 10:35:33'),('b21e36d0-2b35-4f69-90c0-ce0dbe3530b3',16412,16404,10153,16402,'MSEE Admin','2013-11-18 15:32:47','2013-11-18 15:32:47',10002,16411,-1,16413,16412,0,'16411','16411','bbcode',0,0,0,0,0,0,16402,'MSEE Admin','2013-11-18 15:32:47'),('79a31e1a-72b9-4b35-a4d2-e7dadd85a55d',16417,16404,10153,16402,'MSEE Admin','2013-11-18 15:32:47','2013-11-18 15:32:47',10002,16416,-1,16418,16417,0,'16416','16416','bbcode',0,0,0,0,0,0,16402,'MSEE Admin','2013-11-18 15:32:47'),('481994c4-2a2c-45c3-8e6f-ed6b4061d614',16432,16424,10153,16422,'MSEE Admin','2013-11-18 15:34:35','2013-11-18 15:34:35',10002,16431,-1,16433,16432,0,'16431','16431','bbcode',0,0,0,0,0,0,16422,'MSEE Admin','2013-11-18 15:34:35'),('07c78234-de67-482b-b0df-cef4ecd353ea',16437,16424,10153,16422,'MSEE Admin','2013-11-18 15:34:35','2013-11-18 15:34:35',10002,16436,-1,16438,16437,0,'16436','16436','bbcode',0,0,0,0,0,0,16422,'MSEE Admin','2013-11-18 15:34:35'),('14a2f3ab-7ebc-4fdd-bf9f-e432856c8be3',16452,16444,10153,16442,'MSEE Employee','2013-11-18 15:37:19','2013-11-18 15:37:19',10002,16451,-1,16453,16452,0,'16451','16451','bbcode',0,0,0,0,0,0,16442,'MSEE Employee','2013-11-18 15:37:19'),('34a875e5-2860-4c49-8441-0f672241aa06',16457,16444,10153,16442,'MSEE Employee','2013-11-18 15:37:19','2013-11-18 15:37:19',10002,16456,-1,16458,16457,0,'16456','16456','bbcode',0,0,0,0,0,0,16442,'MSEE Employee','2013-11-18 15:37:19'),('ee2ad320-91cf-4849-95d9-72807bdbd9ca',16472,16464,10153,16462,'MSEE Itexpert','2013-11-18 15:39:15','2013-11-18 15:39:15',10002,16471,-1,16473,16472,0,'16471','16471','bbcode',0,0,0,0,0,0,16462,'MSEE Itexpert','2013-11-18 15:39:15'),('1e1bf318-7949-4bc8-bf1c-c6900cc35a65',16477,16464,10153,16462,'MSEE Itexpert','2013-11-18 15:39:15','2013-11-18 15:39:15',10002,16476,-1,16478,16477,0,'16476','16476','bbcode',0,0,0,0,0,0,16462,'MSEE Itexpert','2013-11-18 15:39:15'),('a42503d7-8119-4412-b1d6-6709b0b166d0',16483,10179,10153,12102,'Admin Amin','2013-11-19 13:24:22','2013-11-19 13:24:22',10002,16482,-1,16484,16483,0,'16482','16482','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-11-19 13:24:22'),('4a36bde3-eb8f-439a-9cea-3da3a5eda85e',16488,10179,10153,12102,'Admin Amin','2013-11-19 13:25:18','2013-11-19 13:25:18',10002,16487,-1,16489,16488,0,'16487','16487','bbcode',0,0,0,0,0,0,12102,'Admin Amin','2013-11-19 13:25:18');
/*!40000 ALTER TABLE `mbmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialactivitysetting`
--

DROP TABLE IF EXISTS `socialactivitysetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialactivitysetting` (
  `activitySettingId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `activityType` int(11) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`activitySettingId`),
  KEY `IX_384788CD` (`groupId`,`activityType`),
  KEY `IX_1E9CF33B` (`groupId`,`classNameId`,`activityType`),
  KEY `IX_D984AABA` (`groupId`,`classNameId`,`activityType`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialactivitysetting`
--

LOCK TABLES `socialactivitysetting` WRITE;
/*!40000 ALTER TABLE `socialactivitysetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialactivitysetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `companyId` bigint(20) NOT NULL,
  `accountId` bigint(20) DEFAULT NULL,
  `webId` varchar(75) DEFAULT NULL,
  `key_` longtext,
  `mx` varchar(75) DEFAULT NULL,
  `homeURL` longtext,
  `logoId` bigint(20) DEFAULT NULL,
  `system` tinyint(4) DEFAULT NULL,
  `maxUsers` int(11) DEFAULT NULL,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`companyId`),
  UNIQUE KEY `IX_EC00543C` (`webId`),
  KEY `IX_38EFE3FD` (`logoId`),
  KEY `IX_12566EC2` (`mx`),
  KEY `IX_35E3E7C6` (`system`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (10153,10155,'liferay.com','rO0ABXNyABRqYXZhLnNlY3VyaXR5LktleVJlcL35T7OImqVDAgAETAAJYWxnb3JpdGhtdAASTGphdmEvbGFuZy9TdHJpbmc7WwAHZW5jb2RlZHQAAltCTAAGZm9ybWF0cQB+AAFMAAR0eXBldAAbTGphdmEvc2VjdXJpdHkvS2V5UmVwJFR5cGU7eHB0AANERVN1cgACW0Ks8xf4BghU4AIAAHhwAAAACBA40Ix6KaK1dAADUkFXfnIAGWphdmEuc2VjdXJpdHkuS2V5UmVwJFR5cGUAAAAAAAAAABIAAHhyAA5qYXZhLmxhbmcuRW51bQAAAAAAAAAAEgAAeHB0AAZTRUNSRVQ=','liferay.com','',0,0,0,1);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbstatsuser`
--

DROP TABLE IF EXISTS `mbstatsuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbstatsuser` (
  `statsUserId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `messageCount` int(11) DEFAULT NULL,
  `lastPostDate` datetime DEFAULT NULL,
  PRIMARY KEY (`statsUserId`),
  UNIQUE KEY `IX_9168E2C9` (`groupId`,`userId`),
  KEY `IX_A00A898F` (`groupId`),
  KEY `IX_D33A5445` (`groupId`,`userId`,`messageCount`),
  KEY `IX_847F92B5` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbstatsuser`
--

LOCK TABLES `mbstatsuser` WRITE;
/*!40000 ALTER TABLE `mbstatsuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `mbstatsuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_`
--

DROP TABLE IF EXISTS `organization_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_` (
  `organizationId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `parentOrganizationId` bigint(20) DEFAULT NULL,
  `treePath` longtext,
  `name` varchar(100) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `recursable` tinyint(4) DEFAULT NULL,
  `regionId` bigint(20) DEFAULT NULL,
  `countryId` bigint(20) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `comments` longtext,
  PRIMARY KEY (`organizationId`),
  UNIQUE KEY `IX_E301BDF5` (`companyId`,`name`),
  KEY `IX_834BCEB6` (`companyId`),
  KEY `IX_418E4522` (`companyId`,`parentOrganizationId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_`
--

LOCK TABLES `organization_` WRITE;
/*!40000 ALTER TABLE `organization_` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wikinode`
--

DROP TABLE IF EXISTS `wikinode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wikinode` (
  `uuid_` varchar(75) DEFAULT NULL,
  `nodeId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `lastPostDate` datetime DEFAULT NULL,
  PRIMARY KEY (`nodeId`),
  UNIQUE KEY `IX_920CD8B1` (`groupId`,`name`),
  UNIQUE KEY `IX_7609B2AE` (`uuid_`,`groupId`),
  KEY `IX_5D6FE3F0` (`companyId`),
  KEY `IX_B480A672` (`groupId`),
  KEY `IX_6C112D7C` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wikinode`
--

LOCK TABLES `wikinode` WRITE;
/*!40000 ALTER TABLE `wikinode` DISABLE KEYS */;
INSERT INTO `wikinode` VALUES ('aa68a9cb-64f4-4037-a8b2-b2dee93228c7',17502,10179,10153,10157,'','2013-12-19 15:27:16','2013-12-19 15:27:16','Main','',NULL);
/*!40000 ALTER TABLE `wikinode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone` (
  `phoneId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `number_` varchar(75) DEFAULT NULL,
  `extension` varchar(75) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `primary_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`phoneId`),
  KEY `IX_9F704A14` (`companyId`),
  KEY `IX_A2E4AFBA` (`companyId`,`classNameId`),
  KEY `IX_9A53569` (`companyId`,`classNameId`,`classPK`),
  KEY `IX_812CE07A` (`companyId`,`classNameId`,`classPK`,`primary_`),
  KEY `IX_F202B9CE` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calevent`
--

DROP TABLE IF EXISTS `calevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calevent` (
  `uuid_` varchar(75) DEFAULT NULL,
  `eventId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `title` varchar(75) DEFAULT NULL,
  `description` longtext,
  `location` longtext,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `durationHour` int(11) DEFAULT NULL,
  `durationMinute` int(11) DEFAULT NULL,
  `allDay` tinyint(4) DEFAULT NULL,
  `timeZoneSensitive` tinyint(4) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `repeating` tinyint(4) DEFAULT NULL,
  `recurrence` longtext,
  `remindBy` int(11) DEFAULT NULL,
  `firstReminder` int(11) DEFAULT NULL,
  `secondReminder` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventId`),
  UNIQUE KEY `IX_5CCE79C8` (`uuid_`,`groupId`),
  KEY `IX_D6FD9496` (`companyId`),
  KEY `IX_12EE4898` (`groupId`),
  KEY `IX_4FDDD2BF` (`groupId`,`repeating`),
  KEY `IX_FCD7C63D` (`groupId`,`type_`),
  KEY `IX_FD93CBFA` (`groupId`,`type_`,`repeating`),
  KEY `IX_F6006202` (`remindBy`),
  KEY `IX_C1AD2122` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calevent`
--

LOCK TABLES `calevent` WRITE;
/*!40000 ALTER TABLE `calevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `calevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratingsentry`
--

DROP TABLE IF EXISTS `ratingsentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratingsentry` (
  `entryId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `score` double DEFAULT NULL,
  PRIMARY KEY (`entryId`),
  UNIQUE KEY `IX_B47E3C11` (`userId`,`classNameId`,`classPK`),
  KEY `IX_16184D57` (`classNameId`,`classPK`),
  KEY `IX_A1A8CB8B` (`classNameId`,`classPK`,`score`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratingsentry`
--

LOCK TABLES `ratingsentry` WRITE;
/*!40000 ALTER TABLE `ratingsentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratingsentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialrelation`
--

DROP TABLE IF EXISTS `socialrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialrelation` (
  `uuid_` varchar(75) DEFAULT NULL,
  `relationId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` bigint(20) DEFAULT NULL,
  `userId1` bigint(20) DEFAULT NULL,
  `userId2` bigint(20) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  PRIMARY KEY (`relationId`),
  UNIQUE KEY `IX_12A92145` (`userId1`,`userId2`,`type_`),
  KEY `IX_61171E99` (`companyId`),
  KEY `IX_95135D1C` (`companyId`,`type_`),
  KEY `IX_C31A64C6` (`type_`),
  KEY `IX_5A40CDCC` (`userId1`),
  KEY `IX_4B52BE89` (`userId1`,`type_`),
  KEY `IX_B5C9C690` (`userId1`,`userId2`),
  KEY `IX_5A40D18D` (`userId2`),
  KEY `IX_3F9C2FA8` (`userId2`,`type_`),
  KEY `IX_F0CA24A5` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialrelation`
--

LOCK TABLES `socialrelation` WRITE;
/*!40000 ALTER TABLE `socialrelation` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialrelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classname_`
--

DROP TABLE IF EXISTS `classname_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classname_` (
  `classNameId` bigint(20) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`classNameId`),
  UNIQUE KEY `IX_B27A301F` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classname_`
--

LOCK TABLES `classname_` WRITE;
/*!40000 ALTER TABLE `classname_` DISABLE KEYS */;
INSERT INTO `classname_` VALUES (10014,'com.liferay.counter.model.Counter'),(10408,'com.liferay.marketplace.model.App'),(10409,'com.liferay.marketplace.model.Module'),(10015,'com.liferay.portal.kernel.workflow.WorkflowTask'),(10016,'com.liferay.portal.model.Account'),(10017,'com.liferay.portal.model.Address'),(10018,'com.liferay.portal.model.BrowserTracker'),(10019,'com.liferay.portal.model.ClassName'),(10020,'com.liferay.portal.model.ClusterGroup'),(10021,'com.liferay.portal.model.Company'),(10022,'com.liferay.portal.model.Contact'),(10023,'com.liferay.portal.model.Country'),(10024,'com.liferay.portal.model.EmailAddress'),(10001,'com.liferay.portal.model.Group'),(10025,'com.liferay.portal.model.Image'),(10002,'com.liferay.portal.model.Layout'),(10026,'com.liferay.portal.model.LayoutBranch'),(10027,'com.liferay.portal.model.LayoutPrototype'),(10028,'com.liferay.portal.model.LayoutRevision'),(10029,'com.liferay.portal.model.LayoutSet'),(10030,'com.liferay.portal.model.LayoutSetBranch'),(10031,'com.liferay.portal.model.LayoutSetPrototype'),(10032,'com.liferay.portal.model.ListType'),(10033,'com.liferay.portal.model.Lock'),(10034,'com.liferay.portal.model.MembershipRequest'),(10003,'com.liferay.portal.model.Organization'),(10035,'com.liferay.portal.model.OrgGroupPermission'),(10036,'com.liferay.portal.model.OrgGroupRole'),(10037,'com.liferay.portal.model.OrgLabor'),(10038,'com.liferay.portal.model.PasswordPolicy'),(10039,'com.liferay.portal.model.PasswordPolicyRel'),(10040,'com.liferay.portal.model.PasswordTracker'),(10041,'com.liferay.portal.model.Permission'),(10042,'com.liferay.portal.model.Phone'),(10043,'com.liferay.portal.model.PluginSetting'),(10044,'com.liferay.portal.model.PortalPreferences'),(10045,'com.liferay.portal.model.Portlet'),(10046,'com.liferay.portal.model.PortletItem'),(10047,'com.liferay.portal.model.PortletPreferences'),(10048,'com.liferay.portal.model.Region'),(10049,'com.liferay.portal.model.Release'),(10050,'com.liferay.portal.model.Repository'),(10051,'com.liferay.portal.model.RepositoryEntry'),(10052,'com.liferay.portal.model.Resource'),(10053,'com.liferay.portal.model.ResourceAction'),(10054,'com.liferay.portal.model.ResourceBlock'),(10055,'com.liferay.portal.model.ResourceBlockPermission'),(10056,'com.liferay.portal.model.ResourceCode'),(10057,'com.liferay.portal.model.ResourcePermission'),(10058,'com.liferay.portal.model.ResourceTypePermission'),(10004,'com.liferay.portal.model.Role'),(10059,'com.liferay.portal.model.ServiceComponent'),(10060,'com.liferay.portal.model.Shard'),(10061,'com.liferay.portal.model.Subscription'),(10062,'com.liferay.portal.model.Team'),(10063,'com.liferay.portal.model.Ticket'),(10005,'com.liferay.portal.model.User'),(10006,'com.liferay.portal.model.UserGroup'),(10064,'com.liferay.portal.model.UserGroupGroupRole'),(10065,'com.liferay.portal.model.UserGroupRole'),(10066,'com.liferay.portal.model.UserIdMapper'),(10067,'com.liferay.portal.model.UserNotificationEvent'),(10187,'com.liferay.portal.model.UserPersonalSite'),(10068,'com.liferay.portal.model.UserTracker'),(10069,'com.liferay.portal.model.UserTrackerPath'),(10070,'com.liferay.portal.model.VirtualHost'),(10071,'com.liferay.portal.model.WebDAVProps'),(10072,'com.liferay.portal.model.Website'),(10073,'com.liferay.portal.model.WorkflowDefinitionLink'),(10074,'com.liferay.portal.model.WorkflowInstanceLink'),(10413,'com.liferay.portal.repository.liferayrepository.LiferayRepository'),(10075,'com.liferay.portlet.announcements.model.AnnouncementsDelivery'),(10076,'com.liferay.portlet.announcements.model.AnnouncementsEntry'),(10077,'com.liferay.portlet.announcements.model.AnnouncementsFlag'),(10078,'com.liferay.portlet.asset.model.AssetCategory'),(10079,'com.liferay.portlet.asset.model.AssetCategoryProperty'),(10080,'com.liferay.portlet.asset.model.AssetEntry'),(10081,'com.liferay.portlet.asset.model.AssetLink'),(10082,'com.liferay.portlet.asset.model.AssetTag'),(10083,'com.liferay.portlet.asset.model.AssetTagProperty'),(10084,'com.liferay.portlet.asset.model.AssetTagStats'),(10085,'com.liferay.portlet.asset.model.AssetVocabulary'),(10007,'com.liferay.portlet.blogs.model.BlogsEntry'),(10086,'com.liferay.portlet.blogs.model.BlogsStatsUser'),(10008,'com.liferay.portlet.bookmarks.model.BookmarksEntry'),(10087,'com.liferay.portlet.bookmarks.model.BookmarksFolder'),(10009,'com.liferay.portlet.calendar.model.CalEvent'),(10088,'com.liferay.portlet.documentlibrary.model.DLContent'),(10010,'com.liferay.portlet.documentlibrary.model.DLFileEntry'),(10089,'com.liferay.portlet.documentlibrary.model.DLFileEntryMetadata'),(10090,'com.liferay.portlet.documentlibrary.model.DLFileEntryType'),(10091,'com.liferay.portlet.documentlibrary.model.DLFileRank'),(10092,'com.liferay.portlet.documentlibrary.model.DLFileShortcut'),(10093,'com.liferay.portlet.documentlibrary.model.DLFileVersion'),(10094,'com.liferay.portlet.documentlibrary.model.DLFolder'),(10095,'com.liferay.portlet.documentlibrary.model.DLSync'),(10096,'com.liferay.portlet.dynamicdatalists.model.DDLRecord'),(10097,'com.liferay.portlet.dynamicdatalists.model.DDLRecordSet'),(10098,'com.liferay.portlet.dynamicdatalists.model.DDLRecordVersion'),(10099,'com.liferay.portlet.dynamicdatamapping.model.DDMContent'),(10100,'com.liferay.portlet.dynamicdatamapping.model.DDMStorageLink'),(10101,'com.liferay.portlet.dynamicdatamapping.model.DDMStructure'),(10102,'com.liferay.portlet.dynamicdatamapping.model.DDMStructureLink'),(10103,'com.liferay.portlet.dynamicdatamapping.model.DDMTemplate'),(10104,'com.liferay.portlet.expando.model.ExpandoColumn'),(10105,'com.liferay.portlet.expando.model.ExpandoRow'),(10106,'com.liferay.portlet.expando.model.ExpandoTable'),(10107,'com.liferay.portlet.expando.model.ExpandoValue'),(10108,'com.liferay.portlet.journal.model.JournalArticle'),(10109,'com.liferay.portlet.journal.model.JournalArticleImage'),(10110,'com.liferay.portlet.journal.model.JournalArticleResource'),(10111,'com.liferay.portlet.journal.model.JournalContentSearch'),(10112,'com.liferay.portlet.journal.model.JournalFeed'),(10113,'com.liferay.portlet.journal.model.JournalStructure'),(10114,'com.liferay.portlet.journal.model.JournalTemplate'),(10115,'com.liferay.portlet.messageboards.model.MBBan'),(10116,'com.liferay.portlet.messageboards.model.MBCategory'),(10117,'com.liferay.portlet.messageboards.model.MBDiscussion'),(10118,'com.liferay.portlet.messageboards.model.MBMailingList'),(10011,'com.liferay.portlet.messageboards.model.MBMessage'),(10119,'com.liferay.portlet.messageboards.model.MBStatsUser'),(10012,'com.liferay.portlet.messageboards.model.MBThread'),(10120,'com.liferay.portlet.messageboards.model.MBThreadFlag'),(10121,'com.liferay.portlet.mobiledevicerules.model.MDRAction'),(10122,'com.liferay.portlet.mobiledevicerules.model.MDRRule'),(10123,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroup'),(10124,'com.liferay.portlet.mobiledevicerules.model.MDRRuleGroupInstance'),(10125,'com.liferay.portlet.polls.model.PollsChoice'),(10126,'com.liferay.portlet.polls.model.PollsQuestion'),(10127,'com.liferay.portlet.polls.model.PollsVote'),(10128,'com.liferay.portlet.ratings.model.RatingsEntry'),(10129,'com.liferay.portlet.ratings.model.RatingsStats'),(10130,'com.liferay.portlet.shopping.model.ShoppingCart'),(10131,'com.liferay.portlet.shopping.model.ShoppingCategory'),(10132,'com.liferay.portlet.shopping.model.ShoppingCoupon'),(10133,'com.liferay.portlet.shopping.model.ShoppingItem'),(10134,'com.liferay.portlet.shopping.model.ShoppingItemField'),(10135,'com.liferay.portlet.shopping.model.ShoppingItemPrice'),(10136,'com.liferay.portlet.shopping.model.ShoppingOrder'),(10137,'com.liferay.portlet.shopping.model.ShoppingOrderItem'),(10138,'com.liferay.portlet.social.model.SocialActivity'),(10139,'com.liferay.portlet.social.model.SocialActivityAchievement'),(10140,'com.liferay.portlet.social.model.SocialActivityCounter'),(10141,'com.liferay.portlet.social.model.SocialActivityLimit'),(10142,'com.liferay.portlet.social.model.SocialActivitySetting'),(10143,'com.liferay.portlet.social.model.SocialRelation'),(10144,'com.liferay.portlet.social.model.SocialRequest'),(10145,'com.liferay.portlet.softwarecatalog.model.SCFrameworkVersion'),(10146,'com.liferay.portlet.softwarecatalog.model.SCLicense'),(10147,'com.liferay.portlet.softwarecatalog.model.SCProductEntry'),(10148,'com.liferay.portlet.softwarecatalog.model.SCProductScreenshot'),(10149,'com.liferay.portlet.softwarecatalog.model.SCProductVersion'),(10150,'com.liferay.portlet.usernotifications.model.UserNotificationEvent'),(10151,'com.liferay.portlet.wiki.model.WikiNode'),(10013,'com.liferay.portlet.wiki.model.WikiPage'),(10152,'com.liferay.portlet.wiki.model.WikiPageResource'),(15001,'com.liferay.opensocial.model.Gadget'),(15002,'com.liferay.opensocial.model.OAuthConsumer'),(15003,'com.liferay.opensocial.model.OAuthToken');
/*!40000 ALTER TABLE `classname_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroupgrouprole`
--

DROP TABLE IF EXISTS `usergroupgrouprole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroupgrouprole` (
  `userGroupId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`userGroupId`,`groupId`,`roleId`),
  KEY `IX_CCBE4063` (`groupId`),
  KEY `IX_CAB0CCC8` (`groupId`,`roleId`),
  KEY `IX_1CDF88C` (`roleId`),
  KEY `IX_DCDED558` (`userGroupId`),
  KEY `IX_73C52252` (`userGroupId`,`groupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroupgrouprole`
--

LOCK TABLES `usergroupgrouprole` WRITE;
/*!40000 ALTER TABLE `usergroupgrouprole` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroupgrouprole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marketplace_app`
--

DROP TABLE IF EXISTS `marketplace_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketplace_app` (
  `uuid_` varchar(75) DEFAULT NULL,
  `appId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `remoteAppId` bigint(20) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`appId`),
  KEY `IX_865B7BD5` (`companyId`),
  KEY `IX_20F14D93` (`remoteAppId`),
  KEY `IX_3E667FE1` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketplace_app`
--

LOCK TABLES `marketplace_app` WRITE;
/*!40000 ALTER TABLE `marketplace_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `marketplace_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialactivity`
--

DROP TABLE IF EXISTS `socialactivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialactivity` (
  `activityId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createDate` bigint(20) DEFAULT NULL,
  `mirrorActivityId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `extraData` longtext,
  `receiverUserId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`activityId`),
  UNIQUE KEY `IX_8F32DEC9` (`groupId`,`userId`,`createDate`,`classNameId`,`classPK`,`type_`,`receiverUserId`),
  KEY `IX_82E39A0C` (`classNameId`),
  KEY `IX_A853C757` (`classNameId`,`classPK`),
  KEY `IX_64B1BC66` (`companyId`),
  KEY `IX_2A2468` (`groupId`),
  KEY `IX_FB604DC7` (`groupId`,`userId`,`classNameId`,`classPK`,`type_`,`receiverUserId`),
  KEY `IX_1271F25F` (`mirrorActivityId`),
  KEY `IX_1F00C374` (`mirrorActivityId`,`classNameId`,`classPK`),
  KEY `IX_121CA3CB` (`receiverUserId`),
  KEY `IX_3504B8BC` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialactivity`
--

LOCK TABLES `socialactivity` WRITE;
/*!40000 ALTER TABLE `socialactivity` DISABLE KEYS */;
INSERT INTO `socialactivity` VALUES (1,10179,10153,10157,1347267413104,0,10010,10419,1,'{\"title\":\"welcome_bg_3.jpg\"}',0),(2,10179,10153,10157,1347267415328,0,10010,10433,1,'{\"title\":\"welcome_bg_11.jpg\"}',0),(3,10179,10153,10157,1347267416105,0,10010,10444,1,'{\"title\":\"welcome_bg_12.jpg\"}',0),(4,10179,10153,10157,1347267416466,0,10010,10452,1,'{\"title\":\"welcome_bg_10.png\"}',0),(5,10179,10153,10157,1347267416926,0,10010,10465,1,'{\"title\":\"welcome_bg_2.jpg\"}',0),(6,10179,10153,10157,1347267417236,0,10010,10477,1,'{\"title\":\"welcome_bg_9.jpg\"}',0),(7,10179,10153,10157,1347267417767,0,10010,10493,1,'{\"title\":\"welcome_bg_4.jpg\"}',0),(8,10179,10153,10157,1347267418197,0,10010,10505,1,'{\"title\":\"welcome_bg_6.jpg\"}',0),(9,10179,10153,10157,1347267418582,0,10010,10517,1,'{\"title\":\"welcome_bg_7.jpg\"}',0),(10,10179,10153,10157,1347267419052,0,10010,10530,1,'{\"title\":\"welcome_bg_5.jpg\"}',0),(11,10179,10153,10157,1347267419285,0,10010,10542,1,'{\"title\":\"welcome_bg_13.jpg\"}',0),(12,10179,10153,10157,1347267419543,0,10010,10553,1,'{\"title\":\"welcome_bg_1.jpg\"}',0),(13,10179,10153,10157,1347267419752,0,10010,10566,1,'{\"title\":\"welcome_bg_8.jpg\"}',0),(101,11605,10153,10157,1348674338584,0,10010,11613,1,'{\"title\":\"trophy_icon.png\"}',0),(102,11605,10153,10157,1348674340628,0,10010,11621,1,'{\"title\":\"image3.png\"}',0),(103,11605,10153,10157,1348674340897,0,10010,11630,1,'{\"title\":\"download_icon.png\"}',0),(104,11605,10153,10157,1348674341078,0,10010,11638,1,'{\"title\":\"image2.png\"}',0),(105,11605,10153,10157,1348674341216,0,10010,11646,1,'{\"title\":\"image1.png\"}',0),(106,11605,10153,10157,1348674342101,0,10010,11658,1,'{\"title\":\"strategy_icon.png\"}',0),(107,11605,10153,10157,1348674342230,0,10010,11669,1,'{\"title\":\"gears_icon.png\"}',0),(201,10191,10153,12102,1354189798778,0,10010,13119,1,'{\"title\":\"SouthAmerica.jpg\"}',0),(202,10191,10153,12102,1354190250997,0,10010,13136,1,'{\"title\":\"M&S.jpeg\"}',0),(203,10191,10153,12102,1354190996293,0,10010,13152,1,'{\"title\":\"configurator.jpeg\"}',0),(204,10191,10153,12102,1354197507668,0,10010,13187,1,'{\"title\":\"upload-textile-machinery.png\"}',0),(205,10191,10153,12102,1354199321355,0,10010,13276,1,'{\"title\":\"europe-partners.png\"}',0),(206,10191,10153,12102,1354199777349,0,10010,13347,1,'{\"title\":\"europe-partners1.png\"}',0),(301,10191,10153,12102,1368193138054,0,10010,15298,1,'{\"title\":\"MantAPP.png\"}',0),(401,10191,10153,12102,1393922983231,0,10010,18301,1,'{\"title\":\"bkg-index.jpg\"}',0);
/*!40000 ALTER TABLE `socialactivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `subscriptionId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `frequency` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`subscriptionId`),
  UNIQUE KEY `IX_2E1A92D4` (`companyId`,`userId`,`classNameId`,`classPK`),
  KEY `IX_786D171A` (`companyId`,`classNameId`,`classPK`),
  KEY `IX_54243AFD` (`userId`),
  KEY `IX_E8F34171` (`userId`,`classNameId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mdrrulegroup`
--

DROP TABLE IF EXISTS `mdrrulegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdrrulegroup` (
  `uuid_` varchar(75) DEFAULT NULL,
  `ruleGroupId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  PRIMARY KEY (`ruleGroupId`),
  UNIQUE KEY `IX_46665CC4` (`uuid_`,`groupId`),
  KEY `IX_5849891C` (`groupId`),
  KEY `IX_7F26B2A6` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mdrrulegroup`
--

LOCK TABLES `mdrrulegroup` WRITE;
/*!40000 ALTER TABLE `mdrrulegroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdrrulegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfileentry`
--

DROP TABLE IF EXISTS `dlfileentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfileentry` (
  `uuid_` varchar(75) DEFAULT NULL,
  `fileEntryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `versionUserId` bigint(20) DEFAULT NULL,
  `versionUserName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `repositoryId` bigint(20) DEFAULT NULL,
  `folderId` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `extension` varchar(75) DEFAULT NULL,
  `mimeType` varchar(75) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext,
  `extraSettings` longtext,
  `fileEntryTypeId` bigint(20) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  `size_` bigint(20) DEFAULT NULL,
  `readCount` int(11) DEFAULT NULL,
  `smallImageId` bigint(20) DEFAULT NULL,
  `largeImageId` bigint(20) DEFAULT NULL,
  `custom1ImageId` bigint(20) DEFAULT NULL,
  `custom2ImageId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`fileEntryId`),
  UNIQUE KEY `IX_5391712` (`groupId`,`folderId`,`name`),
  UNIQUE KEY `IX_ED5CA615` (`groupId`,`folderId`,`title`),
  UNIQUE KEY `IX_BC2E7E6A` (`uuid_`,`groupId`),
  KEY `IX_4CB1B2B4` (`companyId`),
  KEY `IX_F4AF5636` (`groupId`),
  KEY `IX_93CF8193` (`groupId`,`folderId`),
  KEY `IX_29D0AF28` (`groupId`,`folderId`,`fileEntryTypeId`),
  KEY `IX_43261870` (`groupId`,`userId`),
  KEY `IX_D20C434D` (`groupId`,`userId`,`folderId`),
  KEY `IX_64F0FE40` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfileentry`
--

LOCK TABLES `dlfileentry` WRITE;
/*!40000 ALTER TABLE `dlfileentry` DISABLE KEYS */;
INSERT INTO `dlfileentry` VALUES ('068f742f-ddac-4214-96c0-70f51b14e43b',10419,10179,10153,10157,'',10157,'','2012-09-10 08:56:53','2012-09-10 08:56:53',10179,0,'1','jpg','image/jpeg','welcome_bg_3.jpg','','',0,'1.0',65684,0,0,0,0,0),('ba3cd525-bf69-4d62-b116-52bb08e6e83d',10433,10179,10153,10157,'',10157,'','2012-09-10 08:56:55','2012-09-10 08:56:55',10179,0,'2','jpg','image/jpeg','welcome_bg_11.jpg','','',0,'1.0',43583,0,0,0,0,0),('0107fbe8-7216-415f-b52a-4ccc58b1ed94',10444,10179,10153,10157,'',10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10179,0,'3','jpg','image/jpeg','welcome_bg_12.jpg','','',0,'1.0',46446,0,0,0,0,0),('5f6a7b5d-40f5-44f7-9374-4b8e6a761ab5',10452,10179,10153,10157,'',10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10179,0,'4','png','image/png','welcome_bg_10.png','','',0,'1.0',27139,0,0,0,0,0),('d5c27f88-fd99-4b14-b799-a8693f91cd73',10465,10179,10153,10157,'',10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10179,0,'5','jpg','image/jpeg','welcome_bg_2.jpg','','',0,'1.0',72911,1,0,0,0,0),('a4deb9c1-ce55-4c8d-a4a9-cd61bc9ad1c5',10477,10179,10153,10157,'',10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10179,0,'6','jpg','image/jpeg','welcome_bg_9.jpg','','',0,'1.0',50215,0,0,0,0,0),('f02472f3-8d71-4305-a26e-92884af82fef',10493,10179,10153,10157,'',10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10179,0,'7','jpg','image/jpeg','welcome_bg_4.jpg','','',0,'1.0',62483,0,0,0,0,0),('2fa90a9b-c8b2-4083-80a5-d0dbe8cae6de',10505,10179,10153,10157,'',10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10179,0,'8','jpg','image/jpeg','welcome_bg_6.jpg','','',0,'1.0',45456,0,0,0,0,0),('e6f1975c-5f13-4ace-ab23-378458c3d7be',10517,10179,10153,10157,'',10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10179,0,'9','jpg','image/jpeg','welcome_bg_7.jpg','','',0,'1.0',68705,0,0,0,0,0),('b7e62e15-d2cf-428e-ba1a-fe95ed129375',10530,10179,10153,10157,'',10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,'10','jpg','image/jpeg','welcome_bg_5.jpg','','',0,'1.0',40022,0,0,0,0,0),('2b98a30e-b5f7-4afa-8b0e-f220c318d8d4',10542,10179,10153,10157,'',10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,'11','jpg','image/jpeg','welcome_bg_13.jpg','','',0,'1.0',33632,0,0,0,0,0),('d25df879-c9eb-4fbc-8dc1-fad3589dfae2',10553,10179,10153,10157,'',10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,'12','jpg','image/jpeg','welcome_bg_1.jpg','','',0,'1.0',54277,3,0,0,0,0),('5b6cf4a9-eb60-471d-804c-7d45660670b2',10566,10179,10153,10157,'',10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10179,0,'13','jpg','image/jpeg','welcome_bg_8.jpg','','',0,'1.0',43664,0,0,0,0,0),('d1ec5a7d-7a2d-4441-95db-4139d93c51c2',11613,11605,10153,10157,'',10157,'','2012-09-26 15:45:38','2012-09-26 15:45:38',11605,0,'101','png','image/png','trophy_icon.png','','',0,'1.0',2314,0,0,0,0,0),('89e0fc78-6945-4566-849d-91e6a2e88944',11621,11605,10153,10157,'',10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',11605,0,'102','png','image/png','image3.png','','',0,'1.0',365175,0,0,0,0,0),('945d2d6b-b3ee-4fa4-b94b-26fec1bd94c9',11630,11605,10153,10157,'',10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',11605,0,'103','png','image/png','download_icon.png','','',0,'1.0',2876,0,0,0,0,0),('64faafc9-fe6d-4ef8-bed0-49a99da3cc60',11638,11605,10153,10157,'',10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',11605,0,'104','png','image/png','image2.png','','',0,'1.0',207501,0,0,0,0,0),('428bed71-cec0-4e6b-be48-c7a2b1d7cd61',11646,11605,10153,10157,'',10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',11605,0,'105','png','image/png','image1.png','','',0,'1.0',198611,0,0,0,0,0),('db0dce92-e663-495b-9e34-a87a912d6638',11658,11605,10153,10157,'',10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',11605,0,'106','png','image/png','strategy_icon.png','','',0,'1.0',3804,0,0,0,0,0),('fed7a05f-fd0a-4126-8944-4f1fabccb73a',11669,11605,10153,10157,'',10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',11605,0,'107','png','image/png','gears_icon.png','','',0,'1.0',3233,0,0,0,0,0),('fa67ae45-0000-4b0c-bdc6-660450a826af',13119,10191,10153,12102,'Admin Amin',12102,'Admin Amin','2012-11-29 11:49:58','2012-11-29 11:49:58',10191,0,'201','jpg','image/jpeg','SouthAmerica.jpg','','',0,'1.0',4190,50,0,0,0,0),('5f8df2be-67f4-4573-908b-6ed37bddd4c6',13136,10191,10153,12102,'Admin Amin',12102,'Admin Amin','2012-11-29 11:57:30','2012-11-29 11:57:30',10191,0,'202','jpeg','image/jpeg','M&S.jpeg','','',0,'1.0',8125,51,0,0,0,0),('93dd05f8-fae4-4cd2-9a43-de40a73e9249',13152,10191,10153,12102,'Admin Amin',12102,'Admin Amin','2012-11-29 12:09:56','2012-11-29 12:09:56',10191,0,'203','jpeg','image/jpeg','configurator.jpeg','','',0,'1.0',9324,417,0,0,0,0),('114d0615-8445-4cb2-871d-99ef6559128e',13187,10191,10153,12102,'Admin Amin',12102,'Admin Amin','2012-11-29 13:58:27','2012-11-29 13:58:27',10191,0,'204','png','image/png','upload-textile-machinery.png','','',0,'1.0',241315,433,0,0,0,0),('985ba964-426c-4193-9456-6b8c64be1f85',13276,10191,10153,12102,'Admin Amin',12102,'Admin Amin','2012-11-29 14:28:41','2012-11-29 14:28:41',10191,0,'205','png','image/png','europe-partners.png','','',0,'1.0',304275,1,0,0,0,0),('e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5',13347,10191,10153,12102,'Admin Amin',12102,'Admin Amin','2012-11-29 14:36:17','2012-11-29 14:36:17',10191,0,'207','png','image/png','europe-partners1.png','','',0,'1.0',322760,460,0,0,0,0),('d4feb609-4aea-4861-9b05-7365cb91ab5b',15298,10191,10153,12102,'Admin Amin',12102,'Admin Amin','2013-05-10 13:38:58','2013-05-10 13:38:58',10191,0,'301','png','image/png','MantAPP.png','','',0,'1.0',39092,7,0,0,0,0),('2f96a36c-df13-4aba-b148-ff0b95d3cd53',18301,10191,10153,12102,'Admin Admin',12102,'Admin Admin','2014-03-04 08:49:43','2014-03-04 08:49:43',10191,0,'401','jpg','image/jpeg','bkg-index.jpg','','',0,'1.0',132922,9,0,0,0,0);
/*!40000 ALTER TABLE `dlfileentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release_`
--

DROP TABLE IF EXISTS `release_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `release_` (
  `releaseId` bigint(20) NOT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `servletContextName` varchar(75) DEFAULT NULL,
  `buildNumber` int(11) DEFAULT NULL,
  `buildDate` datetime DEFAULT NULL,
  `verified` tinyint(4) DEFAULT NULL,
  `state_` int(11) DEFAULT NULL,
  `testString` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`releaseId`),
  KEY `IX_8BD6BCA7` (`servletContextName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release_`
--

LOCK TABLES `release_` WRITE;
/*!40000 ALTER TABLE `release_` DISABLE KEYS */;
INSERT INTO `release_` VALUES (1,'2012-09-10 10:55:53','2015-05-11 13:59:37','portal',6101,'2012-07-31 00:00:00',1,0,'You take the blue pill, the story ends, you wake up in your bed and believe whatever you want to believe. You take the red pill, you stay in Wonderland, and I show you how deep the rabbit hole goes.');
/*!40000 ALTER TABLE `release_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbcategory`
--

DROP TABLE IF EXISTS `mbcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbcategory` (
  `uuid_` varchar(75) DEFAULT NULL,
  `categoryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `parentCategoryId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `displayStyle` varchar(75) DEFAULT NULL,
  `threadCount` int(11) DEFAULT NULL,
  `messageCount` int(11) DEFAULT NULL,
  `lastPostDate` datetime DEFAULT NULL,
  PRIMARY KEY (`categoryId`),
  UNIQUE KEY `IX_F7D28C2F` (`uuid_`,`groupId`),
  KEY `IX_BC735DCF` (`companyId`),
  KEY `IX_BB870C11` (`groupId`),
  KEY `IX_ED292508` (`groupId`,`parentCategoryId`),
  KEY `IX_C2626EDB` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbcategory`
--

LOCK TABLES `mbcategory` WRITE;
/*!40000 ALTER TABLE `mbcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `mbcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journalcontentsearch`
--

DROP TABLE IF EXISTS `journalcontentsearch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journalcontentsearch` (
  `contentSearchId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `privateLayout` tinyint(4) DEFAULT NULL,
  `layoutId` bigint(20) DEFAULT NULL,
  `portletId` varchar(200) DEFAULT NULL,
  `articleId` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`contentSearchId`),
  UNIQUE KEY `IX_C3AA93B8` (`groupId`,`privateLayout`,`layoutId`,`portletId`,`articleId`),
  KEY `IX_9207CB31` (`articleId`),
  KEY `IX_6838E427` (`groupId`,`articleId`),
  KEY `IX_20962903` (`groupId`,`privateLayout`),
  KEY `IX_7CC7D73E` (`groupId`,`privateLayout`,`articleId`),
  KEY `IX_B3B318DC` (`groupId`,`privateLayout`,`layoutId`),
  KEY `IX_7ACC74C9` (`groupId`,`privateLayout`,`layoutId`,`portletId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journalcontentsearch`
--

LOCK TABLES `journalcontentsearch` WRITE;
/*!40000 ALTER TABLE `journalcontentsearch` DISABLE KEYS */;
INSERT INTO `journalcontentsearch` VALUES (13317,10179,10153,0,1,'56_INSTANCE_TO4ossIXPkhm','13308');
/*!40000 ALTER TABLE `journalcontentsearch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogsstatsuser`
--

DROP TABLE IF EXISTS `blogsstatsuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blogsstatsuser` (
  `statsUserId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `entryCount` int(11) DEFAULT NULL,
  `lastPostDate` datetime DEFAULT NULL,
  `ratingsTotalEntries` int(11) DEFAULT NULL,
  `ratingsTotalScore` double DEFAULT NULL,
  `ratingsAverageScore` double DEFAULT NULL,
  PRIMARY KEY (`statsUserId`),
  UNIQUE KEY `IX_82254C25` (`groupId`,`userId`),
  KEY `IX_90CDA39A` (`companyId`,`entryCount`),
  KEY `IX_43840EEB` (`groupId`),
  KEY `IX_28C78D5C` (`groupId`,`entryCount`),
  KEY `IX_BB51F1D9` (`userId`),
  KEY `IX_507BA031` (`userId`,`lastPostDate`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogsstatsuser`
--

LOCK TABLES `blogsstatsuser` WRITE;
/*!40000 ALTER TABLE `blogsstatsuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogsstatsuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfolder`
--

DROP TABLE IF EXISTS `dlfolder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfolder` (
  `uuid_` varchar(75) DEFAULT NULL,
  `folderId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `repositoryId` bigint(20) DEFAULT NULL,
  `mountPoint` tinyint(4) DEFAULT NULL,
  `parentFolderId` bigint(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` longtext,
  `lastPostDate` datetime DEFAULT NULL,
  `defaultFileEntryTypeId` bigint(20) DEFAULT NULL,
  `overrideFileEntryTypes` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`folderId`),
  UNIQUE KEY `IX_902FD874` (`groupId`,`parentFolderId`,`name`),
  UNIQUE KEY `IX_3CC1DED2` (`uuid_`,`groupId`),
  KEY `IX_A74DB14C` (`companyId`),
  KEY `IX_F2EA1ACE` (`groupId`),
  KEY `IX_49C37475` (`groupId`,`parentFolderId`),
  KEY `IX_2A048EA0` (`groupId`,`parentFolderId`,`mountPoint`),
  KEY `IX_51556082` (`parentFolderId`,`name`),
  KEY `IX_EE29C715` (`repositoryId`),
  KEY `IX_CBC408D8` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfolder`
--

LOCK TABLES `dlfolder` WRITE;
/*!40000 ALTER TABLE `dlfolder` DISABLE KEYS */;
INSERT INTO `dlfolder` VALUES ('8fbf48f5-7113-4e31-a670-2c65acd8c83c',12001,10179,10153,10195,'','2012-10-02 08:17:44','2012-10-02 08:17:44',10179,0,0,'Documents','Documents root folder',NULL,0,0),('fd608006-14b2-4a0f-abfc-3a3d1631b33f',15217,12104,10153,12102,'','2013-05-10 08:38:38','2013-05-10 08:38:38',12104,0,0,'OpenSocial Gadgets','',NULL,0,0);
/*!40000 ALTER TABLE `dlfolder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `countryId` bigint(20) NOT NULL,
  `name` varchar(75) DEFAULT NULL,
  `a2` varchar(75) DEFAULT NULL,
  `a3` varchar(75) DEFAULT NULL,
  `number_` varchar(75) DEFAULT NULL,
  `idd_` varchar(75) DEFAULT NULL,
  `zipRequired` tinyint(4) DEFAULT NULL,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`countryId`),
  UNIQUE KEY `IX_717B97E1` (`a2`),
  UNIQUE KEY `IX_717B9BA2` (`a3`),
  UNIQUE KEY `IX_19DA007B` (`name`),
  KEY `IX_25D734CD` (`active_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Canada','CA','CAN','124','001',1,1),(2,'China','CN','CHN','156','086',1,1),(3,'France','FR','FRA','250','033',1,1),(4,'Germany','DE','DEU','276','049',1,1),(5,'Hong Kong','HK','HKG','344','852',1,1),(6,'Hungary','HU','HUN','348','036',1,1),(7,'Israel','IL','ISR','376','972',1,1),(8,'Italy','IT','ITA','380','039',1,1),(9,'Japan','JP','JPN','392','081',1,1),(10,'South Korea','KR','KOR','410','082',1,1),(11,'Netherlands','NL','NLD','528','031',1,1),(12,'Portugal','PT','PRT','620','351',1,1),(13,'Russia','RU','RUS','643','007',1,1),(14,'Singapore','SG','SGP','702','065',1,1),(15,'Spain','ES','ESP','724','034',1,1),(16,'Turkey','TR','TUR','792','090',1,1),(17,'Vietnam','VN','VNM','704','084',1,1),(18,'United Kingdom','GB','GBR','826','044',1,1),(19,'United States','US','USA','840','001',1,1),(20,'Afghanistan','AF','AFG','4','093',1,1),(21,'Albania','AL','ALB','8','355',1,1),(22,'Algeria','DZ','DZA','12','213',1,1),(23,'American Samoa','AS','ASM','16','684',1,1),(24,'Andorra','AD','AND','20','376',1,1),(25,'Angola','AO','AGO','24','244',0,1),(26,'Anguilla','AI','AIA','660','264',1,1),(27,'Antarctica','AQ','ATA','10','672',1,1),(28,'Antigua','AG','ATG','28','268',0,1),(29,'Argentina','AR','ARG','32','054',1,1),(30,'Armenia','AM','ARM','51','374',1,1),(31,'Aruba','AW','ABW','533','297',0,1),(32,'Australia','AU','AUS','36','061',1,1),(33,'Austria','AT','AUT','40','043',1,1),(34,'Azerbaijan','AZ','AZE','31','994',1,1),(35,'Bahamas','BS','BHS','44','242',0,1),(36,'Bahrain','BH','BHR','48','973',1,1),(37,'Bangladesh','BD','BGD','50','880',1,1),(38,'Barbados','BB','BRB','52','246',1,1),(39,'Belarus','BY','BLR','112','375',1,1),(40,'Belgium','BE','BEL','56','032',1,1),(41,'Belize','BZ','BLZ','84','501',0,1),(42,'Benin','BJ','BEN','204','229',0,1),(43,'Bermuda','BM','BMU','60','441',1,1),(44,'Bhutan','BT','BTN','64','975',1,1),(45,'Bolivia','BO','BOL','68','591',1,1),(46,'Bosnia-Herzegovina','BA','BIH','70','387',1,1),(47,'Botswana','BW','BWA','72','267',0,1),(48,'Brazil','BR','BRA','76','055',1,1),(49,'British Virgin Islands','VG','VGB','92','284',1,1),(50,'Brunei','BN','BRN','96','673',1,1),(51,'Bulgaria','BG','BGR','100','359',1,1),(52,'Burkina Faso','BF','BFA','854','226',0,1),(53,'Burma (Myanmar)','MM','MMR','104','095',1,1),(54,'Burundi','BI','BDI','108','257',0,1),(55,'Cambodia','KH','KHM','116','855',1,1),(56,'Cameroon','CM','CMR','120','237',1,1),(57,'Cape Verde Island','CV','CPV','132','238',1,1),(58,'Cayman Islands','KY','CYM','136','345',1,1),(59,'Central African Republic','CF','CAF','140','236',0,1),(60,'Chad','TD','TCD','148','235',1,1),(61,'Chile','CL','CHL','152','056',1,1),(62,'Christmas Island','CX','CXR','162','061',1,1),(63,'Cocos Islands','CC','CCK','166','061',1,1),(64,'Colombia','CO','COL','170','057',1,1),(65,'Comoros','KM','COM','174','269',0,1),(66,'Republic of Congo','CD','COD','180','242',0,1),(67,'Democratic Republic of Congo','CG','COG','178','243',0,1),(68,'Cook Islands','CK','COK','184','682',0,1),(69,'Costa Rica','CR','CRI','188','506',1,1),(70,'Croatia','HR','HRV','191','385',1,1),(71,'Cuba','CU','CUB','192','053',1,1),(72,'Cyprus','CY','CYP','196','357',1,1),(73,'Czech Republic','CZ','CZE','203','420',1,1),(74,'Denmark','DK','DNK','208','045',1,1),(75,'Djibouti','DJ','DJI','262','253',0,1),(76,'Dominica','DM','DMA','212','767',0,1),(77,'Dominican Republic','DO','DOM','214','809',1,1),(78,'Ecuador','EC','ECU','218','593',1,1),(79,'Egypt','EG','EGY','818','020',1,1),(80,'El Salvador','SV','SLV','222','503',1,1),(81,'Equatorial Guinea','GQ','GNQ','226','240',0,1),(82,'Eritrea','ER','ERI','232','291',0,1),(83,'Estonia','EE','EST','233','372',1,1),(84,'Ethiopia','ET','ETH','231','251',1,1),(85,'Faeroe Islands','FO','FRO','234','298',1,1),(86,'Falkland Islands','FK','FLK','238','500',1,1),(87,'Fiji Islands','FJ','FJI','242','679',0,1),(88,'Finland','FI','FIN','246','358',1,1),(89,'French Guiana','GF','GUF','254','594',1,1),(90,'French Polynesia','PF','PYF','258','689',1,1),(91,'Gabon','GA','GAB','266','241',1,1),(92,'Gambia','GM','GMB','270','220',0,1),(93,'Georgia','GE','GEO','268','995',1,1),(94,'Ghana','GH','GHA','288','233',0,1),(95,'Gibraltar','GI','GIB','292','350',1,1),(96,'Greece','GR','GRC','300','030',1,1),(97,'Greenland','GL','GRL','304','299',1,1),(98,'Grenada','GD','GRD','308','473',0,1),(99,'Guadeloupe','GP','GLP','312','590',1,1),(100,'Guam','GU','GUM','316','671',1,1),(101,'Guatemala','GT','GTM','320','502',1,1),(102,'Guinea','GN','GIN','324','224',0,1),(103,'Guinea-Bissau','GW','GNB','624','245',1,1),(104,'Guyana','GY','GUY','328','592',0,1),(105,'Haiti','HT','HTI','332','509',1,1),(106,'Honduras','HN','HND','340','504',1,1),(107,'Iceland','IS','ISL','352','354',1,1),(108,'India','IN','IND','356','091',1,1),(109,'Indonesia','ID','IDN','360','062',1,1),(110,'Iran','IR','IRN','364','098',1,1),(111,'Iraq','IQ','IRQ','368','964',1,1),(112,'Ireland','IE','IRL','372','353',0,1),(113,'Ivory Coast','CI','CIV','384','225',1,1),(114,'Jamaica','JM','JAM','388','876',1,1),(115,'Jordan','JO','JOR','400','962',1,1),(116,'Kazakhstan','KZ','KAZ','398','007',1,1),(117,'Kenya','KE','KEN','404','254',1,1),(118,'Kiribati','KI','KIR','408','686',0,1),(119,'Kuwait','KW','KWT','414','965',1,1),(120,'North Korea','KP','PRK','408','850',0,1),(121,'Kyrgyzstan','KG','KGZ','471','996',1,1),(122,'Laos','LA','LAO','418','856',1,1),(123,'Latvia','LV','LVA','428','371',1,1),(124,'Lebanon','LB','LBN','422','961',1,1),(125,'Lesotho','LS','LSO','426','266',1,1),(126,'Liberia','LR','LBR','430','231',1,1),(127,'Libya','LY','LBY','434','218',1,1),(128,'Liechtenstein','LI','LIE','438','423',1,1),(129,'Lithuania','LT','LTU','440','370',1,1),(130,'Luxembourg','LU','LUX','442','352',1,1),(131,'Macau','MO','MAC','446','853',0,1),(132,'Macedonia','MK','MKD','807','389',1,1),(133,'Madagascar','MG','MDG','450','261',1,1),(134,'Malawi','MW','MWI','454','265',0,1),(135,'Malaysia','MY','MYS','458','060',1,1),(136,'Maldives','MV','MDV','462','960',1,1),(137,'Mali','ML','MLI','466','223',0,1),(138,'Malta','MT','MLT','470','356',1,1),(139,'Marshall Islands','MH','MHL','584','692',1,1),(140,'Martinique','MQ','MTQ','474','596',1,1),(141,'Mauritania','MR','MRT','478','222',0,1),(142,'Mauritius','MU','MUS','480','230',0,1),(143,'Mayotte Island','YT','MYT','175','269',1,1),(144,'Mexico','MX','MEX','484','052',1,1),(145,'Micronesia','FM','FSM','583','691',1,1),(146,'Moldova','MD','MDA','498','373',1,1),(147,'Monaco','MC','MCO','492','377',1,1),(148,'Mongolia','MN','MNG','496','976',1,1),(149,'Montenegro','ME','MNE','499','382',1,1),(150,'Montserrat','MS','MSR','500','664',0,1),(151,'Morocco','MA','MAR','504','212',1,1),(152,'Mozambique','MZ','MOZ','508','258',1,1),(153,'Namibia','NA','NAM','516','264',1,1),(154,'Nauru','NR','NRU','520','674',0,1),(155,'Nepal','NP','NPL','524','977',1,1),(156,'Netherlands Antilles','AN','ANT','530','599',1,1),(157,'New Caledonia','NC','NCL','540','687',1,1),(158,'New Zealand','NZ','NZL','554','064',1,1),(159,'Nicaragua','NI','NIC','558','505',1,1),(160,'Niger','NE','NER','562','227',1,1),(161,'Nigeria','NG','NGA','566','234',1,1),(162,'Niue','NU','NIU','570','683',0,1),(163,'Norfolk Island','NF','NFK','574','672',1,1),(164,'Norway','NO','NOR','578','047',1,1),(165,'Oman','OM','OMN','512','968',1,1),(166,'Pakistan','PK','PAK','586','092',1,1),(167,'Palau','PW','PLW','585','680',1,1),(168,'Palestine','PS','PSE','275','970',1,1),(169,'Panama','PA','PAN','591','507',1,1),(170,'Papua New Guinea','PG','PNG','598','675',1,1),(171,'Paraguay','PY','PRY','600','595',1,1),(172,'Peru','PE','PER','604','051',1,1),(173,'Philippines','PH','PHL','608','063',1,1),(174,'Poland','PL','POL','616','048',1,1),(175,'Puerto Rico','PR','PRI','630','787',1,1),(176,'Qatar','QA','QAT','634','974',0,1),(177,'Reunion Island','RE','REU','638','262',1,1),(178,'Romania','RO','ROU','642','040',1,1),(179,'Rwanda','RW','RWA','646','250',0,1),(180,'St. Helena','SH','SHN','654','290',1,1),(181,'St. Kitts','KN','KNA','659','869',0,1),(182,'St. Lucia','LC','LCA','662','758',0,1),(183,'St. Pierre & Miquelon','PM','SPM','666','508',1,1),(184,'St. Vincent','VC','VCT','670','784',1,1),(185,'San Marino','SM','SMR','674','378',1,1),(186,'Sao Tome & Principe','ST','STP','678','239',0,1),(187,'Saudi Arabia','SA','SAU','682','966',1,1),(188,'Senegal','SN','SEN','686','221',1,1),(189,'Serbia','RS','SRB','688','381',1,1),(190,'Seychelles','SC','SYC','690','248',0,1),(191,'Sierra Leone','SL','SLE','694','249',0,1),(192,'Slovakia','SK','SVK','703','421',1,1),(193,'Slovenia','SI','SVN','705','386',1,1),(194,'Solomon Islands','SB','SLB','90','677',0,1),(195,'Somalia','SO','SOM','706','252',0,1),(196,'South Africa','ZA','ZAF','710','027',1,1),(197,'Sri Lanka','LK','LKA','144','094',1,1),(198,'Sudan','SD','SDN','736','095',1,1),(199,'Suriname','SR','SUR','740','597',0,1),(200,'Swaziland','SZ','SWZ','748','268',1,1),(201,'Sweden','SE','SWE','752','046',1,1),(202,'Switzerland','CH','CHE','756','041',1,1),(203,'Syria','SY','SYR','760','963',0,1),(204,'Taiwan','TW','TWN','158','886',1,1),(205,'Tajikistan','TJ','TJK','762','992',1,1),(206,'Tanzania','TZ','TZA','834','255',0,1),(207,'Thailand','TH','THA','764','066',1,1),(208,'Togo','TG','TGO','768','228',1,1),(209,'Tonga','TO','TON','776','676',0,1),(210,'Trinidad & Tobago','TT','TTO','780','868',0,1),(211,'Tunisia','TN','TUN','788','216',1,1),(212,'Turkmenistan','TM','TKM','795','993',1,1),(213,'Turks & Caicos','TC','TCA','796','649',1,1),(214,'Tuvalu','TV','TUV','798','688',0,1),(215,'Uganda','UG','UGA','800','256',0,1),(216,'Ukraine','UA','UKR','804','380',1,1),(217,'United Arab Emirates','AE','ARE','784','971',0,1),(218,'Uruguay','UY','URY','858','598',1,1),(219,'Uzbekistan','UZ','UZB','860','998',1,1),(220,'Vanuatu','VU','VUT','548','678',0,1),(221,'Vatican City','VA','VAT','336','039',1,1),(222,'Venezuela','VE','VEN','862','058',1,1),(223,'Wallis & Futuna','WF','WLF','876','681',1,1),(224,'Western Samoa','EH','ESH','732','685',1,1),(225,'Yemen','YE','YEM','887','967',0,1),(226,'Zambia','ZM','ZMB','894','260',1,1),(227,'Zimbabwe','ZW','ZWE','716','263',0,1);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialactivitycounter`
--

DROP TABLE IF EXISTS `socialactivitycounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialactivitycounter` (
  `activityCounterId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `ownerType` int(11) DEFAULT NULL,
  `currentValue` int(11) DEFAULT NULL,
  `totalValue` int(11) DEFAULT NULL,
  `graceValue` int(11) DEFAULT NULL,
  `startPeriod` int(11) DEFAULT NULL,
  `endPeriod` int(11) DEFAULT NULL,
  PRIMARY KEY (`activityCounterId`),
  UNIQUE KEY `IX_1B7E3B67` (`groupId`,`classNameId`,`classPK`,`name`,`ownerType`,`endPeriod`),
  UNIQUE KEY `IX_374B35AE` (`groupId`,`classNameId`,`classPK`,`name`,`ownerType`,`startPeriod`),
  KEY `IX_A4B9A23B` (`classNameId`,`classPK`),
  KEY `IX_926CDD04` (`groupId`,`classNameId`,`classPK`,`ownerType`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialactivitycounter`
--

LOCK TABLES `socialactivitycounter` WRITE;
/*!40000 ALTER TABLE `socialactivitycounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialactivitycounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddlrecord`
--

DROP TABLE IF EXISTS `ddlrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddlrecord` (
  `uuid_` varchar(75) DEFAULT NULL,
  `recordId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `versionUserId` bigint(20) DEFAULT NULL,
  `versionUserName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `DDMStorageId` bigint(20) DEFAULT NULL,
  `recordSetId` bigint(20) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  `displayIndex` int(11) DEFAULT NULL,
  PRIMARY KEY (`recordId`),
  UNIQUE KEY `IX_B4328F39` (`uuid_`,`groupId`),
  KEY `IX_87A6B599` (`recordSetId`),
  KEY `IX_AAC564D3` (`recordSetId`,`userId`),
  KEY `IX_8BC2F891` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddlrecord`
--

LOCK TABLES `ddlrecord` WRITE;
/*!40000 ALTER TABLE `ddlrecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `ddlrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sclicenses_scproductentries`
--

DROP TABLE IF EXISTS `sclicenses_scproductentries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sclicenses_scproductentries` (
  `licenseId` bigint(20) NOT NULL,
  `productEntryId` bigint(20) NOT NULL,
  PRIMARY KEY (`licenseId`,`productEntryId`),
  KEY `IX_27006638` (`licenseId`),
  KEY `IX_D7710A66` (`productEntryId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sclicenses_scproductentries`
--

LOCK TABLES `sclicenses_scproductentries` WRITE;
/*!40000 ALTER TABLE `sclicenses_scproductentries` DISABLE KEYS */;
/*!40000 ALTER TABLE `sclicenses_scproductentries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_roles`
--

DROP TABLE IF EXISTS `groups_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_roles` (
  `groupId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY (`groupId`,`roleId`),
  KEY `IX_84471FD2` (`groupId`),
  KEY `IX_3103EF3D` (`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_roles`
--

LOCK TABLES `groups_roles` WRITE;
/*!40000 ALTER TABLE `groups_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_scheduler_state`
--

DROP TABLE IF EXISTS `quartz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(20) NOT NULL,
  `CHECKIN_INTERVAL` bigint(20) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_scheduler_state`
--

LOCK TABLES `quartz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `quartz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journalarticle`
--

DROP TABLE IF EXISTS `journalarticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journalarticle` (
  `uuid_` varchar(75) DEFAULT NULL,
  `id_` bigint(20) NOT NULL,
  `resourcePrimKey` bigint(20) DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `articleId` varchar(75) DEFAULT NULL,
  `version` double DEFAULT NULL,
  `title` longtext,
  `urlTitle` varchar(150) DEFAULT NULL,
  `description` longtext,
  `content` longtext,
  `type_` varchar(75) DEFAULT NULL,
  `structureId` varchar(75) DEFAULT NULL,
  `templateId` varchar(75) DEFAULT NULL,
  `layoutUuid` varchar(75) DEFAULT NULL,
  `displayDate` datetime DEFAULT NULL,
  `expirationDate` datetime DEFAULT NULL,
  `reviewDate` datetime DEFAULT NULL,
  `indexable` tinyint(4) DEFAULT NULL,
  `smallImage` tinyint(4) DEFAULT NULL,
  `smallImageId` bigint(20) DEFAULT NULL,
  `smallImageURL` longtext,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id_`),
  UNIQUE KEY `IX_85C52EEC` (`groupId`,`articleId`,`version`),
  UNIQUE KEY `IX_3463D95B` (`uuid_`,`groupId`),
  KEY `IX_DFF98523` (`companyId`),
  KEY `IX_323DF109` (`companyId`,`status`),
  KEY `IX_3D070845` (`companyId`,`version`),
  KEY `IX_E82F322B` (`companyId`,`version`,`status`),
  KEY `IX_9356F865` (`groupId`),
  KEY `IX_68C0F69C` (`groupId`,`articleId`),
  KEY `IX_4D5CD982` (`groupId`,`articleId`,`status`),
  KEY `IX_9CE6E0FA` (`groupId`,`classNameId`,`classPK`),
  KEY `IX_A2534AC2` (`groupId`,`classNameId`,`layoutUuid`),
  KEY `IX_91E78C35` (`groupId`,`classNameId`,`structureId`),
  KEY `IX_F43B9FF2` (`groupId`,`classNameId`,`templateId`),
  KEY `IX_3C028C1E` (`groupId`,`layoutUuid`),
  KEY `IX_301D024B` (`groupId`,`status`),
  KEY `IX_2E207659` (`groupId`,`structureId`),
  KEY `IX_8DEAE14E` (`groupId`,`templateId`),
  KEY `IX_22882D02` (`groupId`,`urlTitle`),
  KEY `IX_D2D249E8` (`groupId`,`urlTitle`,`status`),
  KEY `IX_F0A26B29` (`groupId`,`version`,`status`),
  KEY `IX_33F49D16` (`resourcePrimKey`),
  KEY `IX_3E2765FC` (`resourcePrimKey`,`status`),
  KEY `IX_EF9B7028` (`smallImageId`),
  KEY `IX_8E8710D9` (`structureId`),
  KEY `IX_9106F6CE` (`templateId`),
  KEY `IX_F029602F` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journalarticle`
--

LOCK TABLES `journalarticle` WRITE;
/*!40000 ALTER TABLE `journalarticle` DISABLE KEYS */;
INSERT INTO `journalarticle` VALUES ('dff9b553-6dc1-4af9-b26d-c425b1cf9206',10581,10582,10179,10153,10157,'','2012-09-10 08:57:00','2012-09-10 08:57:00',0,0,'WHO-IS-USING-LIFERAY',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Who Is Using Liferay</Title></root>','who-is-using-liferay','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<style type=\"text/css\">\n	.content-area.selected {\n		background: url(/documents/10179/0/welcome_bg_8.jpg/5b6cf4a9-eb60-471d-804c-7d45660670b2?version=1.0&t=1347267419752) 100% 0 no-repeat;\n	}\n</style>\n\n<div class=\"navigation-wrapper\">\n	<header class=\"content-head content-head-liferay-portal\">\n		<hgroup>\n			<h1>\n				Liferay helps you build feature-rich, easy-to-use web applications quickly.\n			</h1>\n\n			<hr />\n		</hgroup>\n\n		<p>\n			Here are some of our customers from around the globe:\n		</p>\n\n		<ul class=\"left\">\n			<li><span>Rolex</span></li>\n			<li><span>Bugaboo</span></li>\n			<li><span>Deluxe Corporation</span></li>\n			<li><span>Domino\'s Pizza</span></li>\n			<li><span>BASF</span></li>\n		</ul>\n\n		<ul class=\"right\">\n			<li><span>Honda</span></li>\n			<li><span>GE Capital</span></li>\n			<li><span>Sesame Street</span></li>\n			<li><span>China Mobile</span></li>\n			<li><span>York University</span></li>\n		</ul>\n	</header>\n\n	<div class=\"content-area selected\">\n		<a href=\"//www.liferay.com/users?wh=8\" id=\"marketplace\">&nbsp;</a>\n	</div>\n</div>]]></static-content>\n</root>','general','','','','2010-02-01 00:00:00',NULL,NULL,1,0,10583,'',0,10157,'','2012-09-10 08:57:00'),('d0acbc73-7134-4e8c-a682-9a0783712cda',10595,10596,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',0,0,'LIFERAY-BENEFITS',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Liferay Benefits</Title></root>','liferay-benefits','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"XbU4Tt8d\" name=\"page-title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[See how Liferay can change the way you do business.]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"zLvpsWs9\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"XbnjZ8Kf\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_9.jpg/a4deb9c1-ce55-4c8d-a4a9-cd61bc9ad1c5?version=1.0&t=1347267417236]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"Jg6grt09\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/open?wh=9]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Open Source: A Better Way]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"mVzYNdMh\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"LU7ujkcC\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_10.png/5f6a7b5d-40f5-44f7-9374-4b8e6a761ab5?version=1.0&t=1347267416466]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"1LCJ560s\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/ready?wh=10]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Ready to Go]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"KC74M8j1\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"dhL2PHcA\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_11.jpg/ba3cd525-bf69-4d62-b116-52bb08e6e83d?version=1.0&t=1347267415328]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"padOwYYA\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/grow?wh=11]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Ready to Grow]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"A702mdKW\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"f1M1eNh9\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_12.jpg/0107fbe8-7216-415f-b52a-4ccc58b1ed94?version=1.0&t=1347267416105]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"0stopvdI\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/approved?wh=12]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Approved by IT]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"ICAJilfL\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"Q20qsDlX\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_13.jpg/2b98a30e-b5f7-4afa-8b0e-f220c318d8d4?version=1.0&t=1347267419285]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"2vjBgvkJ\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/subscription?wh=13]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Open for Business]]></dynamic-content>\n	</dynamic-element>\n</root>','general','10590','10592','','2010-02-01 00:00:00',NULL,NULL,1,0,10597,'',0,10157,'','2012-09-10 08:57:01'),('7c3e36a0-6b18-4870-8d3b-7a07235e2d35',10603,10604,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',0,0,'WHAT-WE-DO',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">What We Do</Title></root>','what-we-do','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"opu708Sy\" name=\"page-title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[Liferay helps you build feature-rich, easy-to-use web applications quickly.]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"Dyig4q0t\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"iLGzkJA2\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_1.jpg/d25df879-c9eb-4fbc-8dc1-fad3589dfae2?version=1.0&t=1347267419543]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"D6RyRV8B\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/platform?wh=1]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[A Foundation for Apps]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"hPiZkCOd\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"MhNFM5l9\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_2.jpg/d5c27f88-fd99-4b14-b799-a8693f91cd73?version=1.0&t=1347267416926]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"cRxjgI5n\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/wem?wh=2]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Dynamic Websites]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"vpGFKJCQ\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"gh9EXOmx\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_3.jpg/068f742f-ddac-4214-96c0-70f51b14e43b?version=1.0&t=1347267413104]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"y9LxlToP\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/dm?wh=3]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Centralized Document Management]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"ouksVhdr\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"uBCTuyxG\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_4.jpg/f02472f3-8d71-4305-a26e-92884af82fef?version=1.0&t=1347267417767]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"pd27Fmww\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/team?wh=4]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Intuitive Team Collaboration]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"x0WdWruO\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"qDdU3SDP\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_5.jpg/b7e62e15-d2cf-428e-ba1a-fe95ed129375?version=1.0&t=1347267419052]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"sl1Vtl1C\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/productivity?wh=5]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Tools for Business]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"8hmTz6rx\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"a3KYFfTC\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_6.jpg/2fa90a9b-c8b2-4083-80a5-d0dbe8cae6de?version=1.0&t=1347267418197]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"RVoEeB9K\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/sync?wh=6]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Desktop & Mobile Access]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"mB58buvT\" name=\"links\" type=\"text\" index-type=\"\">\n		<dynamic-element instance-id=\"zXTxzQGO\" name=\"bg-image\" type=\"document_library\" index-type=\"\">\n			<dynamic-content><![CDATA[/documents/10179/0/welcome_bg_7.jpg/e6f1975c-5f13-4ace-ab23-378458c3d7be?version=1.0&t=1347267418582]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-element instance-id=\"7LupLUIR\" name=\"action-link-url\" type=\"text\" index-type=\"\">\n			<dynamic-content><![CDATA[//www.liferay.com/marketplace?wh=7]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[Liferay Marketplace]]></dynamic-content>\n	</dynamic-element>\n</root>','general','10590','10592','','2010-02-01 00:00:00',NULL,NULL,1,0,10605,'',0,10157,'','2012-09-10 08:57:01'),('092a926b-44f0-4570-aaa4-3b1387ce276e',11702,11703,11605,10153,10157,'','2012-09-26 15:45:43','2012-09-26 15:45:44',0,0,'INNOVATING-FOR-OVER-30-YEARS',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovating For Over 30 Years</Title></root>','innovating-for-over-30-years','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"B9iP0psz\" name=\"title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[INNOVATING FOR OVER 30 YEARS]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"c7kCbmEK\" name=\"col-one\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[<p>Proin quis dui sem, quis suscipit diam. Vestibulum laoreet mollis justo. Etiam quis dapibus justo. Praesent posuere tellus ac dui consequat accumsan. Pellentesque rutrum ultrices nisi non luctus. In leo velit, ornare a consectetur ut, semper gravida elit. Nulla facilisis ante libero.<br /><br />Suspendisse tellus risus, auctor vitae suscipit et, fermentum a est. Donec magna nulla, malesuada ut semper viverra, bibendum in mi. Nullam semper, nisi in elementum tempus, massa urna suscipit turpis, ac bibendum lectus nisl ac enim. Duis rhoncus dictum ipsum, eu dignissim neque vestibulum a. Nam vel tortor urna. Aliquam erat volutpat. Donec diam massa, aliquet quis lacinia nec, aliquam ut mi. Etiam non condimentum mi. Donec faucibus purus vel leo fermentum fringilla. Donec interdum, libero sed consectetur luctus, enim nunc dictum lorem, sed ullamcorper nibh nisi eu magna.<br /><br />Praesent posuere tellus ac dui consequat accumsan. Pellentesque rutrum ultrices nisi non luctus. In leo velit, ornare a consectetur ut, semper gravida elit. Nulla facilisis ante libero. Suspendisse tellus risus, auctor vitae suscipit et, fermentum a est. Donec magna nulla, malesuada ut semper viverra, bibendum in mi. Nullam semper, nisi in elementum tempus, massa urna suscipit turpis, ac bibendum lectus nisl ac enim. Duis rhoncus dictum ipsum, eu dignissim neque vestibulum a. Nam vel tortor urna. Aliquam erat volutpat. Donec diam massa, aliquet quis lacinia nec, aliquam ut mi. Etiam non condimentum mi. Donec faucibus purus vel leo fermentum fringilla. Donec interdum, libero sed consectetur luctus, enim nunc dictum lorem, sed ullamcorper nibh nisi eu magna.</p>\n]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"gOIrc3rO\" name=\"col-two\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[<p>Proin quis dui sem, quis suscipit diam. Vestibulum laoreet mollis justo. Etiam quis dapibus justo. Praesent posuere tellus ac dui consequat accumsan. Pellentesque rutrum ultrices nisi non luctus. In leo velit, ornare a consectetur ut, semper gravida elit. Nulla facilisis ante libero.<br /><br />Suspendisse tellus risus, auctor vitae suscipit et, fermentum a est. Donec magna nulla, malesuada ut semper viverra, bibendum in mi. Nullam semper, nisi in elementum tempus, massa urna suscipit turpis, ac bibendum lectus nisl ac enim. Duis rhoncus dictum ipsum, eu dignissim neque vestibulum a. Nam vel tortor urna. Aliquam erat volutpat. Donec diam massa, aliquet quis lacinia nec, aliquam ut mi. Etiam non condimentum mi. Donec faucibus purus vel leo fermentum fringilla. Donec interdum, libero sed consectetur luctus, enim nunc dictum lorem, sed ullamcorper nibh nisi eu magna.<br /><br />Praesent posuere tellus ac dui consequat accumsan. Pellentesque rutrum ultrices nisi non luctus. In leo velit, ornare a consectetur ut, semper gravida elit. Nulla facilisis ante libero. Suspendisse tellus risus, auctor vitae suscipit et, fermentum a est. Donec magna nulla, malesuada ut semper viverra, bibendum in mi. Nullam semper, nisi in elementum tempus, massa urna suscipit turpis, ac bibendum lectus nisl ac enim. Duis rhoncus dictum ipsum, eu dignissim neque vestibulum a. Nam vel tortor urna. Aliquam erat volutpat. Donec diam massa, aliquet quis lacinia nec, aliquam ut mi. Etiam non condimentum mi. Donec faucibus purus vel leo fermentum fringilla. Donec interdum, libero sed consectetur luctus, enim nunc dictum lorem, sed ullamcorper nibh nisi eu magna.</p>\n]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"Y5MtSR5b\" name=\"col-three\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n</root>','general','11681','11687','','2010-02-01 11:00:00',NULL,NULL,1,0,11704,'',0,10157,'','2012-09-26 15:45:44'),('0a67d626-c161-47ff-a67b-6a4d8f88e5d2',11716,11717,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',0,0,'OUR-STRATEGY',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Our Strategy</Title></root>','our-strategy','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"p5hIAxLD\" name=\"title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[OUR STRATEGY]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"XgFOunh5\" name=\"link\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"UzhxO9Fo\" name=\"image\" type=\"document_library\" index-type=\"\">\n		<dynamic-content><![CDATA[/documents/11605/0/strategy_icon.png/db0dce92-e663-495b-9e34-a87a912d6638?version=1.0&t=1348674342101]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"7Q5MoQdR\" name=\"description\" type=\"text_box\" index-type=\"\">\n		<dynamic-content><![CDATA[How we achieve our goals and provide quality products]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"99r6u5Hk\" name=\"content\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[<p>\n	Etiam porta condimentum vulputate. Etiam in eros viverra mauris vehicula commodo vitae vehicula justo. Vestibulum massa diam, iaculis ut posuere dapibus, blandit volutpat nibh.<br />\n	<br />\n	Neth vehicula, sapien tincidunt aliquet condimentum, nisi ante sodales ligula, ac bibendum risus tortor at lacus. Aliquam sit amet purus felis. Suspendisse velit justo, suscipit eget convallis eget, viverra at ligula. Aliquam ut mollis orci. Mauris condimentum viverra dui a dictum. Donec adipiscing arcu non sapien hendrerit pellentesque.<br />\n	<br />\n	Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse laoreet pharetra lorem sit amet volutpat. Quisque felis nulla, rhoncus at blandit vitae, tempus a ante.</p>\n]]></dynamic-content>\n	</dynamic-element>\n</root>','general','11711','11713','','2010-02-01 11:00:00',NULL,NULL,1,0,11718,'',0,10157,'','2012-09-26 15:45:44'),('f4361e12-2ee5-4acf-b936-5e570156c3d3',11724,11725,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:45',0,0,'OUR-ACHIEVEMENTS',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Our Achievements</Title></root>','our-achievements','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"R2jUanzU\" name=\"title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[Our Achievements]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"516DValA\" name=\"link\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"RXFN7Ijp\" name=\"image\" type=\"document_library\" index-type=\"\">\n		<dynamic-content><![CDATA[/documents/11605/0/trophy_icon.png/d1ec5a7d-7a2d-4441-95db-4139d93c51c2?version=1.0&t=1348674338584]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"8VMklZ2R\" name=\"description\" type=\"text_box\" index-type=\"\">\n		<dynamic-content><![CDATA[Take a look at what we\'ve done to provide you with the best there is.]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"12HH4wl6\" name=\"content\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[<p>\n	Aliquam consequat, purus vehicula tristique scelerisque, lorem neque rutrum erat, quis aliquet diam magna at ligula. Etiam eget mi tortor, vel pretium lectus. Morbi sit amet dui velit. Cras odio nisl, blandit quis rhoncus eget, convallis nec tortor. In quis tellus lorem. Proin posuere ligula et nisi rhoncus eu mollis ligula varius. Donec pharetra molestie felis non tincidunt. Donec faucibus consectetur cursus. Donec viverra dignissim tempus.<br />\n	<br />\n	Suspendisse dictum tellus sit amet sapien ullamcorper id facilisis nisi tempor. Integer pulvinar lacus vitae sem scelerisque mollis. Praesent at est eu magna mollis scelerisque sit amet sed lacus.</p>\n]]></dynamic-content>\n	</dynamic-element>\n</root>','general','11711','11713','','2010-02-01 11:00:00',NULL,NULL,1,0,11726,'',0,10157,'','2012-09-26 15:45:45'),('be612ddb-5aaf-494f-8f05-86cd662cb9d0',11732,11733,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',0,0,'HOW-DO-WE-DO-IT',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">How Do We Do It</Title></root>','how-do-we-do-it','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"M4puwHg8\" name=\"title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[How do we do it?]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"VP25Oqe7\" name=\"link\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"6n0S7AjA\" name=\"image\" type=\"document_library\" index-type=\"\">\n		<dynamic-content><![CDATA[/documents/11605/0/gears_icon.png/fed7a05f-fd0a-4126-8944-4f1fabccb73a?version=1.0&t=1348674342230]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"jrO1zZ9V\" name=\"description\" type=\"text_box\" index-type=\"\">\n		<dynamic-content><![CDATA[A walk through of our process to bring new reality to your world]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"Q9mUXJt6\" name=\"content\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[<p>\n	Nulla turpis erat, sagittis eget mattis sit amet, sagittis at leo. Maecenas condimentum, mi nec iaculis faucibus, ligula libero malesuada massa, quis consequat leo sem et lorem. Sed dignissim, augue bibendum convallis faucibus, sapien ante sollicitudin felis, ac tristique est sapien a enim.<br />\n	<br />\n	Nunc ut felis nibh. Pellentesque cursus vulputate leo in tincidunt. Nullam lacinia nibh et elit tristique volutpat. Fusce vel arcu vitae velit fermentum blandit.<br />\n	<br />\n	Sed lobortis venenatis mauris, eu scelerisque lectus rutrum ac. Proin dui magna, dapibus ac ultricies vel, condimentum sed magna. Aenean eleifend molestie nunc a sagittis. Duis leo tellus, consequat nec suscipit tempus, sagittis molestie erat. &nbsp;&nbsp;</p>\n]]></dynamic-content>\n	</dynamic-element>\n</root>','general','11711','11713','','2010-02-01 11:00:00',NULL,NULL,1,0,11734,'',0,10157,'','2012-09-26 15:45:45'),('e580f80a-5e27-46d3-b58f-6df4b819aff3',11743,11744,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',0,0,'DOWNLOAD-POD',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Download Pod</Title></root>','download-pod','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"BoF6EAid\" name=\"title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[GET THE LATEST CATALOGUE]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"4jan7pvC\" name=\"link\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"7kUD5CQD\" name=\"image\" type=\"document_library\" index-type=\"\">\n		<dynamic-content><![CDATA[/documents/11605/0/download_icon.png/945d2d6b-b3ee-4fa4-b94b-26fec1bd94c9?version=1.0&t=1348674340897]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"htn4tqLU\" name=\"description\" type=\"text_box\" index-type=\"\">\n		<dynamic-content><![CDATA[Released Date: December 2010<br/> Issue: #46<br/> Type: PDF<br/>]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"C78OvPR5\" name=\"content\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n</root>','general','11711','11740','','2010-02-01 11:00:00',NULL,NULL,1,0,11745,'',0,10157,'','2012-09-26 15:45:45'),('19804b7a-14ae-4ef3-b780-477a2a7a2a54',11754,11755,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',0,0,'WHO-WE-ARE',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Who We Are</Title></root>','who-we-are','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"9T65cMfh\" name=\"title\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[Who We Are]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"rCjUCAH7\" name=\"link\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"UVplaFX5\" name=\"imageselect\" type=\"document_library\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"mPj0tpWQ\" name=\"imageupload\" type=\"image\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"DHao9cNb\" name=\"description\" type=\"text_box\" index-type=\"\">\n		<dynamic-content><![CDATA[How we achieve our goals and provide quality products]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"EVZd09wH\" name=\"content\" type=\"text_area\" index-type=\"\">\n		<dynamic-content><![CDATA[<p>\n	Aliquam consequat, purus vehicula tristique scelerisque, lorem neque rutrum erat, quis aliquet diam magna at ligula. Etiam eget mi tortor, vel pretium lectus. Morbi sit amet dui velit. Cras odio nisl, blandit quis rhoncus eget, convallis nec tortor. In quis tellus lorem. Proin posuere ligula et nisi rhoncus eu mollis ligula varius. Donec pharetra molestie felis non tincidunt. Donec faucibus consectetur cursus. Donec viverra dignissim tempus.<br />\n	<br />\n	Suspendisse dictum tellus sit amet sapien ullamcorper id facilisis nisi tempor. Integer pulvinar lacus vitae sem scelerisque mollis. Praesent at est eu magna mollis. Nulla turpis erat, sagittis eget mattis sit amet, sagittis at leo. Maecenas condimentum, mi nec iaculis faucibus, ligula libero malesuada massa. Proin posuere ligula et nisi rhoncus eu mollis ligula varius. Donec pharetra molestie felis non tincidunt. Donec faucibus consectetur cursus. Donec viverra dignissim tempus. Maecenas condimentum, mi nec iaculis faucibus, ligula libero malesuada massa. Proin posuere ligula et nisi rhoncus eu mollis ligula varius.</p>\n]]></dynamic-content>\n	</dynamic-element>\n</root>','general','11711','11751','','2010-02-01 11:00:00',NULL,NULL,1,0,11758,'',0,10157,'','2012-09-26 15:45:45'),('4c9c9274-312d-4c46-996e-37377c828ee9',11771,11772,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:46',0,0,'HOME-CAROUSEL',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Home Carousel</Title></root>','home-carousel','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<dynamic-element instance-id=\"F9rndeGh\" name=\"width\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[960]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"dohmZ4aW\" name=\"height\" type=\"text\" index-type=\"\">\n		<dynamic-content><![CDATA[260]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"sSzCClU1\" name=\"duration\" type=\"list\" index-type=\"\">\n		<dynamic-content><![CDATA[6]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"TKFzz6Cm\" name=\"controls\" type=\"boolean\" index-type=\"\">\n		<dynamic-content><![CDATA[]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"G4uAO5yJ\" name=\"image\" type=\"document_library\" index-type=\"\">\n		<dynamic-element instance-id=\"YROro1ov\" name=\"link\" type=\"text\" index-type=\"\">\n			<dynamic-element instance-id=\"5XDcRwj2\" name=\"url-location\" type=\"text\" index-type=\"\">\n				<dynamic-content><![CDATA[]]></dynamic-content>\n			</dynamic-element>\n			<dynamic-content><![CDATA[]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[/documents/11605/0/image1.png/428bed71-cec0-4e6b-be48-c7a2b1d7cd61?version=1.0&t=1348674341216]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"KvW92QWJ\" name=\"image\" type=\"document_library\" index-type=\"\">\n		<dynamic-element instance-id=\"mUJqXMFs\" name=\"link\" type=\"text\" index-type=\"\">\n			<dynamic-element instance-id=\"sWvozbm7\" name=\"url-location\" type=\"text\" index-type=\"\">\n				<dynamic-content><![CDATA[]]></dynamic-content>\n			</dynamic-element>\n			<dynamic-content><![CDATA[]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[/documents/11605/0/image2.png/64faafc9-fe6d-4ef8-bed0-49a99da3cc60?version=1.0&t=1348674341078]]></dynamic-content>\n	</dynamic-element>\n	<dynamic-element instance-id=\"ZkHbi2dD\" name=\"image\" type=\"document_library\" index-type=\"\">\n		<dynamic-element instance-id=\"RIt6U99s\" name=\"link\" type=\"text\" index-type=\"\">\n			<dynamic-element instance-id=\"0BPNPTkc\" name=\"url-location\" type=\"text\" index-type=\"\">\n				<dynamic-content><![CDATA[]]></dynamic-content>\n			</dynamic-element>\n			<dynamic-content><![CDATA[]]></dynamic-content>\n		</dynamic-element>\n		<dynamic-content><![CDATA[/documents/11605/0/image3.png/89e0fc78-6945-4566-849d-91e6a2e88944?version=1.0&t=1348674340628]]></dynamic-content>\n	</dynamic-element>\n</root>','general','11766','11768','','2010-02-01 11:00:00',NULL,NULL,1,0,11773,'',0,10157,'','2012-09-26 15:45:46'),('ed096554-4f6f-417e-9f3e-06c1352c6b8f',11804,11805,10179,10153,10195,'Test Test','2012-09-27 08:55:17','2012-09-27 08:55:19',0,0,'11803',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div>\n	Such a cycle is composed of two main processes:</div>\n<ul>\n	<li>\n		The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches the value offered from physical products to product-service \"bundles\".</li>\n	<li>\n		The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</li>\n</ul>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 08:55:19'),('9cfae6aa-0479-4efd-90fd-76ffee37901f',11814,11805,10179,10153,10195,'Test Test','2012-09-27 08:59:29','2012-09-27 08:59:32',0,0,'11803',1.1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div style=\"text-align: center; \">\n	<img alt=\"\" src=\"/welcome-theme/images/circle.png\" /></div>\n<div>\n	&nbsp;</div>\n<div>\n	Such a cycle is composed of two main processes:</div>\n<ul>\n	<li>\n		The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches the value offered from physical products to product-service \"bundles\".</li>\n	<li>\n		The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</li>\n</ul>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 08:59:32'),('2fd69b3d-18d7-4cc2-92ab-c6bda0dfa671',11816,11805,10179,10153,10195,'Test Test','2012-09-27 09:00:06','2012-09-27 09:00:06',0,0,'11803',1.2,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div>\n	Such a cycle is composed of two main processes:</div>\n<ul>\n	<li>\n		The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches the value offered from physical products to product-service \"bundles\".</li>\n	<li>\n		The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</li>\n</ul>\n<p style=\"text-align: center; \">\n	<img alt=\"\" src=\"/welcome-theme/images/circle.png\" style=\"color: rgb(0, 0, 0); text-align: center; \" /></p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:00:06'),('a5e640f0-7efe-4b66-bbc2-967a32ed073e',11818,11805,10179,10153,10195,'Test Test','2012-09-27 09:01:25','2012-09-27 09:01:25',0,0,'11803',1.3,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div>\n	Such a cycle is composed of two main processes:</div>\n<ul>\n	<li>\n		The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches the value offered from physical products to product-service \"bundles\".</li>\n	<li>\n		The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</li>\n</ul>\n<p style=\"text-align: center; \">\n	<img alt=\"\" src=\"/welcome-theme/images/circle.png\" style=\"color: rgb(0, 0, 0); text-align: center; height: 302px; width: 300px; \" /></p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:01:25'),('6aab542b-e76f-431b-901e-c69ef3a60956',11820,11805,10179,10153,10195,'Test Test','2012-09-27 09:08:15','2012-09-27 09:08:15',0,0,'11803',1.4,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div>\n	Such a cycle is composed of two main processes:</div>\n<ul>\n	<li>\n		The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches the value offered from physical products to product-service \"bundles\".</li>\n	<li>\n		The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</li>\n</ul>\n<p style=\"text-align: center; \">\n	<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"color: rgb(0, 0, 0); text-align: center; height: 419px; width: 416px; \" /></p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:08:15'),('b186e8fc-2b00-443d-b5f6-1adc17db6ad0',11822,11805,10179,10153,10195,'Test Test','2012-09-27 09:09:04','2012-09-27 09:09:04',0,0,'11803',1.5,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	<span style=\"font-size:14px;\">The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</span></div>\n<div>\n	&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div style=\"text-align: center; \">\n	<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"text-align: center; height: 302px; width: 300px; \" /></div>\n<div>\n	&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div>\n	<span style=\"font-size:14px;\">Such a cycle is composed of two main processes:</span></div>\n<ul>\n	<li>\n		<span style=\"font-size:14px;\">The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches the value offered from physical products to product-service \"bundles\".</span></li>\n	<li>\n		<span style=\"font-size:14px;\">The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</span></li>\n</ul>\n<p style=\"text-align: center; \">\n	&nbsp;</p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:09:04'),('e4b45621-8981-4bbc-bae0-0dba6215f8de',11824,11805,10179,10153,10195,'Test Test','2012-09-27 09:11:33','2012-09-27 09:11:33',0,0,'11803',1.6,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div style=\"text-align: justify; \">\n	&nbsp;</div>\n<div>\n	&nbsp;</div>\n<p style=\"text-align: justify; \">\n	&nbsp;</p>\n<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width: 500px; \">\n	<tbody>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</span></div>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td style=\"text-align: center; \">\n				<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"text-align: center; height: 302px; width: 300px; \" /></td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">Such a cycle is composed of two main processes:</span></div>\n				<ul>\n					<li style=\"text-align: justify; \">\n						<span style=\"font-size: 14px; \">The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches&nbsp;</span><span style=\"font-size: 14px; \">the value offered from physical products to product-service \"bundles\".</span></li>\n					<li style=\"text-align: justify; \">\n						<span style=\"font-size: 14px; \">The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</span></li>\n				</ul>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n	</tbody>\n</table>\n<br />\n<p style=\"text-align: center; \">\n	&nbsp;</p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:11:33'),('6c0a55f6-a00e-49b8-b8d9-52e1c9db2fa4',11826,11805,10179,10153,10195,'Test Test','2012-09-27 09:12:18','2012-09-27 09:12:18',0,0,'11803',1.7,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	&nbsp;</div>\n<div>\n	&nbsp;</div>\n<p>\n	&nbsp;</p>\n<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width: 800px; \">\n	<tbody>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</span></div>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"text-align: center; height: 302px; width: 300px; \" /></td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">Such a cycle is composed of two main processes:</span></div>\n				<ul>\n					<li>\n						<span style=\"font-size: 14px; \">The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches&nbsp;</span><span style=\"font-size: 14px; \">the value offered from physical products to product-service \"bundles\".</span></li>\n					<li>\n						<span style=\"font-size: 14px; \">The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</span></li>\n				</ul>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	&nbsp;</p>\n<p style=\"text-align: center; \">\n	&nbsp;</p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:12:18'),('f8d0e642-767f-475a-b5ff-10a3041b118d',11828,11805,10179,10153,10195,'Test Test','2012-09-27 09:12:53','2012-09-27 09:12:53',0,0,'11803',1.8,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<div>\n	&nbsp;</div>\n<div>\n	&nbsp;</div>\n<p>\n	&nbsp;</p>\n<table align=\"center\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width: 800px; \">\n	<tbody>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</span></div>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td style=\"text-align: center; \">\n				<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"text-align: center; height: 302px; width: 300px; \" /></td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">Such a cycle is composed of two main processes:</span></div>\n				<ul>\n					<li>\n						<span style=\"font-size: 14px; \">The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches&nbsp;</span><span style=\"font-size: 14px; \">the value offered from physical products to product-service \"bundles\".</span></li>\n					<li>\n						<span style=\"font-size: 14px; \">The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</span></li>\n				</ul>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	&nbsp;</p>\n<p style=\"text-align: center; \">\n	&nbsp;</p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:12:53'),('54d40faf-92d4-48ab-bce8-5bc92e3c3fb7',11830,11805,10179,10153,10195,'Test Test','2012-09-27 09:13:30','2012-09-27 09:13:30',0,0,'11803',1.9,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<table align=\"center\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width: 800px; \">\n	<tbody>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</span></div>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td style=\"text-align: center; \">\n				<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"text-align: center; height: 302px; width: 300px; \" /></td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div>\n					<span style=\"font-size: 14px; \">Such a cycle is composed of two main processes:</span></div>\n				<ul>\n					<li>\n						<span style=\"font-size: 14px; \">The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches&nbsp;</span><span style=\"font-size: 14px; \">the value offered from physical products to product-service \"bundles\".</span></li>\n					<li>\n						<span style=\"font-size: 14px; \">The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</span></li>\n				</ul>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	&nbsp;</p>\n<p style=\"text-align: center; \">\n	&nbsp;</p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:13:30'),('535189ed-2397-473e-a063-5cb9651b44e1',11832,11805,10179,10153,10195,'Test Test','2012-09-27 09:14:06','2012-09-27 09:14:06',0,0,'11803',2,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovation Ecosystem Platform</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<table align=\"center\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width: 800px; \">\n	<tbody>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div style=\"text-align: justify; \">\n					<span style=\"font-size: 14px; \">The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</span></div>\n				<div>\n					&nbsp;</div>\n				<div>\n					&nbsp;</div>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td style=\"text-align: center; \">\n				<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"text-align: center; height: 302px; width: 300px; \" /></td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div style=\"text-align: justify; \">\n					<span style=\"font-size: 14px; \">Such a cycle is composed of two main processes:</span></div>\n				<ul>\n					<li style=\"text-align: justify; \">\n						<span style=\"font-size: 14px; \">The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches&nbsp;</span><span style=\"font-size: 14px; \">the value offered from physical products to product-service \"bundles\".</span></li>\n					<li style=\"text-align: justify; \">\n						<span style=\"font-size: 14px; \">The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</span></li>\n				</ul>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	&nbsp;</p>\n<p style=\"text-align: center; \">\n	&nbsp;</p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,10195,'Test Test','2012-09-27 09:14:06'),('79214d68-495b-42b7-9be9-331c7d6230fb',13171,13172,10179,10153,12102,'Admin Amin','2012-11-29 13:38:24','2012-11-29 13:38:24',0,0,'13170',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">For Partners</Title></root>','for-partners','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<p>\n	<strong>Bivolino configurator for e-retailers</strong></p>\n<p>\n	Bivolino\'s shirt configurator can be embedded into third party e-retailer portals through the iFrame technology. See how to&nbsp;<u>integrate the Bivolino\'s shirt configurator</u>&nbsp;or&nbsp;<u>ask for support</u>. Embedding the shirt configurayor is easy and requires not more than 10 days for cistomizing the look&amp;feel and for configuring technical and business characteristics of the tool.</p>\n<p>\n	&nbsp;</p>\n<p>\n	<strong>In-Tangible assets</strong></p>\n<p>\n	Every partner is invited to describe their tangible and intangible assets and to upload such descriptions on the portal in order to facilitate the grasping of new business opportunities.</p>]]></static-content>\n</root>','general','','','','2012-11-29 13:35:00',NULL,NULL,1,0,13173,'',0,12102,'Admin Amin','2012-11-29 13:38:24'),('6b08d877-57db-473a-b978-675d9cd1477e',13182,13172,10179,10153,12102,'Admin Amin','2012-11-29 13:44:32','2012-11-29 13:44:32',0,0,'13170',1.1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">For Partners</Title></root>','for-partners','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<p>\n	<strong>Bivolino configurator for e-retailers</strong></p>\n<p>\n	Bivolino\'s shirt configurator can be embedded into third party e-retailer portals through the iFrame technology. See how to&nbsp;<u>integrate the Bivolino\'s shirt configurator</u>&nbsp;or&nbsp;<u>ask for support</u>. Embedding the shirt configurator is easy and requires less than 10 days for customizing the look&amp;feel and for configuring technical and business characteristics of the tool.</p>\n<p>\n	&nbsp;</p>\n<p>\n	<strong>In-Tangible assets collection</strong></p>\n<p>\n	Every partner is invited to describe their tangible and intangible assets and to upload such descriptions on the portal in order to facilitate the grasping of new business opportunities. See how to <u>describe and upload</u> your tangible and intangible assets.</p>]]></static-content>\n</root>','general','','','','2012-11-29 13:35:00',NULL,NULL,1,0,13173,'',0,12102,'Admin Amin','2012-11-29 13:44:32'),('5764f6cd-3d11-4edc-9f80-efdfed028a8b',13200,13172,10179,10153,12102,'Admin Amin','2012-11-29 13:59:03','2012-11-29 13:59:03',0,0,'13170',1.2,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">For Partners</Title></root>','for-partners','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<p>\n	<strong>Bivolino configurator for e-retailers</strong></p>\n<p style=\"text-align: justify;\">\n	<img alt=\"\" src=\"/documents/10191/0/configurator.jpeg/93dd05f8-fae4-4cd2-9a43-de40a73e9249?t=1354190996000\" style=\"width: 100px; height: 74px; float: left;\" />Bivolino\'s shirt configurator can be embedded into third party e-retailer portals through the iFrame &nbsp;technology.&nbsp;See how to&nbsp;<u>integrate the Bivolino\'s shirt configurator</u>&nbsp;or&nbsp;<u>ask for support</u>. Embedding the shirt configurator is easy and requires less than 10 days for customizing the look&amp;feel and for configuring technical and business characteristics of the tool.</p>\n<p style=\"text-align: justify;\">\n	&nbsp;</p>\n<p>\n	&nbsp;</p>\n<p>\n	<strong>In-Tangible assets collection</strong></p>\n<p>\n	<img alt=\"\" src=\"/documents/10191/0/upload-textile-machinery.png/114d0615-8445-4cb2-871d-99ef6559128e?t=1354197507668\" style=\"width: 100px; height: 63px; float: left;\" />Every partner is invited to describe their tangible and intangible assets and to upload such descriptions on the portal in order to facilitate the grasping of new business opportunities. See how to <u>describe</u> &nbsp;your tangible and intangible assets. Then follow <u>this link</u> to submit your asset description (asset assessment process) to the ecosystem manager.</p>]]></static-content>\n</root>','general','','','','2012-11-29 13:35:00',NULL,NULL,1,0,13173,'',0,12102,'Admin Amin','2012-11-29 13:59:03'),('f0df850c-bc97-4c34-8a38-a863936501b8',17901,13310,10179,10153,12102,'Admin Admin','2013-12-23 13:42:03','2013-12-23 13:42:03',0,0,'13308',2.1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"http://localhost/data/bkg-index.jpg\" style=\"width: 1156px; height: 531px;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2013-12-23 13:42:03'),('86277964-8e5a-432e-bd70-b69cf68135cd',17903,13310,10179,10153,12102,'Admin Admin','2013-12-23 13:46:25','2013-12-23 13:46:25',0,0,'13308',2.2,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"http://localhost/data/bkg-index.jpg\" style=\"width: 1024px; height: 470px;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2013-12-23 13:46:25'),('8ff4c4a0-1593-4d51-b616-1abd96d6f59d',17905,13310,10179,10153,12102,'Admin Admin','2013-12-23 13:47:07','2013-12-23 13:47:07',0,0,'13308',2.3,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"http://localhost/data/bkg-index.jpg\" style=\"width: 900px; height: 413px;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2013-12-23 13:47:07'),('26eaaef8-a5d2-414f-abcb-16e9c7e0634f',13309,13310,10179,10153,12102,'Admin Amin','2012-11-29 14:30:26','2012-11-29 14:30:26',0,0,'13308',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners.png/985ba964-426c-4193-9456-6b8c64be1f85?t=1354199321355\" style=\"width: 400px; height: 313px; float: left;\" />&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx</p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 14:30:26'),('4d75f1bf-63b6-48bf-9d03-ed3264050742',17704,13310,10179,10153,12102,'Admin Admin','2013-12-23 11:20:01','2013-12-23 11:20:01',0,0,'13308',1.9,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	FITMAN is one the 5 Use Case Trials projects selected in the 2<sup>nd</sup> phase of the <a class=\"external-link\" href=\"http://www.fi-ppp.eu/about-us/projects/\" target=\"_blank\">FI PPP programme</a>.</p>\n<p>\n	FITMAN provides the FI/PPP Core Platform with 11 industry-led use case trials which test and assess the suitability, openness and flexibility of <a class=\"external-link\" href=\"http://www.fi-ware.eu/\" target=\"_blank\">FI-WARE Generic Enablers</a> while contributing to the STEEP (social-technological-economical-environmental-political) sustainability of EU Manufacturing Industries.</p>\n<p>\n	The FITMAN use case trials belong to several manufacturing sectors such as automotive, aeronautics, white goods, furniture, textile/clothing, LED lighting, plastic, construction, machinery for wood, and manufacturing assets management.</p>\n<p>\n	<br />\n	<img alt=\"\" src=\"http://www.fitman-fi.eu/admin/images/use-cases-illustration\" style=\"width: 653px; height: 161px;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2013-12-23 11:20:01'),('7ed47056-7a0c-48ac-8ff8-2e6971ed2d69',13336,13310,10179,10153,12102,'Admin Amin','2012-11-29 14:32:06','2012-11-29 14:32:06',0,0,'13308',1.1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners.png/985ba964-426c-4193-9456-6b8c64be1f85?t=1354199321355\" style=\"width: 200px; height: 156px; float: left;\" />&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx</p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 14:32:06'),('2f86763f-66e6-4727-b5e1-91c0d5876f90',13360,13310,10179,10153,12102,'Admin Amin','2012-11-29 14:36:33','2012-11-29 14:36:33',0,0,'13308',1.2,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners1.png/e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5?t=1354199777349\" style=\"width: 200px; height: 153px; float: left;\" />&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx&nbsp;&nbsp;dcswxs xs w swx &nbsp;s x sxxxxxx xxxxxxx xxxxxxxxx xxxxxx</p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 14:36:33'),('a3c6ecb2-f3fe-405d-8724-32d321996cea',13362,13310,10179,10153,12102,'Admin Amin','2012-11-29 14:53:55','2012-11-29 14:53:55',0,0,'13308',1.3,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners1.png/e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5?t=1354199777349\" style=\"width: 200px; height: 153px; float: left;\" />Bivolino, founded in 1954, is a Belgian clothing manufacturer, specialized in customized shirts. Bivolino.com was founded by the brothers Louis and Jacques Byvoet. Each Bivolino customized shirt is embroidered with the squirrel as the symbol of the perfect biometric fitting guarantee. In 1969, Bivolino introduced a new ergonomic measurement system, allowing each shirt to be individually fitted to the body. In 1981, Bivolino became the first shirt label to take steps towards computerised production, which automatically produces the pattern making gradations. By now, and using this technology, Bivolino was producing 900.000 shirts a year and employing 270 people. The growth of the internet opened up new possibilities for Bivolino and the brand established a new digital studio at the Limburg Science Park. In 1997 the first shirt was sold via their online shop, Bivolino.com. In 2000, after two years of anthropometric research, Bivolino launched their biometric sizing technology (patented) which could calculate the cut and size for every Bivolino customer, without using a measurement tape. In 2010, Bivolino launched its latest piece of technology, a 3D shirt design platform under the Open Garments research project.</p>\n<p>\n	Current roles in the Bivolino MSE:</p>\n<ul>\n	<li>\n		Customers: consumers using the new services;</li>\n	<li>\n		Laundries: Shirts washing;</li>\n	<li>\n		Mobile providers: they care about maintenance &amp; development of mobile apps providing the (potential) customer with specific functionalities of Bivolino.com (buy shirts, use existing and new services);</li>\n	<li>\n		Business partners using the configurator or other services (for MtM garments) from Bivolino, in particular e-retailers operating in a specific market segment;</li>\n	<li>\n		Manufacturing microplants: Bivolino\'s long-term manufacturing partner (Platico) or a Third Manufacturer who produces the MtM garments for a business partner of Bivolino (e-retailer).</li>\n</ul>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 14:53:55'),('edb70941-ecfc-45e0-893b-f8ee9207318b',13393,13310,10179,10153,12102,'Admin Amin','2012-11-29 15:03:59','2012-11-29 15:03:59',0,0,'13308',1.4,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners1.png/e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5?t=1354199777349\" style=\"width: 200px; height: 153px; float: left;\" />Bivolino, founded in 1954, is a Belgian clothing manufacturer, specialized in customized shirts. Bivolino.com was founded by the brothers Louis and Jacques Byvoet. Each Bivolino customized shirt is embroidered with the squirrel as the symbol of the perfect biometric fitting guarantee. In 1969, Bivolino introduced a new ergonomic measurement system, allowing each shirt to be individually fitted to the body. In 1981, Bivolino became the first shirt label to take steps towards computerised production, which automatically produces the pattern making gradations. By now, and using this technology, Bivolino was producing 900.000 shirts a year and employing 270 people. The growth of the internet opened up new possibilities for Bivolino and the brand established a new digital studio at the Limburg Science Park. In 1997 the first shirt was sold via their online shop, Bivolino.com. In 2000, after two years of anthropometric research, Bivolino launched their biometric sizing technology (patented) which could calculate the cut and size for every Bivolino customer, without using a measurement tape. In 2010, Bivolino launched its latest piece of technology, a 3D shirt design platform under the Open Garments research project.&nbsp;Currently, with the MSEE (Manufacturing Service Ecosystem) European Project, Bivolino is expanding its ecosystem in order to further innovate its value proposition.&nbsp;</p>\n<p>\n	Roles of partners that are now part of the Bivolino MSE:</p>\n<ul>\n	<li>\n		<strong>Customers</strong>: consumers using the new services;</li>\n	<li>\n		<strong>Laundries</strong>: Shirts washing and pick-up/drop-off;</li>\n	<li>\n		<strong>Mobile App Developers</strong>: maintenance &amp; development of mobile apps providing the (potential) customer with specific functionalities of Bivolino.com;</li>\n	<li>\n		<strong>Business partners</strong> using the configurator or other services (for MtM garments) from Bivolino, in particular <strong>e-retailers </strong>operating in a specific market segment;</li>\n	<li>\n		<strong>Manufacturing microplants</strong>: Bivolino\'s long-term manufacturing partner (Platico) or a Third Manufacturer who produces the MtM garments for a business partner of Bivolino (e-retailer);</li>\n	<li>\n		<strong>Logistics provider</strong>: transportation of the product and final delivery to the customer,</li>\n</ul>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 15:03:59'),('86755c10-2d20-4abe-a425-fb2237c9153a',13395,13310,10179,10153,12102,'Admin Amin','2012-11-29 15:06:29','2012-11-29 15:06:29',0,0,'13308',1.5,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<h1>\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners1.png/e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5?t=1354199777349\" style=\"width: 200px; height: 153px; float: left;\" />History of Bivolino</h1>\n<p>\n	Bivolino, founded in 1954, is a Belgian clothing manufacturer, specialized in customized shirts. Bivolino.com was founded by the brothers Louis and Jacques Byvoet. Each Bivolino customized shirt is embroidered with the squirrel as the symbol of the perfect biometric fitting guarantee. In 1969, Bivolino introduced a new ergonomic measurement system, allowing each shirt to be individually fitted to the body. In 1981, Bivolino became the first shirt label to take steps towards computerised production, which automatically produces the pattern making gradations. By now, and using this technology, Bivolino was producing 900.000 shirts a year and employing 270 people. The growth of the internet opened up new possibilities for Bivolino and the brand established a new digital studio at the Limburg Science Park. In 1997 the first shirt was sold via their online shop, Bivolino.com. In 2000, after two years of anthropometric research, Bivolino launched their biometric sizing technology (patented) which could calculate the cut and size for every Bivolino customer, without using a measurement tape. In 2010, Bivolino launched its latest piece of technology, a 3D shirt design platform under the Open Garments research project.&nbsp;Currently, with the MSEE (Manufacturing Service Ecosystem) European Project, Bivolino is expanding its ecosystem in order to further innovate its value proposition.&nbsp;</p>\n<h1>\n	Bivolino MSE</h1>\n<p>\n	Roles of partners that are now part of the Bivolino MSE:</p>\n<ul>\n	<li>\n		<strong>Customers</strong>: consumers using the new services;</li>\n	<li>\n		<strong>Laundries</strong>: Shirts washing and pick-up/drop-off;</li>\n	<li>\n		<strong>Mobile App Developers</strong>: maintenance &amp; development of mobile apps providing the (potential) customer with specific functionalities of Bivolino.com;</li>\n	<li>\n		<strong>Business partners</strong> using the configurator or other services (for MtM garments) from Bivolino, in particular <strong>e-retailers </strong>operating in a specific market segment;</li>\n	<li>\n		<strong>Manufacturing microplants</strong>: Bivolino\'s long-term manufacturing partner (Platico) or a Third Manufacturer who produces the MtM garments for a business partner of Bivolino (e-retailer);</li>\n	<li>\n		<strong>Logistics provider</strong>: transportation of the product and final delivery to the customer,</li>\n</ul>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 15:06:29'),('d28a8e9d-c84c-4888-b69e-da0b52f22ee4',13397,13310,10179,10153,12102,'Admin Amin','2012-11-29 15:07:26','2012-11-29 15:07:26',0,0,'13308',1.6,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<h1>\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners1.png/e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5?t=1354199777349\" style=\"width: 250px; height: 192px; float: left;\" />History of Bivolino</h1>\n<p>\n	Bivolino, founded in 1954, is a Belgian clothing manufacturer, specialized in customized shirts. Bivolino.com was founded by the brothers Louis and Jacques Byvoet. Each Bivolino customized shirt is embroidered with the squirrel as the symbol of the perfect biometric fitting guarantee. In 1969, Bivolino introduced a new ergonomic measurement system, allowing each shirt to be individually fitted to the body. In 1981, Bivolino became the first shirt label to take steps towards computerised production, which automatically produces the pattern making gradations. By now, and using this technology, Bivolino was producing 900.000 shirts a year and employing 270 people. The growth of the internet opened up new possibilities for Bivolino and the brand established a new digital studio at the Limburg Science Park. In 1997 the first shirt was sold via their online shop, Bivolino.com. In 2000, after two years of anthropometric research, Bivolino launched their biometric sizing technology (patented) which could calculate the cut and size for every Bivolino customer, without using a measurement tape. In 2010, Bivolino launched its latest piece of technology, a 3D shirt design platform under the Open Garments research project.&nbsp;Currently, with the MSEE (Manufacturing Service Ecosystem) European Project, Bivolino is expanding its ecosystem in order to further innovate its value proposition.&nbsp;</p>\n<h1>\n	Bivolino MSE</h1>\n<p>\n	Roles of partners that are now part of the Bivolino MSE:</p>\n<ul>\n	<li>\n		<strong>Customers</strong>: consumers using the new services;</li>\n	<li>\n		<strong>Laundries</strong>: Shirts washing and pick-up/drop-off;</li>\n	<li>\n		<strong>Mobile App Developers</strong>: maintenance &amp; development of mobile apps providing the (potential) customer with specific functionalities of Bivolino.com;</li>\n	<li>\n		<strong>Business partners</strong> using the configurator or other services (for MtM garments) from Bivolino, in particular <strong>e-retailers </strong>operating in a specific market segment;</li>\n	<li>\n		<strong>Manufacturing microplants</strong>: Bivolino\'s long-term manufacturing partner (Platico) or a Third Manufacturer who produces the MtM garments for a business partner of Bivolino (e-retailer);</li>\n	<li>\n		<strong>Logistics providers</strong>: transportation of the product and final delivery to the customer,</li>\n</ul>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 15:07:26'),('eeff0f13-0795-445f-993b-8461d7cfc30d',13399,13310,10179,10153,12102,'Admin Amin','2012-11-29 15:09:01','2012-11-29 15:09:01',0,0,'13308',1.7,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Introducing the Bivolino Manufacturing Service Ecosystem</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<h1 style=\"text-align: justify;\">\n	<img alt=\"\" src=\"/documents/10191/0/europe-partners1.png/e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5?t=1354199777349\" style=\"width: 250px; height: 192px; float: left;\" />History of Bivolino</h1>\n<p style=\"text-align: justify;\">\n	Bivolino, founded in 1954, is a Belgian clothing manufacturer, specialized in customized shirts. Bivolino.com was founded by the brothers Louis and Jacques Byvoet. Each Bivolino customized shirt is embroidered with the squirrel as the symbol of the perfect biometric fitting guarantee. In 1969, Bivolino introduced a new ergonomic measurement system, allowing each shirt to be individually fitted to the body. In 1981, Bivolino became the first shirt label to take steps towards computerised production, which automatically produces the pattern making gradations. By now, and using this technology, Bivolino was producing 900.000 shirts a year and employing 270 people. The growth of the internet opened up new possibilities for Bivolino and the brand established a new digital studio at the Limburg Science Park. In 1997 the first shirt was sold via their online shop, Bivolino.com. In 2000, after two years of anthropometric research, Bivolino launched their biometric sizing technology (patented) which could calculate the cut and size for every Bivolino customer, without using a measurement tape. In 2010, Bivolino launched its latest piece of technology, a 3D shirt design platform under the Open Garments research project.&nbsp;Currently, with the MSEE (Manufacturing Service Ecosystem) European Project, Bivolino is expanding its ecosystem in order to further innovate its value proposition.&nbsp;</p>\n<h1 style=\"text-align: justify;\">\n	Bivolino MSE</h1>\n<p style=\"text-align: justify;\">\n	Roles of partners that are now part of the Bivolino MSE:</p>\n<ul>\n	<li style=\"text-align: justify;\">\n		<strong>Customers</strong>: consumers using the new services;</li>\n	<li style=\"text-align: justify;\">\n		<strong>Laundries</strong>: Shirts washing and pick-up/drop-off;</li>\n	<li style=\"text-align: justify;\">\n		<strong>Mobile App Developers</strong>: maintenance &amp; development of mobile apps providing the (potential) customer with specific functionalities of Bivolino.com;</li>\n	<li style=\"text-align: justify;\">\n		<strong>Business partners</strong> using the configurator or other services (for MtM garments) from Bivolino, in particular <strong>e-retailers </strong>operating in a specific market segment;</li>\n	<li style=\"text-align: justify;\">\n		<strong>Manufacturing microplants</strong>: Bivolino\'s long-term manufacturing partner (Platico) or a Third Manufacturer who produces the MtM garments for a business partner of Bivolino (e-retailer);</li>\n	<li style=\"text-align: justify;\">\n		<strong>Logistics providers</strong>: transportation of the product and final delivery to the customer.</li>\n</ul>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Amin','2012-11-29 15:09:01'),('bdde8699-7798-40bd-a1c0-a459508778f0',13401,13172,10179,10153,12102,'Admin Amin','2012-11-29 15:09:43','2012-11-29 15:09:43',0,0,'13170',1.3,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">For Partners</Title></root>','for-partners','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p style=\"text-align: justify;\">\n	<strong>Bivolino configurator for e-retailers</strong></p>\n<p style=\"text-align: justify;\">\n	<img alt=\"\" src=\"/documents/10191/0/configurator.jpeg/93dd05f8-fae4-4cd2-9a43-de40a73e9249?t=1354190996000\" style=\"width: 100px; height: 74px; float: left;\" />Bivolino\'s shirt configurator can be embedded into third party e-retailer portals through the iFrame &nbsp;technology.&nbsp;See how to&nbsp;<u>integrate the Bivolino\'s shirt configurator</u>&nbsp;or&nbsp;<u>ask for support</u>. Embedding the shirt configurator is easy and requires less than 10 days for customizing the look&amp;feel and for configuring technical and business characteristics of the tool.</p>\n<p style=\"text-align: justify;\">\n	&nbsp;</p>\n<p style=\"text-align: justify;\">\n	&nbsp;</p>\n<p style=\"text-align: justify;\">\n	<strong>In-Tangible assets collection</strong></p>\n<p style=\"text-align: justify;\">\n	<img alt=\"\" src=\"/documents/10191/0/upload-textile-machinery.png/114d0615-8445-4cb2-871d-99ef6559128e?t=1354197507668\" style=\"width: 100px; height: 63px; float: left;\" />Every partner is invited to describe their tangible and intangible assets and to upload such descriptions on the portal in order to facilitate the grasping of new business opportunities. See how to <u>describe</u> &nbsp;your tangible and intangible assets. Then follow <u>this link</u> to submit your asset description (asset assessment process) to the ecosystem manager.</p>]]></static-content>\n</root>','general','','','','2012-11-29 13:35:00',NULL,NULL,1,0,13173,'',0,12102,'Admin Amin','2012-11-29 15:09:43'),('8f776c3e-27ce-48db-a59e-5e20dd6b3598',15221,15222,10179,10153,12102,'Admin Amin','2013-05-10 08:47:02','2013-05-10 08:47:02',0,0,'15220',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','usdl-editor','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<div style=\"width:1024px; overflow:auto;\">\n	<iframe alt=\"\" border=\"0\" bordercolor=\"#000000\" frameborder=\"0\"\n		height=\"600\" hspace=\"0\" id=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\"\n		longdesc=\"\" name=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\"\n		onload=\"_48_INSTANCE_QZGwhbXQ1D5a_monitorIframe();\" scrolling=\"auto\"\n		src=\"https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?\"\n		title=\"\" vspace=\"0\" width=\"1024\" style=\"width:1200px; height: 600px;\"> Your\n		browser does not support inline frames or is currently configured not\n		to display inline frames. Content can be viewed at actual source page:\n		https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?.\n	</iframe>\n</div>]]></static-content>\n</root>','general','','','','2013-05-10 08:45:00',NULL,NULL,1,0,15223,'',2,0,'',NULL),('592b7732-afe2-4e9f-8a1c-5b1054f0f0c2',15231,15232,10179,10153,12102,'Admin Amin','2013-05-10 08:47:07','2013-05-10 08:47:07',0,0,'15230',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','usdl-editor','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<div style=\"width:1024px; overflow:auto;\">\n	<iframe alt=\"\" border=\"0\" bordercolor=\"#000000\" frameborder=\"0\" height=\"600\" hspace=\"0\" id=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\" longdesc=\"\" name=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\" onload=\"_48_INSTANCE_QZGwhbXQ1D5a_monitorIframe();\" scrolling=\"auto\" src=\"https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?\" style=\"width:1200px; height: 600px;\" title=\"\" vspace=\"0\" width=\"1024\">Your browser does not support inline frames or is currently configured not to display inline frames. Content can be viewed at actual source page: https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?.</iframe></div>]]></static-content>\n</root>','general','','','','2013-05-10 08:45:00',NULL,NULL,1,0,15233,'',0,12102,'Admin Amin','2013-05-10 08:47:07'),('029efe4f-bc98-4232-af52-84e396effe03',15241,15242,10179,10153,12102,'Admin Amin','2013-05-10 08:47:15','2013-05-10 08:47:15',0,0,'15240',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','usdl-edit-1','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<div style=\"width:1024px; overflow:auto;\">\n	<iframe alt=\"\" border=\"0\" bordercolor=\"#000000\" frameborder=\"0\" height=\"600\" hspace=\"0\" id=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\" longdesc=\"\" name=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\" onload=\"_48_INSTANCE_QZGwhbXQ1D5a_monitorIframe();\" scrolling=\"auto\" src=\"https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?\" style=\"width:1200px; height: 600px;\" title=\"\" vspace=\"0\" width=\"1024\">Your browser does not support inline frames or is currently configured not to display inline frames. Content can be viewed at actual source page: https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?.</iframe></div>]]></static-content>\n</root>','general','','','','2013-05-10 08:45:00',NULL,NULL,1,0,15243,'',0,12102,'Admin Amin','2013-05-10 08:47:15'),('57c6f761-d5ce-43d4-bdbe-cf2b9b02b014',15251,15252,10179,10153,12102,'Admin Amin','2013-05-10 08:47:25','2013-05-10 08:47:25',0,0,'15250',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','usdl-edit-2','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<div style=\"width:1024px; overflow:auto;\">\n	<iframe alt=\"\" border=\"0\" bordercolor=\"#000000\" frameborder=\"0\" height=\"600\" hspace=\"0\" id=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\" longdesc=\"\" name=\"_48_INSTANCE_QZGwhbXQ1D5a_iframe\" onload=\"_48_INSTANCE_QZGwhbXQ1D5a_monitorIframe();\" scrolling=\"auto\" src=\"https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?\" style=\"width:1200px; height: 600px;\" title=\"\" vspace=\"0\" width=\"1024\">Your browser does not support inline frames or is currently configured not to display inline frames. Content can be viewed at actual source page: https://dl.dropboxusercontent.com/u/4318200/usdl-editor-master/index.html?.</iframe></div>]]></static-content>\n</root>','general','','','','2013-05-10 08:45:00',NULL,NULL,1,0,15253,'',0,12102,'Admin Amin','2013-05-10 08:47:25'),('0b341bca-ac90-49e9-9950-83ae97237961',15312,15313,10179,10153,12102,'Admin Amin','2013-05-10 13:39:27','2013-05-10 13:39:27',0,0,'15311',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-app','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 1432px; height: 548px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:38:00',NULL,NULL,1,0,15314,'',0,12102,'Admin Amin','2013-05-10 13:39:27'),('7c78f8cd-7bbc-42f4-9ffd-8bdad345ccd3',15322,15323,10179,10153,12102,'Admin Amin','2013-05-10 13:41:54','2013-05-10 13:41:54',0,0,'15321',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">ma</Title></root>','ma','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 285px; height: 109px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:39:00',NULL,NULL,1,0,15324,'',0,12102,'Admin Amin','2013-05-10 13:41:54'),('20d9b9e7-e881-46a1-864c-64c1faea2c1d',15332,15333,10179,10153,12102,'Admin Amin','2013-05-10 13:42:02','2013-05-10 13:42:02',0,0,'15331',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-a-1','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 285px; height: 109px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:39:00',NULL,NULL,1,0,15334,'',0,12102,'Admin Amin','2013-05-10 13:42:02'),('b0965118-3933-4da6-9b9d-6b91dc1602ea',15342,15343,10179,10153,12102,'Admin Amin','2013-05-10 13:55:30','2013-05-10 13:55:31',0,0,'15341',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-a-2','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 1100px; height: 421px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:42:00',NULL,NULL,1,0,15344,'',0,12102,'Admin Amin','2013-05-10 13:55:31'),('5651f413-b5ed-4141-b867-c32d5e5b029b',15352,15353,10179,10153,12102,'Admin Amin','2013-05-10 13:56:28','2013-05-10 13:56:28',0,0,'15351',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-a-3','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 1050px; height: 402px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:55:00',NULL,NULL,1,0,15354,'',2,0,'',NULL),('71be1a7f-09cb-4ed3-bad2-cc1521289145',15362,15363,10179,10153,12102,'Admin Amin','2013-05-10 13:56:30','2013-05-10 13:56:31',0,0,'15361',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-a-3','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 1050px; height: 402px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:55:00',NULL,NULL,1,0,15364,'',0,12102,'Admin Amin','2013-05-10 13:56:31'),('3b71b3a7-9432-4c5c-a056-b6c2970c2633',15374,15375,10179,10153,12102,'Admin Amin','2013-05-10 13:57:47','2013-05-10 13:57:47',0,0,'15373',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-a-4','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 1100px; height: 421px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:57:00',NULL,NULL,1,0,15376,'',0,12102,'Admin Amin','2013-05-10 13:57:47'),('c68f2374-6755-4f22-bd79-eb7f7bd7aba1',15384,15385,10179,10153,12102,'Admin Amin','2013-05-10 13:59:38','2013-05-10 13:59:38',0,0,'15383',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-a-5','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 1100px; height: 421px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 13:58:00',NULL,NULL,1,0,15386,'',0,12102,'Admin Amin','2013-05-10 13:59:38'),('7d3d78bc-1f5a-46d6-8696-0ffc02f01b93',15399,15400,10179,10153,12102,'Admin Amin','2013-05-10 14:09:26','2013-05-10 14:09:26',0,0,'15398',1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','mant-a-6','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/MantAPP.png/d4feb609-4aea-4861-9b05-7365cb91ab5b?t=1368193138054\" style=\"width: 1020px; height: 421px;\" /></p>]]></static-content>\n</root>','general','','','','2013-05-10 14:08:00',NULL,NULL,1,0,15401,'',0,12102,'Admin Amin','2013-05-10 14:09:26'),('bc66910b-1741-4295-bfa6-3b73ce54c686',17702,13310,10179,10153,12102,'Admin Admin','2013-12-23 11:05:46','2013-12-23 11:05:46',0,0,'13308',1.8,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">FITMAN</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2013-12-23 11:05:46'),('5c26c8f6-9382-47df-9dc1-09f0ca8e15a7',17801,13310,10179,10153,12102,'Admin Admin','2013-12-23 12:06:37','2013-12-23 12:06:37',0,0,'13308',2,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/SouthAmerica.jpg/fa67ae45-0000-4b0c-bdc6-660450a826af?t=1354189798000\" style=\"width: 118px; height: 164px;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2013-12-23 12:06:37'),('0876f5d9-4148-43ee-b5af-babdefa7c2cc',17803,11805,10179,10153,12102,'Admin Admin','2013-12-23 12:10:09','2013-12-23 12:10:09',0,0,'11803',2.1,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Fitman Portal</Title></root>','fitman-portal','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	&nbsp;</p>\n<table align=\"center\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width: 800px; \">\n	<tbody>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div style=\"text-align: justify; \">\n					<span style=\"font-size: 14px; \">The role of the Innovation Ecosystem Platform (IEP) in MSEE is to enable the execution and the enactment of the business processes that characterize a Manufacturing Service Ecosystem (MSE). The scope of those processes must be defined in the context of the overall Service System Life Cycle that MSEE aims at supporting and guiding in the manufacturing industry.&nbsp;</span></div>\n				<div>\n					&nbsp;</div>\n				<div>\n					&nbsp;</div>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td style=\"text-align: center; \">\n				<img alt=\"\" src=\"/welcome-theme/images/circle_t.gif\" style=\"text-align: center; height: 302px; width: 300px; \" /></td>\n			<td>\n				&nbsp;</td>\n		</tr>\n		<tr>\n			<td>\n				&nbsp;</td>\n			<td>\n				<div style=\"text-align: justify; \">\n					<span style=\"font-size: 14px; \">Such a cycle is composed of two main processes:</span></div>\n				<ul>\n					<li style=\"text-align: justify; \">\n						<span style=\"font-size: 14px; \">The servitization process that, on the basis of precise new business opportunities and after the set-up of a Virtual Manufacturing Enterprise (VME) &nbsp;aims at grasping such opportunities. This process in responsible for the design of the VME\'s organizational-human, manufacturing-physical and information-IT resources, leading to a new business model that switches&nbsp;</span><span style=\"font-size: 14px; \">the value offered from physical products to product-service \"bundles\".</span></li>\n					<li style=\"text-align: justify; \">\n						<span style=\"font-size: 14px; \">The governance, operations and innovation process, that on the one hand allows the management of an MSE (MSE Governance), fostering and stimulating open innovation actions among the ecosystem actors (MSE Innovation), and on the other hand exploits the new techno-organizational configuration of VMEs in order to deliver the new value proposition to the customer through collaborative processes (VME Operations).</span></li>\n				</ul>\n			</td>\n			<td>\n				&nbsp;</td>\n		</tr>\n	</tbody>\n</table>\n<p>\n	&nbsp;</p>\n<p style=\"text-align: center; \">\n	&nbsp;</p>]]></static-content>\n</root>','general','','','','2012-09-27 08:54:00',NULL,NULL,1,0,11806,'',0,12102,'Admin Admin','2013-12-23 12:10:09'),('ea6836e4-bbe4-40b9-9e50-90bc51effd96',17907,13310,10179,10153,12102,'Admin Admin','2013-12-23 13:47:37','2013-12-23 13:47:37',0,0,'13308',2.4,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"http://localhost/data/bkg-index.jpg\" style=\"width: 980px; height: 450px;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2013-12-23 13:47:37'),('2dafbaea-d574-42ab-8644-013d26b3c4c1',18001,13310,10179,10153,12102,'Admin Admin','2014-01-03 08:41:06','2014-01-03 08:41:09',0,0,'13308',2.5,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"http://localhost/data/bkg-index.jpg\" style=\"width: 100%; height: 100%;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2014-01-03 08:41:09'),('bd549604-4279-470a-9bf4-ddc2f99d97a0',18314,13310,10179,10153,12102,'Admin Admin','2014-03-04 08:51:47','2014-03-04 08:51:48',0,0,'13308',2.6,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"http://localhost/data/bkg-index.jpg\" style=\"width: 100%; height: 100%;\" /><img alt=\"\" src=\"/documents/10191/0/bkg-index.jpg/2f96a36c-df13-4aba-b148-ff0b95d3cd53?t=1393922983231\" style=\"width: 1156px; height: 531px;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2014-03-04 08:51:48'),('605a2519-8d61-4b96-860a-2b8212ee444d',18316,13310,10179,10153,12102,'Admin Admin','2014-03-04 08:56:38','2014-03-04 08:56:39',0,0,'13308',2.7,'<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','future-internet-technologies-for-manufacturing-industries','','<?xml version=\"1.0\"?>\n\n<root available-locales=\"en_US\" default-locale=\"en_US\">\n	<static-content language-id=\"en_US\"><![CDATA[<p>\n	<img alt=\"\" src=\"/documents/10191/0/bkg-index.jpg/2f96a36c-df13-4aba-b148-ff0b95d3cd53?t=1393922983231\" style=\"width: 100%; height: 100%;\" /></p>]]></static-content>\n</root>','general','','','','2012-11-29 14:13:00',NULL,NULL,1,0,13311,'',0,12102,'Admin Admin','2014-03-04 08:56:39');
/*!40000 ALTER TABLE `journalarticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddmtemplate`
--

DROP TABLE IF EXISTS `ddmtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddmtemplate` (
  `uuid_` varchar(75) DEFAULT NULL,
  `templateId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `structureId` bigint(20) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `type_` varchar(75) DEFAULT NULL,
  `mode_` varchar(75) DEFAULT NULL,
  `language` varchar(75) DEFAULT NULL,
  `script` longtext,
  PRIMARY KEY (`templateId`),
  UNIQUE KEY `IX_1AA75CE3` (`uuid_`,`groupId`),
  KEY `IX_DB24DDDD` (`groupId`),
  KEY `IX_33BEF579` (`language`),
  KEY `IX_C9757A51` (`structureId`),
  KEY `IX_5BC0E264` (`structureId`,`type_`),
  KEY `IX_5B019FE8` (`structureId`,`type_`,`mode_`),
  KEY `IX_C4F283C8` (`type_`),
  KEY `IX_F2A243A7` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddmtemplate`
--

LOCK TABLES `ddmtemplate` WRITE;
/*!40000 ALTER TABLE `ddmtemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `ddmtemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journalarticleimage`
--

DROP TABLE IF EXISTS `journalarticleimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journalarticleimage` (
  `articleImageId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `articleId` varchar(75) DEFAULT NULL,
  `version` double DEFAULT NULL,
  `elInstanceId` varchar(75) DEFAULT NULL,
  `elName` varchar(75) DEFAULT NULL,
  `languageId` varchar(75) DEFAULT NULL,
  `tempImage` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`articleImageId`),
  UNIQUE KEY `IX_103D6207` (`groupId`,`articleId`,`version`,`elInstanceId`,`elName`,`languageId`),
  KEY `IX_3B51BB68` (`groupId`),
  KEY `IX_158B526F` (`groupId`,`articleId`,`version`),
  KEY `IX_D4121315` (`tempImage`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journalarticleimage`
--

LOCK TABLES `journalarticleimage` WRITE;
/*!40000 ALTER TABLE `journalarticleimage` DISABLE KEYS */;
INSERT INTO `journalarticleimage` VALUES (11756,11605,'WHO-WE-ARE',1,'mPj0tpWQ','imageupload','',0),(11757,11605,'WHO-WE-ARE',1,'mPj0tpWQ','imageupload','_en_US',0);
/*!40000 ALTER TABLE `journalarticleimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orggrouppermission`
--

DROP TABLE IF EXISTS `orggrouppermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orggrouppermission` (
  `organizationId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  `permissionId` bigint(20) NOT NULL,
  PRIMARY KEY (`organizationId`,`groupId`,`permissionId`),
  KEY `IX_A425F71A` (`groupId`),
  KEY `IX_6C53DA4E` (`permissionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orggrouppermission`
--

LOCK TABLES `orggrouppermission` WRITE;
/*!40000 ALTER TABLE `orggrouppermission` DISABLE KEYS */;
/*!40000 ALTER TABLE `orggrouppermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualhost`
--

DROP TABLE IF EXISTS `virtualhost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualhost` (
  `virtualHostId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `layoutSetId` bigint(20) DEFAULT NULL,
  `hostname` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`virtualHostId`),
  UNIQUE KEY `IX_A083D394` (`companyId`,`layoutSetId`),
  UNIQUE KEY `IX_431A3960` (`hostname`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualhost`
--

LOCK TABLES `virtualhost` WRITE;
/*!40000 ALTER TABLE `virtualhost` DISABLE KEYS */;
INSERT INTO `virtualhost` VALUES (10156,10153,0,'localhost');
/*!40000 ALTER TABLE `virtualhost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `userId` bigint(20) NOT NULL,
  `groupId` bigint(20) NOT NULL,
  PRIMARY KEY (`userId`,`groupId`),
  KEY `IX_C4F9E699` (`groupId`),
  KEY `IX_F10B6C6B` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `quartz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_paused_trigger_grps`
--

LOCK TABLES `quartz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `quartz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shard`
--

DROP TABLE IF EXISTS `shard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shard` (
  `shardId` bigint(20) NOT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`shardId`),
  KEY `IX_DA5F4359` (`classNameId`,`classPK`),
  KEY `IX_941BA8C3` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shard`
--

LOCK TABLES `shard` WRITE;
/*!40000 ALTER TABLE `shard` DISABLE KEYS */;
INSERT INTO `shard` VALUES (10154,10021,10153,'default');
/*!40000 ALTER TABLE `shard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddlrecordversion`
--

DROP TABLE IF EXISTS `ddlrecordversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddlrecordversion` (
  `recordVersionId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `DDMStorageId` bigint(20) DEFAULT NULL,
  `recordSetId` bigint(20) DEFAULT NULL,
  `recordId` bigint(20) DEFAULT NULL,
  `version` varchar(75) DEFAULT NULL,
  `displayIndex` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`recordVersionId`),
  UNIQUE KEY `IX_C79E347` (`recordId`,`version`),
  KEY `IX_2F4DDFE1` (`recordId`),
  KEY `IX_762ADC7` (`recordId`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddlrecordversion`
--

LOCK TABLES `ddlrecordversion` WRITE;
/*!40000 ALTER TABLE `ddlrecordversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `ddlrecordversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pollsvote`
--

DROP TABLE IF EXISTS `pollsvote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pollsvote` (
  `voteId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `questionId` bigint(20) DEFAULT NULL,
  `choiceId` bigint(20) DEFAULT NULL,
  `voteDate` datetime DEFAULT NULL,
  PRIMARY KEY (`voteId`),
  UNIQUE KEY `IX_1BBFD4D3` (`questionId`,`userId`),
  KEY `IX_D5DF7B54` (`choiceId`),
  KEY `IX_12112599` (`questionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pollsvote`
--

LOCK TABLES `pollsvote` WRITE;
/*!40000 ALTER TABLE `pollsvote` DISABLE KEYS */;
/*!40000 ALTER TABLE `pollsvote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portalpreferences`
--

DROP TABLE IF EXISTS `portalpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portalpreferences` (
  `portalPreferencesId` bigint(20) NOT NULL,
  `ownerId` bigint(20) DEFAULT NULL,
  `ownerType` int(11) DEFAULT NULL,
  `preferences` longtext,
  PRIMARY KEY (`portalPreferencesId`),
  KEY `IX_D1F795F1` (`ownerId`,`ownerType`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portalpreferences`
--

LOCK TABLES `portalpreferences` WRITE;
/*!40000 ALTER TABLE `portalpreferences` DISABLE KEYS */;
INSERT INTO `portalpreferences` VALUES (10159,10153,1,'<portlet-preferences><preference><name>cas.auth.enabled</name><value>false</value></preference><preference><name>company.security.strangers.verify</name><value>false</value></preference><preference><name>ldap.server.ids</name><value></value></preference><preference><name>admin.email.password.reset.subject</name><value>[$PORTAL_URL$]: Reset Your Password</value></preference><preference><name>admin.email.user.added.subject</name><value>[$PORTAL_URL$]: Your New Account</value></preference><preference><name>admin.email.password.sent.body</name><value>&lt;p&gt;[$NEW_LINE$]	Dear [$TO_NAME$],&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Your new password for [$PORTAL_URL$] is [$USER_PASSWORD$].&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	The request for a new password was made from [$REMOTE_ADDRESS$] / [$REMOTE_HOST$] with the browser [$USER_AGENT$].&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Sincerely,&lt;br /&gt;[$NEW_LINE$]	[$FROM_NAME$]&lt;br /&gt;[$NEW_LINE$]	[$FROM_ADDRESS$]&lt;br /&gt;[$NEW_LINE$]	[$PORTAL_URL$]&lt;/p&gt;[$NEW_LINE$]</value></preference><preference><name>admin.email.verification.subject</name><value>[$PORTAL_URL$]: Email Address Verification</value></preference><preference><name>admin.default.role.names</name><value>Power User[$NEW_LINE$]User</value></preference><preference><name>company.security.strangers.with.mx</name><value>true</value></preference><preference><name>company.security.auto.login</name><value>true</value></preference><preference><name>company.security.site.logo</name><value>true</value></preference><preference><name>admin.email.password.sent.subject</name><value>[$PORTAL_URL$]: Your New Password</value></preference><preference><name>cas.server.name</name><value>localhost</value></preference><preference><name>admin.email.password.reset.body</name><value>&lt;p&gt;[$NEW_LINE$]	Dear [$TO_NAME$],&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	You can reset your password for [$PORTAL_URL$] at [$PASSWORD_RESET_URL$].&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	The request for a new password was made from [$REMOTE_ADDRESS$] / [$REMOTE_HOST$].&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Sincerely,&lt;br /&gt;[$NEW_LINE$]	[$FROM_NAME$]&lt;br /&gt;[$NEW_LINE$]	[$FROM_ADDRESS$]&lt;br /&gt;[$NEW_LINE$]	[$PORTAL_URL$]&lt;/p&gt;[$NEW_LINE$]</value></preference><preference><name>cas.logout.url</name><value>http://localhost/sso/logout</value></preference><preference><name>company.security.send.password</name><value>true</value></preference><preference><name>cas.no.such.user.redirect.url</name><value>http://localhost</value></preference><preference><name>google.apps.username</name><value>test@liferay.com</value></preference><preference><name>admin.email.verification.body</name><value>&lt;p&gt;[$NEW_LINE$]	Dear [$TO_NAME$],&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Please verify your email address for [$PORTAL_URL$] at [$EMAIL_VERIFICATION_URL$].&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Your verification code is [$EMAIL_VERIFICATION_CODE$] Sincerely,&lt;br /&gt;[$NEW_LINE$]	[$FROM_NAME$]&lt;br /&gt;[$NEW_LINE$]	[$FROM_ADDRESS$]&lt;br /&gt;[$NEW_LINE$]	[$PORTAL_URL$]&lt;/p&gt;[$NEW_LINE$]</value></preference><preference><name>admin.email.user.added.no.password.body</name><value>&lt;p&gt;[$NEW_LINE$]	Dear [$TO_NAME$],&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Welcome! You recently created an account at [$PORTAL_URL$].&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Sincerely,&lt;br /&gt;[$NEW_LINE$]	[$FROM_NAME$]&lt;br /&gt;[$NEW_LINE$]	[$FROM_ADDRESS$]&lt;br /&gt;[$NEW_LINE$]	[$PORTAL_URL$]&lt;/p&gt;[$NEW_LINE$]</value></preference><preference><name>cas.login.url</name><value>http://localhost/sso/login</value></preference><preference><name>admin.email.user.added.body</name><value>&lt;p&gt;[$NEW_LINE$]	Dear [$TO_NAME$],&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Welcome! You recently created an account at [$PORTAL_URL$]. Your password is [$USER_PASSWORD$]. Enjoy!&lt;br /&gt;[$NEW_LINE$]	&lt;br /&gt;[$NEW_LINE$]	Sincerely,&lt;br /&gt;[$NEW_LINE$]	[$FROM_NAME$]&lt;br /&gt;[$NEW_LINE$]	[$FROM_ADDRESS$]&lt;br /&gt;[$NEW_LINE$]	[$PORTAL_URL$]&lt;/p&gt;[$NEW_LINE$]</value></preference><preference><name>company.security.strangers</name><value>true</value></preference><preference><name>company.security.auth.type</name><value>screenName</value></preference><preference><name>cas.server.url</name><value>http://localhost/sso</value></preference></portlet-preferences>'),(10196,0,1,'<portlet-preferences />'),(10431,10195,4,'<portlet-preferences><preference><name>com.liferay.portal.util.SessionClicks#control-panel-sidebar-minimized</name><value>0</value></preference><preference><name>125#users-order-by-col</name><value>last-name</value></preference><preference><name>128#roles-order-by-col</name><value>name</value></preference><preference><name>125#organizations-order-by-col</name><value>last-name</value></preference><preference><name>128#roles-order-by-type</name><value>asc</value></preference><preference><name>com.liferay.portal.util.SessionClicks#usersAdminUsersPanel</name><value>open</value></preference><preference><name>125#organizations-order-by-type</name><value>asc</value></preference><preference><name>com.liferay.portal.util.SessionClicks#liferay_toggle_controls</name><value>visible</value></preference><preference><name>125#users-order-by-type</name><value>asc</value></preference><preference><name>com.liferay.portal.util.SessionClicks#documentLibraryDisplayDocumentsListingPanel</name><value>open</value></preference><preference><name>com.liferay.portal.util.SessionClicks#messageBoardsThreadsPanel</name><value>closed</value></preference><preference><name>com.liferay.portal.util.SessionClicks#layoutsTreeRootNode</name><value>1</value></preference><preference><name>com.liferay.portal.util.SessionClicks#toggle_id_users_admin_user_search</name><value>basic</value></preference></portlet-preferences>'),(10637,10157,4,'<portlet-preferences />'),(10858,10839,4,'<portlet-preferences><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-content</name><value>closed</value></preference><preference><name>com.liferay.portal.util.SessionClicks#liferay_dockbar_pinned</name><value>0</value></preference></portlet-preferences>'),(12121,12102,4,'<portlet-preferences><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-portal</name><value>open</value></preference><preference><name>com.liferay.portal.util.SessionClicks#show-portlet-description-136</name><value>1</value></preference><preference><name>com.liferay.portal.util.SessionClicks#usersAdminOrganizationsPanel</name><value>open</value></preference><preference><name>com.liferay.portal.util.SessionTreeJSClicks#layoutsTree</name><value>12,35,37,</value></preference><preference><name>125#users-order-by-col</name><value>screen-name</value></preference><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-content</name><value>open</value></preference><preference><name>com.liferay.portal.model.CustomizedPages15201#column-1</name><value>48_INSTANCE_kkisgkTbNtZ1</value></preference><preference><name>com.liferay.portal.util.SessionClicks#show-portlet-description-2</name><value>0</value></preference><preference><name>com.liferay.portal.model.CustomizedPages15201#modifiedDate</name><value>20130510082327</value></preference><preference><name>128#roles-order-by-col</name><value>name</value></preference><preference><name>125#organizations-order-by-col</name><value>screen-name</value></preference><preference><name>128#roles-order-by-type</name><value>asc</value></preference><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-server</name><value>open</value></preference><preference><name>com.liferay.portal.util.SessionClicks#usersAdminUsersPanel</name><value>open</value></preference><preference><name>125#organizations-order-by-type</name><value>asc</value></preference><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-my</name><value>open</value></preference><preference><name>com.liferay.portal.util.SessionClicks#liferay_toggle_controls</name><value>visible</value></preference><preference><name>125#users-order-by-type</name><value>asc</value></preference><preference><name>com.liferay.portal.util.SessionClicks#iframeAuthenticationPanel</name><value>open</value></preference><preference><name>com.liferay.portal.util.SessionClicks#toggle_id_users_admin_user_search</name><value>advanced</value></preference></portlet-preferences>'),(12141,12122,4,'<portlet-preferences />'),(12221,12202,4,'<portlet-preferences />'),(12420,12401,4,'<portlet-preferences />'),(12821,12801,4,'<portlet-preferences />'),(12930,12901,4,'<portlet-preferences />'),(12941,12910,4,'<portlet-preferences />'),(13377,13202,4,'<portlet-preferences />'),(13390,13212,4,'<portlet-preferences />'),(13415,13221,4,'<portlet-preferences />'),(13430,13230,4,'<portlet-preferences />'),(13443,13239,4,'<portlet-preferences />'),(13456,13248,4,'<portlet-preferences />'),(13469,13258,4,'<portlet-preferences />'),(13482,13267,4,'<portlet-preferences />'),(13495,13289,4,'<portlet-preferences />'),(13508,13318,4,'<portlet-preferences />'),(13521,13327,4,'<portlet-preferences />'),(13534,13338,4,'<portlet-preferences />'),(13571,13552,4,'<portlet-preferences />'),(13721,13702,4,'<portlet-preferences />'),(15946,15914,4,'<portlet-preferences />'),(14206,14201,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14219,14214,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14233,14228,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14252,14247,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14264,14259,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14278,14273,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14292,14287,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14306,14301,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14320,14315,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14337,14332,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14353,14348,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14374,14369,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14390,14385,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14408,14403,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14426,14421,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(14635,14451,4,'<portlet-preferences />'),(14655,14636,4,'<portlet-preferences><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-content</name><value>closed</value></preference><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-my</name><value>open</value></preference></portlet-preferences>'),(14671,14442,4,'<portlet-preferences><preference><name>com.liferay.portal.util.SessionClicks#panel-manage-content</name><value>closed</value></preference></portlet-preferences>'),(14820,14801,4,'<portlet-preferences />'),(14920,14901,4,'<portlet-preferences />'),(15074,15069,6,'<portlet-preferences><preference><name>reminderQueries_bg_BG</name><value></value></preference><preference><name>reminderQueries_hr_HR</name><value></value></preference><preference><name>reminderQueries_hi_IN</name><value></value></preference><preference><name>reminderQueries_lo_LA</name><value></value></preference><preference><name>reminderQueries_ca_ES</name><value></value></preference><preference><name>reminderQueries_ca_AD</name><value></value></preference><preference><name>reminderQueries_ro_RO</name><value></value></preference><preference><name>reminderQueries_hu_HU</name><value></value></preference><preference><name>reminderQueries_pt_PT</name><value></value></preference><preference><name>reminderQueries_eu_ES</name><value></value></preference><preference><name>reminderQueries_sr_RS_latin</name><value></value></preference><preference><name>reminderQueries_fi_FI</name><value></value></preference><preference><name>reminderQueries_ar_SA</name><value></value></preference><preference><name>reminderQueries_it_IT</name><value></value></preference><preference><name>reminderQueries_sl_SI</name><value></value></preference><preference><name>reminderQueries_sr_RS</name><value></value></preference><preference><name>reminderQueries_pl_PL</name><value></value></preference><preference><name>reminderQueries_sv_SE</name><value></value></preference><preference><name>reminderQueries_es_ES</name><value></value></preference><preference><name>reminderQueries_zh_CN</name><value></value></preference><preference><name>reminderQueries_nl_NL</name><value></value></preference><preference><name>reminderQueries_da_DK</name><value></value></preference><preference><name>reminderQueries_en_GB</name><value></value></preference><preference><name>reminderQueries_iw_IL</name><value></value></preference><preference><name>reminderQueries_in_ID</name><value></value></preference><preference><name>reminderQueries_nl_BE</name><value></value></preference><preference><name>reminderQueries_nb_NO</name><value></value></preference><preference><name>reminderQueries_et_EE</name><value></value></preference><preference><name>reminderQueries_tr_TR</name><value></value></preference><preference><name>reminderQueries_el_GR</name><value></value></preference><preference><name>reminderQueries_vi_VN</name><value></value></preference><preference><name>reminderQueries_sk_SK</name><value></value></preference><preference><name>reminderQueries_pt_BR</name><value></value></preference><preference><name>reminderQueries</name><value></value></preference><preference><name>reminderQueries_cs_CZ</name><value></value></preference><preference><name>reminderQueries_fr_FR</name><value></value></preference><preference><name>reminderQueries_gl_ES</name><value></value></preference><preference><name>reminderQueries_zh_TW</name><value></value></preference><preference><name>reminderQueries_uk_UA</name><value></value></preference><preference><name>reminderQueries_fa_IR</name><value></value></preference><preference><name>reminderQueries_ja_JP</name><value></value></preference><preference><name>reminderQueries_ko_KR</name><value></value></preference><preference><name>reminderQueries_de_DE</name><value></value></preference><preference><name>reminderQueries_ru_RU</name><value></value></preference></portlet-preferences>'),(15104,15077,4,'<portlet-preferences />'),(15966,15947,4,'<portlet-preferences />'),(15995,15976,4,'<portlet-preferences />'),(16006,15967,4,'<portlet-preferences />'),(16017,15924,4,'<portlet-preferences />'),(16213,15502,4,'<portlet-preferences />'),(16327,16308,4,'<portlet-preferences />'),(16421,16402,4,'<portlet-preferences />'),(16441,16422,4,'<portlet-preferences />'),(16461,16442,4,'<portlet-preferences />'),(16481,16462,4,'<portlet-preferences />');
/*!40000 ALTER TABLE `portalpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listtype`
--

DROP TABLE IF EXISTS `listtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `listtype` (
  `listTypeId` int(11) NOT NULL,
  `name` varchar(75) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`listTypeId`),
  KEY `IX_2932DD37` (`type_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listtype`
--

LOCK TABLES `listtype` WRITE;
/*!40000 ALTER TABLE `listtype` DISABLE KEYS */;
INSERT INTO `listtype` VALUES (10000,'billing','com.liferay.portal.model.Account.address'),(10001,'other','com.liferay.portal.model.Account.address'),(10002,'p-o-box','com.liferay.portal.model.Account.address'),(10003,'shipping','com.liferay.portal.model.Account.address'),(10004,'email-address','com.liferay.portal.model.Account.emailAddress'),(10005,'email-address-2','com.liferay.portal.model.Account.emailAddress'),(10006,'email-address-3','com.liferay.portal.model.Account.emailAddress'),(10007,'fax','com.liferay.portal.model.Account.phone'),(10008,'local','com.liferay.portal.model.Account.phone'),(10009,'other','com.liferay.portal.model.Account.phone'),(10010,'toll-free','com.liferay.portal.model.Account.phone'),(10011,'tty','com.liferay.portal.model.Account.phone'),(10012,'intranet','com.liferay.portal.model.Account.website'),(10013,'public','com.liferay.portal.model.Account.website'),(11000,'business','com.liferay.portal.model.Contact.address'),(11001,'other','com.liferay.portal.model.Contact.address'),(11002,'personal','com.liferay.portal.model.Contact.address'),(11003,'email-address','com.liferay.portal.model.Contact.emailAddress'),(11004,'email-address-2','com.liferay.portal.model.Contact.emailAddress'),(11005,'email-address-3','com.liferay.portal.model.Contact.emailAddress'),(11006,'business','com.liferay.portal.model.Contact.phone'),(11007,'business-fax','com.liferay.portal.model.Contact.phone'),(11008,'mobile-phone','com.liferay.portal.model.Contact.phone'),(11009,'other','com.liferay.portal.model.Contact.phone'),(11010,'pager','com.liferay.portal.model.Contact.phone'),(11011,'personal','com.liferay.portal.model.Contact.phone'),(11012,'personal-fax','com.liferay.portal.model.Contact.phone'),(11013,'tty','com.liferay.portal.model.Contact.phone'),(11014,'dr','com.liferay.portal.model.Contact.prefix'),(11015,'mr','com.liferay.portal.model.Contact.prefix'),(11016,'mrs','com.liferay.portal.model.Contact.prefix'),(11017,'ms','com.liferay.portal.model.Contact.prefix'),(11020,'ii','com.liferay.portal.model.Contact.suffix'),(11021,'iii','com.liferay.portal.model.Contact.suffix'),(11022,'iv','com.liferay.portal.model.Contact.suffix'),(11023,'jr','com.liferay.portal.model.Contact.suffix'),(11024,'phd','com.liferay.portal.model.Contact.suffix'),(11025,'sr','com.liferay.portal.model.Contact.suffix'),(11026,'blog','com.liferay.portal.model.Contact.website'),(11027,'business','com.liferay.portal.model.Contact.website'),(11028,'other','com.liferay.portal.model.Contact.website'),(11029,'personal','com.liferay.portal.model.Contact.website'),(12000,'billing','com.liferay.portal.model.Organization.address'),(12001,'other','com.liferay.portal.model.Organization.address'),(12002,'p-o-box','com.liferay.portal.model.Organization.address'),(12003,'shipping','com.liferay.portal.model.Organization.address'),(12004,'email-address','com.liferay.portal.model.Organization.emailAddress'),(12005,'email-address-2','com.liferay.portal.model.Organization.emailAddress'),(12006,'email-address-3','com.liferay.portal.model.Organization.emailAddress'),(12007,'fax','com.liferay.portal.model.Organization.phone'),(12008,'local','com.liferay.portal.model.Organization.phone'),(12009,'other','com.liferay.portal.model.Organization.phone'),(12010,'toll-free','com.liferay.portal.model.Organization.phone'),(12011,'tty','com.liferay.portal.model.Organization.phone'),(12012,'administrative','com.liferay.portal.model.Organization.service'),(12013,'contracts','com.liferay.portal.model.Organization.service'),(12014,'donation','com.liferay.portal.model.Organization.service'),(12015,'retail','com.liferay.portal.model.Organization.service'),(12016,'training','com.liferay.portal.model.Organization.service'),(12017,'full-member','com.liferay.portal.model.Organization.status'),(12018,'provisional-member','com.liferay.portal.model.Organization.status'),(12019,'intranet','com.liferay.portal.model.Organization.website'),(12020,'public','com.liferay.portal.model.Organization.website');
/*!40000 ALTER TABLE `listtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingitemprice`
--

DROP TABLE IF EXISTS `shoppingitemprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingitemprice` (
  `itemPriceId` bigint(20) NOT NULL,
  `itemId` bigint(20) DEFAULT NULL,
  `minQuantity` int(11) DEFAULT NULL,
  `maxQuantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `taxable` tinyint(4) DEFAULT NULL,
  `shipping` double DEFAULT NULL,
  `useShippingFormula` tinyint(4) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemPriceId`),
  KEY `IX_EA6FD516` (`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingitemprice`
--

LOCK TABLES `shoppingitemprice` WRITE;
/*!40000 ALTER TABLE `shoppingitemprice` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingitemprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layoutrevision`
--

DROP TABLE IF EXISTS `layoutrevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layoutrevision` (
  `layoutRevisionId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `layoutSetBranchId` bigint(20) DEFAULT NULL,
  `layoutBranchId` bigint(20) DEFAULT NULL,
  `parentLayoutRevisionId` bigint(20) DEFAULT NULL,
  `head` tinyint(4) DEFAULT NULL,
  `major` tinyint(4) DEFAULT NULL,
  `plid` bigint(20) DEFAULT NULL,
  `privateLayout` tinyint(4) DEFAULT NULL,
  `name` longtext,
  `title` longtext,
  `description` longtext,
  `keywords` longtext,
  `robots` longtext,
  `typeSettings` longtext,
  `iconImage` tinyint(4) DEFAULT NULL,
  `iconImageId` bigint(20) DEFAULT NULL,
  `themeId` varchar(75) DEFAULT NULL,
  `colorSchemeId` varchar(75) DEFAULT NULL,
  `wapThemeId` varchar(75) DEFAULT NULL,
  `wapColorSchemeId` varchar(75) DEFAULT NULL,
  `css` longtext,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`layoutRevisionId`),
  KEY `IX_43E8286A` (`head`,`plid`),
  KEY `IX_314B621A` (`layoutSetBranchId`),
  KEY `IX_A9AC086E` (`layoutSetBranchId`,`head`),
  KEY `IX_E10AC39` (`layoutSetBranchId`,`head`,`plid`),
  KEY `IX_13984800` (`layoutSetBranchId`,`layoutBranchId`,`plid`),
  KEY `IX_4A84AF43` (`layoutSetBranchId`,`parentLayoutRevisionId`,`plid`),
  KEY `IX_B7B914E5` (`layoutSetBranchId`,`plid`),
  KEY `IX_70DA9ECB` (`layoutSetBranchId`,`plid`,`status`),
  KEY `IX_7FFAE700` (`layoutSetBranchId`,`status`),
  KEY `IX_9329C9D6` (`plid`),
  KEY `IX_8EC3D2BC` (`plid`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layoutrevision`
--

LOCK TABLES `layoutrevision` WRITE;
/*!40000 ALTER TABLE `layoutrevision` DISABLE KEYS */;
/*!40000 ALTER TABLE `layoutrevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfileentrytypes_ddmstructures`
--

DROP TABLE IF EXISTS `dlfileentrytypes_ddmstructures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfileentrytypes_ddmstructures` (
  `fileEntryTypeId` bigint(20) NOT NULL,
  `structureId` bigint(20) NOT NULL,
  PRIMARY KEY (`fileEntryTypeId`,`structureId`),
  KEY `IX_8373EC7C` (`fileEntryTypeId`),
  KEY `IX_F147CF3F` (`structureId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfileentrytypes_ddmstructures`
--

LOCK TABLES `dlfileentrytypes_ddmstructures` WRITE;
/*!40000 ALTER TABLE `dlfileentrytypes_ddmstructures` DISABLE KEYS */;
INSERT INTO `dlfileentrytypes_ddmstructures` VALUES (10300,10301),(10302,10298),(10302,10303),(10304,10297),(10304,10305),(10306,10299),(10306,10307);
/*!40000 ALTER TABLE `dlfileentrytypes_ddmstructures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetentry`
--

DROP TABLE IF EXISTS `assetentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetentry` (
  `entryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `classUuid` varchar(75) DEFAULT NULL,
  `classTypeId` bigint(20) DEFAULT NULL,
  `visible` tinyint(4) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `publishDate` datetime DEFAULT NULL,
  `expirationDate` datetime DEFAULT NULL,
  `mimeType` varchar(75) DEFAULT NULL,
  `title` longtext,
  `description` longtext,
  `summary` longtext,
  `url` longtext,
  `layoutUuid` varchar(75) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `priority` double DEFAULT NULL,
  `viewCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`entryId`),
  UNIQUE KEY `IX_1E9D371D` (`classNameId`,`classPK`),
  KEY `IX_FC1F9C7B` (`classUuid`),
  KEY `IX_7306C60` (`companyId`),
  KEY `IX_75D42FF9` (`expirationDate`),
  KEY `IX_1EBA6821` (`groupId`,`classUuid`),
  KEY `IX_2E4E3885` (`publishDate`),
  KEY `IX_9029E15A` (`visible`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetentry`
--

LOCK TABLES `assetentry` WRITE;
/*!40000 ALTER TABLE `assetentry` DISABLE KEYS */;
INSERT INTO `assetentry` VALUES (10177,10171,10153,10157,'','2012-09-10 08:56:29','2012-09-10 08:56:29',10117,10175,'0b9d6f2d-57ea-41f0-9457-27437ac641f8',0,0,NULL,NULL,NULL,NULL,'text/html','10174','','','','',0,0,0,0),(10317,10310,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38',10117,10314,'a4d10364-c621-45d9-b908-c197eae636f6',0,0,NULL,NULL,NULL,NULL,'text/html','10313','','','','',0,0,0,0),(10326,10320,10153,10157,'','2012-09-10 08:56:39','2012-09-10 08:56:39',10117,10324,'2c515e4a-475f-43ee-b845-2f1692e0f08f',0,0,NULL,NULL,NULL,NULL,'text/html','10323','','','','',0,0,0,0),(10335,10329,10153,10157,'','2012-09-10 08:56:39','2012-09-10 08:56:39',10117,10333,'8cd658de-d5ef-40c1-90cb-6b272412015f',0,0,NULL,NULL,NULL,NULL,'text/html','10332','','','','',0,0,0,0),(10349,10338,10153,10157,'','2012-09-10 08:56:45','2012-09-10 08:56:45',10117,10347,'30aa2add-c068-47c8-912a-bb0d70587bf8',0,0,NULL,NULL,NULL,NULL,'text/html','10346','','','','',0,0,0,0),(10355,10338,10153,10157,'','2012-09-10 08:56:45','2012-09-10 08:56:45',10117,10353,'8f423061-446f-4c7d-b522-35ac8326e5a2',0,0,NULL,NULL,NULL,NULL,'text/html','10352','','','','',0,0,0,0),(10361,10338,10153,10157,'','2012-09-10 08:56:45','2012-09-10 08:56:45',10117,10359,'f0dd6772-164f-4c12-a04c-e2490306fb6a',0,0,NULL,NULL,NULL,NULL,'text/html','10358','','','','',0,0,0,0),(10375,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10117,10373,'cda5718c-a96c-4de4-96bb-c48dc8047712',0,0,NULL,NULL,NULL,NULL,'text/html','10372','','','','',0,0,0,0),(10383,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10117,10381,'6df5d5c4-44c2-4acc-a62e-e8a10033feb4',0,0,NULL,NULL,NULL,NULL,'text/html','10380','','','','',0,0,0,0),(10389,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10117,10387,'8ef3b62e-c426-47ba-acab-bd6b1a31c295',0,0,NULL,NULL,NULL,NULL,'text/html','10386','','','','',0,0,0,0),(10395,10364,10153,10157,'','2012-09-10 08:56:46','2012-09-10 08:56:46',10117,10393,'0f45fefc-4d59-48d9-9c09-b984eb37722f',0,0,NULL,NULL,NULL,NULL,'text/html','10392','','','','',0,0,0,0),(10426,10179,10153,10157,'','2012-09-10 08:56:54','2012-09-10 08:56:54',10010,10419,'068f742f-ddac-4214-96c0-70f51b14e43b',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_3.jpg','','','','',0,0,0,0),(10429,10179,10153,10157,'','2012-09-10 08:56:54','2012-09-10 08:56:54',10117,10427,'caaadc21-a70c-4145-8d02-8f67ae8c4bea',0,0,NULL,NULL,NULL,NULL,'text/html','10419','','','','',0,0,0,0),(10436,10179,10153,10157,'','2012-09-10 08:56:55','2012-09-10 08:56:55',10010,10433,'ba3cd525-bf69-4d62-b116-52bb08e6e83d',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_11.jpg','','','','',0,0,0,0),(10439,10179,10153,10157,'','2012-09-10 08:56:55','2012-09-10 08:56:55',10117,10437,'a47f8bc9-7fc6-4557-a294-9b4eed8f8d0c',0,0,NULL,NULL,NULL,NULL,'text/html','10433','','','','',0,0,0,0),(10446,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10010,10444,'0107fbe8-7216-415f-b52a-4ccc58b1ed94',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_12.jpg','','','','',0,0,0,0),(10449,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10117,10447,'0baffd11-8b46-43c5-ba63-0acc110208ca',0,0,NULL,NULL,NULL,NULL,'text/html','10444','','','','',0,0,0,0),(10455,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10010,10452,'5f6a7b5d-40f5-44f7-9374-4b8e6a761ab5',0,1,NULL,NULL,NULL,NULL,'image/png','welcome_bg_10.png','','','','',0,0,0,0),(10458,10179,10153,10157,'','2012-09-10 08:56:56','2012-09-10 08:56:56',10117,10456,'4dba900f-65d2-4648-9f3c-c423515dc512',0,0,NULL,NULL,NULL,NULL,'text/html','10452','','','','',0,0,0,0),(10471,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10010,10465,'d5c27f88-fd99-4b14-b799-a8693f91cd73',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_2.jpg','','','','',0,0,0,1),(10474,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10117,10472,'de2d682a-494f-426c-a8d2-8887b97af335',0,0,NULL,NULL,NULL,NULL,'text/html','10465','','','','',0,0,0,0),(10483,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10010,10477,'a4deb9c1-ce55-4c8d-a4a9-cd61bc9ad1c5',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_9.jpg','','','','',0,0,0,0),(10486,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10117,10484,'75d9b05b-0135-43cf-bf5d-b0394e66b309',0,0,NULL,NULL,NULL,NULL,'text/html','10477','','','','',0,0,0,0),(10495,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10010,10493,'f02472f3-8d71-4305-a26e-92884af82fef',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_4.jpg','','','','',0,0,0,0),(10498,10179,10153,10157,'','2012-09-10 08:56:57','2012-09-10 08:56:57',10117,10496,'2f26e317-f5c5-47b0-90dc-8b6cdbbe4b8f',0,0,NULL,NULL,NULL,NULL,'text/html','10493','','','','',0,0,0,0),(10507,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10010,10505,'2fa90a9b-c8b2-4083-80a5-d0dbe8cae6de',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_6.jpg','','','','',0,0,0,0),(10510,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10117,10508,'5c63da0d-56ea-4e19-bb2f-34a62b177532',0,0,NULL,NULL,NULL,NULL,'text/html','10505','','','','',0,0,0,0),(10523,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10010,10517,'e6f1975c-5f13-4ace-ab23-378458c3d7be',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_7.jpg','','','','',0,0,0,0),(10526,10179,10153,10157,'','2012-09-10 08:56:58','2012-09-10 08:56:58',10117,10524,'0b26b96d-6214-4b93-85a4-af51c3e64f83',0,0,NULL,NULL,NULL,NULL,'text/html','10517','','','','',0,0,0,0),(10535,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10530,'b7e62e15-d2cf-428e-ba1a-fe95ed129375',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_5.jpg','','','','',0,0,0,0),(10538,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10117,10536,'58b4d5bb-68fd-4b90-9e3f-8115c5e15f22',0,0,NULL,NULL,NULL,NULL,'text/html','10530','','','','',0,0,0,0),(10547,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10542,'2b98a30e-b5f7-4afa-8b0e-f220c318d8d4',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_13.jpg','','','','',0,0,0,0),(10550,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10117,10548,'5e623edd-785e-472c-b7d0-57de0965868c',0,0,NULL,NULL,NULL,NULL,'text/html','10542','','','','',0,0,0,0),(10559,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10553,'d25df879-c9eb-4fbc-8dc1-fad3589dfae2',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_1.jpg','','','','',0,0,0,3),(10562,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10117,10560,'e9491e11-4ed2-4b7d-9e29-85a07882c772',0,0,NULL,NULL,NULL,NULL,'text/html','10553','','','','',0,0,0,0),(10571,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10010,10566,'5b6cf4a9-eb60-471d-804c-7d45660670b2',0,1,NULL,NULL,NULL,NULL,'image/jpeg','welcome_bg_8.jpg','','','','',0,0,0,0),(10574,10179,10153,10157,'','2012-09-10 08:56:59','2012-09-10 08:56:59',10117,10572,'4647e70c-57fe-431a-a7de-270ebd37136b',0,0,NULL,NULL,NULL,NULL,'text/html','10566','','','','',0,0,0,0),(10584,10179,10153,10157,'','2012-09-10 08:57:00','2012-09-10 08:57:00',10108,10582,'02f4a2f4-16cc-44be-8c88-512837f7ea6f',0,1,NULL,NULL,'2010-02-01 00:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Who Is Using Liferay</Title></root>','','','','',0,0,0,0),(10587,10179,10153,10157,'','2012-09-10 08:57:00','2012-09-10 08:57:00',10117,10585,'b89f9d9e-b294-4953-a972-098941ec66ed',0,0,NULL,NULL,NULL,NULL,'text/html','10582','','','','',0,0,0,0),(10598,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10108,10596,'c906870b-3d9b-4279-bdb2-4dba71526b96',10591,1,NULL,NULL,'2010-02-01 00:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Liferay Benefits</Title></root>','','','','',0,0,0,1),(10601,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10117,10599,'c8c23e32-51eb-41ed-ae79-defd4c08570b',0,0,NULL,NULL,NULL,NULL,'text/html','10596','','','','',0,0,0,0),(10606,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10108,10604,'46543336-c2e5-4055-bccf-1a052c9c77fc',10591,1,NULL,NULL,'2010-02-01 00:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">What We Do</Title></root>','','','','',0,0,0,88),(10609,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10117,10607,'b1e96876-0a45-4d99-89fd-10967952071f',0,0,NULL,NULL,NULL,NULL,'text/html','10604','','','','',0,0,0,0),(10614,10179,10153,10157,'','2012-09-10 08:57:01','2012-09-10 08:57:01',10117,10612,'77a588a7-7edd-4098-aabc-b685811b807c',0,0,NULL,NULL,NULL,NULL,'text/html','10611','','','','',0,0,0,0),(18104,10179,10153,12102,'Admin Admin','2014-01-03 11:21:41','2014-01-03 11:21:41',10117,18102,'e760e790-c17d-4be7-b95d-130e5ae649f8',0,0,NULL,NULL,NULL,NULL,'text/html','18101','','','','',0,0,0,0),(18109,10179,10153,12102,'Admin Admin','2014-01-03 11:22:06','2014-01-03 11:22:06',10117,18107,'b9f28045-219b-4318-80c1-64bd87966ba6',0,0,NULL,NULL,NULL,NULL,'text/html','18106','','','','',0,0,0,0),(11505,10179,10153,10195,'Test Test','2012-09-26 09:52:16','2012-09-26 09:52:16',10117,11503,'9d55e46f-bf10-45a9-add8-5fce26479e9a',0,0,NULL,NULL,NULL,NULL,'text/html','11502','','','','',0,0,0,0),(18303,10191,10153,12102,'Admin Admin','2014-03-04 08:49:43','2014-03-04 08:49:43',10010,18301,'2f96a36c-df13-4aba-b148-ff0b95d3cd53',0,1,NULL,NULL,NULL,NULL,'image/jpeg','bkg-index.jpg','','','','',0,0,0,9),(11615,11605,10153,10157,'','2012-09-26 15:45:39','2012-09-26 15:45:39',10010,11613,'d1ec5a7d-7a2d-4441-95db-4139d93c51c2',0,1,NULL,NULL,NULL,NULL,'image/png','trophy_icon.png','','','','',0,0,0,0),(11618,11605,10153,10157,'','2012-09-26 15:45:39','2012-09-26 15:45:39',10117,11616,'9a537ff1-6c5b-4970-a3b8-61bf97bcd4b2',0,0,NULL,NULL,NULL,NULL,'text/html','11613','','','','',0,0,0,0),(11623,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',10010,11621,'89e0fc78-6945-4566-849d-91e6a2e88944',0,1,NULL,NULL,NULL,NULL,'image/png','image3.png','','','','',0,0,0,0),(11626,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',10117,11624,'d9e80adf-27a0-4918-92f3-a6755e175f67',0,0,NULL,NULL,NULL,NULL,'text/html','11621','','','','',0,0,0,0),(11632,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',10010,11630,'945d2d6b-b3ee-4fa4-b94b-26fec1bd94c9',0,1,NULL,NULL,NULL,NULL,'image/png','download_icon.png','','','','',0,0,0,0),(11635,11605,10153,10157,'','2012-09-26 15:45:40','2012-09-26 15:45:40',10117,11633,'eb0ec6aa-98b8-4bc7-88aa-291c36644262',0,0,NULL,NULL,NULL,NULL,'text/html','11630','','','','',0,0,0,0),(11640,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',10010,11638,'64faafc9-fe6d-4ef8-bed0-49a99da3cc60',0,1,NULL,NULL,NULL,NULL,'image/png','image2.png','','','','',0,0,0,0),(11643,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',10117,11641,'edc809ca-3b46-4e4f-bede-d7a4c78ecba8',0,0,NULL,NULL,NULL,NULL,'text/html','11638','','','','',0,0,0,0),(11649,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',10010,11646,'428bed71-cec0-4e6b-be48-c7a2b1d7cd61',0,1,NULL,NULL,NULL,NULL,'image/png','image1.png','','','','',0,0,0,0),(11653,11605,10153,10157,'','2012-09-26 15:45:41','2012-09-26 15:45:41',10117,11651,'388367fe-c83a-4716-9ce7-4a7b2ea02056',0,0,NULL,NULL,NULL,NULL,'text/html','11646','','','','',0,0,0,0),(11660,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',10010,11658,'db0dce92-e663-495b-9e34-a87a912d6638',0,1,NULL,NULL,NULL,NULL,'image/png','strategy_icon.png','','','','',0,0,0,0),(11665,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',10117,11661,'bedd8adb-1d54-4fb7-9f1f-d1cd6fb9b1a6',0,0,NULL,NULL,NULL,NULL,'text/html','11658','','','','',0,0,0,0),(11671,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',10010,11669,'fed7a05f-fd0a-4126-8944-4f1fabccb73a',0,1,NULL,NULL,NULL,NULL,'image/png','gears_icon.png','','','','',0,0,0,0),(11674,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42',10117,11672,'e6f86b61-0253-4b40-b9e6-a15f14597d9a',0,0,NULL,NULL,NULL,NULL,'text/html','11669','','','','',0,0,0,0),(11705,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10108,11703,'6ebfd0a1-5522-43b8-a407-ce135e819588',11682,1,NULL,NULL,'2010-02-01 11:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Innovating For Over 30 Years</Title></root>','','','','',0,0,0,0),(11708,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10117,11706,'c5860997-007f-478a-8b28-14d9f07bcc57',0,0,NULL,NULL,NULL,NULL,'text/html','11703','','','','',0,0,0,0),(11719,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10108,11717,'83cc3990-b15f-4ea1-8bcd-d2faf35cea1d',11712,1,NULL,NULL,'2010-02-01 11:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Our Strategy</Title></root>','','','','',0,0,0,0),(11722,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10117,11720,'cf57f0a2-c57e-4699-9493-66152fe6284c',0,0,NULL,NULL,NULL,NULL,'text/html','11717','','','','',0,0,0,0),(11727,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10108,11725,'1c13d446-e273-490e-ad98-b3e61fda8058',11712,1,NULL,NULL,'2010-02-01 11:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Our Achievements</Title></root>','','','','',0,0,0,0),(11730,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44',10117,11728,'20b2fb15-df9f-430c-bcb6-141893e54a41',0,0,NULL,NULL,NULL,NULL,'text/html','11725','','','','',0,0,0,0),(11735,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10108,11733,'32767481-cf27-4a0d-a76c-c37cc89b07aa',11712,1,NULL,NULL,'2010-02-01 11:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">How Do We Do It</Title></root>','','','','',0,0,0,0),(11738,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10117,11736,'909c194e-e41c-42ee-aaff-87de67346657',0,0,NULL,NULL,NULL,NULL,'text/html','11733','','','','',0,0,0,0),(11746,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10108,11744,'8f207c2c-8657-4216-b6b6-aa61b7513e89',11712,1,NULL,NULL,'2010-02-01 11:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Download Pod</Title></root>','','','','',0,0,0,0),(11749,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10117,11747,'d30b9533-a204-49b2-ac54-ee811b6ae19e',0,0,NULL,NULL,NULL,NULL,'text/html','11744','','','','',0,0,0,0),(11759,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10108,11755,'62954c04-6d1f-4d4c-aee5-54e8a1afeb80',11712,1,NULL,NULL,'2010-02-01 11:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Who We Are</Title></root>','','','','',0,0,0,0),(11762,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10117,11760,'a5483515-66ad-4ffe-b7d3-2a848af3b1bd',0,0,NULL,NULL,NULL,NULL,'text/html','11755','','','','',0,0,0,0),(11774,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45',10108,11772,'382bcf9f-46ad-460d-b75e-156d2b062152',11767,1,NULL,NULL,'2010-02-01 11:00:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Home Carousel</Title></root>','','','','',0,0,0,0),(11777,11605,10153,10157,'','2012-09-26 15:45:46','2012-09-26 15:45:46',10117,11775,'67bb51d3-b115-4f46-9cb3-71ed6724ab71',0,0,NULL,NULL,NULL,NULL,'text/html','11772','','','','',0,0,0,0),(11782,11605,10153,10157,'','2012-09-26 15:45:48','2012-09-26 15:45:48',10117,11780,'671d1b6d-fb23-4b2e-921c-6451db017a36',0,0,NULL,NULL,NULL,NULL,'text/html','11779','','','','',0,0,0,0),(11807,10179,10153,10195,'Test Test','2012-09-27 08:55:18','2013-12-23 12:10:09',10108,11805,'53388af0-3ed9-46b5-9132-78670cce19f4',0,1,NULL,NULL,'2012-09-27 08:54:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Fitman Portal</Title></root>','','','','',0,0,0,1000),(11810,10179,10153,10195,'Test Test','2012-09-27 08:55:18','2012-09-27 08:55:18',10117,11808,'d1572ca2-bca8-4e09-9154-0a48df2b94d6',0,0,NULL,NULL,NULL,NULL,'text/html','11805','','','','',0,0,0,0),(12107,10191,10153,10195,'Test Test','2012-10-04 14:55:24','2013-12-19 14:01:09',10005,12102,'8b9b469e-ac21-496e-a4a1-ad40f6f0cb0c',0,0,NULL,NULL,NULL,NULL,'','Admin Admin','','','','',0,0,0,0),(12114,12104,10153,12102,'Admin Amin','2012-10-04 14:56:41','2012-10-04 14:56:41',10117,12112,'8c81d1b9-e899-4411-b08d-dbd44731b28c',0,0,NULL,NULL,NULL,NULL,'text/html','12111','','','','',0,0,0,0),(12119,12104,10153,12102,'Admin Amin','2012-10-04 14:56:41','2012-10-04 14:56:41',10117,12117,'8fe13f3b-5907-4a96-bb3c-9f927564eb24',0,0,NULL,NULL,NULL,NULL,'text/html','12116','','','','',0,0,0,0),(13121,10191,10153,12102,'Admin Amin','2012-11-29 11:49:59','2012-11-29 11:49:59',10010,13119,'fa67ae45-0000-4b0c-bdc6-660450a826af',0,1,NULL,NULL,NULL,NULL,'image/jpeg','SouthAmerica.jpg','','','','',0,0,0,51),(13124,10191,10153,12102,'Admin Amin','2012-11-29 11:49:59','2012-11-29 11:49:59',10117,13122,'228b7711-e887-4711-98c5-f3197841a832',0,0,NULL,NULL,NULL,NULL,'text/html','13119','','','','',0,0,0,0),(13138,10191,10153,12102,'Admin Amin','2012-11-29 11:57:31','2012-11-29 11:57:31',10010,13136,'5f8df2be-67f4-4573-908b-6ed37bddd4c6',0,1,NULL,NULL,NULL,NULL,'image/jpeg','M&S.jpeg','','','','',0,0,0,51),(13141,10191,10153,12102,'Admin Amin','2012-11-29 11:57:31','2012-11-29 11:57:31',10117,13139,'e35c0bc9-93e9-48e3-9bda-4ac1c5421183',0,0,NULL,NULL,NULL,NULL,'text/html','13136','','','','',0,0,0,0),(13154,10191,10153,12102,'Admin Amin','2012-11-29 12:09:56','2012-11-29 12:09:56',10010,13152,'93dd05f8-fae4-4cd2-9a43-de40a73e9249',0,1,NULL,NULL,NULL,NULL,'image/jpeg','configurator.jpeg','','','','',0,0,0,417),(13157,10191,10153,12102,'Admin Amin','2012-11-29 12:09:56','2012-11-29 12:09:56',10117,13155,'e978a26a-53a8-47b5-ba58-f872ddb238b9',0,0,NULL,NULL,NULL,NULL,'text/html','13152','','','','',0,0,0,0),(13174,10179,10153,12102,'Admin Amin','2012-11-29 13:38:24','2012-11-29 15:09:43',10108,13172,'da9a3134-12bd-4693-a42f-57e219bf976d',0,1,NULL,NULL,'2012-11-29 13:35:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">For Partners</Title></root>','','','','',0,0,0,28809),(13177,10179,10153,12102,'Admin Amin','2012-11-29 13:38:24','2012-11-29 13:38:24',10117,13175,'7c497b7a-be0f-4881-aa22-6970b38bf790',0,0,NULL,NULL,NULL,NULL,'text/html','13172','','','','',0,0,0,0),(13189,10191,10153,12102,'Admin Amin','2012-11-29 13:58:27','2012-11-29 13:58:27',10010,13187,'114d0615-8445-4cb2-871d-99ef6559128e',0,1,NULL,NULL,NULL,NULL,'image/png','upload-textile-machinery.png','','','','',0,0,0,433),(13192,10191,10153,12102,'Admin Amin','2012-11-29 13:58:27','2012-11-29 13:58:27',10117,13190,'b9c5368b-9f58-4a80-946b-7d2ae33f08e7',0,0,NULL,NULL,NULL,NULL,'text/html','13187','','','','',0,0,0,0),(13278,10191,10153,12102,'Admin Amin','2012-11-29 14:28:41','2012-11-29 14:28:41',10010,13276,'985ba964-426c-4193-9456-6b8c64be1f85',0,1,NULL,NULL,NULL,NULL,'image/png','europe-partners.png','','','','',0,0,0,1),(13281,10191,10153,12102,'Admin Amin','2012-11-29 14:28:41','2012-11-29 14:28:41',10117,13279,'12697732-3368-4dc3-a2ca-40dfd8bd8ed3',0,0,NULL,NULL,NULL,NULL,'text/html','13276','','','','',0,0,0,0),(18306,10191,10153,12102,'Admin Admin','2014-03-04 08:49:43','2014-03-04 08:49:43',10117,18304,'e9c2a481-a924-45b6-a3b3-5c5d56b1d1ba',0,0,NULL,NULL,NULL,NULL,'text/html','18301','','','','',0,0,0,0),(13312,10179,10153,12102,'Admin Amin','2012-11-29 14:30:26','2014-03-04 08:56:39',10108,13310,'78499ff2-88dd-4798-86a6-1270c12c53f1',0,1,NULL,NULL,'2012-11-29 14:13:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Future Internet Technologies for MANufacturing industries</Title></root>','','','','',0,0,0,23785),(13315,10179,10153,12102,'Admin Amin','2012-11-29 14:30:26','2012-11-29 14:30:26',10117,13313,'244cc0ba-5f38-4801-beff-e14f4de49336',0,0,NULL,NULL,NULL,NULL,'text/html','13310','','','','',0,0,0,0),(13349,10191,10153,12102,'Admin Amin','2012-11-29 14:36:17','2012-11-29 14:36:17',10010,13347,'e7f6cc2d-bba1-43d8-9f67-f8a82f8aacb5',0,1,NULL,NULL,NULL,NULL,'image/png','europe-partners1.png','','','','',0,0,0,460),(13352,10191,10153,12102,'Admin Amin','2012-11-29 14:36:17','2012-11-29 14:36:17',10117,13350,'f239f5e0-2b4f-4759-bc2b-734c3afed345',0,0,NULL,NULL,NULL,NULL,'text/html','13347','','','','',0,0,0,0),(14104,10179,10153,12102,'Admin Amin','2013-04-03 10:51:46','2013-04-03 10:51:46',10117,14102,'b90a270d-c222-41db-abab-1e2ea93bcddd',0,0,NULL,NULL,NULL,NULL,'text/html','14101','','','','',0,0,0,0),(15224,10179,10153,12102,'Admin Amin','2013-05-10 08:47:02','2013-05-10 08:47:02',10108,15222,'5ab864d6-8848-4cab-a0ee-a8b67d9138ba',0,0,NULL,NULL,'2013-05-10 08:45:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','','','','',0,0,0,0),(15227,10179,10153,12102,'Admin Amin','2013-05-10 08:47:02','2013-05-10 08:47:02',10117,15225,'145577d0-21b6-4c89-9c36-2533aa306a50',0,0,NULL,NULL,NULL,NULL,'text/html','15222','','','','',0,0,0,0),(15234,10179,10153,12102,'Admin Amin','2013-05-10 08:47:07','2013-05-10 08:47:07',10108,15232,'007ce382-0486-4053-bbd0-fd9737a29483',0,1,NULL,NULL,'2013-05-10 08:45:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','','','','',0,0,0,0),(15237,10179,10153,12102,'Admin Amin','2013-05-10 08:47:07','2013-05-10 08:47:07',10117,15235,'f08f5f68-e8b2-4863-88f4-63de1ed73de6',0,0,NULL,NULL,NULL,NULL,'text/html','15232','','','','',0,0,0,0),(15244,10179,10153,12102,'Admin Amin','2013-05-10 08:47:15','2013-05-10 08:47:15',10108,15242,'cfaaa38d-6463-4dc0-aa3f-fd74e0ed63dc',0,1,NULL,NULL,'2013-05-10 08:45:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','','','','',0,0,0,0),(15247,10179,10153,12102,'Admin Amin','2013-05-10 08:47:15','2013-05-10 08:47:15',10117,15245,'a15178e9-d4f4-48dc-a4ce-616f394627ae',0,0,NULL,NULL,NULL,NULL,'text/html','15242','','','','',0,0,0,0),(15254,10179,10153,12102,'Admin Amin','2013-05-10 08:47:25','2013-05-10 08:47:25',10108,15252,'f34a58d8-1073-443c-9eed-bb92f721aff2',0,1,NULL,NULL,'2013-05-10 08:45:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">USDL Editor</Title></root>','','','','',0,0,0,40),(15257,10179,10153,12102,'Admin Amin','2013-05-10 08:47:25','2013-05-10 08:47:25',10117,15255,'e223480c-4b5f-4066-83e0-457a07adfb65',0,0,NULL,NULL,NULL,NULL,'text/html','15252','','','','',0,0,0,0),(18114,10179,10153,12102,'Admin Admin','2014-01-03 11:22:46','2014-01-03 11:22:46',10117,18112,'240c693e-d00d-4e45-96a1-702707bfe4a0',0,0,NULL,NULL,NULL,NULL,'text/html','18111','','','','',0,0,0,0),(15300,10191,10153,12102,'Admin Amin','2013-05-10 13:38:58','2013-05-10 13:38:58',10010,15298,'d4feb609-4aea-4861-9b05-7365cb91ab5b',0,1,NULL,NULL,NULL,NULL,'image/png','MantAPP.png','','','','',0,0,0,7),(15303,10191,10153,12102,'Admin Amin','2013-05-10 13:38:58','2013-05-10 13:38:58',10117,15301,'90870fac-f851-4f6c-a497-df6a6436d4c3',0,0,NULL,NULL,NULL,NULL,'text/html','15298','','','','',0,0,0,0),(15315,10179,10153,12102,'Admin Amin','2013-05-10 13:39:27','2013-05-10 13:39:27',10108,15313,'621358dc-a059-4893-81e0-b60f92b12c2c',0,1,NULL,NULL,'2013-05-10 13:38:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,1),(15318,10179,10153,12102,'Admin Amin','2013-05-10 13:39:27','2013-05-10 13:39:27',10117,15316,'af4486c7-ac79-4ca9-b393-1ccbb604f910',0,0,NULL,NULL,NULL,NULL,'text/html','15313','','','','',0,0,0,0),(15325,10179,10153,12102,'Admin Amin','2013-05-10 13:41:54','2013-05-10 13:41:54',10108,15323,'8766ffe4-2f01-4ca4-a8a8-5993e90fe92f',0,1,NULL,NULL,'2013-05-10 13:39:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">ma</Title></root>','','','','',0,0,0,0),(15328,10179,10153,12102,'Admin Amin','2013-05-10 13:41:54','2013-05-10 13:41:54',10117,15326,'68ddd62a-f8eb-494f-982d-98e93277399c',0,0,NULL,NULL,NULL,NULL,'text/html','15323','','','','',0,0,0,0),(15335,10179,10153,12102,'Admin Amin','2013-05-10 13:42:02','2013-05-10 13:42:02',10108,15333,'d9d57688-95cd-417a-92cb-2de53a1815fa',0,1,NULL,NULL,'2013-05-10 13:39:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,3),(15338,10179,10153,12102,'Admin Amin','2013-05-10 13:42:02','2013-05-10 13:42:02',10117,15336,'1dbb92ba-dcda-42af-a7ac-c70a2ae74a71',0,0,NULL,NULL,NULL,NULL,'text/html','15333','','','','',0,0,0,0),(15345,10179,10153,12102,'Admin Amin','2013-05-10 13:55:31','2013-05-10 13:55:31',10108,15343,'ff67358a-aba3-4f24-a208-917d8a8d084a',0,1,NULL,NULL,'2013-05-10 13:42:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,1),(15348,10179,10153,12102,'Admin Amin','2013-05-10 13:55:31','2013-05-10 13:55:31',10117,15346,'b5269c1d-231c-47a4-9acd-844e9df1007f',0,0,NULL,NULL,NULL,NULL,'text/html','15343','','','','',0,0,0,0),(15355,10179,10153,12102,'Admin Amin','2013-05-10 13:56:28','2013-05-10 13:56:28',10108,15353,'89daacc8-ce54-4e8d-be8a-b6dd030389ec',0,0,NULL,NULL,'2013-05-10 13:55:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,0),(15358,10179,10153,12102,'Admin Amin','2013-05-10 13:56:28','2013-05-10 13:56:28',10117,15356,'48aebf7d-61f6-49e4-a81e-8e20ace490ad',0,0,NULL,NULL,NULL,NULL,'text/html','15353','','','','',0,0,0,0),(15365,10179,10153,12102,'Admin Amin','2013-05-10 13:56:31','2013-05-10 13:56:31',10108,15363,'b40f1084-01f9-44f2-b8c1-651478dfb545',0,1,NULL,NULL,'2013-05-10 13:55:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,1),(15368,10179,10153,12102,'Admin Amin','2013-05-10 13:56:31','2013-05-10 13:56:31',10117,15366,'3f67d40d-f8aa-448f-ade1-5a172bf0cb6d',0,0,NULL,NULL,NULL,NULL,'text/html','15363','','','','',0,0,0,0),(15377,10179,10153,12102,'Admin Amin','2013-05-10 13:57:47','2013-05-10 13:57:47',10108,15375,'fa5006e9-770d-4ae0-a1fb-895b52d8074c',0,1,NULL,NULL,'2013-05-10 13:57:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,1),(15380,10179,10153,12102,'Admin Amin','2013-05-10 13:57:47','2013-05-10 13:57:47',10117,15378,'5fbb1747-a493-4516-bd8c-1e0ef1be585e',0,0,NULL,NULL,NULL,NULL,'text/html','15375','','','','',0,0,0,0),(15387,10179,10153,12102,'Admin Amin','2013-05-10 13:59:38','2013-05-10 13:59:38',10108,15385,'832f5be2-9be6-460a-a5f2-c98dbc78a0eb',0,1,NULL,NULL,'2013-05-10 13:58:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,5),(15390,10179,10153,12102,'Admin Amin','2013-05-10 13:59:38','2013-05-10 13:59:38',10117,15388,'43e2e979-3e67-4170-836b-155aa4083dac',0,0,NULL,NULL,NULL,NULL,'text/html','15385','','','','',0,0,0,0),(15402,10179,10153,12102,'Admin Amin','2013-05-10 14:09:26','2013-05-10 14:09:26',10108,15400,'b8954fe2-5119-4b71-8dab-1522223c5e20',0,1,NULL,NULL,'2013-05-10 14:08:00',NULL,'text/html','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Mant APP</Title></root>','','','','',0,0,0,19),(15405,10179,10153,12102,'Admin Amin','2013-05-10 14:09:26','2013-05-10 14:09:26',10117,15403,'12753dee-e784-4252-b367-92b5204a93f3',0,0,NULL,NULL,NULL,NULL,'text/html','15400','','','','',0,0,0,0),(16313,10191,10153,12102,'Admin Amin','2013-11-15 10:34:11','2013-12-20 11:58:40',10005,16308,'5d713633-2fbc-4559-88cf-6ea15b325ca7',0,0,NULL,NULL,NULL,NULL,'','fitman_guest','','','','',0,0,0,0),(16320,16310,10153,16308,'msee_guest','2013-11-15 10:35:33','2013-11-15 10:35:33',10117,16318,'3c79277c-649b-4d5d-b60d-79084f191a5c',0,0,NULL,NULL,NULL,NULL,'text/html','16317','','','','',0,0,0,0),(16325,16310,10153,16308,'msee_guest','2013-11-15 10:35:33','2013-11-15 10:35:33',10117,16323,'78775d50-fdd7-455c-bd9b-8b97f4ff74dc',0,0,NULL,NULL,NULL,NULL,'text/html','16322','','','','',0,0,0,0),(16407,10191,10153,12102,'Admin Amin','2013-11-18 15:32:17','2013-11-18 15:32:29',10005,16402,'7aefdc3b-cebe-4dd1-8f50-43d218f91f3d',0,0,NULL,NULL,NULL,NULL,'','MSEE Admin','','','','',0,0,0,0),(16414,16404,10153,16402,'MSEE Admin','2013-11-18 15:32:47','2013-11-18 15:32:47',10117,16412,'b21e36d0-2b35-4f69-90c0-ce0dbe3530b3',0,0,NULL,NULL,NULL,NULL,'text/html','16411','','','','',0,0,0,0),(16419,16404,10153,16402,'MSEE Admin','2013-11-18 15:32:47','2013-11-18 15:32:47',10117,16417,'79a31e1a-72b9-4b35-a4d2-e7dadd85a55d',0,0,NULL,NULL,NULL,NULL,'text/html','16416','','','','',0,0,0,0),(16427,10191,10153,12102,'Admin Amin','2013-11-18 15:33:57','2013-11-18 15:35:41',10005,16422,'7a2f74c5-0d5e-4937-872e-289f910a6fb0',0,0,NULL,NULL,NULL,NULL,'','MSEE Businessexpert','','','','',0,0,0,0),(16434,16424,10153,16422,'MSEE Admin','2013-11-18 15:34:35','2013-11-18 15:34:35',10117,16432,'481994c4-2a2c-45c3-8e6f-ed6b4061d614',0,0,NULL,NULL,NULL,NULL,'text/html','16431','','','','',0,0,0,0),(16439,16424,10153,16422,'MSEE Admin','2013-11-18 15:34:35','2013-11-18 15:34:35',10117,16437,'07c78234-de67-482b-b0df-cef4ecd353ea',0,0,NULL,NULL,NULL,NULL,'text/html','16436','','','','',0,0,0,0),(16447,10191,10153,12102,'Admin Amin','2013-11-18 15:36:42','2013-11-18 15:37:01',10005,16442,'cf4ff13f-10e8-47b6-a0d2-d987bb8afa3f',0,0,NULL,NULL,NULL,NULL,'','MSEE Employee','','','','',0,0,0,0),(16454,16444,10153,16442,'MSEE Employee','2013-11-18 15:37:19','2013-11-18 15:37:19',10117,16452,'14a2f3ab-7ebc-4fdd-bf9f-e432856c8be3',0,0,NULL,NULL,NULL,NULL,'text/html','16451','','','','',0,0,0,0),(16459,16444,10153,16442,'MSEE Employee','2013-11-18 15:37:19','2013-11-18 15:37:19',10117,16457,'34a875e5-2860-4c49-8441-0f672241aa06',0,0,NULL,NULL,NULL,NULL,'text/html','16456','','','','',0,0,0,0),(16467,10191,10153,12102,'Admin Amin','2013-11-18 15:38:39','2013-11-18 15:38:58',10005,16462,'93e1a181-7ad5-4a89-800f-b9b5418f9a71',0,0,NULL,NULL,NULL,NULL,'','MSEE Itexpert','','','','',0,0,0,0),(16474,16464,10153,16462,'MSEE Itexpert','2013-11-18 15:39:15','2013-11-18 15:39:15',10117,16472,'ee2ad320-91cf-4849-95d9-72807bdbd9ca',0,0,NULL,NULL,NULL,NULL,'text/html','16471','','','','',0,0,0,0),(16479,16464,10153,16462,'MSEE Itexpert','2013-11-18 15:39:15','2013-11-18 15:39:15',10117,16477,'1e1bf318-7949-4bc8-bf1c-c6900cc35a65',0,0,NULL,NULL,NULL,NULL,'text/html','16476','','','','',0,0,0,0),(16485,10179,10153,12102,'Admin Amin','2013-11-19 13:24:22','2013-11-19 13:24:22',10117,16483,'a42503d7-8119-4412-b1d6-6709b0b166d0',0,0,NULL,NULL,NULL,NULL,'text/html','16482','','','','',0,0,0,0),(16490,10179,10153,12102,'Admin Amin','2013-11-19 13:25:18','2013-11-19 13:25:18',10117,16488,'4a36bde3-eb8f-439a-9cea-3da3a5eda85e',0,0,NULL,NULL,NULL,NULL,'text/html','16487','','','','',0,0,0,0),(17508,10191,10153,12102,'Admin Admin','2013-12-19 15:52:05','2013-12-19 15:52:05',10005,17503,'088dbbc3-3aee-4030-927a-f4572cf68b06',0,0,NULL,NULL,NULL,NULL,'','user','','','','',0,0,0,0),(17608,10191,10153,12102,'Admin Admin','2013-12-19 16:08:43','2013-12-19 16:08:43',10005,17603,'3462db22-b3a8-4e36-9b36-b30da3af2227',0,0,NULL,NULL,NULL,NULL,'','user','','','','',0,0,0,0),(17701,10191,10153,10157,'','2013-12-23 10:50:59','2013-12-23 10:50:59',10001,10179,'',0,0,NULL,NULL,NULL,NULL,'','Innovation Ecosystem Platform','FITMAN Portal','','','',0,0,0,0);
/*!40000 ALTER TABLE `assetentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcetypepermission`
--

DROP TABLE IF EXISTS `resourcetypepermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcetypepermission` (
  `resourceTypePermissionId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `roleId` bigint(20) DEFAULT NULL,
  `actionIds` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`resourceTypePermissionId`),
  UNIQUE KEY `IX_BA497163` (`companyId`,`groupId`,`name`,`roleId`),
  KEY `IX_7D81F66F` (`companyId`,`name`,`roleId`),
  KEY `IX_A82690E2` (`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcetypepermission`
--

LOCK TABLES `resourcetypepermission` WRITE;
/*!40000 ALTER TABLE `resourcetypepermission` DISABLE KEYS */;
INSERT INTO `resourcetypepermission` VALUES (14614,10153,0,'com.liferay.portlet.bookmarks.model.BookmarksFolder',14610,127),(14615,10153,0,'com.liferay.portlet.bookmarks.model.BookmarksEntry',14610,15);
/*!40000 ALTER TABLE `resourcetypepermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_cron_triggers`
--

DROP TABLE IF EXISTS `quartz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_cron_triggers`
--

LOCK TABLES `quartz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `quartz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journalfeed`
--

DROP TABLE IF EXISTS `journalfeed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journalfeed` (
  `uuid_` varchar(75) DEFAULT NULL,
  `id_` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `feedId` varchar(75) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `type_` varchar(75) DEFAULT NULL,
  `structureId` varchar(75) DEFAULT NULL,
  `templateId` varchar(75) DEFAULT NULL,
  `rendererTemplateId` varchar(75) DEFAULT NULL,
  `delta` int(11) DEFAULT NULL,
  `orderByCol` varchar(75) DEFAULT NULL,
  `orderByType` varchar(75) DEFAULT NULL,
  `targetLayoutFriendlyUrl` varchar(255) DEFAULT NULL,
  `targetPortletId` varchar(75) DEFAULT NULL,
  `contentField` varchar(75) DEFAULT NULL,
  `feedType` varchar(75) DEFAULT NULL,
  `feedVersion` double DEFAULT NULL,
  PRIMARY KEY (`id_`),
  UNIQUE KEY `IX_65576CBC` (`groupId`,`feedId`),
  UNIQUE KEY `IX_39031F51` (`uuid_`,`groupId`),
  KEY `IX_35A2DB2F` (`groupId`),
  KEY `IX_50C36D79` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journalfeed`
--

LOCK TABLES `journalfeed` WRITE;
/*!40000 ALTER TABLE `journalfeed` DISABLE KEYS */;
/*!40000 ALTER TABLE `journalfeed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_teams`
--

DROP TABLE IF EXISTS `users_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_teams` (
  `userId` bigint(20) NOT NULL,
  `teamId` bigint(20) NOT NULL,
  PRIMARY KEY (`userId`,`teamId`),
  KEY `IX_4D06AD51` (`teamId`),
  KEY `IX_A098EFBF` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_teams`
--

LOCK TABLES `users_teams` WRITE;
/*!40000 ALTER TABLE `users_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfileshortcut`
--

DROP TABLE IF EXISTS `dlfileshortcut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfileshortcut` (
  `uuid_` varchar(75) DEFAULT NULL,
  `fileShortcutId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `repositoryId` bigint(20) DEFAULT NULL,
  `folderId` bigint(20) DEFAULT NULL,
  `toFileEntryId` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`fileShortcutId`),
  UNIQUE KEY `IX_FDB4A946` (`uuid_`,`groupId`),
  KEY `IX_B0051937` (`groupId`,`folderId`),
  KEY `IX_ECCE311D` (`groupId`,`folderId`,`status`),
  KEY `IX_4B7247F6` (`toFileEntryId`),
  KEY `IX_4831EBE4` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfileshortcut`
--

LOCK TABLES `dlfileshortcut` WRITE;
/*!40000 ALTER TABLE `dlfileshortcut` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlfileshortcut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scproductscreenshot`
--

DROP TABLE IF EXISTS `scproductscreenshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scproductscreenshot` (
  `productScreenshotId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `productEntryId` bigint(20) DEFAULT NULL,
  `thumbnailId` bigint(20) DEFAULT NULL,
  `fullImageId` bigint(20) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`productScreenshotId`),
  KEY `IX_AE8224CC` (`fullImageId`),
  KEY `IX_467956FD` (`productEntryId`),
  KEY `IX_DA913A55` (`productEntryId`,`priority`),
  KEY `IX_6C572DAC` (`thumbnailId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scproductscreenshot`
--

LOCK TABLES `scproductscreenshot` WRITE;
/*!40000 ALTER TABLE `scproductscreenshot` DISABLE KEYS */;
/*!40000 ALTER TABLE `scproductscreenshot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetvocabulary`
--

DROP TABLE IF EXISTS `assetvocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetvocabulary` (
  `uuid_` varchar(75) DEFAULT NULL,
  `vocabularyId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `title` longtext,
  `description` longtext,
  `settings_` longtext,
  PRIMARY KEY (`vocabularyId`),
  UNIQUE KEY `IX_C0AAD74D` (`groupId`,`name`),
  UNIQUE KEY `IX_1B2B8792` (`uuid_`,`groupId`),
  KEY `IX_B22D908C` (`companyId`),
  KEY `IX_B6B8CA0E` (`groupId`),
  KEY `IX_55F58818` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetvocabulary`
--

LOCK TABLES `assetvocabulary` WRITE;
/*!40000 ALTER TABLE `assetvocabulary` DISABLE KEYS */;
INSERT INTO `assetvocabulary` VALUES ('a8159e5b-65ff-48fe-84a6-a57a29252a87',10316,10191,10153,10157,'','2012-09-10 08:56:38','2012-09-10 08:56:38','Topic','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Topic</Title></root>','',''),('7f1c718f-3efb-4323-9461-82864c120364',14236,10179,10153,10157,'','2013-04-16 14:42:20','2013-04-16 14:42:20','Topic','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Topic</Title></root>','',''),('75e3e178-2df3-43f9-8510-2230e35562d4',15803,12104,10153,10157,'','2013-09-04 16:45:44','2013-09-04 16:45:44','Topic','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Topic</Title></root>','','');
/*!40000 ALTER TABLE `assetvocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opensocial_oauthtoken`
--

DROP TABLE IF EXISTS `opensocial_oauthtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opensocial_oauthtoken` (
  `oAuthTokenId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `gadgetKey` varchar(75) DEFAULT NULL,
  `serviceName` varchar(75) DEFAULT NULL,
  `moduleId` bigint(20) DEFAULT NULL,
  `accessToken` varchar(75) DEFAULT NULL,
  `tokenName` varchar(75) DEFAULT NULL,
  `tokenSecret` varchar(75) DEFAULT NULL,
  `sessionHandle` varchar(75) DEFAULT NULL,
  `expiration` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`oAuthTokenId`),
  KEY `IX_6C8CCC3D` (`gadgetKey`,`serviceName`),
  KEY `IX_CDD35402` (`userId`,`gadgetKey`,`serviceName`,`moduleId`,`tokenName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opensocial_oauthtoken`
--

LOCK TABLES `opensocial_oauthtoken` WRITE;
/*!40000 ALTER TABLE `opensocial_oauthtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `opensocial_oauthtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useridmapper`
--

DROP TABLE IF EXISTS `useridmapper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `useridmapper` (
  `userIdMapperId` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `description` varchar(75) DEFAULT NULL,
  `externalUserId` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`userIdMapperId`),
  UNIQUE KEY `IX_41A32E0D` (`type_`,`externalUserId`),
  UNIQUE KEY `IX_D1C44A6E` (`userId`,`type_`),
  KEY `IX_E60EA987` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useridmapper`
--

LOCK TABLES `useridmapper` WRITE;
/*!40000 ALTER TABLE `useridmapper` DISABLE KEYS */;
/*!40000 ALTER TABLE `useridmapper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lock_`
--

DROP TABLE IF EXISTS `lock_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lock_` (
  `uuid_` varchar(75) DEFAULT NULL,
  `lockId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `className` varchar(75) DEFAULT NULL,
  `key_` varchar(200) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `inheritable` tinyint(4) DEFAULT NULL,
  `expirationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`lockId`),
  UNIQUE KEY `IX_DD635956` (`className`,`key_`,`owner`),
  KEY `IX_228562AD` (`className`,`key_`),
  KEY `IX_E3F1286B` (`expirationDate`),
  KEY `IX_13C5CD3A` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lock_`
--

LOCK TABLES `lock_` WRITE;
/*!40000 ALTER TABLE `lock_` DISABLE KEYS */;
/*!40000 ALTER TABLE `lock_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_teams`
--

DROP TABLE IF EXISTS `usergroups_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_teams` (
  `userGroupId` bigint(20) NOT NULL,
  `teamId` bigint(20) NOT NULL,
  PRIMARY KEY (`userGroupId`,`teamId`),
  KEY `IX_31FB0B08` (`teamId`),
  KEY `IX_7F187E63` (`userGroupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_teams`
--

LOCK TABLES `usergroups_teams` WRITE;
/*!40000 ALTER TABLE `usergroups_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portlet`
--

DROP TABLE IF EXISTS `portlet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portlet` (
  `id_` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `portletId` varchar(200) DEFAULT NULL,
  `roles` longtext,
  `active_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_`),
  UNIQUE KEY `IX_12B5E51D` (`companyId`,`portletId`),
  KEY `IX_80CC9508` (`companyId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portlet`
--

LOCK TABLES `portlet` WRITE;
/*!40000 ALTER TABLE `portlet` DISABLE KEYS */;
INSERT INTO `portlet` VALUES (10202,10153,'98','',1),(10203,10153,'66','',1),(10204,10153,'180','',1),(10205,10153,'27','',1),(10206,10153,'152','',1),(10207,10153,'134','',1),(10208,10153,'130','',1),(10209,10153,'122','',1),(10210,10153,'36','',1),(10211,10153,'26','',1),(10212,10153,'104','',1),(10213,10153,'175','',1),(10214,10153,'153','',1),(10215,10153,'64','',1),(10216,10153,'129','',1),(10217,10153,'179','',1),(10218,10153,'173','',1),(10219,10153,'100','',1),(10220,10153,'19','',1),(10221,10153,'157','',1),(10222,10153,'128','',1),(10223,10153,'181','',1),(10224,10153,'154','',1),(10225,10153,'148','',1),(10226,10153,'11','',1),(10227,10153,'29','',1),(10228,10153,'158','',1),(10229,10153,'178','',1),(10230,10153,'8','',1),(10231,10153,'58','',1),(10232,10153,'71','',1),(10233,10153,'97','',1),(10234,10153,'39','',1),(10235,10153,'177','',1),(10236,10153,'85','',1),(10237,10153,'118','',1),(10238,10153,'107','',1),(10239,10153,'30','',1),(10240,10153,'147','',1),(10241,10153,'48','',1),(10242,10153,'125','',1),(10243,10153,'161','',1),(10244,10153,'146','',1),(10245,10153,'62','',1),(10246,10153,'162','',1),(10247,10153,'176','',1),(10248,10153,'108','',1),(10249,10153,'84','',1),(10250,10153,'101','',1),(10251,10153,'121','',1),(10252,10153,'143','',1),(10253,10153,'77','',1),(10254,10153,'167','',1),(10255,10153,'115','',1),(10256,10153,'56','',1),(10257,10153,'16','',1),(10258,10153,'111','',1),(10259,10153,'3','',1),(10260,10153,'23','',1),(10261,10153,'20','',1),(10262,10153,'83','',1),(10263,10153,'164','',1),(10264,10153,'99','',1),(10265,10153,'70','',1),(10266,10153,'141','',1),(10267,10153,'9','',1),(10268,10153,'28','',1),(10269,10153,'137','',1),(10270,10153,'47','',1),(10271,10153,'15','',1),(10272,10153,'116','',1),(10273,10153,'82','',1),(10274,10153,'151','',1),(10275,10153,'54','',1),(10276,10153,'34','',1),(10277,10153,'169','',1),(10278,10153,'132','',1),(10279,10153,'61','',1),(10280,10153,'73','',1),(10281,10153,'31','',1),(10282,10153,'136','',1),(10283,10153,'50','',1),(10284,10153,'127','',1),(10285,10153,'25','',1),(10286,10153,'166','',1),(10287,10153,'33','',1),(10288,10153,'150','',1),(10289,10153,'114','',1),(10290,10153,'149','',1),(10291,10153,'67','',1),(10292,10153,'110','',1),(10293,10153,'59','',1),(10294,10153,'135','',1),(10295,10153,'131','',1),(10296,10153,'102','',1),(15005,10153,'4_WAR_opensocialportlet','',1),(15006,10153,'2_WAR_opensocialportlet','',1),(15007,10153,'1_WAR_opensocialportlet','',1),(15008,10153,'3_WAR_opensocialportlet','',1),(15020,10153,'OPENSOCIAL_d11d3c30__a211__4b1c__9805__e427cd1ef9bf','',1),(15027,10153,'OPENSOCIAL_8a63ef63__cdc5__4425__9a60__69b823e53965','',1),(15029,10153,'OPENSOCIAL_d31e75ef__96fe__4094__8b00__ddb873e622f6','',1),(15106,10153,'OPENSOCIAL_9daa7c16__c08f__4fa1__b4fd__97cd1cbfa153','',1),(15262,10153,'OPENSOCIAL_7d997a45__553e__42fd__a97a__00c5b703d2d1','',1),(15266,10153,'OPENSOCIAL_ef821589__cd7f__4acc__9c02__e9b6dae2cacc','',1),(15271,10153,'OPENSOCIAL_4dbcf984__6462__4c1c__ac90__6761b366d688','',1),(15621,10153,'OPENSOCIAL_12477752__1f79__4c1b__8fb5__bc2df62f4552','',1),(15702,10153,'OPENSOCIAL_e916fdc0__aa8d__434e__b0ff__fc63b6137eb0','',1),(15802,10153,'OPENSOCIAL_21917435__b9d8__4586__a315__639ed79bfd95','',1),(16034,10153,'OPENSOCIAL_6da598d7__0aaa__4b1f__bfe2__41edd18db021','',1);
/*!40000 ALTER TABLE `portlet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pollschoice`
--

DROP TABLE IF EXISTS `pollschoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pollschoice` (
  `uuid_` varchar(75) DEFAULT NULL,
  `choiceId` bigint(20) NOT NULL,
  `questionId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`choiceId`),
  UNIQUE KEY `IX_D76DD2CF` (`questionId`,`name`),
  KEY `IX_EC370F10` (`questionId`),
  KEY `IX_6660B399` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pollschoice`
--

LOCK TABLES `pollschoice` WRITE;
/*!40000 ALTER TABLE `pollschoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `pollschoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expandotable`
--

DROP TABLE IF EXISTS `expandotable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expandotable` (
  `tableId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`tableId`),
  UNIQUE KEY `IX_37562284` (`companyId`,`classNameId`,`name`),
  KEY `IX_B5AE8A85` (`companyId`,`classNameId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expandotable`
--

LOCK TABLES `expandotable` WRITE;
/*!40000 ALTER TABLE `expandotable` DISABLE KEYS */;
INSERT INTO `expandotable` VALUES (10411,10153,10005,'MP'),(15009,10153,10002,'OPEN_SOCIAL_DATA_');
/*!40000 ALTER TABLE `expandotable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journalarticleresource`
--

DROP TABLE IF EXISTS `journalarticleresource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journalarticleresource` (
  `uuid_` varchar(75) DEFAULT NULL,
  `resourcePrimKey` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `articleId` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`resourcePrimKey`),
  UNIQUE KEY `IX_88DF994A` (`groupId`,`articleId`),
  UNIQUE KEY `IX_84AB0309` (`uuid_`,`groupId`),
  KEY `IX_F8433677` (`groupId`),
  KEY `IX_DCD1FAC1` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journalarticleresource`
--

LOCK TABLES `journalarticleresource` WRITE;
/*!40000 ALTER TABLE `journalarticleresource` DISABLE KEYS */;
INSERT INTO `journalarticleresource` VALUES ('02f4a2f4-16cc-44be-8c88-512837f7ea6f',10582,10179,'WHO-IS-USING-LIFERAY'),('c906870b-3d9b-4279-bdb2-4dba71526b96',10596,10179,'LIFERAY-BENEFITS'),('46543336-c2e5-4055-bccf-1a052c9c77fc',10604,10179,'WHAT-WE-DO'),('6ebfd0a1-5522-43b8-a407-ce135e819588',11703,11605,'INNOVATING-FOR-OVER-30-YEARS'),('83cc3990-b15f-4ea1-8bcd-d2faf35cea1d',11717,11605,'OUR-STRATEGY'),('1c13d446-e273-490e-ad98-b3e61fda8058',11725,11605,'OUR-ACHIEVEMENTS'),('32767481-cf27-4a0d-a76c-c37cc89b07aa',11733,11605,'HOW-DO-WE-DO-IT'),('8f207c2c-8657-4216-b6b6-aa61b7513e89',11744,11605,'DOWNLOAD-POD'),('62954c04-6d1f-4d4c-aee5-54e8a1afeb80',11755,11605,'WHO-WE-ARE'),('382bcf9f-46ad-460d-b75e-156d2b062152',11772,11605,'HOME-CAROUSEL'),('53388af0-3ed9-46b5-9132-78670cce19f4',11805,10179,'11803'),('da9a3134-12bd-4693-a42f-57e219bf976d',13172,10179,'13170'),('78499ff2-88dd-4798-86a6-1270c12c53f1',13310,10179,'13308'),('5ab864d6-8848-4cab-a0ee-a8b67d9138ba',15222,10179,'15220'),('007ce382-0486-4053-bbd0-fd9737a29483',15232,10179,'15230'),('cfaaa38d-6463-4dc0-aa3f-fd74e0ed63dc',15242,10179,'15240'),('f34a58d8-1073-443c-9eed-bb92f721aff2',15252,10179,'15250'),('621358dc-a059-4893-81e0-b60f92b12c2c',15313,10179,'15311'),('8766ffe4-2f01-4ca4-a8a8-5993e90fe92f',15323,10179,'15321'),('d9d57688-95cd-417a-92cb-2de53a1815fa',15333,10179,'15331'),('ff67358a-aba3-4f24-a208-917d8a8d084a',15343,10179,'15341'),('89daacc8-ce54-4e8d-be8a-b6dd030389ec',15353,10179,'15351'),('b40f1084-01f9-44f2-b8c1-651478dfb545',15363,10179,'15361'),('fa5006e9-770d-4ae0-a1fb-895b52d8074c',15375,10179,'15373'),('832f5be2-9be6-460a-a5f2-c98dbc78a0eb',15385,10179,'15383'),('b8954fe2-5119-4b71-8dab-1522223c5e20',15400,10179,'15398');
/*!40000 ALTER TABLE `journalarticleresource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_`
--

DROP TABLE IF EXISTS `role_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_` (
  `roleId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  `classPK` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `title` longtext,
  `description` longtext,
  `type_` int(11) DEFAULT NULL,
  `subtype` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`roleId`),
  UNIQUE KEY `IX_A88E424E` (`companyId`,`classNameId`,`classPK`),
  UNIQUE KEY `IX_EBC931B8` (`companyId`,`name`),
  KEY `IX_449A10B9` (`companyId`),
  KEY `IX_F436EC8E` (`name`),
  KEY `IX_5EB4E2FB` (`subtype`),
  KEY `IX_CBE204` (`type_`,`subtype`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_`
--

LOCK TABLES `role_` WRITE;
/*!40000 ALTER TABLE `role_` DISABLE KEYS */;
INSERT INTO `role_` VALUES (10160,10153,10004,10160,'Administrator','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Administrators are super users who can do anything.</Description></root>',1,''),(10161,10153,10004,10161,'Guest','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Unauthenticated users always have this role.</Description></root>',1,''),(10162,10153,10004,10162,'Owner','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">This is an implied role with respect to the objects users create.</Description></root>',1,''),(10163,10153,10004,10163,'Power User','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Power Users have their own personal site.</Description></root>',1,''),(10164,10153,10004,10164,'User','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Authenticated users should be assigned this role.</Description></root>',1,''),(10165,10153,10004,10165,'Organization Administrator','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Organization Administrators are super users of their organization but cannot make other users into Organization Administrators.</Description></root>',3,''),(10166,10153,10004,10166,'Organization Owner','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Organization Owners are super users of their organization and can assign organization roles to users.</Description></root>',3,''),(10167,10153,10004,10167,'Organization User','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">All users who belong to an organization have this role within that organization.</Description></root>',3,''),(10168,10153,10004,10168,'Site Administrator','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Site Administrators are super users of their site but cannot make other users into Site Administrators.</Description></root>',2,''),(10169,10153,10004,10169,'Site Member','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">All users who belong to a site have this role within that site.</Description></root>',2,''),(10170,10153,10004,10170,'Site Owner','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Site Owners are super users of their site and can assign site roles to users.</Description></root>',2,''),(11302,10153,10004,11302,'Responsabile','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Responsabile</Title></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Responsabile</Description></root>',1,''),(11524,10153,10004,11524,'Business Modeler','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Ecosystem business modeler</Description></root>',1,''),(13101,10153,10004,13101,'Evaluator','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">Evaluator</Title></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Asset evaluator</Description></root>',1,''),(14610,10153,10004,14610,'FITMAN_Administrator','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">FITMAN_Administrator</Title></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">Has an administrator role in the company. He can add/remove users and enterprises from the ecosystem, manages roles, permissions, visibility of information.</Description></root>',1,''),(14613,10153,10004,14613,'FITMAN_User','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">FITMAN_User</Title></root>','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Description language-id=\"en_US\">he is a generic user of the plartform with no one of the previous skill. He could be involved in different processes in the IEP, such as idea proposal, operational processes etc. He should have basic IT skills</Description></root>',1,''),(15043,10153,10004,15043,'supplier','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Title language-id=\"en_US\">supplier</Title></root>','',1,'');
/*!40000 ALTER TABLE `role_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passwordtracker`
--

DROP TABLE IF EXISTS `passwordtracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `passwordtracker` (
  `passwordTrackerId` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `password_` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`passwordTrackerId`),
  KEY `IX_326F75BD` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passwordtracker`
--

LOCK TABLES `passwordtracker` WRITE;
/*!40000 ALTER TABLE `passwordtracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `passwordtracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dlfileentrytypes_dlfolders`
--

DROP TABLE IF EXISTS `dlfileentrytypes_dlfolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlfileentrytypes_dlfolders` (
  `fileEntryTypeId` bigint(20) NOT NULL,
  `folderId` bigint(20) NOT NULL,
  PRIMARY KEY (`fileEntryTypeId`,`folderId`),
  KEY `IX_5BB6AD6C` (`fileEntryTypeId`),
  KEY `IX_6E00A2EC` (`folderId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dlfileentrytypes_dlfolders`
--

LOCK TABLES `dlfileentrytypes_dlfolders` WRITE;
/*!40000 ALTER TABLE `dlfileentrytypes_dlfolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `dlfileentrytypes_dlfolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbban`
--

DROP TABLE IF EXISTS `mbban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbban` (
  `banId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `banUserId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`banId`),
  UNIQUE KEY `IX_8ABC4E3B` (`groupId`,`banUserId`),
  KEY `IX_69951A25` (`banUserId`),
  KEY `IX_5C3FF12A` (`groupId`),
  KEY `IX_48814BBA` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbban`
--

LOCK TABLES `mbban` WRITE;
/*!40000 ALTER TABLE `mbban` DISABLE KEYS */;
/*!40000 ALTER TABLE `mbban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scproductentry`
--

DROP TABLE IF EXISTS `scproductentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scproductentry` (
  `productEntryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `type_` varchar(75) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `shortDescription` longtext,
  `longDescription` longtext,
  `pageURL` longtext,
  `author` varchar(75) DEFAULT NULL,
  `repoGroupId` varchar(75) DEFAULT NULL,
  `repoArtifactId` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`productEntryId`),
  KEY `IX_5D25244F` (`companyId`),
  KEY `IX_72F87291` (`groupId`),
  KEY `IX_98E6A9CB` (`groupId`,`userId`),
  KEY `IX_7311E812` (`repoGroupId`,`repoArtifactId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scproductentry`
--

LOCK TABLES `scproductentry` WRITE;
/*!40000 ALTER TABLE `scproductentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `scproductentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetcategoryproperty`
--

DROP TABLE IF EXISTS `assetcategoryproperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetcategoryproperty` (
  `categoryPropertyId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `categoryId` bigint(20) DEFAULT NULL,
  `key_` varchar(75) DEFAULT NULL,
  `value` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`categoryPropertyId`),
  UNIQUE KEY `IX_DBD111AA` (`categoryId`,`key_`),
  KEY `IX_99DA856` (`categoryId`),
  KEY `IX_8654719F` (`companyId`),
  KEY `IX_52340033` (`companyId`,`key_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetcategoryproperty`
--

LOCK TABLES `assetcategoryproperty` WRITE;
/*!40000 ALTER TABLE `assetcategoryproperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetcategoryproperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingcoupon`
--

DROP TABLE IF EXISTS `shoppingcoupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoppingcoupon` (
  `couponId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `code_` varchar(75) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `description` longtext,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `active_` tinyint(4) DEFAULT NULL,
  `limitCategories` longtext,
  `limitSkus` longtext,
  `minOrder` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `discountType` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`couponId`),
  UNIQUE KEY `IX_DC60CFAE` (`code_`),
  KEY `IX_3251AF16` (`groupId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingcoupon`
--

LOCK TABLES `shoppingcoupon` WRITE;
/*!40000 ALTER TABLE `shoppingcoupon` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingcoupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journalstructure`
--

DROP TABLE IF EXISTS `journalstructure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journalstructure` (
  `uuid_` varchar(75) DEFAULT NULL,
  `id_` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `structureId` varchar(75) DEFAULT NULL,
  `parentStructureId` varchar(75) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `xsd` longtext,
  PRIMARY KEY (`id_`),
  UNIQUE KEY `IX_AB6E9996` (`groupId`,`structureId`),
  UNIQUE KEY `IX_42E86E58` (`uuid_`,`groupId`),
  KEY `IX_B97F5608` (`groupId`),
  KEY `IX_CA0BD48C` (`groupId`,`parentStructureId`),
  KEY `IX_4FA67B72` (`parentStructureId`),
  KEY `IX_8831E4FC` (`structureId`),
  KEY `IX_6702CA92` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journalstructure`
--

LOCK TABLES `journalstructure` WRITE;
/*!40000 ALTER TABLE `journalstructure` DISABLE KEYS */;
INSERT INTO `journalstructure` VALUES ('f441afef-64ce-483b-9700-0f6a11572468',10591,10179,10153,10157,'','2012-09-10 08:57:00','2012-09-10 08:57:00','10590','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Welcome Content Structure</Name></root>','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"page-title\" type=\"text\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Sub Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"links\" type=\"text\" index-type=\"\" repeatable=\"true\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Link Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n		<dynamic-element name=\"bg-image\" type=\"document_library\" index-type=\"\" repeatable=\"false\">\n			<meta-data>\n				<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n				<entry name=\"required\"><![CDATA[false]]></entry>\n				<entry name=\"instructions\"><![CDATA[]]></entry>\n				<entry name=\"label\"><![CDATA[Background Image]]></entry>\n				<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			</meta-data>\n		</dynamic-element>\n		<dynamic-element name=\"action-link-url\" type=\"text\" index-type=\"\" repeatable=\"false\">\n			<meta-data>\n				<entry name=\"displayAsTooltip\"><![CDATA[false]]></entry>\n				<entry name=\"required\"><![CDATA[false]]></entry>\n				<entry name=\"instructions\"><![CDATA[]]></entry>\n				<entry name=\"label\"><![CDATA[Call to Action URL]]></entry>\n				<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			</meta-data>\n		</dynamic-element>\n	</dynamic-element>\n</root>'),('f9581490-8e83-4de2-b400-309ca4a6e69f',11682,11605,10153,10157,'','2012-09-26 15:45:42','2012-09-26 15:45:42','11681','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Main Content</Name></root>','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"title\" type=\"text\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"col-one\" type=\"text_area\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Column 1]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"col-two\" type=\"text_area\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Column 2]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"col-three\" type=\"text_area\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Column 3]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>'),('5f12e2b0-e7e1-4216-9cdd-06a697b53d32',11712,11605,10153,10157,'','2012-09-26 15:45:44','2012-09-26 15:45:44','11711','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Featured Content</Name></root>','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"title\" type=\"text\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"link\" type=\"text\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[URL Link]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"image\" type=\"document_library\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Select Image]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"description\" type=\"text_box\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Description]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"content\" type=\"text_area\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[false]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Content]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>'),('35d08084-9e94-4d60-ad00-f3c1953c6eff',11765,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45','11764','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Pod</Name></root>','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"title\" type=\"text\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Title]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"col-one\" type=\"text_area\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Column 1]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"col-two\" type=\"text_area\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Column 2]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"col-three\" type=\"text_area\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Column 3]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n</root>'),('91a0533a-f8f2-4d1f-8705-3844c471eef4',11767,11605,10153,10157,'','2012-09-26 15:45:45','2012-09-26 15:45:45','11766','','<?xml version=\'1.0\' encoding=\'UTF-8\'?><root available-locales=\"en_US\" default-locale=\"en_US\"><Name language-id=\"en_US\">Carousel</Name></root>','','<?xml version=\"1.0\"?>\n\n<root>\n	<dynamic-element name=\"width\" type=\"text\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[true]]></entry>\n			<entry name=\"instructions\"><![CDATA[Image width (960) without the \"px\" label]]></entry>\n			<entry name=\"label\"><![CDATA[Image Width]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[960]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"height\" type=\"text\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[true]]></entry>\n			<entry name=\"instructions\"><![CDATA[Image height (260) without the \"px\" label]]></entry>\n			<entry name=\"label\"><![CDATA[Image Height]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[260]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"duration\" type=\"list\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[true]]></entry>\n			<entry name=\"instructions\"><![CDATA[Number of Seconds]]></entry>\n			<entry name=\"label\"><![CDATA[Transition Delay]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n		<dynamic-element name=\"1\" type=\"1\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"2\" type=\"2\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"3\" type=\"3\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"4\" type=\"4\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"5\" type=\"5\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"6\" type=\"6\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"7\" type=\"7\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"8\" type=\"8\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"9\" type=\"9\" index-type=\"\" repeatable=\"false\"></dynamic-element>\n		<dynamic-element name=\"10\" type=\"10\" index-type=\"\" repeatable=\"false\"/>\n	</dynamic-element>\n	<dynamic-element name=\"controls\" type=\"boolean\" index-type=\"\" repeatable=\"false\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[false]]></entry>\n			<entry name=\"instructions\"><![CDATA[Display the Controls that allows selecting which carousel image to display]]></entry>\n			<entry name=\"label\"><![CDATA[Display Controls]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n	</dynamic-element>\n	<dynamic-element name=\"image\" type=\"document_library\" index-type=\"\" repeatable=\"true\">\n		<meta-data>\n			<entry name=\"displayAsTooltip\"><![CDATA[true]]></entry>\n			<entry name=\"required\"><![CDATA[true]]></entry>\n			<entry name=\"instructions\"><![CDATA[]]></entry>\n			<entry name=\"label\"><![CDATA[Image]]></entry>\n			<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n		</meta-data>\n		<dynamic-element name=\"link\" type=\"text\" index-type=\"\" repeatable=\"false\">\n			<meta-data>\n				<entry name=\"displayAsTooltip\"><![CDATA[false]]></entry>\n				<entry name=\"required\"><![CDATA[false]]></entry>\n				<entry name=\"instructions\"><![CDATA[]]></entry>\n				<entry name=\"label\"><![CDATA[link]]></entry>\n				<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n			</meta-data>\n			<dynamic-element name=\"url-location\" type=\"text\" index-type=\"\" repeatable=\"false\">\n				<meta-data>\n					<entry name=\"displayAsTooltip\"><![CDATA[false]]></entry>\n					<entry name=\"required\"><![CDATA[false]]></entry>\n					<entry name=\"instructions\"><![CDATA[]]></entry>\n					<entry name=\"label\"><![CDATA[url-location]]></entry>\n					<entry name=\"predefinedValue\"><![CDATA[]]></entry>\n				</meta-data>\n			</dynamic-element>\n		</dynamic-element>\n	</dynamic-element>\n</root>');
/*!40000 ALTER TABLE `journalstructure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_`
--

DROP TABLE IF EXISTS `user_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_` (
  `uuid_` varchar(75) DEFAULT NULL,
  `userId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `defaultUser` tinyint(4) DEFAULT NULL,
  `contactId` bigint(20) DEFAULT NULL,
  `password_` varchar(75) DEFAULT NULL,
  `passwordEncrypted` tinyint(4) DEFAULT NULL,
  `passwordReset` tinyint(4) DEFAULT NULL,
  `passwordModifiedDate` datetime DEFAULT NULL,
  `digest` varchar(255) DEFAULT NULL,
  `reminderQueryQuestion` varchar(75) DEFAULT NULL,
  `reminderQueryAnswer` varchar(75) DEFAULT NULL,
  `graceLoginCount` int(11) DEFAULT NULL,
  `screenName` varchar(75) DEFAULT NULL,
  `emailAddress` varchar(75) DEFAULT NULL,
  `facebookId` bigint(20) DEFAULT NULL,
  `openId` varchar(1024) DEFAULT NULL,
  `portraitId` bigint(20) DEFAULT NULL,
  `languageId` varchar(75) DEFAULT NULL,
  `timeZoneId` varchar(75) DEFAULT NULL,
  `greeting` varchar(255) DEFAULT NULL,
  `comments` longtext,
  `firstName` varchar(75) DEFAULT NULL,
  `middleName` varchar(75) DEFAULT NULL,
  `lastName` varchar(75) DEFAULT NULL,
  `jobTitle` varchar(100) DEFAULT NULL,
  `loginDate` datetime DEFAULT NULL,
  `loginIP` varchar(75) DEFAULT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginIP` varchar(75) DEFAULT NULL,
  `lastFailedLoginDate` datetime DEFAULT NULL,
  `failedLoginAttempts` int(11) DEFAULT NULL,
  `lockout` tinyint(4) DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `agreedToTermsOfUse` tinyint(4) DEFAULT NULL,
  `emailAddressVerified` tinyint(4) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `IX_615E9F7A` (`companyId`,`emailAddress`),
  UNIQUE KEY `IX_C5806019` (`companyId`,`screenName`),
  UNIQUE KEY `IX_9782AD88` (`companyId`,`userId`),
  UNIQUE KEY `IX_5ADBE171` (`contactId`),
  KEY `IX_3A1E834E` (`companyId`),
  KEY `IX_6EF03E4E` (`companyId`,`defaultUser`),
  KEY `IX_1D731F03` (`companyId`,`facebookId`),
  KEY `IX_F6039434` (`companyId`,`status`),
  KEY `IX_762F63C6` (`emailAddress`),
  KEY `IX_A18034A4` (`portraitId`),
  KEY `IX_E0422BDA` (`uuid_`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_`
--

LOCK TABLES `user_` WRITE;
/*!40000 ALTER TABLE `user_` DISABLE KEYS */;
INSERT INTO `user_` VALUES ('925ec833-4782-4ae7-90c6-e7ab9bbbf7bb',10157,10153,'2012-09-10 08:56:28','2012-09-10 08:56:28',1,10158,'password',0,0,NULL,'5533ed38b5e33c076a804bb4bca644f9,0347dafacbca54a43d2f7e97bbae2275,0347dafacbca54a43d2f7e97bbae2275','what-is-your-father\'s-middle-name','test',0,'10157','default@liferay.com',0,'',0,'en_US','Pacific/Midway','Welcome!','','','','','','2013-09-30 10:48:42','213.140.3.190','2013-09-30 10:45:48','213.140.3.190',NULL,0,0,NULL,1,0,0),('8b9b469e-ac21-496e-a4a1-ad40f6f0cb0c',12102,10153,'2012-10-04 14:55:24','2013-12-19 14:01:08',0,12103,'KLccH3cZjvy7kXS5Rg1bSwuGIys=',1,0,'2013-09-30 11:24:17','74b2c8e4d77aeb5c86686466c9b69190,796f62a1bcd0548a19a88a5b5fba70aa,c37b4f4234a92c092abd68c82441eeeb','what-is-your-father\'s-middle-name','msee',0,'admin','admin@fitman.eu',0,'',0,'en_US','Pacific/Midway','Welcome Admin Amin!','','Admin','','Admin','','2015-04-03 11:18:27','192.168.60.254','2015-04-03 11:12:01','192.168.60.254',NULL,0,0,NULL,1,0,0),('088dbbc3-3aee-4030-927a-f4572cf68b06',17503,10153,'2013-12-19 15:52:04','2013-12-19 15:52:04',0,17504,'/RpzeKTb8qt3CmdEhlQDn6KTaD0=',1,1,NULL,'','','',0,'user','user@fitman.eu',0,'',0,'en_US','Pacific/Midway','Welcome user!','','user','','','',NULL,'',NULL,'',NULL,0,0,NULL,0,0,0),('5d713633-2fbc-4559-88cf-6ea15b325ca7',16308,10153,'2013-11-15 10:34:11','2013-12-20 11:58:40',0,16309,'xj1PyhcsJbMheXGbqHnZVL0gG1A=',1,0,'2013-11-15 10:35:46','','what-is-your-father\'s-middle-name','msee',0,'fitman-guest','fitmanguest@fitman.eu',0,'',0,'en_US','Pacific/Midway','Welcome msee_guest!','','fitman_guest','','','','2013-11-23 13:56:07','91.109.61.221','2013-11-21 16:12:31','91.109.61.221',NULL,0,0,NULL,1,0,0),('7aefdc3b-cebe-4dd1-8f50-43d218f91f3d',16402,10153,'2013-11-18 15:32:17','2013-11-18 15:32:29',0,16403,'xj1PyhcsJbMheXGbqHnZVL0gG1A=',1,0,'2013-11-18 15:33:01','','what-is-your-father\'s-middle-name','msee',0,'mseeadmin','mseeadmin@msee.eu',0,'',0,'en_US','Pacific/Midway','Welcome MSEE Admin!','','MSEE','','Admin','','2013-11-27 18:34:29','147.67.4.98','2013-11-27 18:05:42','147.67.4.98',NULL,0,0,NULL,1,0,5),('7a2f74c5-0d5e-4937-872e-289f910a6fb0',16422,10153,'2013-11-18 15:33:56','2013-11-18 15:35:41',0,16423,'xj1PyhcsJbMheXGbqHnZVL0gG1A=',1,0,'2013-11-18 15:34:47','','what-is-your-father\'s-middle-name','msee',0,'mseebusinessexpert','mseebusinessexpert@msee.eu',0,'',0,'en_US','Pacific/Midway','Welcome MSEE Admin!','','MSEE','','Businessexpert','','2013-11-18 15:36:01','213.140.3.190','2013-11-18 15:35:21','213.140.3.190',NULL,0,0,NULL,1,0,5),('cf4ff13f-10e8-47b6-a0d2-d987bb8afa3f',16442,10153,'2013-11-18 15:36:42','2013-11-18 15:37:01',0,16443,'xj1PyhcsJbMheXGbqHnZVL0gG1A=',1,0,'2013-11-18 15:37:30','','what-is-your-father\'s-middle-name','msee',0,'mseeemployee','mseeemployee@msee.eu',0,'',0,'en_US','Pacific/Midway','Welcome MSEE Employee!','','MSEE','','Employee','','2013-11-18 15:37:19','213.140.3.190','2013-11-18 15:37:19','213.140.3.190',NULL,0,0,NULL,1,0,5),('93e1a181-7ad5-4a89-800f-b9b5418f9a71',16462,10153,'2013-11-18 15:38:39','2013-11-18 15:38:58',0,16463,'xj1PyhcsJbMheXGbqHnZVL0gG1A=',1,0,'2013-11-18 15:39:27','','what-is-your-father\'s-middle-name','msee',0,'mseeitexpert','mseeitexpert@msee.eu',0,'',0,'en_US','Pacific/Midway','Welcome MSEE Itexpert!','','MSEE','','Itexpert','','2013-11-18 15:39:15','213.140.3.190','2013-11-18 15:39:15','213.140.3.190',NULL,0,0,NULL,1,0,5),('3462db22-b3a8-4e36-9b36-b30da3af2227',17603,10153,'2013-12-19 16:08:43','2013-12-19 16:08:43',0,17604,'7fDs1rzUnP+WXxdZFuSR6DT8DUs=',1,1,NULL,'','','',0,'userfitman','user_fitman@fitman.eu',0,'',0,'en_US','Pacific/Midway','Welcome user!','','user','','','',NULL,'',NULL,'',NULL,0,0,NULL,0,0,0);
/*!40000 ALTER TABLE `user_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicecomponent`
--

DROP TABLE IF EXISTS `servicecomponent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicecomponent` (
  `serviceComponentId` bigint(20) NOT NULL,
  `buildNamespace` varchar(75) DEFAULT NULL,
  `buildNumber` bigint(20) DEFAULT NULL,
  `buildDate` bigint(20) DEFAULT NULL,
  `data_` longtext,
  PRIMARY KEY (`serviceComponentId`),
  UNIQUE KEY `IX_4F0315B8` (`buildNamespace`,`buildNumber`),
  KEY `IX_7338606F` (`buildNamespace`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicecomponent`
--

LOCK TABLES `servicecomponent` WRITE;
/*!40000 ALTER TABLE `servicecomponent` DISABLE KEYS */;
INSERT INTO `servicecomponent` VALUES (10410,'Marketplace',1,1312562779947,'<?xml version=\"1.0\"?>\n\n<data>\n	<tables-sql><![CDATA[create table Marketplace_App (\n	uuid_ VARCHAR(75) null,\n	appId LONG not null primary key,\n	companyId LONG,\n	userId LONG,\n	userName VARCHAR(75) null,\n	createDate DATE null,\n	modifiedDate DATE null,\n	remoteAppId LONG,\n	version VARCHAR(75) null\n);\n\ncreate table Marketplace_Module (\n	uuid_ VARCHAR(75) null,\n	moduleId LONG not null primary key,\n	appId LONG,\n	contextName VARCHAR(75) null\n);]]></tables-sql>\n	<sequences-sql><![CDATA[]]></sequences-sql>\n	<indexes-sql><![CDATA[create index IX_865B7BD5 on Marketplace_App (companyId);\ncreate index IX_20F14D93 on Marketplace_App (remoteAppId);\ncreate index IX_3E667FE1 on Marketplace_App (uuid_);\n\ncreate index IX_7DC16D26 on Marketplace_Module (appId);\ncreate index IX_C6938724 on Marketplace_Module (appId, contextName);\ncreate index IX_F2F1E964 on Marketplace_Module (contextName);\ncreate index IX_A7EFD80E on Marketplace_Module (uuid_);]]></indexes-sql>\n</data>'),(15004,'OpenSocial',3,1292372319795,'<?xml version=\"1.0\"?>\n\n<data>\n	<tables-sql><![CDATA[create table OpenSocial_Gadget (\n	uuid_ VARCHAR(75) null,\n	gadgetId LONG not null primary key,\n	companyId LONG,\n	createDate DATE null,\n	modifiedDate DATE null,\n	name VARCHAR(75) null,\n	url STRING null,\n	portletCategoryNames STRING null\n);\n\ncreate table OpenSocial_OAuthConsumer (\n	oAuthConsumerId LONG not null primary key,\n	companyId LONG,\n	createDate DATE null,\n	modifiedDate DATE null,\n	gadgetKey VARCHAR(75) null,\n	serviceName VARCHAR(75) null,\n	consumerKey VARCHAR(75) null,\n	consumerSecret TEXT null,\n	keyType VARCHAR(75) null\n);\n\ncreate table OpenSocial_OAuthToken (\n	oAuthTokenId LONG not null primary key,\n	companyId LONG,\n	userId LONG,\n	userName VARCHAR(75) null,\n	createDate DATE null,\n	modifiedDate DATE null,\n	gadgetKey VARCHAR(75) null,\n	serviceName VARCHAR(75) null,\n	moduleId LONG,\n	accessToken VARCHAR(75) null,\n	tokenName VARCHAR(75) null,\n	tokenSecret VARCHAR(75) null,\n	sessionHandle VARCHAR(75) null,\n	expiration LONG\n);]]></tables-sql>\n	<sequences-sql><![CDATA[]]></sequences-sql>\n	<indexes-sql><![CDATA[create index IX_729869EE on OpenSocial_Gadget (companyId);\ncreate unique index IX_A6A89EB1 on OpenSocial_Gadget (companyId, url);\ncreate index IX_E1F8627A on OpenSocial_Gadget (uuid_);\n\ncreate index IX_47206618 on OpenSocial_OAuthConsumer (gadgetKey);\ncreate index IX_8E715BF8 on OpenSocial_OAuthConsumer (gadgetKey, serviceName);\n\ncreate index IX_6C8CCC3D on OpenSocial_OAuthToken (gadgetKey, serviceName);\ncreate index IX_CDD35402 on OpenSocial_OAuthToken (userId, gadgetKey, serviceName, moduleId, tokenName);]]></indexes-sql>\n</data>');
/*!40000 ALTER TABLE `servicecomponent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter`
--

DROP TABLE IF EXISTS `counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counter` (
  `name` varchar(75) NOT NULL,
  `currentId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter`
--

LOCK TABLES `counter` WRITE;
/*!40000 ALTER TABLE `counter` DISABLE KEYS */;
INSERT INTO `counter` VALUES ('com.liferay.counter.model.Counter',18400),('com.liferay.portal.model.Layout#10171#true',1),('com.liferay.portal.model.Layout#10179#false',39),('com.liferay.portal.model.Layout#10310#true',1),('com.liferay.portal.model.Layout#10320#true',1),('com.liferay.portal.model.Layout#10329#true',1),('com.liferay.portal.model.Layout#10338#true',3),('com.liferay.portal.model.Layout#10364#true',4),('com.liferay.portal.model.Layout#11605#true',1),('com.liferay.portal.model.Layout#12104#false',1),('com.liferay.portal.model.Layout#12104#true',1),('com.liferay.portal.model.Permission',100),('com.liferay.portal.model.Resource',100),('com.liferay.portal.model.ResourceAction',2400),('com.liferay.portal.model.ResourcePermission',6800),('com.liferay.portlet.documentlibrary.model.DLFileEntry',500),('com.liferay.portlet.social.model.SocialActivity',500),('com.liferay.portal.model.Layout#16310#true',1),('com.liferay.portal.model.Layout#16310#false',1),('com.liferay.portal.model.Layout#16404#true',1),('com.liferay.portal.model.Layout#16404#false',1),('com.liferay.portal.model.Layout#16424#true',1),('com.liferay.portal.model.Layout#16424#false',1),('com.liferay.portal.model.Layout#16444#true',1),('com.liferay.portal.model.Layout#16444#false',1),('com.liferay.portal.model.Layout#16464#true',1),('com.liferay.portal.model.Layout#16464#false',1);
/*!40000 ALTER TABLE `counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertracker`
--

DROP TABLE IF EXISTS `usertracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertracker` (
  `userTrackerId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `sessionId` varchar(200) DEFAULT NULL,
  `remoteAddr` varchar(75) DEFAULT NULL,
  `remoteHost` varchar(75) DEFAULT NULL,
  `userAgent` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`userTrackerId`),
  KEY `IX_29BA1CF5` (`companyId`),
  KEY `IX_46B0AE8E` (`sessionId`),
  KEY `IX_E4EFBA8D` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertracker`
--

LOCK TABLES `usertracker` WRITE;
/*!40000 ALTER TABLE `usertracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `usertracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbthread`
--

DROP TABLE IF EXISTS `mbthread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mbthread` (
  `threadId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `categoryId` bigint(20) DEFAULT NULL,
  `rootMessageId` bigint(20) DEFAULT NULL,
  `rootMessageUserId` bigint(20) DEFAULT NULL,
  `messageCount` int(11) DEFAULT NULL,
  `viewCount` int(11) DEFAULT NULL,
  `lastPostByUserId` bigint(20) DEFAULT NULL,
  `lastPostDate` datetime DEFAULT NULL,
  `priority` double DEFAULT NULL,
  `question` tinyint(4) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `statusByUserId` bigint(20) DEFAULT NULL,
  `statusByUserName` varchar(75) DEFAULT NULL,
  `statusDate` datetime DEFAULT NULL,
  PRIMARY KEY (`threadId`),
  KEY `IX_41F6DC8A` (`categoryId`,`priority`),
  KEY `IX_95C0EA45` (`groupId`),
  KEY `IX_9A2D11B2` (`groupId`,`categoryId`),
  KEY `IX_50F1904A` (`groupId`,`categoryId`,`lastPostDate`),
  KEY `IX_485F7E98` (`groupId`,`categoryId`,`status`),
  KEY `IX_E1E7142B` (`groupId`,`status`),
  KEY `IX_AEDD9CB5` (`lastPostDate`,`priority`),
  KEY `IX_CC993ECB` (`rootMessageId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbthread`
--

LOCK TABLES `mbthread` WRITE;
/*!40000 ALTER TABLE `mbthread` DISABLE KEYS */;
INSERT INTO `mbthread` VALUES (10176,10171,10153,-1,10175,10157,1,0,0,'2012-09-10 08:56:30',0,0,0,10157,'','2012-09-10 08:56:30'),(10315,10310,10153,-1,10314,10157,1,0,0,'2012-09-10 08:56:38',0,0,0,10157,'','2012-09-10 08:56:38'),(10325,10320,10153,-1,10324,10157,1,0,0,'2012-09-10 08:56:39',0,0,0,10157,'','2012-09-10 08:56:39'),(10334,10329,10153,-1,10333,10157,1,0,0,'2012-09-10 08:56:39',0,0,0,10157,'','2012-09-10 08:56:39'),(10348,10338,10153,-1,10347,10157,1,0,0,'2012-09-10 08:56:45',0,0,0,10157,'','2012-09-10 08:56:45'),(10354,10338,10153,-1,10353,10157,1,0,0,'2012-09-10 08:56:45',0,0,0,10157,'','2012-09-10 08:56:45'),(10360,10338,10153,-1,10359,10157,1,0,0,'2012-09-10 08:56:45',0,0,0,10157,'','2012-09-10 08:56:45'),(10374,10364,10153,-1,10373,10157,1,0,0,'2012-09-10 08:56:46',0,0,0,10157,'','2012-09-10 08:56:46'),(10382,10364,10153,-1,10381,10157,1,0,0,'2012-09-10 08:56:46',0,0,0,10157,'','2012-09-10 08:56:46'),(10388,10364,10153,-1,10387,10157,1,0,0,'2012-09-10 08:56:46',0,0,0,10157,'','2012-09-10 08:56:46'),(10394,10364,10153,-1,10393,10157,1,0,0,'2012-09-10 08:56:46',0,0,0,10157,'','2012-09-10 08:56:46'),(10428,10179,10153,-1,10427,10157,1,0,0,'2012-09-10 08:56:54',0,0,0,10157,'','2012-09-10 08:56:54'),(10438,10179,10153,-1,10437,10157,1,0,0,'2012-09-10 08:56:55',0,0,0,10157,'','2012-09-10 08:56:55'),(10448,10179,10153,-1,10447,10157,1,0,0,'2012-09-10 08:56:56',0,0,0,10157,'','2012-09-10 08:56:56'),(10457,10179,10153,-1,10456,10157,1,0,0,'2012-09-10 08:56:56',0,0,0,10157,'','2012-09-10 08:56:56'),(10473,10179,10153,-1,10472,10157,1,0,0,'2012-09-10 08:56:57',0,0,0,10157,'','2012-09-10 08:56:57'),(10485,10179,10153,-1,10484,10157,1,0,0,'2012-09-10 08:56:57',0,0,0,10157,'','2012-09-10 08:56:57'),(10497,10179,10153,-1,10496,10157,1,0,0,'2012-09-10 08:56:57',0,0,0,10157,'','2012-09-10 08:56:57'),(10509,10179,10153,-1,10508,10157,1,0,0,'2012-09-10 08:56:58',0,0,0,10157,'','2012-09-10 08:56:58'),(10525,10179,10153,-1,10524,10157,1,0,0,'2012-09-10 08:56:58',0,0,0,10157,'','2012-09-10 08:56:58'),(10537,10179,10153,-1,10536,10157,1,0,0,'2012-09-10 08:56:59',0,0,0,10157,'','2012-09-10 08:56:59'),(10549,10179,10153,-1,10548,10157,1,0,0,'2012-09-10 08:56:59',0,0,0,10157,'','2012-09-10 08:56:59'),(10561,10179,10153,-1,10560,10157,1,0,0,'2012-09-10 08:56:59',0,0,0,10157,'','2012-09-10 08:56:59'),(10573,10179,10153,-1,10572,10157,1,0,0,'2012-09-10 08:56:59',0,0,0,10157,'','2012-09-10 08:56:59'),(10586,10179,10153,-1,10585,10157,1,0,0,'2012-09-10 08:57:00',0,0,0,10157,'','2012-09-10 08:57:00'),(10600,10179,10153,-1,10599,10157,1,0,0,'2012-09-10 08:57:01',0,0,0,10157,'','2012-09-10 08:57:01'),(10608,10179,10153,-1,10607,10157,1,0,0,'2012-09-10 08:57:01',0,0,0,10157,'','2012-09-10 08:57:01'),(10613,10179,10153,-1,10612,10157,1,0,0,'2012-09-10 08:57:01',0,0,0,10157,'','2012-09-10 08:57:01'),(18108,10179,10153,-1,18107,12102,1,0,12102,'2014-01-03 11:22:06',0,0,0,12102,'Admin Admin','2014-01-03 11:22:06'),(18113,10179,10153,-1,18112,12102,1,0,12102,'2014-01-03 11:22:46',0,0,0,12102,'Admin Admin','2014-01-03 11:22:46'),(11504,10179,10153,-1,11503,10195,1,0,10195,'2012-09-26 09:52:16',0,0,0,10195,'Test Test','2012-09-26 09:52:16'),(18305,10191,10153,-1,18304,12102,1,0,12102,'2014-03-04 08:49:43',0,0,0,12102,'Admin Admin','2014-03-04 08:49:43'),(11617,11605,10153,-1,11616,10157,1,0,0,'2012-09-26 15:45:39',0,0,0,10157,'','2012-09-26 15:45:39'),(11625,11605,10153,-1,11624,10157,1,0,0,'2012-09-26 15:45:40',0,0,0,10157,'','2012-09-26 15:45:40'),(11634,11605,10153,-1,11633,10157,1,0,0,'2012-09-26 15:45:40',0,0,0,10157,'','2012-09-26 15:45:40'),(11642,11605,10153,-1,11641,10157,1,0,0,'2012-09-26 15:45:41',0,0,0,10157,'','2012-09-26 15:45:41'),(11652,11605,10153,-1,11651,10157,1,0,0,'2012-09-26 15:45:41',0,0,0,10157,'','2012-09-26 15:45:41'),(11662,11605,10153,-1,11661,10157,1,0,0,'2012-09-26 15:45:42',0,0,0,10157,'','2012-09-26 15:45:42'),(11673,11605,10153,-1,11672,10157,1,0,0,'2012-09-26 15:45:42',0,0,0,10157,'','2012-09-26 15:45:42'),(11707,11605,10153,-1,11706,10157,1,0,0,'2012-09-26 15:45:44',0,0,0,10157,'','2012-09-26 15:45:44'),(11721,11605,10153,-1,11720,10157,1,0,0,'2012-09-26 15:45:44',0,0,0,10157,'','2012-09-26 15:45:44'),(11729,11605,10153,-1,11728,10157,1,0,0,'2012-09-26 15:45:44',0,0,0,10157,'','2012-09-26 15:45:44'),(11737,11605,10153,-1,11736,10157,1,0,0,'2012-09-26 15:45:45',0,0,0,10157,'','2012-09-26 15:45:45'),(11748,11605,10153,-1,11747,10157,1,0,0,'2012-09-26 15:45:45',0,0,0,10157,'','2012-09-26 15:45:45'),(11761,11605,10153,-1,11760,10157,1,0,0,'2012-09-26 15:45:45',0,0,0,10157,'','2012-09-26 15:45:45'),(11776,11605,10153,-1,11775,10157,1,0,0,'2012-09-26 15:45:46',0,0,0,10157,'','2012-09-26 15:45:46'),(11781,11605,10153,-1,11780,10157,1,0,0,'2012-09-26 15:45:48',0,0,0,10157,'','2012-09-26 15:45:48'),(11809,10179,10153,-1,11808,10195,1,0,10195,'2012-09-27 08:55:18',0,0,0,10195,'Test Test','2012-09-27 08:55:18'),(12113,12104,10153,-1,12112,12102,1,0,12102,'2012-10-04 14:56:41',0,0,0,12102,'Admin Amin','2012-10-04 14:56:41'),(12118,12104,10153,-1,12117,12102,1,0,12102,'2012-10-04 14:56:41',0,0,0,12102,'Admin Amin','2012-10-04 14:56:41'),(13123,10191,10153,-1,13122,12102,1,0,12102,'2012-11-29 11:49:59',0,0,0,12102,'Admin Amin','2012-11-29 11:49:59'),(13140,10191,10153,-1,13139,12102,1,0,12102,'2012-11-29 11:57:31',0,0,0,12102,'Admin Amin','2012-11-29 11:57:31'),(13156,10191,10153,-1,13155,12102,1,0,12102,'2012-11-29 12:09:56',0,0,0,12102,'Admin Amin','2012-11-29 12:09:56'),(13176,10179,10153,-1,13175,12102,1,0,12102,'2012-11-29 13:38:24',0,0,0,12102,'Admin Amin','2012-11-29 13:38:24'),(13191,10191,10153,-1,13190,12102,1,0,12102,'2012-11-29 13:58:27',0,0,0,12102,'Admin Amin','2012-11-29 13:58:27'),(13280,10191,10153,-1,13279,12102,1,0,12102,'2012-11-29 14:28:41',0,0,0,12102,'Admin Amin','2012-11-29 14:28:41'),(13314,10179,10153,-1,13313,12102,1,0,12102,'2012-11-29 14:30:26',0,0,0,12102,'Admin Amin','2012-11-29 14:30:26'),(13351,10191,10153,-1,13350,12102,1,0,12102,'2012-11-29 14:36:17',0,0,0,12102,'Admin Amin','2012-11-29 14:36:17'),(14103,10179,10153,-1,14102,12102,1,0,12102,'2013-04-03 10:51:46',0,0,0,12102,'Admin Amin','2013-04-03 10:51:46'),(15226,10179,10153,-1,15225,12102,1,0,12102,'2013-05-10 08:47:02',0,0,0,12102,'Admin Amin','2013-05-10 08:47:02'),(15236,10179,10153,-1,15235,12102,1,0,12102,'2013-05-10 08:47:07',0,0,0,12102,'Admin Amin','2013-05-10 08:47:07'),(15246,10179,10153,-1,15245,12102,1,0,12102,'2013-05-10 08:47:15',0,0,0,12102,'Admin Amin','2013-05-10 08:47:15'),(15256,10179,10153,-1,15255,12102,1,0,12102,'2013-05-10 08:47:25',0,0,0,12102,'Admin Amin','2013-05-10 08:47:25'),(18103,10179,10153,-1,18102,12102,1,0,12102,'2014-01-03 11:21:41',0,0,0,12102,'Admin Admin','2014-01-03 11:21:41'),(15302,10191,10153,-1,15301,12102,1,0,12102,'2013-05-10 13:38:58',0,0,0,12102,'Admin Amin','2013-05-10 13:38:58'),(15317,10179,10153,-1,15316,12102,1,0,12102,'2013-05-10 13:39:27',0,0,0,12102,'Admin Amin','2013-05-10 13:39:27'),(15327,10179,10153,-1,15326,12102,1,0,12102,'2013-05-10 13:41:54',0,0,0,12102,'Admin Amin','2013-05-10 13:41:54'),(15337,10179,10153,-1,15336,12102,1,0,12102,'2013-05-10 13:42:02',0,0,0,12102,'Admin Amin','2013-05-10 13:42:02'),(15347,10179,10153,-1,15346,12102,1,0,12102,'2013-05-10 13:55:31',0,0,0,12102,'Admin Amin','2013-05-10 13:55:31'),(15357,10179,10153,-1,15356,12102,1,0,12102,'2013-05-10 13:56:28',0,0,0,12102,'Admin Amin','2013-05-10 13:56:28'),(15367,10179,10153,-1,15366,12102,1,0,12102,'2013-05-10 13:56:31',0,0,0,12102,'Admin Amin','2013-05-10 13:56:31'),(15379,10179,10153,-1,15378,12102,1,0,12102,'2013-05-10 13:57:47',0,0,0,12102,'Admin Amin','2013-05-10 13:57:47'),(15389,10179,10153,-1,15388,12102,1,0,12102,'2013-05-10 13:59:38',0,0,0,12102,'Admin Amin','2013-05-10 13:59:38'),(15404,10179,10153,-1,15403,12102,1,0,12102,'2013-05-10 14:09:26',0,0,0,12102,'Admin Amin','2013-05-10 14:09:26'),(16319,16310,10153,-1,16318,16308,1,0,16308,'2013-11-15 10:35:33',0,0,0,16308,'msee_guest','2013-11-15 10:35:33'),(16324,16310,10153,-1,16323,16308,1,0,16308,'2013-11-15 10:35:33',0,0,0,16308,'msee_guest','2013-11-15 10:35:33'),(16413,16404,10153,-1,16412,16402,1,0,16402,'2013-11-18 15:32:47',0,0,0,16402,'MSEE Admin','2013-11-18 15:32:47'),(16418,16404,10153,-1,16417,16402,1,0,16402,'2013-11-18 15:32:47',0,0,0,16402,'MSEE Admin','2013-11-18 15:32:47'),(16433,16424,10153,-1,16432,16422,1,0,16422,'2013-11-18 15:34:35',0,0,0,16422,'MSEE Admin','2013-11-18 15:34:35'),(16438,16424,10153,-1,16437,16422,1,0,16422,'2013-11-18 15:34:35',0,0,0,16422,'MSEE Admin','2013-11-18 15:34:35'),(16453,16444,10153,-1,16452,16442,1,0,16442,'2013-11-18 15:37:19',0,0,0,16442,'MSEE Employee','2013-11-18 15:37:19'),(16458,16444,10153,-1,16457,16442,1,0,16442,'2013-11-18 15:37:19',0,0,0,16442,'MSEE Employee','2013-11-18 15:37:19'),(16473,16464,10153,-1,16472,16462,1,0,16462,'2013-11-18 15:39:15',0,0,0,16462,'MSEE Itexpert','2013-11-18 15:39:15'),(16478,16464,10153,-1,16477,16462,1,0,16462,'2013-11-18 15:39:15',0,0,0,16462,'MSEE Itexpert','2013-11-18 15:39:15'),(16484,10179,10153,-1,16483,12102,1,0,12102,'2013-11-19 13:24:22',0,0,0,12102,'Admin Amin','2013-11-19 13:24:22'),(16489,10179,10153,-1,16488,12102,1,0,12102,'2013-11-19 13:25:18',0,0,0,12102,'Admin Amin','2013-11-19 13:25:18');
/*!40000 ALTER TABLE `mbthread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_locks`
--

DROP TABLE IF EXISTS `quartz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_locks`
--

LOCK TABLES `quartz_locks` WRITE;
/*!40000 ALTER TABLE `quartz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetcategory`
--

DROP TABLE IF EXISTS `assetcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetcategory` (
  `uuid_` varchar(75) DEFAULT NULL,
  `categoryId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `parentCategoryId` bigint(20) DEFAULT NULL,
  `leftCategoryId` bigint(20) DEFAULT NULL,
  `rightCategoryId` bigint(20) DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `title` longtext,
  `description` longtext,
  `vocabularyId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`categoryId`),
  UNIQUE KEY `IX_BE4DF2BF` (`parentCategoryId`,`name`,`vocabularyId`),
  UNIQUE KEY `IX_E8D019AA` (`uuid_`,`groupId`),
  KEY `IX_E639E2F6` (`groupId`),
  KEY `IX_510B46AC` (`groupId`,`parentCategoryId`,`name`),
  KEY `IX_2008FACB` (`groupId`,`vocabularyId`),
  KEY `IX_D61ABE08` (`name`,`vocabularyId`),
  KEY `IX_7BB1826B` (`parentCategoryId`),
  KEY `IX_9DDD15EA` (`parentCategoryId`,`name`),
  KEY `IX_B185E980` (`parentCategoryId`,`vocabularyId`),
  KEY `IX_4D37BB00` (`uuid_`),
  KEY `IX_287B1F89` (`vocabularyId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetcategory`
--

LOCK TABLES `assetcategory` WRITE;
/*!40000 ALTER TABLE `assetcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opensocial_oauthconsumer`
--

DROP TABLE IF EXISTS `opensocial_oauthconsumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opensocial_oauthconsumer` (
  `oAuthConsumerId` bigint(20) NOT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `gadgetKey` varchar(75) DEFAULT NULL,
  `serviceName` varchar(75) DEFAULT NULL,
  `consumerKey` varchar(75) DEFAULT NULL,
  `consumerSecret` longtext,
  `keyType` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`oAuthConsumerId`),
  KEY `IX_47206618` (`gadgetKey`),
  KEY `IX_8E715BF8` (`gadgetKey`,`serviceName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opensocial_oauthconsumer`
--

LOCK TABLES `opensocial_oauthconsumer` WRITE;
/*!40000 ALTER TABLE `opensocial_oauthconsumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `opensocial_oauthconsumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portletitem`
--

DROP TABLE IF EXISTS `portletitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portletitem` (
  `portletItemId` bigint(20) NOT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `userName` varchar(75) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `name` varchar(75) DEFAULT NULL,
  `portletId` varchar(75) DEFAULT NULL,
  `classNameId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`portletItemId`),
  KEY `IX_96BDD537` (`groupId`,`classNameId`),
  KEY `IX_D699243F` (`groupId`,`name`,`portletId`,`classNameId`),
  KEY `IX_2C61314E` (`groupId`,`portletId`),
  KEY `IX_E922D6C0` (`groupId`,`portletId`,`classNameId`),
  KEY `IX_8E71167F` (`groupId`,`portletId`,`classNameId`,`name`),
  KEY `IX_33B8CE8D` (`groupId`,`portletId`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portletitem`
--

LOCK TABLES `portletitem` WRITE;
/*!40000 ALTER TABLE `portletitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `portletitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_blob_triggers`
--

DROP TABLE IF EXISTS `quartz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` longblob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_blob_triggers`
--

LOCK TABLES `quartz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `quartz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `quartz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-11 16:02:27
