-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2025 at 02:17 PM
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
-- Database: `auction_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password`, `status`) VALUES
(1, 'Admin', 'admin@gmail.com', 'admin123', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `auction_winners`
--

CREATE TABLE `auction_winners` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `winning_amount` double NOT NULL,
  `winning_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auction_winners`
--

INSERT INTO `auction_winners` (`id`, `product_id`, `buyer_id`, `winning_amount`, `winning_time`) VALUES
(1, 11, 7, 350, '2025-06-04 17:15:50'),
(2, 1, 8, 1500, '2025-06-04 20:32:53');

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE `bids` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `buyer_id` int(11) DEFAULT NULL,
  `bid_amount` double DEFAULT NULL,
  `bid_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`id`, `product_id`, `buyer_id`, `bid_amount`, `bid_time`) VALUES
(1, 11, 6, 300, '2025-06-04 17:10:05'),
(2, 11, 7, 350, '2025-06-04 17:15:02'),
(3, 1, 6, 1000, '2025-06-04 19:18:41'),
(4, 1, 8, 1500, '2025-06-04 20:32:32'),
(5, 2, 12, 700, '2025-06-05 07:51:34'),
(6, 2, 6, 1000, '2025-06-05 07:56:29');

-- --------------------------------------------------------

--
-- Table structure for table `buyer_wallet`
--

CREATE TABLE `buyer_wallet` (
  `buyer_id` int(11) NOT NULL,
  `balance` double DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buyer_wallet`
--

INSERT INTO `buyer_wallet` (`buyer_id`, `balance`) VALUES
(6, 2000),
(7, 1150),
(8, 1500),
(12, 3000);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `start_price` double DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` datetime NOT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `seller_id`, `name`, `description`, `start_price`, `start_time`, `end_time`, `status`) VALUES
(1, 1, 'Antique Violin', '1940s handmade violin, slight wear, vintage collectors item', 900, '2025-06-04 16:35:58', '2025-06-04 22:35:00', 'sold'),
(2, 1, 'Brass Table Clock (Vintage)', 'Made in Germany, hand-wound mechanism, still working', 400, '2025-06-04 16:36:40', '2025-06-04 22:38:00', 'approved'),
(3, 2, 'Old Transistor Radio', '1980s portable radio, working condition, very rare', 350, '2025-06-04 16:37:49', '2025-06-04 22:41:00', 'pending'),
(4, 2, 'Vintage Film Camera', 'Kodak Brownie model, collectable item, lens in good shape', 750, '2025-06-04 16:38:25', '2025-06-04 22:44:00', 'pending'),
(5, 3, 'Classic Leather Briefcase', 'Real leather, pre-owned, from 1970s, great condition', 650, '2025-06-04 16:39:26', '2025-06-04 22:46:00', 'pending'),
(6, 3, 'Coin Collection Set', '10 rare Indian & Bangladeshi coins from 1950-1971', 350, '2025-06-04 16:40:22', '2025-06-04 22:53:00', 'pending'),
(7, 4, 'Hand-Painted Scroll Art', 'Traditional Bengali scroll painting (patachitra style), 2ft x 1ft', 280, '2025-06-04 16:41:35', '2025-06-04 22:58:00', 'pending'),
(8, 4, 'Small Brass Telescope (Decorative)', 'Table-top collectible telescope, handmade finish', 450, '2025-06-04 16:42:23', '2025-06-04 23:01:00', 'pending'),
(9, 5, 'Vintage Projector', 'Manual reel film projector, slightly damaged, for decor', 850, '2025-06-04 16:50:15', '2025-06-04 23:16:00', 'pending'),
(10, 5, 'Old Sewing Machine', 'Singer brand 1965 hand-crank sewing machine, still operational', 550, '2025-06-04 16:51:39', '2025-06-04 23:20:00', 'pending'),
(11, 11, 'Vintage Gramophone Record', 'Original Rabindranath Tagore songs record, shellac disc', 250, '2025-06-04 16:59:36', '2025-06-04 23:03:00', 'sold'),
(12, 11, 'Classic Pocket Compass', '1950s brass compass, still working, with glass lid', 350, '2025-06-04 17:00:37', '2025-06-05 00:04:00', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `seller_wallet`
--

CREATE TABLE `seller_wallet` (
  `seller_id` int(11) NOT NULL,
  `balance` double DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seller_wallet`
--

INSERT INTO `seller_wallet` (`seller_id`, `balance`) VALUES
(1, 2000),
(11, 350);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('buyer','seller','admin') DEFAULT NULL,
  `status` enum('active','blocked') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `status`) VALUES
(1, 'Tanvir', 'tanvir@gmail.com', 'tanvir123', 'seller', 'active'),
(2, 'Mahfuz', 'mahfuz@gmail.com', 'mahfuz123', 'seller', 'active'),
(3, 'Rashed', 'rashed@gmail.com', 'rashed123', 'seller', 'active'),
(4, 'Mamun', 'mamun@gmail.com', 'mamun123', 'seller', 'active'),
(5, 'Shahin', 'shahin@gmail.com', 'shahin123', 'seller', 'active'),
(6, 'Arif', 'arif@gmail.com', 'arif123', 'buyer', 'active'),
(7, 'Jamil', 'jamil@gmail.com', 'jamil123', 'buyer', 'active'),
(8, 'Nasir', 'nasir@gmail.com', 'nasir123', 'buyer', 'active'),
(9, 'Rifat', 'rifat@gmail.com', 'rifat123', 'buyer', 'active'),
(10, 'Sabbir', 'sabbir@gmail.com', 'sabbir123', 'buyer', 'active'),
(11, 'Joy', 'joy@gmail.com', 'joy123', 'seller', 'active'),
(12, 'Nirob', 'nirob@gmail.com', 'nirob123', 'buyer', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `auction_winners`
--
ALTER TABLE `auction_winners`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_product` (`product_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `buyer_wallet`
--
ALTER TABLE `buyer_wallet`
  ADD PRIMARY KEY (`buyer_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `seller_wallet`
--
ALTER TABLE `seller_wallet`
  ADD PRIMARY KEY (`seller_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `buyer_id` (`buyer_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auction_winners`
--
ALTER TABLE `auction_winners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auction_winners`
--
ALTER TABLE `auction_winners`
  ADD CONSTRAINT `auction_winners_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `auction_winners_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `bids`
--
ALTER TABLE `bids`
  ADD CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `buyer_wallet`
--
ALTER TABLE `buyer_wallet`
  ADD CONSTRAINT `buyer_wallet_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `seller_wallet`
--
ALTER TABLE `seller_wallet`
  ADD CONSTRAINT `seller_wallet_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
