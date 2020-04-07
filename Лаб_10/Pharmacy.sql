CREATE DATABASE pharmacy;
USE pharmacy;

CREATE TABLE `pharmacy` (
	`pharmacy_id` INT NOT NULL AUTO_INCREMENT,
	`pharmacy_name` varchar(200) NOT NULL,
	`phone` varchar(30),
	`email` varchar(50),
	`street` varchar(50),
	`city` varchar(50),
	`state` varchar(50),
	PRIMARY KEY (`pharmacy_id`)
);

CREATE TABLE `customer` (
	`customer_id` INT AUTO_INCREMENT,
	`first_name` varchar(40) NOT NULL,
	`last_name` varchar(40) NOT NULL,
	`phone` varchar(30),
	`email` varchar(50),
	`street` varchar(50),
	`city` varchar(50) DEFAULT "Lviv",
	`state` varchar(50),
	`zip_code` varchar(50),
	`login` varchar(150) NOT NULL,
	`password` varchar(150) NOT NULL,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE `order` (
	`order_id` INT NOT NULL AUTO_INCREMENT,
	`customer_id` INT NOT NULL,
	`pharmacy_id` INT,
	`order_date` DATETIME,
	`order_status` BINARY,
	PRIMARY KEY (`order_id`),
    CONSTRAINT `order_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `order_fk1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy`(`pharmacy_id`) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `medicine_category` (
	`medicine_category_id` INT NOT NULL AUTO_INCREMENT,
	`medicine_category` varchar(255) NOT NULL,
	PRIMARY KEY (`medicine_category_id`)
);

CREATE TABLE `all_medicine` (
	`medicine_name` varchar(255) NOT NULL,
    `medicine_category_id` INT NOT NULL,
	`medicine_description` varchar(150),
	`contraindication` varchar(150),
	`appliance` varchar(150),
	PRIMARY KEY (`medicine_name`),
    CONSTRAINT `all_medicine_fk0` FOREIGN KEY (`medicine_category_id`) REFERENCES `medicine_category`(`medicine_category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `medicine` (
	`medicine_id` INT NOT NULL AUTO_INCREMENT,
	`pharmacy_id` INT NOT NULL,
	`medicine_name` varchar(150) NOT NULL,
	`quantity` INT NOT NULL,
	`price` INT NOT NULL,
	PRIMARY KEY (`medicine_id`),
    CONSTRAINT `medicine_fk0` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy`(`pharmacy_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `medicine_fk1` FOREIGN KEY (`medicine_name`) REFERENCES `all_medicine`(`medicine_name`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `order_item` (
	`item_id` INT NOT NULL AUTO_INCREMENT,
	`medicine_id` INT NOT NULL,
	`quantity` INT NOT NULL,
	`discount` INT,
	`order_id` INT NOT NULL,
	PRIMARY KEY (`item_id`),
    CONSTRAINT `order_item_fk0` FOREIGN KEY (`medicine_id`) REFERENCES `medicine`(`medicine_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `order_item_fk1` FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `delivery` (
	`delivery_id` INT NOT NULL AUTO_INCREMENT,
	`order_id` INT NOT NULL UNIQUE,
	`delivery_status` BOOLEAN NOT NULL,
	`delivery_price` INT NOT NULL,
	PRIMARY KEY (`delivery_id`),
    CONSTRAINT `delivery_fk0` FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `delivery_man` (
	`delivery_man_id` INT NOT NULL AUTO_INCREMENT,
	`delivery_id` INT NOT NULL,
	`first_name` varchar(100) NOT NULL,
	`last_name` varchar(100) NOT NULL,
	`phone` varchar(100),
	PRIMARY KEY (`delivery_man_id`),
    CONSTRAINT `delivery_man_fk0` FOREIGN KEY (`delivery_id`) REFERENCES `delivery`(`delivery_id`) ON DELETE NO ACTION ON UPDATE NO ACTION 
);
