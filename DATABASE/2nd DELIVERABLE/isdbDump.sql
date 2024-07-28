DROP SCHEMA IF EXISTS `isdb`;
CREATE SCHEMA `isdb`;
USE `isdb`;

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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `albumID` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `release_date` date NOT NULL,
  `rating` float NOT NULL,
  `duration` time DEFAULT NULL,
  `type` enum('EP','LP','SINGLE') DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `RecordLabel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`albumID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'Abbey Road','1969-09-26',4.8,'00:47:23','LP','abbey_road.jpg','Rock','Apple Records'),(2,'Thriller','1982-11-30',4.7,'00:42:19','LP','thriller.jpg','Pop','Epic Records'),(3,'Back in Black','1980-07-25',4.9,'00:42:11','LP','back_in_black.jpg','Rock','Atlantic Records'),(4,'Dark Side of the Moon','1973-03-01',4.9,'00:42:49','LP','dark_side_of_the_moon.jpg','Progressive Rock','Harvest Records'),(5,'Rumours','1977-02-04',4.8,'00:39:31','LP','rumours.jpg','Rock','Warner Bros. Records'),(6,'OK Computer','1997-05-21',4.7,'00:53:21','LP','ok_computer.jpg','Alternative','Parlophone'),(7,'A Night at the Opera','1975-11-21',4.8,'00:43:08','LP','night_at_the_opera.jpg','Rock','EMI Records'),(8,'Kind of Blue','1959-08-17',4.9,'00:45:44','LP','kind_of_blue.jpg','Jazz','Columbia Records'),(9,'The Wall','1979-11-30',4.8,'01:19:23','LP','the_wall.jpg','Rock','Columbia Records'),(10,'Back to Black','2006-10-27',4.7,'00:34:58','LP','back_to_black.jpg','Soul','Island Records'),(11,'Nevermind','1991-09-24',4.7,'00:49:16','LP','nevermind.jpg','Grunge','DGC Records'),(12,'Abbey Road Sessions','2019-09-27',4.5,'00:47:55','LP','abbey_road_sessions.jpg','Rock','Capitol Records'),(13,'Singles Collection: The London Years','1989-08-28',4.6,'03:05:08','EP','singles_collection.jpg','Rock','Abkco Records'),(14,'The Suburbs','2010-08-02',4.6,'01:03:51','LP','the_suburbs.jpg','Indie Rock','Merge Records'),(15,'Kind of Blue Sessions','2021-09-17',4.5,'01:28:32','EP','kind_of_blue_sessions.jpg','Jazz','Columbia Records'),(16,'Bohemian Rhapsody','1975-10-31',4.9,'00:05:55','SINGLE','bohemian_rhapsody.jpg','Rock','EMI Records'),(17,'Like a Rolling Stone','1965-07-20',4.8,'00:06:13','SINGLE','rolling_stone.jpg','Rock','Columbia Records'),(18,'Billie Jean','1983-01-02',4.7,'00:04:54','SINGLE','billie_jean.jpg','Pop','Epic Records'),(19,'Whatever Gets You Thru The Night','1974-09-05',4.5,'00:04:57','SINGLE','whatever_gets_you_thru_the_night.jpg','Rock','Apple Records'),(20,'Imagine','1971-09-09',4.9,'00:39:31','LP','imagine.jpg','Rock','Apple Records'),(21,'x','2014-06-23',4.8,'00:50:17','LP','x.jpg','Pop','Asylum Records'),(22,'A Love Supreme','1965-02-02',4.9,'00:32:46','LP','a_love_supreme.jpg','Jazz','Impulse! Records');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `album_view`
--

