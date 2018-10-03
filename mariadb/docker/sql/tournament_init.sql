-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: tournament
-- ------------------------------------------------------
-- Server version	10.2.14-MariaDB-10.2.14+maria~jessie

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
-- Table structure for table `fos_user`
--

DROP TABLE IF EXISTS `fos_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fos_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `confirmation_token` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_957A647992FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_957A6479A0D96FBF` (`email_canonical`),
  UNIQUE KEY `UNIQ_957A6479C05FB297` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user`
--

LOCK TABLES `fos_user` WRITE;
/*!40000 ALTER TABLE `fos_user` DISABLE KEYS */;
INSERT INTO `fos_user` VALUES (1,'trambi','trambi','bertrand.madet@gmail.com','bertrand.madet@gmail.com',1,NULL,'$2y$13$mz43Bm5W3ReReMXSt5V5G.TiV78AHmdnBOQ0HDVF/P/X6804XLXM2','2017-05-14 04:41:21',NULL,NULL,'a:0:{}'),(2,'orgardvbb','orgardvbb','tisseursdechimeres@gmail.com','tisseursdechimeres@gmail.com',1,NULL,'$2y$13$BqaWJQP.gSUHDF1T.R71x.lEgBwLE3Sx11iXrvu8j0vrxa3JYWmpm','2017-05-20 01:30:59',NULL,NULL,'a:0:{}');
/*!40000 ALTER TABLE `fos_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_coach`
--

DROP TABLE IF EXISTS `tournament_coach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament_coach` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_race` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `points` int(11) NOT NULL,
  `opponents_points` int(11) NOT NULL,
  `net_td` int(11) NOT NULL,
  `casualties` int(11) NOT NULL,
  `edition` smallint(6) NOT NULL,
  `naf_number` int(11) NOT NULL,
  `id_coach_team` int(11) DEFAULT NULL,
  `ready` tinyint(1) NOT NULL,
  `fan_factor` tinyint(4) DEFAULT NULL,
  `reroll` tinyint(4) DEFAULT NULL,
  `apothecary` tinyint(4) DEFAULT NULL,
  `assistant_coach` tinyint(4) DEFAULT NULL,
  `cheerleader` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FE0FFDD5514FA7AD` (`id_race`),
  KEY `IDX_FE0FFDD5E25543D4` (`id_coach_team`)
) ENGINE=MyISAM AUTO_INCREMENT=1374 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_coach`
--

