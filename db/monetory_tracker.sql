-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2025 at 07:21 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `monetory_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `u_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `pass` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`u_id`, `name`, `email`, `pass`) VALUES
(3, 'xyz', 'xyz@gmail.com', 'VBTZ'),
(4, 'Rahul Dixit', 'rahulndixit2002@gmail.com', 'CDICIZ'),
(5, 'Shreya Gaur', 'shreyagaur0107@gmail.com', 'CFSCAB');

-- --------------------------------------------------------

--
-- Table structure for table `asking`
--

CREATE TABLE `asking` (
  `name` char(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `msg` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `asking`
--

INSERT INTO `asking` (`name`, `email`, `msg`) VALUES
('Palak Dixit', 'd.eyelid2003@gmail.com', 'This website give me privacy or not?'),
('Lokesh Garothiya', 'garothiyalokesh@gmail.com', 'lovely UI'),
('Palak Dixit', 'd.eyelid2003@gmail.com', 'dafd');

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `amount` bigint(100) NOT NULL,
  `cat` varchar(100) NOT NULL,
  `Edate` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `name`, `amount`, `cat`, `Edate`) VALUES
(2, 'Grocery Shopping', 2500, 'Household', '2024-11-06'),
(3, 'Electricity Bill', 1200, 'Utilities', '2024-11-02'),
(4, 'Netflix Subscription', 499, 'Entertainment', '2024-11-14');

-- --------------------------------------------------------

--
-- Table structure for table `income`
--

CREATE TABLE `income` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `amount` bigint(100) NOT NULL,
  `cat` varchar(100) NOT NULL,
  `Idate` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `income`
--

INSERT INTO `income` (`id`, `name`, `amount`, `cat`, `Idate`) VALUES
(1, 'Freelance Writing', 5000, 'Freelance Work', '2024-11-17'),
(2, 'Monthly Salary', 45000, 'Job', '2024-11-01'),
(3, 'Rent from Property', 15000, 'Passive Income', '2024-11-15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`u_id`);

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income`
--
ALTER TABLE `income`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `income`
--
ALTER TABLE `income`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
