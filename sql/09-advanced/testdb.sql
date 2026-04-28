CREATE DATABASE  IF NOT EXISTS `testdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `testdb`;
-- MySQL dump 10.13  Distrib 8.0.45, for macos15 (arm64)
--
-- Host: localhost    Database: testdb
-- ------------------------------------------------------
-- Server version	8.0.45

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

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `departmentId` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `manager_email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`departmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Human Resources',NULL),(2,'Engineering',NULL),(3,'Sales',NULL),(4,'Finance',NULL);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employeeId` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `departmentId` int DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `emp_status` varchar(30) DEFAULT 'Active',
  `job_title` varchar(100) NOT NULL DEFAULT 'Employee',
  PRIMARY KEY (`employeeId`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_department` (`departmentId`),
  KEY `idx_employee_salary` (`salary`),
  CONSTRAINT `fk_department` FOREIGN KEY (`departmentId`) REFERENCES `department` (`departmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'John','Doe','john.doe@example.com',51000.00,1,NULL,NULL,NULL,NULL,'Employee'),(2,'Jane','Smith','jane.smith@example.com',65000.00,2,NULL,NULL,NULL,NULL,'Employee'),(3,'Robert','Johnson','robert.johnson@example.com',55000.00,3,NULL,NULL,NULL,NULL,'Employee'),(4,'Emily','Brown','emily.brown@example.com',60000.00,4,NULL,NULL,NULL,NULL,'Employee'),(5,'Michael','Williams','michael.williams@example.com',52000.00,1,NULL,NULL,NULL,'Active','Employee'),(6,'Sarah','Jones','sarah.jones@example.com',58000.00,1,NULL,NULL,NULL,'Active','Employee'),(7,'David','Miller','david.miller@example.com',55000.00,1,NULL,NULL,NULL,'Active','Employee'),(8,'Lisa','Davis','lisa.davis@example.com',60000.00,1,NULL,NULL,NULL,'Active','Employee'),(9,'James','Garcia','james.garcia@example.com',54000.00,1,NULL,NULL,NULL,'Active','Employee'),(10,'Jennifer','Rodriguez','jennifer.rodriguez@example.com',62000.00,1,NULL,NULL,NULL,'Active','Employee'),(11,'Christopher','Martinez','christopher.martinez@example.com',57000.00,1,NULL,NULL,NULL,'Active','Employee'),(12,'Amanda','Hernandez','amanda.hernandez@example.com',64000.00,1,NULL,NULL,NULL,'Active','Employee'),(13,'Daniel','Lopez','daniel.lopez@example.com',59000.00,1,NULL,NULL,NULL,'Active','Employee'),(14,'Andrew','Gonzalez','andrew.gonzalez@example.com',95000.00,2,NULL,NULL,NULL,'Active','Employee'),(15,'Michelle','Wilson','michelle.wilson@example.com',92000.00,2,NULL,NULL,NULL,'Active','Employee'),(16,'Ryan','Anderson','ryan.anderson@example.com',88000.00,2,NULL,NULL,NULL,'Active','Employee'),(17,'Christina','Thomas','christina.thomas@example.com',90000.00,2,NULL,NULL,NULL,'Active','Employee'),(18,'Brandon','Taylor','brandon.taylor@example.com',75000.00,2,NULL,NULL,NULL,'Active','Employee'),(19,'Jessica','Moore','jessica.moore@example.com',78000.00,2,NULL,NULL,NULL,'Active','Employee'),(20,'Kevin','Jackson','kevin.jackson@example.com',72000.00,2,NULL,NULL,NULL,'Active','Employee'),(21,'Stephanie','White','stephanie.white@example.com',76000.00,2,NULL,NULL,NULL,'Active','Employee'),(22,'Justin','Harris','justin.harris@example.com',74000.00,2,NULL,NULL,NULL,'Active','Employee'),(23,'Lauren','Martin','lauren.martin@example.com',65000.00,2,NULL,NULL,NULL,'Active','Employee'),(24,'Eric','Thompson','eric.thompson@example.com',63000.00,2,NULL,NULL,NULL,'Active','Employee'),(25,'Megan','Garcia','megan.garcia@example.com',66000.00,2,NULL,NULL,NULL,'Active','Employee'),(26,'Nathan','Black','nathan.black@example.com',62000.00,2,NULL,NULL,NULL,'Active','Employee'),(27,'Ashley','Perez','ashley.perez@example.com',64000.00,2,NULL,NULL,NULL,'Active','Employee'),(28,'Benjamin','Green','benjamin.green@example.com',120000.00,2,NULL,NULL,NULL,'Active','Employee'),(29,'Mark','Adams','mark.adams@example.com',75000.00,3,NULL,NULL,NULL,'Active','Employee'),(30,'Susan','Nelson','susan.nelson@example.com',78000.00,3,NULL,NULL,NULL,'Active','Employee'),(31,'Paul','Carter','paul.carter@example.com',72000.00,3,NULL,NULL,NULL,'Active','Employee'),(32,'Karen','Roberts','karen.roberts@example.com',65000.00,3,NULL,NULL,NULL,'Active','Employee'),(33,'Brian','Phillips','brian.phillips@example.com',68000.00,3,NULL,NULL,NULL,'Active','Employee'),(34,'Nancy','Evans','nancy.evans@example.com',62000.00,3,NULL,NULL,NULL,'Active','Employee'),(35,'Joseph','Edwards','joseph.edwards@example.com',55000.00,3,NULL,NULL,NULL,'Active','Employee'),(36,'Susan','Collins','susan.collins@example.com',58000.00,3,NULL,NULL,NULL,'Active','Employee'),(37,'Charles','Stewart','charles.stewart@example.com',56000.00,3,NULL,NULL,NULL,'Active','Employee'),(38,'Lisa','Sanchez','lisa.sanchez@example.com',60000.00,3,NULL,NULL,NULL,'Active','Employee'),(39,'Donald','Morris','donald.morris@example.com',90000.00,3,NULL,NULL,NULL,'Active','Employee'),(40,'Angela','Rogers','angela.rogers@example.com',85000.00,3,NULL,NULL,NULL,'Active','Employee'),(41,'Thomas','Reed','thomas.reed@example.com',85000.00,4,NULL,NULL,NULL,'Active','Employee'),(42,'Sandra','Cook','sandra.cook@example.com',87000.00,4,NULL,NULL,NULL,'Active','Employee'),(43,'Matthew','Morgan','matthew.morgan@example.com',82000.00,4,NULL,NULL,NULL,'Active','Employee'),(44,'Brenda','Bell','brenda.bell@example.com',68000.00,4,NULL,NULL,NULL,'Active','Employee'),(45,'Steven','Murphy','steven.murphy@example.com',70000.00,4,NULL,NULL,NULL,'Active','Employee'),(46,'Dorothy','Bailey','dorothy.bailey@example.com',66000.00,4,NULL,NULL,NULL,'Active','Employee'),(47,'Paul','Rivera','paul.rivera@example.com',72000.00,4,NULL,NULL,NULL,'Active','Employee'),(48,'Frances','Cooper','frances.cooper@example.com',65000.00,4,NULL,NULL,NULL,'Active','Employee'),(49,'Andrew','Richardson','andrew.richardson@example.com',100000.00,4,NULL,NULL,NULL,'Active','Employee'),(50,'Kathryn','Cox','kathryn.cox@example.com',95000.00,4,NULL,NULL,NULL,'Active','Employee');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_uk`
--

DROP TABLE IF EXISTS `employee_uk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_uk` (
  `employeeId` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  PRIMARY KEY (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_uk`
