-- from mysql workbench
delimiter $$

CREATE TABLE `FIWARE_MARKETPLACE` (
 `ID` int(11) NOT NULL AUTO_INCREMENT,
 `NAME` varchar(255) NOT NULL,
 `URL` varchar(1024) NOT NULL,
 PRIMARY KEY (`ID`),
 UNIQUE KEY `unique_ID` (`ID`),
 UNIQUE KEY `unique_NAME` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8$$

CREATE TABLE `SERVICE_PROVIDER` (
 `ID` int(11) NOT NULL AUTO_INCREMENT,
 `EMAIL` varchar(255) NOT NULL,
 `COMPANY` varchar(255) NOT NULL,
 `PASSWORD_HASH` varchar(255) NOT NULL,
 `USERNAME` varchar(255) NOT NULL,
 PRIMARY KEY (`ID`),
 UNIQUE KEY `unique_ID` (`ID`),
 UNIQUE KEY `EMAIL_UNIQUE` (`EMAIL`),
 UNIQUE KEY `unique_USERNAME` (`USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8$$

CREATE TABLE `TRUSTED_MARKETPLACE` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8$$

CREATE TABLE `SERVICE_TEMPLATE` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `TEMPLATE_TEXT` longtext,
  `TEMPLATE_DESCRIPTION` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8$$

CREATE TABLE `USDL_REPOSITORY` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `URL` varchar(1024) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_NAME` (`ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8$$
