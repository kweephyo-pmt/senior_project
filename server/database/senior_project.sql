-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: senior_project
-- ------------------------------------------------------
-- Server version	9.3.0
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!50503 SET NAMES utf8 */
;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
--
-- Table structure for table `budget_categories`
--

DROP TABLE IF EXISTS `budget_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `budget_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `total_budget` decimal(10, 2) NOT NULL DEFAULT '0.00',
  `spent_amount` decimal(10, 2) NOT NULL DEFAULT '0.00',
  `year` int NOT NULL DEFAULT '2025',
  `staff_code` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_staff_year` (`staff_code`, `year`)
) ENGINE = InnoDB AUTO_INCREMENT = 61 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `budget_categories`
--

LOCK TABLES `budget_categories` WRITE;
/*!40000 ALTER TABLE `budget_categories` DISABLE KEYS */
;
INSERT INTO `budget_categories`
VALUES (
    1,
    'Self Development',
    '#3B82F6',
    12000.00,
    7200.00,
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    2,
    'Academic Service Project',
    '#EC4899',
    45000.00,
    15300.00,
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    3,
    'Research Project',
    '#8B5CF6',
    20000.00,
    6000.00,
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    4,
    'Guest Speaker',
    '#10B981',
    18000.00,
    2160.00,
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    5,
    'Guest Lecturer',
    '#F59E0B',
    16000.00,
    1920.00,
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    6,
    'Student Activity',
    '#EF4444',
    14000.00,
    1680.00,
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    7,
    'Self Development',
    '#3B82F6',
    11000.00,
    6600.00,
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    8,
    'Academic Service Project',
    '#EC4899',
    40000.00,
    13600.00,
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    9,
    'Research Project',
    '#8B5CF6',
    22000.00,
    6600.00,
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    10,
    'Guest Speaker',
    '#10B981',
    17000.00,
    2040.00,
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    11,
    'Guest Lecturer',
    '#F59E0B',
    15000.00,
    1800.00,
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    12,
    'Student Activity',
    '#EF4444',
    13000.00,
    1560.00,
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    13,
    'Self Development',
    '#3B82F6',
    10500.00,
    6300.00,
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    14,
    'Academic Service Project',
    '#EC4899',
    38000.00,
    12920.00,
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    15,
    'Research Project',
    '#8B5CF6',
    19000.00,
    5700.00,
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    16,
    'Guest Speaker',
    '#10B981',
    16000.00,
    1920.00,
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    17,
    'Guest Lecturer',
    '#F59E0B',
    14500.00,
    1740.00,
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    18,
    'Student Activity',
    '#EF4444',
    12500.00,
    1500.00,
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    19,
    'Self Development',
    '#3B82F6',
    13000.00,
    7800.00,
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    20,
    'Academic Service Project',
    '#EC4899',
    47000.00,
    15980.00,
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    21,
    'Research Project',
    '#8B5CF6',
    21000.00,
    6300.00,
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    22,
    'Guest Speaker',
    '#10B981',
    19000.00,
    2280.00,
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    23,
    'Guest Lecturer',
    '#F59E0B',
    17000.00,
    2040.00,
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    24,
    'Student Activity',
    '#EF4444',
    15000.00,
    1800.00,
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    25,
    'Self Development',
    '#3B82F6',
    9500.00,
    5700.00,
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    26,
    'Academic Service Project',
    '#EC4899',
    35000.00,
    11900.00,
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    27,
    'Research Project',
    '#8B5CF6',
    17000.00,
    5100.00,
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    28,
    'Guest Speaker',
    '#10B981',
    15000.00,
    1800.00,
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    29,
    'Guest Lecturer',
    '#F59E0B',
    13500.00,
    1620.00,
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    30,
    'Student Activity',
    '#EF4444',
    11500.00,
    1380.00,
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    31,
    'Self Development',
    '#3B82F6',
    11500.00,
    6900.00,
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    32,
    'Academic Service Project',
    '#EC4899',
    42000.00,
    14280.00,
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    33,
    'Research Project',
    '#8B5CF6',
    20500.00,
    6150.00,
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    34,
    'Guest Speaker',
    '#10B981',
    17500.00,
    2100.00,
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    35,
    'Guest Lecturer',
    '#F59E0B',
    16000.00,
    1920.00,
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    36,
    'Student Activity',
    '#EF4444',
    14000.00,
    1680.00,
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    37,
    'Self Development',
    '#3B82F6',
    10000.00,
    6400.00,
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    38,
    'Academic Service Project',
    '#EC4899',
    42000.00,
    14112.00,
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    39,
    'Research Project',
    '#8B5CF6',
    18000.00,
    5472.00,
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    40,
    'Guest Speaker',
    '#10B981',
    15000.00,
    1800.00,
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    41,
    'Guest Lecturer',
    '#F59E0B',
    15000.00,
    1800.00,
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    42,
    'Student Activity',
    '#EF4444',
    15000.00,
    1800.00,
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    43,
    'Self Development',
    '#3B82F6',
    12500.00,
    7500.00,
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    44,
    'Academic Service Project',
    '#EC4899',
    44000.00,
    14960.00,
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    45,
    'Research Project',
    '#8B5CF6',
    19500.00,
    5850.00,
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    46,
    'Guest Speaker',
    '#10B981',
    18000.00,
    2160.00,
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    47,
    'Guest Lecturer',
    '#F59E0B',
    16500.00,
    1980.00,
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    48,
    'Student Activity',
    '#EF4444',
    14500.00,
    1740.00,
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    49,
    'Self Development',
    '#3B82F6',
    10800.00,
    6480.00,
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    50,
    'Academic Service Project',
    '#EC4899',
    41000.00,
    13940.00,
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    51,
    'Research Project',
    '#8B5CF6',
    18500.00,
    5550.00,
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    52,
    'Guest Speaker',
    '#10B981',
    16000.00,
    1920.00,
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    53,
    'Guest Lecturer',
    '#F59E0B',
    15500.00,
    1860.00,
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    54,
    'Student Activity',
    '#EF4444',
    13500.00,
    1620.00,
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    55,
    'Self Development',
    '#3B82F6',
    9800.00,
    5880.00,
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    56,
    'Academic Service Project',
    '#EC4899',
    36000.00,
    12240.00,
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    57,
    'Research Project',
    '#8B5CF6',
    17500.00,
    5250.00,
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    58,
    'Guest Speaker',
    '#10B981',
    15500.00,
    1860.00,
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    59,
    'Guest Lecturer',
    '#F59E0B',
    14000.00,
    1680.00,
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    60,
    'Student Activity',
    '#EF4444',
    12000.00,
    1440.00,
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  );
/*!40000 ALTER TABLE `budget_categories` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `budget_projects`
--

DROP TABLE IF EXISTS `budget_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `budget_projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `category_id` int NOT NULL,
  `budget_amount` decimal(10, 2) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `year` int NOT NULL DEFAULT '2025',
  `staff_code` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `idx_staff_year` (`staff_code`, `year`),
  CONSTRAINT `budget_projects_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `budget_categories` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 33 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `budget_projects`
