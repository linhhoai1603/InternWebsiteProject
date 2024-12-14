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

-- Dumping data for table project_web.products: ~70 rows (approximately)
INSERT INTO `products` (`id`, `name`, `quantity`, `addedDate`, `idCategory`, `area`, `description`, `selling`, `idTechnical`, `image`) VALUES
 (1, 'Nút áo nhựa xám', 80, '2024-12-08', 3, 0, 'Nút áo nhựa màu xám, chất liệu nhựa bền bỉ', 1, 1, NULL),
 (2, 'Nút áo gỗ đỏ', 150, '2024-12-12', 3, 0, 'Nút áo gỗ màu đỏ, thiết kế mạnh mẽ và sang trọng', 1, 2, NULL),
 (3, 'Nút áo kim loại bạc mờ', 100, '2024-12-23', 3, 0, 'Nút áo kim loại màu bạc mờ, kiểu dáng hiện đại', 1, 3, NULL),
 (4, 'Nút áo nhựa cam', 120, '2024-04-14', 3, 0, 'Nút áo nhựa màu cam, nổi bật và dễ phối hợp', 1, 4, NULL),
 (5, 'Nút áo gỗ vàng', 180, '2024-08-14', 3, 0, 'Nút áo gỗ màu vàng, thiết kế tinh tế và bền bỉ', 1, 5, NULL),
 (6, 'Nút áo nhựa hồng', 150, '2024-09-14', 3, 0, 'Nút áo nhựa màu hồng, phù hợp với trang phục nữ tính', 1, 6, NULL),
 (7, 'Nút áo kim loại bạc sáng', 130, '2024-07-14', 3, 0, 'Nút áo kim loại màu bạc sáng, sang trọng và hiện đại', 1, 7, NULL),
 (8, 'Nút áo nhựa đen', 100, '2025-05-14', 3, 0, 'Nút áo nhựa màu đen, chất liệu nhựa cao cấp', 1, 8, NULL),
 (9, 'Nút áo gỗ nâu', 200, '2024-08-08', 3, 0, 'Nút áo gỗ màu nâu, thiết kế cổ điển', 1, 9, NULL),
 (10, 'Nút áo kim loại vàng', 150, '2024-12-13', 3, 0, 'Nút áo kim loại màu vàng, kiểu dáng sang trọng', 1, 10, NULL),
 (11, 'Nút áo nhựa trắng', 120, '2025-02-13', 3, 0, 'Nút áo nhựa màu trắng, phù hợp với trang phục sáng màu', 1, 11, NULL),
 (12, 'Nút áo gỗ đen', 180, '2024-08-14', 3, 0, 'Nút áo gỗ màu đen, sang trọng và bền bỉ', 1, 12, NULL),
 (13, 'Nút áo nhựa xanh', 130, '2025-02-14', 3, 0, 'Nút áo nhựa màu xanh, dễ phối hợp với nhiều trang phục', 1, 13, NULL),
 (14, 'Nút áo kim loại bạc', 90, '2024-12-14', 3, 0, 'Nút áo kim loại màu bạc, thiết kế hiện đại', 1, 14, NULL),
 (15, 'Nút áo gỗ be', 160, '2024-08-14', 3, 0, 'Nút áo gỗ màu be, tự nhiên và thanh lịch', 1, 15, NULL),
 (16, 'Nút áo nhựa đỏ', 140, '2024-03-14', 3, 0, 'Nút áo nhựa màu đỏ, nổi bật và dễ sử dụng', 1, 16, NULL),
 (17, 'Nút áo kim loại đồng', 110, '2024-07-14', 3, 0, 'Nút áo kim loại màu đồng, tinh tế và bền bỉ', 1, 17, NULL),
 (18, 'Nút áo nhựa vàng', 110, '2024-09-14', 3, 0, 'Nút áo nhựa màu vàng, bền và dễ sử dụng', 1, 18, NULL),
 (19, 'Nút áo gỗ xanh', 140, '2024-02-14', 3, 0, 'Nút áo gỗ màu xanh, thanh thoát và hiện đại', 1, 19, NULL),
 (20, 'Nút áo kim loại đồng mờ', 90, '2024-06-23', 3, 0, 'Nút áo kim loại màu đồng mờ, sang trọng và tinh tế', 1, 20, NULL),
 (21, 'Nút áo nhựa xanh dương', 130, '2024-04-14', 3, 0, 'Nút áo nhựa màu xanh dương, dịu mắt và dễ sử dụng', 1, 21, NULL),
 (22, 'Nút áo gỗ xám', 180, '2024-08-14', 3, 0, 'Nút áo gỗ màu xám, thanh lịch và sang trọng', 1, 22, NULL),
 (23, 'Nút áo nhựa vàng cam', 150, '2024-07-14', 3, 0, 'Nút áo nhựa màu vàng cam, nổi bật và dễ phối hợp', 1, 23, NULL),
 (24, 'Nút áo gỗ nâu sáng', 120, '2024-07-14', 3, 0, 'Nút áo gỗ màu nâu sáng, thiết kế tự nhiên và bền bỉ', 1, 24, NULL),
 (25, 'Nút áo kim loại vàng ánh kim', 100, '2024-08-14', 3, 0, 'Nút áo kim loại màu vàng ánh kim, thiết kế sang trọng', 1, 25, NULL),
 (26, 'Nút áo nhựa tím', 90, '2024-12-14', 3, 0, 'Nút áo nhựa màu tím, tinh tế và độc đáo', 1, 26, NULL),
 (27, 'Nút áo gỗ cẩm lai', 140, '2024-12-14', 3, 0, 'Nút áo gỗ cẩm lai, sang trọng và có độ bền cao', 1, 27, NULL),
 (28, 'Nút nhựa - Trắng 10mm', 500, '2024-11-01', 3, 0, 'Nút nhựa trắng, nhẹ và dẻo, phù hợp cho áo sơ mi.', 1, 28, NULL),
 (29, 'Nút kim loại - Bạc 12mm', 300, '2024-11-02', 3, 0, 'Nút kim loại bạc, cứng và bền, thích hợp cho áo khoác.', 1, 29, NULL),
 (30, 'Nút gỗ - Nâu 15mm', 200, '2024-11-03', 3, 0, 'Nút gỗ tự nhiên màu nâu, phù hợp cho áo len hoặc áo dệt tay.', 1, 30, NULL),
 (31, 'Nút nhựa - Đen 8mm', 600, '2024-11-04', 3, 0, 'Nút nhựa đen, nhỏ gọn và bền bỉ, thích hợp cho váy.', 1, 31, NULL),
 (32, 'Nút kim loại - Vàng 10mm', 450, '2024-11-05', 3, 0, 'Nút kim loại màu vàng, mang phong cách thời trang.', 1, 32, NULL),
 (33, 'Nút gỗ - Vàng nhạt 12mm', 350, '2024-11-06', 3, 0, 'Nút gỗ vàng nhạt, bền và tự nhiên, dành cho áo thủ công.', 1, 33, NULL),
 (34, 'Nút nhựa - Xám 14mm', 400, '2024-11-07', 3, 0, 'Nút nhựa xám, dẻo và bền bỉ, phù hợp cho áo khoác.', 1, 34, NULL),
 (35, 'Nút kim loại - Đen 16mm', 250, '2024-11-08', 3, 0, 'Nút kim loại màu đen, chắc chắn và chống gỉ.', 1, 35, NULL),
 (36, 'Nút gỗ - Trắng ngà 10mm', 300, '2024-11-09', 3, 0, 'Nút gỗ nhẹ màu trắng ngà, phù hợp cho trang phục vintage.', 1, 36, NULL),
 (37, 'Nút nhựa - Xanh dương 18mm', 500, '2024-11-10', 3, 0, 'Nút nhựa xanh dương, nổi bật và bắt mắt, thích hợp cho áo khoác thời trang.', 1, 37, NULL),
 (38, 'Nút nhựa - Đỏ 12mm', 600, '2024-12-01', 3, 0, 'Nút nhựa đỏ, bền và nhẹ, phù hợp cho áo khoác hoặc áo sơ mi.', 1, 38, NULL),
 (39, 'Nút kim loại - Đồng 14mm', 400, '2024-12-02', 3, 0, 'Nút kim loại đồng, chống mài mòn, thích hợp cho áo khoác dày.', 1, 39, NULL),
 (40, 'Nút gỗ - Đen 16mm', 300, '2024-12-03', 3, 0, 'Nút gỗ màu đen, mang phong cách cổ điển, dành cho áo len hoặc trang phục vintage.', 1, 40, NULL),
 (41, 'Nút nhựa - Vàng 10mm', 700, '2024-12-04', 3, 0, 'Nút nhựa vàng, nổi bật và bền, dùng cho áo khoác thời trang.', 1, 41, NULL),
 (42, 'Nút kim loại - Bạc xước 18mm', 250, '2024-12-05', 3, 0, 'Nút kim loại bạc xước, mang phong cách thời trang, dành cho áo vest.', 1, 42, NULL),
 (43, 'Nút gỗ - Xám tro 14mm', 350, '2024-12-06', 3, 0, 'Nút gỗ màu xám tro, chắc chắn và tự nhiên, dành cho quần áo thủ công.', 1, 43, NULL),
 (44, 'Nút nhựa - Xanh lá 12mm', 500, '2024-12-07', 3, 0, 'Nút nhựa xanh lá, bắt mắt và dẻo dai, thích hợp cho trang phục mùa hè.', 1, 44, NULL),
 (45, 'Nút kim loại - Đỏ đậm 16mm', 300, '2024-12-08', 3, 0, 'Nút kim loại đỏ đậm, cứng và nổi bật, dành cho áo khoác dày.', 1, 45, NULL),
 (46, 'Nút gỗ - Nâu đen 10mm', 400, '2024-12-09', 3, 0, 'Nút gỗ nâu đen, sang trọng và tự nhiên, phù hợp cho trang phục cao cấp.', 1, 46, NULL),
 (47, 'Nút nhựa - Trắng sữa 8mm', 800, '2024-12-10', 3, 0, 'Nút nhựa trắng sữa, tinh tế và nhẹ, dành cho áo sơ mi.', 1, 47, NULL),
 (48, 'Nút nhựa - Cam 14mm', 450, '2024-12-21', 3, 0, 'Nút nhựa màu cam, bền, dẻo và thời trang, phù hợp cho áo khoác hoặc váy.', 1, 48, NULL),
 (49, 'Nút kim loại - Xanh dương đậm 16mm', 300, '2024-12-22', 3, 0, 'Nút kim loại xanh dương đậm, chống gỉ, nổi bật, dùng cho áo khoác dày hoặc thời trang cao cấp.', 1, 49, NULL),
 (50, 'Nút gỗ - Xanh lá nhạt 12mm', 350, '2024-12-23', 3, 0, 'Nút gỗ màu xanh lá nhạt, nhẹ và bền, phù hợp cho áo len hoặc trang phục vintage.', 1, 50, NULL),
 (51, 'Dây kéo nhựa đen', 200, '2024-12-15', 4, 0, 'Dây kéo nhựa màu đen, chất liệu bền, phù hợp cho áo khoác', 1, 51, NULL),
 (52, 'Dây kéo kim loại bạc', 150, '2024-12-16', 4, 0, 'Dây kéo kim loại màu bạc, chất liệu chắc chắn và bền bỉ', 1, 52, NULL),
 (53, 'Dây kéo nhựa đỏ', 180, '2024-12-17', 4, 0, 'Dây kéo nhựa màu đỏ, nổi bật và dễ phối hợp', 1, 53, NULL),
 (54, 'Dây kéo kim loại vàng', 100, '2024-12-18', 4, 0, 'Dây kéo kim loại màu vàng, sang trọng và thời trang', 1, 54, NULL),
 (55, 'Dây kéo nhựa xanh dương', 150, '2024-12-19', 4, 0, 'Dây kéo nhựa màu xanh dương, dễ sử dụng và bền bỉ', 1, 55, NULL),
 (56, 'Dây kéo kim loại đồng', 200, '2024-12-20', 4, 0, 'Dây kéo kim loại màu đồng, bền bỉ và tinh tế', 1, 56, NULL),
 (57, 'Dây kéo nhựa hồng', 120, '2024-12-21', 4, 0, 'Dây kéo nhựa màu hồng, phù hợp cho trang phục nữ tính', 1, 57, NULL),
 (58, 'Dây kéo kim loại bạc sáng', 130, '2024-12-22', 4, 0, 'Dây kéo kim loại màu bạc sáng, hiện đại và sang trọng', 1, 58, NULL),
 (59, 'Dây kéo nhựa cam', 170, '2024-12-23', 4, 0, 'Dây kéo nhựa màu cam, nổi bật và dễ phối hợp với nhiều trang phục', 1, 59, NULL),
 (60, 'Dây kéo kim loại đen', 180, '2024-12-24', 4, 0, 'Dây kéo kim loại màu đen, bền và chắc chắn', 1, 60, NULL),
 (61, 'Dây kéo nhựa vàng', 150, '2024-12-25', 4, 0, 'Dây kéo nhựa màu vàng, bền và dễ sử dụng', 1, 61, NULL),
 (62, 'Dây kéo kim loại xám', 100, '2024-12-26', 4, 0, 'Dây kéo kim loại màu xám, thiết kế thanh lịch', 1, 62, NULL),
 (63, 'Dây kéo nhựa trắng', 200, '2024-12-27', 4, 0, 'Dây kéo nhựa màu trắng, dễ phối hợp với nhiều trang phục', 1, 63, NULL),
 (64, 'Dây kéo kim loại đồng mờ', 120, '2024-12-28', 4, 0, 'Dây kéo kim loại màu đồng mờ, sang trọng và tinh tế', 1, 64, NULL),
 (65, 'Dây kéo nhựa xanh lá', 180, '2024-12-29', 4, 0, 'Dây kéo nhựa màu xanh lá, bền bỉ và dễ sử dụng', 1, 65, NULL),
 (66, 'Dây kéo kim loại vàng sáng', 150, '2024-12-30', 4, 0, 'Dây kéo kim loại màu vàng sáng, sang trọng và bền bỉ', 1, 66, NULL),
 (67, 'Dây kéo nhựa xám', 130, '2024-12-31', 4, 0, 'Dây kéo nhựa màu xám, đơn giản và tinh tế', 1, 67, NULL),
 (68, 'Dây kéo kim loại bạc xước', 120, '2025-01-01', 4, 0, 'Dây kéo kim loại bạc xước, cứng và thời trang', 1, 68, NULL),
 (69, 'Dây kéo nhựa tím', 140, '2025-01-02', 4, 0, 'Dây kéo nhựa màu tím, tinh tế và độc đáo', 1, 69, NULL),
 (70, 'Dây kéo kim loại đỏ', 110, '2025-01-03', 4, 0, 'Dây kéo kim loại màu đỏ, nổi bật và bền bỉ', 1, 70, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
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

-- Dumping data for table project_web.technical_information: ~70 rows (approximately)
INSERT INTO `technical_information` (`id`, `specifications`, `manufactureDate`) VALUES
  (1, 'Chất liệu: Nhựa, Màu sắc: Xám, Bền bỉ và dẻo', '2024-01-01'),
  (2, 'Chất liệu: Gỗ, Màu sắc: Đỏ, Thiết kế mạnh mẽ và sang trọng', '2024-01-01'),
  (3, 'Chất liệu: Kim loại, Màu sắc: Bạc mờ, Kiểu dáng hiện đại', '2024-01-01'),
  (4, 'Chất liệu: Nhựa, Màu sắc: Cam, Nổi bật và dễ phối hợp', '2024-01-01'),
  (5, 'Chất liệu: Gỗ, Màu sắc: Vàng, Thiết kế tinh tế và bền bỉ', '2024-01-01'),
  (6, 'Chất liệu: Nhựa, Màu sắc: Hồng, Phù hợp với trang phục nữ tính', '2024-01-01'),
  (7, 'Chất liệu: Kim loại, Màu sắc: Bạc sáng, Sang trọng và hiện đại', '2024-01-01'),
  (8, 'Chất liệu: Nhựa, Màu sắc: Đen', '2024-01-01'),
  (9, 'Chất liệu: Gỗ, Màu sắc: Nâu', '2024-01-01'),
  (10, 'Chất liệu: Kim loại, Màu sắc: Vàng', '2024-01-01'),
  (11, 'Chất liệu: Nhựa, Màu sắc: Trắng', '2024-01-01'),
  (12, 'Chất liệu: Gỗ, Màu sắc: Đen', '2024-01-01'),
  (13, 'Chất liệu: Nhựa, Màu sắc: Xanh', '2024-01-01'),
  (14, 'Chất liệu: Kim loại, Màu sắc: Bạc', '2024-01-01'),
  (15, 'Chất liệu: Gỗ, Màu sắc: Be', '2024-01-01'),
  (16, 'Chất liệu: Nhựa, Màu sắc: Đỏ', '2024-01-01'),
  (17, 'Chất liệu: Kim loại, Màu sắc: Đồng', '2024-01-01'),
  (18, 'Chất liệu: Nhựa, Màu sắc: Vàng, Bền và dễ sử dụng', '2024-01-01'),
  (19, 'Chất liệu: Gỗ, Màu sắc: Xanh, Thanh thoát và hiện đại', '2024-01-01'),
  (20, 'Chất liệu: Kim loại, Màu sắc: Đồng mờ, Sang trọng và tinh tế', '2024-01-01'),
  (21, 'Chất liệu: Nhựa, Màu sắc: Xanh dương, Dịu mắt và dễ sử dụng', '2024-01-01'),
  (22, 'Chất liệu: Gỗ, Màu sắc: Xám, Thanh lịch và sang trọng', '2024-01-01'),
  (23, 'Chất liệu: Nhựa, Màu sắc: Vàng cam, Nổi bật và dễ phối hợp', '2024-01-01'),
  (24, 'Chất liệu: Gỗ, Màu sắc: Nâu sáng, Thiết kế tự nhiên và bền bỉ', '2024-01-01'),
  (25, 'Chất liệu: Kim loại, Màu sắc: Vàng ánh kim, Thiết kế sang trọng', '2024-01-01'),
  (26, 'Chất liệu: Nhựa, Màu sắc: Tím, Tinh tế và độc đáo', '2024-01-01'),
  (27, 'Chất liệu: Gỗ, Màu sắc: Cẩm lai, Sang trọng và có độ bền cao', '2024-01-01'),
  (28, 'Chất liệu: Nhựa, Màu sắc: Trắng, Đặc tính: Nhẹ và dẻo', '2024-01-15'),
  (29, 'Chất liệu: Kim loại, Màu sắc: Bạc, Đặc tính: Cứng và bền', '2024-02-10'),
  (30, 'Chất liệu: Gỗ, Màu sắc: Nâu, Đặc tính: Tự nhiên và chắc chắn', '2024-03-05'),
  (31, 'Chất liệu: Nhựa, Màu sắc: Đen, Đặc tính: Dẻo và bền bỉ', '2024-04-20'),
  (32, 'Chất liệu: Kim loại, Màu sắc: Vàng, Đặc tính: Cứng cáp và thời trang', '2024-05-25'),
  (33, 'Chất liệu: Gỗ, Màu sắc: Vàng nhạt, Đặc tính: Tự nhiên và bền', '2024-06-15'),
  (34, 'Chất liệu: Nhựa, Màu sắc: Xám, Đặc tính: Bền bỉ và dẻo', '2024-07-10'),
  (35, 'Chất liệu: Kim loại, Màu sắc: Đen, Đặc tính: Cứng và chống gỉ', '2024-08-05'),
  (36, 'Chất liệu: Gỗ, Màu sắc: Trắng ngà, Đặc tính: Nhẹ và tự nhiên', '2024-09-12'),
  (37, 'Chất liệu: Nhựa, Màu sắc: Xanh dương, Đặc tính: Dẻo và bắt mắt', '2024-10-18'),
  (38, 'Chất liệu: Nhựa, Màu sắc: Đỏ, Đặc tính: Bền và nhẹ', '2024-11-01'),
  (39, 'Chất liệu: Kim loại, Màu sắc: Đồng, Đặc tính: Bền, chống mài mòn', '2024-11-10'),
  (40, 'Chất liệu: Gỗ, Màu sắc: Đen, Đặc tính: Bền, cổ điển', '2024-11-15'),
  (41, 'Chất liệu: Nhựa, Màu sắc: Vàng, Đặc tính: Dẻo và nổi bật', '2024-12-01'),
  (42, 'Chất liệu: Kim loại, Màu sắc: Bạc xước, Đặc tính: Cứng và thời trang', '2024-12-05'),
  (43, 'Chất liệu: Gỗ, Màu sắc: Xám tro, Đặc tính: Tự nhiên và chắc chắn', '2024-12-10'),
  (44, 'Chất liệu: Nhựa, Màu sắc: Xanh lá, Đặc tính: Dẻo và bắt mắt', '2024-12-15'),
  (45, 'Chất liệu: Kim loại, Màu sắc: Đỏ đậm, Đặc tính: Cứng và nổi bật', '2024-12-20'),
  (46, 'Chất liệu: Gỗ, Màu sắc: Nâu đen, Đặc tính: Tự nhiên, sang trọng', '2024-12-25'),
  (47, 'Chất liệu: Nhựa, Màu sắc: Trắng sữa, Đặc tính: Nhẹ và tinh tế', '2024-12-30'),
  (48, 'Chất liệu: Nhựa, Màu sắc: Cam, Đặc tính: Bền, dẻo và thời trang', '2024-12-05'),
  (49, 'Chất liệu: Kim loại, Màu sắc: Xanh dương đậm, Đặc tính: Cứng, chống gỉ và nổi bật', '2024-12-15'),
  (50, 'Chất liệu: Gỗ, Màu sắc: Xanh lá nhạt, Đặc tính: Tự nhiên, nhẹ và bền', '2024-12-20'),
  (51, 'Nhựa, đường kính 10mm', '2024-01-15'),
  (52, 'Kim loại, đường kính 12mm', '2024-02-10'),
  (53, 'Gỗ, đường kính 15mm', '2024-03-05'),
  (54, 'Nhựa, đường kính 8mm', '2024-04-20'),
  (55, 'Kim loại, đường kính 10mm', '2024-05-25'),
  (56, 'Gỗ, đường kính 12mm', '2024-06-15'),
  (57, 'Nhựa, đường kính 14mm', '2024-07-10'),
  (58, 'Kim loại, đường kính 16mm', '2024-08-05'),
  (59, 'Gỗ, đường kính 10mm', '2024-09-12'),
  (60, 'Nhựa, đường kính 18mm', '2024-10-18'),
  (61, 'Kim loại, đường kính 9mm', '2024-11-20'),
  (62, 'Gỗ, đường kính 13mm', '2024-12-01'),
  (63, 'Nhựa, đường kính 16mm', '2024-12-05'),
  (64, 'Kim loại, đường kính 11mm', '2024-12-10'),
  (65, 'Gỗ, đường kính 17mm', '2024-12-15'),
  (66, 'Nhựa, đường kính 12mm', '2024-12-18'),
  (67, 'Kim loại, đường kính 18mm', '2024-12-22'),
  (68, 'Gỗ, đường kính 11mm', '2024-12-25'),
  (69, 'Nhựa, đường kính 20mm', '2024-12-30'),
  (70, 'Kim loại, đường kính 14mm', '2025-01-03');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