LOCK TABLES `tournament_coach` WRITE;
/*!40000 ALTER TABLE `tournament_coach` DISABLE KEYS */;
INSERT INTO `tournament_coach` VALUES (1,'team_1','coach_1',4,'team_1@mail.com',0,0,0,0,1,1243,1,1,NULL,NULL,NULL,NULL,NULL),(2,'team_2','coach_2',17,'team_2@mail.com',0,0,0,0,1,545,1,1,NULL,NULL,NULL,NULL,NULL),(4,'team_4','coach_4',23,'team_4@mail.com',0,0,0,0,1,411,2,1,NULL,NULL,NULL,NULL,NULL),(5,'team_5','coach_5',17,'team_5@mail.com',0,0,0,0,1,234,2,1,NULL,NULL,NULL,NULL,NULL),(6,'team_6','coach_6',11,'team_6@mail.com',0,0,0,0,1,688,2,1,NULL,NULL,NULL,NULL,NULL),(8,'team_8','coach_8',23,'team_8@mail.com',0,0,0,0,1,581,3,1,NULL,NULL,NULL,NULL,NULL),(9,'team_9','coach_9',10,'team_9@mail.com',0,0,0,0,1,0,3,1,NULL,NULL,NULL,NULL,NULL),(10,'team_10','coach_10',2,'team_10@mail.com',0,0,0,0,1,607,4,1,NULL,NULL,NULL,NULL,NULL),(11,'team_11','coach_11',17,'team_11@mail.com',0,0,0,0,1,608,4,1,NULL,NULL,NULL,NULL,NULL),(12,'team_12','coach_12',3,'team_12@mail.com',0,0,0,0,1,789,4,1,NULL,NULL,NULL,NULL,NULL),(13,'team_13','coach_13',18,'team_13@mail.com',0,0,0,0,1,588,5,1,NULL,NULL,NULL,NULL,NULL),(14,'team_14','coach_14',12,'team_14@mail.com',0,0,0,0,1,1090,5,1,NULL,NULL,NULL,NULL,NULL),(15,'team_15','coach_15',17,'team_15@mail.com',0,0,0,0,1,1027,5,1,NULL,NULL,NULL,NULL,NULL),(16,'team_16','coach_16',25,'team_16@mail.com',0,0,0,0,1,178,6,1,NULL,NULL,NULL,NULL,NULL),(17,'team_17','coach_17',25,'team_17@mail.com',0,0,0,0,1,1006,6,1,NULL,NULL,NULL,NULL,NULL),(18,'team_18','coach_18',10,'team_18@mail.com',0,0,0,0,1,1183,6,1,NULL,NULL,NULL,NULL,NULL),(19,'team_19','coach_19',12,'team_19@mail.com',0,0,0,0,1,112,7,1,NULL,NULL,NULL,NULL,NULL),(20,'team_20','coach_20',5,'team_20@mail.com',0,0,0,0,1,0,7,1,NULL,NULL,NULL,NULL,NULL),(21,'team_21','coach_21',13,'team_21@mail.com',0,0,0,0,1,1207,7,1,NULL,NULL,NULL,NULL,NULL),(22,'team_22','coach_22',1,'team_22@mail.com',0,0,0,0,1,315,8,1,NULL,NULL,NULL,NULL,NULL),(23,'team_23','coach_23',11,'team_23@mail.com',0,0,0,0,1,1232,8,1,NULL,NULL,NULL,NULL,NULL),(39,'team_39','coach_39',19,'team_39@mail.com',0,0,0,0,1,939,3,1,NULL,NULL,NULL,NULL,NULL),(25,'team_25','coach_25',17,'team_25@mail.com',0,0,0,0,1,767,9,1,NULL,NULL,NULL,NULL,NULL),(26,'team_26','coach_26',6,'team_26@mail.com',0,0,0,0,1,20,9,1,NULL,NULL,NULL,NULL,NULL),(27,'team_27','coach_27',15,'team_27@mail.com',0,0,0,0,1,899,9,1,NULL,NULL,NULL,NULL,NULL),(28,'team_28','coach_28',23,'team_28@mail.com',0,0,0,0,1,413,10,1,NULL,NULL,NULL,NULL,NULL),(29,'team_29','coach_29',17,'team_29@mail.com',0,0,0,0,1,790,10,1,NULL,NULL,NULL,NULL,NULL),(31,'team_31','coach_31',1,'team_31@mail.com',0,0,0,0,1,1018,11,1,NULL,NULL,NULL,NULL,NULL),(32,'team_32','coach_32',4,'team_32@mail.com',0,0,0,0,1,842,11,1,NULL,NULL,NULL,NULL,NULL),(33,'team_33','coach_33',9,'team_33@mail.com',0,0,0,0,1,598,11,1,NULL,NULL,NULL,NULL,NULL),(34,'team_34','coach_34',10,'team_34@mail.com',0,0,0,0,1,0,12,1,NULL,NULL,NULL,NULL,NULL),(35,'team_35','coach_35',1,'team_35@mail.com',0,0,0,0,1,0,12,1,NULL,NULL,NULL,NULL,NULL),(36,'team_36','coach_36',4,'team_36@mail.com',0,0,0,0,1,0,12,1,NULL,NULL,NULL,NULL,NULL),(37,'team_37','coach_37',12,'team_37@mail.com',0,0,0,0,1,1211,10,1,NULL,NULL,NULL,NULL,NULL),(38,'team_38','coach_38',15,'team_38@mail.com',0,0,0,0,1,186,8,1,NULL,NULL,NULL,NULL,NULL),(40,'team_40','coach_40',21,'team_40@mail.com',0,0,0,0,1,480,1,1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tournament_coach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_coach_team`
--

DROP TABLE IF EXISTS `tournament_coach_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament_coach_team` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=346 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_coach_team`
--

LOCK TABLES `tournament_coach_team` WRITE;
/*!40000 ALTER TABLE `tournament_coach_team` DISABLE KEYS */;
INSERT INTO `tournament_coach_team` VALUES (1,'coach_team_1'),(2,'coach_team_2'),(3,'coach_team_3'),(4,'coach_team_4'),(5,'coach_team_5'),(6,'coach_team_6'),(7,'coach_team_7'),(8,'coach_team_8'),(9,'coach_team_9'),(10,'coach_team_10'),(11,'coach_team_11'),(12,'coach_team_12');
/*!40000 ALTER TABLE `tournament_coach_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_edition`
--

DROP TABLE IF EXISTS `tournament_edition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament_edition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day_1` date NOT NULL,
  `day_2` date NOT NULL,
  `round_number` int(11) NOT NULL,
  `current_round` int(11) NOT NULL,
  `use_finale` tinyint(1) NOT NULL DEFAULT 1,
  `full_triplette` tinyint(4) NOT NULL DEFAULT 1,
  `ranking_strategy` varchar(65) COLLATE utf8_unicode_ci NOT NULL,
  `first_day_round` int(11) NOT NULL DEFAULT 3,
  `organiser` varchar(65) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_edition`
--

LOCK TABLES `tournament_edition` WRITE;
/*!40000 ALTER TABLE `tournament_edition` DISABLE KEYS */;
INSERT INTO `tournament_edition` VALUES (1,'2018-05-19','2018-05-20',5,5,1,1,'Rdvbb14',3,'organiser_1');
/*!40000 ALTER TABLE `tournament_edition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_match`
--

DROP TABLE IF EXISTS `tournament_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament_match` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_coach_1` int(11) DEFAULT NULL,
  `id_coach_2` int(11) DEFAULT NULL,
  `td_1` smallint(6) NOT NULL,
  `td_2` smallint(6) NOT NULL,
  `round` smallint(6) NOT NULL,
  `points_1` smallint(6) DEFAULT NULL,
  `points_2` smallint(6) DEFAULT NULL,
  `casualties_1` smallint(6) DEFAULT NULL,
  `casualties_2` smallint(6) DEFAULT NULL,
  `completions_1` smallint(6) DEFAULT NULL,
  `completions_2` smallint(6) DEFAULT NULL,
  `fouls_1` smallint(6) DEFAULT NULL,
  `fouls_2` smallint(6) DEFAULT NULL,
  `special_1` varchar(33) COLLATE utf8_bin DEFAULT NULL,
  `special_2` varchar(33) COLLATE utf8_bin DEFAULT NULL,
  `finale` tinyint(1) NOT NULL,
  `edition` smallint(6) NOT NULL,
  `status` varchar(33) COLLATE utf8_bin NOT NULL,
  `table_number` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BB0D551CA7F540D0` (`id_coach_1`),
  KEY `IDX_BB0D551C3EFC116A` (`id_coach_2`)
) ENGINE=MyISAM AUTO_INCREMENT=2581 DEFAULT CHARSET=utf8 COLLATE=utf8_bin PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_match`
--

LOCK TABLES `tournament_match` WRITE;
/*!40000 ALTER TABLE `tournament_match` DISABLE KEYS */;
INSERT INTO `tournament_match` VALUES (1,29,2,2,1,1,1000,0,1,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',11),(2,28,1,0,3,1,0,1000,1,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',12),(3,37,40,2,1,1,1000,0,0,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',13),(4,35,4,1,0,1,1000,0,1,4,NULL,NULL,0,0,NULL,NULL,0,1,'resume',21),(5,36,5,1,1,1,500,500,2,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',22),(6,34,6,0,2,1,0,1000,0,3,NULL,NULL,0,0,NULL,NULL,0,1,'resume',23),(7,16,10,1,0,1,1000,0,3,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',31),(8,18,11,2,0,1,1000,0,1,2,NULL,NULL,0,1,NULL,NULL,0,1,'resume',32),(9,17,12,1,3,1,0,1000,2,1,NULL,NULL,1,1,NULL,NULL,0,1,'resume',33),(10,39,20,1,1,1,500,500,1,0,NULL,NULL,2,0,NULL,NULL,0,1,'resume',41),(11,9,19,1,1,1,500,500,2,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',42),(12,8,21,0,3,1,0,1000,0,4,NULL,NULL,0,0,NULL,NULL,0,1,'resume',43),(13,15,22,1,2,1,0,1000,1,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',51),(14,14,23,1,2,1,0,1000,1,4,NULL,NULL,1,0,NULL,NULL,0,1,'resume',52),(15,13,38,1,2,1,0,1000,0,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',53),(16,33,25,0,1,1,0,1000,2,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',61),(17,31,27,1,1,1,500,500,2,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',62),(18,32,26,1,1,1,500,500,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',63),(19,23,16,0,1,2,0,1000,1,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',11),(20,38,18,2,0,2,1000,0,2,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',12),(21,22,17,5,0,2,1000,0,0,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',13),(22,29,21,1,0,2,1000,0,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',21),(23,37,19,0,1,2,0,1000,1,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',22),(24,28,20,0,1,2,0,1000,1,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',23),(25,25,6,2,0,2,1000,0,1,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',31),(26,26,5,2,1,2,1000,0,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',32),(27,27,4,1,1,2,500,500,0,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',33),(28,35,1,0,2,2,0,1000,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',41),(29,36,40,0,2,2,0,1000,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',42),(30,34,2,0,2,2,0,1000,0,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',43),(31,12,39,2,0,2,1000,0,1,1,NULL,NULL,0,1,NULL,NULL,0,1,'resume',51),(32,11,9,3,0,2,1000,0,1,2,NULL,NULL,1,0,NULL,NULL,0,1,'resume',52),(33,10,8,1,0,2,1000,0,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',53),(34,31,15,1,0,2,1000,0,1,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',61),(35,32,13,2,1,2,1000,0,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',62),(36,33,14,2,0,2,1000,0,0,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',63),(37,38,25,2,1,3,1000,0,3,5,NULL,NULL,0,0,NULL,NULL,0,1,'resume',11),(38,22,26,1,1,3,500,500,3,4,NULL,NULL,0,0,NULL,NULL,0,1,'resume',12),(39,23,27,1,1,3,500,500,3,3,NULL,NULL,0,0,NULL,NULL,0,1,'resume',13),(40,19,1,0,1,3,0,1000,3,6,NULL,NULL,0,1,NULL,NULL,0,1,'resume',21),(41,20,2,0,2,3,0,1000,2,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',22),(42,21,40,3,1,3,1000,0,7,3,NULL,NULL,0,0,NULL,NULL,0,1,'resume',23),(43,12,32,2,2,3,500,500,4,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',31),(44,10,31,2,2,3,500,500,0,6,NULL,NULL,0,0,NULL,NULL,0,1,'resume',32),(45,11,33,0,1,3,0,1000,5,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',33),(46,16,29,1,2,3,0,1000,2,7,NULL,NULL,0,0,NULL,NULL,0,1,'resume',41),(47,18,37,0,2,3,0,1000,1,3,NULL,NULL,0,0,NULL,NULL,0,1,'resume',42),(48,17,28,2,0,3,1000,0,6,2,NULL,NULL,1,0,NULL,NULL,0,1,'resume',43),(49,6,39,1,0,3,1000,0,4,1,NULL,NULL,0,3,NULL,NULL,0,1,'resume',51),(50,4,9,1,1,3,500,500,3,4,NULL,NULL,0,0,NULL,NULL,0,1,'resume',52),(51,5,8,2,1,3,1000,0,3,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',53),(52,35,15,0,3,3,0,1000,2,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',61),(53,36,13,2,1,3,1000,0,3,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',62),(54,34,14,2,1,3,1000,0,3,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',63),(55,38,1,0,0,4,500,500,2,6,NULL,NULL,0,0,NULL,NULL,0,1,'resume',11),(56,22,2,0,2,4,0,1000,0,2,NULL,NULL,0,1,NULL,NULL,0,1,'resume',12),(57,23,40,1,0,4,1000,0,0,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',13),(58,29,33,2,1,4,1000,0,2,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',21),(59,37,32,0,1,4,0,1000,0,5,NULL,NULL,1,0,NULL,NULL,0,1,'resume',22),(60,28,31,0,0,4,500,500,1,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',23),(61,21,25,0,3,4,0,1000,4,4,NULL,NULL,0,0,NULL,NULL,0,1,'resume',31),(62,19,26,1,1,4,500,500,2,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',32),(63,20,27,0,1,4,0,1000,2,1,NULL,NULL,1,0,NULL,NULL,0,1,'resume',33),(64,6,12,0,1,4,0,1000,1,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',41),(65,5,10,2,0,4,1000,0,7,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',42),(66,4,11,0,2,4,0,1000,6,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',43),(67,36,16,1,2,4,0,1000,5,0,NULL,NULL,1,0,NULL,NULL,0,1,'resume',51),(68,35,18,1,0,4,1000,0,2,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',52),(69,34,17,1,0,4,1000,0,4,3,NULL,NULL,0,0,NULL,NULL,0,1,'resume',53),(70,15,9,1,0,4,1000,0,2,2,NULL,NULL,0,1,NULL,NULL,0,1,'resume',61),(71,13,39,3,0,4,1000,0,0,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',62),(72,14,8,1,1,4,500,500,1,0,NULL,NULL,0,2,NULL,NULL,0,1,'resume',63),(93,23,26,2,0,5,1000,0,3,0,NULL,NULL,0,0,NULL,NULL,1,1,'resume',3),(92,22,25,0,1,5,0,1000,1,1,NULL,NULL,0,0,NULL,NULL,1,1,'resume',2),(91,38,27,1,0,5,1000,0,3,2,NULL,NULL,0,0,NULL,NULL,1,1,'resume',1),(76,1,32,0,1,5,0,1000,0,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',11),(77,2,31,1,1,5,500,500,3,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',12),(78,40,33,0,3,5,0,1000,0,1,NULL,NULL,0,0,NULL,NULL,0,1,'resume',13),(79,29,35,3,0,5,1000,0,2,2,NULL,NULL,0,1,NULL,NULL,0,1,'resume',21),(80,37,34,1,2,5,0,1000,1,4,NULL,NULL,0,0,NULL,NULL,0,1,'resume',22),(81,28,36,2,1,5,1000,0,0,2,NULL,NULL,1,1,NULL,NULL,0,1,'resume',23),(82,12,21,1,2,5,0,1000,0,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',31),(83,11,19,1,1,5,500,500,1,1,NULL,NULL,1,0,NULL,NULL,0,1,'resume',32),(84,10,20,1,1,5,500,500,1,2,NULL,NULL,0,0,NULL,NULL,0,1,'resume',33),(85,5,15,1,1,5,500,500,4,0,NULL,NULL,0,0,NULL,NULL,0,1,'resume',41),(86,6,13,1,4,5,0,1000,4,0,NULL,NULL,1,0,NULL,NULL,0,1,'resume',42),(87,4,14,0,2,5,0,1000,0,3,NULL,NULL,1,1,NULL,NULL,0,1,'resume',43),(88,16,9,2,0,5,1000,0,4,0,NULL,NULL,1,0,NULL,NULL,0,1,'resume',51),(89,18,39,2,0,5,1000,0,1,0,NULL,0,0,3,NULL,NULL,0,1,'resume',52),(90,17,8,1,0,5,1000,0,2,4,NULL,NULL,0,0,NULL,NULL,0,1,'resume',53);
/*!40000 ALTER TABLE `tournament_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_precoach`
--

DROP TABLE IF EXISTS `tournament_precoach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament_precoach` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(65) COLLATE utf8_unicode_ci NOT NULL,
  `id_race` int(11) NOT NULL,
  `email` varchar(129) COLLATE utf8_unicode_ci NOT NULL,
  `edition` int(11) NOT NULL,
  `naf_number` int(11) NOT NULL,
  `lang` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `team_name` varchar(129) COLLATE utf8_unicode_ci NOT NULL,
  `id_coach_team` int(11) NOT NULL,
  `contact` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_precoach`
--

LOCK TABLES `tournament_precoach` WRITE;
/*!40000 ALTER TABLE `tournament_precoach` DISABLE KEYS */;
/*!40000 ALTER TABLE `tournament_precoach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_race`
--

DROP TABLE IF EXISTS `tournament_race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament_race` (
  `edition` smallint(6) NOT NULL,
  `id_race` int(11) NOT NULL AUTO_INCREMENT,
  `nom_fr` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
  `nom_en` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
  `nom_en_2` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
  `nom_fr_2` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
  `reroll` smallint(6) NOT NULL,
  PRIMARY KEY (`id_race`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_race`
--

LOCK TABLES `tournament_race` WRITE;
/*!40000 ALTER TABLE `tournament_race` DISABLE KEYS */;
INSERT INTO `tournament_race` VALUES (1,1,'Orc','Orc','Orc','d\'orcs',6),(1,2,'Skaven','Skaven','Skaven','de skavens',6),(1,3,'Elfe noir','Dark elf','Dark Elves','d\'elfes noirs',5),(1,4,'Humain','Human','Humans','d\'hommes',5),(1,5,'Nain','Dwarf','Dwarves','de nains',4),(1,6,'Haut elfe','High elf','High Elves','d\'hauts elfes',5),(1,7,'Gobelin','Goblin','Goblins','de gobelins',6),(1,8,'Halfling','Halfling','Halflings','de halflings',6),(1,9,'Elfe sylvain','Wood elf','Wood elves','d\'elfes sylvains',5),(1,10,'Chaos','Chaos','Chaos','du Chaos',7),(1,11,'Nain du Chaos','Chaos dwarf','Chaos dwarves','de nains du Chaos',7),(1,12,'Mort-vivant','Undead','Undead','de mort-vivants',7),(1,13,'Nordique','Norse','Norse','de nordiques',6),(1,14,'Amazone','Amazon','Amazons','d\'amazones',4),(1,15,'Homme-lézard','Lizardmen','Lizardmen','d\'hommes lézards',6),(2,16,'Khemri','Khemri','Khemri','de Khemri',7),(2,17,'Nécromantique','Necromantic','Necromantic','nécromantique',7),(2,18,'Elfe pro','Elf','Elves','d\'elfes pro',5),(2,19,'Nurgle','Nurgle','Nurgle\'s Rotters','des pourris de Nurgle',7),(3,20,'Ogre','Ogre','Ogres','d\'ogres',7),(3,21,'Vampire','Vampire','Vampires','de vampires',7),(7,22,'Bas fonds','Underworld','Underworld','des bas fonds',7),(7,23,'Pacte chaotique','Chaos Pact','Chaos Pact','chaotique',7),(7,24,'Slann','Slann','Slann','de slanns',5),(1,25,'Inconnu','Unknown','Unknown','inconnu',5),(10,26,'Skink','skink','skink','skink',5),(16,27,'Khorne','Khorne','Khorne','Khorne',7),(16,28,'Bretonniens','Bretonnian','Bretonnians','bretonnienne',7);
/*!40000 ALTER TABLE `tournament_race` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-03 19:26:20
