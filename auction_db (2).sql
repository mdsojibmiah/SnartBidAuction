-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2025 at 02:39 PM
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
(1, 1, 12, 50050, '2025-06-04 10:58:20'),
(7, 2, 3, 400050, '2025-06-04 11:02:40'),
(9, 4, 11, 1700000, '2025-06-04 11:52:51'),
(10, 5, 11, 1000000, '2025-06-04 11:55:44'),
(11, 16, 3, 30000, '2025-06-04 11:59:51'),
(12, 3, 3, 80000, '2025-06-04 12:15:25');

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
(1, 2, 3, 400050, '2025-06-04 05:33:02'),
(2, 1, 12, 50050, '2025-06-04 07:00:22'),
(3, 4, 9, 150090, '2025-06-04 11:50:32'),
(4, 4, 11, 160000, '2025-06-04 11:51:47'),
(5, 4, 11, 1700000, '2025-06-04 11:52:16'),
(6, 5, 11, 90000, '2025-06-04 11:55:12'),
(7, 5, 11, 1000000, '2025-06-04 11:55:27'),
(8, 16, 3, 10000, '2025-06-04 11:58:51'),
(9, 16, 3, 20000, '2025-06-04 11:59:03'),
(10, 16, 3, 30000, '2025-06-04 11:59:14'),
(11, 3, 15, 70000, '2025-06-04 12:11:31'),
(12, 3, 3, 80000, '2025-06-04 12:15:14');

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
(3, 980946989),
(5, 500),
(11, 98995678977),
(15, 990987655789),
(19, 1500);

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
(1, 2, 'Apple iPhone 1st Gen (2007)', 'First generation iPhone in mint condition. Collector’s item.', 50000, '2025-06-04 05:24:43', '2025-06-07 11:24:43', 'sold'),
(2, 2, 'Rare Sony Walkman NW-ZX2', 'High-res audio player, extremely rare in perfect condition.', 40000, '2025-06-04 05:24:43', '2025-06-08 11:24:43', 'sold'),
(3, 2, 'Samsung Galaxy Fold Prototype', 'First generation Galaxy Fold prototype device.', 60000, '2025-06-04 05:24:43', '2025-06-06 11:24:43', 'sold'),
(4, 4, 'Vintage Rolex Submariner 1960', 'Classic Rolex wristwatch, perfect for collectors.', 150000, '2025-06-04 05:25:32', '2025-06-09 11:25:32', 'sold'),
(5, 4, 'Classic Wooden Gramophone', 'Antique gramophone with working horn, early 1900s.', 80000, '2025-06-04 05:25:32', '2025-06-07 11:25:32', 'sold'),
(6, 4, 'Nokia 3310 (Unopened Box)', 'Original packaging, never used. Legendary phone.', 25000, '2025-06-04 05:25:32', '2025-06-06 11:25:32', 'approved'),
(7, 6, 'Vintage Typewriter – Remington', 'Fully working, excellent condition, 1930s model.', 45000, '2025-06-04 05:25:56', '2025-06-08 11:25:56', 'approved'),
(8, 6, '1950s Coca-Cola Vending Machine', 'Restored vintage vending machine. Rare piece.', 120000, '2025-06-04 05:25:56', '2025-06-09 11:25:56', 'approved'),
(9, 6, 'Polaroid SX-70 Land Camera', 'Classic instant camera in great shape with original box.', 35000, '2025-06-04 05:25:56', '2025-06-07 11:25:56', 'approved'),
(10, 8, 'Limited Edition Tesla Roadster Diecast Model', '1:18 scale diecast, limited edition Tesla Roadster.', 30000, '2025-06-04 05:26:18', '2025-06-07 11:26:18', 'approved'),
(11, 8, 'OnePlus Concept One (McLaren Edition)', 'Rare concept phone with disappearing camera.', 70000, '2025-06-04 05:26:18', '2025-06-06 11:26:18', 'approved'),
(12, 8, 'Macintosh Classic II (1991)', 'Working Apple Macintosh from early 90s.', 50000, '2025-06-04 05:26:18', '2025-06-08 11:26:18', 'approved'),
(13, 10, 'Vintage Gold Pocket Watch (1890)', 'Hand-crafted antique gold pocket watch.', 200000, '2025-06-04 05:26:40', '2025-06-09 11:26:40', 'approved'),
(14, 10, 'Signed First Edition – Sherlock Holmes', 'First edition book signed by Arthur Conan Doyle.', 300000, '2025-06-04 05:26:40', '2025-06-10 11:26:40', 'approved'),
(15, 10, 'Rare Vinyl – The Beatles White Album', 'Limited press with original inserts and cover.', 90000, '2025-06-04 05:26:40', '2025-06-07 11:26:40', 'rejected'),
(16, 2, 'Sony WH-1000XM5 Headphones', 'Noise Cancelling Wireless Headphones with 30-hour battery life.', 980, '2025-06-04 07:09:02', '2025-06-05 12:00:00', 'sold'),
(17, 2, 'Laptop', 'asdfg', 200, '2025-06-04 12:26:50', '2025-06-04 18:26:00', NULL),
(18, 1, 'Laptopqwasdfgh', 'Szfdxgfcgvh', 200, '2025-06-04 12:35:45', '2025-06-04 18:55:00', 'approved'),
(19, 1, 'Phone', 'phone xcvbnm', 200, '2025-06-04 12:37:39', '2025-06-05 18:37:00', 'approved');

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
(2, 80000),
(5, 2000),
(19, 1500);

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
  `status` enum('active','blocked') DEFAULT 'active',
  `wallet` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `status`, `wallet`) VALUES
