-- -----------------------------------------------------
-- Schema Social
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Social` ;

CREATE SCHEMA IF NOT EXISTS `Social` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `Social` ;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `first_name` VARCHAR(20) NOT NULL DEFAULT '',
  `last_name` VARCHAR(20) NOT NULL DEFAULT '',
  `middle_name` VARCHAR(20) NOT NULL DEFAULT '',
  `is_active` TINYINT(1) NOT NULL DEFAULT 0,
  `is_reported` TINYINT(1) NOT NULL DEFAULT 0,
  `is_blocked` TINYINT(1) NOT NULL DEFAULT 0,
  `preferences` TEXT NOT NULL DEFAULT '',
  `bio_id` TEXT NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `phone_UNIQUE` ON `users` (`phone` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `email_UNIQUE` ON `users` (`email` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Location` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Location` (
  `Userid`,
  `address` text,
  `state` text,
  `city` text,
  `country_code`,
  `postcode_or_zip` text
  PRIMARY KEY (`Userid`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BioProfile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BioProfile` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BioProfile` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `bio` TEXT NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `user_id_for_BioProfile` ON `BioProfile` (`user_id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `ProfilePicture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProfilePicture` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ProfilePicture` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `ProfilePicture` VARCHAR(255) NOT NULL DEFAULT '',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `user_id_for_ProfilePicture` ON `ProfilePicture` (`user_id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contacts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `contacts` (
  `FriendshipID` INT NOT NULL,
  `Userid` INT NOT NULL,
  `Userid_2` INT NOT NULL,
  `RelationshipTypeID` INT,
  `created_at` VARCHAR(45) NOT NULL,
  `updated_at` VARCHAR(45) NOT NULL
  PRIMARY KEY (`FriendshipID`))
ENGINE = InnoDB;
CREATE UNIQUE INDEX `FriendshipID_for_contacts` ON `contacts` (`FriendshipID` ASC) VISIBLE;
CREATE UNIQUE INDEX `RelationshipTypeID_for_contacts` ON `contacts` (`RelationshipTypeID` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `RelationshipType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RelationshipType` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `RelationshipType` (
  `RelationshipTypeID` INT,
  `RelationshipDesc` INT NOT NULL,
  `created_at` VARCHAR(45) NOT NULL,
  `updated_at` VARCHAR(45) NOT NULL
  PRIMARY KEY (`RelationshipTypeID`))
ENGINE = InnoDB;
CREATE UNIQUE INDEX `RelationshipTypeID_for_RelationshipType` ON `RelationshipType` (`RelationshipTypeID` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Post` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Post` (
  `PostID` INT,
  `UserID` INT,
  `TotalLikes` INT,
  `Content` TEXT,
  `MediaType` VARCHAR(20),
  `MediaURL` VARCHAR(255),
  `Timestamp` TIMESTAMP,
  `created_at` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PostID`))
ENGINE = InnoDB;

SHOW WARNINGS;


-- -----------------------------------------------------
-- Table `Like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Like` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Like` (
  `LikeID` INT,
  `PostID` INT,
  `CommentID` INT,
  `UserID` INT,
  `created_at` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`LikeID`))
ENGINE = InnoDB;
SHOW WARNINGS;


-- -----------------------------------------------------
-- Table `Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Event` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Event` (
    `EventID` INTEGER,
    `title` TEXT NOT NULL,
    `description` TEXT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE, 
    `start_time` TIME NOT NULL,
    `end_time` TIME,
    `location_map` TEXT,
    `city_id` INTEGER NOT NULL,
    `organizer_id` INTEGER NOT NULL,
    `guest_list` TEXT,
    `latitude` REAL,
    `longitude` REAL
  PRIMARY KEY (`EventID`))
ENGINE = InnoDB;
SHOW WARNINGS;



-- -----------------------------------------------------
-- Table `Invite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Invite` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Invite` (
    `InviteID` INTEGER,
    `event_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,
    `content` TEXT,
    `status` TEXT CHECK (status IN ('accepted', 'denied', 'waiting')) NOT NULL,
    `feedback` TEXT,
  PRIMARY KEY (`InviteID`))
ENGINE = InnoDB;
SHOW WARNINGS;




-- -----------------------------------------------------
-- Table `Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comment` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Comment` (
  `CommentID` INT,
  `PostID` INT,
  `Content` TEXT,
  `created_at` VARCHAR(45) NOT NULL,
  `updated_at` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CommentID`))
ENGINE = InnoDB;
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `conversation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `conversation` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `conversation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(40) NOT NULL,
  `creator_id` INT NOT NULL,
  `channel_id` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `deleted_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;


-- -----------------------------------------------------
-- Table `participants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `participants` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `participants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `conversation_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `type` ENUM('single', 'group') NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `participants_UNIQUE` ON `participants` (
   `conversation_id`, `users_id`) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reports` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `reports` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `participants_id` INT NOT NULL,
  `report_type` VARCHAR(45) NOT NULL,
  `notes` TEXT NOT NULL,
  `status` ENUM('pending', 'resolved') NOT NULL DEFAULT 'pending',
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `block_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `block_list` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `block_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `participants_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;


-- -----------------------------------------------------
-- Table `access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `access` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `access` (
  `id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `devices_id` INT NOT NULL,
  `token` VARCHAR(60) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `deleted_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `user_verification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_verification` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `user_verification` (
  `users_id` INT NOT NULL,
  `verification_code` VARCHAR(45) NOT NULL,
  `created_at` VARCHAR(45) NOT NULL)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `attachments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attachments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `attachments` (
  `id` INT NOT NULL,
  `messages_id` INT NOT NULL,
  `thumb_url` VARCHAR(45) NOT NULL,
  `file_url` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
