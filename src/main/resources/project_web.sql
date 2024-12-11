CREATE TABLE `account_users`(
                                `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                `idUser` INT NOT NULL,
                                `password` VARCHAR(255) NOT NULL,
                                `role` TINYINT NOT NULL,
                                `locked` TINYINT NOT NULL
);
CREATE TABLE `products`(
                           `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                           `name` VARCHAR(255) NOT NULL,
                           `quantity` INT NOT NULL,
                           `addedDate` DATE NOT NULL,
                           `idCategory` INT NOT NULL,
                           `area` DOUBLE NOT NULL,
                           `description` VARCHAR(255) NOT NULL,
                           `selling` TINYINT NOT NULL,
                           `idTechnical` INT NOT NULL,
                           `img` VARCHAR(255) NOT NULL
);
CREATE TABLE `orders`(
                         `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         `timeOrder` DATETIME NOT NULL,
                         `idUser` INT NOT NULL,
                         `idVoucher` INT NULL,
                         `statusOrder` VARCHAR(255) NOT NULL
);
CREATE TABLE `payments`(
                           `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                           `idOrder` INT NOT NULL,
                           `method` TINYINT NOT NULL,
                           `status` BOOLEAN NOT NULL,
                           `time` DATETIME NOT NULL,
                           `price` DOUBLE NOT NULL
);
CREATE TABLE `order_details`(
                                `id` INT NOT NULL AUTO_INCREMENT,
                                `idOrder` INT NOT NULL,
                                `idStyle` INT NOT NULL,
                                `quantity` INT NOT NULL,
                                `totalPrice` BIGINT NOT NULL,
                                PRIMARY KEY(`idOrder`)
);
ALTER TABLE
    `order_details` ADD PRIMARY KEY(`idStyle`);
CREATE TABLE `vouchers`(
                           `idVoucher` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                           `code` VARCHAR(255) NOT NULL,
                           `amount` DOUBLE NOT NULL,
                           `condition_amount` DOUBLE NOT NULL
);
CREATE TABLE `deliveries`(
                             `id` INT NOT NULL AUTO_INCREMENT,
                             `idOrder` INT NOT NULL,
                             `idAddress` INT NOT NULL,
                             `fullName` VARCHAR(255) NOT NULL,
                             `phoneNumber` VARCHAR(255) NOT NULL,
                             `weight` DOUBLE NOT NULL,
                             `deliveryFee` DOUBLE NOT NULL,
                             `note` VARCHAR(255) NOT NULL,
                             `status` VARCHAR(255) NOT NULL,
                             `scheduledDateTime` DATETIME NOT NULL,
                             PRIMARY KEY(`idOrder`)
);
CREATE TABLE `addresses`(
                            `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                            `city` VARCHAR(255) NOT NULL,
                            `province` VARCHAR(255) NOT NULL,
                            `commune` VARCHAR(255) NOT NULL,
                            `street` VARCHAR(255) NOT NULL
);
CREATE TABLE `categories`(
                             `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                             `name` VARCHAR(255) NOT NULL
);
CREATE TABLE `styles`(
                         `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         `id_product` BIGINT NOT NULL,
                         `name` BIGINT NOT NULL,
                         `image` BIGINT NOT NULL,
                         `quantity` INT NOT NULL,
                         `idPrice` INT NOT NULL
);
CREATE TABLE `prices`(
                         `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         `price` DOUBLE NOT NULL,
                         `discountPercent` DOUBLE NOT NULL,
                         `lastPrice` DOUBLE NOT NULL
);
CREATE TABLE `technical_information`(
                                        `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                        `specifications` VARCHAR(255) NOT NULL,
                                        `manufactureDate` DATE NOT NULL
);
CREATE TABLE `users`(
                        `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        `email` VARCHAR(255) NOT NULL,
                        `fullName` VARCHAR(255) NOT NULL,
                        `phoneNumber` VARCHAR(255) NOT NULL,
                        `idAddress` INT NOT NULL
);
CREATE TABLE `message`(
                          `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          `idUser` INT NOT NULL,
                          `title` VARCHAR(255) NOT NULL,
                          `content` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `products` ADD CONSTRAINT `products_idcategory_foreign` FOREIGN KEY(`idCategory`) REFERENCES `categories`(`id`);
ALTER TABLE
    `styles` ADD CONSTRAINT `styles_id_product_foreign` FOREIGN KEY(`id_product`) REFERENCES `products`(`id`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_idvoucher_foreign` FOREIGN KEY(`idVoucher`) REFERENCES `vouchers`(`idVoucher`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_id_foreign` FOREIGN KEY(`id`) REFERENCES `order_details`(`idOrder`);
ALTER TABLE
    `styles` ADD CONSTRAINT `styles_id_foreign` FOREIGN KEY(`id`) REFERENCES `order_details`(`idStyle`);
ALTER TABLE
    `account_users` ADD CONSTRAINT `account_users_iduser_foreign` FOREIGN KEY(`idUser`) REFERENCES `users`(`id`);
ALTER TABLE
    `styles` ADD CONSTRAINT `styles_idprice_foreign` FOREIGN KEY(`idPrice`) REFERENCES `prices`(`id`);
ALTER TABLE
    `deliveries` ADD CONSTRAINT `deliveries_idaddress_foreign` FOREIGN KEY(`idAddress`) REFERENCES `addresses`(`id`);
ALTER TABLE
    `payments` ADD CONSTRAINT `payments_idorder_foreign` FOREIGN KEY(`idOrder`) REFERENCES `orders`(`id`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_iduser_foreign` FOREIGN KEY(`idUser`) REFERENCES `users`(`id`);
ALTER TABLE
    `products` ADD CONSTRAINT `products_idtechnical_foreign` FOREIGN KEY(`idTechnical`) REFERENCES `technical_information`(`id`);
ALTER TABLE
    `users` ADD CONSTRAINT `users_idaddress_foreign` FOREIGN KEY(`idAddress`) REFERENCES `addresses`(`id`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_id_foreign` FOREIGN KEY(`id`) REFERENCES `deliveries`(`idOrder`);
ALTER TABLE
    `message` ADD CONSTRAINT `message_iduser_foreign` FOREIGN KEY(`idUser`) REFERENCES `users`(`id`);