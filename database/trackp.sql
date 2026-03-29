-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2025 at 11:29 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trackp`
--

-- --------------------------------------------------------

--
-- Table structure for table `cameras`
--

CREATE TABLE `cameras` (
  `id` int(11) NOT NULL,
  `address` text NOT NULL,
  `longitude` text NOT NULL,
  `latitude` text NOT NULL,
  `status` text NOT NULL DEFAULT 'None'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cameras`
--

INSERT INTO `cameras` (`id`, `address`, `longitude`, `latitude`, `status`) VALUES
(1, 'Chhatrapati Shivaji Maharaj Putala', '74.794243', '20.901190', 'Active'),
(2, 'At D-Mart', '73.027614', '19.033526', 'Active'),
(3, 'SVKM IOT, Dhule', '74.7698444', '20.8746484', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `missing_person_id` int(11) NOT NULL,
  `camera_id` int(11) NOT NULL,
  `identify_date` text NOT NULL,
  `time` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `missing_person_id`, `camera_id`, `identify_date`, `time`) VALUES
(1, 5, 3, '2025-06-13', '13:51:47'),
(2, 5, 3, '2025-06-13', '13:51:48'),
(3, 6, 1, '2025-06-13', '15:44:57'),
(4, 6, 1, '2025-06-13', '15:44:59'),
(5, 6, 1, '2025-06-13', '15:44:59'),
(6, 6, 1, '2025-06-13', '15:45:00'),
(7, 6, 1, '2025-06-13', '15:45:01'),
(8, 6, 1, '2025-06-13', '15:45:01'),
(9, 6, 1, '2025-06-13', '15:45:02'),
(10, 6, 1, '2025-06-13', '15:45:03');

-- --------------------------------------------------------

--
-- Table structure for table `missing_person`
--

CREATE TABLE `missing_person` (
  `id` int(11) NOT NULL,
  `station_id` text NOT NULL,
  `name` text NOT NULL,
  `birthdate` text NOT NULL,
  `address` text NOT NULL,
  `missingdate` text NOT NULL,
  `complaintdate` text NOT NULL,
  `criminal` enum('yes','no') NOT NULL,
  `aadharCardNo` text NOT NULL,
  `photo` text NOT NULL,
  `laststatus` text NOT NULL,
  `status` text NOT NULL DEFAULT 'Missing'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `missing_person`
--

INSERT INTO `missing_person` (`id`, `station_id`, `name`, `birthdate`, `address`, `missingdate`, `complaintdate`, `criminal`, `aadharCardNo`, `photo`, `laststatus`, `status`) VALUES
(5, '10', 'Tejas Kothawade', '2003-11-26', 'Kisanbati Chock, Dhule', '2025-06-13', '2025-06-13', 'yes', '781545121215', 'static/uploads/Tejas.jpg', '', 'Missing'),
(6, '9', 'Sushant Rokade', '2003-12-27', 'Madhav Colony, near Natraj theater, Dhule', '2025-06-11', '2025-06-13', 'yes', '702535252559', 'static/uploads/S13_EROLLPIC_7_S13007O6N1101251200033_10215637-cdc1-414a-bb8c-8542413b282d_Photo.jpeg', 'Found', 'Found'),
(7, '9', 'Pushkraj Patil', '2003-06-13', 'Vrundavan Colony, Dhule', '2025-06-12', '2025-06-13', 'yes', '451321351651', 'static/uploads/WIN_20250503_11_05_45_Pro.jpg', '', 'Missing');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `camera_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `missing_person_id` int(11) NOT NULL,
  `status` text NOT NULL DEFAULT 'unseen'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `camera_id`, `station_id`, `missing_person_id`, `status`) VALUES
(1, 3, 10, 5, 'seen'),
(2, 3, 10, 5, 'seen'),
(3, 1, 9, 6, 'seen'),
(4, 1, 9, 6, 'seen'),
(5, 1, 9, 6, 'seen'),
(6, 1, 9, 6, 'seen'),
(7, 1, 9, 6, 'seen'),
(8, 1, 9, 6, 'seen'),
(9, 1, 9, 6, 'seen'),
(10, 1, 9, 6, 'seen');

-- --------------------------------------------------------

--
-- Table structure for table `stations`
--

CREATE TABLE `stations` (
  `id` int(11) NOT NULL,
  `station_name` text NOT NULL,
  `station_email` text NOT NULL,
  `password` text NOT NULL,
  `station_mobile_no` text NOT NULL,
  `longitude` text NOT NULL,
  `latitude` text NOT NULL,
  `state` text NOT NULL,
  `district` text NOT NULL,
  `division` text NOT NULL,
  `city` text NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `stations`
--

INSERT INTO `stations` (`id`, `station_name`, `station_email`, `password`, `station_mobile_no`, `longitude`, `latitude`, `state`, `district`, `division`, `city`, `date`) VALUES
(9, 'Azad Nagar Police Station', 'azadnagar@gmail.com', 'azadnagar', '9373956605', '78.552031', '17.450043', 'Maharashtra', 'Dhule', 'Dhule', 'Dhule', '2025-01-17'),
(10, 'chalisgaon road police station ', 'chalisgaonroad@gmail.com', 'chalisgaonroad', '7598533145', '75.002378', '20.462767', 'Maharashtra', 'Dhule', 'Dhule', 'Dhule', '2025-01-25');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `user_type` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `user_type`) VALUES
(1, 'admin@gmail.com', '123', 'admin'),
(9, 'azadnagar@gmail.com', 'azadnagar', 'station'),
(10, 'chalisgaonroad@gmail.com', 'chalisgaonroad', 'station');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cameras`
--
ALTER TABLE `cameras`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `missing_person`
--
ALTER TABLE `missing_person`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stations`
--
ALTER TABLE `stations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cameras`
--
ALTER TABLE `cameras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `missing_person`
--
ALTER TABLE `missing_person`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stations`
--
ALTER TABLE `stations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
