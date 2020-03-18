CREATE TABLE `pharmacies` (
	`pharmacy_id` INT NOT NULL AUTO_INCREMENT,
	`pharmacy_name` varchar(200) NOT NULL,
	`phone` varchar(30) NOT NULL,
	`email` varchar(50) NOT NULL,
	`street` varchar(50) NOT NULL,
	`city` varchar(50) NOT NULL,
	`state` varchar(50) NOT NULL,
	PRIMARY KEY (`pharmacy_id`)
);

CREATE TABLE `customers` (
	`customer_id` INT NOT NULL AUTO_INCREMENT,
	`first_name` varchar(40) NOT NULL,
	`last_name` varchar(40) NOT NULL,
	`phone` varchar(30) NOT NULL UNIQUE,
	`email` varchar(50) NOT NULL,
	`street` varchar(50) NOT NULL,
	`city` varchar(50) NOT NULL,
	`state` varchar(50) NOT NULL,
	`zip_code` varchar(50) NOT NULL,
	`login` varchar(150) NOT NULL UNIQUE,
	`password` varchar(150) NOT NULL,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE `orders` (
	`order_id` INT NOT NULL,
	`customer_id` INT NOT NULL UNIQUE,
	`pharmacy_id` INT NOT NULL UNIQUE,
	`order_status` BINARY NOT NULL,
	`order_date` DATETIME NOT NULL,
	PRIMARY KEY (`order_id`)
);

CREATE TABLE `order_items` (
	`item_id` INT NOT NULL AUTO_INCREMENT,
	`order_id` INT NOT NULL,
	`medicine_id` INT NOT NULL UNIQUE,
	`quantity` INT NOT NULL,
	`price` varchar(40) NOT NULL,
	`discount` INT NOT NULL,
	PRIMARY KEY (`item_id`)
);

CREATE TABLE `medicines` (
	`medicine_id` INT NOT NULL AUTO_INCREMENT,
	`medicine_name` varchar(100) NOT NULL AUTO_INCREMENT,
	`category_id` INT NOT NULL,
	`brand_id` INT NOT NULL,
	PRIMARY KEY (`medicine_id`)
);

CREATE TABLE `categories` (
	`category_id` INT NOT NULL AUTO_INCREMENT,
	`category_name` varchar(50) NOT NULL,
	PRIMARY KEY (`category_id`)
);

CREATE TABLE `stock` (
	`pharmacy_id` INT NOT NULL,
	`medicine_id` INT NOT NULL,
	`quantity` INT
);

CREATE TABLE `brands` (
	`brand_id` INT NOT NULL AUTO_INCREMENT,
	`brand_name` varchar(50) NOT NULL,
	PRIMARY KEY (`brand_id`)
);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies`(`pharmacy_id`);

ALTER TABLE `order_items` ADD CONSTRAINT `order_items_fk0` FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`);

ALTER TABLE `order_items` ADD CONSTRAINT `order_items_fk1` FOREIGN KEY (`medicine_id`) REFERENCES `medicines`(`medicine_id`);

ALTER TABLE `medicines` ADD CONSTRAINT `medicines_fk0` FOREIGN KEY (`category_id`) REFERENCES `categories`(`category_id`);

ALTER TABLE `medicines` ADD CONSTRAINT `medicines_fk1` FOREIGN KEY (`brand_id`) REFERENCES `brands`(`brand_id`);

ALTER TABLE `stock` ADD CONSTRAINT `stock_fk0` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies`(`pharmacy_id`);

ALTER TABLE `stock` ADD CONSTRAINT `stock_fk1` FOREIGN KEY (`medicine_id`) REFERENCES `medicines`(`medicine_id`);

