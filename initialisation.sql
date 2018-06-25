-- MySQL Workbench Synchronization
-- Generated: 2018-06-25 12:51
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Yauhen

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `CourierService` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

CREATE TABLE IF NOT EXISTS `CourierService`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `e-mail` VARCHAR(45) NOT NULL COMMENT 'Must be unique for login use',
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `sex` TINYINT(4) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NOT NULL COMMENT 'Must be unique for login use',
  `adress` VARCHAR(45) NULL DEFAULT NULL,
  `is_verified` TINYINT(4) NULL DEFAULT NULL COMMENT 'Boolean field thats show is verification completed or not',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Contains all Users.';

CREATE TABLE IF NOT EXISTS `CourierService`.`role` (
  `role` VARCHAR(10) NOT NULL COMMENT 'Unique field ',
  PRIMARY KEY (`role`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Roles of users';

CREATE TABLE IF NOT EXISTS `CourierService`.`users_has_role` (
  `users_id` INT(11) NOT NULL,
  `role_role` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`users_id`, `role_role`),
  INDEX `fk_users_has_role_role1_idx` (`role_role` ASC),
  INDEX `fk_users_has_role_users_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_has_role_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `CourierService`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_role_role1`
    FOREIGN KEY (`role_role`)
    REFERENCES `CourierService`.`role` (`role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Service table to m-2-m connection';

CREATE TABLE IF NOT EXISTS `CourierService`.`transport` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL COMMENT 'Name to display',
  `capacity` INT(11) NULL DEFAULT NULL COMMENT 'Capacity in kg',
  `volume` INT(11) NULL DEFAULT NULL COMMENT 'Volume in litres',
  `user_id` INT(11) NOT NULL COMMENT 'User that use this transport for delivery',
  PRIMARY KEY (`id`),
  INDEX `fk_transport_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_transport_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CourierService`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Transport that user can use to delivery';

CREATE TABLE IF NOT EXISTS `CourierService`.`order` (
  `id` INT(11) NOT NULL,
  `from` VARCHAR(90) NOT NULL COMMENT 'Adress from',
  `to` VARCHAR(90) CHARACTER SET 'armscii8' NOT NULL COMMENT 'Adress to',
  `time_placed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When order was placed. Current time as default',
  `price` DECIMAL(5,2) NOT NULL COMMENT 'Price',
  `time_must_done` DATETIME NULL DEFAULT NULL COMMENT 'Time when order must be deliveried',
  `time_done` DATETIME NULL DEFAULT NULL COMMENT 'Time when order was successfully deliveried',
  `status` VARCHAR(10) NOT NULL COMMENT 'Current status of order',
  `mark` INT(11) NULL DEFAULT NULL COMMENT 'Mark given by customer for this order',
  `customer_id` INT(11) NOT NULL COMMENT 'User id for Customer',
  `carrier_id` INT(11) NOT NULL COMMENT 'User id for carrier',
  `cargo_type_type` VARCHAR(45) NOT NULL COMMENT 'Type of goods to deliver',
  `transport_id` INT(11) NOT NULL COMMENT 'Transport that use carrier for delivery',
  PRIMARY KEY (`id`),
  INDEX `fk_order_user1_idx` (`customer_id` ASC),
  INDEX `fk_order_user2_idx` (`carrier_id` ASC),
  INDEX `fk_order_cargo_type1_idx` (`cargo_type_type` ASC),
  INDEX `fk_order_transport1_idx` (`transport_id` ASC),
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `CourierService`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_user2`
    FOREIGN KEY (`carrier_id`)
    REFERENCES `CourierService`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_cargo_type1`
    FOREIGN KEY (`cargo_type_type`)
    REFERENCES `CourierService`.`cargo_type` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_transport1`
    FOREIGN KEY (`transport_id`)
    REFERENCES `CourierService`.`transport` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'All orders';

CREATE TABLE IF NOT EXISTS `CourierService`.`payment` (
  `id` INT(11) NOT NULL,
  `time_made` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time when payment was made. With current time for default.',
  `amount` DECIMAL(5,2) NOT NULL COMMENT 'Size of payment',
  `is_confirmed` TINYINT(4) NULL DEFAULT NULL COMMENT 'Boolean that shows is payment confirmed by Administrator',
  `time_confirmed` DATETIME NULL DEFAULT NULL COMMENT 'Time of confirmation',
  `payment_type` VARCHAR(10) NOT NULL COMMENT 'Type of payment',
  `order_id` INT(11) NOT NULL COMMENT 'Order thats was payed for',
  `user_id` INT(11) NOT NULL COMMENT 'User who was made this payment',
  PRIMARY KEY (`id`),
  INDEX `fk_payment_order1_idx` (`order_id` ASC),
  INDEX `fk_payment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_payment_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `CourierService`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CourierService`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Holds all payments made by users for orders\n';

CREATE TABLE IF NOT EXISTS `CourierService`.`cargo_type` (
  `type` VARCHAR(45) NOT NULL COMMENT 'One field, used as id because unique',
  PRIMARY KEY (`type`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Types of goods to delivery';

CREATE TABLE IF NOT EXISTS `CourierService`.`document` (
  `id` INT(11) NOT NULL,
  `document` BLOB NULL DEFAULT NULL COMMENT 'Holds file of user document',
  `is_passport_or_license` TINYINT(4) NULL DEFAULT 0 COMMENT 'Shows that document shows credentials of user',
  `user_id` INT(11) NOT NULL COMMENT 'User who uploaded this',
  `messages_id` INT(11) NULL DEFAULT NULL COMMENT 'If it attachment to message here is id of this message',
  PRIMARY KEY (`id`),
  INDEX `fk_documents_user1_idx` (`user_id` ASC),
  INDEX `fk_documents_messages1_idx` (`messages_id` ASC),
  CONSTRAINT `fk_documents_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CourierService`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `CourierService`.`message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Holds all uploaded documents';

CREATE TABLE IF NOT EXISTS `CourierService`.`transport_has_cargo_type` (
  `transport_id` INT(11) NOT NULL,
  `cargo_type_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transport_id`, `cargo_type_type`),
  INDEX `fk_transport_has_cargo_type_cargo_type1_idx` (`cargo_type_type` ASC),
  INDEX `fk_transport_has_cargo_type_transport1_idx` (`transport_id` ASC),
  CONSTRAINT `fk_transport_has_cargo_type_transport1`
    FOREIGN KEY (`transport_id`)
    REFERENCES `CourierService`.`transport` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transport_has_cargo_type_cargo_type1`
    FOREIGN KEY (`cargo_type_type`)
    REFERENCES `CourierService`.`cargo_type` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Service table to m-2-m connection';

CREATE TABLE IF NOT EXISTS `CourierService`.`message` (
  `id` INT(11) NOT NULL,
  `text_message` VARCHAR(256) NULL DEFAULT NULL COMMENT 'Message text',
  `time_when_placed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Time when was send. Current time as default',
  `is_viewed` TINYINT(4) NULL DEFAULT 0 COMMENT 'Shows was it opened by receiver or not',
  `order_id` INT(11) NOT NULL COMMENT 'Order that message was for',
  `user_id` INT(11) NOT NULL COMMENT 'User who send it',
  `is_for_admin` TINYINT(4) NULL DEFAULT 0 COMMENT 'Shows that this message was sent to Administrator',
  PRIMARY KEY (`id`),
  INDEX `fk_messages_order1_idx` (`order_id` ASC),
  INDEX `fk_messages_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_messages_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `CourierService`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CourierService`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Messages sent by users';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
