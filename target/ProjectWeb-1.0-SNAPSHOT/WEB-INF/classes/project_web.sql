/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MariaDB
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : project_web

 Target Server Type    : MariaDB
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 08/04/2025 20:33:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_users
-- ----------------------------
DROP TABLE IF EXISTS `account_users`;
CREATE TABLE `account_users`  (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `idUser` int(11) NOT NULL,
                                  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `idRole` int(11) NOT NULL,
                                  `locked` tinyint(4) NOT NULL,
                                  `code` int(11) NULL DEFAULT NULL,
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `account_users_iduser_foreign`(`idUser`) USING BTREE,
                                  INDEX `account_users_role_id_foreign_idx`(`idRole`) USING BTREE,
                                  CONSTRAINT `account_users_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                  CONSTRAINT `account_users_role_id_foreign` FOREIGN KEY (`idRole`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account_users
-- ----------------------------
INSERT INTO `account_users` VALUES (1, 1, 'hung', '123', 2, 1, NULL);
INSERT INTO `account_users` VALUES (3, 3, 'khang', '123', 1, 0, NULL);
INSERT INTO `account_users` VALUES (4, 4, 'phamthuy', 'password101', 1, 1, NULL);
INSERT INTO `account_users` VALUES (5, 5, 'hoangtuan', 'password102', 1, 0, NULL);
INSERT INTO `account_users` VALUES (6, 6, 'dinhphuong', 'password103', 1, 0, NULL);
INSERT INTO `account_users` VALUES (7, 7, 'vothanh', 'password104', 1, 0, NULL);
INSERT INTO `account_users` VALUES (8, 8, 'ngothao', 'password105', 1, 0, NULL);
INSERT INTO `account_users` VALUES (9, 9, 'phamgiang', 'password106', 1, 0, NULL);
INSERT INTO `account_users` VALUES (10, 10, 'tranthuy', 'password107', 1, 1, NULL);
INSERT INTO `account_users` VALUES (16, 23, 'linhhoai', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhbGluaGhvYWk3OTY2NTZAIyQlUUAjZmNmdnlnYg==', 2, 0, 529385);
INSERT INTO `account_users` VALUES (18, 27, 'linhhoai123', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhbGluaGhvYWkxMjM3OTY2NTZAIyQlUUAjZmNmdnlnYg==', 2, 0, 0);
INSERT INTO `account_users` VALUES (19, 28, 'linhhoai1', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhbGluaGhvYWkxNzk2NjU2QCMkJVFAI2ZjZnZ5Z2I=', 1, 0, 0);

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses`  (
                              `id` int(11) NOT NULL AUTO_INCREMENT,
                              `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                              `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                              `ward` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                              `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addresses
-- ----------------------------
INSERT INTO `addresses` VALUES (1, 'Long Bình', 'Đồng Nai', 'Biên Hòa', 'Yết Kiêu');
INSERT INTO `addresses` VALUES (2, 'Hà Nội', 'Hà Nội', 'Đống Đa', 'Xã Đàn');
INSERT INTO `addresses` VALUES (3, 'Hồ Chí Minh', 'Hồ Chí Minh', 'Quận 1', 'Nguyễn Huệ');
INSERT INTO `addresses` VALUES (4, 'Hồ Chí Minh', 'Hồ Chí Minh', 'Quận 3', 'Lê Văn Sỹ');
INSERT INTO `addresses` VALUES (5, 'Đà Nẵng', 'Đà Nẵng', 'Hải Châu', 'Nguyễn Văn Linh');
INSERT INTO `addresses` VALUES (6, 'Đà Nẵng', 'Đà Nẵng', 'Sơn Trà', 'Võ Nguyên Giáp');
INSERT INTO `addresses` VALUES (7, 'Cần Thơ', 'Cần Thơ', 'Ninh Kiều', '30 Tháng 4');
INSERT INTO `addresses` VALUES (8, 'Hải Phòng', 'Hải Phòng', 'Lê Chân', 'Trần Nguyên Hãn');
INSERT INTO `addresses` VALUES (9, 'Huế', 'Thừa Thiên Huế', 'Phú Hội', 'Hùng Vương');
INSERT INTO `addresses` VALUES (10, 'Nha Trang', 'Khánh Hòa', 'Vĩnh Hải', 'Trần Phú');
INSERT INTO `addresses` VALUES (11, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh');
INSERT INTO `addresses` VALUES (12, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh');
INSERT INTO `addresses` VALUES (13, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh');
INSERT INTO `addresses` VALUES (14, 'Linh Trung', '1102 Phạm Văn Đồng', 'Thủ Đức ', 'Hồ Chí Minh');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
                               `id` int(11) NOT NULL AUTO_INCREMENT,
                               `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Vải may mặc');
INSERT INTO `categories` VALUES (2, 'Vải nội thất');
INSERT INTO `categories` VALUES (3, 'Nút áo');
INSERT INTO `categories` VALUES (4, 'Dây kéo');

-- ----------------------------
-- Table structure for deliveries
-- ----------------------------
DROP TABLE IF EXISTS `deliveries`;
CREATE TABLE `deliveries`  (
                               `id` int(11) NOT NULL AUTO_INCREMENT,
                               `idOrder` int(11) NOT NULL,
                               `idAddress` int(11) NOT NULL,
                               `fullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               `phoneNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               `area` double NOT NULL,
                               `deliveryFee` double NOT NULL,
                               `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               `scheduledDateTime` datetime NOT NULL,
                               PRIMARY KEY (`id`) USING BTREE,
                               INDEX `deliveries_idaddress_foreign`(`idAddress`) USING BTREE,
                               CONSTRAINT `deliveries_idaddress_foreign` FOREIGN KEY (`idAddress`) REFERENCES `addresses` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of deliveries
-- ----------------------------
INSERT INTO `deliveries` VALUES (1, 1, 2, 'Nguyen Van A', '0901234567', 20.5, 50, 'Giao nhanh', 'Delivered', '2024-12-18 09:00:00');
INSERT INTO `deliveries` VALUES (2, 2, 3, 'Tran Thi B', '0902345678', 15, 40, 'Giao qua app', 'Pending', '2024-12-18 10:30:00');
INSERT INTO `deliveries` VALUES (3, 3, 4, 'Le Minh C', '0903456789', 25, 60, 'Khuyến mãi', 'Cancelled', '2024-12-18 12:00:00');
INSERT INTO `deliveries` VALUES (4, 4, 5, 'Pham Thi D', '0904567890', 18, 45, 'Giao tận nơi', 'In transit', '2024-12-18 14:00:00');
INSERT INTO `deliveries` VALUES (5, 5, 6, 'Hoang Minh E', '0905678901', 22.5, 55, 'Giao vào buổi tối', 'Delivered', '2024-12-18 17:30:00');
INSERT INTO `deliveries` VALUES (6, 6, 2, 'Nguyen Van A', '0901234567', 20.5, 50, 'Giao nhanh', 'Delivered', '2024-12-18 09:00:00');
INSERT INTO `deliveries` VALUES (7, 7, 3, 'Tran Thi B', '0902345678', 15, 40, 'Giao qua app', 'Pending', '2024-12-18 10:30:00');
INSERT INTO `deliveries` VALUES (8, 8, 4, 'Le Minh C', '0903456789', 25, 60, 'Khuyến mãi', 'Cancelled', '2024-12-18 12:00:00');
INSERT INTO `deliveries` VALUES (9, 9, 5, 'Pham Thi D', '0904567890', 18, 45, 'Giao tận nơi', 'In transit', '2024-12-18 14:00:00');
INSERT INTO `deliveries` VALUES (10, 10, 6, 'Hoang Minh E', '0905678901', 22.5, 55, 'Giao vào buổi tối', 'Delivered', '2024-12-18 17:30:00');
INSERT INTO `deliveries` VALUES (11, 17, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 07:49:53');
INSERT INTO `deliveries` VALUES (12, 18, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 07:53:00');
INSERT INTO `deliveries` VALUES (13, 19, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 07:56:59');
INSERT INTO `deliveries` VALUES (14, 20, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 08:00:12');
INSERT INTO `deliveries` VALUES (15, 21, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-09 08:01:05');
INSERT INTO `deliveries` VALUES (16, 24, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-10 09:02:44');
INSERT INTO `deliveries` VALUES (17, 25, 2, 'Lê Thị Hạnh', '0987654321', 0, 0, '', 'Đang giao hàng', '2025-01-10 09:06:41');
INSERT INTO `deliveries` VALUES (18, 30, 12, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, 'giao hàng lúc 9 giờ', 'Đang giao hàng', '2025-01-10 23:17:58');
INSERT INTO `deliveries` VALUES (19, 31, 13, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, 'hehe', 'Đang giao hàng', '2025-01-11 18:27:46');
INSERT INTO `deliveries` VALUES (20, 32, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, '', 'Đang giao hàng', '2025-01-13 14:45:45');
INSERT INTO `deliveries` VALUES (21, 33, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-13 15:36:09');
INSERT INTO `deliveries` VALUES (22, 34, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, '', 'Đang giao hàng', '2025-01-14 09:27:54');
INSERT INTO `deliveries` VALUES (23, 35, 14, 'Huỳnh Linh Hoài', '0377314202', 0, 30000, 'Giao hàng trong ngày mai', 'Đang giao hàng', '2025-01-14 22:24:11');
INSERT INTO `deliveries` VALUES (24, 36, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-14 23:01:22');
INSERT INTO `deliveries` VALUES (25, 37, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-14 23:02:12');
INSERT INTO `deliveries` VALUES (26, 38, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-14 23:04:01');
INSERT INTO `deliveries` VALUES (27, 39, 1, 'Huỳnh Linh Hoài', '0377314202', 0, 0, '', 'Đang giao hàng', '2025-01-15 10:23:00');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
                            `id` int(11) NOT NULL AUTO_INCREMENT,
                            `idUser` int(11) NULL DEFAULT NULL,
                            `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                            `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                            PRIMARY KEY (`id`) USING BTREE,
                            INDEX `message_iduser_foreign`(`idUser`) USING BTREE,
                            CONSTRAINT `message_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 1, 'title', 'content');
INSERT INTO `message` VALUES (2, 2, 'Tư vấn vải mùa đông', 'Toi muon mua vai');
INSERT INTO `message` VALUES (3, 2, 'Tư vấn vải mùa đông', 'Toi muon mua vai');
INSERT INTO `message` VALUES (4, 2, 'Tư vấn vải mùa đông', 'Mua vai mua dong');
INSERT INTO `message` VALUES (5, 23, 'Tư vấn vải mùa đông', 'hehe');
INSERT INTO `message` VALUES (6, 23, 'Tư vấn vải mùa đông', 'hehe\r\n');
INSERT INTO `message` VALUES (7, 23, 'Tư vấn vải mùa đông', 'hihi');
INSERT INTO `message` VALUES (8, 23, 'Tư vấn vải mùa đông', 'Mua vải mùa đông');

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `idOrder` int(11) NOT NULL,
                                  `idStyle` int(11) NOT NULL,
                                  `quantity` int(11) NOT NULL,
                                  `totalPrice` double NOT NULL,
                                  `weight` double NOT NULL,
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (1, 1, 23, 2, 300000, 1.5);
INSERT INTO `order_details` VALUES (2, 1, 45, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (3, 2, 67, 3, 450000, 2);
INSERT INTO `order_details` VALUES (4, 2, 89, 4, 600000, 3.2);
INSERT INTO `order_details` VALUES (5, 3, 12, 1, 120000, 0.5);
INSERT INTO `order_details` VALUES (6, 3, 34, 2, 240000, 1);
INSERT INTO `order_details` VALUES (7, 4, 56, 5, 750000, 4);
INSERT INTO `order_details` VALUES (8, 4, 78, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (9, 5, 90, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (10, 5, 123, 3, 450000, 2.1);
INSERT INTO `order_details` VALUES (11, 6, 234, 1, 150000, 0.6);
INSERT INTO `order_details` VALUES (12, 6, 345, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (13, 7, 156, 4, 600000, 2.5);
INSERT INTO `order_details` VALUES (14, 7, 267, 1, 120000, 0.4);
INSERT INTO `order_details` VALUES (15, 8, 378, 3, 450000, 1.9);
INSERT INTO `order_details` VALUES (16, 8, 189, 2, 300000, 1.3);
INSERT INTO `order_details` VALUES (17, 9, 11, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (18, 9, 22, 5, 750000, 3.8);
INSERT INTO `order_details` VALUES (19, 10, 33, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (20, 10, 44, 3, 450000, 2);
INSERT INTO `order_details` VALUES (21, 11, 55, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (22, 11, 66, 4, 600000, 3.1);
INSERT INTO `order_details` VALUES (23, 12, 77, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (24, 12, 88, 3, 450000, 2.1);
INSERT INTO `order_details` VALUES (25, 13, 99, 5, 750000, 4.5);
INSERT INTO `order_details` VALUES (26, 13, 110, 1, 150000, 0.9);
INSERT INTO `order_details` VALUES (27, 14, 121, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (28, 14, 132, 4, 600000, 2.8);
INSERT INTO `order_details` VALUES (29, 15, 143, 3, 450000, 2);
INSERT INTO `order_details` VALUES (30, 15, 154, 2, 300000, 1.3);
INSERT INTO `order_details` VALUES (31, 16, 165, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (32, 16, 176, 5, 750000, 3.9);
INSERT INTO `order_details` VALUES (33, 17, 187, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (34, 17, 198, 3, 450000, 2.4);
INSERT INTO `order_details` VALUES (35, 18, 209, 4, 600000, 3);
INSERT INTO `order_details` VALUES (36, 18, 220, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (37, 19, 231, 2, 300000, 1.5);
INSERT INTO `order_details` VALUES (38, 19, 242, 3, 450000, 2.3);
INSERT INTO `order_details` VALUES (39, 20, 253, 5, 750000, 4.7);
INSERT INTO `order_details` VALUES (40, 20, 264, 1, 150000, 0.9);
INSERT INTO `order_details` VALUES (41, 1, 23, 2, 300000, 1.5);
INSERT INTO `order_details` VALUES (42, 1, 45, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (43, 2, 67, 3, 450000, 2);
INSERT INTO `order_details` VALUES (44, 2, 89, 4, 600000, 3.2);
INSERT INTO `order_details` VALUES (45, 3, 12, 1, 120000, 0.5);
INSERT INTO `order_details` VALUES (46, 3, 34, 2, 240000, 1);
INSERT INTO `order_details` VALUES (47, 4, 56, 5, 750000, 4);
INSERT INTO `order_details` VALUES (48, 4, 78, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (49, 5, 90, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (50, 5, 123, 3, 450000, 2.1);
INSERT INTO `order_details` VALUES (51, 6, 234, 1, 150000, 0.6);
INSERT INTO `order_details` VALUES (52, 6, 345, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (53, 7, 156, 4, 600000, 2.5);
INSERT INTO `order_details` VALUES (54, 7, 267, 1, 120000, 0.4);
INSERT INTO `order_details` VALUES (55, 8, 378, 3, 450000, 1.9);
INSERT INTO `order_details` VALUES (56, 8, 189, 2, 300000, 1.3);
INSERT INTO `order_details` VALUES (57, 9, 11, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (58, 9, 22, 5, 750000, 3.8);
INSERT INTO `order_details` VALUES (59, 10, 33, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (60, 10, 44, 3, 450000, 2);
INSERT INTO `order_details` VALUES (61, 11, 55, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (62, 11, 66, 4, 600000, 3.1);
INSERT INTO `order_details` VALUES (63, 12, 77, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (64, 12, 88, 3, 450000, 2.1);
INSERT INTO `order_details` VALUES (65, 13, 99, 5, 750000, 4.5);
INSERT INTO `order_details` VALUES (66, 13, 110, 1, 150000, 0.9);
INSERT INTO `order_details` VALUES (67, 14, 121, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (68, 14, 132, 4, 600000, 2.8);
INSERT INTO `order_details` VALUES (69, 15, 143, 3, 450000, 2);
INSERT INTO `order_details` VALUES (70, 15, 154, 2, 300000, 1.3);
INSERT INTO `order_details` VALUES (71, 16, 165, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (72, 16, 176, 5, 750000, 3.9);
INSERT INTO `order_details` VALUES (73, 17, 187, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (74, 17, 198, 3, 450000, 2.4);
INSERT INTO `order_details` VALUES (75, 18, 209, 4, 600000, 3);
INSERT INTO `order_details` VALUES (76, 18, 220, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (77, 19, 231, 2, 300000, 1.5);
INSERT INTO `order_details` VALUES (78, 19, 242, 3, 450000, 2.3);
INSERT INTO `order_details` VALUES (79, 20, 253, 5, 750000, 4.7);
INSERT INTO `order_details` VALUES (80, 20, 264, 1, 150000, 0.9);
INSERT INTO `order_details` VALUES (83, 17, 356, 1, 450000, 0.5);
INSERT INTO `order_details` VALUES (84, 17, 358, 10, 2850000, 5);
INSERT INTO `order_details` VALUES (85, 18, 355, 10, 4500000, 5);
INSERT INTO `order_details` VALUES (86, 19, 355, 10, 4500000, 5);
INSERT INTO `order_details` VALUES (87, 19, 357, 10, 2850000, 5);
INSERT INTO `order_details` VALUES (88, 20, 355, 10, 4500000, 5);
INSERT INTO `order_details` VALUES (89, 21, 355, 10, 4500000, 5);
INSERT INTO `order_details` VALUES (90, 21, 372, 2, 1520000, 1);
INSERT INTO `order_details` VALUES (91, 24, 355, 3, 1350000, 1.5);
INSERT INTO `order_details` VALUES (92, 24, 358, 10, 2850000, 5);
INSERT INTO `order_details` VALUES (93, 25, 358, 10, 2850000, 5);
INSERT INTO `order_details` VALUES (94, 26, 5, 10, 19000, 5);
INSERT INTO `order_details` VALUES (95, 26, 373, 1, 760000, 0.5);
INSERT INTO `order_details` VALUES (96, 26, 358, 1, 285000, 0.5);
INSERT INTO `order_details` VALUES (97, 27, 355, 10, 4500000, 5);
INSERT INTO `order_details` VALUES (98, 28, 357, 1, 285000, 0.5);
INSERT INTO `order_details` VALUES (99, 28, 393, 1, 540000, 0.5);
INSERT INTO `order_details` VALUES (100, 28, 396, 1, 220000, 0.5);
INSERT INTO `order_details` VALUES (101, 28, 383, 1, 467500, 0.5);
INSERT INTO `order_details` VALUES (102, 29, 358, 10, 2850000, 5);
INSERT INTO `order_details` VALUES (103, 29, 375, 2, 738000, 1);
INSERT INTO `order_details` VALUES (104, 29, 360, 2, 595000, 1);
INSERT INTO `order_details` VALUES (105, 30, 2, 1, 4500, 0.5);
INSERT INTO `order_details` VALUES (106, 30, 6, 1, 1900, 0.5);
INSERT INTO `order_details` VALUES (107, 30, 359, 1, 285000, 0.5);
INSERT INTO `order_details` VALUES (108, 31, 358, 6, 1710000, 3);
INSERT INTO `order_details` VALUES (109, 32, 184, 10, 270000, 5);
INSERT INTO `order_details` VALUES (110, 33, 355, 10, 4500000, 5);
INSERT INTO `order_details` VALUES (111, 33, 359, 1, 285000, 0.5);
INSERT INTO `order_details` VALUES (112, 34, 21, 1, 22500, 0.5);
INSERT INTO `order_details` VALUES (113, 34, 24, 1, 22500, 0.5);
INSERT INTO `order_details` VALUES (114, 35, 24, 10, 225000, 5);
INSERT INTO `order_details` VALUES (115, 36, 369, 10, 6300000, 5);
INSERT INTO `order_details` VALUES (116, 36, 385, 1, 285000, 0.5);
INSERT INTO `order_details` VALUES (117, 37, 417, 10, 1584000, 5);
INSERT INTO `order_details` VALUES (118, 37, 411, 10, 2760000, 5);
INSERT INTO `order_details` VALUES (119, 38, 368, 3, 1584000, 1.5);
INSERT INTO `order_details` VALUES (120, 38, 369, 20, 12600000, 10);
INSERT INTO `order_details` VALUES (121, 39, 357, 10, 2850000, 5);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `timeOrder` datetime NOT NULL,
                           `idUser` int(11) NOT NULL,
                           `idVoucher` int(11) NULL DEFAULT NULL,
                           `statusOrder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `totalPrice` double NOT NULL,
                           `lastPrice` double NOT NULL,
                           PRIMARY KEY (`id`) USING BTREE,
                           INDEX `orders_iduser_foreign`(`idUser`) USING BTREE,
                           INDEX `orders_idVoucher_foreign`(`idVoucher`) USING BTREE,
                           CONSTRAINT `orders_idVoucher_foreign` FOREIGN KEY (`idVoucher`) REFERENCES `vouchers` (`idVoucher`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                           CONSTRAINT `orders_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2025-12-01 10:30:00', 1, 1, 'Chưa thanh toán', 150000, 135000);
INSERT INTO `orders` VALUES (2, '2025-12-01 11:15:00', 2, NULL, 'Đã thanh toán', 200000, 200000);
INSERT INTO `orders` VALUES (3, '2025-12-02 14:00:00', 3, 1, 'Chưa thanh toán', 250000, 225000);
INSERT INTO `orders` VALUES (4, '2025-12-03 09:45:00', 4, NULL, 'Chưa thanh toán', 100000, 100000);
INSERT INTO `orders` VALUES (5, '2025-12-03 12:00:00', 5, 3, 'Đã thanh toán', 300000, 270000);
INSERT INTO `orders` VALUES (6, '2025-12-04 16:30:00', 6, NULL, 'Đã thanh toán', 50000, 50000);
INSERT INTO `orders` VALUES (7, '2025-12-05 08:20:00', 7, 1, 'Chưa thanh toán', 120000, 108000);
INSERT INTO `orders` VALUES (8, '2025-12-05 19:00:00', 8, NULL, 'Đã thanh toán', 450000, 450000);
INSERT INTO `orders` VALUES (9, '2025-12-06 11:50:00', 9, 2, 'Chưa thanh toán', 600000, 540000);
INSERT INTO `orders` VALUES (10, '2025-12-07 15:10:00', 10, NULL, 'Chưa thanh toán', 700000, 700000);
INSERT INTO `orders` VALUES (11, '2025-01-07 07:13:46', 1, 1, 'Đang giao hàng', 500, 450);
INSERT INTO `orders` VALUES (17, '2025-03-07 07:49:53', 2, NULL, 'Đang giao hàng', 3300000, 3300000);
INSERT INTO `orders` VALUES (18, '2025-03-07 07:53:00', 2, NULL, 'Đang giao hàng', 4500000, 4500000);
INSERT INTO `orders` VALUES (19, '2025-04-07 07:56:59', 2, NULL, 'Đang giao hàng', 7350000, 7350000);
INSERT INTO `orders` VALUES (20, '2025-04-07 08:00:12', 2, NULL, 'Đang giao hàng', 4500000, 4500000);
INSERT INTO `orders` VALUES (21, '2025-09-07 08:01:05', 2, NULL, 'Đang giao hàng', 6020000, 6020000);
INSERT INTO `orders` VALUES (25, '2025-11-08 09:06:41', 2, 5, 'Đang giao hàng', 2850000, 2600000);
INSERT INTO `orders` VALUES (26, '2025-10-08 23:01:05', 23, 1, 'Đang giao hàng', 1064000, 994000);
INSERT INTO `orders` VALUES (27, '2025-01-08 23:09:02', 23, NULL, 'Đang giao hàng', 4500000, 4500000);
INSERT INTO `orders` VALUES (28, '2025-04-08 23:11:11', 23, NULL, 'Đang giao hàng', 1512500, 1532500);
INSERT INTO `orders` VALUES (29, '2025-12-08 23:13:30', 23, NULL, 'Đang giao hàng', 4183000, 4183000);
INSERT INTO `orders` VALUES (30, '2025-02-08 23:17:58', 23, NULL, 'Đang giao hàng', 291400, 321400);
INSERT INTO `orders` VALUES (31, '2025-05-09 18:27:46', 23, 5, 'Đang giao hàng', 1710000, 1490000);
INSERT INTO `orders` VALUES (32, '2025-02-11 14:45:45', 23, NULL, 'Đang giao hàng', 270000, 300000);
INSERT INTO `orders` VALUES (33, '2025-06-11 15:36:09', 23, 5, 'Đang giao hàng', 4785000, 4535000);
INSERT INTO `orders` VALUES (34, '2025-07-12 09:27:54', 23, NULL, 'Đang giao hàng', 45000, 75000);
INSERT INTO `orders` VALUES (35, '2025-01-12 22:24:11', 23, NULL, 'Đang giao hàng', 225000, 255000);
INSERT INTO `orders` VALUES (36, '2025-08-12 23:01:22', 23, 5, 'Đang giao hàng', 6585000, 6335000);
INSERT INTO `orders` VALUES (37, '2025-07-12 23:02:12', 23, 1, 'Đang giao hàng', 4344000, 4244000);
INSERT INTO `orders` VALUES (38, '2025-01-12 23:04:01', 23, NULL, 'Đang giao hàng', 14184000, 14184000);
INSERT INTO `orders` VALUES (39, '2025-01-13 10:23:00', 23, 5, 'Đang giao hàng', 2850000, 2600000);

-- ----------------------------
-- Table structure for payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `idOrder` int(11) NOT NULL,
                             `method` tinyint(4) NOT NULL,
                             `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `time` datetime NOT NULL,
                             `price` double NOT NULL,
                             PRIMARY KEY (`id`) USING BTREE,
                             INDEX `payments_idorder_foreign`(`idOrder`) USING BTREE,
                             CONSTRAINT `payments_idorder_foreign` FOREIGN KEY (`idOrder`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payments
-- ----------------------------
INSERT INTO `payments` VALUES (1, 2, 1, 'Completed', '2024-12-17 10:00:00', 150);
INSERT INTO `payments` VALUES (2, 3, 2, 'Pending', '2024-12-17 11:00:00', 200);
INSERT INTO `payments` VALUES (3, 4, 1, 'Completed', '2024-12-17 12:00:00', 120);
INSERT INTO `payments` VALUES (4, 5, 2, 'Completed', '2024-12-17 14:00:00', 250);

-- ----------------------------
-- Table structure for prices
-- ----------------------------
DROP TABLE IF EXISTS `prices`;
CREATE TABLE `prices`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `price` double NOT NULL,
                           `discountPercent` double NOT NULL,
                           `lastPrice` double GENERATED ALWAYS AS (`price` * (1 - `discountPercent` / 100)) PERSISTENT,
                           `startDate` DATETIME NULL ,
                           `endDate` DATETIME NULL,
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prices
-- ----------------------------
INSERT INTO `prices` VALUES (1, 5000, 10, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (2, 2000, 10, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (3, 30000, 15, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (4, 50000, 20, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (5, 15000, 5, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (6, 25000, 10, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (7, 50000, 25, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (8, 35000, 10, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (9, 10000, 5, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (10, 45000, 15, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (11, 50000, 30, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (12, 12000, 0, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (13, 18000, 10, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (14, 45000, 20, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (15, 40000, 10, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (16, 50000, 25, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (17, 30000, 5, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (18, 45000, 15, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (19, 50000, 20, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (20, 50000, 30, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (21, 40000, 10, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (22, 50000, 5, DEFAULT,NOW(),NULL);
INSERT INTO `prices` VALUES (23, 30000, 0, DEFAULT,NOW(),NULL);


-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `quantity` int(11) NOT NULL,
                             `addedDate` date NOT NULL,
                             `idCategory` int(11) NOT NULL,
                             `height` DOUBLE NULL ,
                             `width` DOUBLE NULL ,
                             `weight` DOUBLE NULL  ,
                             `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `selling` tinyint(4) NOT NULL,
                             `idTechnical` int(11) NOT NULL,
                             `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `idPrice` int(11) NOT NULL,
                             PRIMARY KEY (`id`) USING BTREE,
                             INDEX `products_idcategory_foreign`(`idCategory`) USING BTREE,
                             INDEX `products_idtechnical_foreign`(`idTechnical`) USING BTREE,
                             CONSTRAINT `products_idcategory_foreign` FOREIGN KEY (`idCategory`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                             CONSTRAINT `products_idtechnical_foreign` FOREIGN KEY (`idTechnical`) REFERENCES `technical_information` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 185 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;
CREATE TABLE ware_house (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            importDate DATETIME DEFAULT CURRENT_TIMESTAMP,
                            updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE inventory (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           idProduct INT NOT NULL,
                           idWareHouse INT NOT NULL,
                           quantityBefore INT DEFAULT 0,
                           quantityLoss INT DEFAULT 0,
                           quantityImported INT DEFAULT 0,
                           quantityTotal INT AS (quantityBefore - quantityLoss + quantityImported) STORED,
                           importDate DATE NOT NULL,
                           FOREIGN KEY (idWareHouse) REFERENCES ware_house(id),
                           FOREIGN KEY (idProduct) REFERENCES products(id)
);
-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO products (name, quantity, addedDate, idCategory, height, width, weight, description, selling, idTechnical, img, idPrice)
VALUES
    ('Linen Bột', 20, '2025-04-08', 1, 50.5, 60.3, 0.8, 'vải cotton cao cấp', 1, 1, 'https://product.hstatic.net/200000898773/product/00_f90ef99c88dd4fc384abad51dc497172_master.jpg', 1),
    ('Linen Tưng Hàn', 35, '2025-04-05', 1, 45.0, 70.2, 1.2, 'vải lụa mềm mại', 1, 2, 'https://product.hstatic.net/200000898773/product/upload_8bceb0438f664f5ea5dacfa31e87af76_master.jpg
', 2),
    ('Linen Bố Gân', 12, '2025-04-02', 1, 60.0, 80.0, 0.9, 'vải bố dày dặn', 0, 3, 'https://product.hstatic.net/200000898773/product/upload_5c893063cad64535b0095413662c65e8_master.jpg
', 3),
    ('Linen cotton lạnh', 25, '2025-03-30', 1, 55.2, 75.1, 1.1, 'vải kaki bền màu', 1, 4, 'https://product.hstatic.net/200000898773/product/110-vai-linen-cotton-lanh-min-mat-chong-nhan-may-so-mi-vay-dam-bo__1__f6b195bc103b49c485a2da4a22b80bc2_master.jpg', 4),
    ('Linen tưng ướt', 18, '2025-03-28', 1, 48.0, 68.4, 0.7, 'vải thun co giãn', 0, 5,'https://product.hstatic.net/200000898773/product/00__2__3e2ac73090724bad9253c7f05ce1dee4_master.jpg', 5),
    ('Linen bamboo', 22, '2025-03-25', 1, 52.7, 69.9, 1.0, 'vải linen thoáng mát', 1, 6, 'https://product.hstatic.net/200000898773/product/vai-linen-bamboo__1__99439c1b192d42e991e33a4dd564e639_master.jpg', 6),
    ('Linen bột dày', 30, '2025-03-24', 1, 57.6, 72.5, 1.3, 'vải dạ ấm áp', 1, 7, 'https://product.hstatic.net/200000898773/product/11_1000ff25414e489cb85ae7666f58dd39_master.jpg', 7),
    ('Linen gân nhật', 16, '2025-03-20', 1, 42.4, 65.0, 0.6, 'vải jean năng động', 1, 8, 'https://product.hstatic.net/200000898773/product/upload_35eae0b1726a47e79b52d54463512913_master.jpg', 8),
    ('Thun gân tăm', 40, '2025-03-18', 1, 49.9, 67.2, 1.1, 'vải nỉ cao cấp', 0, 9, 'https://product.hstatic.net/200000898773/product/upload_7b0850c4e69c4820a974d52124f55870_master.jpg', 9),
    ('Thun sóng', 28, '2025-03-16', 1, 53.3, 70.6, 1.4, 'vải canvas bền đẹp', 1, 10, 'https://product.hstatic.net/200000898773/product/vai-thun-gan-song-gian-4c__1__469c4cb081674b3e8570f2cce028d010_master.jpg', 10),
    ('Thun giấy', 21, '2025-03-14', 1, 46.6, 66.5, 0.9, 'vải nhung mịn màng', 1, 11, 'https://product.hstatic.net/200000898773/product/vai-thun-giay-mong-mat__1__9548fb7d6f9844ae9addac1280796e30_master.jpg
', 11),
    ('Thun xốp nhật', 19, '2025-03-12', 1, 58.1, 73.4, 1.2, 'vải gấm họa tiết', 0, 12, 'https://product.hstatic.net/200000898773/product/upload_78acea25c3e4458aa43b89d22e2e4489_master.jpg
', 12),
    ('Thun ướt', 34, '2025-03-10', 1, 51.2, 69.8, 1.0, 'vải taffeta chống nước', 1, 13, 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__1__6d8677fe59f343bf8e90d767ca8d78eb_master.jpg
', 13),
    ('Lưới thun dẻo', 27, '2025-03-08', 1, 54.4, 71.1, 0.8, 'vải organza nhẹ', 0, 14, 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke__1', 14),
    ('Thun cotton 100% 2 chiều', 32, '2025-03-06', 1, 47.3, 66.9, 0.7, 'vải chiffon bay bổng', 1, 15, 'https://product.hstatic.net/200000898773/product/upload_e2d7b48c7f364913898d44bd782a4af1_master.jpg
', 15),
    ('Thun hàn dày', 23, '2025-03-04', 1, 56.8, 74.2, 1.3, 'vải voan sang trọng', 1, 16, 'https://product.hstatic.net/200000898773/product/upload_d53f6dec5d2b4cc6868b0a977dc3fe09_master.jpg
', 16),
    ('Thun tăm lạnh', 38, '2025-03-02', 1, 50.6, 68.3, 1.0, 'vải cashmere mịn', 0, 17, 'https://product.hstatic.net/200000898773/product/upload_b019968cfbbe496cb15313d7d4897076_master.jpg
', 17),
    ('Thun co dãn', 29, '2025-02-28', 1, 44.7, 64.8, 0.9, 'vải tweed cổ điển', 1, 18, 'https://product.hstatic.net/200000898773/product/upload_cb178eb1ccbf4ab6ac990669de42923c_master.jpg
', 18),
    ('Kaki xước hoa nổi', 33, '2025-02-26', 1, 59.5, 76.0, 1.2, 'vải polyester bền', 1, 19, 'https://product.hstatic.net/200000898773/product/506-vai-kaki-xuoc-hoa-noi-may-quan-tay-vay-dam-vest-thiet-ke__1__', 19),
    ('Jean Chấm', 17, '2025-02-24', 1, 43.9, 63.7, 0.6, 'vải rayon mềm mát', 1, 20, 'https://product.hstatic.net/200000898773/product/upload_fc8717f020c64a5c83ce03028cf5eebe_master.jpg
', 20),
    ('Jean demin', 24, '2025-02-22', 1, 55.9, 71.6, 1.1, 'vải modal hút ẩm', 0, 21, 'https://product.hstatic.net/200000898773/product/upload_9c56871814ad4fc0ba48af9a4aa8f6f4_master.jpg
', 21),
    ('Jean lụa', 36, '2025-02-20', 1, 61.2, 77.3, 1.3, 'vải spandex co dãn', 1, 22, 'https://product.hstatic.net/200000898773/product/upload_ea9df28aa38f43c585d64d9aaa8a0993_master.jpg
', 22),
    ('jean loang', 26, '2025-02-18', 1, 52.0, 70.0, 1.0, 'vải nylon chống thấm', 1, 23, 'https://product.hstatic.net/200000898773/product/upload_981854ba7eb5427d883f3d0d33c5bf07_master.jpg
', 23);


-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
                          `id` int(11) NOT NULL AUTO_INCREMENT,
                          `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tên vai trò (vd: Admin, User, Moderator)',
                          PRIMARY KEY (`id`) USING BTREE,
                          UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Lưu trữ các vai trò người dùng' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (2, 'Admin');
INSERT INTO `roles` VALUES (1, 'User');

-- ----------------------------
-- Table structure for styles
-- ----------------------------
DROP TABLE IF EXISTS `styles`;
CREATE TABLE `styles`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `idProduct` int(11) NOT NULL,
                           `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
                           `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `quantity` int(11) NOT NULL,
                           PRIMARY KEY (`id`) USING BTREE,
                           INDEX `styles_idproduct_foreign`(`idProduct`) USING BTREE,
                           CONSTRAINT `styles_idproduct_foreign` FOREIGN KEY (`idProduct`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 446 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of styles
-- ----------------------------
INSERT INTO `styles` (`idProduct`, `name`, `image`, `quantity`) VALUES
                                                                    (1, 'Linen Bột xanh da trời', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__3__3c9c3f26e7224b4796827ae0b001f3ab_master.jpg', 1),
                                                                    (1, 'Linen Bột trắng tinh', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__4__497a1b76ddab4fe1b48533cc9273ed3b_master.jpg', 1),
                                                                    (1, 'Linen Bột Muối tiêu', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__7__61ffb81f86fe4800b1d735d89a0e35f3_master.jpg', 1),
                                                                    (1, 'Linen Bột đen', 'https://product.hstatic.net/200000898773/product/linen-bot-mat__15__0c9852186a4b4d7788669457e4bc2594_master.jpg', 1),
                                                                    (1, 'Linen Bột xanh Carolina', 'https://product.hstatic.net/200000898773/product/z4854448267372_cb08f468ebcedd209900293a18c40cc7_49fedc489e174f81892ace51c9e8cb64_master.jpg', 1),

                                                                    (2, 'Linen Tưng Hàn Kem', 'https://product.hstatic.net/200000898773/product/upload_8bceb0438f664f5ea5dacfa31e87af76_master.jpg', 1),
                                                                    (2, 'Linen Tưng Hàn Xanh da trời', 'https://product.hstatic.net/200000898773/product/upload_bd349e85b0894056b62b208d3c48e2ed_master.jpg', 1),
                                                                    (2, 'Linen Tưng Hàn đen', 'https://product.hstatic.net/200000898773/product/02_4c6680d5388a41a68e94fab7227b37cd_master.jpg', 1),
                                                                    (2, 'Linen Tưng Hàn nâu', 'https://product.hstatic.net/200000898773/product/07_57d4fd19520d40b58014cce3fc551605_master.jpg', 1),

                                                                    (3, 'Linen Bố Gân do nhung', 'https://product.hstatic.net/200000898773/product/01_a78977897050428591120b8fe5ca8686_master.jpg', 1),
                                                                    (3, 'Linen Bố Gân xanh lá', 'https://product.hstatic.net/200000898773/product/02_4976a7977cb945478b9076be4b9b9356_master.jpg', 1),
                                                                    (3, 'Linen Bố Gân da đậm', 'https://product.hstatic.net/200000898773/product/04_dcaef903b11e4fb597b5d776c069d5a3_master.jpg', 1),
                                                                    (3, 'Linen Bố Gân trắng', 'https://product.hstatic.net/200000898773/product/07_08131ef255c34d9b99409ca613b3a475_master.jpg', 1),

                                                                    (4, 'Linen cotton lạnh Hồng baby', 'https://product.hstatic.net/200000898773/product/01_d446d33fcbc24e4f89b90a3829908942_master.jpg', 1),
                                                                    (4, 'Linen cotton lạnh xanh đen', 'https://product.hstatic.net/200000898773/product/15_2567b2293f564bbfaee710cf21c855cd_master.jpg', 1),
                                                                    (4, 'Linen cotton lạnh nâu cacao', 'https://product.hstatic.net/200000898773/product/24_31003a51e2e44d98b6c10ad989b4b798_master.jpg', 1),
                                                                    (4, 'Linen cotton lạnh xanh dâu', 'https://product.hstatic.net/200000898773/product/110-vai-linen-cotton-lanh-min-mat-chong-nhan-may-so-mi-vay-dam-bo__17__37c31b1635794331a2f0147fa8e179e9_master.jpg', 1),

                                                                    (5, 'Linen tưng ướt đen', 'https://product.hstatic.net/200000898773/product/03-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__2__abf3b6e1abe9414ba4af1b52a5327c27_master.jpg', 1),
                                                                    (5, 'Linen tưng ướt muối tiêu', 'https://product.hstatic.net/200000898773/product/03-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__3__a26009d329f347f990b6c7c706e074b0_master.jpg', 1),
                                                                    (5, 'Linen tưng ướt xanh đá', 'https://product.hstatic.net/200000898773/product/3-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__14__b00f01469f4b43d0a98a6e1e6e2a0833_master.jpg', 1),
                                                                    (5, 'Linen tưng ướt Xanh cameo', 'https://product.hstatic.net/200000898773/product/3-vai-linen-tung-uot-premium-may-ao-so-mi-vay-dam-set-bo-thiet-ke__17__da23073faba34a5d80fd0d7a37126855_master.jpg', 1),

                                                                    (6, 'Linen bamboo trắng', 'https://product.hstatic.net/200000898773/product/upload_b550ba94cece49ab866741d7a9d92388_master.jpg', 1),

                                                                    (7, 'Linen bột dày', 'https://product.hstatic.net/200000898773/product/11_1000ff25414e489cb85ae7666f58dd39_master.jpg', 1),
                                                                    (7, 'Linen bột dày trắng', 'https://product.hstatic.net/200000898773/product/11_1000ff25414e489cb85ae7666f58dd39_master.jpg', 1),

                                                                    (8, 'Linen gân nhật xanh', 'https://product.hstatic.net/200000898773/product/upload_5797bb8020dd43ccbeb6efcb1ac70036_master.jpg', 1),
                                                                    (8, 'Linen gân nhật đen', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__11__3c4a4b3c897f4b6f9c598647c72c83a2_master.jpg', 1),
                                                                    (8, 'Linen gân nhật trắng', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__12__db74a652f477491c9203d013d78fe178_master.jpg', 1),
                                                                    (8, 'Linen gân nhật xanh da trời', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__15__8f698b4ea4464c429b4d0cd59343edbb_master.jpg', 1),
                                                                    (8, 'Linen gân nhật đỏ', 'https://product.hstatic.net/200000898773/product/vai-linen-gan-nhat__17__ebf67c37e8f54bd8b20141465b8d3b92_master.jpg', 1),

                                                                    (9, 'Thun gân tăm trắng gạo', 'https://product.hstatic.net/200000898773/product/upload_7b0850c4e69c4820a974d52124f55870_master.jpg', 1),
                                                                    (9, 'Thun gân tăm đen', 'https://product.hstatic.net/200000898773/product/upload_5620aff9c123413f8323cace13ef71ea_master.jpg', 1),
                                                                    (9, 'Thun gân tăm xanh bơ', 'https://product.hstatic.net/200000898773/product/z5688530491253_0eb312480a5291d811e547f48a6cc240_d231f089ac944eb5a42b026369dd6afa_master.jpg', 1),
                                                                    (9, 'Thun gân tăm tím', 'https://product.hstatic.net/200000898773/product/z5688530497370_676caab435a983767b69b6cc119c56291_cd3610714f0d4f6e9c43199f282dfa07_master.jpg', 1),
                                                                    (9, 'Thun gân tăm cam', 'https://product.hstatic.net/200000898773/product/z5688530539659_a81d2662501c6ee51cd1d113901f2790_53b596d9f2e3482cb11c9d31a5569d42_master.jpg', 1),

                                                                    (10, 'Thun sóng kem', 'https://product.hstatic.net/200000898773/product/z5695162812219_b2077366ce331cb8d28436db56d75145_5ea0644732f049e28b312b302a2c4898_master.jpg', 1),
                                                                    (10, 'Thun sóng trắng', 'https://product.hstatic.net/200000898773/product/z5695249703766_01a067b78d41ec98d1c49c72c6b173d2_4132b186f4884f32a30cf9901ced757e_master.jpg', 1),
                                                                    (10, 'Thun sóng xanh bơ', 'https://product.hstatic.net/200000898773/product/z5695262408270_010df517460e6958e38619fd838f5364_b2977f81caea4f3ab8f67ffbc7c24a37_master.jpg', 1),
                                                                    (10, 'Thun sóng hồng', 'https://product.hstatic.net/200000898773/product/z5695286517664_fe6e421a316cfea8e3d02ae8b1482de6_c87476f1d2bc4124a970e4f91f588f14_master.jpg', 1),
                                                                    (10, 'Thun sóng đen', 'https://product.hstatic.net/200000898773/product/z5695336161796_87dfc4713a21fbe7eb54b131f8571814_34496a1931c340188aaf7fdd47914d9f_master.jpg', 1),

                                                                    (11, 'Thun giấy xanh môn', 'https://product.hstatic.net/200000898773/product/z5694869951710_480014f65edff1f194e8c46e42842fc5_b3157a89fe124cdeadc3421214fd2413_master.jpg', 1),
                                                                    (11, 'Thun giấy đen', 'https://product.hstatic.net/200000898773/product/z5694881209741_d2891080adc3189224049a807ac180d9_ff59991b45974abeb14916756d81413f_master.jpg', 1),
                                                                    (11, 'Thun giấy nâu tây', 'https://product.hstatic.net/200000898773/product/z5694911231190_18a609cdb04008bcf04a6bf0eba239c3_964a2b34db02498784e4f0cfef795c7d_master.jpg', 1),
                                                                    (11, 'Thun giấy xanh bơ', 'https://product.hstatic.net/200000898773/product/z5694949143266_a5de9130ae5c590978d7bbe21cd260c6_7f3532b2117345a589f632ae6d7e01a4_master.jpg', 1),
                                                                    (11, 'Thun giấy dâu', 'https://product.hstatic.net/200000898773/product/z5695003886475_8172008fbf4873fc271b4240a8f33e09_ba61adb45301475eafe3233e7811dc63_master.jpg', 1),

                                                                    (12, 'Thun xốp nhật xanh rêu', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__10__0affb4ee142e4727a15e44ec40536c1e_master.jpg', 1),
                                                                    (12, 'Thun xốp nhật xanh bơ', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__11__0c394427e51e4c0f84558b11b9521b8b_master.jpg', 1),
                                                                    (12, 'Thun xốp nhật đen', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__12__a82a1eec56ee43b2a025dc6b2a1e5cfe_master.jpg', 1),
                                                                    (12, 'Thun xốp nhật tím cà', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__13__03e3a6cc717d4f54a257fb40526b081d_master.jpg', 1),
                                                                    (12, 'Thun xốp nhật đỏ nhung', 'https://product.hstatic.net/200000898773/product/204-vai-thun-xop-nhat-co-gian-4c__15__82c40cbdc07d4142bfab76be5193b58c_master.jpg', 1),

                                                                    (13, 'Thun ướt xanh lá', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__14__d97f0e37f9fc4ff387e5e1786938681b_master.jpg', 1),
                                                                    (13, 'Thun ướt dâu nhạt', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__15__dc3c942a9ecf492d8f4f8b0902f6806c_master.jpg', 1),
                                                                    (13, 'Thun ướt đen', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__16__2fc0508b44cf406cb411fca66b294a3b_master.jpg', 1),
                                                                    (13, 'Thun ướt kem', 'https://product.hstatic.net/200000898773/product/vai-thun-uot-co-gian-4c__17__7fd299d6fe594ea597ccddc1402dc6d8_master.jpg', 1),

                                                                    (14, 'Lưới thun dẻo trắng', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___5__bf0f18030726476f8d9aec354ea2a90b_master.jpg', 1),
                                                                    (14, 'Lưới thun dẻo đen', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___6__cf06dc64b4074e16bebbd5d2f62216f1_master.jpg', 1),
                                                                    (14, 'Lưới thun dẻo xanh mint', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___7__9e0c8c4fb14a4fe4a4934aca86f82455_master.jpg', 1),
                                                                    (14, 'Lưới thun dẻo be', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___9__af027d046a5042f79a2b27d2d2935e0c_master.jpg', 1),
                                                                    (14, 'Lưới thun dẻo đỏ', 'https://product.hstatic.net/200000898773/product/771-vai-luoi-thun-deo-co-gian-may-dam-vay-set-bo-thiet-ke___10__bdb42b4fc04d485ba2f5066fbbb12649_master.jpg', 1),
                                                                    (15, 'Thun cotton 100% 2 chiều trắng', 'https://product.hstatic.net/200000898773/product/vai-thun-cotton-100-_-250-gsm-2-chieu__2__a088f7256a584e94a8697c9fe2223e95_master.jpg', 1),
                                                                    (15, 'Thun cotton 100% 2 chiều xám chì', 'https://product.hstatic.net/200000898773/product/vai-thun-cotton-100-_-250-gsm-2-chieu__4__69e363c9f804428ca94f70c57243fc3a_master.jpg', 1),

                                                                    (16, 'Thun hàn dày đen', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__10__88d7ac21b4914e36a8930be98ed9982f_master.jpg', 1),
                                                                    (16, 'Thun hàn dày hồng sen', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__20__40f92a2bf9d344c58a439b1ca919f48c_master.jpg', 1),
                                                                    (16, 'Thun hàn dày nâu bò', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__21__310bfcfd3b404744a6c1e2e500dc163b_master.jpg', 1),
                                                                    (16, 'Thun hàn dày xanh than', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__23__68f8552a2c39426ca322f8d4719e1c42_master.jpg', 1),
                                                                    (16, 'Thun hàn dày tím', 'https://product.hstatic.net/200000898773/product/vai-thun-han-day__24__41f73b37c16d41b0a4a2fa32062ba1de_master.jpg', 1),

                                                                    (17, 'Thun tăm lạnh đen', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__11__41a32a53dc3d4100b85bfbcf4e1a6c33_master.jpg', 1),
                                                                    (17, 'Thun tăm lạnh trắng', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__12__2c681098a3a345a892f50efeb45eb28c_master.jpg', 1),
                                                                    (17, 'Thun tăm lạnh be', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__13__7826eac35acf4de38cb2f45152ef2792_master.jpg', 1),
                                                                    (17, 'Thun tăm lạnh dâu', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__15__0f30cbc373e54455b04e24a804749389_master.jpg', 1),
                                                                    (17, 'Thun tăm lạnh nâu tây', 'https://product.hstatic.net/200000898773/product/200-vai-thun-tam-lanh-may-ao-thun-vay-dam-do-bo-thiet-ke__16__5abf4e7f17f9441c920acd0aba60307e_master.jpg', 1),

                                                                    (18, 'Thun co dãn hồng', 'https://product.hstatic.net/200000898773/product/upload_0bcc75beed7947f48221dff7d307d8cf_master.jpg', 1),
                                                                    (18, 'Thun co dãn trắng', 'https://product.hstatic.net/200000898773/product/upload_52b9534b525b41c19fb63ecf3aeec87f_master.jpg', 1),

                                                                    (19, 'Kaki xước hoa nổi xám', 'https://product.hstatic.net/200000898773/product/506-vai-kaki-xuoc-hoa-noi-may-quan-tay-vay-dam-vest-thiet-ke__1__4040d7da88fa4535b126ca1947e43302_master.jpg', 1),

                                                                    (20, 'Jean Chấm Xanh', 'https://product.hstatic.net/200000898773/product/upload_2396fab85c0f4dbca287bd126d2fe21b_master.jpg', 1),

                                                                    (21, 'Jean demin xanh biển', 'https://product.hstatic.net/200000898773/product/1_17e7f222863045308ee85bce8f9ad869_master.jpg', 1),
                                                                    (21, 'Jean demin xanh nhạt', 'https://product.hstatic.net/200000898773/product/2_5dada4e4169e4a3ea4b76087d6c0792c_master.jpg', 1),
                                                                    (21, 'Jean demin xanh trung', 'https://product.hstatic.net/200000898773/product/3_223f83a720864c60b0efc52d1f745cae_master.jpg', 1),

                                                                    (22, 'Jean lụa xanh đậm', 'https://product.hstatic.net/200000898773/product/01_c7e963b8124246be914310ddad9491f6_master.jpg', 1),
                                                                    (22, 'Jean lụa xanh nhạt', 'https://product.hstatic.net/200000898773/product/02_714a147e40c54d088abce23e6d70218e_master.jpg', 1),
                                                                    (22, 'Jean lụa đen', 'https://product.hstatic.net/200000898773/product/03_8eebfbf420ea461d8666261d53d392f6_master.jpg', 1),

                                                                    (23, 'Jean loang xanh', 'https://product.hstatic.net/200000898773/product/802-vai-jean-loang-may-quan-jean-ao-khoac-vay-dam-set__11__bb6154c33757486f913fa3f0584e8260_master.jpg', 1);


-- ----------------------------
-- Table structure for technical_information
-- ----------------------------
DROP TABLE IF EXISTS `technical_information`;
CREATE TABLE `technical_information`  (
                                          `id` int(11) NOT NULL AUTO_INCREMENT,
                                          `specifications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                          `manufactureDate` date NOT NULL,
                                          `releaseDay` DATE NULL,
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 187 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of technical_information
INSERT INTO technical_information (id, releaseDay, manufactureDate, specifications) VALUES
                                                                                        (1, '2023-01-15 10:00:00', '2022-12-01 08:00:00', 'Vải linen mềm mại, thoáng khí.'),
                                                                                        (2, '2023-02-20 12:00:00', '2022-11-15 09:00:00', 'Vải linen tự nhiên, thân thiện với môi trường.'),
                                                                                        (3, '2023-03-05 14:00:00', '2022-12-10 07:30:00', 'Vải linen cao cấp, chống nhăn.'),
                                                                                        (4, '2023-04-12 16:30:00', '2022-11-20 10:15:00', 'Vải linen thoáng mát, thích hợp mùa hè.'),
                                                                                        (5, '2023-05-25 09:45:00', '2022-12-15 11:00:00', 'Vải linen sang trọng, thích hợp tiệc tùng.'),
                                                                                        (6, '2023-06-30 15:00:00', '2022-11-30 13:00:00', 'Vải linen nhẹ nhàng, thấm hút mồ hôi.'),
                                                                                        (7, '2023-07-15 11:30:00', '2022-12-05 14:00:00', 'Vải linen mềm mại, dễ mặc.'),
                                                                                        (8, '2023-07-15 11:30:00', '2022-12-05 14:00:00', 'Vải linen mềm mại, dễ mặc.'),
                                                                                        (9, '2023-08-10 08:00:00', '2022-12-20 16:00:00', 'Vải thun cao cấp, chống nhăn.'),
                                                                                        (10, '2024-05-15 12:30:00', '2022-12-08 09:30:00', 'Vải thun cơ bản, dễ sử dụng.'),
                                                                                        (11, '2024-06-01 16:00:00', '2022-12-18 09:00:00', 'Vải linen cao cấp, thoáng khí.'),
                                                                                        (12, '2023-09-18 12:15:00', '2022-11-25 17:00:00', 'Vải thun co giãn, thoải mái khi mặc.'),
                                                                                        (13, '2023-10-22 14:00:00', '2022-11-10 09:45:00', 'Vải thun dày dặn, bền màu.'),
                                                                                        (14, '2023-11-05 10:30:00', '2022-11-15 11:15:00', 'Vải thun năng động, phù hợp thể thao.'),
                                                                                        (15, '2023-11-20 13:00:00', '2022-12-12 15:30:00', 'Vải thun cổ điển, dễ phối đồ.'),
                                                                                        (16, '2024-01-15 15:30:00', '2022-11-18 12:00:00', 'Vải thun thể thao, thoải mái vận động.'),
                                                                                        (17, '2024-04-20 10:00:00', '2022-11-28 14:30:00', 'Vải thun hiện đại, phong cách trẻ trung.'),
                                                                                        (18, '2024-06-15 10:30:00', '2022-11-28 14:30:00', 'Vải thun pha trộn, độc đáo và mới lạ.'),
                                                                                        (19, '2024-02-20 11:00:00', '2022-12-25 18:30:00', 'Vải kaki chắc chắn, phong cách.'),
                                                                                        (20, '2024-03-10 09:15:00', '2022-12-30 11:30:00', 'Vải jean bền bỉ, phong cách cá tính.'),
                                                                                        (21, '2024-04-05 13:30:00', '2022-12-29 15:00:00', 'Vải jean thời trang, cá tính và phong cách.'),
                                                                                        (22, '2024-07-01 08:30:00', '2022-12-29 15:00:00', 'Vải jean cổ điển, không bao giờ lỗi mốt.'),
                                                                                        (23, '2024-07-01 08:30:00', '2022-12-29 15:00:00', 'Vải jean bền bỉ, phong cách cá tính.');
-- ----------------------------
-- Table structure for user_tokens
-- ----------------------------
DROP TABLE IF EXISTS `user_tokens`;
CREATE TABLE `user_tokens`  (
                                `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
                                `idUser` int(11) NOT NULL COMMENT 'Khóa ngoại liên kết tới users.id',
                                `tokenHash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Giá trị token đã được hash (để lưu trữ an toàn)',
                                `tokenType` enum('email_verification','reset_password') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Loại token',
                                `expiresAt` datetime NULL DEFAULT NULL COMMENT 'Thời gian token hết hạn (NULL nếu không hết hạn)',
                                `createdAt` timestamp NULL DEFAULT current_timestamp() COMMENT 'Thời gian token được tạo',
                                PRIMARY KEY (`id`) USING BTREE,
                                INDEX `user_tokens_iduser_foreign`(`idUser`) USING BTREE,
                                INDEX `user_tokens_tokenhash_index`(`tokenHash`) USING BTREE,
                                CONSTRAINT `user_tokens_iduser_foreign` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Lưu trữ token xác thực, đặt lại mật khẩu,...' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
                          `id` int(11) NOT NULL AUTO_INCREMENT,
                          `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                          `firstName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                          `lastName` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                          `fullNameGenerated` varchar(255) GENERATED ALWAYS AS (trim(concat_ws(' ',`firstName`,`lastName`))) PERSISTENT,
                          `phoneNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                          `idAddress` int(11) NULL DEFAULT NULL,
                          `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                          `createdAt` timestamp NULL DEFAULT current_timestamp(),
                          `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
                          PRIMARY KEY (`id`) USING BTREE,
                          UNIQUE INDEX `email`(`email`) USING BTREE,
                          INDEX `users_idaddress_foreign`(`idAddress`) USING BTREE,
                          CONSTRAINT `users_idaddress_foreign` FOREIGN KEY (`idAddress`) REFERENCES `addresses` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'hung1@gmail.com', 'Hưng', 'Lê Đình', DEFAULT, '0337057878', 1, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (2, 'lethihanh@gmail.com', 'Hạnh', 'Lê Thị', DEFAULT, '0987654321', 2, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (3, 'tranvanbinh@gmail.com', 'Bình', 'Trần Văn', DEFAULT, '0934567890', 3, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (4, 'phamthuy@gmail.com', 'Thúy', 'Phạm Thị', DEFAULT, '0978123456', 4, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (5, 'hoangminhtuan@gmail.com', 'Tuấn', 'Hoàng Minh', DEFAULT, '0923456789', 5, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (6, 'dinhphuong@gmail.com', 'Phượng', 'Đinh Thị', DEFAULT, '0945678901', 6, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (7, 'votienthanh@gmail.com', 'Thành', 'Võ Tiến', DEFAULT, '0967890123', 7, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (8, 'ngothithao@gmail.com', 'Thảo', 'Ngô Thị', DEFAULT, '0901234567', 8, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (9, 'phamvangiang@gmail.com', 'Giang', 'Phạm Văn', DEFAULT, '0919876543', 9, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (10, 'tranthuthuy@gmail.com', 'Thủy', 'Trần Thu', DEFAULT, '0921098765', 10, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (23, '22130084@st.hcmuaf.edu.vn', 'Hoài', 'Huỳnh Linh', DEFAULT, '0377314202', 1, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (25, NULL, 'Name', 'Default', DEFAULT, '0000000000', 1, 'default.png', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (26, NULL, 'Name', 'Default', DEFAULT, '0000000000', 1, 'default.png', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (27, NULL, 'Name', 'Default', DEFAULT, '0000000000', 1, 'default.png', '2025-04-06 11:07:24', '2025-04-06 15:27:57');
INSERT INTO `users` VALUES (28, NULL, 'Name', 'Default', DEFAULT, '0000000000', 1, 'default.png', '2025-04-06 11:07:24', '2025-04-06 15:27:57');

-- ----------------------------
-- Table structure for vouchers
-- ----------------------------
DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers`  (
                             `idVoucher` int(11) NOT NULL AUTO_INCREMENT,
                             `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `discountAmount` double NOT NULL,
                             `condition_amount` double NOT NULL,
                             `valid` tinyint(4) NULL DEFAULT NULL,
                             PRIMARY KEY (`idVoucher`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vouchers
-- ----------------------------
INSERT INTO `vouchers` VALUES (1, 'VOUCHER01', 100000, 500000, 1);
INSERT INTO `vouchers` VALUES (2, 'VOUCHER02', 20000, 200000, 1);
INSERT INTO `vouchers` VALUES (3, 'VOUCHER03', 150000, 750000, 1);
INSERT INTO `vouchers` VALUES (4, 'VOUCHER04', 300000, 1500000, 1);
INSERT INTO `vouchers` VALUES (5, 'VOUCHER05', 250000, 1000000, 1);

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE contact_info (
                              id INT AUTO_INCREMENT PRIMARY KEY,
                              idAddress INT NULL ,
                              email VARCHAR(50) NOT NULL,
                              website VARCHAR(100) NULL,
                              hotline VARCHAR(50) NOT NULL,
                              FOREIGN KEY (idAddress) REFERENCES addresses(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE cart (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      idUser INT NOT NULL,
                      idVoucher INT NULL,
                      shippingFee DECIMAL(15, 2) NULL DEFAULT 0.00,
                      createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                      updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                      FOREIGN KEY (idUser) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
                      FOREIGN KEY (idVoucher) REFERENCES vouchers(idVoucher) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE cart_items (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            idCart INT NOT NULL,
                            idStyle INT NOT NULL,
                            quantity INT NOT NULL,
                            unitPrice DECIMAL(15, 2) NOT NULL,
                            addedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (idCart) REFERENCES cart(id) ON DELETE CASCADE ON UPDATE CASCADE,
                            FOREIGN KEY (idStyle) REFERENCES styles(id) ON DELETE CASCADE ON UPDATE CASCADE,
                            UNIQUE KEY idx_cart_item_style (idCart, idStyle)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