--

LOCK TABLES `employee_uk` WRITE;
/*!40000 ALTER TABLE `employee_uk` DISABLE KEYS */;
INSERT INTO `employee_uk` VALUES (1,'John','Smith','john.smith@uk.company.com',72000.00,'Sales','2025-01-15'),(2,'Sarah','Johnson','sarah.johnson@uk.company.com',82000.00,'Engineering','2025-02-10'),(11,'James','Wilson','james.wilson@uk.company.com',85000.00,'Sales','2025-03-20'),(12,'Emma','White','emma.white@uk.company.com',79000.00,'Engineering','2025-04-25'),(13,'Oliver','Harris','oliver.harris@uk.company.com',88000.00,'Finance','2025-05-15'),(14,'Sophia','Clark','sophia.clark@uk.company.com',81000.00,'HR','2025-06-10'),(15,'Benjamin','Lewis','benjamin.lewis@uk.company.com',86000.00,'Sales','2025-07-22'),(16,'Isabella','Walker','isabella.walker@uk.company.com',93000.00,'Engineering','2025-08-30'),(17,'Lucas','Hall','lucas.hall@uk.company.com',77000.00,'Finance','2026-01-12'),(18,'Amelia','Young','amelia.young@uk.company.com',83000.00,'HR','2026-02-05');
/*!40000 ALTER TABLE `employee_uk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_us`
--

DROP TABLE IF EXISTS `employee_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_us` (
  `employeeId` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  PRIMARY KEY (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_us`
--

LOCK TABLES `employee_us` WRITE;
/*!40000 ALTER TABLE `employee_us` DISABLE KEYS */;
INSERT INTO `employee_us` VALUES (1,'John','Smith','john.smith@us.company.com',75000.00,'Sales','2025-01-15'),(2,'Sarah','Johnson','sarah.johnson@us.company.com',85000.00,'Engineering','2025-02-10'),(3,'Michael','Brown','michael.brown@us.company.com',95000.00,'Sales','2025-03-05'),(4,'Emily','Davis','emily.davis@us.company.com',78000.00,'HR','2025-04-12'),(5,'Robert','Wilson','robert.wilson@us.company.com',88000.00,'Engineering','2025-05-18'),(6,'Jennifer','Martinez','jennifer.martinez@us.company.com',82000.00,'Finance','2025-06-22'),(7,'David','Garcia','david.garcia@us.company.com',79000.00,'Sales','2025-07-30'),(8,'Lisa','Anderson','lisa.anderson@us.company.com',91000.00,'Engineering','2026-01-08'),(9,'James','Taylor','james.taylor@us.company.com',76000.00,'Finance','2026-01-20'),(10,'Patricia','Thomas','patricia.thomas@us.company.com',84000.00,'HR','2026-02-14');
/*!40000 ALTER TABLE `employee_us` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `projectId` int NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  `departmentId` int NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`projectId`),
  UNIQUE KEY `project_name` (`project_name`),
  KEY `fk_project_department` (`departmentId`),
  CONSTRAINT `fk_project_department` FOREIGN KEY (`departmentId`) REFERENCES `department` (`departmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'HR Management System','Build internal HR management system for employee records and payroll','2025-01-15','2025-06-30',150000.00,1,'Active'),(2,'Mobile App Development','Develop cross-platform mobile application for customer engagement','2025-02-01','2025-08-31',300000.00,2,'Active'),(3,'Data Analytics Platform','Create data analytics platform for business intelligence','2025-03-10','2025-09-30',250000.00,2,'Active'),(4,'Sales Dashboard','Build real-time sales tracking and reporting dashboard','2025-03-01','2025-05-31',100000.00,3,'On Hold'),(5,'Financial Audit System','Implement automated financial audit and compliance checking system','2025-04-01','2025-10-31',200000.00,4,'Active'),(6,'Customer Portal','Develop web portal for customer self-service and order tracking','2025-05-01','2025-09-30',180000.00,3,'Completed'),(7,'Employee Training Platform','Develop online training and certification platform for employee development','2025-04-15','2025-09-30',175000.00,1,'Active'),(8,'Payroll System Upgrade','Upgrade existing payroll system with new compliance features','2025-05-01','2025-08-31',120000.00,1,'Active'),(9,'Performance Management System','Build comprehensive performance review and feedback system','2025-06-01','2025-11-30',145000.00,1,'Planned'),(10,'Cloud Migration Initiative','Migrate on-premises infrastructure to AWS cloud platform','2025-03-15','2025-10-31',400000.00,2,'Active'),(11,'API Gateway Development','Build microservices API gateway for internal and external integrations','2025-04-01','2025-08-15',220000.00,2,'Active'),(12,'Database Optimization Project','Optimize database performance and implement sharding strategy','2025-05-15','2025-09-15',180000.00,2,'Active'),(13,'DevOps Infrastructure','Implement CI/CD pipeline and containerization with Docker/Kubernetes','2025-04-20','2025-09-20',250000.00,2,'On Hold'),(14,'Mobile App Version 2.0','Major release with new features and UI redesign','2025-06-01','2025-12-31',350000.00,2,'Planned'),(15,'AI/ML Integration Engine','Integrate machine learning models for predictive analytics','2025-07-01','2026-01-31',500000.00,2,'Planned'),(16,'CRM System Overhaul','Complete redesign and upgrade of CRM system with new modules','2025-04-01','2025-10-30',280000.00,3,'Active'),(17,'Sales Forecasting System','Implement predictive sales forecasting with historical analytics','2025-05-15','2025-10-15',160000.00,3,'Active'),(18,'Customer Loyalty Program','Design and implement tiered customer loyalty rewards program','2025-06-01','2025-11-30',95000.00,3,'Planned'),(19,'Budget Planning Tool','Develop automated budget planning and forecasting tool','2025-07-01','2026-01-31',210000.00,4,'Planned'),(20,'Tax Compliance Automation','Automate tax compliance checking and reporting processes','2025-08-01','2026-02-28',185000.00,4,'Planned');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_assignment`
--

DROP TABLE IF EXISTS `project_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_assignment` (
  `assignment_id` int NOT NULL,
  `employeeId` int NOT NULL,
  `projectId` int NOT NULL,
  `role` varchar(100) DEFAULT NULL,
  `allocation_percentage` decimal(5,2) DEFAULT NULL,
  `assignment_date` date DEFAULT NULL,
  PRIMARY KEY (`assignment_id`),
  UNIQUE KEY `unique_assignment` (`employeeId`,`projectId`),
  KEY `fk_assignment_project` (`projectId`),
  CONSTRAINT `fk_assignment_employee` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`employeeId`),
  CONSTRAINT `fk_assignment_project` FOREIGN KEY (`projectId`) REFERENCES `project` (`projectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_assignment`
--

LOCK TABLES `project_assignment` WRITE;
/*!40000 ALTER TABLE `project_assignment` DISABLE KEYS */;
INSERT INTO `project_assignment` VALUES (1,1,1,'Project Manager',100.00,'2025-01-15'),(2,2,2,'Lead Developer',100.00,'2025-02-01'),(3,2,3,'Architect',50.00,'2025-03-10'),(4,3,4,'Business Analyst',100.00,'2025-03-01'),(5,3,6,'Project Coordinator',50.00,'2025-05-01'),(6,4,1,'Finance Consultant',30.00,'2025-01-15'),(7,4,5,'Audit Lead',100.00,'2025-04-01'),(8,5,7,'Project Manager',100.00,'2025-04-15'),(9,8,7,'Content Designer',80.00,'2025-04-15'),(10,11,7,'Quality Assurance',60.00,'2025-04-20'),(11,6,8,'Project Lead',100.00,'2025-05-01'),(12,9,8,'Technical Specialist',100.00,'2025-05-01'),(13,12,8,'Compliance Officer',70.00,'2025-05-05'),(14,10,9,'Project Manager',100.00,'2025-06-01'),(15,7,9,'Business Analyst',80.00,'2025-06-01'),(16,14,10,'Cloud Architect',100.00,'2025-03-15'),(17,15,10,'Senior DevOps Engineer',100.00,'2025-03-15'),(18,20,10,'Infrastructure Specialist',100.00,'2025-03-20'),(19,24,10,'Junior Engineer',50.00,'2025-04-01'),(20,16,11,'Lead Developer',100.00,'2025-04-01'),(21,19,11,'Backend Engineer',100.00,'2025-04-01'),(22,25,11,'Junior Developer',80.00,'2025-04-05'),(23,17,12,'Database Architect',100.00,'2025-05-15'),(24,21,12,'Database Administrator',100.00,'2025-05-15'),(25,26,12,'Performance Analyst',75.00,'2025-05-20'),(26,18,13,'DevOps Lead',100.00,'2025-04-20'),(27,22,13,'Platform Engineer',100.00,'2025-04-20'),(28,27,13,'Junior DevOps Engineer',60.00,'2025-05-01'),(29,23,14,'Mobile App Lead',100.00,'2025-06-01'),(30,28,14,'Senior Mobile Developer',100.00,'2025-06-01'),(31,15,15,'ML Engineer Lead',100.00,'2025-07-01'),(32,18,15,'Data Scientist',80.00,'2025-07-01'),(33,29,16,'Project Manager',100.00,'2025-04-01'),(34,32,16,'Business Analyst',100.00,'2025-04-01'),(35,35,16,'Sales Consultant',60.00,'2025-04-05'),(36,30,17,'Project Lead',100.00,'2025-05-15'),(37,33,17,'Data Analyst',100.00,'2025-05-15'),(38,38,17,'Technical Writer',50.00,'2025-05-20'),(39,31,18,'Program Manager',100.00,'2025-06-01'),(40,36,18,'Coordinator',80.00,'2025-06-01');
/*!40000 ALTER TABLE `project_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_active_employees`
--

DROP TABLE IF EXISTS `v_active_employees`;
/*!50001 DROP VIEW IF EXISTS `v_active_employees`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_active_employees` AS SELECT 
 1 AS `employeeId`,
 1 AS `full_name`,
 1 AS `email`,
 1 AS `salary`,
 1 AS `departmentId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_employee_list`
--

DROP TABLE IF EXISTS `v_employee_list`;
/*!50001 DROP VIEW IF EXISTS `v_employee_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_employee_list` AS SELECT 
 1 AS `employeeId`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_active_employees`
--

/*!50001 DROP VIEW IF EXISTS `v_active_employees`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_active_employees` AS select `employee`.`employeeId` AS `employeeId`,concat(`employee`.`first_name`,' ',`employee`.`last_name`) AS `full_name`,`employee`.`email` AS `email`,`employee`.`salary` AS `salary`,`employee`.`departmentId` AS `departmentId` from `employee` where (`employee`.`salary` > 0) order by concat(`employee`.`first_name`,' ',`employee`.`last_name`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_employee_list`
--

/*!50001 DROP VIEW IF EXISTS `v_employee_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_employee_list` AS select `employee`.`employeeId` AS `employeeId`,`employee`.`first_name` AS `first_name`,`employee`.`last_name` AS `last_name`,`employee`.`email` AS `email` from `employee` order by `employee`.`employeeId` */;
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

-- Dump completed on 2026-04-28 10:44:24