--

LOCK TABLES `budget_projects` WRITE;
/*!40000 ALTER TABLE `budget_projects` DISABLE KEYS */
;
INSERT INTO `budget_projects`
VALUES (
    1,
    'Professional Development Workshop',
    1,
    7200.00,
    '3 Month',
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    2,
    'Community Service Initiative',
    2,
    15300.00,
    '12 Month',
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    3,
    'AI Research Project',
    3,
    6000.00,
    '6 Month',
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    4,
    'Guest Speaker Series',
    4,
    2160.00,
    '2 Month',
    2025,
    '6431703502',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    5,
    'Leadership Training Program',
    7,
    6600.00,
    '4 Month',
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    6,
    'Academic Conference Organization',
    8,
    13600.00,
    '8 Month',
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    7,
    'Marketing Research Study',
    9,
    6600.00,
    '5 Month',
    2025,
    '6531503017',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    8,
    'Digital Skills Workshop',
    13,
    6300.00,
    '3 Month',
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    9,
    'Student Mentorship Program',
    14,
    12920.00,
    '10 Month',
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    10,
    'Business Analytics Project',
    15,
    5700.00,
    '4 Month',
    2025,
    '6531503069',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    11,
    'Advanced Excel Training',
    19,
    7800.00,
    '2 Month',
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    12,
    'Quality Assurance Initiative',
    20,
    15980.00,
    '12 Month',
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    13,
    'Supply Chain Research',
    21,
    6300.00,
    '6 Month',
    2025,
    '6531503070',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    14,
    'Teaching Methodology Workshop',
    25,
    5700.00,
    '3 Month',
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    15,
    'Student Activity Coordination',
    26,
    11900.00,
    '9 Month',
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    16,
    'Economics Research Project',
    27,
    5100.00,
    '5 Month',
    2025,
    '6531503074',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    17,
    'Research Methodology Training',
    31,
    6900.00,
    '4 Month',
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    18,
    'Academic Service Committee',
    32,
    14280.00,
    '12 Month',
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    19,
    'Finance Research Study',
    33,
    6150.00,
    '6 Month',
    2025,
    '6531503137',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    20,
    'Professional Development Workshop',
    37,
    6400.00,
    '3 Month',
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    21,
    'Community Service Initiative',
    38,
    14112.00,
    '12 Month',
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    22,
    'SoM Project',
    39,
    5472.00,
    '6 Month',
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    23,
    'Guest Speaker 130S305',
    40,
    1800.00,
    '2 Month',
    2025,
    '6531503172',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    24,
    'Curriculum Development',
    43,
    7500.00,
    '5 Month',
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    25,
    'International Conference',
    44,
    14960.00,
    '8 Month',
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    26,
    'Management Research Project',
    45,
    5850.00,
    '6 Month',
    2025,
    '6531503174',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    27,
    'Innovation Workshop',
    49,
    6480.00,
    '3 Month',
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    28,
    'Academic Excellence Program',
    50,
    13940.00,
    '10 Month',
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    29,
    'Technology Integration Study',
    51,
    5550.00,
    '4 Month',
    2025,
    '6531503176',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    30,
    'Skills Enhancement Program',
    55,
    5880.00,
    '3 Month',
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    31,
    'Community Outreach Initiative',
    56,
    12240.00,
    '9 Month',
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    32,
    'Business Strategy Research',
    57,
    5250.00,
    '5 Month',
    2025,
    '6631205226',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  );
