-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2026 at 10:04 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ctrl_alt_deliver`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 2, '2026-05-17 04:15:00', '2026-05-19 08:45:00'),
(2, 3, '2026-05-18 03:30:00', '2026-05-19 10:00:00'),
(3, 4, '2026-05-19 02:15:00', '2026-05-19 10:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cart_item_id`, `cart_id`, `product_id`, `quantity`, `added_at`, `updated_at`) VALUES
(1, 1, 7, 1, '2026-05-17 04:20:00', '2026-05-17 04:20:00'),
(2, 1, 12, 1, '2026-05-17 04:25:00', '2026-05-19 08:45:00'),
(3, 2, 6, 1, '2026-05-18 03:35:00', '2026-05-18 03:35:00'),
(4, 2, 9, 1, '2026-05-18 03:40:00', '2026-05-18 03:40:00'),
(5, 2, 10, 1, '2026-05-18 03:45:00', '2026-05-19 10:00:00'),
(6, 3, 1, 1, '2026-05-19 02:20:00', '2026-05-19 02:20:00'),
(7, 3, 4, 2, '2026-05-19 02:25:00', '2026-05-19 10:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`, `image`, `created_at`, `updated_at`) VALUES
(1, 'CPUs & Processors', 'Desktop and laptop processors from Intel, AMD, and more.', 'resources/categories/cpus.webp', '2026-05-18 20:04:46', '2026-05-18 20:04:46'),
(2, 'Graphics Cards', 'GPUs for gaming, content creation, and professional workloads.', 'resources/categories/graphics_cards.webp', '2026-05-18 20:04:46', '2026-05-18 20:04:46'),
(3, 'HDD & Storage', 'Hard drives, SSDs, NVMe drives, and portable storage solutions.', 'resources/categories/storage.webp', '2026-05-18 20:04:46', '2026-05-18 20:04:46'),
(4, 'Motherboards', 'ATX, Micro-ATX, and Mini-ITX motherboards for every build.', 'resources/categories/motherboards.webp', '2026-05-18 20:04:46', '2026-05-18 20:04:46'),
(5, 'Cooling', 'Air coolers, liquid AIOs, case fans, and thermal compounds.', 'resources/categories/cooling.webp', '2026-05-18 20:04:46', '2026-05-18 20:04:46'),
(6, 'Power Supplies', 'Modular and non-modular PSUs ranging from 450W to 1600W.', 'resources/categories/psus.webp', '2026-05-18 20:04:46', '2026-05-18 20:04:46'),
(7, 'Memory', 'DDR4 and DDR5 RAM kits for gaming, workstations, and laptops.', 'resources/categories/memory.webp', '2026-05-18 20:04:46', '2026-05-18 20:04:46');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `shipping_fee` decimal(10,2) DEFAULT 0.00,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `grand_total` decimal(10,2) DEFAULT NULL,
  `order_status` varchar(50) DEFAULT 'Pending',
  `payment_status` varchar(50) DEFAULT 'Pending',
  `shipment_status` varchar(50) DEFAULT 'Pending',
  `shipping_address` text DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `subtotal`, `shipping_fee`, `discount_amount`, `grand_total`, `order_status`, `payment_status`, `shipment_status`, `shipping_address`, `order_date`) VALUES
