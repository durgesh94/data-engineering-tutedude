CREATE DATABASE  IF NOT EXISTS `emp_performance_payroll_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `emp_performance_payroll_db`;
-- MySQL dump 10.13  Distrib 8.0.45, for macos15 (arm64)
--
-- Host: localhost    Database: emp_performance_payroll_db
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
  `departmentId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`departmentId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Master table storing department information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Sales','New York','2026-04-28 05:33:13'),(2,'Engineering','San Francisco','2026-04-28 05:33:13'),(3,'HR','Chicago','2026-04-28 05:33:13'),(4,'Finance','Boston','2026-04-28 05:33:13'),(5,'Operations','Dallas','2026-04-28 05:33:13');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employeeId` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `base_salary` decimal(10,2) NOT NULL,
  `hire_date` date NOT NULL,
  `departmentId` int NOT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`employeeId`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_department` (`departmentId`),
  KEY `idx_email` (`email`),
  KEY `idx_salary` (`base_salary`),
  KEY `idx_employee_salary_dept` (`departmentId`,`base_salary`),
  CONSTRAINT `fk_employee_dept` FOREIGN KEY (`departmentId`) REFERENCES `department` (`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Stores employee information and base salary';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'John','Smith','john.smith@company.com',75000.00,'2022-01-15',2,'Active','2026-04-28 05:33:19'),(2,'Sarah','Johnson','sarah.johnson@company.com',65000.00,'2021-06-20',1,'Active','2026-04-28 05:33:19'),(3,'Michael','Williams','michael.williams@company.com',85000.00,'2020-03-10',2,'Active','2026-04-28 05:33:19'),(4,'Emily','Brown','emily.brown@company.com',55000.00,'2023-02-01',3,'Active','2026-04-28 05:33:19'),(5,'Robert','Davis','robert.davis@company.com',95000.00,'2019-11-05',1,'Active','2026-04-28 05:33:19'),(6,'Jennifer','Miller','jennifer.miller@company.com',70000.00,'2022-05-12',4,'Active','2026-04-28 05:33:19'),(7,'David','Wilson','david.wilson@company.com',60000.00,'2023-01-20',5,'Active','2026-04-28 05:33:19');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `performance`
--

DROP TABLE IF EXISTS `performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `performance` (
  `performanceId` int NOT NULL AUTO_INCREMENT,
  `employeeId` int NOT NULL,
  `review_date` date NOT NULL,
  `review_year` int GENERATED ALWAYS AS (year(`review_date`)) STORED,
  `rating` int NOT NULL,
  `bonus_percentage` decimal(5,2) DEFAULT '0.00',
  `review_notes` varchar(500) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`performanceId`),
  UNIQUE KEY `unique_annual_review` (`employeeId`,`review_year`),
  KEY `idx_employee_review` (`employeeId`,`review_date`),
  KEY `idx_performance_rating` (`rating`),
  KEY `idx_performance_date` (`review_date`),
  KEY `idx_performance_rating_date` (`rating`,`review_date`),
  KEY `idx_performance_date_desc` (`review_date` DESC),
  CONSTRAINT `fk_performance_emp` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`employeeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_bonus` CHECK (((`bonus_percentage` >= 0) and (`bonus_percentage` <= 100))),
  CONSTRAINT `chk_rating` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Stores employee performance ratings and bonus details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `performance`
--

LOCK TABLES `performance` WRITE;
/*!40000 ALTER TABLE `performance` DISABLE KEYS */;
INSERT INTO `performance` (`performanceId`, `employeeId`, `review_date`, `rating`, `bonus_percentage`, `review_notes`, `created_date`) VALUES (1,1,'2025-12-31',5,15.00,'Excellent developer, great team player','2026-04-28 05:33:27'),(2,2,'2025-12-31',4,10.00,'Good sales performance, needs improvement in client relations','2026-04-28 05:33:27'),(3,3,'2025-12-31',5,15.00,'Outstanding technical skills and leadership','2026-04-28 05:33:27'),(4,4,'2025-12-31',3,5.00,'Average performer, room for improvement','2026-04-28 05:33:27'),(5,5,'2025-12-31',4,12.00,'Consistent high performer in sales','2026-04-28 05:33:27'),(6,6,'2025-12-31',3,5.00,'Meets expectations','2026-04-28 05:33:27'),(7,7,'2025-12-31',2,2.00,'Needs improvement in delivery timelines','2026-04-28 05:33:27'),(8,1,'2026-03-15',4,12.00,'Good progress, maintaining excellence','2026-04-28 05:33:27'),(9,2,'2026-03-15',3,8.00,'Struggling with new product line','2026-04-28 05:33:27'),(10,3,'2026-03-15',5,18.00,'Promoted to team lead, excellent mentor','2026-04-28 05:33:27'),(11,5,'2026-03-15',5,15.00,'Best salesman this quarter','2026-04-28 05:33:27');
/*!40000 ALTER TABLE `performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_department_analytics`
--

DROP TABLE IF EXISTS `v_department_analytics`;
/*!50001 DROP VIEW IF EXISTS `v_department_analytics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_department_analytics` AS SELECT 
 1 AS `departmentId`,
 1 AS `department`,
 1 AS `location`,
 1 AS `total_employees`,
 1 AS `total_payroll`,
 1 AS `avg_salary`,
 1 AS `min_salary`,
 1 AS `max_salary`,
 1 AS `avg_performance_rating`,
 1 AS `total_bonus_payout`,
 1 AS `total_compensation`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_employee_payroll_summary`