/*!40000 ALTER TABLE `budget_projects` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `evaluate`
--

DROP TABLE IF EXISTS `evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `evaluate` (
  `evaluate_id` int NOT NULL,
  `evaluate_name` varchar(20) NOT NULL,
  `evaluate_start_date` date NOT NULL,
  `evaluate_end_date` date NOT NULL,
  PRIMARY KEY (`evaluate_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `evaluate`
--

LOCK TABLES `evaluate` WRITE;
/*!40000 ALTER TABLE `evaluate` DISABLE KEYS */
;
INSERT INTO `evaluate`
VALUES (1, '1/2021', '2020-08-01', '2021-01-31'),
(2, '2/2021', '2021-02-01', '2021-07-31'),
(3, '1/2022', '2021-08-01', '2022-01-31'),
(4, '2/2022', '2022-02-01', '2022-07-31'),
(5, '1/2023', '2022-08-01', '2023-01-31'),
(6, '2/2023', '2023-02-01', '2023-07-31'),
(7, '1/2024', '2023-08-01', '2024-01-31'),
(8, '2/2024', '2024-02-01', '2024-07-31'),
(9, '1/2025', '2024-08-01', '2025-01-31'),
(10, '2/2025', '2025-02-01', '2025-07-31');
/*!40000 ALTER TABLE `evaluate` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `graduate`
--

DROP TABLE IF EXISTS `graduate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `graduate` (
  `semester` int DEFAULT NULL,
  `academic_year` int DEFAULT NULL,
  `staff_code` varchar(20) DEFAULT NULL,
  `course_code` varchar(20) DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `section` int DEFAULT NULL,
  `total_student` int DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `graduate`
--

LOCK TABLES `graduate` WRITE;
/*!40000 ALTER TABLE `graduate` DISABLE KEYS */
;
INSERT INTO `graduate`
VALUES (
    1,
    2567,
    '46212058',
    '1203702',
    'Business Research',
    1,
    24
  );
/*!40000 ALTER TABLE `graduate` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `graduate_rawscore`
--

DROP TABLE IF EXISTS `graduate_rawscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `graduate_rawscore` (
  `semester` int DEFAULT NULL,
  `academic_year` int DEFAULT NULL,
  `staff_code` varchar(20) DEFAULT NULL,
  `score_lecture` decimal(5, 2) DEFAULT NULL,
  `score_lab` decimal(5, 2) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `graduate_rawscore`
--

LOCK TABLES `graduate_rawscore` WRITE;
/*!40000 ALTER TABLE `graduate_rawscore` DISABLE KEYS */
;
INSERT INTO `graduate_rawscore`
VALUES (1, 2567, '46212058', 38.00, 0.00);
/*!40000 ALTER TABLE `graduate_rawscore` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `lecturer_education`
--

DROP TABLE IF EXISTS `lecturer_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `lecturer_education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `staff_code` varchar(20) DEFAULT NULL,
  `degree` varchar(100) DEFAULT NULL,
  `institution` varchar(100) DEFAULT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_code` (`staff_code`),
  CONSTRAINT `lecturer_education_ibfk_1` FOREIGN KEY (`staff_code`) REFERENCES `lecturer_profiles` (`staff_code`)
) ENGINE = InnoDB AUTO_INCREMENT = 31 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `lecturer_education`
--

LOCK TABLES `lecturer_education` WRITE;
/*!40000 ALTER TABLE `lecturer_education` DISABLE KEYS */
;
INSERT INTO `lecturer_education`
VALUES (
    1,
    '6431703502',
    'Ph.D. in Accounting',
    'Chulalongkorn University',
    2018
  ),
(
    2,
    '6431703502',
    'M.B.A.',
    'Thammasat University',
    2014
  ),
(
    3,
    '6431703502',
    'B.B.A. in Accounting',
    'Kasetsart University',
    2012
  ),
(
    4,
    '6531503017',
    'Ph.D. in Business Administration',
    'Mae Fah Luang University',
    2020
  ),
(
    5,
    '6531503017',
    'M.B.A.',
    'Chiang Mai University',
    2016
  ),
(
    6,
    '6531503017',
    'B.B.A.',
    'Khon Kaen University',
    2014
  ),
(
    7,
    '6531503069',
    'Ph.D. in Economics',
    'Mahidol University',
    2019
  ),
(
    8,
    '6531503069',
    'M.A. in Economics',
    'Chulalongkorn University',
    2015
  ),
(
    9,
    '6531503069',
    'B.A. in Economics',
    'Thammasat University',
    2013
  ),
(
    10,
    '6531503070',
    'Ph.D. in Tourism Management',
    'Prince of Songkla University',
    2021
  ),
(
    11,
    '6531503070',
    'M.B.A. in Tourism',
    'Chiang Mai University',
    2017
  ),
(
    12,
    '6531503070',
    'B.B.A. in Tourism',
    'Srinakharinwirot University',
    2015
  ),
(
    13,
    '6531503074',
    'Ph.D. in Aviation Management',
    'Embry-Riddle Aeronautical University',
    2020
  ),
(
    14,
    '6531503074',
    'M.S. in Aviation',
    'Kasetsart University',
    2016
  ),
(
    15,
    '6531503074',
    'B.S. in Aviation Technology',
    'King Mongkut University',
    2014
  ),
(
    16,
    '6531503137',
    'Ph.D. in Hospitality Management',
    'Cornell University',
    2019
  ),
(
    17,
    '6531503137',
    'M.S. in Hotel Administration',
    'Mae Fah Luang University',
    2015
  ),
(
    18,
    '6531503137',
    'B.B.A. in Hotel Management',
    'Assumption University',
    2013
  ),
(
    19,
    '6531503172',
    'Ph.D. in Management',
    'Mae Fah Luang University',
    2020
  ),
(
    20,
    '6531503172',
    'M.B.A.',
    'Chulalongkorn University',
    2015
  ),
(
    21,
    '6531503172',
    'B.B.A.',
    'Chiang Mai University',
    2012
  ),
(
    22,
    '6531503174',
    'Ph.D. in Business Administration',
    'Thammasat University',
    2018
  ),
