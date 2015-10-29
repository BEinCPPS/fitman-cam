-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: fitman_cm
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `fiware_marketplace`
--

DROP TABLE IF EXISTS `fiware_marketplace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fiware_marketplace` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `URL` varchar(1024) NOT NULL,
  `ECOSYSTEM` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_ID` (`ID`),
  UNIQUE KEY `unique_NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fiware_marketplace`
--

LOCK TABLES `fiware_marketplace` WRITE;
/*!40000 ALTER TABLE `fiware_marketplace` DISABLE KEYS */;
/*!40000 ALTER TABLE `fiware_marketplace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localuser`
--

DROP TABLE IF EXISTS `localuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localuser` (
  `LOCALUSER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOCALUSER_COMPANY` varchar(255) DEFAULT NULL,
  `LOCALUSER_EMAIL` varchar(255) NOT NULL,
  `LOCALUSER_PASSWORD` varchar(255) NOT NULL,
  `LOCALUSER_REGISTRATION_DATE` datetime NOT NULL,
  `LOCALUSER_USERNAME` varchar(255) NOT NULL,
  PRIMARY KEY (`LOCALUSER_ID`),
  UNIQUE KEY `LOCALUSER_ID` (`LOCALUSER_ID`),
  UNIQUE KEY `LOCALUSER_EMAIL` (`LOCALUSER_EMAIL`),
  UNIQUE KEY `LOCALUSER_USERNAME` (`LOCALUSER_USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localuser`
--

LOCK TABLES `localuser` WRITE;
/*!40000 ALTER TABLE `localuser` DISABLE KEYS */;
INSERT INTO `localuser` VALUES (1,'admin','admin@admin.it','admin','2014-03-24 00:00:00','admin');
/*!40000 ALTER TABLE `localuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricecomponent`
--

DROP TABLE IF EXISTS `pricecomponent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pricecomponent` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` text,
  `CURRENCY` varchar(45) DEFAULT NULL,
  `CURRENCY_VALUE` decimal(20,5) DEFAULT NULL,
  `UNIT_OF_MEASUREMENT` varchar(45) DEFAULT NULL,
  `PRICE_PLAN_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricecomponent`
--