(1, 2, 32999.00, 200.00, 3299.90, 29899.10, 'Completed', 'Paid', 'Delivered', 'Bhaktapur Durbar Square Area, Bhaktapur 44800', '2026-01-10 05:15:00'),
(2, 2, 18999.00, 200.00, 2849.85, 16349.15, 'Completed', 'Paid', 'Delivered', 'Bhaktapur Durbar Square Area, Bhaktapur 44800', '2026-02-14 07:45:00'),
(3, 2, 79999.00, 500.00, 0.00, 80499.00, 'Completed', 'Paid', 'Delivered', 'Bhaktapur Durbar Square Area, Bhaktapur 44800', '2026-03-05 04:00:00'),
(4, 3, 42999.00, 300.00, 2149.95, 41149.05, 'Completed', 'Paid', 'Delivered', 'Naya Bazaar, Pokhara 33700', '2026-02-20 04:15:00'),
(5, 3, 34999.00, 300.00, 0.00, 35299.00, 'Completed', 'Paid', 'Delivered', 'Naya Bazaar, Pokhara 33700', '2026-03-18 08:15:00'),
(6, 3, 23999.00, 300.00, 0.00, 24299.00, 'Processing', 'Paid', 'Processing', 'Naya Bazaar, Pokhara 33700', '2026-05-15 02:45:00'),
(7, 4, 29999.00, 200.00, 0.00, 30199.00, 'Completed', 'Paid', 'Delivered', 'Lakeside Road, Pokhara 33700', '2026-01-25 10:15:00'),
(8, 4, 62999.00, 500.00, 6299.90, 57199.10, 'Completed', 'Paid', 'Delivered', 'Lakeside Road, Pokhara 33700', '2026-04-02 06:15:00'),
(9, 4, 18999.00, 200.00, 0.00, 19199.00, 'Shipped', 'Paid', 'Shipped', 'Lakeside Road, Pokhara 33700', '2026-05-10 04:30:00'),
(10, 2, 15999.00, 200.00, 0.00, 16199.00, 'Pending', 'Pending', 'Pending', 'Bhaktapur Durbar Square Area, Bhaktapur 44800', '2026-05-19 09:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 1, 1, 32999.00, 32999.00),
(2, 2, 3, 1, 18999.00, 18999.00),
(3, 3, 7, 1, 79999.00, 79999.00),
(4, 4, 6, 1, 42999.00, 42999.00),
(5, 5, 20, 1, 34999.00, 34999.00),
(6, 6, 11, 1, 23999.00, 23999.00),
(7, 7, 8, 1, 29999.00, 29999.00),
(8, 8, 14, 1, 62999.00, 62999.00),
(9, 9, 12, 1, 18999.00, 18999.00),
(10, 10, 17, 1, 15999.00, 15999.00),
(11, 4, 9, 1, 34999.00, 34999.00),
(12, 3, 12, 2, 18999.00, 37998.00),
(13, 7, 15, 1, 17999.00, 17999.00),
(14, 8, 10, 1, 21999.00, 21999.00),
(15, 2, 5, 1, 12999.00, 12999.00),
(16, 1, 4, 1, 14999.00, 14999.00),
(17, 5, 17, 1, 15999.00, 15999.00),
(18, 6, 12, 1, 18999.00, 18999.00);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT 'Pending',
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `payment_method`, `transaction_id`, `amount`, `payment_status`, `payment_date`) VALUES
(1, 1, 'eSewa', 'ESW-20260110-84721', 29899.10, 'Completed', '2026-01-10 05:20:00'),
(2, 2, 'Khalti', 'KHL-20260214-33092', 16349.15, 'Completed', '2026-02-14 07:50:00'),
(3, 3, 'Bank Transfer', 'BNK-20260305-10043', 80499.00, 'Completed', '2026-03-05 04:15:00'),
(4, 4, 'eSewa', 'ESW-20260220-91823', 41149.05, 'Completed', '2026-02-20 04:20:00'),
(5, 5, 'Khalti', 'KHL-20260318-55671', 35299.00, 'Completed', '2026-03-18 08:25:00'),
(6, 6, 'eSewa', 'ESW-20260515-72910', 24299.00, 'Completed', '2026-05-15 02:50:00'),
(7, 7, 'Cash on Delivery', NULL, 30199.00, 'Completed', '2026-01-28 06:15:00'),
(8, 8, 'eSewa', 'ESW-20260402-48830', 57199.10, 'Completed', '2026-04-02 06:20:00'),
(9, 9, 'Khalti', 'KHL-20260510-29941', 19199.00, 'Completed', '2026-05-10 04:35:00'),
(10, 10, 'eSewa', NULL, 16199.00, 'Pending', '2026-05-19 09:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount_percent` decimal(5,2) DEFAULT 0.00,
  `stock_quantity` int(11) DEFAULT 0,
  `image_path` varchar(255) DEFAULT NULL,
  `status` enum('InStock','OutOfStock') DEFAULT 'InStock',
  `tag` enum('NEW','BESTSELLER','LIMITED','DISCOUNT') DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `name`, `brand`, `description`, `price`, `discount_percent`, `stock_quantity`, `image_path`, `status`, `tag`, `is_featured`, `created_at`, `updated_at`) VALUES