(
    23,
    '6531503174',
    'M.B.A.',
    'Mahidol University',
    2014
  ),
(
    24,
    '6531503174',
    'B.B.A.',
    'Bangkok University',
    2012
  ),
(
    25,
    '6531503176',
    'Ph.D. in Economics',
    'Chiang Mai University',
    2021
  ),
(
    26,
    '6531503176',
    'M.A. in Economics',
    'Kasetsart University',
    2017
  ),
(
    27,
    '6531503176',
    'B.A. in Economics',
    'Chulalongkorn University',
    2015
  ),
(
    28,
    '6631205226',
    'Ph.D. in Tourism and Hospitality',
    'Mahidol University',
    2020
  ),
(
    29,
    '6631205226',
    'M.B.A. in Tourism',
    'Prince of Songkla University',
    2016
  ),
(
    30,
    '6631205226',
    'B.B.A. in Tourism',
    'Suan Dusit University',
    2014
  );
/*!40000 ALTER TABLE `lecturer_education` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `lecturer_profiles`
--

DROP TABLE IF EXISTS `lecturer_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `lecturer_profiles` (
  `staff_code` varchar(20) NOT NULL,
  `staff_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`staff_code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `lecturer_profiles`
--

LOCK TABLES `lecturer_profiles` WRITE;
/*!40000 ALTER TABLE `lecturer_profiles` DISABLE KEYS */
;
INSERT INTO `lecturer_profiles`
VALUES (
    '6431703502',
    'User 6431703502',
    '081-234-5678',
    'Chiang Rai, Thailand',
    'Accounting Program',
    'Associate Professor'
  ),
(
    '6531503017',
    'User 6531503017',
    '081-345-6789',
    'Chiang Rai, Thailand',
    'Business Administration',
    'Assistant Professor'
  ),
(
    '6531503069',
    'User 6531503069',
    '081-456-7890',
    'Chiang Rai, Thailand',
    'Economics Program',
    'Associate Professor'
  ),
(
    '6531503070',
    'User 6531503070',
    '081-567-8901',
    'Chiang Rai, Thailand',
    'Tourism Management',
    'Assistant Professor'
  ),
(
    '6531503074',
    'User 6531503074',
    '081-678-9012',
    'Chiang Rai, Thailand',
    'Aviation Management',
    'Associate Professor'
  ),
(
    '6531503137',
    'User 6531503137',
    '081-789-0123',
    'Chiang Rai, Thailand',
    'Hospitality Management',
    'Assistant Professor'
  ),
(
    '6531503172',
    'Phyo Min Thein',
    '081-890-1234',
    'Chiang Rai, Thailand',
    'Accounting Program',
    'Assistant Professor'
  ),
(
    '6531503174',
    'User 6531503174',
    '081-901-2345',
    'Chiang Rai, Thailand',
    'Business Administration',
    'Associate Professor'
  ),
(
    '6531503176',
    'User 6531503176',
    '081-012-3456',
    'Chiang Rai, Thailand',
    'Economics Program',
    'Assistant Professor'
  ),
(
    '6631205226',
    'User 6631205226',
    '081-123-4567',
    'Chiang Rai, Thailand',
    'Tourism Management',
    'Associate Professor'
  );
/*!40000 ALTER TABLE `lecturer_profiles` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `lecturer_publications`
--

DROP TABLE IF EXISTS `lecturer_publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `lecturer_publications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `staff_code` varchar(20) DEFAULT NULL,
  `title` text,
  `venue` varchar(200) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_code` (`staff_code`),
  CONSTRAINT `lecturer_publications_ibfk_1` FOREIGN KEY (`staff_code`) REFERENCES `lecturer_profiles` (`staff_code`)
) ENGINE = InnoDB AUTO_INCREMENT = 23 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `lecturer_publications`
--

LOCK TABLES `lecturer_publications` WRITE;
/*!40000 ALTER TABLE `lecturer_publications` DISABLE KEYS */
;
INSERT INTO `lecturer_publications`
VALUES (
    1,
    '6431703502',
    'Corporate Governance and Financial Performance in Thai Listed Companies',
    'Journal of Asian Finance',
    2024,
    'https://example.com/paper1'
  ),
(
    2,
    '6431703502',
    'The Impact of IFRS Adoption on Earnings Quality',
    'International Accounting Review',
    2023,
    'https://example.com/paper2'
  ),
(
    3,
    '6431703502',
    'Audit Quality and Corporate Transparency',
    'Auditing Research Journal',
    2023,
    'https://example.com/paper3'
  ),
(
    4,
    '6531503017',
    'Strategic Leadership in Digital Transformation',
    'Management Science Quarterly',
    2024,
    'https://example.com/paper4'
  ),
(
    5,
    '6531503017',
    'Organizational Culture and Innovation Performance',
    'Business Strategy Review',
    2023,
    'https://example.com/paper5'
  ),
(
    6,
    '6531503069',
    'ASEAN Economic Integration and Trade Patterns',
    'Asian Economic Journal',
    2024,
    'https://example.com/paper6'
  ),
(
    7,
    '6531503069',
    'Monetary Policy Effectiveness in Emerging Markets',
    'Economics Letters',
    2023,
    'https://example.com/paper7'
  ),
(
    8,
    '6531503070',
    'Community-Based Tourism Development in Northern Thailand',
    'Tourism Management',
    2024,
    'https://example.com/paper8'
  ),
(
    9,
    '6531503070',
    'Sustainable Tourism Practices and Local Communities',
    'Journal of Sustainable Tourism',
    2023,
    'https://example.com/paper9'
  ),
