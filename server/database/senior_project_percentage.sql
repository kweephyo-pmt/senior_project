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
  `domain1_weight` int NOT NULL,
  `domain2_weight` int NOT NULL,
  `domain3_weight` int NOT NULL,
  `domain4_weight` int NOT NULL,
  `domain5_weight` int NOT NULL,
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
('6531503172', 'Phyo Min Thein', 60, 15, 10, 5, 4),
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
-- Dump completed on 2025-07-30  0:33:07