-- MySQL dump 10.17  Distrib 10.3.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: tournament
-- ------------------------------------------------------
-- Server version	10.3.14-MariaDB-1:10.3.14+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user`
--

LOCK TABLES `fos_user` WRITE;
/*!40000 ALTER TABLE `fos_user` DISABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_edition`
--

LOCK TABLES `tournament_edition` WRITE;
/*!40000 ALTER TABLE `tournament_edition` DISABLE KEYS */;
INSERT INTO `tournament_edition` VALUES (18,'2022-05-08','2022-05-09',5,0,1,1,'Rdvbb18',3,'Sebotouno');
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_match`
--

LOCK TABLES `tournament_match` WRITE;
/*!40000 ALTER TABLE `tournament_match` DISABLE KEYS */;
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
INSERT INTO `tournament_race` VALUES (1,1,'Orc','Orc','Orc','d\'orcs',6),(1,2,'Skaven','Skaven','Skaven','de skavens',6),(1,3,'Elfe noir','Dark elf','Dark Elves','d\'elfes noirs',5),(1,4,'Humain','Human','Humans','d\'hommes',5),(1,5,'Nain','Dwarf','Dwarves','de nains',4),(1,6,'Haut elfe','High elf','High Elves','d\'hauts elfes',5),(1,7,'Gobelin','Goblin','Goblins','de gobelins',6),(1,8,'Halfling','Halfling','Halflings','de halflings',6),(1,9,'Elfe sylvain','Wood elf','Wood Elves','d\'elfes sylvains',5),(1,10,'Elus du Chaos','Chaos Chosen','Chaos','du Chaos',7),(1,11,'Nain du Chaos','Chaos dwarf','Chaos Dwarves','de nains du Chaos',7),(1,12,'Mort-vivant','Undead','Undead','de mort-vivants',7),(1,13,'Nordique','Norse','Norse','de nordiques',6),(1,14,'Amazone','Amazon','Amazons','d\'amazones',4),(1,15,'Homme-lézard','Lizardmen','Lizardmen','d\'hommes lézards',6),(2,16,'Khemri','Khemri','Khemri','de Khemri',7),(2,17,'Horreurs Nécromantiques','Necromantic','Necromantic','nécromantique',7),(2,18,'Elfe pro','Elf','Elf Union','d\'elfes pro',5),(2,19,'Nurgle','Nurgle','Nurgle\'s Rotters','des pourris de Nurgle',7),(3,20,'Ogre','Ogre','Ogres','d\'ogres',7),(3,21,'Vampire','Vampire','Vampires','de vampires',7),(7,22,'Bas fonds','Underworld','Underworld Denizens','des bas fonds',7),(7,23,'Pacte chaotique','Chaos Pact','Chaos Renegades','chaotique',7),(7,24,'Slann','Slann','Slann','de slanns',5),(1,25,'Inconnu','Unknown','Unknown','inconnu',5),(10,26,'Skink','skink','skink','skink',5),(16,27,'Khorne','Khorne','Daemons of Khorne','Khorne',7),(16,28,'Bretonniens','Bretonnian','Bretonnians','bretonnienne',7),(18,29,'Vieux Monde','Old World','Alliance of Old World','Alliance du vieux monde',7),(18,30,'Noblesse impériale','Imperial Nobility','of imperial nobility','de la noblesse impériale',7),(18,31,'Snotling','Snotling','of snotlings','de  snotlings',6);
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

-- Dump completed on 2019-06-06 22:39:59