(
    10,
    '6531503074',
    'Aviation Safety Management Systems Implementation',
    'Aviation Safety Journal',
    2024,
    'https://example.com/paper10'
  ),
(
    11,
    '6531503074',
    'Airport Capacity Management in Southeast Asia',
    'Transportation Research',
    2023,
    'https://example.com/paper11'
  ),
(
    12,
    '6531503137',
    'Revenue Management Strategies in Boutique Hotels',
    'International Journal of Hospitality Management',
    2024,
    'https://example.com/paper12'
  ),
(
    13,
    '6531503137',
    'Technology Adoption in Hotel Operations',
    'Cornell Hospitality Quarterly',
    2023,
    'https://example.com/paper13'
  ),
(
    14,
    '6531503172',
    'A Novel Approach to Sentiment Analysis',
    'Journal of Data Science',
    2024,
    'https://example.com/paper14'
  ),
(
    15,
    '6531503172',
    'Machine Learning in Education',
    'International Conference on AI',
    2023,
    'https://example.com/paper15'
  ),
(
    16,
    '6531503172',
    'Optimizing Research Collaboration',
    'Research Management Review',
    2023,
    'https://example.com/paper16'
  ),
(
    17,
    '6531503174',
    'Digital Marketing Effectiveness in E-commerce',
    'Journal of Digital Marketing',
    2024,
    'https://example.com/paper17'
  ),
(
    18,
    '6531503174',
    'Consumer Behavior in Online Shopping',
    'Marketing Research Journal',
    2023,
    'https://example.com/paper18'
  ),
(
    19,
    '6531503176',
    'Financial Market Integration in ASEAN',
    'Finance Research Letters',
    2024,
    'https://example.com/paper19'
  ),
(
    20,
    '6531503176',
    'Banking Efficiency and Economic Growth',
    'Journal of Banking and Finance',
    2023,
    'https://example.com/paper20'
  ),
(
    21,
    '6631205226',
    'Cultural Heritage Tourism and Local Development',
    'Cultural Tourism Research',
    2024,
    'https://example.com/paper21'
  ),
(
    22,
    '6631205226',
    'Tourism Impact on Rural Communities',
    'Rural Tourism Journal',
    2023,
    'https://example.com/paper22'
  );
/*!40000 ALTER TABLE `lecturer_publications` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `lecturer_research_areas`
--

DROP TABLE IF EXISTS `lecturer_research_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `lecturer_research_areas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `staff_code` varchar(20) DEFAULT NULL,
  `research_area` text,
  PRIMARY KEY (`id`),
  KEY `staff_code` (`staff_code`),
  CONSTRAINT `lecturer_research_areas_ibfk_1` FOREIGN KEY (`staff_code`) REFERENCES `lecturer_profiles` (`staff_code`)
) ENGINE = InnoDB AUTO_INCREMENT = 32 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `lecturer_research_areas`
--

LOCK TABLES `lecturer_research_areas` WRITE;
/*!40000 ALTER TABLE `lecturer_research_areas` DISABLE KEYS */
;
INSERT INTO `lecturer_research_areas`
VALUES (
    1,
    '6431703502',
    'Financial Accounting and Reporting'
  ),
(2, '6431703502', 'Corporate Governance'),
(3, '6431703502', 'Auditing and Assurance'),
(4, '6531503017', 'Strategic Management'),
(5, '6531503017', 'Organizational Behavior'),
(6, '6531503017', 'Leadership Development'),
(7, '6531503069', 'Macroeconomic Policy'),
(8, '6531503069', 'International Trade'),
(9, '6531503069', 'Development Economics'),
(10, '6531503070', 'Sustainable Tourism'),
(11, '6531503070', 'Community-Based Tourism'),
(12, '6531503070', 'Tourism Marketing'),
(13, '6531503074', 'Aviation Safety Management'),
(14, '6531503074', 'Airport Operations'),
(15, '6531503074', 'Airline Management'),
(16, '6531503137', 'Hotel Revenue Management'),
(17, '6531503137', 'Service Quality Management'),
(18, '6531503137', 'Hospitality Technology'),
(
    19,
    '6531503172',
    'Business Intelligence and Data Analytics'
  ),
(
    20,
    '6531503172',
    'Machine Learning Applications in Management'
  ),
(
    21,
    '6531503172',
    'Higher Education Administration'
  ),
(
    22,
    '6531503172',
    'Research Collaboration Networks'
  ),
(23, '6531503174', 'Digital Marketing'),
(24, '6531503174', 'E-commerce Strategy'),
(25, '6531503174', 'Consumer Behavior'),
(26, '6531503176', 'Financial Economics'),
(27, '6531503176', 'Monetary Policy'),
(28, '6531503176', 'Banking and Finance'),
(29, '6631205226', 'Cultural Tourism'),
(30, '6631205226', 'Tourism Impact Assessment'),
(31, '6631205226', 'Destination Management');
/*!40000 ALTER TABLE `lecturer_research_areas` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `percentage`
--

DROP TABLE IF EXISTS `percentage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `percentage` (
  `staff_code` varchar(10) NOT NULL,
  `staff_name` varchar(255) NOT NULL,
  `domain1_weight` float NOT NULL,
  `domain2_weight` float NOT NULL,
  `domain3_weight` float NOT NULL,
  `domain4_weight` float NOT NULL,
  `domain5_weight` float NOT NULL,
  PRIMARY KEY (`staff_code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `percentage`
--

LOCK TABLES `percentage` WRITE;
/*!40000 ALTER TABLE `percentage` DISABLE KEYS */
;
INSERT INTO `percentage`
VALUES (
    '45210012',
    'Assistant Professor Dr. Apisom Intralawan',
    35,
    40,
    10,
    5,
    10
  ),
