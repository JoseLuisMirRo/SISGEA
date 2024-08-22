-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: sisgea.cva1cb77g6fg.us-east-1.rds.amazonaws.com    Database: sisgea_prod
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `id` int NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'D1','Docencia 1'),(2,'D2','Docencia 2'),(3,'D3','Docencia 3'),(4,'D4','Docencia 4'),(5,'D5','Docencia 5'),(6,'CCC','CECADEC'),(7,'CDM','CEDIM'),(8,'TP1','Taller Pesado 1'),(9,'TP2','Taller Pesado 2');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `program_id` int NOT NULL,
  `status` tinyint DEFAULT NULL,
  `grade_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_class_program1_idx` (`program_id`),
  KEY `idx_class_program` (`program_id`),
  KEY `fk_class_grade_id` (`grade_id`),
  CONSTRAINT `fk_class_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`),
  CONSTRAINT `fk_class_program1` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'Base de Datos para Aplicaciones',1,0,1),(2,'Aplicaciones Web',1,1,3),(3,'Formación Sociocultural III',1,1,3),(9,'Probabilidad y estadística',1,1,3),(10,'Ingles III',5,1,3),(11,'Ingles VIII',6,1,9),(15,'Ignacio',7,0,1),(20,'Ingles VIII',7,1,9),(21,'Integradora l',1,1,3),(22,'Sistemas Operativos',1,1,3),(23,'Ingles III',8,1,3),(24,'Infraestructura de Redes Datos',2,1,3),(25,'Sistemas de Calidad para TI',3,1,9),(26,'Admon de proy TI',4,1,9),(27,'Integradora l',2,1,3),(28,'BD para Aplic',1,1,3),(29,'Matemáticas',8,1,3),(30,'Admon de la Manufactura',7,1,9),(31,'Matemáticas',1,1,3),(32,'Proceso Administrativo',5,1,3),(33,'Dir Eq Alto Rend',4,1,9),(34,'Formación Sociocultural III',5,1,3),(35,'Costos',5,1,3),(36,'Cálculo Diferencial',1,1,3),(37,'Dir Eq Alto Rend',6,1,9),(38,'Ingles VIII',4,1,9),(39,'Ingles VIII',3,1,9),(40,'Ingles III',1,1,3),(41,'Dir Eq Alto Rend',3,1,9),(42,'Ingles III',2,1,3),(43,'Software CAD',5,1,3),(44,'Aplicaciones Web',2,1,3),(45,'Hacking ético',3,1,9),(46,'Des p disp inteligentes',4,1,9),(47,'Autom Infraest Dig I',3,1,9),(48,'Proc Prod Audiovisual',6,1,9),(49,'Sistemas Operativos',2,1,3),(50,'Extrac de conoc en BD',4,1,9),(51,'Conmut Redes Dat',2,1,3),(52,'Dirección de proyectos II',3,1,9),(53,'Des Web integral',4,1,9),(54,'Formación Sociocultural I',2,1,1),(55,'Formación Sociocultural II',2,1,2);
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11);
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonbusinessday`
--

DROP TABLE IF EXISTS `nonbusinessday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nonbusinessday` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonbusinessday`
--