(1, 'Admin', 'admin@gmail.com', 'admin123', 'admin', 'active', 0.00),
(2, 'TechMart', 'techmart@gmail.com', 'techmart123', 'seller', 'active', 0.00),
(3, 'Rahim', 'rahim@gmail.com', 'rahim123', 'buyer', 'active', 0.00),
(4, 'ClassicStore', 'classicstore@gmail.com', 'classicstore123', 'seller', 'active', 0.00),
(5, 'Alif', 'alif@gmail.com', 'alif123', 'buyer', 'active', 0.00),
(6, 'VintageHub', 'vintagehub@gmail.com', 'vintagehub123', 'seller', 'active', 0.00),
(7, 'Sakib', 'sakib@gmail.com', 'sakib123', 'buyer', 'active', 0.00),
(8, 'SmartSeller', 'smartseller@gmail.com', 'smartseller123', 'seller', 'active', 0.00),
(9, 'Tarek', 'tarek@gmail.com', 'tarek123', 'buyer', 'active', 0.00),
(10, 'OldGold', 'oldgold@gmail.com', 'oldgold123', 'seller', 'active', 0.00),
(11, 'Nayeem', 'nayeem@gmail.com', 'nayeem123', 'buyer', 'active', 0.00),
(12, 'Rakib', 'rakib@gmail.com', '1145', 'buyer', 'active', 50000000.00),
(13, 'Mamun', 'mamun@gmail.com', '4321', 'buyer', 'active', 0.00),
(14, 'Joy', 'joy@gmail.com', 'joy123', 'buyer', 'active', 0.00),
(15, 'Error', 'error@gmail.com', 'error123', 'buyer', 'active', 0.00),
(16, 'Nafi', 'nafi@gmail.com', 'nafi123', 'buyer', 'active', 0.00),
(17, 'Aditta', 'aditta@gmail.com', 'aditta123', 'buyer', 'active', 0.00),
(18, 'Demo', 'demo@gmail.com', 'demon123', 'buyer', 'active', 0.00),
(19, 'abc', 'abc@gmail.com', 'abc123', 'seller', 'active', 0.00);

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `auction_winners`
--
ALTER TABLE `auction_winners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

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