(
    '46212058',
    'Ajarn Dr. Chachaya Yodsuwan',
    35,
    40,
    10,
    5,
    10
  ),
(
    '46212130',
    'Ajarn Supannika Khuanmuang',
    60,
    15,
    10,
    5,
    10
  ),
(
    '48212025',
    'Ajarn Rapipong Promnart',
    60,
    15,
    10,
    5,
    10
  ),
(
    '49210074',
    'Ajarn Sudsiri Rungruang',
    60,
    15,
    10,
    5,
    10
  ),
(
    '49212075',
    'Ajarn Dr. Piyatida Pianluprasidh',
    60,
    15,
    10,
    5,
    10
  ),
(
    '52212018',
    'Assistant Professor Dr. Chatrudee Jongsureyapart',
    35,
    15,
    10,
    30,
    10
  ),
(
    '53212053',
    'Ajarn Ekawee Vinitkhatkumnuen',
    60,
    15,
    10,
    5,
    10
  ),
(
    '54212008',
    'Ajarn Dr. Pornpimol Chaisanit',
    35,
    15,
    35,
    5,
    10
  ),
(
    '54212096',
    'Ajarn Dr. Pornwasin Sirisawat',
    35,
    15,
    10,
    30,
    10
  ),
(
    '55212008',
    'Assistant Professor Dr. Narat Hasachoo',
    35,
    15,
    10,
    30,
    10
  ),
(
    '56212015',
    'Ajarn Dr. Pratsanee Na Keeree',
    35,
    15,
    35,
    5,
    10
  ),
(
    '56212026',
    'Assistant Professor Dr. Tipavinee Suwanwong Rodbundith',
    35,
    15,
    10,
    30,
    10
  ),
(
    '56212063',
    'Assistant Professor Dr. Tarittawan Chareanporn',
    35,
    40,
    10,
    5,
    10
  ),
(
    '56212106',
    'Ajarn Dr. Parinyakorn Paengsri',
    35,
    15,
    10,
    30,
    10
  ),
(
    '56212113',
    'Assistant Professor Dr. Nattapan Kongbuamai',
    35,
    15,
    10,
    30,
    10
  ),
(
    '57212016',
    'Assistant Professor Krit Sittivangkul',
    35,
    40,
    10,
    5,
    10
  ),
(
    '57212087',
    'Assistant Professor Dr. Athitaya Pathan',
    35,
    15,
    35,
    5,
    10
  ),
(
    '57212116',
    'Ajarn Anvar Variskhanov',
    60,
    15,
    10,
    5,
    10
  ),
(
    '57212154',
    'Ajarn Dr. Korawit Fakkhong',
    35,
    15,
    10,
    30,
    10
  ),
(
    '58212017',
    'Ajarn Dr. Samatthachai Yamsa-ard',
    35,
    40,
    10,
    5,
    10
  ),
(
    '58212129',
    'Ajarn Dr. Warawut Ruankham',
    35,
    40,
    10,
    5,
    10
  ),
('58212221', 'Ajarn Thunwa Kaewket', 35, 40, 10, 5, 10),
(
    '59212025',
    'Ajarn Paponpat taveeapiradeecharoen',
    35,
    15,
    10,
    30,
    10
  ),
(
    '60212071',
    'Assistant Professor Piyanart Junkrachang',
    35,
    15,
    35,
    5,
    10
  ),
(
    '60212205',
    'Ajarn Dulyaluk Butkhunthong',
    60,
    15,
    10,
    5,
    10
  ),
('61212038', 'Ajarn Chun Jiang', 60, 15, 10, 5, 10),
(
    '61212115',
    'Assistant Professor Dr. Popkarn Arwatchanakarn',
    35,
    15,
    10,
    30,
    10
  ),
(
    '61212204',
    'Assistant Professor Muhammad Syukur',
    60,
    15,
    10,
    5,
    10
  ),
(
    '62212055',
    'Ajarn Dr. Justin Kraemer',
    60,
    15,
    10,
    5,
    10
  ),
(
    '62212117',
    'Assistant Professor Teeris Thepchalerm',
    35,
    40,
    10,
    5,
    10
  ),
(
    '63212199',
    'Assistant Professor Dr. Tosporn Arreeras',
    35,
    40,
    10,
    5,
    10
  ),
('64212045', 'Ajarn Wachira Ponboon', 60, 15, 10, 5, 10),
(
    '64212188',
    'Ajarn Dr. Sunida Tiwong',
    60,
    15,
    10,
    5,
    10
  ),
(
    '64212268',
    'Assistant Professor Dr. Panita Rachapaettayakom',
    35,
    15,
    35,
    5,
    10
  ),
(
    '64212282',
    'Ajarn Donlapon Suwanthep',
    60,
    15,
    10,
    5,
    10
  ),
('6431703502', 'SHWE YI OO ', 60, 20, 10, 4, 5),
(
    '65212073',
    'Ajarn Dzakiyy Hadiyan Achyar',
    60,
    15,
    10,
    5,
    10
  ),
(
    '65212150',
    'Ajarn Dr. Lahcene Makhloufi',
    35,
    15,
    35,
    5,
    10
  ),
(
    '65212167',
    'Ajarn Dr. Supansa Chaising',
    35,
    40,
    10,
    5,
    10
  ),
