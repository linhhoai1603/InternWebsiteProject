-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Create user_logs table
CREATE TABLE user_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    description TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
); 

-- Dumping database structure for project_web
CREATE DATABASE IF NOT EXISTS `project_web` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `project_web`;

-- Dumping structure for table project_web.account_users
CREATE TABLE IF NOT EXISTS `account_users` (
                                               `id` int(11) NOT NULL AUTO_INCREMENT,
    `idUser` int(11) NOT NULL,
    `username` varchar(255) NOT NULL,
    `password` varchar(512) NOT NULL,
    `idRole` int(11) NOT NULL,
    `locked` tinyint(4) NOT NULL,
    `code` int(11) DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `account_users_iduser_foreign` (`idUser`) USING BTREE,
    KEY `account_users_role_id_foreign_idx` (`idRole`) USING BTREE,
    CONSTRAINT `account_users_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`),
    CONSTRAINT `account_users_role_id_foreign` FOREIGN KEY (`idRole`) REFERENCES `roles` (`id`) ON UPDATE CASCADE
    ) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.account_users: ~12 rows (approximately)
DELETE FROM `account_users`;
INSERT INTO `account_users` (`id`, `idUser`, `username`, `password`, `idRole`, `locked`, `code`) VALUES
                                                                                                     (1, 1, 'hung', '123', 2, 1, NULL),
                                                                                                     (3, 3, 'khang', '123', 1, 0, NULL),
                                                                                                     (4, 4, 'phamthuy', 'password101', 1, 1, NULL),
                                                                                                     (5, 5, 'hoangtuan', 'password102', 1, 0, NULL),
                                                                                                     (6, 6, 'dinhphuong', 'password103', 1, 0, NULL),
                                                                                                     (7, 7, 'vothanh', 'password104', 1, 0, NULL),
                                                                                                     (8, 8, 'ngothao', 'password105', 1, 0, NULL),
                                                                                                     (9, 9, 'phamgiang', 'password106', 1, 0, NULL),
                                                                                                     (10, 10, 'tranthuy', 'password107', 1, 1, NULL),
                                                                                                     (16, 23, 'linhhoai', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhbGluaGhvYWk3OTY2NTZAIyQlUUAjZmNmdnlnYg==', 2, 0, 529385),
                                                                                                     (18, 27, 'linhhoai123', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhbGluaGhvYWkxMjM3OTY2NTZAIyQlUUAjZmNmdnlnYg==', 2, 0, 0),
                                                                                                     (19, 28, 'linhhoai1', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhbGluaGhvYWkxNzk2NjU2QCMkJVFAI2ZjZnZ5Z2I=', 1, 0, 0);

-- Dumping structure for table project_web.addresses
CREATE TABLE IF NOT EXISTS `addresses` (
                                           `id` int(11) NOT NULL AUTO_INCREMENT,
    `province` varchar(255) NOT NULL,
    `district` varchar(255) NOT NULL,
    `ward` varchar(255) NOT NULL,
    `detail` varchar(255) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.addresses: ~14 rows (approximately)
DELETE FROM `addresses`;
INSERT INTO `addresses` (`id`, `province`, `district`, `ward`, `detail`) VALUES
                                                                             (1, 'Long Bình', 'Đồng Nai', 'Biên Hòa', 'Yết Kiêu'),
                                                                             (2, 'Hà Nội', 'Hà Nội', 'Đống Đa', 'Xã Đàn'),
                                                                             (3, 'Hồ Chí Minh', 'Hồ Chí Minh', 'Quận 1', 'Nguyễn Huệ'),
                                                                             (4, 'Hồ Chí Minh', 'Hồ Chí Minh', 'Quận 3', 'Lê Văn Sỹ'),
                                                                             (5, 'Đà Nẵng', 'Đà Nẵng', 'Hải Châu', 'Nguyễn Văn Linh'),
                                                                             (6, 'Đà Nẵng', 'Đà Nẵng', 'Sơn Trà', 'Võ Nguyên Giáp'),
                                                                             (7, 'Cần Thơ', 'Cần Thơ', 'Ninh Kiều', '30 Tháng 4'),
                                                                             (8, 'Hải Phòng', 'Hải Phòng', 'Lê Chân', 'Trần Nguyên Hãn'),
                                                                             (9, 'Huế', 'Thừa Thiên Huế', 'Phú Hội', 'Hùng Vương'),
                                                                             (10, 'Nha Trang', 'Khánh Hòa', 'Vĩnh Hải', 'Trần Phú'),
                                                                             (11, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh'),
                                                                             (12, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh'),
                                                                             (13, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh'),
                                                                             (14, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh');

-- Dumping structure for table project_web.cart
CREATE TABLE IF NOT EXISTS `cart` (
                                      `id` int(11) NOT NULL AUTO_INCREMENT,
    `idUser` int(11) NOT NULL,
    `idVoucher` int(11) DEFAULT NULL,
    `shippingFee` decimal(15,2) DEFAULT 0.00,
    `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
    `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`),
    KEY `idUser` (`idUser`),
    KEY `idVoucher` (`idVoucher`),
    CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`idVoucher`) REFERENCES `vouchers` (`idVoucher`) ON DELETE SET NULL ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table project_web.cart: ~0 rows (approximately)
DELETE FROM `cart`;

-- Dumping structure for table project_web.cart_items
CREATE TABLE IF NOT EXISTS `cart_items` (
                                            `id` int(11) NOT NULL AUTO_INCREMENT,
    `idCart` int(11) NOT NULL,
    `idStyle` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    `unitPrice` decimal(15,2) NOT NULL,
    `addedAt` datetime NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_cart_item_style` (`idCart`,`idStyle`),
    KEY `idStyle` (`idStyle`),
    CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`idCart`) REFERENCES `cart` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`idStyle`) REFERENCES `styles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table project_web.cart_items: ~0 rows (approximately)
DELETE FROM `cart_items`;

-- Dumping structure for table project_web.categories
CREATE TABLE IF NOT EXISTS `categories` (
                                            `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.categories: ~4 rows (approximately)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `name`) VALUES
                                            (1, 'Vải may mặc'),
                                            (2, 'Vải nội thất'),
                                            (3, 'Nút áo'),
                                            (4, 'Dây kéo');

-- Dumping structure for table project_web.contact_info
CREATE TABLE IF NOT EXISTS `contact_info` (
                                              `id` int(11) NOT NULL AUTO_INCREMENT,
    `idAddress` int(11) DEFAULT NULL,
    `email` varchar(50) NOT NULL,
    `website` varchar(100) DEFAULT NULL,
    `hotline` varchar(50) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `idAddress` (`idAddress`),
    CONSTRAINT `contact_info_ibfk_1` FOREIGN KEY (`idAddress`) REFERENCES `addresses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table project_web.contact_info: ~0 rows (approximately)
DELETE FROM `contact_info`;

-- Dumping structure for table project_web.deliveries
CREATE TABLE IF NOT EXISTS `deliveries` (
                                            `id` int(11) NOT NULL AUTO_INCREMENT,
    `idOrder` int(11) NOT NULL,
    `idAddress` int(11) NOT NULL,
    `fullName` varchar(255) NOT NULL,
    `phoneNumber` varchar(255) NOT NULL,
    `area` double NOT NULL,
    `deliveryFee` double NOT NULL,
    `note` varchar(255) NOT NULL,
    `status` varchar(255) NOT NULL,
    `scheduledDateTime` datetime NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `deliveries_idaddress_foreign` (`idAddress`) USING BTREE,
    CONSTRAINT `deliveries_idaddress_foreign` FOREIGN KEY (`idAddress`) REFERENCES `addresses` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.deliveries: ~27 rows (approximately)
DELETE FROM `deliveries`;
INSERT INTO `deliveries` (`id`, `idOrder`, `idAddress`, `fullName`, `phoneNumber`, `area`, `deliveryFee`, `note`, `status`, `scheduledDateTime`) VALUES
                                                                                                                                                     (1, 1, 2, 'Nguyen Van A', '0901234567', 20.5, 50, 'Giao nhanh', 'Delivered', '2024-12-18 09:00:00'),
                                                                                                                                                     (2, 2, 3, 'Tran Thi B', '0902345678', 15, 40, 'Giao qua app', 'Pending', '2024-12-18 10:30:00'),
                                                                                                                                                     (3, 3, 4, 'Le Minh C', '0903456789', 25, 60, 'Khuyến mãi', 'Cancelled', '2024-12-18 12:00:00'),
                                                                                                                                                     (4, 4, 5, 'Pham Thi D', '0904567890', 18, 45, 'Giao tận nơi', 'In transit', '2024-12-18 14:00:00'),
                                                                                                                                                     (5, 5, 6, 'Hoang Minh E', '0905678901', 22.5, 55, 'Giao vào buổi tối', 'Delivered', '2024-12-18 17:30:00'),
                                                                                                                                                     (6, 6, 2, 'Nguyen Van A', '0901234567', 20.5, 50, 'Giao nhanh', 'Delivered', '2024-12-18 09:00:00'),
                                                                                                                                                     (7, 7, 3, 'Tran Thi B', '0902345678', 15, 40, 'Giao qua app', 'Pending', '2024-12-18 10:30:00'),
                                                                                                                                                     (8, 8, 4, 'Le Minh C', '0903456789', 25, 60, 'Khuyến mãi', 'Cancelled', '2024-12-18 12:00:00'),
                                                                                                                                                     (9, 9, 5, 'Pham Thi D', '0904567890', 18, 45, 'Giao tận nơi', 'In transit', '2024-12-18 14:00:00'),
                                                                                                                                                     (10, 10, 6, 'Hoang Minh E', '0905678901', 22.5, 55, 'Giao vào buổi tối', 'Delivered', '2024-12-18 17:30:00'),
                                                                                                                                                     (11, 17, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 07:49:53'),
                                                                                                                                                     (12, 18, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 07:53:00'),
                                                                                                                                                     (13, 19, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 07:56:59'),
                                                                                                                                                     (14, 20, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 08:00:12'),
                                                                                                                                                     (15, 21, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 08:01:05'),
                                                                                                                                                     (16, 24, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-10 09:02:44'),
                                                                                                                                                     (17, 25, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-10 09:06:41'),
                                                                                                                                                     (18, 30, 12, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, 'giao hàng lúc 9 giờ', 'Đang giao hàng', '2025-01-10 23:17:58'),
                                                                                                                                                     (19, 31, 13, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, 'hehe', 'Đang giao hàng', '2025-01-11 18:27:46'),
                                                                                                                                                     (20, 32, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, '', 'Đang giao hàng', '2025-01-13 14:45:45'),
                                                                                                                                                     (21, 33, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-13 15:36:09'),
                                                                                                                                                     (22, 34, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, '', 'Đang giao hàng', '2025-01-14 09:27:54'),
                                                                                                                                                     (23, 35, 14, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, 'Giao hàng trong ngày mai', 'Đang giao hàng', '2025-01-14 22:24:11'),
                                                                                                                                                     (24, 36, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-14 23:01:22'),
                                                                                                                                                     (25, 37, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-14 23:02:12'),
                                                                                                                                                     (26, 38, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-14 23:04:01'),
                                                                                                                                                     (27, 39, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-15 10:23:00');

-- Dumping structure for table project_web.message
CREATE TABLE IF NOT EXISTS `message` (
                                         `id` int(11) NOT NULL AUTO_INCREMENT,
    `idUser` int(11) DEFAULT NULL,
    `title` varchar(255) NOT NULL,
    `content` varchar(255) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `message_iduser_foreign` (`idUser`) USING BTREE,
    CONSTRAINT `message_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.message: ~8 rows (approximately)
DELETE FROM `message`;
INSERT INTO `message` (`id`, `idUser`, `title`, `content`) VALUES
                                                               (1, 1, 'title', 'content'),
                                                               (2, 2, 'Tư vấn vải mùa đông', 'Toi muon mua vai'),
                                                               (3, 2, 'Tư vấn vải mùa đông', 'Toi muon mua vai'),
                                                               (4, 2, 'Tư vấn vải mùa đông', 'Mua vai mua dong'),
                                                               (5, 23, 'Tư vấn vải mùa đông', 'hehe'),
                                                               (6, 23, 'Tư vấn vải mùa đông', 'hehe\r\n'),
                                                               (7, 23, 'Tư vấn vải mùa đông', 'hihi'),
                                                               (8, 23, 'Tư vấn vải mùa đông', 'Mua vải mùa đông');

-- Dumping structure for table project_web.orders
CREATE TABLE IF NOT EXISTS `orders` (
                                        `id` int(11) NOT NULL AUTO_INCREMENT,
    `timeOrder` datetime NOT NULL,
    `idUser` int(11) NOT NULL,
    `idVoucher` int(11) DEFAULT NULL,
    `statusOrder` varchar(255) NOT NULL,
    `totalPrice` double NOT NULL,
    `lastPrice` double NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `orders_iduser_foreign` (`idUser`) USING BTREE,
    KEY `orders_idVoucher_foreign` (`idVoucher`) USING BTREE,
    CONSTRAINT `orders_idVoucher_foreign` FOREIGN KEY (`idVoucher`) REFERENCES `vouchers` (`idVoucher`),
    CONSTRAINT `orders_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.orders: ~31 rows (approximately)
DELETE FROM `orders`;
INSERT INTO `orders` (`id`, `timeOrder`, `idUser`, `idVoucher`, `statusOrder`, `totalPrice`, `lastPrice`) VALUES
                                                                                                              (1, '2025-12-01 10:30:00', 1, 1, 'Chưa thanh toán', 150000, 135000),
                                                                                                              (2, '2025-12-01 11:15:00', 2, NULL, 'Đã thanh toán', 200000, 200000),
                                                                                                              (3, '2025-12-02 14:00:00', 3, 1, 'Chưa thanh toán', 250000, 225000),
                                                                                                              (4, '2025-12-03 09:45:00', 4, NULL, 'Chưa thanh toán', 100000, 100000),
                                                                                                              (5, '2025-12-03 12:00:00', 5, 3, 'Đã thanh toán', 300000, 270000),
                                                                                                              (6, '2025-12-04 16:30:00', 6, NULL, 'Đã thanh toán', 50000, 50000),
                                                                                                              (7, '2025-12-05 08:20:00', 7, 1, 'Chưa thanh toán', 120000, 108000),
                                                                                                              (8, '2025-12-05 19:00:00', 8, NULL, 'Đã thanh toán', 450000, 450000),
                                                                                                              (9, '2025-12-06 11:50:00', 9, 2, 'Chưa thanh toán', 600000, 540000),
                                                                                                              (10, '2025-12-07 15:10:00', 10, NULL, 'Chưa thanh toán', 700000, 700000),
                                                                                                              (11, '2025-01-07 07:13:46', 1, 1, 'Đang giao hàng', 500, 450),
                                                                                                              (17, '2025-03-07 07:49:53', 2, NULL, 'Đang giao hàng', 3300000, 3300000),
                                                                                                              (18, '2025-03-07 07:53:00', 2, NULL, 'Đang giao hàng', 4500000, 4500000),
                                                                                                              (19, '2025-04-07 07:56:59', 2, NULL, 'Đang giao hàng', 7350000, 7350000),
                                                                                                              (20, '2025-04-07 08:00:12', 2, NULL, 'Đang giao hàng', 4500000, 4500000),
                                                                                                              (21, '2025-09-07 08:01:05', 2, NULL, 'Đang giao hàng', 6020000, 6020000),
                                                                                                              (25, '2025-11-08 09:06:41', 2, 5, 'Đang giao hàng', 2850000, 2600000),
                                                                                                              (26, '2025-10-08 23:01:05', 23, 1, 'Đang giao hàng', 1064000, 994000),
                                                                                                              (27, '2025-01-08 23:09:02', 23, NULL, 'Đang giao hàng', 4500000, 4500000),
                                                                                                              (28, '2025-04-08 23:11:11', 23, NULL, 'Đang giao hàng', 1512500, 1532500),
                                                                                                              (29, '2025-12-08 23:13:30', 23, NULL, 'Đang giao hàng', 4183000, 4183000),
                                                                                                              (30, '2025-02-08 23:17:58', 23, NULL, 'Đang giao hàng', 291400, 321400),
                                                                                                              (31, '2025-05-09 18:27:46', 23, 5, 'Đang giao hàng', 1710000, 1490000),
                                                                                                              (32, '2025-02-11 14:45:45', 23, NULL, 'Đang giao hàng', 270000, 300000),
                                                                                                              (33, '2025-06-11 15:36:09', 23, 5, 'Đang giao hàng', 4785000, 4535000),
                                                                                                              (34, '2025-07-12 09:27:54', 23, NULL, 'Đang giao hàng', 45000, 75000),
                                                                                                              (35, '2025-01-12 22:24:11', 23, NULL, 'Đang giao hàng', 225000, 255000),
                                                                                                              (36, '2025-08-12 23:01:22', 23, 5, 'Đang giao hàng', 6585000, 6335000),
                                                                                                              (37, '2025-07-12 23:02:12', 23, 1, 'Đang giao hàng', 4344000, 4244000),
                                                                                                              (38, '2025-01-12 23:04:01', 23, NULL, 'Đang giao hàng', 14184000, 14184000),
                                                                                                              (39, '2025-01-13 10:23:00', 23, 5, 'Đang giao hàng', 2850000, 2600000);

-- Dumping structure for table project_web.order_details
CREATE TABLE IF NOT EXISTS `order_details` (
                                               `id` int(11) NOT NULL AUTO_INCREMENT,
    `idOrder` int(11) NOT NULL,
    `idStyle` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    `totalPrice` double NOT NULL,
    `weight` double NOT NULL,
    PRIMARY KEY (`id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.order_details: ~119 rows (approximately)
DELETE FROM `order_details`;
INSERT INTO `order_details` (`id`, `idOrder`, `idStyle`, `quantity`, `totalPrice`, `weight`) VALUES
                                                                                                 (1, 1, 23, 2, 300000, 1.5),
                                                                                                 (2, 1, 45, 1, 150000, 0.7),
                                                                                                 (3, 2, 67, 3, 450000, 2),
                                                                                                 (4, 2, 89, 4, 600000, 3.2),
                                                                                                 (5, 3, 12, 1, 120000, 0.5),
                                                                                                 (6, 3, 34, 2, 240000, 1),
                                                                                                 (7, 4, 56, 5, 750000, 4),
                                                                                                 (8, 4, 78, 1, 150000, 0.8),
                                                                                                 (9, 5, 90, 2, 300000, 1.4),
                                                                                                 (10, 5, 123, 3, 450000, 2.1),
                                                                                                 (11, 6, 234, 1, 150000, 0.6),
                                                                                                 (12, 6, 345, 2, 300000, 1.2),
                                                                                                 (13, 7, 156, 4, 600000, 2.5),
                                                                                                 (14, 7, 267, 1, 120000, 0.4),
                                                                                                 (15, 8, 378, 3, 450000, 1.9),
                                                                                                 (16, 8, 189, 2, 300000, 1.3),
                                                                                                 (17, 9, 11, 1, 150000, 0.7),
                                                                                                 (18, 9, 22, 5, 750000, 3.8),
                                                                                                 (19, 10, 33, 2, 300000, 1.4),
                                                                                                 (20, 10, 44, 3, 450000, 2),
                                                                                                 (21, 11, 55, 1, 150000, 0.8),
                                                                                                 (22, 11, 66, 4, 600000, 3.1),
                                                                                                 (23, 12, 77, 2, 300000, 1.2),
                                                                                                 (24, 12, 88, 3, 450000, 2.1),
                                                                                                 (25, 13, 99, 5, 750000, 4.5),
                                                                                                 (26, 13, 110, 1, 150000, 0.9),
                                                                                                 (27, 14, 121, 2, 300000, 1.4),
                                                                                                 (28, 14, 132, 4, 600000, 2.8),
                                                                                                 (29, 15, 143, 3, 450000, 2),
                                                                                                 (30, 15, 154, 2, 300000, 1.3),
                                                                                                 (31, 16, 165, 1, 150000, 0.7),
                                                                                                 (32, 16, 176, 5, 750000, 3.9),
                                                                                                 (33, 17, 187, 2, 300000, 1.2),
                                                                                                 (34, 17, 198, 3, 450000, 2.4),
                                                                                                 (35, 18, 209, 4, 600000, 3),
                                                                                                 (36, 18, 220, 1, 150000, 0.8),
                                                                                                 (37, 19, 231, 2, 300000, 1.5),
                                                                                                 (38, 19, 242, 3, 450000, 2.3),
                                                                                                 (39, 20, 253, 5, 750000, 4.7),
                                                                                                 (40, 20, 264, 1, 150000, 0.9),
                                                                                                 (41, 1, 23, 2, 300000, 1.5),
                                                                                                 (42, 1, 45, 1, 150000, 0.7),
                                                                                                 (43, 2, 67, 3, 450000, 2),
                                                                                                 (44, 2, 89, 4, 600000, 3.2),
                                                                                                 (45, 3, 12, 1, 120000, 0.5),
                                                                                                 (46, 3, 34, 2, 240000, 1),
                                                                                                 (47, 4, 56, 5, 750000, 4),
                                                                                                 (48, 4, 78, 1, 150000, 0.8),
                                                                                                 (49, 5, 90, 2, 300000, 1.4),
                                                                                                 (50, 5, 123, 3, 450000, 2.1),
                                                                                                 (51, 6, 234, 1, 150000, 0.6),
                                                                                                 (52, 6, 345, 2, 300000, 1.2),
                                                                                                 (53, 7, 156, 4, 600000, 2.5),
                                                                                                 (54, 7, 267, 1, 120000, 0.4),
                                                                                                 (55, 8, 378, 3, 450000, 1.9),
                                                                                                 (56, 8, 189, 2, 300000, 1.3),
                                                                                                 (57, 9, 11, 1, 150000, 0.7),
                                                                                                 (58, 9, 22, 5, 750000, 3.8),
                                                                                                 (59, 10, 33, 2, 300000, 1.4),
                                                                                                 (60, 10, 44, 3, 450000, 2),
                                                                                                 (61, 11, 55, 1, 150000, 0.8),
                                                                                                 (62, 11, 66, 4, 600000, 3.1),
                                                                                                 (63, 12, 77, 2, 300000, 1.2),
                                                                                                 (64, 12, 88, 3, 450000, 2.1),
                                                                                                 (65, 13, 99, 5, 750000, 4.5),
                                                                                                 (66, 13, 110, 1, 150000, 0.9),
                                                                                                 (67, 14, 121, 2, 300000, 1.4),
                                                                                                 (68, 14, 132, 4, 600000, 2.8),
                                                                                                 (69, 15, 143, 3, 450000, 2),
                                                                                                 (70, 15, 154, 2, 300000, 1.3),
                                                                                                 (71, 16, 165, 1, 150000, 0.7),
                                                                                                 (72, 16, 176, 5, 750000, 3.9),
                                                                                                 (73, 17, 187, 2, 300000, 1.2),
                                                                                                 (74, 17, 198, 3, 450000, 2.4),
                                                                                                 (75, 18, 209, 4, 600000, 3),
                                                                                                 (76, 18, 220, 1, 150000, 0.8),
                                                                                                 (77, 19, 231, 2, 300000, 1.5),
                                                                                                 (78, 19, 242, 3, 450000, 2.3),
                                                                                                 (79, 20, 253, 5, 750000, 4.7),
                                                                                                 (80, 20, 264, 1, 150000, 0.9),
                                                                                                 (83, 17, 356, 1, 450000, 0.5),
                                                                                                 (84, 17, 358, 10, 2850000, 5),
                                                                                                 (85, 18, 355, 10, 4500000, 5),
                                                                                                 (86, 19, 355, 10, 4500000, 5),
                                                                                                 (87, 19, 357, 10, 2850000, 5),
                                                                                                 (88, 20, 355, 10, 4500000, 5),
                                                                                                 (89, 21, 355, 10, 4500000, 5),
                                                                                                 (90, 21, 372, 2, 1520000, 1),
                                                                                                 (91, 24, 355, 3, 1350000, 1.5),
                                                                                                 (92, 24, 358, 10, 2850000, 5),
                                                                                                 (93, 25, 358, 10, 2850000, 5),
                                                                                                 (94, 26, 5, 10, 19000, 5),
                                                                                                 (95, 26, 373, 1, 760000, 0.5),
                                                                                                 (96, 26, 358, 1, 285000, 0.5),
                                                                                                 (97, 27, 355, 10, 4500000, 5),
                                                                                                 (98, 28, 357, 1, 285000, 0.5),
                                                                                                 (99, 28, 393, 1, 540000, 0.5),
                                                                                                 (100, 28, 396, 1, 220000, 0.5),
                                                                                                 (101, 28, 383, 1, 467500, 0.5),
                                                                                                 (102, 29, 358, 10, 2850000, 5),
                                                                                                 (103, 29, 375, 2, 738000, 1),
                                                                                                 (104, 29, 360, 2, 595000, 1),
                                                                                                 (105, 30, 2, 1, 4500, 0.5),
                                                                                                 (106, 30, 6, 1, 1900, 0.5),
                                                                                                 (107, 30, 359, 1, 285000, 0.5),
                                                                                                 (108, 31, 358, 6, 1710000, 3),
                                                                                                 (109, 32, 184, 10, 270000, 5),
                                                                                                 (110, 33, 355, 10, 4500000, 5),
                                                                                                 (111, 33, 359, 1, 285000, 0.5),
                                                                                                 (112, 34, 21, 1, 22500, 0.5),
                                                                                                 (113, 34, 24, 1, 22500, 0.5),
                                                                                                 (114, 35, 24, 10, 225000, 5),
                                                                                                 (115, 36, 369, 10, 6300000, 5),
                                                                                                 (116, 36, 385, 1, 285000, 0.5),
                                                                                                 (117, 37, 417, 10, 1584000, 5),
                                                                                                 (118, 37, 411, 10, 2760000, 5),
                                                                                                 (119, 38, 368, 3, 1584000, 1.5),
                                                                                                 (120, 38, 369, 20, 12600000, 10),
                                                                                                 (121, 39, 357, 10, 2850000, 5);

-- Dumping structure for table project_web.payments
CREATE TABLE IF NOT EXISTS `payments` (
                                          `id` int(11) NOT NULL AUTO_INCREMENT,
    `idOrder` int(11) NOT NULL,
    `method` tinyint(4) NOT NULL,
    `status` varchar(255) NOT NULL,
    `time` datetime NOT NULL,
    `price` double NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `payments_idorder_foreign` (`idOrder`) USING BTREE,
    CONSTRAINT `payments_idorder_foreign` FOREIGN KEY (`idOrder`) REFERENCES `orders` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.payments: ~4 rows (approximately)
DELETE FROM `payments`;
INSERT INTO `payments` (`id`, `idOrder`, `method`, `status`, `time`, `price`) VALUES
                                                                                  (1, 2, 1, 'Completed', '2024-12-17 10:00:00', 150),
                                                                                  (2, 3, 2, 'Pending', '2024-12-17 11:00:00', 200),
                                                                                  (3, 4, 1, 'Completed', '2024-12-17 12:00:00', 120),
                                                                                  (4, 5, 2, 'Completed', '2024-12-17 14:00:00', 250);

-- Dumping structure for table project_web.prices
CREATE TABLE IF NOT EXISTS `prices` (
                                        `id` int(11) NOT NULL AUTO_INCREMENT,
    `price` double NOT NULL,
    `discountPercent` double NOT NULL,
    `lastPrice` double GENERATED ALWAYS AS (`price` * (1 - `discountPercent` / 100)) STORED,
    `startDate` datetime DEFAULT NULL,
    `endDate` datetime DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.prices: ~43 rows (approximately)
DELETE FROM `prices`;
INSERT INTO `prices` (`id`, `price`, `discountPercent`, `startDate`, `endDate`) VALUES
                                                                                    (1, 5000, 10, '2025-04-13 16:13:04', NULL),
                                                                                    (2, 2000, 10, '2025-04-13 16:13:04', NULL),
                                                                                    (3, 30000, 15, '2025-04-13 16:13:04', NULL),
                                                                                    (4, 50000, 20, '2025-04-13 16:13:04', NULL),
                                                                                    (5, 15000, 5, '2025-04-13 16:13:04', NULL),
                                                                                    (6, 25000, 10, '2025-04-13 16:13:04', NULL),
                                                                                    (7, 50000, 25, '2025-04-13 16:13:04', NULL),
                                                                                    (8, 35000, 10, '2025-04-13 16:13:04', NULL),
                                                                                    (9, 10000, 5, '2025-04-13 16:13:04', NULL),
                                                                                    (10, 45000, 15, '2025-04-13 16:13:04', NULL),
                                                                                    (11, 50000, 30, '2025-04-13 16:13:04', NULL),
                                                                                    (12, 12000, 0, '2025-04-13 16:13:04', NULL),
                                                                                    (13, 18000, 10, '2025-04-13 16:13:04', NULL),
                                                                                    (14, 45000, 20, '2025-04-13 16:13:04', NULL),
                                                                                    (15, 40000, 10, '2025-04-13 16:13:04', NULL),
                                                                                    (16, 50000, 25, '2025-04-13 16:13:04', NULL),
                                                                                    (17, 30000, 5, '2025-04-13 16:13:04', NULL),
                                                                                    (18, 45000, 15, '2025-04-13 16:13:04', NULL),
                                                                                    (19, 50000, 20, '2025-04-13 16:13:04', NULL),
                                                                                    (20, 50000, 30, '2025-04-13 16:13:04', NULL),
                                                                                    (21, 40000, 10, '2025-04-13 16:13:04', NULL),
                                                                                    (22, 50000, 5, '2025-04-13 16:13:04', NULL),
                                                                                    (23, 30000, 0, '2025-04-13 16:13:04', NULL),
                                                                                    (186, 150000, 10, '2025-04-13 17:09:10', NULL),
                                                                                    (187, 180000, 15, '2025-04-13 17:09:10', NULL),
                                                                                    (188, 200000, 5, '2025-04-13 17:09:11', NULL),
                                                                                    (189, 170000, 12, '2025-04-13 17:09:12', NULL),
                                                                                    (190, 220000, 8, '2025-04-13 17:09:12', NULL),
                                                                                    (191, 130000, 20, '2025-04-13 17:09:14', NULL),
                                                                                    (192, 250000, 10, '2025-04-13 17:09:15', NULL),
                                                                                    (193, 160000, 0, '2025-04-13 17:09:15', NULL),
                                                                                    (194, 190000, 5, '2025-04-13 17:09:16', NULL),
                                                                                    (195, 145000, 10, '2025-04-13 17:09:16', NULL),
                                                                                    (196, 210000, 15, '2025-04-13 17:09:17', NULL),
                                                                                    (197, 230000, 10, '2025-04-13 17:09:18', NULL),
                                                                                    (198, 175000, 7, '2025-04-13 17:09:18', NULL),
                                                                                    (199, 165000, 8, '2025-04-13 17:09:19', NULL),
                                                                                    (200, 195000, 12, '2025-04-13 17:09:19', NULL),
                                                                                    (201, 240000, 6, '2025-04-13 17:09:20', NULL),
                                                                                    (202, 225000, 10, '2025-04-13 17:09:20', NULL),
                                                                                    (203, 185000, 9, '2025-04-13 17:09:21', NULL),
                                                                                    (204, 155000, 10, '2025-04-13 17:09:22', NULL),
                                                                                    (205, 205000, 15, '2025-04-13 17:09:23', NULL);

-- Dumping structure for table project_web.products
CREATE TABLE IF NOT EXISTS `products` (
                                          `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `quantity` int(11) NOT NULL,
    `addedDate` date NOT NULL,
    `idCategory` int(11) NOT NULL,
    `height` double DEFAULT NULL,
    `width` double DEFAULT NULL,
    `weight` double DEFAULT NULL,
    `description` varchar(255) NOT NULL,
    `selling` tinyint(4) NOT NULL,
    `idTechnical` int(11) NOT NULL,
    `img` varchar(255) NOT NULL,
    `idPrice` int(11) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `products_idcategory_foreign` (`idCategory`) USING BTREE,
    KEY `products_idtechnical_foreign` (`idTechnical`) USING BTREE,
    CONSTRAINT `products_idcategory_foreign` FOREIGN KEY (`idCategory`) REFERENCES `categories` (`id`),
    CONSTRAINT `products_idtechnical_foreign` FOREIGN KEY (`idTechnical`) REFERENCES `technical_information` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.products: ~43 rows (approximately)
DELETE FROM `products`;
INSERT INTO `products` (`id`, `name`, `quantity`, `addedDate`, `idCategory`, `height`, `width`, `weight`, `description`, `selling`, `idTechnical`, `img`, `idPrice`) VALUES
                                                                                                                                                                         (185, 'Linen Bột', 20, '2025-04-08', 1, 50.5, 60.3, 0.8, 'vải cotton cao cấp', 1, 1, 'https://product.hstatic.net/200000898773/product/00_f90ef99c88dd4fc384abad51dc497172_master.jpg', 1),
                                                                                                                                                                         (186, 'Linen Tưng Hàn', 35, '2025-04-05', 1, 45, 70.2, 1.2, 'vải lụa mềm mại', 1, 2, 'https://product.hstatic.net/200000898773/product/upload_8bceb0438f664f5ea5dacfa31e87af76_master.jpg\r\n', 2),
                                                                                                                                                                         (187, 'Linen Bố Gân', 12, '2025-04-02', 1, 60, 80, 0.9, 'vải bố dày dặn', 0, 3, 'https://product.hstatic.net/200000898773/product/upload_5c893063cad64535b0095413662c65e8_master.jpg\r\n', 3),
                                                                                                                                                                         (188, 'Linen cotton lạnh', 25, '2025-03-30', 1, 55.2, 75.1, 1.1, 'vải kaki bền màu', 1, 4, 'https://product.hstatic.net/200000898773/product/110-vai-linen-cotton-lanh-min-mat-chong-nhan-may-so-mi-vay-dam-bo__1__f6b195bc103b49c485a2da4a22b80bc2_master.jpg', 4),
                                                                                                                                                                         (189, 'Linen tưng ướt', 18, '2025-03-28', 1, 48, 68.4, 0.7, 'vải thun co giãn', 0, 5, 'https://product.hstatic.net/200000898773/product/00__2__3e2ac73090724bad9253c7f05ce1dee4_master.jpg', 5),
                                                                                                                                                                         (190, 'Linen bamboo', 22, '2025-03-25', 1, 52.7, 69.9, 1, 'vải linen thoáng mát', 1, 6, 'https://product.hstatic.net/200000898773/product/vai-linen-bamboo__1__99439c1b192d42e991e33a4dd564e639_master.jpg', 6),
                                                                                                                                                                         (191, 'Linen bột dày', 30, '2025-03-24', 1, 57.6, 72.5, 1.3, 'vải dạ ấm áp', 1, 7, 'https://product.hstatic.net/200000898773/product/11_1000ff25414e489cb85ae7666f58dd39_master.jpg', 7),
                                                                                                                                                                         (192, 'Linen gân nhật', 16, '2025-03-20', 1, 42.4, 65, 0.6, 'vải jean năng động', 1, 8, 'https://product.hstatic.net/200000898773/product/upload_35eae0b1726a47e79b52d54463512913_master.jpg', 8),
                                                                                                                                                                         (193, 'Thun gân tăm', 40, '2025-03-18', 1, 49.9, 67.2, 1.1, 'vải nỉ cao cấp', 0, 9, 'https://product.hstatic.net/200000898773/product/upload_7b0850c4e69c4820a974d52124f55870_master.jpg', 9),
                                                                                                                                                                         (194, 'Thun sóng', 28, '2025-03-16', 1, 53.3, 70.6, 1.4, 'vải canvas bền đẹp', 1, 10, 'https://product.hstatic.net/200000898773/product/vai-thun-gan-song-gian-4c__1__469c4cb081674b3e8570f2cce028d010_master.jpg', 10),
                                                                                                                                                                         (195, 'Thun giấy', 21, '2025-03-14', 1, 46.6, 66.5, 0.9, 'vải nhung mịn màng', 1, 11, 'https://product.hstatic.net/200000898773/product/vai-thun-giay-mong-mat__1__9548fb7d6f9844ae9addac1280796e30_master.jpg\r\n', 11),
                                                                                                                                                                         (196, 'Thun xốp nhật', 19, '2025-03-12', 1, 58.1, 73.4, 1.2, 'vải gấm họa tiết', 0, 12, 'https://product.hstatic.net/200000898773/product/upload_78acea25c3e4458aa43b89d22e2e4489_master.jpg\r\n', 12),
                                                                                                                                                                         (197, 'Thun ướt', 34, '2025-03-10', 1, 51.2, 69.8, 1, 'vải taffeta chống nước', 1, 13, 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__1__6d8677fe59f343bf8e90d767ca8d78eb_master.jpg\r\n', 13),
                                                                                                                                                                         (198, 'Lưới thun dẻo', 27, '2025-03-08', 1, 54.4, 71.1, 0.8, 'vải organza nhẹ', 0, 14, 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke__1', 14),
                                                                                                                                                                         (199, 'Thun cotton 100% 2 chiều', 32, '2025-03-06', 1, 47.3, 66.9, 0.7, 'vải chiffon bay bổng', 1, 15, 'https://product.hstatic.net/200000898773/product/upload_e2d7b48c7f364913898d44bd782a4af1_master.jpg\r\n', 15),
                                                                                                                                                                         (200, 'Thun hàn dày', 23, '2025-03-04', 1, 56.8, 74.2, 1.3, 'vải voan sang trọng', 1, 16, 'https://product.hstatic.net/200000898773/product/upload_d53f6dec5d2b4cc6868b0a977dc3fe09_master.jpg\r\n', 16),
                                                                                                                                                                         (201, 'Thun tăm lạnh', 38, '2025-03-02', 1, 50.6, 68.3, 1, 'vải cashmere mịn', 0, 17, 'https://product.hstatic.net/200000898773/product/upload_b019968cfbbe496cb15313d7d4897076_master.jpg\r\n', 17),
                                                                                                                                                                         (202, 'Thun co dãn', 29, '2025-02-28', 1, 44.7, 64.8, 0.9, 'vải tweed cổ điển', 1, 18, 'https://product.hstatic.net/200000898773/product/upload_cb178eb1ccbf4ab6ac990669de42923c_master.jpg\r\n', 18),
                                                                                                                                                                         (203, 'Kaki xước hoa nổi', 33, '2025-02-26', 1, 59.5, 76, 1.2, 'vải polyester bền', 1, 19, 'https://product.hstatic.net/200000898773/product/506-vai-kaki-xuoc-hoa-noi-may-quan-tay-vay-dam-vest-thiet-ke__1__', 19),
                                                                                                                                                                         (204, 'Jean Chấm', 17, '2025-02-24', 1, 43.9, 63.7, 0.6, 'vải rayon mềm mát', 1, 20, 'https://product.hstatic.net/200000898773/product/upload_fc8717f020c64a5c83ce03028cf5eebe_master.jpg\r\n', 20),
                                                                                                                                                                         (205, 'Jean demin', 24, '2025-02-22', 1, 55.9, 71.6, 1.1, 'vải modal hút ẩm', 0, 21, 'https://product.hstatic.net/200000898773/product/upload_9c56871814ad4fc0ba48af9a4aa8f6f4_master.jpg\r\n', 21),
                                                                                                                                                                         (206, 'Jean lụa', 36, '2025-02-20', 1, 61.2, 77.3, 1.3, 'vải spandex co dãn', 1, 22, 'https://product.hstatic.net/200000898773/product/upload_ea9df28aa38f43c585d64d9aaa8a0993_master.jpg\r\n', 22),
                                                                                                                                                                         (207, 'jean loang', 26, '2025-02-18', 1, 52, 70, 1, 'vải nylon chống thấm', 1, 23, 'https://product.hstatic.net/200000898773/product/upload_981854ba7eb5427d883f3d0d33c5bf07_master.jpg\r\n', 23),
                                                                                                                                                                         (208, 'Vải Cotton Mịn', 100, '2025-04-01', 2, 2, 1.5, 0.3, 'Vải cotton cao cấp, mềm mại, thấm hút tốt.', 1, 187, 'https://wego.net.vn/wp-content/uploads/2022/03/chat-lieu-vai-cotton-sieu-mat-sieu-mem-muot-1.jpg', 186),
                                                                                                                                                                         (209, 'Vải Lụa Tơ Tằm', 80, '2025-03-28', 2, 1.8, 1.4, 0.25, 'Vải lụa mềm mại, thích hợp may váy đầm.', 1, 188, 'https://bizweb.dktcdn.net/100/320/888/files/vai-lua-to-tam-6.jpg?v=1677826219176', 187),
                                                                                                                                                                         (210, 'Vải Kaki Co Giãn', 150, '2025-03-15', 2, 2.2, 1.6, 0.4, 'Kaki dày dặn, có độ co giãn nhẹ.', 1, 189, 'https://down-vn.img.susercontent.com/file/9c85c33afeabb236c75467d3ac9086e5', 188),
                                                                                                                                                                         (211, 'Vải Voan Hoa Văn', 120, '2025-03-20', 2, 2, 1.5, 0.2, 'Voan nhẹ, in hoa văn sang trọng.', 1, 190, 'https://1.bp.blogspot.com/-Wog0LzmuZOM/XPn1Hh1GRJI/AAAAAAAALas/75_q4IpY-dw8sGejDG3Av0VdUjDT5dgJgCLcBGAs/s1600/babc3006e80127817a8e7aa3d7c69ec6_result.jpg', 189),
                                                                                                                                                                         (212, 'Vải Denim Cao Cấp', 90, '2025-04-02', 2, 2.1, 1.5, 0.45, 'Denim bền, phù hợp may quần jean.', 1, 191, 'https://file.hstatic.net/200000053174/article/f3f7d7c1-486e-4f06-be97-e24b42de41c0_38800a4b84d54339adf6b1fb1b8b6ac9.jpg', 190),
                                                                                                                                                                         (213, 'Vải Thô Trơn', 110, '2025-04-01', 2, 1.9, 1.3, 0.35, 'Vải thô đơn giản, dễ phối màu.', 1, 192, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMnZssT23EwBJ9s_EpQqiyabBDb6iF-n6TVQ&s', 191),
                                                                                                                                                                         (214, 'Vải Nhung Cao Cấp', 75, '2025-03-30', 2, 2, 1.4, 0.5, 'Vải nhung sang trọng, dày dặn.', 1, 193, 'https://thaituan.com/wp-content/uploads/2023/02/uu-diem-cua-vai-nhung.jpg', 192),
                                                                                                                                                                         (215, 'Vải Kate Mịn', 95, '2025-03-22', 2, 2, 1.4, 0.3, 'Kate mềm mại, thấm hút mồ hôi tốt.', 1, 194, 'https://pubcdn.ivymoda.com/files/news/2023/05/04/65749e3c32abaa8fe01a56d12b75fc5a.jpg', 193),
                                                                                                                                                                         (216, 'Vải Linen Tự Nhiên', 85, '2025-03-27', 2, 2.1, 1.5, 0.28, 'Linen mát mẻ, thân thiện môi trường.', 1, 195, 'https://gianphoi.com.vn/uploads/images/2022/7/4/vai-linen-la-gi.webp', 194),
                                                                                                                                                                         (217, 'Vải Lanh Trơn', 105, '2025-04-05', 2, 1.8, 1.3, 0.25, 'Vải lanh mịn, nhẹ, thích hợp ngày hè.', 1, 196, 'https://media.loveitopcdn.com/6535/vai-linen-han-quoc.jpg', 195),
                                                                                                                                                                         (218, 'Vải Tuyết Mưa', 98, '2025-03-25', 2, 2, 1.5, 0.33, 'Tuyết mưa mềm, có độ rũ đẹp.', 1, 197, 'https://thaituan.com/wp-content/uploads/2023/02/hinh-anh-vai-tuyet-mua-thoi-trang.jpg', 196),
                                                                                                                                                                         (219, 'Vải Phi Bóng', 130, '2025-04-03', 2, 2.2, 1.6, 0.3, 'Vải phi bóng loáng, thường dùng cho áo dài.', 1, 198, 'https://mialala.vn/media/lib/27-06-2023/mialala-vai-bong2.jpg', 197),
                                                                                                                                                                         (220, 'Vải Ren Hoa Văn', 65, '2025-03-18', 2, 1.7, 1.3, 0.22, 'Ren mỏng, hoa văn tinh xảo.', 1, 199, 'https://file.hstatic.net/1000165376/file/4_97e6dd585e75430994960fb4b592f269_grande.jpeg', 198),
                                                                                                                                                                         (221, 'Vải Chiffon Mềm', 120, '2025-03-19', 2, 2, 1.5, 0.25, 'Chiffon nhẹ, rũ, thường dùng làm váy.', 1, 200, 'https://file.hstatic.net/1000058447/article/vai_chiffon_182d2caaadf64696b63c7c207f6747bc.jpg', 199),
                                                                                                                                                                         (222, 'Vải Dạ Lạnh', 85, '2025-03-17', 2, 2, 1.5, 0.5, 'Dạ mềm, giữ ấm tốt.', 1, 201, 'https://dongphucbonmua.com/wp-content/uploads/2021/09/vai-lanh-22-min.png', 200),
                                                                                                                                                                         (223, 'Vải Jean Co Giãn', 140, '2025-03-26', 2, 2.3, 1.6, 0.48, 'Jean co giãn, bền chắc.', 1, 202, 'https://down-vn.img.susercontent.com/file/cn-11134207-7qukw-li9sri2c1tva96', 201),
                                                                                                                                                                         (224, 'Vải Gấm Hoa', 70, '2025-03-29', 2, 2, 1.4, 0.45, 'Gấm dày, hoa văn cổ điển.', 1, 203, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwgBbfewfdkwiduuIVVK9POr3MWG7UyIPCsQ&s', 202),
                                                                                                                                                                         (225, 'Vải Modal Mềm', 88, '2025-03-31', 2, 2, 1.5, 0.3, 'Modal mềm mại, co giãn tốt.', 1, 204, 'https://demxanh.com/media/news/1726_v___i_modal.jpg', 203),
                                                                                                                                                                         (226, 'Vải Cotton Họa Tiết', 115, '2025-03-24', 2, 2.1, 1.5, 0.3, 'Cotton in họa tiết dễ thương.', 1, 205, 'https://down-vn.img.susercontent.com/file/71cf707dc7962a1ae9279817cbf1ce38', 204),
                                                                                                                                                                         (227, 'Vải Flannel Kẻ Sọc', 95, '2025-04-04', 2, 2, 1.4, 0.4, 'Flannel mềm, sọc caro, giữ ấm tốt.', 1, 206, 'https://gaohouse.vn/wp-content/uploads/2024/10/chat-lieu-flannel-ke-soc.jpg', 205);

-- Dumping structure for table project_web.roles
CREATE TABLE IF NOT EXISTS `roles` (
                                       `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL COMMENT 'Tên vai trò (vd: Admin, User, Moderator)',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `name` (`name`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='Lưu trữ các vai trò người dùng';

-- Dumping data for table project_web.roles: ~2 rows (approximately)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`) VALUES
                                       (2, 'Admin'),
                                       (1, 'User');

-- Dumping structure for table project_web.styles
CREATE TABLE IF NOT EXISTS `styles` (
                                        `id` int(11) NOT NULL AUTO_INCREMENT,
    `idProduct` int(11) NOT NULL,
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `image` varchar(255) NOT NULL,
    `quantity` int(11) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `styles_idproduct_foreign` (`idProduct`) USING BTREE,
    CONSTRAINT `styles_idproduct_foreign` FOREIGN KEY (`idProduct`) REFERENCES `products` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=647 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.styles: ~141 rows (approximately)
DELETE FROM `styles`;
INSERT INTO `styles` (`id`, `idProduct`, `name`, `image`, `quantity`) VALUES
                                                                          (446, 1, 'Linen Bột xanh da trời', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__3__3c9c3f26e7224b4796827ae0b001f3ab_master.jpg', 1),
                                                                          (447, 1, 'Linen Bột trắng tinh', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__4__497a1b76ddab4fe1b48533cc9273ed3b_master.jpg', 1),
                                                                          (448, 1, 'Linen Bột Muối tiêu', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__7__61ffb81f86fe4800b1d735d89a0e35f3_master.jpg', 1),
                                                                          (449, 1, 'Linen Bột đen', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__15__0c9852186a4b4d7788669457e4bc2594_master.jpg', 1),
                                                                          (450, 1, 'Linen Bột xanh Carolina', 'https://product.hstatic.net/200000898773/product/z4854448267372_cb08f468ebcedd209900293a18c40cc7_49fedc489e174f81892ace51c9e8cb64_master.jpg', 1),
                                                                          (451, 2, 'Linen Tưng Hàn Kem', 'https://product.hstatic.net/200000898773/product/upload_8bceb0438f664f5ea5dacfa31e87af76_master.jpg', 1),
                                                                          (452, 2, 'Linen Tưng Hàn Xanh da trời', 'https://product.hstatic.net/200000898773/product/upload_bd349e85b0894056b62b208d3c48e2ed_master.jpg', 1),
                                                                          (453, 2, 'Linen Tưng Hàn đen', 'https://product.hstatic.net/200000898773/product/02_4c6680d5388a41a68e94fab7227b37cd_master.jpg', 1),
                                                                          (454, 2, 'Linen Tưng Hàn nâu', 'https://product.hstatic.net/200000898773/product/07_57d4fd19520d40b58014cce3fc551605_master.jpg', 1),
                                                                          (455, 3, 'Linen Bố Gân do nhung', 'https://product.hstatic.net/200000898773/product/01_a78977897050428591120b8fe5ca8686_master.jpg', 1),
                                                                          (456, 3, 'Linen Bố Gân xanh lá', 'https://product.hstatic.net/200000898773/product/02_4976a7977cb945478b9076be4b9b9356_master.jpg', 1),
                                                                          (457, 3, 'Linen Bố Gân da đậm', 'https://product.hstatic.net/200000898773/product/04_dcaef903b11e4fb597b5d776c069d5a3_master.jpg', 1),
                                                                          (458, 3, 'Linen Bố Gân trắng', 'https://product.hstatic.net/200000898773/product/07_08131ef255c34d9b99409ca613b3a475_master.jpg', 1),
                                                                          (459, 4, 'Linen cotton lạnh Hồng baby', 'https://product.hstatic.net/200000898773/product/01_d446d33fcbc24e4f89b90a3829908942_master.jpg', 1),
                                                                          (460, 4, 'Linen cotton lạnh xanh đen', 'https://product.hstatic.net/200000898773/product/15_2567b2293f564bbfaee710cf21c855cd_master.jpg', 1),
                                                                          (461, 4, 'Linen cotton lạnh nâu cacao', 'https://product.hstatic.net/200000898773/product/24_31003a51e2e44d98b6c10ad989b4b798_master.jpg', 1),
                                                                          (462, 4, 'Linen cotton lạnh xanh dâu', 'https://product.hstatic.net/200000898773/product/110-vai-linen-cotton-lanh-min-mat-chong-nhan-may-so-mi-vay-dam-bo__17__37c31b1635794331a2f0147fa8e179e9_master.jpg', 1),
                                                                          (463, 5, 'Linen tưng ướt đen', 'https://product.hstatic.net/200000898773/product/03-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__2__abf3b6e1abe9414ba4af1b52a5327c27_master.jpg', 1),
                                                                          (464, 5, 'Linen tưng ướt muối tiêu', 'https://product.hstatic.net/200000898773/product/03-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__3__a26009d329f347f990b6c7c706e074b0_master.jpg', 1),
                                                                          (465, 5, 'Linen tưng ướt xanh đá', 'https://product.hstatic.net/200000898773/product/3-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__14__b00f01469f4b43d0a98a6e1e6e2a0833_master.jpg', 1),
                                                                          (466, 5, 'Linen tưng ướt Xanh cameo', 'https://product.hstatic.net/200000898773/product/3-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__17__da23073faba34a5d80fd0d7a37126855_master.jpg', 1),
                                                                          (467, 6, 'Linen bamboo trắng', 'https://product.hstatic.net/200000898773/product/upload_b550ba94cece49ab866741d7a9d92388_master.jpg', 1),
                                                                          (468, 7, 'Linen bột dày', 'https://product.hstatic.net/200000898773/product/11_1000ff25414e489cb85ae7666f58dd39_master.jpg', 1),
                                                                          (469, 7, 'Linen bột dày trắng', 'https://product.hstatic.net/200000898773/product/11_1000ff25414e489cb85ae7666f58dd39_master.jpg', 1),
                                                                          (470, 8, 'Linen gân nhật xanh', 'https://product.hstatic.net/200000898773/product/upload_5797bb8020dd43ccbeb6efcb1ac70036_master.jpg', 1),
                                                                          (471, 8, 'Linen gân nhật đen', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__11__3c4a4b3c897f4b6f9c598647c72c83a2_master.jpg', 1),
                                                                          (472, 8, 'Linen gân nhật trắng', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__12__db74a652f477491c9203d013d78fe178_master.jpg', 1),
                                                                          (473, 8, 'Linen gân nhật xanh da trời', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__15__8f698b4ea4464c429b4d0cd59343edbb_master.jpg', 1),
                                                                          (474, 8, 'Linen gân nhật đỏ', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__17__ebf67c37e8f54bd8b20141465b8d3b92_master.jpg', 1),
                                                                          (475, 9, 'Thun gân tăm trắng gạo', 'https://product.hstatic.net/200000898773/product/upload_7b0850c4e69c4820a974d52124f55870_master.jpg', 1),
                                                                          (476, 9, 'Thun gân tăm đen', 'https://product.hstatic.net/200000898773/product/upload_5620aff9c123413f8323cace13ef71ea_master.jpg', 1),
                                                                          (477, 9, 'Thun gân tăm xanh bơ', 'https://product.hstatic.net/200000898773/product/z5688530491253_0eb312480a5291d811e547f48a6cc240_d231f089ac944eb5a42b026369dd6afa_master.jpg', 1),
                                                                          (478, 9, 'Thun gân tăm tím', 'https://product.hstatic.net/200000898773/product/z5688530497370_676caab435a983767b69b6cc119c56291_cd3610714f0d4f6e9c43199f282dfa07_master.jpg', 1),
                                                                          (479, 9, 'Thun gân tăm cam', 'https://product.hstatic.net/200000898773/product/z5688530539659_a81d2662501c6ee51cd1d113901f2790_53b596d9f2e3482cb11c9d31a5569d42_master.jpg', 1),
                                                                          (480, 10, 'Thun sóng kem', 'https://product.hstatic.net/200000898773/product/z5695162812219_b2077366ce331cb8d28436db56d75145_5ea0644732f049e28b312b302a2c4898_master.jpg', 1),
                                                                          (481, 10, 'Thun sóng trắng', 'https://product.hstatic.net/200000898773/product/z5695249703766_01a067b78d41ec98d1c49c72c6b173d2_4132b186f4884f32a30cf9901ced757e_master.jpg', 1),
                                                                          (482, 10, 'Thun sóng xanh bơ', 'https://product.hstatic.net/200000898773/product/z5695262408270_010df517460e6958e38619fd838f5364_b2977f81caea4f3ab8f67ffbc7c24a37_master.jpg', 1),
                                                                          (483, 10, 'Thun sóng hồng', 'https://product.hstatic.net/200000898773/product/z5695286517664_fe6e421a316cfea8e3d02ae8b1482de6_c87476f1d2bc4124a970e4f91f588f14_master.jpg', 1),
                                                                          (484, 10, 'Thun sóng đen', 'https://product.hstatic.net/200000898773/product/z5695336161796_87dfc4713a21fbe7eb54b131f8571814_34496a1931c340188aaf7fdd47914d9f_master.jpg', 1),
                                                                          (485, 11, 'Thun giấy xanh môn', 'https://product.hstatic.net/200000898773/product/z5694869951710_480014f65edff1f194e8c46e42842fc5_b3157a89fe124cdeadc3421214fd2413_master.jpg', 1),
                                                                          (486, 11, 'Thun giấy đen', 'https://product.hstatic.net/200000898773/product/z5694881209741_d2891080adc3189224049a807ac180d9_ff59991b45974abeb14916756d81413f_master.jpg', 1),
                                                                          (487, 11, 'Thun giấy nâu tây', 'https://product.hstatic.net/200000898773/product/z5694911231190_18a609cdb04008bcf04a6bf0eba239c3_964a2b34db02498784e4f0cfef795c7d_master.jpg', 1),
                                                                          (488, 11, 'Thun giấy xanh bơ', 'https://product.hstatic.net/200000898773/product/z5694949143266_a5de9130ae5c590978d7bbe21cd260c6_7f3532b2117345a589f632ae6d7e01a4_master.jpg', 1),
                                                                          (489, 11, 'Thun giấy dâu', 'https://product.hstatic.net/200000898773/product/z5695003886475_8172008fbf4873fc271b4240a8f33e09_ba61adb45301475eafe3233e7811dc63_master.jpg', 1),
                                                                          (490, 12, 'Thun xốp nhật xanh rêu', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__10__0affb4ee142e4727a15e44ec40536c1e_master.jpg', 1),
                                                                          (491, 12, 'Thun xốp nhật xanh bơ', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__11__0c394427e51e4c0f84558b11b9521b8b_master.jpg', 1),
                                                                          (492, 12, 'Thun xốp nhật đen', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__12__a82a1eec56ee43b2a025dc6b2a1e5cfe_master.jpg', 1),
                                                                          (493, 12, 'Thun xốp nhật tím cà', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__13__03e3a6cc717d4f54a257fb40526b081d_master.jpg', 1),
                                                                          (494, 12, 'Thun xốp nhật đỏ nhung', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__15__82c40cbdc07d4142bfab76be5193b58c_master.jpg', 1),
                                                                          (495, 13, 'Thun ướt xanh lá', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__14__d97f0e37f9fc4ff387e5e1786938681b_master.jpg', 1),
                                                                          (496, 13, 'Thun ướt dâu nhạt', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__15__dc3c942a9ecf492d8f4f8b0902f6806c_master.jpg', 1),
                                                                          (497, 13, 'Thun ướt đen', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__16__2fc0508b44cf406cb411fca66b294a3b_master.jpg', 1),
                                                                          (498, 13, 'Thun ướt kem', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__17__7fd299d6fe594ea597ccddc1402dc6d8_master.jpg', 1),
                                                                          (499, 14, 'Lưới thun dẻo trắng', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___5__bf0f18030726476f8d9aec354ea2a90b_master.jpg', 1),
                                                                          (500, 14, 'Lưới thun dẻo đen', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___6__cf06dc64b4074e16bebbd5d2f62216f1_master.jpg', 1),
                                                                          (501, 14, 'Lưới thun dẻo xanh mint', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___7__9e0c8c4fb14a4fe4a4934aca86f82455_master.jpg', 1),
                                                                          (502, 14, 'Lưới thun dẻo be', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___9__af027d046a5042f79a2b27d2d2935e0c_master.jpg', 1),
                                                                          (503, 14, 'Lưới thun dẻo đỏ', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___10__bdb42b4fc04d485ba2f5066fbbb12649_master.jpg', 1),
                                                                          (504, 15, 'Thun cotton 100% 2 chiều trắng', 'https://product.hstatic.net/200000898773/product/vai-thun-cotton-100-_-250-gsm-2-chieu__2__a088f7256a584e94a8697c9fe2223e95_master.jpg', 1),
                                                                          (505, 15, 'Thun cotton 100% 2 chiều xám chì', 'https://product.hstatic.net/200000898773/product/vai-thun-cotton-100-_-250-gsm-2-chieu__4__69e363c9f804428ca94f70c57243fc3a_master.jpg', 1),
                                                                          (506, 16, 'Thun hàn dày đen', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__10__88d7ac21b4914e36a8930be98ed9982f_master.jpg', 1),
                                                                          (507, 16, 'Thun hàn dày hồng sen', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__20__40f92a2bf9d344c58a439b1ca919f48c_master.jpg', 1),
                                                                          (508, 16, 'Thun hàn dày nâu bò', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__21__310bfcfd3b404744a6c1e2e500dc163b_master.jpg', 1),
                                                                          (509, 16, 'Thun hàn dày xanh than', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__23__68f8552a2c39426ca322f8d4719e1c42_master.jpg', 1),
                                                                          (510, 16, 'Thun hàn dày tím', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__24__41f73b37c16d41b0a4a2fa32062ba1de_master.jpg', 1),
                                                                          (511, 17, 'Thun tăm lạnh đen', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__11__41a32a53dc3d4100b85bfbcf4e1a6c33_master.jpg', 1),
                                                                          (512, 17, 'Thun tăm lạnh trắng', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__12__2c681098a3a345a892f50efeb45eb28c_master.jpg', 1),
                                                                          (513, 17, 'Thun tăm lạnh be', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__13__7826eac35acf4de38cb2f45152ef2792_master.jpg', 1),
                                                                          (514, 17, 'Thun tăm lạnh dâu', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__15__0f30cbc373e54455b04e24a804749389_master.jpg', 1),
                                                                          (515, 17, 'Thun tăm lạnh nâu tây', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__16__5abf4e7f17f9441c920acd0aba60307e_master.jpg', 1),
                                                                          (516, 18, 'Thun co dãn hồng', 'https://product.hstatic.net/200000898773/product/upload_0bcc75beed7947f48221dff7d307d8cf_master.jpg', 1),
                                                                          (517, 18, 'Thun co dãn trắng', 'https://product.hstatic.net/200000898773/product/upload_52b9534b525b41c19fb63ecf3aeec87f_master.jpg', 1),
                                                                          (518, 19, 'Kaki xước hoa nổi xám', 'https://product.hstatic.net/200000898773/product/506-vai-kaki-xuoc-hoa-noi-may-quan-tay-vay-dam-vest-thiet-ke__1__4040d7da88fa4535b126ca1947e43302_master.jpg', 1),
                                                                          (519, 20, 'Jean Chấm Xanh', 'https://product.hstatic.net/200000898773/product/upload_2396fab85c0f4dbca287bd126d2fe21b_master.jpg', 1),
                                                                          (520, 21, 'Jean demin xanh biển', 'https://product.hstatic.net/200000898773/product/1_17e7f222863045308ee85bce8f9ad869_master.jpg', 1),
                                                                          (521, 21, 'Jean demin xanh nhạt', 'https://product.hstatic.net/200000898773/product/2_5dada4e4169e4a3ea4b76087d6c0792c_master.jpg', 1),
                                                                          (522, 21, 'Jean demin xanh trung', 'https://product.hstatic.net/200000898773/product/3_223f83a720864c60b0efc52d1f745cae_master.jpg', 1),
                                                                          (523, 22, 'Jean lụa xanh đậm', 'https://product.hstatic.net/200000898773/product/01_c7e963b8124246be914310ddad9491f6_master.jpg', 1),
                                                                          (524, 22, 'Jean lụa xanh nhạt', 'https://product.hstatic.net/200000898773/product/02_714a147e40c54d088abce23e6d70218e_master.jpg', 1),
                                                                          (525, 22, 'Jean lụa đen', 'https://product.hstatic.net/200000898773/product/03_8eebfbf420ea461d8666261d53d392f6_master.jpg', 1),
                                                                          (526, 23, 'Jean loang xanh', 'https://product.hstatic.net/200000898773/product/802-vai-jean-loang-may-quan-jean-ao-khoac-vay-dam-set__11__bb6154c33757486f913fa3f0584e8260_master.jpg', 1),
                                                                          (587, 208, 'Màu Trắng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfQa6kZV3EQhaIKVkQjVfsWxcP9RdswUh-zg&s', 30),
                                                                          (588, 208, 'Màu Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRzwch8IKcbawSTy6dLyYV7mXujeLNw2F6WGWgRxZOYpzSw4z1MkDznITf_6_bUjzLrYw&usqp=CAU', 35),
                                                                          (589, 208, 'Màu Kem', 'https://img.alicdn.com/i3/1825669215/TB2zS4ZrlmWBuNkSndVXXcsApXa-1825669215.jpg_400x400.jpg_.webp', 35),
                                                                          (590, 209, 'Màu Vàng Nhạt', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTujzzgSYjYDSPLEpU4e3wp75ZAvXRPJCPKjg&s', 25),
                                                                          (591, 209, 'Màu Hồng Phấn', 'https://nhaxasilk.com/wp-content/uploads/2021/05/ST22.jpg', 30),
                                                                          (592, 209, 'Màu Bạc', 'https://product.hstatic.net/200000192953/product/likeakiss_mulberrysilk_xam_silver_1_4adf8b82a2a549dc96c32b9d33a2c81d_master.png', 25),
                                                                          (593, 210, 'Màu Be', 'https://file.hstatic.net/1000361985/article/vai-kaki-la-gi_e7480b5129684cea950712b3e91e8a80.jpg', 50),
                                                                          (594, 210, 'Màu Rêu', 'https://www.vaisoiphuloc.vn/Portals/21677/vai-tuyet-mua-la-gi_1.jpg', 55),
                                                                          (595, 210, 'Màu Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTglrJHWD4fR59RbYAf5S1hq8Gmi_E7ooRw4A&s', 45),
                                                                          (596, 211, 'Màu Tím Nhạt', 'https://cdn.shopify.com/s/files/1/0681/2821/1221/files/36_88be638e-d8ba-400b-aa55-bb985c8b87f1_480x480.jpg?v=1698387390', 40),
                                                                          (597, 211, 'Màu Hồng Nhạt', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lspzehwo87mh6a_tn.webp', 40),
                                                                          (598, 211, 'Màu Xanh Biển', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSh14waUNQmWr1DkxQXOnB5TKHL7cBeJ0l8w&s', 40),
                                                                          (599, 212, 'Màu Đen', 'https://demxanh.com/media/news/2311_vai_denim.jpg', 30),
                                                                          (600, 212, 'Màu Xanh Navy', 'https://everon.com/upload/upload-images/vai-denim-la-gi-2.jpg', 30),
                                                                          (601, 212, 'Màu Xanh Lơ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx2oUVPpIYiVhl4gWctt1oc6Sf4Apbp46hlBJc4MnoSmycpn2R1_TCTCV1-C3crDNJXW0&usqp=CAU', 30),
                                                                          (602, 213, 'Màu Ghi', 'https://media.loveitopcdn.com/6535/vai-tho-dui-la-gi.jpg', 40),
                                                                          (603, 213, 'Màu Nâu', 'https://media.loveitopcdn.com/6535/gioi-thieu-chung-ve-vai-tho-nhung-tam.jpeg', 35),
                                                                          (604, 213, 'Màu Xanh Lá', 'https://down-vn.img.susercontent.com/file/460ae7dca554578139f4eb5497d2f5f3', 35),
                                                                          (605, 214, 'Màu Đỏ Đô', 'https://thanhtungtextile.vn/upload/trang-san-pham/vai-nhung-tuyet/gia-vai-nhung-tuyet3-inkjpeg.jpeg', 25),
                                                                          (606, 214, 'Màu Tím Than', 'https://vietnamese.polyesterspandexfabric.com/photo/pl20408173-high_stretch_burnout_velvet_fabric_embossed_velvet_upholstery_fabric_patterned.jpg', 25),
                                                                          (607, 214, 'Màu Xanh Rêu', 'https://kitasofa.com/wp-content/uploads/2020/01/vai-nhung-ni-sofa-cao-cap.jpg', 25),
                                                                          (608, 215, 'Màu Trắng', 'https://hoangphuconline.vn/media/magefan_blog/2022/02/vai-kate-lua-ava.jpg', 30),
                                                                          (609, 215, 'Màu Xanh Dương', 'https://bizweb.dktcdn.net/100/320/888/files/vai-kate-1-jpeg.jpg?v=1677908112050', 35),
                                                                          (610, 215, 'Màu Cam Nhạt', 'https://lados.vn/wp-content/uploads/2024/09/chat-lieu-vai-kaki-lua.jpg', 30),
                                                                          (611, 216, 'Màu Be', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtaGiP0GbYsJipshwOAA4bEqMZdYFoI4P6iw&s', 30),
                                                                          (612, 216, 'Màu Xanh Lá Mạ', 'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m51d24atszr7a6', 30),
                                                                          (613, 216, 'Màu Vàng Kem', 'https://flaxieslinen.com/wp-content/uploads/2024/04/Stone-170_S06_web-08-682x1024.jpg', 25),
                                                                          (614, 217, 'Màu Trắng Ngà', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrIy5IsWHnQHmzI2VsvT0g-Uxj8xfiYEzEMg&s', 35),
                                                                          (615, 217, 'Màu Xám Nhẹ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv6G2ghcEi7rG0NfGTcSY6elgPeZaOTxcVWA&s', 35),
                                                                          (616, 217, 'Màu Hồng Phấn', 'https://down-vn.img.susercontent.com/file/c93771aad922b95b51af75ff762df08c', 35),
                                                                          (617, 218, 'Màu Nâu Nhạt', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ05oGhMtaLArUs5jfRmtX9GM5b8vsamNO0-w&s', 33),
                                                                          (618, 218, 'Màu Xám Tro', 'https://onoff.vn/blog/wp-content/uploads/2024/10/vai-tuyet-mua-1.jpg', 33),
                                                                          (619, 218, 'Màu Cam Đất', 'https://tamanh.net/wp-content/uploads/2022/09/vai-tuyet-mua-la-gi-copy.jpg', 32),
                                                                          (620, 219, 'Màu Trắng', 'https://cdn.gumac.vn/image2/anh-tin-tuc/vai-phi-bong-la-gi/vai-phi-bong-trang050520221711153351.jpg', 45),
                                                                          (621, 219, 'Màu Đỏ', 'https://down-vn.img.susercontent.com/file/ea99d256a077bd125b6a32592bd00106', 45),
                                                                          (622, 219, 'Màu Xanh Ngọc', 'https://vaihuongquang.vn/wp-content/uploads/2023/02/frame-2.webp', 40),
                                                                          (623, 220, 'Màu Vàng Nhạt', 'https://bizweb.dktcdn.net/100/320/888/articles/vai-ren.jpg?v=1678080803260', 22),
                                                                          (624, 220, 'Màu Hồng Đậm', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiKnorlbDDKAg8VymBMhDctjCXq2DPcergpg&s', 21),
                                                                          (625, 220, 'Màu Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQO44-s0cR7ShfqYlVIpRE3ea9AAPzvn8VFQ&s', 22),
                                                                          (626, 221, 'Màu Hồng', 'https://dony.vn/wp-content/uploads/2024/07/vai-chiffon-6.jpg', 40),
                                                                          (627, 221, 'Màu Cam', 'https://down-vn.img.susercontent.com/file/c95d043df068144dc740ddcb1bb70680', 40),
                                                                          (628, 221, 'Màu Vàng Chanh', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTPRJfuk07ApcmDSOe6oktshZ2wbnv64ADHg&s', 40),
                                                                          (629, 222, 'Màu Ghi Đậm', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__28__13c0337e13f04a0e9f125a9df87c56c1_master.jpg', 28),
                                                                          (630, 222, 'Màu Rêu', 'https://mialala.vn/media/lib/25-07-2023/vicottonlnh-07.png', 28),
                                                                          (631, 222, 'Màu Nâu Đậm', 'https://demxanh.com/media/news/2111_vai_lanh4565.jpg', 29),
                                                                          (632, 223, 'Màu Xanh Đậm', 'https://xuongmaydosi.com/wp-content/uploads/2019/07/Stretch-Denim-la-loai-vai-denim-co-gian.jpg', 47),
                                                                          (633, 223, 'Màu Đen', 'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m0mv6417cxyla9', 47),
                                                                          (634, 223, 'Màu Trắng', 'https://azolaco.com/vnt_upload/product/thoi_trang_nam/DJ32.gif', 46),
                                                                          (635, 224, 'Màu Đỏ Tía', 'https://down-vn.img.susercontent.com/file/1d59ad29af515780ecd0a6ea030c1c6d', 23),
                                                                          (636, 224, 'Màu Vàng Ánh Kim', 'https://vaiaodaimymy.com/wp-content/uploads/2021/12/1640326297_vai-gam-hoa-thai-tuan-mau.jpg', 24),
                                                                          (637, 224, 'Màu Tím Nhạt', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0BjFykhDSnfWHBvuwQxA8eQ4yU0itPTDqVg&s', 23),
                                                                          (638, 225, 'Màu Xám Bạc', 'https://changagoidemsonghong.online/media/news/0106_Modal-Fabric.jpg', 30),
                                                                          (639, 225, 'Màu Trắng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuw9ou9_D9REcmnjUO-PtT2eka8fUc8OrsoQ&s', 29),
                                                                          (640, 225, 'Màu Hồng Nhạt', 'https://khonemtonghop.com/wp-content/uploads/2023/11/vai-modal-co-kha-nang-chong-co-rut-tot.webp', 29),
                                                                          (641, 226, 'Màu Vàng Tươi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRC_ybdpY5VSpSUK-HX1k--qDw0pTkZP6oXQA&s', 38),
                                                                          (642, 226, 'Màu Cam Nhẹ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ws-aTtgzE3CkeP4F-XbyIP7cQAv3OLA7KJdBDFi4LHwcSE8e9_WxG5aA_9Oc1pRFwpc&usqp=CAU', 38),
                                                                          (643, 226, 'Màu Hồng Sen', 'https://thanhtungtextile.vn/upload/trang-san-pham/vai-khac/hoa-nhi/o1cn01zdnx2y1bhfw1aol3d_977113497-0-cib-inkjpeg.jpeg', 39),
                                                                          (644, 227, 'Màu Đỏ Đậm', 'https://dongphuchaianh.vn/wp-content/uploads/2023/12/chat-vai-flannel.jpg', 32),
                                                                          (645, 227, 'Màu Xanh Biển', 'https://vaimaycaocap.com/wp-content/uploads/2022/04/vai-flannel-cavani-thomas-nguyen-fabric-10.jpg', 31),
                                                                          (646, 227, 'Màu Xám Tro', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lv7e1glrsk2i5c', 32);

-- Dumping structure for table project_web.technical_information
CREATE TABLE IF NOT EXISTS `technical_information` (
                                                       `id` int(11) NOT NULL AUTO_INCREMENT,
    `specifications` varchar(255) NOT NULL,
    `manufactureDate` date NOT NULL,
    `releaseDay` date DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.technical_information: ~43 rows (approximately)
DELETE FROM `technical_information`;
INSERT INTO `technical_information` (`id`, `specifications`, `manufactureDate`, `releaseDay`) VALUES
                                                                                                  (1, 'Vải linen mềm mại, thoáng khí.', '2022-12-01', '2023-01-15'),
                                                                                                  (2, 'Vải linen tự nhiên, thân thiện với môi trường.', '2022-11-15', '2023-02-20'),
                                                                                                  (3, 'Vải linen cao cấp, chống nhăn.', '2022-12-10', '2023-03-05'),
                                                                                                  (4, 'Vải linen thoáng mát, thích hợp mùa hè.', '2022-11-20', '2023-04-12'),
                                                                                                  (5, 'Vải linen sang trọng, thích hợp tiệc tùng.', '2022-12-15', '2023-05-25'),
                                                                                                  (6, 'Vải linen nhẹ nhàng, thấm hút mồ hôi.', '2022-11-30', '2023-06-30'),
                                                                                                  (7, 'Vải linen mềm mại, dễ mặc.', '2022-12-05', '2023-07-15'),
                                                                                                  (8, 'Vải linen mềm mại, dễ mặc.', '2022-12-05', '2023-07-15'),
                                                                                                  (9, 'Vải thun cao cấp, chống nhăn.', '2022-12-20', '2023-08-10'),
                                                                                                  (10, 'Vải thun cơ bản, dễ sử dụng.', '2022-12-08', '2024-05-15'),
                                                                                                  (11, 'Vải linen cao cấp, thoáng khí.', '2022-12-18', '2024-06-01'),
                                                                                                  (12, 'Vải thun co giãn, thoải mái khi mặc.', '2022-11-25', '2023-09-18'),
                                                                                                  (13, 'Vải thun dày dặn, bền màu.', '2022-11-10', '2023-10-22'),
                                                                                                  (14, 'Vải thun năng động, phù hợp thể thao.', '2022-11-15', '2023-11-05'),
                                                                                                  (15, 'Vải thun cổ điển, dễ phối đồ.', '2022-12-12', '2023-11-20'),
                                                                                                  (16, 'Vải thun thể thao, thoải mái vận động.', '2022-11-18', '2024-01-15'),
                                                                                                  (17, 'Vải thun hiện đại, phong cách trẻ trung.', '2022-11-28', '2024-04-20'),
                                                                                                  (18, 'Vải thun pha trộn, độc đáo và mới lạ.', '2022-11-28', '2024-06-15'),
                                                                                                  (19, 'Vải kaki chắc chắn, phong cách.', '2022-12-25', '2024-02-20'),
                                                                                                  (20, 'Vải jean bền bỉ, phong cách cá tính.', '2022-12-30', '2024-03-10'),
                                                                                                  (21, 'Vải jean thời trang, cá tính và phong cách.', '2022-12-29', '2024-04-05'),
                                                                                                  (22, 'Vải jean cổ điển, không bao giờ lỗi mốt.', '2022-12-29', '2024-07-01'),
                                                                                                  (23, 'Vải jean bền bỉ, phong cách cá tính.', '2022-12-29', '2024-07-01'),
                                                                                                  (187, '100% cotton, độ bền cao, thoáng khí', '2024-12-15', '2022-02-04'),
                                                                                                  (188, 'Lụa nhân tạo, mềm mại, chịu nhiệt tốt', '2025-01-10', '2025-04-13'),
                                                                                                  (189, 'Kaki pha polyester, co giãn nhẹ', '2024-11-25', '2025-04-13'),
                                                                                                  (190, 'Voan in hoa, nhẹ và thoáng', '2024-12-30', '2025-04-13'),
                                                                                                  (191, 'Denim 95% cotton, 5% elastane', '2025-01-01', '2025-04-13'),
                                                                                                  (192, 'Vải thô dệt sợi to, độ bền cao', '2024-12-20', '2025-04-13'),
                                                                                                  (193, 'Nhung nhập khẩu, dày, bề mặt mịn', '2024-11-18', '2025-04-13'),
                                                                                                  (194, 'Kate 60% cotton, 40% polyester', '2025-01-05', '2025-04-13'),
                                                                                                  (195, 'Linen tự nhiên, thoáng khí, chống nhăn', '2024-12-10', '2025-04-13'),
                                                                                                  (196, 'Lanh mỏng nhẹ, thích hợp mùa hè', '2025-01-12', '2025-04-13'),
                                                                                                  (197, 'Tuyết mưa, co giãn tốt, bề mặt nhẵn', '2025-01-03', '2025-04-13'),
                                                                                                  (198, 'Phi bóng chống nhăn, giữ form tốt', '2024-12-27', '2025-04-13'),
                                                                                                  (199, 'Ren sợi mảnh, hoa văn tinh tế', '2025-01-07', '2025-04-13'),
                                                                                                  (200, 'Chiffon 100% polyester, mỏng nhẹ', '2025-01-08', '2025-04-13'),
                                                                                                  (201, 'Dạ tổng hợp, giữ ấm tốt, mềm mịn', '2024-12-22', '2025-04-13'),
                                                                                                  (202, 'Jean co giãn, bền, khó rách', '2025-01-15', '2025-04-13'),
                                                                                                  (203, 'Gấm dệt hoa, độ dày cao', '2025-01-09', '2025-04-13'),
                                                                                                  (204, 'Modal tự nhiên, co giãn, hút ẩm', '2025-01-11', '2025-04-13'),
                                                                                                  (205, 'Cotton in họa tiết, sắc nét, không phai', '2024-12-28', '2025-04-13'),
                                                                                                  (206, 'Flannel kẻ sọc, mềm mại, giữ nhiệt', '2025-01-04', '2025-04-13');

-- Dumping structure for table project_web.users
CREATE TABLE IF NOT EXISTS `users` (
                                       `id` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(255) DEFAULT NULL,
    `firstName` varchar(100) DEFAULT NULL,
    `lastName` varchar(150) DEFAULT NULL,
    `fullNameGenerated` varchar(255) GENERATED ALWAYS AS (trim(concat_ws(' ',`firstName`,`lastName`))) STORED,
    `phoneNumber` varchar(255) DEFAULT NULL,
    `idAddress` int(11) DEFAULT NULL,
    `image` varchar(255) DEFAULT NULL,
    `createdAt` timestamp NULL DEFAULT current_timestamp(),
    `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `email` (`email`) USING BTREE,
    KEY `users_idaddress_foreign` (`idAddress`) USING BTREE,
    CONSTRAINT `users_idaddress_foreign` FOREIGN KEY (`idAddress`) REFERENCES `addresses` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.users: ~15 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `email`, `firstName`, `lastName`, `phoneNumber`, `idAddress`, `image`, `createdAt`, `updatedAt`) VALUES
                                                                                                                                (1, 'hung1@gmail.com', 'Hưng', 'Lê Đình', '0337057878', 1, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (2, 'lethihanh@gmail.com', 'Hạnh', 'Lê Thị', '0987654321', 2, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (3, 'tranvanbinh@gmail.com', 'Bình', 'Trần Văn', '0934567890', 3, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (4, 'phamthuy@gmail.com', 'Thúy', 'Phạm Thị', '0978123456', 4, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (5, 'hoangminhtuan@gmail.com', 'Tuấn', 'Hoàng Minh', '0923456789', 5, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (6, 'dinhphuong@gmail.com', 'Phượng', 'Đinh Thị', '0945678901', 6, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (7, 'votienthanh@gmail.com', 'Thành', 'Võ Tiến', '0967890123', 7, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (8, 'ngothithao@gmail.com', 'Thảo', 'Ngô Thị', '0901234567', 8, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (9, 'phamvangiang@gmail.com', 'Giang', 'Phạm Văn', '0919876543', 9, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (10, 'tranthuthuy@gmail.com', 'Thủy', 'Trần Thu', '0921098765', 10, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (23, '22130084@st.hcmuaf.edu.vn', 'Hoài', 'Huỳnh Linh', '0377314202', 1, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (25, NULL, 'Name', 'Default', '0000000000', 1, 'default.png', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (26, NULL, 'Name', 'Default', '0000000000', 1, 'default.png', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (27, NULL, 'Name', 'Default', '0000000000', 1, 'default.png', '2025-04-06 04:07:24', '2025-04-06 08:27:57'),
                                                                                                                                (28, NULL, 'Name', 'Default', '0000000000', 1, 'default.png', '2025-04-06 04:07:24', '2025-04-06 08:27:57');

-- Dumping structure for table project_web.user_tokens
CREATE TABLE IF NOT EXISTS `user_tokens` (
                                             `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `idUser` int(11) NOT NULL COMMENT 'Khóa ngoại liên kết tới users.id',
    `tokenHash` varchar(255) NOT NULL COMMENT 'Giá trị token đã được hash (để lưu trữ an toàn)',
    `tokenType` enum('email_verification','reset_password') NOT NULL COMMENT 'Loại token',
    `expiresAt` datetime DEFAULT NULL COMMENT 'Thời gian token hết hạn (NULL nếu không hết hạn)',
    `createdAt` timestamp NULL DEFAULT current_timestamp() COMMENT 'Thời gian token được tạo',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `user_tokens_iduser_foreign` (`idUser`) USING BTREE,
    KEY `user_tokens_tokenhash_index` (`tokenHash`) USING BTREE,
    CONSTRAINT `user_tokens_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='Lưu trữ token xác thực, đặt lại mật khẩu,...';

-- Dumping data for table project_web.user_tokens: ~0 rows (approximately)
DELETE FROM `user_tokens`;

-- Dumping structure for table project_web.vouchers
CREATE TABLE IF NOT EXISTS `vouchers` (
                                          `idVoucher` int(11) NOT NULL AUTO_INCREMENT,
    `code` varchar(255) NOT NULL,
    `discountAmount` double NOT NULL,
    `condition_amount` double NOT NULL,
    `valid` tinyint(4) DEFAULT NULL,
    PRIMARY KEY (`idVoucher`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table project_web.vouchers: ~5 rows (approximately)
DELETE FROM `vouchers`;
INSERT INTO `vouchers` (`idVoucher`, `code`, `discountAmount`, `condition_amount`, `valid`) VALUES
                                                                                                (1, 'VOUCHER01', 100000, 500000, 1),
                                                                                                (2, 'VOUCHER02', 20000, 200000, 1),
                                                                                                (3, 'VOUCHER03', 150000, 750000, 1),
                                                                                                (4, 'VOUCHER04', 300000, 1500000, 1),
                                                                                                (5, 'VOUCHER05', 250000, 1000000, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
