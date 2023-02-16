-- MySQL Script generated by MySQL Workbench
-- Wed Sep 14 11:38:55 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`USERS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`USERS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`USERS` (
  `id` INT NOT NULL,
  `profile_image` BLOB NULL DEFAULT 프로필이미지,
  `introduction` VARCHAR(255) NOT NULL DEFAULT '한줄소개',
  `email` VARCHAR(255) NOT NULL DEFAULT '이메일',
  `portfolio` VARCHAR(255) NULL DEFAULT '포트폴리오링크',
  `nickname` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BOARDS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BOARDS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BOARDS` (
  `id` INT NOT NULL,
  `content` BLOB NOT NULL DEFAULT 본문,
  `type` VARCHAR(45) NOT NULL DEFAULT '스터디/프로젝트',
  `backend` INT NULL DEFAULT 백엔드 인원,
  `frontend` INT NULL DEFAULT 프론트엔드 인원,
  `designer` INT NULL DEFAULT 디자이너 인원,
  `people` INT NOT NULL DEFAULT 전체 인원,
  `contact` VARCHAR(45) NOT NULL,
  `due_date` DATE NOT NULL DEFAULT 모집마감일,
  `starting_date` DATE NOT NULL DEFAULT 예상 시작일,
  `period` VARCHAR(45) NOT NULL DEFAULT '예상 진행기간',
  `on_offline` VARCHAR(45) NOT NULL DEFAULT '진행방법',
  `status` VARCHAR(45) NOT NULL DEFAULT '모집상태(모집중/완료)',
  `view` INT NULL DEFAULT 조회수,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_BOARDS_USERS1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_BOARDS_USERS1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `mydb`.`TAGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TAGS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TAGS` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT '이름',
  `type` VARCHAR(45) NOT NULL DEFAULT '백엔드/프론트엔드/모바일/기타/전체',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BOARDS_TAGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BOARDS_TAGS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BOARDS_TAGS` (
  `id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  `board_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_BOARDS_TAGS_TAGS_idx` (`tag_id` ASC) VISIBLE,
  INDEX `fk_BOARDS_TAGS_BOARDS1_idx` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_BOARDS_TAGS_TAGS`
    FOREIGN KEY (`tag_id`)
    REFERENCES `mydb`.`TAGS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BOARDS_TAGS_BOARDS1`
    FOREIGN KEY (`board_id`)
    REFERENCES `mydb`.`BOARDS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `mydb`.`BOOKMARKS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BOOKMARKS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BOOKMARKS` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `board_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_BOOKMARKS_USERS1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_BOOKMARKS_BOARDS1_idx` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_BOOKMARKS_USERS1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BOOKMARKS_BOARDS1`
    FOREIGN KEY (`board_id`)
    REFERENCES `mydb`.`BOARDS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USERS_TAGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`USERS_TAGS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`USERS_TAGS` (
  `id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_USERS_TAGS_TAGS1_idx` (`tag_id` ASC) VISIBLE,
  INDEX `fk_USERS_TAGS_USERS1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_USERS_TAGS_TAGS1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `mydb`.`TAGS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USERS_TAGS_USERS1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LIKES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LIKES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LIKES` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `board_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_LIKES_USERS1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_LIKES_BOARDS1_idx` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_LIKES_USERS1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LIKES_BOARDS1`
    FOREIGN KEY (`board_id`)
    REFERENCES `mydb`.`BOARDS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`QUESTIONS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`QUESTIONS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`QUESTIONS` (
  `id` INT NOT NULL,
  `content` VARCHAR(255) NULL DEFAULT '내용',
  `board_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_QUESTIONS_BOARDS1_idx` (`board_id` ASC) VISIBLE,
  INDEX `fk_QUESTIONS_USERS1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_QUESTIONS_BOARDS1`
    FOREIGN KEY (`board_id`)
    REFERENCES `mydb`.`BOARDS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_QUESTIONS_USERS1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ANSWERS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ANSWERS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ANSWERS` (
  `id` INT NOT NULL,
  `content` VARCHAR(45) NULL,
  `question_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ANSWERS_QUESTIONS1_idx` (`question_id` ASC) VISIBLE,
  INDEX `fk_ANSWERS_USERS1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_ANSWERS_QUESTIONS1`
    FOREIGN KEY (`question_id`)
    REFERENCES `mydb`.`QUESTIONS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ANSWERS_USERS1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`APPLIES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`APPLIES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`APPLIES` (
  `id` INT NOT NULL,
  `board_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `position` VARCHAR(45) NOT NULL DEFAULT '지원포지션',
  `is_accepted` TINYINT NULL DEFAULT 수락/거절,
  PRIMARY KEY (`id`),
  INDEX `fk_APPLIES_BOARDS1_idx` (`board_id` ASC) VISIBLE,
  INDEX `fk_APPLIES_USERS1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_APPLIES_BOARDS1`
    FOREIGN KEY (`board_id`)
    REFERENCES `mydb`.`BOARDS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_APPLIES_USERS1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;