DROP TABLE IF EXISTS `album_view`;
/*!50001 DROP VIEW IF EXISTS `album_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `album_view` AS SELECT 
 1 AS `albumID`,
 1 AS `album_title`,
 1 AS `release_date`,
 1 AS `RecordLabel`,
 1 AS `artist_name`,
 1 AS `GroupMembers`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `albumplatform`
--

DROP TABLE IF EXISTS `albumplatform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albumplatform` (
  `albumID` int NOT NULL,
  `platformID` int NOT NULL,
  PRIMARY KEY (`albumID`,`platformID`),
  KEY `platformID` (`platformID`),
  CONSTRAINT `albumplatform_ibfk_1` FOREIGN KEY (`albumID`) REFERENCES `album` (`albumID`),
  CONSTRAINT `albumplatform_ibfk_2` FOREIGN KEY (`platformID`) REFERENCES `platform` (`platformID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albumplatform`
--

LOCK TABLES `albumplatform` WRITE;
/*!40000 ALTER TABLE `albumplatform` DISABLE KEYS */;
INSERT INTO `albumplatform` VALUES (1,1),(2,1),(6,1),(8,1),(11,1),(12,1),(1,2),(5,2),(10,2),(13,2),(3,3),(9,3),(14,3),(4,4),(7,4);
/*!40000 ALTER TABLE `albumplatform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artistID` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `isGroup` tinyint(1) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `groupMembers` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`artistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'The Beatles',1,'United Kingdom','John Lennon,Paul McCartney,George Harrison,Ringo Starr'),(2,'Michael Jackson',0,'United States',NULL),(3,'AC/DC',1,'Australia','Angus Young,Malcolm Young,Bon Scott,Brian Johnson'),(4,'Pink Floyd',1,'United Kingdom','David Gilmour,Roger Waters,Richard Wright,Nick Mason'),(5,'Fleetwood Mac',1,'United Kingdom','Stevie Nicks,Lindsey Buckingham,Christine McVie,John McVie,Mick Fleetwood'),(6,'Radiohead',1,'United Kingdom','Thom Yorke,Jonny Greenwood,Ed O\'Brien,Colin Greenwood,Phil Selway'),(7,'Queen',1,'United Kingdom','Freddie Mercury,Brian May,Roger Taylor,John Deacon'),(8,'Miles Davis',0,'United States',NULL),(9,'Led Zeppelin',1,'United Kingdom','Robert Plant,Jimmy Page,John Paul Jones,John Bonham'),(10,'Amy Winehouse',0,'United Kingdom',NULL),(11,'Nirvana',1,'United States','Kurt Cobain,Krist Novoselic,Dave Grohl'),(12,'Ed Sheeran',0,'United Kingdom',NULL),(13,'The Rolling Stones',1,'United Kingdom','Mick Jagger,Keith Richards,Charlie Watts,Ronnie Wood'),(14,'Arcade Fire',1,'Canada','Win Butler,Régine Chassagne,Richard Reed Parry,William Butler,Tim Kingsbury,Jeremy Gara'),(15,'John Coltrane',0,'United States',NULL),(16,'John Lennon',0,'United Kingdom',NULL);
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistfollows`
--

DROP TABLE IF EXISTS `artistfollows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artistfollows` (
  `userID` int NOT NULL,
  `artistID` int NOT NULL,
  PRIMARY KEY (`userID`,`artistID`),
  KEY `artistID` (`artistID`),
  CONSTRAINT `artistfollows_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `artistfollows_ibfk_2` FOREIGN KEY (`artistID`) REFERENCES `artist` (`artistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistfollows`
--

LOCK TABLES `artistfollows` WRITE;
/*!40000 ALTER TABLE `artistfollows` DISABLE KEYS */;
/*!40000 ALTER TABLE `artistfollows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artisttoalbum`
--

DROP TABLE IF EXISTS `artisttoalbum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artisttoalbum` (
  `albumID` int NOT NULL,
  `artistID` int NOT NULL,
  PRIMARY KEY (`albumID`,`artistID`),
  KEY `artistID` (`artistID`),
  CONSTRAINT `artisttoalbum_ibfk_1` FOREIGN KEY (`albumID`) REFERENCES `album` (`albumID`),
  CONSTRAINT `artisttoalbum_ibfk_2` FOREIGN KEY (`artistID`) REFERENCES `artist` (`artistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artisttoalbum`
--

LOCK TABLES `artisttoalbum` WRITE;
/*!40000 ALTER TABLE `artisttoalbum` DISABLE KEYS */;
INSERT INTO `artisttoalbum` VALUES (1,1),(12,1),(19,1),(2,2),(18,2),(3,3),(4,4),(16,4),(5,5),(6,6),(7,7),(8,8),(15,8),(9,9),(10,10),(11,11),(21,12),(13,13),(17,13),(14,14),(22,15),(20,16);
/*!40000 ALTER TABLE `artisttoalbum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `avg_rating_view`
--

DROP TABLE IF EXISTS `avg_rating_view`;
/*!50001 DROP VIEW IF EXISTS `avg_rating_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `avg_rating_view` AS SELECT 
 1 AS `albumID`,
 1 AS `album_title`,
 1 AS `average_rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `commentID` int NOT NULL,
  `userID` int NOT NULL,
  `reviewID` int NOT NULL,
  `parentID` int NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `userID` (`userID`),
  KEY `reviewID` (`reviewID`),
  KEY `comment_ibfk_3_idx` (`parentID`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`reviewID`) REFERENCES `review` (`reviewID`),
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`parentID`) REFERENCES `comment` (`commentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,1,'Great review! I enjoyed reading it.','2023-01-15 08:30:00','2023-01-15 08:30:00'),(2,2,1,2,'Thanks for your comment!','2023-01-15 09:00:00','2023-01-15 09:00:00'),(3,3,1,2,'I have a different opinion on this.','2023-01-15 10:30:00','2023-01-15 10:30:00'),(4,4,1,4,'Can you elaborate on your viewpoint?','2023-01-15 11:15:00','2023-01-15 11:15:00'),(5,5,2,4,'Well-written review! Looking forward to more.','2023-01-16 08:45:00','2023-01-16 08:45:00'),(6,6,2,6,'I completely agree with your points.','2023-01-16 09:30:00','2023-01-16 09:30:00'),(7,7,3,7,'Interesting perspective. I hadn\'t thought about that.','2023-01-17 10:00:00','2023-01-17 10:00:00'),(8,8,3,6,'I\'m glad you found it interesting! Let\'s discuss more.','2023-01-17 11:00:00','2023-01-17 11:00:00'),(9,9,4,9,'Agreed with your review. Spot-on analysis.','2023-01-18 08:00:00','2023-01-18 08:00:00'),(10,10,4,9,'Thanks for your agreement! What was your favorite part?','2023-01-18 09:30:00','2023-01-18 09:30:00'),(11,11,5,2,'I have a different perspective on this album.','2023-01-19 10:45:00','2023-01-19 10:45:00'),(12,12,5,11,'That\'s interesting! What specifically did you find different?','2023-01-19 11:30:00','2023-01-19 11:30:00');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `comment_thread_for_review`
--

DROP TABLE IF EXISTS `comment_thread_for_review`;
/*!50001 DROP VIEW IF EXISTS `comment_thread_for_review`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `comment_thread_for_review` AS SELECT 
 1 AS `commentID`,
 1 AS `details`,
 1 AS `createdAt`,
 1 AS `updatedAt`,
 1 AS `username`,
 1 AS `avatar`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `most_reviewed_albums`
--

DROP TABLE IF EXISTS `most_reviewed_albums`;
/*!50001 DROP VIEW IF EXISTS `most_reviewed_albums`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `most_reviewed_albums` AS SELECT 
 1 AS `albumID`,
 1 AS `AverageRating`,
 1 AS `reviewCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `platform`
--

DROP TABLE IF EXISTS `platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform` (
  `platformID` int NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`platformID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform`
--

LOCK TABLES `platform` WRITE;
/*!40000 ALTER TABLE `platform` DISABLE KEYS */;
INSERT INTO `platform` VALUES (1,'https://spotify.com','spotify_logo.jpg','Spotify'),(2,'https://apple.com/music','apple_music_logo.jpg','Apple Music'),(3,'https://tidal.com','tidal_logo.jpg','Tidal'),(4,'https://amazon.com/music','amazon_music_logo.jpg','Amazon Music');
/*!40000 ALTER TABLE `platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `playlistID` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `userID` int DEFAULT NULL,
  PRIMARY KEY (`playlistID`),
  KEY `playlist_ibfk_1_idx` (`userID`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,'Favorites',4.5,'My favorite tracks of all time','01:30:00',1),(2,'Chill Vibes',4,'Relaxing tunes for a peaceful day','01:15:00',2),(3,'Workout Jams',3.8,'Energetic songs to keep me motivated','01:00:00',3),(4,'Road Trip Mix',4.2,'Perfect tunes for a long drive','02:00:00',1),(5,'Throwback Hits',4.7,'Nostalgic songs from the past','01:45:00',4),(6,'Study Session',3.5,'Instrumental music for focused studying','02:30:00',2),(7,'Party Time',4.8,'Upbeat tracks to get the party started','01:45:00',5),(8,'Acoustic Bliss',4,'Soothing acoustic melodies','01:20:00',3),(9,'Indie Discoveries',4.3,'Exploring the world of indie music','01:15:00',1),(10,'Classical Elegance',4.6,'Timeless classical masterpieces','02:15:00',4),(11,'Jazz Lounge',4.2,'Smooth jazz for a laid-back evening','01:30:00',2),(12,'Electronic Dreams',4.4,'Electronic beats for a futuristic vibe','01:45:00',3),(13,'Country Roads',3.9,'Country tunes for a scenic drive','01:40:00',5);
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `playlist_details`
--

DROP TABLE IF EXISTS `playlist_details`;
/*!50001 DROP VIEW IF EXISTS `playlist_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `playlist_details` AS SELECT 
 1 AS `playlistID`,
 1 AS `details`,
 1 AS `userID`,
 1 AS `title`,
 1 AS `username`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `playlistlikes`
--

DROP TABLE IF EXISTS `playlistlikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlistlikes` (
  `userID` int NOT NULL,
  `playlistID` int NOT NULL,
  PRIMARY KEY (`userID`,`playlistID`),
  KEY `playlistID` (`playlistID`),
  CONSTRAINT `playlistlikes_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `playlistlikes_ibfk_2` FOREIGN KEY (`playlistID`) REFERENCES `playlist` (`playlistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlistlikes`
--

LOCK TABLES `playlistlikes` WRITE;
/*!40000 ALTER TABLE `playlistlikes` DISABLE KEYS */;
INSERT INTO `playlistlikes` VALUES (1,1),(4,2),(2,3),(8,4),(3,5),(9,6),(5,7),(10,8),(6,9),(11,10),(7,11),(12,12);
/*!40000 ALTER TABLE `playlistlikes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `reviewID` int NOT NULL,
  `userID` int DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `albumID` int NOT NULL,
  PRIMARY KEY (`reviewID`),
  KEY `userID` (`userID`),
  KEY `review_ibfk_1` (`albumID`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`albumID`) REFERENCES `album` (`albumID`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,4.5,'Great album, loved the melodies!','John\'s Review',1),(2,2,5,'Absolutely amazing, a masterpiece!','Alice\'s Review',2),(3,3,4,'Solid effort, enjoyed the variety of tracks.','Bob\'s Review',3),(4,4,4.8,'Fantastic production and vocals!','Emily\'s Review',4),(5,5,3.5,'Decent album, but not my favorite.','Charlie\'s Review',5),(6,6,4.2,'Innovative sound, worth a listen.','Sarah\'s Review',6),(7,7,4.7,'Classic album, timeless tracks.','David\'s Review',7),(8,8,4.9,'Miles Davis at his best, a jazz masterpiece.','Olivia\'s Review',8),(9,9,3.8,'Good rock album, but not outstanding.','Sam\'s Review',9),(10,10,4.6,'Soulful and captivating, Winehouse shines.','Lily\'s Review',10),(11,11,4.5,'Iconic grunge album, a must-listen.','Jason\'s Review',11),(12,12,4,'Melodic and heartfelt, Sheeran delivers.','Zoey\'s Review',12);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviewlikes`
--

DROP TABLE IF EXISTS `reviewlikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewlikes` (
  `userID` int NOT NULL,
  `reviewID` int NOT NULL,
  PRIMARY KEY (`userID`,`reviewID`),
  KEY `reviewID` (`reviewID`),
  CONSTRAINT `reviewlikes_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `reviewlikes_ibfk_2` FOREIGN KEY (`reviewID`) REFERENCES `review` (`reviewID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviewlikes`
--

LOCK TABLES `reviewlikes` WRITE;
/*!40000 ALTER TABLE `reviewlikes` DISABLE KEYS */;
INSERT INTO `reviewlikes` VALUES (1,1),(4,2),(2,3),(8,4),(3,5),(9,6),(5,7),(10,8),(6,9),(11,10),(7,11),(12,12);
/*!40000 ALTER TABLE `reviewlikes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `track` (
  `trackID` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `albumID` int NOT NULL,
  PRIMARY KEY (`trackID`),
  KEY `track_ibfk_1` (`albumID`),
  CONSTRAINT `track_ibfk_1` FOREIGN KEY (`albumID`) REFERENCES `album` (`albumID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES (1,'Bohemian Rhapsody','05:55:00',1),(2,'Imagine','03:03:00',2),(3,'Like a Rolling Stone','06:13:00',3),(4,'Hotel California','06:30:00',4),(5,'Thriller','05:57:00',5),(6,'Stairway to Heaven','08:02:00',6),(7,'Billie Jean','04:54:00',5),(8,'Hey Jude','07:11:00',7),(9,'Smells Like Teen Spirit','05:01:00',8),(10,'Like a Virgin','03:35:00',9),(11,'Sweet Child o\' Mine','05:56:00',10),(12,'Dancing Queen','03:50:00',11),(13,'Purple Haze','02:50:00',12),(14,'What\'s Going On','03:53:00',13),(15,'Boogie Wonderland','04:47:00',14);
/*!40000 ALTER TABLE `track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trackplaylist`
--

DROP TABLE IF EXISTS `trackplaylist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trackplaylist` (
  `trackID` int NOT NULL,
  `playlistID` int NOT NULL,
  PRIMARY KEY (`trackID`,`playlistID`),
  KEY `playlistID` (`playlistID`),
  CONSTRAINT `trackplaylist_ibfk_1` FOREIGN KEY (`trackID`) REFERENCES `track` (`trackID`),
  CONSTRAINT `trackplaylist_ibfk_2` FOREIGN KEY (`playlistID`) REFERENCES `playlist` (`playlistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trackplaylist`
--

LOCK TABLES `trackplaylist` WRITE;
/*!40000 ALTER TABLE `trackplaylist` DISABLE KEYS */;
INSERT INTO `trackplaylist` VALUES (1,1),(2,1),(3,2),(4,2),(5,3),(6,3),(7,4),(8,4),(9,5),(10,5),(11,6),(12,6);
/*!40000 ALTER TABLE `trackplaylist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'john_doe','john.doe@example.com','john_avatar.jpg'),(2,'alice_smith','alice.smith@example.com','alice_avatar.jpg'),(3,'bob_jones','bob.jones@example.com','bob_avatar.jpg'),(4,'emily_white','emily.white@example.com','emily_avatar.jpg'),(5,'charlie_brown','charlie.brown@example.com','charlie_avatar.jpg'),(6,'sarah_green','sarah.green@example.com','sarah_avatar.jpg'),(7,'david_clark','david.clark@example.com','david_avatar.jpg'),(8,'olivia_lee','olivia.lee@example.com','olivia_avatar.jpg'),(9,'sam_wilson','sam.wilson@example.com','sam_avatar.jpg'),(10,'lily_taylor','lily.taylor@example.com','lily_avatar.jpg'),(11,'jason_miller','jason.miller@example.com','jason_avatar.jpg'),(12,'zoey_robinson','zoey.robinson@example.com','zoey_avatar.jpg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_playlist`
--

DROP TABLE IF EXISTS `user_playlist`;
/*!50001 DROP VIEW IF EXISTS `user_playlist`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_playlist` AS SELECT 
 1 AS `userID`,
 1 AS `name`,
 1 AS `playlistID`,
 1 AS `username`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_with_followers`
--

DROP TABLE IF EXISTS `user_with_followers`;
/*!50001 DROP VIEW IF EXISTS `user_with_followers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_with_followers` AS SELECT 
 1 AS `userID`,
 1 AS `username`,
 1 AS `avatar`,
 1 AS `followersCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `userfollows`
--

DROP TABLE IF EXISTS `userfollows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userfollows` (
  `userID` int NOT NULL,
  `followerID` int NOT NULL,
  PRIMARY KEY (`userID`,`followerID`),
  KEY `followerID` (`followerID`),
  CONSTRAINT `userfollows_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `userfollows_ibfk_2` FOREIGN KEY (`followerID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userfollows`
--

LOCK TABLES `userfollows` WRITE;
/*!40000 ALTER TABLE `userfollows` DISABLE KEYS */;
INSERT INTO `userfollows` VALUES (1,2),(1,3),(2,4),(1,5),(4,5),(2,6),(3,7),(4,8),(3,9),(5,10),(6,11),(5,12);
/*!40000 ALTER TABLE `userfollows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `album_view`
--

/*!50001 DROP VIEW IF EXISTS `album_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `album_view` AS select `album`.`albumID` AS `albumID`,`album`.`title` AS `album_title`,`album`.`release_date` AS `release_date`,`album`.`RecordLabel` AS `RecordLabel`,`artist`.`name` AS `artist_name`,`artist`.`groupMembers` AS `GroupMembers` from (`artist` left join (`album` join `artisttoalbum` on((`album`.`albumID` = `artisttoalbum`.`albumID`))) on((`artisttoalbum`.`artistID` = `artist`.`artistID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `avg_rating_view`
--

/*!50001 DROP VIEW IF EXISTS `avg_rating_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `avg_rating_view` AS select `album`.`albumID` AS `albumID`,`album`.`title` AS `album_title`,avg(`review`.`rating`) AS `average_rating` from (`album` left join `review` on((`album`.`albumID` = `review`.`reviewID`))) group by `album`.`albumID`,`album`.`title` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `comment_thread_for_review`
--

/*!50001 DROP VIEW IF EXISTS `comment_thread_for_review`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `comment_thread_for_review` AS select `c`.`commentID` AS `commentID`,`c`.`details` AS `details`,`c`.`createdAt` AS `createdAt`,`c`.`updatedAt` AS `updatedAt`,`u`.`username` AS `username`,`u`.`avatar` AS `avatar` from (`comment` `c` join `user` `u` on((`c`.`userID` = `u`.`userID`))) where (`c`.`reviewID` = 1) order by `c`.`createdAt` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `most_reviewed_albums`
--

/*!50001 DROP VIEW IF EXISTS `most_reviewed_albums`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `most_reviewed_albums` AS select `review`.`albumID` AS `albumID`,avg(`review`.`rating`) AS `AverageRating`,count(`review`.`reviewID`) AS `reviewCount` from `review` group by `review`.`albumID` order by `reviewCount` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `playlist_details`
--

/*!50001 DROP VIEW IF EXISTS `playlist_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `playlist_details` AS select `playlist`.`playlistID` AS `playlistID`,`playlist`.`details` AS `details`,`playlist`.`userID` AS `userID`,`track`.`title` AS `title`,`user`.`username` AS `username` from (((`playlist` join `trackplaylist` on((`trackplaylist`.`playlistID` = `playlist`.`playlistID`))) join `track` on((`trackplaylist`.`trackID` = `track`.`trackID`))) join `user` on((`user`.`userID` = `playlist`.`userID`))) where (`user`.`userID` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_playlist`
--

/*!50001 DROP VIEW IF EXISTS `user_playlist`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_playlist` AS select `playlist`.`userID` AS `userID`,`playlist`.`name` AS `name`,`playlist`.`playlistID` AS `playlistID`,`user`.`username` AS `username` from (`playlist` join `user` on((`playlist`.`userID` = `user`.`userID`))) where (`user`.`userID` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_with_followers`
--

/*!50001 DROP VIEW IF EXISTS `user_with_followers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_with_followers` AS select `u`.`userID` AS `userID`,`u`.`username` AS `username`,`u`.`avatar` AS `avatar`,count(`uf`.`followerID`) AS `followersCount` from (`user` `u` left join `userfollows` `uf` on((`u`.`userID` = `uf`.`userID`))) group by `u`.`userID` order by `followersCount` desc */;
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

-- Dump completed on 2023-12-21 19:48:57