(1, NULL, 'WH-1000XM5 Wireless Headphones', 'Sony', 'Industry-leading noise cancelling with 30h battery life and multipoint connection.', 32999.00, 10.00, 45, 'resources/products/sony_xm5.webp', 'InStock', 'BESTSELLER', 1, '2025-01-05 03:15:00', '2026-05-18 19:47:07'),
(2, NULL, 'QuietComfort 45 Headphones', 'Bose', 'Acclaimed noise cancelling headphones with TriPort acoustic architecture.', 29999.00, 0.00, 30, 'resources/products/bose_qc45.webp', 'InStock', NULL, 0, '2025-01-05 03:25:00', '2026-05-18 19:47:19'),
(3, NULL, 'Galaxy Buds2 Pro', 'Samsung', '360 audio, intelligent ANC, and IPX7 water resistance in a compact form.', 18999.00, 15.00, 60, 'resources/products/galaxy_buds2.webp', 'InStock', 'DISCOUNT', 1, '2025-01-06 04:15:00', '2026-05-18 19:47:07'),
(4, NULL, 'Soundcore Motion X600 Speaker', 'Anker', 'Spatial audio with 50W output and hi-res certification. IPX7 waterproof.', 14999.00, 5.00, 25, 'resources/products/anker_motion.webp', 'InStock', 'BESTSELLER', 1, '2025-01-07 05:15:00', '2026-05-18 19:47:07'),
(5, NULL, 'MX Keys Advanced Keyboard', 'Logitech', 'Smart illuminated wireless keyboard with perfect stroke keys and USB-C charging.', 12999.00, 0.00, 80, 'resources/products/logitech_mxkeys.webp', 'InStock', 'BESTSELLER', 1, '2025-01-08 03:45:00', '2026-05-18 19:47:07'),
(6, 1, 'Ryzen 5 7600X Processor', 'AMD', '6-core 12-thread AM5 processor with 4.7GHz base and 5.3GHz boost clock. 105W TDP, PCIe 5.0 support.', 42999.00, 5.00, 40, 'resources/products/sony_xm5.webp', 'InStock', 'BESTSELLER', 1, '2026-05-18 20:08:15', '2026-05-18 20:08:15'),
(7, 2, 'GeForce RTX 4060 Ti 16GB', 'MSI', 'Ada Lovelace GPU with 16GB GDDR6, DLSS 3, ray tracing, and dual-fan VENTUS 2X cooling.', 79999.00, 0.00, 22, 'resources/products/bose_qc45.webp', 'InStock', 'BESTSELLER', 1, '2026-05-18 20:08:15', '2026-05-18 20:08:15'),
(8, 3, 'Samsung 990 Pro NVMe SSD 2TB', 'Samsung', 'PCIe 4.0 M.2 SSD with 7450MB/s read and 6900MB/s write. Ideal for gaming and creative workloads.', 29999.00, 8.00, 55, 'resources/products/galaxy_buds2.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:08:25'),
(9, 4, 'MAG B650 TOMAHAWK WiFi Motherboard', 'MSI', 'AMD B650 ATX board for AM5 CPUs. PCIe 5.0 slot, DDR5, 2.5G LAN, WiFi 6E, USB 3.2 Gen 2.', 34999.00, 0.00, 18, 'resources/products/anker_motion.webp', 'InStock', 'NEW', 1, '2026-05-18 20:08:15', '2026-05-18 20:08:15'),
(10, 5, 'Arctic Liquid Freezer III 360 AIO', 'Arctic', '360mm all-in-one liquid cooler with three 120mm P-fans, VRM fan header, and zero-RPM mode.', 21999.00, 0.00, 30, 'resources/products/logitech_mxkeys.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:08:28'),
(11, 6, 'RM850e 850W 80+ Gold PSU', 'Corsair', 'Fully modular 80 Plus Gold PSU with ATX 3.0 and PCIe 5.0 native 12VHPWR connector. 10yr warranty.', 23999.00, 0.00, 35, 'resources/products/sony_xm5.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:08:30'),
(12, 7, 'Vengeance DDR5 32GB 6000MHz Kit', 'Corsair', '2×16GB DDR5-6000 CL36 dual-channel memory kit. Intel XMP 3.0 and AMD EXPO certified.', 18999.00, 5.00, 60, 'resources/products/bose_qc45.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:08:33'),
(13, 1, 'Core i7-14700K Processor', 'Intel', '20-core (8P+12E) LGA1700 processor, 5.6GHz max turbo, 125W TDP, DDR4/DDR5 compatible.', 64999.00, 0.00, 25, 'resources/products/galaxy_buds2.webp', 'InStock', 'NEW', 1, '2026-05-18 20:08:15', '2026-05-18 20:08:15'),
(14, 2, 'Radeon RX 7700 XT 12GB', 'Sapphire', 'RDNA3 GPU with 12GB GDDR6, 245W TDP, DisplayPort 2.1, and NITRO+ dual-BIOS triple-fan design.', 62999.00, 10.00, 15, 'resources/products/anker_motion.webp', 'InStock', 'DISCOUNT', 1, '2026-05-18 20:08:15', '2026-05-18 20:08:15'),
(15, 3, 'WD Black SN850X NVMe SSD 1TB', 'Western Digital', 'PCIe 4.0 NVMe SSD optimized for PlayStation 5 and PC gaming. 7300MB/s read, heatsink included.', 17999.00, 0.00, 70, 'resources/products/logitech_mxkeys.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:08:38'),
(16, 4, 'ROG STRIX B760-F Gaming WiFi', 'ASUS', 'Intel B760 ATX board for LGA1700. DDR5, PCIe 5.0 M.2, Thunderbolt 4, 2.5G LAN, WiFi 6E.', 39999.00, 0.00, 20, 'resources/products/sony_xm5.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:08:40'),
(17, 5, 'Noctua NH-D15 G2 CPU Cooler', 'Noctua', 'Dual-tower air cooler with 6 heatpipes and two 150mm NF-A15 fans. Up to 250W TDP, LGA1700 ready.', 15999.00, 0.00, 28, 'resources/products/bose_qc45.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:08:43'),
(18, 6, 'Dark Power Pro 13 1000W PSU', 'be quiet!', 'Flagship 80 Plus Titanium fully modular PSU with ATX 3.0, silent 135mm fan, and 5yr warranty.', 37999.00, 0.00, 12, 'resources/products/galaxy_buds2.webp', 'InStock', 'LIMITED', 1, '2026-05-18 20:08:15', '2026-05-18 20:08:46'),
(19, 7, 'Trident Z5 RGB DDR5 64GB 6400MHz Kit', 'G.Skill', '2×32GB DDR5-6400 CL32 kit with RGB lighting, Intel XMP 3.0, and AMD EXPO support.', 34999.00, 0.00, 20, 'resources/products/anker_motion.webp', 'InStock', NULL, 0, '2026-05-18 20:08:15', '2026-05-18 20:10:01'),
(20, 2, 'Arc B580 12GB Graphics Card', 'Intel', 'Xe2 architecture GPU with 12GB GDDR6, hardware ray tracing, XeSS upscaling, and DP 2.1 output.', 34999.00, 0.00, 33, 'resources/products/logitech_mxkeys.webp', 'InStock', 'NEW', 1, '2026-05-18 20:08:15', '2026-05-18 20:08:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `image_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_primary` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`image_id`, `product_id`, `image_path`, `is_primary`) VALUES
(1, 1, 'resources/products/sony_xm5.webp', 1),
(2, 1, 'resources/products/sony_xm5_side.webp', 0),
(3, 2, 'resources/products/bose_qc45_2.webp', 0),
(4, 2, 'resources/products/bose_qc45.webp', 1),
(5, 2, 'resources/products/bose_qc45_open.webp', 0),
(6, 3, 'resources/products/galaxy_buds2.webp', 1),
(7, 3, 'resources/products/galaxy_buds2_case.webp', 0),
(8, 5, 'resources/products/logitech_mxkeys.webp', 1),
(9, 5, 'resources/products/logitech_mxkeys_top.webp', 0),
(10, 4, 'resources/products/anker_motion.webp', 1),
(11, 4, 'resources/products/anker_motion_top.webp', 0),
(21, 6, 'resources/products/sony_xm5.webp', 1),
(22, 6, 'resources/products/sony_xm5_side.webp', 0),
(23, 7, 'resources/products/bose_qc45_2.webp', 1),
(24, 7, 'resources/products/bose_qc45.webp', 0),
(25, 8, 'resources/products/galaxy_buds2.webp', 1),
(26, 8, 'resources/products/galaxy_buds2_case.webp', 0),
(27, 9, 'resources/products/logitech_mxkeys.webp', 1),
(28, 9, 'resources/products/logitech_mxkeys_top.webp', 0),
(29, 10, 'resources/products/logitech_mxkeys.webp', 1),
(30, 10, 'resources/products/logitech_mxkeys_top.webp', 0),
(31, 11, 'resources/products/bose_qc45_2.webp', 1),
(32, 11, 'resources/products/bose_qc45_open.webp', 0),
(33, 12, 'resources/products/anker_motion.webp', 1),
(34, 12, 'resources/products/anker_motion.webp', 0),
(35, 13, 'resources/products/galaxy_buds2.webp', 1),
(36, 13, 'resources/products/galaxy_buds2_case.webp', 0),
(37, 14, 'resources/products/logitech_mxkeys.webp', 1),
(38, 14, 'resources/products/logitech_mxkeys_top.webp', 0),
(39, 15, 'resources/products/bose_qc45_2.webp', 1),
(40, 15, 'resources/products/bose_qc45_open.webp', 0),
(41, 16, 'resources/products/anker_motion.webp', 1),
(42, 16, 'resources/products/anker_motion.webp', 0),
(43, 17, 'resources/products/galaxy_buds2.webp', 1),
(44, 17, 'resources/products/galaxy_buds2_case.webp', 0),
(45, 18, 'resources/products/sony_xm5.webp', 1),
(46, 18, 'resources/products/sony_xm5_side.webp', 0),
(47, 19, 'resources/products/bose_qc45_2.webp', 1),
(48, 19, 'resources/products/bose_qc45.webp', 0),
(49, 20, 'resources/products/galaxy_buds2.webp', 1),
(50, 20, 'resources/products/galaxy_buds2_case.webp', 0);

-- --------------------------------------------------------

--
-- Table structure for table `shipments`
--

CREATE TABLE `shipments` (
  `shipment_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `courier_name` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `shipment_status` varchar(50) DEFAULT 'Processing',
  `shipped_date` date DEFAULT NULL,
  `delivered_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipments`
--

INSERT INTO `shipments` (`shipment_id`, `order_id`, `courier_name`, `tracking_number`, `shipment_status`, `shipped_date`, `delivered_date`) VALUES
(1, 1, 'Sajilo Sewa', 'SS-2026-00101', 'Delivered', '2026-01-11', '2026-01-13'),
(2, 2, 'Bhojdeals', 'BD-2026-00214', 'Delivered', '2026-02-15', '2026-02-17'),
(3, 3, 'Bluedart Nepal', 'BDN-2026-0305', 'Delivered', '2026-03-06', '2026-03-09'),
(4, 4, 'Sajilo Sewa', 'SS-2026-00420', 'Delivered', '2026-02-21', '2026-02-23'),
(5, 5, 'Bhojdeals', 'BD-2026-00318', 'Delivered', '2026-03-19', '2026-03-21'),
(6, 6, 'Bluedart Nepal', 'BDN-2026-0515', 'Processing', NULL, NULL),
(7, 7, 'Cash on Delivery', 'COD-2026-0125', 'Delivered', '2026-01-25', '2026-01-28'),
(8, 8, 'Sajilo Sewa', 'SS-2026-00802', 'Delivered', '2026-04-03', '2026-04-06'),
(9, 9, 'Bluedart Nepal', 'BDN-2026-0510', 'Shipped', '2026-05-11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('ADMIN','MEMBER') DEFAULT 'MEMBER',
  `profile_image` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone`, `password_hash`, `role`, `profile_image`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Alex Rivera', 'alex.rivera@ctrlaltdeliver.com', '+977-9841100001', '$2a$10$66SYemUd3Z3vIrmtPQZqhubMOkiAJmtTmt/sjQVvrXsJ03xLF79li', 'ADMIN', 'profiles/alex.jpg', NULL, '2025-01-01 08:00:00', '2026-05-19 06:31:41'),
(2, 'Nisha Karki', 'nisha.karki@outlook.com', '+977-9845679876', '$2a$10$66SYemUd3Z3vIrmtPQZqhubMOkiAJmtTmt/sjQVvrXsJ03xLF79li', 'MEMBER', 'profiles/nisha.jpg', 'Bhaktapur Durbar Square Area, Bhaktapur 44800', '2025-04-10 15:00:00', '2026-05-19 16:52:10'),
(3, 'Pranish Poudel', 'pranish.poudel.s25@icp.edu.np', '9816161302', '$2a$10$66SYemUd3Z3vIrmtPQZqhubMOkiAJmtTmt/sjQVvrXsJ03xLF79li', 'MEMBER', NULL, NULL, '2026-05-18 10:20:43', '2026-05-19 16:59:31'),
(4, 'Deepak Poudel', 'reachdeepakhere@gmail.com', '9840454840', '$2a$10$z6M2Uas47Ut.0EDxTaFAK.frThMnk0wMmpjh0xJYwQ1BUN4GC3Siq', 'MEMBER', NULL, NULL, '2026-05-18 10:24:25', '2026-05-19 16:52:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `idx_cart_user` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `idx_cart_items_cart` (`cart_id`),
  ADD KEY `idx_cart_items_product` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `idx_orders_user` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `idx_order_items_order` (`order_id`),
  ADD KEY `idx_order_items_product` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `idx_payments_order` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `idx_products_category` (`category_id`),
  ADD KEY `idx_products_status` (`status`),
  ADD KEY `idx_products_featured` (`is_featured`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `idx_product_images_product` (`product_id`);

--
-- Indexes for table `shipments`
--
ALTER TABLE `shipments`
  ADD PRIMARY KEY (`shipment_id`),
  ADD KEY `idx_shipments_order` (`order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `shipments`
--
ALTER TABLE `shipments`
  MODIFY `shipment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `fk_cart_items_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cart_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_product_images_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `shipments`
--
ALTER TABLE `shipments`
  ADD CONSTRAINT `fk_shipments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