(
    '65212205',
    'Acting Sub Lt. Ajarn Dr. Patipat Tunming',
    35,
    40,
    10,
    5,
    10
  ),
(
    '65212219',
    'Ajarn Dr. Siripen Yiamjanya',
    35,
    40,
    10,
    5,
    10
  ),
(
    '65212262',
    'Ajarn Dr. Matej Balen',
    35,
    15,
    10,
    30,
    10
  ),
('6531503017', 'CHURANIPUK SABAIJAI', 50, 30, 20, 10, 5),
('6531503069', 'RAWISARA AIAMOON', 60, 20, 10, 15, 4),
(
    '6531503070',
    'RATCANON SUWATSIRIPHOL',
    60,
    20,
    10,
    14,
    5
  ),
(
    '6531503074',
    'VILASEENLAPA LIMTHANADEATCHANUN',
    60,
    10,
    15,
    10,
    4
  ),
('6531503137', 'Chit Min Thu', 50, 15, 20, 5, 4),
('6531503172', 'Phyo Min Thein', 60, 15, 10, 5, 3.75),
('6531503174', 'Phyo Thiha', 60, 20, 30, 6, 5),
('6531503176', 'Sai Myat Min Han', 60, 15, 10, 5, 4),
(
    '66212042',
    'Ajarn Kasidit Saraphon',
    35,
    15,
    10,
    30,
    10
  ),
(
    '66212127',
    'Ajarn Dr. Kasidech Treethong',
    60,
    15,
    10,
    5,
    10
  ),
(
    '66212133',
    'Ajarn Dr. Natacha Maswichian',
    60,
    15,
    10,
    5,
    10
  ),
('6631205226', 'Youn Shwe Yie Moe', 60, 30, 20, 10, 10),
(
    '67212021',
    'Ajarn Wayoon Akesakulpaibool',
    60,
    15,
    10,
    5,
    10
  ),
(
    '67212030',
    'Ajarn Dr. Mihlayifani Nicholas Nyoni',
    60,
    15,
    10,
    5,
    10
  ),
(
    '67212038',
    'Ajarn Ubolkarn Petchluan',
    35,
    15,
    10,
    5,
    10
  ),
(
    '67212095',
    'Ajarn Dr. Piranun Juntapoon',
    60,
    15,
    10,
    5,
    10
  );
/*!40000 ALTER TABLE `percentage` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `project_owners`
--

DROP TABLE IF EXISTS `project_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `project_owners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_owners_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `budget_projects` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 36 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `project_owners`
--

LOCK TABLES `project_owners` WRITE;
/*!40000 ALTER TABLE `project_owners` DISABLE KEYS */
;
INSERT INTO `project_owners`
VALUES (
    1,
    1,
    'Dr. Apinya Wongkham',
    1,
    '2025-08-05 22:39:46'
  ),
(
    2,
    2,
    'Dr. Apinya Wongkham',
    1,
    '2025-08-05 22:39:46'
  ),
(
    3,
    3,
    'Dr. Apinya Wongkham',
    1,
    '2025-08-05 22:39:46'
  ),
(
    4,
    4,
    'Dr. Apinya Wongkham',
    1,
    '2025-08-05 22:39:46'
  ),
(
    5,
    5,
    'Dr. Siriporn Thanakit',
    1,
    '2025-08-05 22:39:46'
  ),
(
    6,
    6,
    'Dr. Siriporn Thanakit',
    1,
    '2025-08-05 22:39:46'
  ),
(
    7,
    7,
    'Dr. Siriporn Thanakit',
    1,
    '2025-08-05 22:39:46'
  ),
(
    8,
    8,
    'Dr. Rattana Choosri',
    1,
    '2025-08-05 22:39:46'
  ),
(
    9,
    9,
    'Dr. Rattana Choosri',
    1,
    '2025-08-05 22:39:46'
  ),
(
    10,
    10,
    'Dr. Rattana Choosri',
    1,
    '2025-08-05 22:39:46'
  ),
(
    11,
    11,
    'Dr. Suwanna Phakdee',
    1,
    '2025-08-05 22:39:46'
  ),
(
    12,
    12,
    'Dr. Suwanna Phakdee',
    1,
    '2025-08-05 22:39:46'
  ),
(
    13,
    13,
    'Dr. Suwanna Phakdee',
    1,
    '2025-08-05 22:39:46'
  ),
(14, 14, 'Dr. Niran Jaikla', 1, '2025-08-05 22:39:46'),
(15, 15, 'Dr. Niran Jaikla', 1, '2025-08-05 22:39:46'),
(16, 16, 'Dr. Niran Jaikla', 1, '2025-08-05 22:39:46'),
(
    17,
    17,
    'Dr. Kamon Bualert',
    1,
    '2025-08-05 22:39:46'
  ),
(
    18,
    18,
    'Dr. Kamon Bualert',
    1,
    '2025-08-05 22:39:46'
  ),
(
    19,
    19,
    'Dr. Kamon Bualert',
    1,
    '2025-08-05 22:39:46'
  ),
(
    20,
    20,
    'Dr. Phyo Min Thein',
    1,
    '2025-08-05 22:39:46'
  ),
(
    21,
    21,
    'Dr. Phyo Min Thein',
    0,
    '2025-08-05 22:39:46'
  ),
(
    22,
    22,
    'Dr. Phyo Min Thein',
    1,
    '2025-08-05 22:39:46'
  ),
(
    23,
    23,
    'Dr. Phyo Min Thein',
    1,
    '2025-08-05 22:39:46'
  ),
(
    24,
    24,
    'Dr. Supansa Chaising',
    1,
    '2025-08-05 22:39:46'
  ),
