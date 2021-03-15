-- MySQL dump 10.13  Distrib 8.0.18, for osx10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: mqtt_auth_2
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_levels`
--

DROP TABLE IF EXISTS `access_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_levels` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_levels`
--

LOCK TABLES `access_levels` WRITE;
/*!40000 ALTER TABLE `access_levels` DISABLE KEYS */;
INSERT INTO `access_levels` (`id`, `name`) VALUES (0,'Forbidden'),(1,'Read Only'),(2,'Write Only'),(3,'Read and Write'),(4,'Subscribe Only'),(5,'Read and Subscribe'),(6,'Write and Subscribe'),(7,'Read, Write and Subscribe'),(255,'godmode');
/*!40000 ALTER TABLE `access_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acls`
--

DROP TABLE IF EXISTS `acls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `privilege_id` bigint(20) unsigned DEFAULT NULL,
  `namespace` varchar(100) NOT NULL,
  `group_id` varchar(100) DEFAULT NULL,
  `message_type` varchar(100) DEFAULT NULL,
  `edge_node_id` varchar(100) DEFAULT NULL,
  `device_id` varchar(100) DEFAULT NULL,
  `rw` tinyint(3) unsigned NOT NULL,
  `topic` varchar(200) GENERATED ALWAYS AS (concat_ws(_utf8mb4'/',`namespace`,`group_id`,`message_type`,`edge_node_id`,`device_id`)) VIRTUAL NOT NULL,
  `rw_emqx` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acl_roles_rw_FK` (`rw`),
  KEY `acls_FK` (`privilege_id`),
  CONSTRAINT `acl_roles_rw_FK` FOREIGN KEY (`rw`) REFERENCES `access_levels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `acls_FK` FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acls`
--

LOCK TABLES `acls` WRITE;
/*!40000 ALTER TABLE `acls` DISABLE KEYS */;
INSERT INTO `acls` (`id`, `privilege_id`, `namespace`, `group_id`, `message_type`, `edge_node_id`, `device_id`, `rw`, `rw_emqx`) VALUES (4,6,'spBv1.0','#',NULL,NULL,NULL,5,0),(5,3,'STATE','%n',NULL,NULL,NULL,2,0),(9,9,'STATE','#',NULL,NULL,NULL,5,0),(11,4,'spBv1.0','%g','+','%n',NULL,2,0),(14,4,'spBv1.0','%g','NCMD','%n','#',5,0),(16,5,'spBv1.0','%g','+','%n','+',2,0),(31,7,'spBv1.0','%g','#',NULL,NULL,5,0),(34,10,'STATE','%g',NULL,NULL,NULL,2,0),(38,2,'spBv1.0','%g','NCMD','+',NULL,2,0),(39,2,'spBv1.0','%g','DCMD','#',NULL,2,0),(47,8,'spBv1.0','%g','#',NULL,NULL,2,0),(54,12,'spBv1.0','#',NULL,NULL,NULL,4,0),(92,1,'spBv1.0','+','NCMD','+',NULL,2,NULL),(93,1,'spBv1.0','+','DCMD','#',NULL,2,NULL),(96,5,'spBv1.0','%g','DCMD','%n','+',5,0);
/*!40000 ALTER TABLE `acls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `groups_UN` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_nodes_supplemental_roles`
--

DROP TABLE IF EXISTS `link_nodes_supplemental_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `link_nodes_supplemental_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `link_nodes_roles_FK` (`role_id`),
  KEY `link_nodes_supplemental_roles_FK` (`node_id`),
  CONSTRAINT `link_nodes_roles_FK` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `link_nodes_supplemental_roles_FK` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_nodes_supplemental_roles`
--

LOCK TABLES `link_nodes_supplemental_roles` WRITE;
/*!40000 ALTER TABLE `link_nodes_supplemental_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `link_nodes_supplemental_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_roles_privileges`
--

DROP TABLE IF EXISTS `link_roles_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `link_roles_privileges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `privilege_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_permissions_FK` (`role_id`),
  KEY `roles_permissions_FK_1` (`privilege_id`),
  CONSTRAINT `roles_permissions_FK` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `roles_permissions_FK_1` FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_roles_privileges`
--

LOCK TABLES `link_roles_privileges` WRITE;
/*!40000 ALTER TABLE `link_roles_privileges` DISABLE KEYS */;
INSERT INTO `link_roles_privileges` (`id`, `role_id`, `privilege_id`) VALUES (1,1,1),(2,1,3),(3,1,9),(4,1,6),(5,2,2),(6,2,3),(7,2,4),(8,2,7),(9,2,9),(10,3,4),(11,3,9),(12,4,4),(13,4,5),(14,4,9),(15,5,7),(16,5,8),(17,5,9),(18,5,10),(20,5,12),(21,5,11),(24,2,12),(25,3,12),(26,4,12);
/*!40000 ALTER TABLE `link_roles_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nodes`
--

DROP TABLE IF EXISTS `nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nodes` (
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `node_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `group_id` bigint(20) unsigned NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `is_valid` tinyint(1) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `principal_role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `password_hash` (`password_hash`),
  UNIQUE KEY `nodes_UN` (`username`),
  UNIQUE KEY `node_group_UN` (`group_id`,`node_id`),
  KEY `nodes_FK` (`principal_role_id`),
  KEY `nodes_FK_1` (`group_id`),
  CONSTRAINT `nodes_FK` FOREIGN KEY (`principal_role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nodes_FK_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nodes`
--

LOCK TABLES `nodes` WRITE;
/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privileges`
--

DROP TABLE IF EXISTS `privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privileges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privileges`
--

LOCK TABLES `privileges` WRITE;
/*!40000 ALTER TABLE `privileges` DISABLE KEYS */;
INSERT INTO `privileges` (`id`, `name`) VALUES (1,'Issue Global Commands'),(2,'Issue Group Commands'),(3,'Update Own State'),(4,'Participate as Node'),(5,'Represent Devices'),(6,'Subscribe and Read Whole Namespace'),(7,'Subscribe and Read Own Group'),(8,'Publish All from Group'),(9,'Subscribe and Read all States'),(10,'Update Group State'),(12,'Subscribe to Whole Namespace');
/*!40000 ALTER TABLE `privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `is_principal` tinyint(1) NOT NULL DEFAULT '0',
  `icon` varchar(20) DEFAULT NULL COMMENT 'Added by Alex on 9th Jan 2021',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_UN` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `is_principal`, `icon`) VALUES (1,'global primary application',1,'fa fa-globe-europe'),(2,'group primary application',1,'fas fa-expand'),(3,'secondary application',1,'fa fa-layer-group'),(4,'edge node',1,'fa fa-sitemap'),(5,'gateway bridge',1,NULL),(6,'none',1,'far fa-times-circle');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_acl_joined`
--

DROP TABLE IF EXISTS `view_acl_joined`;
/*!50001 DROP VIEW IF EXISTS `view_acl_joined`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_acl_joined` AS SELECT 
 1 AS `username`,
 1 AS `topic`,
 1 AS `rw`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_acl_joined`
--

/*!50001 DROP VIEW IF EXISTS `view_acl_joined`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_acl_joined` AS select 1 AS `username`,1 AS `topic`,1 AS `rw` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-15  8:40:10
