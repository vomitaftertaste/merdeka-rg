
-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 05, 2015 at 06:57 AM
-- Server version: 10.0.22-MariaDB
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `u972812590_db1`
--

-- --------------------------------------------------------

--
-- Table structure for table `merdeka`
--

CREATE TABLE IF NOT EXISTS `merdeka` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `imageUrl` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `timeStamp` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `hashtag` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `merdeka`
--

INSERT INTO `merdeka` (`id`, `message`, `imageUrl`, `timeStamp`, `hashtag`) VALUES
(1, 'just for fun', 'http://images.edge-generalmills.com/e39f4536-7071-48fa-a764-30235cd5fb54.jpg', '2015/12/5 2.49pm', '#pie');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