LOCK TABLES `pricecomponent` WRITE;
/*!40000 ALTER TABLE `pricecomponent` DISABLE KEYS */;
/*!40000 ALTER TABLE `pricecomponent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `priceplan`
--

DROP TABLE IF EXISTS `priceplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `priceplan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `SERVICE_OFFERING_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `priceplan`
--

LOCK TABLES `priceplan` WRITE;
/*!40000 ALTER TABLE `priceplan` DISABLE KEYS */;
/*!40000 ALTER TABLE `priceplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `RATING_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_DATE` datetime NOT NULL,
  `RATING_FEEDBACK` varchar(255) DEFAULT NULL,
  `RATING_NAME` varchar(255) DEFAULT NULL,
  `RATING_OBJECT_ID` int(11) NOT NULL,
  PRIMARY KEY (`RATING_ID`),
  UNIQUE KEY `RATING_ID` (`RATING_ID`),
  KEY `FK917A9DBDC96A3395` (`RATING_OBJECT_ID`),
  CONSTRAINT `FK917A9DBDC96A3395` FOREIGN KEY (`RATING_OBJECT_ID`) REFERENCES `ratingobject` (`RATING_OBJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratingcategory`
--

DROP TABLE IF EXISTS `ratingcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratingcategory` (
  `RATING_CATEGORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_CATEGORY_NAME` varchar(255) NOT NULL,
  `RATING_OBJ_CAT_ID` int(11) NOT NULL,
  PRIMARY KEY (`RATING_CATEGORY_ID`),
  UNIQUE KEY `RATING_CATEGORY_ID` (`RATING_CATEGORY_ID`),
  KEY `FKECF0B1DBE096C108` (`RATING_OBJ_CAT_ID`),
  CONSTRAINT `FKECF0B1DBE096C108` FOREIGN KEY (`RATING_OBJ_CAT_ID`) REFERENCES `ratingobjectcategory` (`RATING_OBJ_CAT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratingcategory`
--

LOCK TABLES `ratingcategory` WRITE;
/*!40000 ALTER TABLE `ratingcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratingcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratingcategoryentry`
--

DROP TABLE IF EXISTS `ratingcategoryentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratingcategoryentry` (
  `RATING_CATEGORY_ENTRY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_CATEGORY_ENTRY_VALUE` int(11) NOT NULL,
  `RATING_ID` int(11) NOT NULL,
  `RATING_CATEGORY_ID` int(11) NOT NULL,
  PRIMARY KEY (`RATING_CATEGORY_ENTRY_ID`),
  UNIQUE KEY `RATING_CATEGORY_ENTRY_ID` (`RATING_CATEGORY_ENTRY_ID`),
  KEY `FK2C8B5757BD17C475` (`RATING_CATEGORY_ID`),
  KEY `FK2C8B57575DC536FA` (`RATING_ID`),
  CONSTRAINT `FK2C8B57575DC536FA` FOREIGN KEY (`RATING_ID`) REFERENCES `rating` (`RATING_ID`),
  CONSTRAINT `FK2C8B5757BD17C475` FOREIGN KEY (`RATING_CATEGORY_ID`) REFERENCES `ratingcategory` (`RATING_CATEGORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratingcategoryentry`
--

LOCK TABLES `ratingcategoryentry` WRITE;
/*!40000 ALTER TABLE `ratingcategoryentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratingcategoryentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratingobject`
--

DROP TABLE IF EXISTS `ratingobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratingobject` (
  `RATING_OBJECT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_OBJECT_OBJECT_ID` varchar(255) NOT NULL,
  `RATING_OBJ_CAT_ID` int(11) NOT NULL,
  PRIMARY KEY (`RATING_OBJECT_ID`),
  UNIQUE KEY `RATING_OBJECT_ID` (`RATING_OBJECT_ID`),
  KEY `FKDAB02B5CE096C108` (`RATING_OBJ_CAT_ID`),
  CONSTRAINT `FKDAB02B5CE096C108` FOREIGN KEY (`RATING_OBJ_CAT_ID`) REFERENCES `ratingobjectcategory` (`RATING_OBJ_CAT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratingobject`
--

LOCK TABLES `ratingobject` WRITE;
/*!40000 ALTER TABLE `ratingobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratingobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratingobjectcategory`
--

DROP TABLE IF EXISTS `ratingobjectcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratingobjectcategory` (
  `RATING_OBJ_CAT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_OBJECT_CATEGORY_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`RATING_OBJ_CAT_ID`),
  UNIQUE KEY `RATING_OBJ_CAT_ID` (`RATING_OBJ_CAT_ID`),
  UNIQUE KEY `RATING_OBJECT_CATEGORY_NAME` (`RATING_OBJECT_CATEGORY_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratingobjectcategory`
--

LOCK TABLES `ratingobjectcategory` WRITE;
/*!40000 ALTER TABLE `ratingobjectcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratingobjectcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `SERVICE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SERVICE_DESC` varchar(255) DEFAULT NULL,
  `SERVICE_NAME` varchar(255) NOT NULL,
  `SERVICE_REG_DATE` datetime DEFAULT NULL,
  `SERVICE_URL` varchar(255) NOT NULL,
  `LOCALUSER_CREATOR_ID` int(11) NOT NULL,
  `LOCALUSER_LAST_EDITOR_ID` int(11) NOT NULL,
  `STORE_ID` int(11) NOT NULL,
  PRIMARY KEY (`SERVICE_ID`),
  UNIQUE KEY `SERVICE_ID` (`SERVICE_ID`),
  UNIQUE KEY `SERVICE_URL` (`SERVICE_URL`),
  UNIQUE KEY `SERVICE_NAME` (`SERVICE_NAME`,`STORE_ID`),
  KEY `FKD97C5E95257C978D` (`LOCALUSER_CREATOR_ID`),
  KEY `FKD97C5E9599AF6FC3` (`LOCALUSER_LAST_EDITOR_ID`),
  KEY `FKD97C5E955B467BA` (`STORE_ID`),
  CONSTRAINT `FKD97C5E95257C978D` FOREIGN KEY (`LOCALUSER_CREATOR_ID`) REFERENCES `localuser` (`LOCALUSER_ID`),
  CONSTRAINT `FKD97C5E955B467BA` FOREIGN KEY (`STORE_ID`) REFERENCES `store` (`STORE_ID`),
  CONSTRAINT `FKD97C5E9599AF6FC3` FOREIGN KEY (`LOCALUSER_LAST_EDITOR_ID`) REFERENCES `localuser` (`LOCALUSER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,NULL,'myServiceIaco','2014-04-14 10:47:05','www.iaco.com',1,1,1),(3,NULL,'myServiceIaco1','2014-04-14 10:48:19','www.iaco1.com',1,1,1),(4,'Desc','nAcFIyv','2014-10-20 00:00:00','nAcFIyv',1,1,1),(5,'Desc','KnveCtn','2014-10-21 00:00:00','KnveCtn',1,1,1),(6,'Desc','ddkTzmZ','2014-10-21 00:00:00','ddkTzmZ',1,1,1),(7,'Desc','TEST83454545','2014-10-21 00:00:00','VsZrBAK',1,1,1),(8,'Desc','TESTBLU','2014-10-21 00:00:00','CeWWSES',1,1,1),(9,NULL,'Platico-ShirtProductionService','2014-11-13 00:00:00','test/Platico-ShirtProductionService',1,1,1);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_provider`
--

DROP TABLE IF EXISTS `service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_provider` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `EMAIL` varchar(255) NOT NULL,
  `COMPANY` varchar(255) NOT NULL,
  `PASSWORD_HASH` varchar(255) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `ECOSYSTEM_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_ID` (`ID`),
  UNIQUE KEY `EMAIL_UNIQUE` (`EMAIL`),
  UNIQUE KEY `unique_USERNAME` (`USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_provider`
--

LOCK TABLES `service_provider` WRITE;
/*!40000 ALTER TABLE `service_provider` DISABLE KEYS */;
INSERT INTO `service_provider` VALUES (1,'admin@msee.eu','MSEE','54321qwerty','admin@msee.eu',NULL),(2,'test@msee.eu','MSEE','1234','test',NULL),(3,'TNCTUGL@msee.eu','MSEE','1234','TNCTUGL',NULL),(4,'lfcEMRb@msee.eu','MSEE','1234','lfcEMRb',NULL),(5,'yuazrJf@msee.eu','MSEE','1234','yuazrJf',NULL),(6,'HwjxGRl@msee.eu','MSEE','1234','HwjxGRl',NULL),(7,'OMqfuhW@msee.eu','MSEE','1234','OMqfuhW',NULL),(8,'ZJZtFpd@msee.eu','MSEE','1234','ZJZtFpd',NULL),(9,'QYIhhIT@msee.eu','MSEE','1234','QYIhhIT',NULL),(10,'ZHErQhT@msee.eu','MSEE','1234','ZHErQhT',NULL),(11,'mpUTWVU@msee.eu','MSEE','1234','mpUTWVU',NULL),(12,'zVRDLpl@msee.eu','MSEE','1234','zVRDLpl',NULL),(13,'ZGRrtcS@msee.eu','MSEE','1234','ZGRrtcS',NULL),(14,'wMheHpL@msee.eu','MSEE','1234','wMheHpL',NULL);
/*!40000 ALTER TABLE `service_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_template`
--

DROP TABLE IF EXISTS `service_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_template` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `TEMPLATE_TEXT` longtext,
  `TEMPLATE_DESCRIPTION` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_template`
--

LOCK TABLES `service_template` WRITE;
/*!40000 ALTER TABLE `service_template` DISABLE KEYS */;
INSERT INTO `service_template` VALUES (1,'ShirtCloudManufacturingService','<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:foaf=\"http://xmlns.com/foaf/0.1/\" xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\" xmlns:msm=\"http://cms-wg.sti2.org/ns/minimal-service-model#\" xmlns:owl=\"http://www.w3.org/2002/07/owl#\" xmlns:dcterms=\"http://purl.org/dc/terms/\" xmlns:usdl=\"http://www.linked-usdl.org/ns/usdl-core#\" xmlns:legal=\"http://www.linked-usdl.org/ns/usdl-legal#\" xmlns:price=\"http://www.linked-usdl.org/ns/usdl-pricing#\" xmlns:sla=\"http://www.linked-usdl.org/ns/usdl-sla#\" xmlns:sec=\"http://www.linked-usdl.org/ns/usdl-sec#\" xmlns:blueprint=\"http://bizweb.sap.com/TR/blueprint#\" xmlns:vcard=\"http://www.w3.org/2006/vcard/ns#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\" xmlns:ctag=\"http://commontag.org/ns#\" xmlns:org=\"http://www.w3.org/ns/org#\" xmlns:skos=\"http://www.w3.org/2004/02/skos/core#\" xmlns:time=\"http://www.w3.org/2006/time#\" xmlns:gr=\"http://purl.org/goodrelations/v1#\" xmlns:doap=\"http://usefulinc.com/ns/doap#\"> <usdl:ServiceDescription rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf\"> <dcterms:title>Cutting Machine DCS 2500 service</dcterms:title> <dcterms:description></dcterms:description> <dcterms:modified rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\"></dcterms:modified> <dcterms:created rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\"></dcterms:created> <dcterms:creator rdf:nodeID=\"b21d\"/> </usdl:ServiceDescription> <foaf:Person rdf:nodeID=\"b21d\"> <foaf:name></foaf:name> </foaf:Person> <usdl:Service rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#bdtExQDnqUYhnv2OH\"> <dcterms:subject rdf:nodeID=\"b21e\"/> <dcterms:modified rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\"></dcterms:modified> <dcterms:title xml:lang=\"en\">Cutting Machine DCS 2500</dcterms:title> <dcterms:created rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\">2013-05-03T16:46</dcterms:created> <dcterms:abstract xml:lang=\"en\">High-speed, single- or low-ply, static table cutting machine</dcterms:abstract> <dcterms:description xml:lang=\"en\">The DCS 2500 GERBERcutter system is a high-speed, single- or low-ply, static table cutting system, designed to cut a wide variety of fabrics. It cuts to within millimeters at speeds up to 1.1 meters per second (45 inches per second). </dcterms:description> </usdl:Service> <skos:Concept rdf:nodeID=\"b21e\"> <skos:inScheme rdf:resource=\"http://bizweb.sap.com/TR/blueprint#Industry\"/> <rdfs:label>Other services</rdfs:label> </skos:Concept> <gr:BusinessEntity rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#U4M7QSjmj5YifecaY\"> <vcard:adr rdf:nodeID=\"b21f\"/> <gr:legalName>Platico</gr:legalName> <usdl:legalForm>Inc.</usdl:legalForm> <foaf:homepage rdf:resource=\"http://www.platico.com\"/> <dcterms:description xml:lang=\"en\">Manufacturing as a service&lt;br&gt;</dcterms:description> <gr:offers rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#zcUSHlAhiXYNBaeGN\"/> </gr:BusinessEntity> <vcard:Work rdf:nodeID=\"b21f\"> <dcterms:description></dcterms:description> <vcard:tel></vcard:tel> <vcard:email></vcard:email> <vcard:locality></vcard:locality> <vcard:street-address></vcard:street-address> <vcard:postal-code></vcard:postal-code> <vcard:country-name>Tunisia</vcard:country-name> </vcard:Work> <usdl:ServiceOffering rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#zcUSHlAhiXYNBaeGN\"> <dcterms:description>${description}</dcterms:description> <usdl:validFrom rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\">${validFrom}</usdl:validFrom> <dcterms:title xml:lang=\"en\">${title}</dcterms:title> <usdl:validThrough rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\">${validThrough}</usdl:validThrough> <usdl:includes rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#bdtExQDnqUYhnv2OH\"/> <usdl:hasPricePlan rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#tGPzXc2FjOmV1BN0K\"/> </usdl:ServiceOffering> <price:PricePlan rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#tGPzXc2FjOmV1BN0K\"> <dcterms:title xml:lang=\"en\">Pay per use</dcterms:title> <dcterms:description xml:lang=\"en\">The price is directly proportional to the usage</dcterms:description> <price:hasPriceComponent rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#8lZbba7hRITyqmg8O\"/> <price:hasPriceComponent rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#RfYoHJYE2wBDFgJAK\"/> </price:PricePlan> <price:PriceComponent rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#8lZbba7hRITyqmg8O\"> <dcterms:description></dcterms:description> <dcterms:title xml:lang=\"en\">${priceComponent1}</dcterms:title> <gr:hasCurrency>${currency1}</gr:hasCurrency> <gr:hasUnitOfMeasurement>${unit1}</gr:hasUnitOfMeasurement> <gr:hasCurrencyValue rdf:datatype=\"http://www.w3.org/2001/XMLSchema#float\">${value1}</gr:hasCurrencyValue> </price:PriceComponent> <price:PriceComponent rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#RfYoHJYE2wBDFgJAK\"> <dcterms:description></dcterms:description> <dcterms:title xml:lang=\"en\">${priceComponent2}</dcterms:title> <gr:hasCurrency>${currency2}</gr:hasCurrency> <gr:hasCurrencyValue rdf:datatype=\"http://www.w3.org/2001/XMLSchema#float\">${value2}</gr:hasCurrencyValue> <gr:hasUnitOfMeasurement>${unit2}</gr:hasUnitOfMeasurement> </price:PriceComponent> </rdf:RDF>','<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:foaf=\"http://xmlns.com/foaf/0.1/\" xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\" xmlns:msm=\"http://cms-wg.sti2.org/ns/minimal-service-model#\" xmlns:owl=\"http://www.w3.org/2002/07/owl#\" xmlns:dcterms=\"http://purl.org/dc/terms/\" xmlns:usdl=\"http://www.linked-usdl.org/ns/usdl-core#\" xmlns:legal=\"http://www.linked-usdl.org/ns/usdl-legal#\" xmlns:price=\"http://www.linked-usdl.org/ns/usdl-pricing#\" xmlns:sla=\"http://www.linked-usdl.org/ns/usdl-sla#\" xmlns:sec=\"http://www.linked-usdl.org/ns/usdl-sec#\" xmlns:blueprint=\"http://bizweb.sap.com/TR/blueprint#\" xmlns:vcard=\"http://www.w3.org/2006/vcard/ns#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\" xmlns:ctag=\"http://commontag.org/ns#\" xmlns:org=\"http://www.w3.org/ns/org#\" xmlns:skos=\"http://www.w3.org/2004/02/skos/core#\" xmlns:time=\"http://www.w3.org/2006/time#\" xmlns:gr=\"http://purl.org/goodrelations/v1#\" xmlns:doap=\"http://usefulinc.com/ns/doap#\"> <usdl:ServiceDescription rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf\"> <dcterms:title>Cutting Machine DCS 2500 service</dcterms:title> <dcterms:description></dcterms:description> <dcterms:modified rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\"></dcterms:modified> <dcterms:created rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\"></dcterms:created> <dcterms:creator rdf:nodeID=\"b21d\"/> </usdl:ServiceDescription> <foaf:Person rdf:nodeID=\"b21d\"> <foaf:name></foaf:name> </foaf:Person> <usdl:Service rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#bdtExQDnqUYhnv2OH\"> <dcterms:subject rdf:nodeID=\"b21e\"/> <dcterms:modified rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\"></dcterms:modified> <dcterms:title xml:lang=\"en\">Cutting Machine DCS 2500</dcterms:title> <dcterms:created rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\">2013-05-03T16:46</dcterms:created> <dcterms:abstract xml:lang=\"en\">High-speed, single- or low-ply, static table cutting machine</dcterms:abstract> <dcterms:description xml:lang=\"en\">The DCS 2500 GERBERcutter system is a high-speed, single- or low-ply, static table cutting system, designed to cut a wide variety of fabrics. It cuts to within millimeters at speeds up to 1.1 meters per second (45 inches per second). </dcterms:description> </usdl:Service> <skos:Concept rdf:nodeID=\"b21e\"> <skos:inScheme rdf:resource=\"http://bizweb.sap.com/TR/blueprint#Industry\"/> <rdfs:label>Other services</rdfs:label> </skos:Concept> <gr:BusinessEntity rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#U4M7QSjmj5YifecaY\"> <vcard:adr rdf:nodeID=\"b21f\"/> <gr:legalName>Platico</gr:legalName> <usdl:legalForm>Inc.</usdl:legalForm> <foaf:homepage rdf:resource=\"http://www.platico.com\"/> <dcterms:description xml:lang=\"en\">Manufacturing as a service&lt;br&gt;</dcterms:description> <gr:offers rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#zcUSHlAhiXYNBaeGN\"/> </gr:BusinessEntity> <vcard:Work rdf:nodeID=\"b21f\"> <dcterms:description></dcterms:description> <vcard:tel></vcard:tel> <vcard:email></vcard:email> <vcard:locality></vcard:locality> <vcard:street-address></vcard:street-address> <vcard:postal-code></vcard:postal-code> <vcard:country-name>Tunisia</vcard:country-name> </vcard:Work> <usdl:ServiceOffering rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#zcUSHlAhiXYNBaeGN\"> <dcterms:description>${description}</dcterms:description> <usdl:validFrom rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\">${validFrom}</usdl:validFrom> <dcterms:title xml:lang=\"en\">${title}</dcterms:title> <usdl:validThrough rdf:datatype=\"http://www.w3.org/2001/XMLSchema#datetime\">${validThrough}</usdl:validThrough> <usdl:includes rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#bdtExQDnqUYhnv2OH\"/> <usdl:hasPricePlan rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#tGPzXc2FjOmV1BN0K\"/> </usdl:ServiceOffering> <price:PricePlan rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#tGPzXc2FjOmV1BN0K\"> <dcterms:title xml:lang=\"en\">Pay per use</dcterms:title> <dcterms:description xml:lang=\"en\">The price is directly proportional to the usage</dcterms:description> <price:hasPriceComponent rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#8lZbba7hRITyqmg8O\"/> <price:hasPriceComponent rdf:resource=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#RfYoHJYE2wBDFgJAK\"/> </price:PricePlan> <price:PriceComponent rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#8lZbba7hRITyqmg8O\"> <dcterms:description></dcterms:description> <dcterms:title xml:lang=\"en\">${priceComponent1}</dcterms:title> <gr:hasCurrency>${currency1}</gr:hasCurrency> <gr:hasUnitOfMeasurement>${unit1}</gr:hasUnitOfMeasurement> <gr:hasCurrencyValue rdf:datatype=\"http://www.w3.org/2001/XMLSchema#float\">${value1}</gr:hasCurrencyValue> </price:PriceComponent> <price:PriceComponent rdf:about=\"https://dl.dropboxusercontent.com/u/4318200/usdl/Cutting_Machine_DCS_2500.rdf#RfYoHJYE2wBDFgJAK\"> <dcterms:description></dcterms:description> <dcterms:title xml:lang=\"en\">${priceComponent2}</dcterms:title> <gr:hasCurrency>${currency2}</gr:hasCurrency> <gr:hasCurrencyValue rdf:datatype=\"http://www.w3.org/2001/XMLSchema#float\">${value2}</gr:hasCurrencyValue> <gr:hasUnitOfMeasurement>${unit2}</gr:hasUnitOfMeasurement> </price:PriceComponent> </rdf:RDF>');
/*!40000 ALTER TABLE `service_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviceoffering`
--

DROP TABLE IF EXISTS `serviceoffering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceoffering` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` text NOT NULL,
  `DESCRIPTION` text,
  `VALID_FROM` datetime DEFAULT NULL,
  `VALID_THROUGH` datetime DEFAULT NULL,
  `SERVICE_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SERVICE_OFFERING_ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviceoffering`
--

LOCK TABLES `serviceoffering` WRITE;
/*!40000 ALTER TABLE `serviceoffering` DISABLE KEYS */;
/*!40000 ALTER TABLE `serviceoffering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store` (
  `STORE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `STORE_DESC` varchar(255) DEFAULT NULL,
  `STORE_NAME` varchar(255) NOT NULL,
  `STORE_DATE` datetime DEFAULT NULL,
  `STORE_URL` varchar(255) NOT NULL,
  `LOCALUSER_CREATOR_ID` int(11) NOT NULL,
  `LOCALUSER_LAST_EDITOR_ID` int(11) NOT NULL,
  PRIMARY KEY (`STORE_ID`),
  UNIQUE KEY `STORE_ID` (`STORE_ID`),
  UNIQUE KEY `STORE_NAME` (`STORE_NAME`),
  UNIQUE KEY `STORE_URL` (`STORE_URL`),
  KEY `FK4C808C1257C978D` (`LOCALUSER_CREATOR_ID`),
  KEY `FK4C808C199AF6FC3` (`LOCALUSER_LAST_EDITOR_ID`),
  CONSTRAINT `FK4C808C1257C978D` FOREIGN KEY (`LOCALUSER_CREATOR_ID`) REFERENCES `localuser` (`LOCALUSER_ID`),
  CONSTRAINT `FK4C808C199AF6FC3` FOREIGN KEY (`LOCALUSER_LAST_EDITOR_ID`) REFERENCES `localuser` (`LOCALUSER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES (1,'sssss','store 1','2014-03-24 00:00:00','www.google.it',1,1);
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trusted_marketplace`
--

DROP TABLE IF EXISTS `trusted_marketplace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trusted_marketplace` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SERVICE_PROVIDER_ID` int(11) NOT NULL,
  `TRUSTED_MARKETPLACE_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  UNIQUE KEY `unique_ID` (`ID`),
  KEY `FK_MARKETPLACE` (`TRUSTED_MARKETPLACE_ID`),
  KEY `FK_SERVICEPROVIDER` (`SERVICE_PROVIDER_ID`),
  CONSTRAINT `FK_MARKETPLACE` FOREIGN KEY (`TRUSTED_MARKETPLACE_ID`) REFERENCES `fiware_marketplace` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SERVICEPROVIDER` FOREIGN KEY (`SERVICE_PROVIDER_ID`) REFERENCES `service_provider` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trusted_marketplace`
--

LOCK TABLES `trusted_marketplace` WRITE;
/*!40000 ALTER TABLE `trusted_marketplace` DISABLE KEYS */;
/*!40000 ALTER TABLE `trusted_marketplace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usdl_repository`
--

DROP TABLE IF EXISTS `usdl_repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usdl_repository` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `URL` varchar(1024) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_NAME` (`ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usdl_repository`
--

LOCK TABLES `usdl_repository` WRITE;
/*!40000 ALTER TABLE `usdl_repository` DISABLE KEYS */;
INSERT INTO `usdl_repository` VALUES (1,'H9oLum4','http://www.google.com'),(3,'8L6ZQQP','http://www.yahoo.com');
/*!40000 ALTER TABLE `usdl_repository` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-03 14:30:51