--

DROP TABLE IF EXISTS `v_employee_payroll_summary`;
/*!50001 DROP VIEW IF EXISTS `v_employee_payroll_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_employee_payroll_summary` AS SELECT 
 1 AS `employeeId`,
 1 AS `employee_name`,
 1 AS `department`,
 1 AS `location`,
 1 AS `base_salary`,
 1 AS `hire_date`,
 1 AS `years_employed`,
 1 AS `last_review_date`,
 1 AS `performance_rating`,
 1 AS `bonus_percentage`,
 1 AS `bonus_amount`,
 1 AS `total_compensation`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_performance_review_report`
--

DROP TABLE IF EXISTS `v_performance_review_report`;
/*!50001 DROP VIEW IF EXISTS `v_performance_review_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_performance_review_report` AS SELECT 
 1 AS `performanceId`,
 1 AS `employeeId`,
 1 AS `employee_name`,
 1 AS `department`,
 1 AS `review_date`,
 1 AS `rating`,
 1 AS `performance_band`,
 1 AS `bonus_percentage`,
 1 AS `review_notes`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_department_analytics`
--

/*!50001 DROP VIEW IF EXISTS `v_department_analytics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_department_analytics` AS select `d`.`departmentId` AS `departmentId`,`d`.`name` AS `department`,`d`.`location` AS `location`,count(`e`.`employeeId`) AS `total_employees`,sum(`e`.`base_salary`) AS `total_payroll`,round(avg(`e`.`base_salary`),2) AS `avg_salary`,min(`e`.`base_salary`) AS `min_salary`,max(`e`.`base_salary`) AS `max_salary`,round(avg(coalesce(`p`.`rating`,0)),2) AS `avg_performance_rating`,sum(round(((`e`.`base_salary` * coalesce(`p`.`bonus_percentage`,0)) / 100),2)) AS `total_bonus_payout`,round(sum((`e`.`base_salary` + ((`e`.`base_salary` * coalesce(`p`.`bonus_percentage`,0)) / 100))),2) AS `total_compensation` from ((`department` `d` left join `employee` `e` on((`d`.`departmentId` = `e`.`departmentId`))) left join `performance` `p` on(((`e`.`employeeId` = `p`.`employeeId`) and (`p`.`review_date` = (select max(`performance`.`review_date`) from `performance` where (`performance`.`employeeId` = `e`.`employeeId`)))))) group by `d`.`departmentId`,`d`.`name`,`d`.`location` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_employee_payroll_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_employee_payroll_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_employee_payroll_summary` AS select `e`.`employeeId` AS `employeeId`,concat(`e`.`first_name`,' ',`e`.`last_name`) AS `employee_name`,`d`.`name` AS `department`,`d`.`location` AS `location`,`e`.`base_salary` AS `base_salary`,`e`.`hire_date` AS `hire_date`,(year(curdate()) - year(`e`.`hire_date`)) AS `years_employed`,coalesce(`p`.`review_date`,'Not Reviewed') AS `last_review_date`,coalesce(`p`.`rating`,0) AS `performance_rating`,coalesce(`p`.`bonus_percentage`,0) AS `bonus_percentage`,round(((`e`.`base_salary` * coalesce(`p`.`bonus_percentage`,0)) / 100),2) AS `bonus_amount`,round((`e`.`base_salary` + ((`e`.`base_salary` * coalesce(`p`.`bonus_percentage`,0)) / 100)),2) AS `total_compensation` from ((`employee` `e` join `department` `d` on((`e`.`departmentId` = `d`.`departmentId`))) left join `performance` `p` on(((`e`.`employeeId` = `p`.`employeeId`) and (`p`.`review_date` = (select max(`performance`.`review_date`) from `performance` where (`performance`.`employeeId` = `e`.`employeeId`)))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_performance_review_report`
--

/*!50001 DROP VIEW IF EXISTS `v_performance_review_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_performance_review_report` AS select `p`.`performanceId` AS `performanceId`,`e`.`employeeId` AS `employeeId`,concat(`e`.`first_name`,' ',`e`.`last_name`) AS `employee_name`,`d`.`name` AS `department`,`p`.`review_date` AS `review_date`,`p`.`rating` AS `rating`,(case when (`p`.`rating` = 5) then 'Excellent' when (`p`.`rating` = 4) then 'Good' when (`p`.`rating` = 3) then 'Average' when (`p`.`rating` = 2) then 'Below Average' when (`p`.`rating` = 1) then 'Needs Improvement' end) AS `performance_band`,`p`.`bonus_percentage` AS `bonus_percentage`,`p`.`review_notes` AS `review_notes` from ((`performance` `p` join `employee` `e` on((`p`.`employeeId` = `e`.`employeeId`))) join `department` `d` on((`e`.`departmentId` = `d`.`departmentId`))) */;
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

-- Dump completed on 2026-04-28 11:10:06
