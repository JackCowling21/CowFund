-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: finance
-- ------------------------------------------------------
-- Server version       8.0.36-0ubuntu0.22.04.1

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
-- Table structure for table `Companies`
--

DROP TABLE IF EXISTS `Companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Companies` (
  `CompanyID` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Symbol` varchar(255) DEFAULT NULL,
  `Grouping` varchar(255) DEFAULT NULL,
  `LastFetchDate` datetime DEFAULT NULL,
  `FetchStatus` varchar(10) DEFAULT NULL,
  `StockInfoUpdated` datetime DEFAULT NULL,
  `StockInfoStatus` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`CompanyID`),
  KEY `idx_symbol` (`Symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DailyStockPrices`
--

DROP TABLE IF EXISTS `DailyStockPrices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DailyStockPrices` (
  `Date` date DEFAULT NULL,
  `Open` float DEFAULT NULL,
  `High` float DEFAULT NULL,
  `Low` float DEFAULT NULL,
  `Close` float DEFAULT NULL,
  `Adj_Close` float DEFAULT NULL,
  `Volume` bigint DEFAULT NULL,
  `Symbol` varchar(255) DEFAULT NULL,
  `ChangePercent` float DEFAULT NULL,
  KEY `Symbol` (`Symbol`),
  CONSTRAINT `DailyStockPrices_ibfk_1` FOREIGN KEY (`Symbol`) REFERENCES `Companies` (`Symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `StockInfo`
--

DROP TABLE IF EXISTS `StockInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StockInfo` (
  `Symbol` varchar(10) NOT NULL,
  `LongName` varchar(255) DEFAULT NULL,
  `Sector` varchar(255) DEFAULT NULL,
  `FullTimeEmployees` int DEFAULT NULL,
  `MarketCap` bigint DEFAULT NULL,
  `TrailingPE` float DEFAULT NULL,
  `ForwardPE` float DEFAULT NULL,
  `DividendYield` float DEFAULT NULL,
  `AverageVolume` bigint DEFAULT NULL,
  `PriceToBook` float DEFAULT NULL,
  `ProfitMargins` float DEFAULT NULL,
  `RevenueGrowth` float DEFAULT NULL,
  `OperatingMargins` float DEFAULT NULL,
  `EBITDA` bigint DEFAULT NULL,
  `DebtToEquity` float DEFAULT NULL,
  `ReturnOnAssets` float DEFAULT NULL,
  `ReturnOnEquity` float DEFAULT NULL,
  `TotalCash` bigint DEFAULT NULL,
  `TotalDebt` bigint DEFAULT NULL,
  `CurrentPrice` float DEFAULT NULL,
  `EarningsGrowth` float DEFAULT NULL,
  `Beta` float DEFAULT NULL,
  `DateEntered` datetime DEFAULT CURRENT_TIMESTAMP,
  `DailyAverageAll` bigint DEFAULT '0',
  `DailyAverage60` bigint DEFAULT '0',
  `DailyAverage30` bigint DEFAULT '0',
  `DailyAverage7` bigint DEFAULT '0',
  `DailyAverage2` bigint DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TickerPairs`
--

DROP TABLE IF EXISTS `TickerPairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TickerPairs` (
  `ticker1` varchar(10) DEFAULT NULL,
  `ticker2` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-03 12:10:24