(
    25,
    25,
    'Dr. Supansa Chaising',
    1,
    '2025-08-05 22:39:46'
  ),
(
    26,
    26,
    'Dr. Supansa Chaising',
    1,
    '2025-08-05 22:39:46'
  ),
(
    27,
    27,
    'Dr. Korawit Fakkhong',
    1,
    '2025-08-05 22:39:46'
  ),
(
    28,
    28,
    'Dr. Korawit Fakkhong',
    1,
    '2025-08-05 22:39:46'
  ),
(
    29,
    29,
    'Dr. Korawit Fakkhong',
    1,
    '2025-08-05 22:39:46'
  ),
(
    30,
    30,
    'Dr. Wipob Suttinun',
    1,
    '2025-08-05 22:39:46'
  ),
(
    31,
    31,
    'Dr. Wipob Suttinun',
    1,
    '2025-08-05 22:39:46'
  ),
(
    32,
    32,
    'Dr. Wipob Suttinun',
    1,
    '2025-08-05 22:39:46'
  ),
(
    33,
    21,
    'Dr. Supansa Chaising',
    1,
    '2025-08-05 22:58:10'
  ),
(
    34,
    21,
    'Dr. Korawit Fakkhong',
    0,
    '2025-08-05 22:58:10'
  ),
(
    35,
    21,
    'Dr. Kamon Bualert',
    0,
    '2025-08-05 22:58:10'
  );
/*!40000 ALTER TABLE `project_owners` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `staff_budget_info`
--

DROP TABLE IF EXISTS `staff_budget_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `staff_budget_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `staff_code` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `staff_name` varchar(100) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `staff_code` (`staff_code`),
  UNIQUE KEY `email` (`email`)
) ENGINE = InnoDB AUTO_INCREMENT = 11 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `staff_budget_info`
--

LOCK TABLES `staff_budget_info` WRITE;
/*!40000 ALTER TABLE `staff_budget_info` DISABLE KEYS */
;
INSERT INTO `staff_budget_info`
VALUES (
    1,
    '6431703502',
    '6431703502@lamduan.mfu.ac.th',
    'Dr. Apinya Wongkham',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    2,
    '6531503017',
    '6531503017@lamduan.mfu.ac.th',
    'Dr. Siriporn Thanakit',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    3,
    '6531503069',
    '6531503069@lamduan.mfu.ac.th',
    'Dr. Rattana Choosri',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    4,
    '6531503070',
    '6531503070@lamduan.mfu.ac.th',
    'Dr. Suwanna Phakdee',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    5,
    '6531503074',
    '6531503074@lamduan.mfu.ac.th',
    'Dr. Niran Jaikla',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    6,
    '6531503137',
    '6531503137@lamduan.mfu.ac.th',
    'Dr. Kamon Bualert',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    7,
    '6531503172',
    '6531503172@lamduan.mfu.ac.th',
    'Dr. Supansa Chaising',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:48:07'
  ),
(
    8,
    '6531503174',
    '6531503174@lamduan.mfu.ac.th',
    'Dr. Supansa Chaising',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    9,
    '6531503176',
    '6531503176@lamduan.mfu.ac.th',
    'Dr. Korawit Fakkhong',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  ),
(
    10,
    '6631205226',
    '6631205226@lamduan.mfu.ac.th',
    'Dr. Wipob Suttinun',
    'School of Management',
    '2025-08-05 22:39:46',
    '2025-08-05 22:39:46'
  );
/*!40000 ALTER TABLE `staff_budget_info` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `undergraduate`
--

DROP TABLE IF EXISTS `undergraduate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `undergraduate` (
  `semester` int NOT NULL,
  `academic_year` int NOT NULL,
  `staff_code` varchar(20) NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `section` int NOT NULL,
  `total_student` int NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `undergraduate`
--

LOCK TABLES `undergraduate` WRITE;
/*!40000 ALTER TABLE `undergraduate` DISABLE KEYS */
;
INSERT INTO `undergraduate`
VALUES (
    1,
    2567,
    '67212038',
    '1201101',
    'Foundations of Accounting',
    1,
    165
  ),
(
    1,
    2567,
    '67212038',
    '1201202',
    'Intermediate Accounting 2',
    1,
    103
  ),
(
    1,
    2567,
    '67212038',
    '1201302',
    'Advanced Accounting 2',
    1,
    93
  ),
(
    1,
    2567,
    '67212038',
    '1201344',
    'Apprenticeship',
    1,
    10
  ),
(
    1,
    2567,
    '67212038',
    '1201412',
    'Advanced Accounting 2',
    1,
    1
  );
/*!40000 ALTER TABLE `undergraduate` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `undergraduate_rawscore`
--

DROP TABLE IF EXISTS `undergraduate_rawscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `undergraduate_rawscore` (
  `semester` int NOT NULL,
  `academic_year` int NOT NULL,
  `staff_code` varchar(20) NOT NULL,
  `score_lecture` decimal(5, 2) NOT NULL,
  `score_lab` decimal(5, 2) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `undergraduate_rawscore`
--

LOCK TABLES `undergraduate_rawscore` WRITE;
/*!40000 ALTER TABLE `undergraduate_rawscore` DISABLE KEYS */
;
INSERT INTO `undergraduate_rawscore`
VALUES (1, 2567, '61212204', 82.50, 41.25);
/*!40000 ALTER TABLE `undergraduate_rawscore` ENABLE KEYS */
;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */
;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */
;
-- Dump completed on 2025-08-06  8:41:15