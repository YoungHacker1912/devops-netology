# 0 "test_data/test_dump.sql"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "test_data/test_dump.sql"
-- MySQL dump 10.13 Distrib 8.0.21, for Linux (x86_64)
--
-- Host: localhost Database: test_db
-- ------------------------------------------------------
-- Server version 8.0.21

                                                                ;
                                                                  ;
                                                                ;
                             ;
                                          ;
                                  ;
                                                                   ;
                                                                                  ;
                                                                          ;
                                                       ;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
                                                             ;
                                              ;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
                                                       ;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
                                             ;
INSERT INTO `orders` VALUES (1,'War and Peace',100),(2,'My little pony',500),(3,'Adventure mysql times',300),(4,'Server gravity falls',300),(5,'Log gossips',123);
                                            ;
UNLOCK TABLES;
                                        ;

                                      ;
                                                          ;
                                                ;
                                                              ;
                                                                ;
                                                              ;
                                        ;

-- Dump completed on 2020-10-11 18:15:33
