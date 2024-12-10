CREATE TABLE `account_users` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` tinyint NOT NULL,
  `locked` tinyint NOT NULL
);

CREATE TABLE `products` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `quantity` INT NOT NULL,
  `addedDate` DATE NOT NULL,
  `idCategory` INT NOT NULL,
  `height` int NOT NULL,
  `width` int NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `selling` tinyint NOT NULL
);

CREATE TABLE `orders` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `timeOrder` DATETIME NOT NULL,
  `idUser` INT NOT NULL,
  `idVoucher` INT,
  `statusOrder` varchar(255) NOT NULL,
  `totalPrice` INT NOT NULL,
  `lastPrice` double NOT NULL
);

CREATE TABLE `payments` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `method` tinyint NOT NULL,
  `status` boolean NOT NULL,
  `time` datetime NOT NULL
);

CREATE TABLE `order_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idOrder` int NOT NULL,
  `idStyle` INT NOT NULL,
  `quantity` INT NOT NULL,
  `totalPrice` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `idOrder`, `idStyle`)
);

CREATE TABLE `vouchers` (
  `idVoucher` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `amount` DOUBLE NOT NULL,
  `condition_amount` double NOT NULL
);

CREATE TABLE `deliveries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idOrder` INT NOT NULL,
  `idAddress` INT NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `phoneNumber` VARCHAR(255) NOT NULL,
  `weight` double NOT NULL,
  `deliveryFee` double NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `scheduledDateTime` datetime NOT NULL,
  PRIMARY KEY (`id`, `idOrder`)
);

CREATE TABLE `addresses` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(255) NOT NULL,
  `province` VARCHAR(255) NOT NULL,
  `commune` VARCHAR(255) NOT NULL
);

CREATE TABLE `categories` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `styles` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_product` BIGINT NOT NULL,
  `name` BIGINT NOT NULL,
  `image` BIGINT NOT NULL,
  `quantity` int NOT NULL
);

CREATE TABLE `prices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_style` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `discountPercent` DOUBLE NOT NULL,
  `lastPrice` DOUBLE NOT NULL,
  PRIMARY KEY (`id`, `id_style`)
);

CREATE TABLE `technical_information` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `specifications` VARCHAR(255) NOT NULL,
  `manufactureDate` DATE NOT NULL
);

CREATE TABLE `users` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `fullName` VARCHAR(255) NOT NULL,
  `phoneNumber` VARCHAR(255) NOT NULL,
  `idAddress` INT NOT NULL
);

CREATE TABLE `message` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `title` VARCHAR NOT NULL,
  `content` varchar(255) NOT NULL
);