LOCK TABLES `nonbusinessday` WRITE;
/*!40000 ALTER TABLE `nonbusinessday` DISABLE KEYS */;
INSERT INTO `nonbusinessday` VALUES (1,'Día de la independencia ','2024-09-16'),(2,'Transición del Poder Judicial','2024-10-01'),(3,'Dia de Todos los Santos','2024-11-01'),(4,'Dia de Muertos','2024-11-02'),(5,'Revolución Mexicana','2024-11-18'),(6,'Dia de Navidad','2024-12-25'),(7,'30 de agosto','2024-08-30');
/*!40000 ALTER TABLE `nonbusinessday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (1,'T.S.U. DSM'),(2,'T.S.U. IRD'),(3,'IRIyC'),(4,'IDGS'),(5,'T.S.U. DD'),(6,'IDDyPA'),(7,'DTM'),(8,'T.S.U. DMI');
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quarter`
--

DROP TABLE IF EXISTS `quarter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quarter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quarter`
--

LOCK TABLES `quarter` WRITE;
/*!40000 ALTER TABLE `quarter` DISABLE KEYS */;
INSERT INTO `quarter` VALUES (1,'May-Ago 2024','2024-04-29','2024-08-30');
/*!40000 ALTER TABLE `quarter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserve`
--

DROP TABLE IF EXISTS `reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserve` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `room_id` int NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `date` date NOT NULL,
  `starttime` time NOT NULL,
  `endtime` time NOT NULL,
  `status` enum('Active','Canceled','Admin_Canceled') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reserve_user1_idx` (`user_id`),
  KEY `fk_reserve_room1_idx` (`room_id`),
  CONSTRAINT `fk_reserve_room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `fk_reserve_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserve`
--

LOCK TABLES `reserve` WRITE;
/*!40000 ALTER TABLE `reserve` DISABLE KEYS */;
INSERT INTO `reserve` VALUES (1,1,1,'Asesoría Base de datos','2024-07-17','11:00:00','12:00:00','Active'),(2,1,4,'Recupera AppWeb','2024-07-22','11:00:00','12:00:00','Admin_Canceled'),(4,1,3,'Recupera Probabilidad','2024-07-26','08:30:00','10:30:00','Admin_Canceled'),(5,1,4,'Asesoría App Web','2024-07-17','17:00:00','18:00:00','Active'),(6,1,6,'Asesoría Cálculo','2024-07-31','20:00:00','21:00:00','Active'),(8,21,5,'Asesoria ','2024-08-16','09:00:00','11:00:00','Canceled'),(9,25,12,'Asesoría','2024-08-15','16:00:00','17:00:00','Active');
/*!40000 ALTER TABLE `reserve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Administrador'),(2,'Docente'),(3,'Alumno');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roomtype_id` int NOT NULL,
  `building_id` int NOT NULL,
  `number` int DEFAULT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_room_roomtype1_idx` (`roomtype_id`),
  KEY `fk_room_building1_idx` (`building_id`),
  KEY `idx_room_roomtype` (`roomtype_id`),
  KEY `idx_room_building` (`building_id`),
  CONSTRAINT `fk_room_building1` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`),
  CONSTRAINT `fk_room_roomtype1` FOREIGN KEY (`roomtype_id`) REFERENCES `roomtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,1,1,2,1),(3,1,1,3,1),(4,2,6,10,1),(5,2,2,6,1),(6,1,1,1,1),(8,1,1,6,1),(9,1,1,5,1),(10,3,4,2,1),(11,2,2,7,1),(12,2,4,11,1);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomtype`
--

DROP TABLE IF EXISTS `roomtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomtype` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `abbreviation` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomtype`
--

LOCK TABLES `roomtype` WRITE;
/*!40000 ALTER TABLE `roomtype` DISABLE KEYS */;
INSERT INTO `roomtype` VALUES (1,'Aula','A'),(2,'Centro de cómputo','CC'),(3,'Compu Aula','CA'),(4,'Sala','S');
/*!40000 ALTER TABLE `roomtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `quarter_id` int NOT NULL,
  `room_id` int NOT NULL,
  `day` enum('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `starttime` time NOT NULL,
  `endtime` time NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_schedule_class1_idx` (`class_id`),
  KEY `fk_schedule_quarter1_idx` (`quarter_id`),
  KEY `fk_schedule_room1_idx` (`room_id`),
  KEY `idx_schedule_class` (`class_id`),
  KEY `idx_schedule_quarter` (`quarter_id`),
  KEY `idx_schedule_room` (`room_id`),
  KEY `fk_group_id` (`group_id`),
  CONSTRAINT `fk_group_id` FOREIGN KEY (`group_id`) REFERENCES `schedule_group` (`id`),
  CONSTRAINT `fk_schedule_class1` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `fk_schedule_quarter1` FOREIGN KEY (`quarter_id`) REFERENCES `quarter` (`id`),
  CONSTRAINT `fk_schedule_room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (13,9,1,6,'Lunes','09:00:00','12:00:00',1),(14,10,1,6,'Lunes','13:00:00','15:00:00',2),(15,11,1,6,'Lunes','15:00:00','17:00:00',1),(16,20,1,6,'Lunes','17:00:00','19:00:00',1),(17,23,1,6,'Martes','09:00:00','10:00:00',3),(18,10,1,6,'Martes','10:00:00','12:00:00',1),(19,10,1,6,'Martes','13:00:00','15:00:00',2),(20,11,1,6,'Martes','19:00:00','21:00:00',4),(21,10,1,6,'Miercoles','10:00:00','12:00:00',1),(22,10,1,6,'Miercoles','12:00:00','14:00:00',3),(23,20,1,6,'Miercoles','15:00:00','16:00:00',1),(24,11,1,6,'Miercoles','16:00:00','18:00:00',1),(25,20,1,6,'Miercoles','18:00:00','20:00:00',2),(26,23,1,6,'Jueves','09:00:00','10:00:00',3),(27,23,1,6,'Jueves','10:00:00','12:00:00',1),(28,10,1,6,'Jueves','12:00:00','14:00:00',3),(29,3,1,8,'Lunes','08:00:00','10:00:00',4),(30,29,1,8,'Lunes','12:00:00','14:00:00',3),(32,31,1,8,'Martes','11:00:00','12:00:00',3),(33,32,1,8,'Martes','15:00:00','16:00:00',1),(34,33,1,8,'Martes','18:00:00','19:00:00',3),(35,34,1,8,'Miercoles','14:00:00','15:00:00',2),(36,35,1,8,'Miercoles','16:00:00','17:00:00',4),(37,11,1,8,'Miercoles','18:00:00','19:00:00',3),(38,11,1,8,'Miercoles','19:00:00','20:00:00',2),(39,37,1,8,'Jueves','17:00:00','18:00:00',3),(40,32,1,8,'Jueves','08:00:00','09:00:00',3),(41,36,1,8,'Jueves','12:00:00','14:00:00',2),(42,32,1,8,'Viernes','10:00:00','12:00:00',2),(43,32,1,8,'Viernes','12:00:00','13:00:00',1),(44,35,1,8,'Viernes','15:00:00','16:00:00',3),(45,20,1,8,'Viernes','16:00:00','18:00:00',1),(46,20,1,8,'Viernes','18:00:00','19:00:00',2),(47,9,1,9,'Lunes','12:00:00','15:00:00',1),(48,23,1,9,'Lunes','11:00:00','12:00:00',1),(49,26,1,9,'Lunes','15:00:00','16:00:00',1),(50,35,1,9,'Lunes','16:00:00','17:00:00',1),(51,38,1,9,'Lunes','17:00:00','18:00:00',1),(52,39,1,9,'Lunes','20:00:00','21:00:00',1),(53,23,1,9,'Martes','09:00:00','10:00:00',1),(54,36,1,9,'Martes','10:00:00','11:00:00',1),(55,23,1,9,'Martes','13:00:00','14:00:00',1),(56,40,1,9,'Martes','15:00:00','17:00:00',1),(57,41,1,9,'Martes','17:00:00','18:00:00',1),(58,3,1,9,'Miercoles','07:00:00','08:00:00',1),(59,9,1,9,'Miercoles','09:00:00','10:00:00',1),(60,9,1,9,'Miercoles','10:00:00','12:00:00',1),(61,42,1,9,'Miercoles','12:00:00','15:00:00',1),(62,9,1,9,'Miercoles','16:00:00','18:00:00',1),(63,42,1,9,'Jueves','12:00:00','14:00:00',1),(64,40,1,9,'Jueves','14:00:00','16:00:00',1),(65,40,1,9,'Jueves','16:00:00','17:00:00',1),(66,37,1,9,'Viernes','14:00:00','15:00:00',1),(67,40,1,9,'Sabado','08:00:00','12:00:00',1),(68,44,1,10,'Lunes','08:00:00','10:00:00',7),(69,43,1,10,'Lunes','11:00:00','12:00:00',3),(70,44,1,10,'Lunes','12:00:00','13:00:00',8),(71,2,1,10,'Lunes','13:00:00','14:00:00',2),(72,2,1,10,'Lunes','14:00:00','16:00:00',1),(73,45,1,10,'Lunes','16:00:00','18:00:00',1),(74,46,1,10,'Lunes','18:00:00','20:00:00',3),(75,44,1,10,'Martes','09:00:00','10:00:00',8),(76,2,1,10,'Martes','11:00:00','13:00:00',4),(77,2,1,10,'Martes','13:00:00','14:00:00',2),(78,2,1,10,'Martes','14:00:00','15:00:00',5),(79,47,1,10,'Martes','15:00:00','17:00:00',1),(80,48,1,10,'Martes','17:00:00','18:00:00',1),(81,48,1,10,'Martes','18:00:00','19:00:00',3),(82,44,1,10,'Miercoles','08:00:00','09:00:00',7),(83,2,1,10,'Miercoles','10:00:00','12:00:00',4),(84,2,1,10,'Miercoles','13:00:00','14:00:00',1),(85,2,1,10,'Miercoles','14:00:00','15:00:00',6),(86,45,1,10,'Miercoles','15:00:00','16:00:00',1),(87,46,1,10,'Miercoles','16:00:00','17:00:00',3),(88,2,1,10,'Miercoles','18:00:00','19:00:00',6),(89,2,1,10,'Miercoles','19:00:00','21:00:00',5),(90,2,1,10,'Jueves','08:00:00','10:00:00',4),(91,44,1,10,'Jueves','10:00:00','12:00:00',8),(92,49,1,10,'Jueves','14:00:00','15:00:00',7),(93,45,1,10,'Jueves','15:00:00','17:00:00',1),(94,48,1,10,'Jueves','18:00:00','19:00:00',3),(95,2,1,10,'Jueves','20:00:00','21:00:00',5),(96,44,1,10,'Viernes','10:00:00','12:00:00',8),(97,2,1,10,'Viernes','12:00:00','14:00:00',2),(98,2,1,10,'Viernes','14:00:00','16:00:00',3),(99,47,1,10,'Viernes','16:00:00','18:00:00',1),(100,21,1,5,'Lunes','10:00:00','12:00:00',3),(101,21,1,5,'Lunes','12:00:00','13:00:00',1),(102,24,1,5,'Lunes','14:00:00','15:00:00',7),(103,25,1,5,'Lunes','15:00:00','16:00:00',1),(104,26,1,5,'Lunes','18:00:00','19:00:00',1),(105,24,1,5,'Martes','08:00:00','09:00:00',8),(106,24,1,5,'Martes','11:00:00','12:00:00',7),(107,27,1,5,'Martes','12:00:00','14:00:00',8),(108,21,1,5,'Martes','14:00:00','16:00:00',2),(109,26,1,5,'Martes','16:00:00','18:00:00',1),(110,28,1,5,'Martes','18:00:00','21:00:00',6),(111,22,1,5,'Miercoles','12:00:00','13:00:00',1),(112,21,1,5,'Miercoles','14:00:00','16:00:00',4),(113,25,1,5,'Miercoles','16:00:00','17:00:00',1),(114,26,1,5,'Miercoles','18:00:00','19:00:00',2),(115,53,1,5,'Miercoles','19:00:00','21:00:00',2),(116,27,1,5,'Jueves','08:00:00','10:00:00',7),(117,22,1,5,'Jueves','14:00:00','15:00:00',1),(118,26,1,5,'Jueves','17:00:00','18:00:00',2),(119,26,1,5,'Jueves','18:00:00','19:00:00',3),(120,52,1,5,'Jueves','19:00:00','20:00:00',1),(121,24,1,5,'Viernes','08:00:00','10:00:00',8),(122,22,1,5,'Viernes','10:00:00','12:00:00',1),(123,21,1,5,'Viernes','13:00:00','15:00:00',1),(124,25,1,5,'Viernes','15:00:00','16:00:00',1),(125,21,1,5,'Viernes','16:00:00','18:00:00',5),(126,28,1,5,'Viernes','18:00:00','19:00:00',1),(127,28,1,5,'Sabado','12:00:00','14:00:00',1),(128,28,1,11,'Lunes','09:00:00','10:00:00',1),(129,50,1,11,'Lunes','14:00:00','16:00:00',1),(130,28,1,11,'Lunes','17:00:00','18:00:00',6),(131,28,1,11,'Lunes','18:00:00','19:00:00',5),(132,28,1,11,'Martes','08:00:00','11:00:00',4),(133,28,1,11,'Martes','11:00:00','12:00:00',2),(134,28,1,11,'Martes','12:00:00','14:00:00',1),(135,28,1,11,'Martes','14:00:00','16:00:00',3),(136,50,1,11,'Martes','17:00:00','19:00:00',2),(137,50,1,11,'Martes','19:00:00','21:00:00',1),(138,28,1,11,'Miercoles','08:00:00','10:00:00',4),(139,28,1,11,'Miercoles','10:00:00','12:00:00',2),(140,28,1,11,'Miercoles','12:00:00','14:00:00',3),(141,50,1,11,'Miercoles','14:00:00','16:00:00',3),(142,50,1,11,'Miercoles','17:00:00','18:00:00',2),(143,21,1,11,'Miercoles','19:00:00','21:00:00',6),(144,28,1,11,'Jueves','08:00:00','10:00:00',2),(145,28,1,11,'Jueves','10:00:00','12:00:00',4),(146,28,1,11,'Jueves','12:00:00','14:00:00',1),(147,50,1,11,'Jueves','14:00:00','16:00:00',3),(148,28,1,11,'Viernes','08:00:00','10:00:00',1),(149,28,1,11,'Viernes','10:00:00','12:00:00',2),(150,28,1,11,'Viernes','12:00:00','14:00:00',3),(151,50,1,11,'Viernes','14:00:00','15:00:00',3),(152,26,1,11,'Viernes','15:00:00','16:00:00',1),(153,50,1,11,'Viernes','16:00:00','17:00:00',2),(154,50,1,11,'Viernes','17:00:00','19:00:00',1),(155,28,1,11,'Sabado','07:00:00','12:00:00',5),(156,28,1,11,'Sabado','14:00:00','15:00:00',6),(157,22,1,4,'Lunes','10:00:00','12:00:00',1),(158,51,1,4,'Lunes','12:00:00','13:00:00',1),(159,51,1,4,'Lunes','13:00:00','14:00:00',1),(160,22,1,4,'Lunes','14:00:00','16:00:00',1),(161,46,1,4,'Lunes','16:00:00','18:00:00',1),(162,52,1,4,'Lunes','19:00:00','20:00:00',1),(163,49,1,4,'Martes','07:00:00','08:00:00',1),(164,49,1,4,'Martes','12:00:00','14:00:00',1),(165,22,1,4,'Martes','14:00:00','16:00:00',1),(166,52,1,4,'Martes','19:00:00','20:00:00',1),(167,49,1,4,'Miercoles','07:00:00','08:00:00',1),(168,22,1,4,'Miercoles','12:00:00','13:00:00',1),(169,22,1,4,'Miercoles','14:00:00','15:00:00',1),(170,46,1,4,'Miercoles','15:00:00','17:00:00',1),(171,52,1,4,'Miercoles','17:00:00','18:00:00',1),(172,49,1,4,'Jueves','07:00:00','08:00:00',1),(173,51,1,4,'Jueves','10:00:00','11:00:00',1),(174,44,1,4,'Jueves','11:00:00','12:00:00',1),(175,22,1,4,'Jueves','12:00:00','14:00:00',1),(176,22,1,4,'Jueves','14:00:00','15:00:00',1),(177,22,1,4,'Jueves','15:00:00','16:00:00',1),(178,22,1,4,'Jueves','16:00:00','17:00:00',1),(179,22,1,4,'Viernes','09:00:00','10:00:00',1),(180,22,1,4,'Viernes','10:00:00','11:00:00',1),(181,22,1,4,'Viernes','11:00:00','12:00:00',1),(182,44,1,4,'Viernes','12:00:00','14:00:00',1),(183,22,1,4,'Viernes','14:00:00','17:00:00',1),(184,26,1,4,'Viernes','17:00:00','18:00:00',1),(185,51,1,12,'Martes','14:00:00','15:00:00',1),(186,35,1,12,'Miercoles','13:00:00','14:00:00',1),(187,35,1,12,'Miercoles','15:00:00','16:00:00',1),(189,30,1,8,'Lunes','15:00:00','17:00:00',1);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_group`
--

DROP TABLE IF EXISTS `schedule_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_group`
--

LOCK TABLES `schedule_group` WRITE;
/*!40000 ALTER TABLE `schedule_group` DISABLE KEYS */;
INSERT INTO `schedule_group` VALUES (1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'E'),(6,'F'),(7,'G'),(8,'H');
/*!40000 ALTER TABLE `schedule_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `firstname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `lastnamep` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `lastnamem` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'20233tn052@utez.edu.mx','Jose Luis','Miranda','Roldán','$argon2i$v=19$m=65536,t=2,p=1$NS2uXwdL4+vDQjjO84EhcQ$dgqpVgUlyUXRA3bpJncFz07cLpM2/afkvk/dDM+wkwA',1),(18,'jluis@utez.edu.mx','Jose Luis','Miranda','Roldán ','$argon2i$v=19$m=65536,t=2,p=1$+gi3n7mCyrK7vTY6vURoSw$wKldqC1P+x3fsAmbMBb+Gs4508o7kthoUHWguXrcruU',0),(21,'20233tn085@utez.edu.mx','Jassiel','Paredes','Dominguez','$argon2i$v=19$m=65536,t=2,p=1$0dGnPsBp7+YRPq2UnZ97dA$eFzSr4Kqp4L1sK+frivPyhquLikgoA7ZKpQL4KzNbB0',1),(22,'20233tn165@utez.edu.mx','Luis Ignacio','Valera','Aguilar','$argon2i$v=19$m=65536,t=2,p=1$zUKiSUl3yO9JGCQuFVXF9g$7Yc7UwKuSKAG2cWwxABItXCYGNTimV4nek0dlhKN7b4',1),(23,'20233tn186@utez.edu.mx','Uziel Jared','De Gante ','Obando','$argon2i$v=19$m=65536,t=2,p=1$rO95I2xZg9xSlSQwnef96g$bFdK40O9EibJMwxlF66RBQrYvGPRsm6UzyhFZqJZReU',1),(24,'20223tn109@utez.edu.mx','Julio César ','Santiago ','Manjarrez','$argon2i$v=19$m=65536,t=2,p=1$VqDN4qEz1XywWVCN/EXhMQ$J0RszzWjI2lnu6zolBQ9qTkbamENa3Fs3kao4+povlc',1),(25,'hugoalejandres@utez.edu.mx','Hugo Omar','Alejandres','Sánchez','$argon2i$v=19$m=65536,t=2,p=1$pJuGYLjhJsnkKOCwu1gShg$8k8NEuWdWBrMobW6lTZn3Zd8cAmd2Tuh/v4JoTahKlA',1),(29,'rootsisgea@utez.edu.mx','Jose Luis','Miranda','Roldán','$argon2i$v=19$m=65536,t=2,p=1$k5nhh4AJctDEYuhWgb+iPw$cHWGWqUkTTpLC/q5b5k3jCxQNx1ZCwTMWsHEPEKrsU8',1),(30,'aaaaa@utez.edu.mx','Fernando','Paz','Sanchez','$argon2i$v=19$m=65536,t=2,p=1$y+JgZZrZh87+NzYn1RVCiA$ShEFg4/GtIArAhGFsjKhvKCvqtNkyPYGipDi4uuU7D8',1),(31,'bbbbb@utez.edu.mx','Astrid Valeria','Ventura','Gil','$argon2i$v=19$m=65536,t=2,p=1$n6JzrYR27x0Yb+HK6g6oYw$4XFfwss0Tpe1VWtuTFO1X87jBLHGG5JrfLTcFeoxr3w',1),(32,'ccccc@utez.edu.mx','Sofia','Higareda','Sanchez','$argon2i$v=19$m=65536,t=2,p=1$cMIUhrJ/aD/xLwNyqIb5Ww$LzQdg5zvqMqxg57jIZ2Obu0GgSVh8+DbolCNyz3vez4',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userrole`
--

DROP TABLE IF EXISTS `userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userrole` (
  `user_id` int NOT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_user_has_role_role1_idx` (`role_id`),
  KEY `fk_user_has_role_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_role_role1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `fk_user_has_role_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userrole`
--

LOCK TABLES `userrole` WRITE;
/*!40000 ALTER TABLE `userrole` DISABLE KEYS */;
INSERT INTO `userrole` VALUES (1,1),(18,1),(22,1),(23,1),(24,1),(25,1),(29,1),(1,2),(24,2),(25,2),(21,3),(30,3),(31,3),(32,3);
/*!40000 ALTER TABLE `userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sisgea_prod'
--

--
-- Dumping routines for database 'sisgea_prod'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetAllSchedules` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `GetAllSchedules`()
BEGIN
    SELECT 
        s.id AS schedule_id,
        s.day,
        s.starttime,
        s.endtime,
        c.id AS class_id,
        c.name AS class_name,
        p.id AS program_id,
        p.name AS program_name,
        c.status AS class_status,
        q.id AS quarter_id,
        q.name AS quarter_name,
        q.startdate AS quarter_startdate,
        q.enddate AS quarter_enddate,
        r.id AS room_id,
        rt.id AS roomtype_id,
        rt.name AS roomtype_name,
        rt.abbreviation AS roomtype_abb,
        b.id AS building_id,
        b.name AS building_name,
        b.abbreviation AS building_abb,
        r.number AS room_number,
        r.status AS room_status,
        g.id AS grade_id,
		g.number AS grade_number,
		gr.id AS group_id,
		gr.name AS group_name
    FROM schedule s
    JOIN class c ON c.id = s.class_id
    JOIN program p ON p.id = c.program_id
    JOIN quarter q ON q.id = s.quarter_id
    JOIN room r ON r.id = s.room_id
    JOIN roomtype rt ON rt.id = r.roomtype_id
    JOIN building b ON b.id = r.building_id
    JOIN grade g ON g.id = c.grade_id
	JOIN schedule_group gr ON gr.id = s.group_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `insert_class`(
    IN p_name VARCHAR(45), 
    IN p_program_id INT, 
    IN p_grade_id INT,
    IN p_status TINYINT	
)
BEGIN
    DECLARE count_rows INT;
    DECLARE rollback_action BOOL DEFAULT 0;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Verificar si ya existe una combinación de nombre de clase y program_id
    SELECT COUNT(*) INTO count_rows
    FROM class
    WHERE name = p_name
      AND program_id = p_program_id;

    -- Si count_rows es mayor que 0, hacer rollback y enviar un mensaje de error
    IF count_rows > 0 THEN
        SET rollback_action = 1;  -- Marcar para hacer rollback
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'repeated';
    ELSE
        -- Insertar el nuevo registro
        INSERT INTO class(name, program_id, grade_id, status)
        VALUES(p_name, p_program_id, p_grade_id,p_status);
    END IF;

    -- Comprobar si se debe hacer rollback o commit
    IF rollback_action THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_reserve` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `insert_reserve`(
	IN p_user_id INT,
    IN p_room_id INT, 
    IN p_description VARCHAR(45), 
    IN p_date DATE,
    IN p_starttime TIME, 
    IN p_endtime TIME,
    IN p_status ENUM('Active', 'Canceled', 'Admin_Canceled')
)
BEGIN 
	DECLARE v_count_same_reserve INT;
    DECLARE V_count_time_overlap INT;
    DECLARE continue_insert BOOLEAN DEFAULT TRUE; 
    
    START TRANSACTION; 
    
    -- Verificar si ya existe una reserva con los mismos datos exactos Y ESTA ESTÁ ACTIVA
    SELECT COUNT(*) INTO v_count_same_reserve
    FROM reserve
    WHERE room_id = p_room_id
	  AND date = p_date
      AND starttime = p_starttime
      AND endtime = p_endtime
      AND status = 1;
      
	SELECT COUNT(*) INTO v_count_time_overlap
    FROM reserve
    WHERE room_id = p_room_id
       AND date = p_date
       AND status = 1
       AND (
          (p_starttime >= starttime AND p_starttime < endtime) OR
          (p_endtime > starttime AND p_endtime <= endtime) OR
          (p_starttime <= starttime AND p_endtime >= endtime)
      );
      
      -- Si se encuetra un registro idéntico, arrojar un error
      IF v_count_same_reserve > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'repeated';
		SET continue_insert = FALSE;
	  END IF;
      
      -- Si se encuentra un traslpa de horario, lanzar un error
      IF v_count_time_overlap > 0 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'conflict';
        SET continue_insert = FALSE;
      END IF;
      
      -- Insertar la nueva reserva si no hay conflictos ni duplicados
      IF continue_insert THEN 
		INSERT INTO reserve (user_id,room_id,description,date,starttime,endtime,status)
        VALUES (p_user_id,p_room_id,p_description,p_date,p_starttime,p_endtime,p_status);
        COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_room` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `insert_room`(
    IN p_roomtype_id INT, 
    IN p_building_id INT, 
    IN p_number INT, 
    IN p_status INT
)
BEGIN
    DECLARE count_rows INT;
    DECLARE rollback_action BOOL DEFAULT 0;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Verificar si el número ya existe para la combinación de roomtype_id y building_id
    SELECT COUNT(*) INTO count_rows
    FROM room
    WHERE roomtype_id = p_roomtype_id
      AND building_id = p_building_id
      AND number = p_number;

    -- Si count_rows es mayor que 0, hacer rollback y enviar un mensaje de error
    IF count_rows > 0 THEN
        SET rollback_action = 1;  -- Marcar para hacer rollback
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A record with the same number already exists for this roomtype_id and building_id';
    ELSE
        -- Insertar el nuevo registro
        INSERT INTO room(roomtype_id, building_id, number, status)
        VALUES(p_roomtype_id, p_building_id, p_number, p_status);
    END IF;

    -- Comprobar si se debe hacer rollback o commit
    IF rollback_action THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_schedule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `insert_schedule`(
    IN p_class_id INT,
    IN p_quarter_id INT,
    IN p_room_id INT,
    IN p_day ENUM('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'),
    IN p_starttime TIME,
    IN p_endtime TIME,
    IN p_group_id INT
)
BEGIN
    DECLARE v_count_same_class INT;
    DECLARE v_count_time_overlap INT;
    DECLARE continue_insert BOOLEAN DEFAULT TRUE;

    START TRANSACTION;
    
    -- Verificar si ya existe una registro con los mismos datos exactos
    SELECT COUNT(*) INTO v_count_same_class
    FROM schedule
    WHERE class_id = p_class_id
      AND quarter_id = p_quarter_id
      AND room_id = p_room_id
      AND day = p_day
      AND starttime = p_starttime
      AND endtime = p_endtime
      AND group_id = p_group_id;

    -- Verificar si hay traslape de horarios en el mismo cuatri, aula y día
    SELECT COUNT(*) INTO v_count_time_overlap
    FROM schedule
    WHERE quarter_id = p_quarter_id
      AND room_id = p_room_id
      AND day = p_day
      AND (
          (p_starttime >= starttime AND p_starttime < endtime) OR
          (p_endtime > starttime AND p_endtime <= endtime) OR
          (p_starttime <= starttime AND p_endtime >= endtime)
      );

    -- Si se encuentra un registro idéntico, lanzar un error
    IF v_count_same_class > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'repeated';
        SET continue_insert = FALSE;
    END IF;

    -- Si se encuentra un traslape de horario, lanzar un error
    IF v_count_time_overlap > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'conflict';
        SET continue_insert = FALSE;
    END IF;

    -- Insertar la nueva clase si no hay conflictos ni duplicados
    IF continue_insert THEN
        INSERT INTO schedule (class_id, quarter_id, room_id, day, starttime, endtime, group_id)
        VALUES (p_class_id, p_quarter_id, p_room_id, p_day, p_starttime, p_endtime, p_group_id);
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `update_class`(
    IN p_name VARCHAR(45), 
    IN p_program_id INT,
    IN p_grade_id INT,
	IN p_id INT
)
BEGIN
    DECLARE name_exists INT;
    DECLARE rollback_action BOOL DEFAULT 0;

    START TRANSACTION;

    SELECT COUNT(*) INTO name_exists
    FROM class
    WHERE name = p_name
      AND program_id = p_program_id
      AND id != p_id;
      
    IF name_exists > 0 THEN
        SET rollback_action = 1;  
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'repeated';
    ELSE
        -- Actualizar el registro
        UPDATE class
        SET name = p_name, program_id = p_program_id, grade_id = p_grade_id
        WHERE id = p_id;
    END IF;

    IF rollback_action THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_reserve` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `update_reserve`(
    IN p_room_id INT, 
    IN p_description VARCHAR(45), 
    IN p_date DATE,
    IN p_starttime TIME, 
    IN p_endtime TIME,
    IN p_id INT
)
BEGIN 
	DECLARE v_count_same_reserve INT;
    DECLARE V_count_time_overlap INT;
    DECLARE continue_insert BOOLEAN DEFAULT TRUE; 
    
    START TRANSACTION; 
    
    -- Verificar si ya existe una reserva con los mismos datos exactos Y ESTA ESTÁ ACTIVA
    SELECT COUNT(*) INTO v_count_same_reserve
    FROM reserve
    WHERE room_id = p_room_id
	  AND date = p_date
      AND starttime = p_starttime
      AND endtime = p_endtime
      AND status = 1
      AND id != p_id;
      
	SELECT COUNT(*) INTO v_count_time_overlap
    FROM reserve
    WHERE room_id = p_room_id
       AND date = p_date
       AND status = 1
       AND id != p_id
       AND (
          (p_starttime >= starttime AND p_starttime < endtime) OR
          (p_endtime > starttime AND p_endtime <= endtime) OR
          (p_starttime <= starttime AND p_endtime >= endtime)
      );
      
      -- Si se encuetra un registro idéntico, arrojar un error
      IF v_count_same_reserve > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'repeated';
		SET continue_insert = FALSE;
	  END IF;
      
      -- Si se encuentra un traslpa de horario, lanzar un error
      IF v_count_time_overlap > 0 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'conflict';
        SET continue_insert = FALSE;
      END IF;
      
      -- Insertar la nueva reserva si no hay conflictos ni duplicados
      IF continue_insert THEN 
		UPDATE reserve 
        SET room_id = p_room_id,
			description = p_description,
            date = p_date,
            starttime = p_starttime,
            endtime = p_endtime
		WHERE p_id = id;
        COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_reserve_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `update_reserve_status`(
    IN p_id INT, 
    IN p_status ENUM('Active', 'Canceled', 'Admin_Canceled')
)
BEGIN 
    DECLARE v_room_id INT;
    DECLARE v_date DATE;
    DECLARE v_starttime TIME;
    DECLARE v_endtime TIME;
    DECLARE v_count_same_reserve INT;
    DECLARE v_count_time_overlap INT;
    DECLARE continue_update BOOLEAN DEFAULT TRUE; 

    START TRANSACTION;

    -- Obtener los detalles de la reserva actual
    SELECT room_id, date, starttime, endtime INTO v_room_id, v_date, v_starttime, v_endtime
    FROM reserve
    WHERE id = p_id;

    -- Solo realizar verificaciones si el nuevo status es 'active'+
    IF p_status = 1 THEN
        -- Verificar si ya existe una reserva con los mismos datos exactos y está activa
        SELECT COUNT(*) INTO v_count_same_reserve
        FROM reserve
        WHERE room_id = v_room_id
            AND date = v_date
            AND starttime = v_starttime
            AND endtime = v_endtime
            AND status = 1
            AND id != p_id;

        -- Verificar si hay traslape de horario con otras reservas activas
        SELECT COUNT(*) INTO v_count_time_overlap
        FROM reserve
        WHERE room_id = v_room_id
            AND date = v_date
            AND status = 1
            AND id != p_id
            AND (
                (v_starttime >= starttime AND v_starttime < endtime) OR
                (v_endtime > starttime AND v_endtime <= endtime) OR
                (v_starttime <= starttime AND v_endtime >= endtime)
            );

        -- Si se encuentra un registro idéntico, arrojar un error
        IF v_count_same_reserve > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'repeated';
            SET continue_update = FALSE;
        END IF;

        -- Si se encuentra un traslape de horario, lanzar un error
        IF v_count_time_overlap > 0 THEN 
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'conflict';
            SET continue_update = FALSE;
        END IF;
    END IF;

    -- Actualizar el status de la reserva si no hay conflictos
    IF continue_update THEN 
        UPDATE reserve 
        SET status = p_status
        WHERE id = p_id;
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_room` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `update_room`(
    IN p_roomtype_id INT, 
    IN p_building_id INT, 
    IN p_number INT, 
    IN p_room_id INT 
)
BEGIN
    DECLARE count_rows INT;
    DECLARE rollback_action BOOL DEFAULT 0;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Verificar si el número ya existe para la combinación de roomtype_id y building_id
    SELECT COUNT(*) INTO count_rows
    FROM room
    WHERE roomtype_id = p_roomtype_id
      AND building_id = p_building_id
      AND number = p_number
      AND p_room_id != room_id;

    -- Si count_rows es mayor que 0, hacer rollback y enviar un mensaje de error
    IF count_rows > 0 THEN
        SET rollback_action = 1;  -- Marcar para hacer rollback
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Repeated record';
    ELSE
        -- Actualizar el registro
        UPDATE room
        SET roomtype_id = p_roomtype_id, 
            building_id = p_building_id, 
            number = p_number
        WHERE id = p_room_id;
    END IF;

    -- Comprobar si se debe hacer rollback o commit
    IF rollback_action THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_schedule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `update_schedule`(
    IN p_schedule_id INT,
    IN p_class_id INT,
    IN p_quarter_id INT,
    IN p_room_id INT,
    IN p_day ENUM('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'),
    IN p_starttime TIME,
    IN p_endtime TIME,
    IN p_group_id INT
)
BEGIN
    DECLARE v_count_same_class INT;
    DECLARE v_count_time_overlap INT;
    DECLARE continue_update BOOLEAN DEFAULT TRUE;

    START TRANSACTION;
    
    -- Verificar si ya existe un registro con los mismos datos exactos
    SELECT COUNT(*) INTO v_count_same_class
    FROM schedule
    WHERE class_id = p_class_id
      AND quarter_id = p_quarter_id
      AND room_id = p_room_id
      AND day = p_day
      AND starttime = p_starttime
      AND endtime = p_endtime
      AND group_id = p_group_id;

    -- Verificar si hay traslape de horarios en el mismo cuatri, aula y día
    SELECT COUNT(*) INTO v_count_time_overlap
    FROM schedule
    WHERE quarter_id = p_quarter_id
      AND room_id = p_room_id
      AND day = p_day
      AND id != p_schedule_id
      AND (
          (p_starttime >= starttime AND p_starttime < endtime) OR
          (p_endtime > starttime AND p_endtime <= endtime) OR
          (p_starttime <= starttime AND p_endtime >= endtime)
      );

    -- Si se encuentra un registro idéntico, lanzar un error
    IF v_count_same_class > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'repeated';
        SET continue_update = FALSE;
    END IF;

    -- Si se encuentra un traslape de horario, lanzar un error
    IF v_count_time_overlap > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'conflict';
        SET continue_update = FALSE;
    END IF;

    -- Actualizar la clase si no hay conflictos ni duplicados
    IF continue_update THEN
        UPDATE schedule
        SET class_id = p_class_id,
            quarter_id = p_quarter_id,
            room_id = p_room_id,
            day = p_day,
            starttime = p_starttime,
            endtime = p_endtime,
            group_id = p_group_id
        WHERE id = p_schedule_id;
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-19  1:00:59
