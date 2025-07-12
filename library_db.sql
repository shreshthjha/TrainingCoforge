-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema library_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema library_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library_db` DEFAULT CHARACTER SET utf8 ;
USE `library_db` ;

-- -----------------------------------------------------
-- Table `library_db`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_db`.`members` (
  `member_id` INT NOT NULL,
  `member_type` ENUM('student', 'staff') NOT NULL,
  `join_date` DATE NOT NULL,
  PRIMARY KEY (`member_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library_db`.`returns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_db`.`returns` (
  `return_id` INT NOT NULL AUTO_INCREMENT,
  `borrow_id` INT NOT NULL,
  `return_date` DATE NOT NULL,
  `fine_amount` DECIMAL(6,2) NULL,
  PRIMARY KEY (`return_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library_db`.`borrows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_db`.`borrows` (
  `borrow_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `borrow_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  `returns_return_id` INT NOT NULL,
  PRIMARY KEY (`borrow_id`, `returns_return_id`),
  INDEX `fk_borrows_returns1_idx` (`returns_return_id` ASC) VISIBLE,
  CONSTRAINT `fk_borrows_returns1`
    FOREIGN KEY (`returns_return_id`)
    REFERENCES `library_db`.`returns` (`return_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library_db`.`fines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_db`.`fines` (
  `fine_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `amount` DECIMAL(6,2) NOT NULL,
  `reason` VARCHAR(100) NULL,
  `paid_status` ENUM('paid', 'unpaid') NOT NULL,
  PRIMARY KEY (`fine_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library_db`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_db`.`accounts` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `total_fines_paid` DECIMAL(6,2) NOT NULL,
  `balance` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`account_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_db`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `email` VARCHAR(100) NULL,
  `password` VARCHAR(45) NULL,
  `role` ENUM('librarian', 'student', 'staff') NULL,
  `members_member_id` INT NOT NULL,
  `borrows_borrow_id` INT NOT NULL,
  `fines_fine_id` INT NOT NULL,
  `accounts_account_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `members_member_id`, `borrows_borrow_id`, `fines_fine_id`, `accounts_account_id`),
  UNIQUE INDEX `email_UNIQUE` (`email`) VISIBLE,
  INDEX `fk_users_members_idx` (`members_member_id` ASC) VISIBLE,
  INDEX `fk_users_borrows1_idx` (`borrows_borrow_id` ASC) VISIBLE,
  INDEX `fk_users_fines1_idx` (`fines_fine_id` ASC) VISIBLE,
  INDEX `fk_users_accounts1_idx` (`accounts_account_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_members`
    FOREIGN KEY (`members_member_id`)
    REFERENCES `library_db`.`members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_borrows1`
    FOREIGN KEY (`borrows_borrow_id`)
    REFERENCES `library_db`.`borrows` (`borrow_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_fines1`
    FOREIGN KEY (`fines_fine_id`)
    REFERENCES `library_db`.`fines` (`fine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_accounts1`
    FOREIGN KEY (`accounts_account_id`)
    REFERENCES `library_db`.`accounts` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library_db`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_db`.`books` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `author` VARCHAR(100) NOT NULL,
  `isbn` VARCHAR(45) NOT NULL,
  `total_copies` INT NOT NULL,
  `available_copies` INT NOT NULL,
  `borrows_borrow_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `borrows_borrow_id`),
  INDEX `fk_books_borrows1_idx` (`borrows_borrow_id` ASC) VISIBLE,
  CONSTRAINT `fk_books_borrows1`
    FOREIGN KEY (`borrows_borrow_id`)
    REFERENCES `library_db`.`borrows` (`borrow_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
