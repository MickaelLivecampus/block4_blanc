CREATE DATABASE IF NOT EXISTS account;
CREATE DATABASE IF NOT EXISTS dbzerobank;
CREATE USER 'dbsrudzerobank'@'%' IDENTIFIED BY 'ZeroBankIsFun';
GRANT ALL PRIVILEGES ON account.* TO 'dbsrudzerobank'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON dbzerobank.* TO 'dbsrudzerobank'@'%' WITH GRANT OPTION;
USE dbzerobank;

DROP TABLE IF EXISTS `banker`;
CREATE TABLE `banker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `mail` varchar(200) NOT NULL,
  `passmd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


LOCK TABLES `banker` WRITE;
INSERT INTO `banker` VALUES (1,'Balthazar','Picsou','b.picsou@zbank.fr','83521eb870f229088ee8a90cfa3d7d97'),(2,'George','Clown hey','g.clonee@zbank.fr','83521eb870f229088ee8a90cfa3d7d97'),(3,'San','Re mord','s.remord@zbank.fr','83521eb870f229088ee8a90cfa3d7d97'),(4,'Neville','Long du bas','n.longdubras@zbank.fr','83521eb870f229088ee8a90cfa3d7d97'),(5,'Leo','Hope','l.hope@zbank.fr','83521eb870f229088ee8a90cfa3d7d97');

UNLOCK TABLES;

DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `adresse` varchar(150) NOT NULL,
  `postalcode` varchar(5) NOT NULL,
  `pir` varchar(300) NOT NULL,
  `mail` varchar(200) NOT NULL,
  `passmd` varchar(200) NOT NULL,
  `born` date NOT NULL,
  `idbanker` int(11) DEFAULT NULL,
  `accountnumber` int(11) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `client_FK` (`idbanker`),
  CONSTRAINT `client_FK` FOREIGN KEY (`idbanker`) REFERENCES `banker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

LOCK TABLES `client` WRITE;
INSERT INTO `client` VALUES (1,'Jack','Harnes','Rue des moineaux','28230','L2Fzc2V0cy9wcml2YXRlaW1nLzQ1ODY5Ni5qcGVn','nvjnjv@okjeo.fr','83521eb870f229088ee8a90cfa3d7d97','1985-05-12',1,530050309,1),(2,'James','Beauregard','Rue des moineaux','28230','L2Fzc2V0cy9wcml2YXRlaW1nLzQ1ODY5Ni5qcGVn','hello@bonjour.fr','83521eb870f229088ee8a90cfa3d7d97','1985-05-12',1,729911606,1);

UNLOCK TABLES;

DROP TABLE IF EXISTS `requestben`;
CREATE TABLE `requestben` (
  `idrequest` int(11) NOT NULL AUTO_INCREMENT,
  `idclient` int(11) NOT NULL,
  `idbanker` int(11) NOT NULL,
  `validate` tinyint(1) DEFAULT '0',
  `made` date NOT NULL,
  `valitime` datetime DEFAULT NULL,
  `accountbenef` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idrequest`),
  KEY `FK_banker` (`idbanker`) USING BTREE,
  KEY `requestnc_FK` (`idclient`) USING BTREE,
  CONSTRAINT `FK_banker_copy` FOREIGN KEY (`idbanker`) REFERENCES `banker` (`id`),
  CONSTRAINT `requestnc_FK_copy` FOREIGN KEY (`idclient`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;


LOCK TABLES `requestben` WRITE;
INSERT INTO `requestben` VALUES (11,2,1,1,'2021-04-21',NULL,'530050309');

UNLOCK TABLES;
DROP TABLE IF EXISTS `requestnc`;
CREATE TABLE `requestnc` (
  `idrequest` int(11) NOT NULL AUTO_INCREMENT,
  `idnewclient` int(11) DEFAULT NULL,
  `idbanker` int(11) NOT NULL,
  `validate` tinyint(1) DEFAULT '0',
  `made` date NOT NULL,
  `valitime` datetime DEFAULT NULL,
  `askdelete` tinyint(1) DEFAULT '0',
  `pjdelete` varchar(300) DEFAULT NULL,
  `delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`idrequest`),
  KEY `FK_banker` (`idbanker`),
  KEY `requestnc_FK` (`idnewclient`),
  CONSTRAINT `FK_banker` FOREIGN KEY (`idbanker`) REFERENCES `banker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;


LOCK TABLES `requestnc` WRITE;
INSERT INTO `requestnc` VALUES (1,1,1,1,'2021-04-05','2021-04-20 22:31:24',0,'',0),(2,2,1,1,'2021-04-05','2021-04-18 15:29:27',0,'',0),(3,NULL,1,1,'2021-04-05','2021-04-22 11:30:26',1,'L1VzZXJzL3NseWRlcnNsYXNoL05leHRDbG91ZC9EZXZlbG9wcGVtZW50L1NpdGUvWmVyb0JhbmsvYXNzZXRzL3ByaXZhdGVpbWcvNDM3OTJjMjFmZTdmZjliZDEyZGYxM2ExNDE1NjY1YzEwOGJjZWQ2MC5wbmc=',1),(4,NULL,1,1,'2021-04-22','2021-04-22 10:49:58',1,'L1VzZXJzL3NseWRlcnNsYXNoL05leHRDbG91ZC9EZXZlbG9wcGVtZW50L1NpdGUvWmVyb0JhbmsvYXNzZXRzL3ByaXZhdGVpbWcvNDM3OTJjMjFmZTdmZjliZDEyZGYxM2ExNDE1NjY1YzEwOGJjZWQ2MC5wbmc=',1),(5,NULL,1,1,'2021-04-22','2021-04-22 11:42:48',1,'L1VzZXJzL3NseWRlcnNsYXNoL05leHRDbG91ZC9EZXZlbG9wcGVtZW50L1NpdGUvWmVyb0JhbmsvYXNzZXRzL3ByaXZhdGVpbWcvMzJjMzRkMmVjYjdjODYxZmUwOGQzYzBlYjUyNmI0M2MzZTlmNDNhMi5wbmc=',1),(6,13,4,0,'2021-04-22',NULL,0,NULL,0),(7,14,5,0,'2021-04-22',NULL,0,NULL,0);
UNLOCK TABLES;
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `id` varchar(200) NOT NULL,
  `idclient` int(11) DEFAULT NULL,
  `idbanker` int(11) DEFAULT NULL,
  `type` enum('banker','client','waiting') NOT NULL,
  `madeat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiredat` int(11) NOT NULL,
  KEY `token_FK` (`idclient`),
  KEY `token_FK_1` (`idbanker`),
  CONSTRAINT `token_FK` FOREIGN KEY (`idclient`) REFERENCES `client` (`id`),
  CONSTRAINT `token_FK_1` FOREIGN KEY (`idbanker`) REFERENCES `banker` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
LOCK TABLES `token` WRITE;
INSERT INTO `token` VALUES ('6081553a37c66@6081553a37c5f8.08864852@QmFsdGhhemFy@YmFua2Vy@6081553a37c5f8.08864852@UGljc291@Yi5waWNzb3VAemJhbmsuc25hZ2UudGVjaA==@6081553a37c66',NULL,1,'banker','2021-04-22 10:51:38',1619103098),('6081555be0a01@6081555be09f80.54687278@QmFsdGhhemFy@YmFua2Vy@6081555be09f80.54687278@UGljc291@Yi5waWNzb3VAemJhbmsuc25hZ2UudGVjaA==@6081555be0a01',NULL,1,'banker','2021-04-22 10:52:11',1619103131),('6081562b1243e@6081562b124325.96552766@QmFsdGhhemFy@YmFua2Vy@6081562b124325.96552766@UGljc291@Yi5waWNzb3VAemJhbmsuc25hZ2UudGVjaA==@6081562b1243e',NULL,1,'banker','2021-04-22 10:55:39',1619103339),('60815ea4e3cfa@60815ea4e3cf00.50865804@QmFsdGhhemFy@YmFua2Vy@60815ea4e3cf00.50865804@UGljc291@Yi5waWNzb3VAemJhbmsuc25hZ2UudGVjaA==@60815ea4e3cfa',NULL,1,'banker','2021-04-22 11:31:48',1619105508),('6081617790bec@6081617790be28.38012604@QmFsdGhhemFy@YmFua2Vy@6081617790be28.38012604@UGljc291@Yi5waWNzb3VAemJhbmsuc25hZ2UudGVjaA==@6081617790bec',NULL,1,'banker','2021-04-22 11:43:51',1619106231),('608188c242d06@608188c242cfe5.80562339@QmFsdGhhemFy@YmFua2Vy@608188c242cfe5.80562339@UGljc291@Yi5waWNzb3VAemJhbmsuc25hZ2UudGVjaA==@608188c242d06',NULL,1,'banker','2021-04-22 14:31:30',1619116290),('608188e982060@608188e9820551.10454533@VGF1cGlu@d2FpdGluZw==@608188e9820551.10454533@SsOpcsOpbXk=@amVyZW15dGF1cGluQGhvdG1haWwuY29t@608188e982060',14,NULL,'client','2021-04-22 14:32:09',1619110929),('60818974db871@60818974db8695.79581553@VGF1cGlu@d2FpdGluZw==@60818974db8695.79581553@SsOpcsOpbXk=@amVyZW15dGF1cGluQGhvdG1haWwuY29t@60818974db871',14,NULL,'client','2021-04-22 14:34:28',1619111068),('60818990be4cb@60818990be4c45.46458130@QmFsdGhhemFy@YmFua2Vy@60818990be4c45.46458130@UGljc291@Yi5waWNzb3VAemJhbmsuc25hZ2UudGVjaA==@60818990be4cb',NULL,1,'banker','2021-04-22 14:34:56',1619116496);
UNLOCK TABLES;
