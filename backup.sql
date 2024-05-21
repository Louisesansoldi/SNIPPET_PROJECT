-- MariaDB dump 10.19-11.2.2-MariaDB, for osx10.17 (x86_64)
--
-- Host: localhost    Database: snippet_database
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB

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
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_users` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_users` (`id_users`),
  CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` VALUES
(1,2);
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keyWords`
--

DROP TABLE IF EXISTS `keyWords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keyWords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyWord` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keyWords`
--

LOCK TABLES `keyWords` WRITE;
/*!40000 ALTER TABLE `keyWords` DISABLE KEYS */;
INSERT INTO `keyWords` VALUES
(99,'animation, title'),
(100,'e'),
(101,'animation'),
(102,'title'),
(103,'create'),
(104,'color'),
(105,'pink'),
(106,'red'),
(107,'green'),
(108,'est'),
(109,'ce'),
(110,'que'),
(111,'ça'),
(112,'marche'),
(113,'queee'),
(114,'o'),
(115,'hola'),
(116,'keyWords'),
(117,'encore'),
(118,'ok'),
(119,'mamamia');
/*!40000 ALTER TABLE `keyWords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postKeyWords`
--

DROP TABLE IF EXISTS `postKeyWords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postKeyWords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_keyWords` int(11) DEFAULT NULL,
  `id_snippetPosts` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_keyWords` (`id_keyWords`),
  KEY `id_snippetPosts` (`id_snippetPosts`),
  CONSTRAINT `postkeywords_ibfk_1` FOREIGN KEY (`id_keyWords`) REFERENCES `keyWords` (`id`),
  CONSTRAINT `postkeywords_ibfk_2` FOREIGN KEY (`id_snippetPosts`) REFERENCES `snippetPosts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postKeyWords`
--

LOCK TABLES `postKeyWords` WRITE;
/*!40000 ALTER TABLE `postKeyWords` DISABLE KEYS */;
INSERT INTO `postKeyWords` VALUES
(54,99,42),
(55,99,44),
(56,99,51),
(57,99,51),
(58,106,57),
(59,107,57),
(60,108,58),
(61,109,58),
(62,110,58),
(63,111,58),
(64,112,58),
(65,113,60),
(66,114,60),
(67,115,60),
(68,116,68),
(69,117,69),
(70,118,69),
(71,119,74),
(72,119,75),
(73,119,76);
/*!40000 ALTER TABLE `postKeyWords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snippetPosts`
--

DROP TABLE IF EXISTS `snippetPosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snippetPosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `siteLink` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `author` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imageUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `language` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `snippet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_collection` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_collection` (`id_collection`),
  CONSTRAINT `snippetposts_ibfk_1` FOREIGN KEY (`id_collection`) REFERENCES `collections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snippetPosts`
--

LOCK TABLES `snippetPosts` WRITE;
/*!40000 ALTER TABLE `snippetPosts` DISABLE KEYS */;
INSERT INTO `snippetPosts` VALUES
(1,'animation title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(2,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(3,'animation title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(4,'animation title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(6,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(7,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(8,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(9,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(10,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(11,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(12,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(13,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(14,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(15,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(16,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(17,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(18,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(19,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(20,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(21,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(22,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(23,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(24,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(25,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(26,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(27,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(28,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(29,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(30,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(31,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(32,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(33,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(34,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(35,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(36,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(37,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(38,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(39,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(40,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(41,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(42,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(43,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(44,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(45,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(46,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(47,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(48,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(49,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(50,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(51,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(52,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(53,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(54,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(55,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(56,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(57,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(58,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(59,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(60,'animationnn title','the link of the website','author of the snippet','the url of the screenshot','javascript, css','the snippet here, i have to work on this',1),
(61,'title','siteLink','author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868002/xnzwklln3pblz1ollvsd.jpg','language','snippet',1),
(62,'title','siteLink','author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868060/r5bfzi0at8wgbu6jwxeg.jpg','language','snippet',1),
(63,'title','siteLink','author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868229/d9vpb5ehnyif8qqlmaeq.jpg','language','snippet',1),
(64,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868292/a2z8kgpxlwza2gz96xhp.jpg','the language','the snippettt',1),
(65,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868353/jyzfwyjg14zmewkf2nxu.jpg','the language','the snippettt',1),
(66,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868420/wrznarmjo14tdlohulw6.jpg','the language','the snippettt',1),
(67,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868457/wuytkxeodflr4lg3hzht.jpg','the language','the snippettt',1),
(68,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868478/zgrjkie4nxplq335c26y.jpg','the language','the snippettt',1),
(69,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715868632/frddqljaip7jdros2gcd.jpg','the language','the snippettt',1),
(70,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715870350/syiuvt2nl15fs7udkdc8.jpg','the language','the snippettt',1),
(71,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715870353/yiwnpjofihvnjdinglwg.jpg','the language','the snippettt',1),
(72,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715870403/q11akqpl0nlpd0dvthlv.jpg','the language','the snippettt',1),
(73,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715870464/eujwllx4thektslwrryt.jpg','the language','the snippettt',1),
(74,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715870494/lvgadkmn6uonlvt1dhui.jpg','the language','the snippettt',1),
(75,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715870674/evefm2eiu033ravhsdao.jpg','the language','the snippettt',1),
(76,'the title','the link','the author','https://res.cloudinary.com/ddw3sbubm/image/upload/v1715870690/gjbckevdutidf4curcs8.jpg','the language','the snippettt',1);
/*!40000 ALTER TABLE `snippetPosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'lou','lou@gmail.com','$2b$12$4QCwC3vd3BxDjrbn5n1rWuwyHfWJjTzr82ery4lDKmEIHyWUPvZIu'),
(2,'lou2','lou2@gmail.com','$2b$12$vCi/rqcZVVRqCk/sXq9i9.NpSyCD9Um2YTN649QqWA0n31c1ztgqq');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-21 12:03:21
