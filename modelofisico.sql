-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema farmacia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema farmacia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `farmacia` DEFAULT CHARACTER SET utf8 ;
USE `farmacia` ;

-- -----------------------------------------------------
-- Table `farmacia`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`cliente` (
  `id` INT(11) NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `nif` VARCHAR(9) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `tlmv` VARCHAR(20) NULL DEFAULT NULL,
  `pontos` INT(11) NOT NULL,
  `pass` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `farmacia`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`funcionario` (
  `id` INT(11) NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `tlmv` VARCHAR(20) NOT NULL,
  `niss` VARCHAR(11) NOT NULL,
  `iban` VARCHAR(32) NOT NULL,
  `ordenado` DECIMAL(6,2) NOT NULL,
  `cedula` VARCHAR(6) NOT NULL,
  `pass` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `farmacia`.`fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`fatura` (
  `id` INT(11) NOT NULL,
  `data_f` DATETIME NOT NULL,
  `data_s` DATETIME NOT NULL,
  `pontos_r` INT(11) NOT NULL,
  `pontos_u` INT(11) NOT NULL,
  `desconto` DECIMAL(6,2) NOT NULL,
  `total` DECIMAL(6,2) NOT NULL,
  `id_func` INT(11) NOT NULL,
  `id_c` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`id_func` ASC) VISIBLE,
  INDEX `id_cliente_idx` (`id_c` ASC) VISIBLE,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_c`)
    REFERENCES `farmacia`.`cliente` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `id_func`
    FOREIGN KEY (`id_func`)
    REFERENCES `farmacia`.`funcionario` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `farmacia`.`medicamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`medicamento` (
  `id` INT(11) NOT NULL,
  `des` VARCHAR(45) NOT NULL,
  `qt` DECIMAL(6,2) NOT NULL,
  `un` VARCHAR(5) NOT NULL,
  `formato` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
  `stock` INT(11) NOT NULL,
  `lab` VARCHAR(45) NOT NULL,
  `receita` CHAR(1) NOT NULL,
  `pos` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `farmacia`.`fatura_med`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`fatura_med` (
  `id_f` INT(11) NOT NULL,
  `id_m` INT(11) NOT NULL,
  `qt_v` INT(11) NOT NULL,
  `preco_v` DECIMAL(6,2) NOT NULL,
  `preco_l` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_f`, `id_m`),
  INDEX `id_m_idx` (`id_m` ASC) VISIBLE,
  CONSTRAINT `id_f`
    FOREIGN KEY (`id_f`)
    REFERENCES `farmacia`.`fatura` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_m`
    FOREIGN KEY (`id_m`)
    REFERENCES `farmacia`.`medicamento` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `farmacia`.`fatura_receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`fatura_receita` (
  `id_fatura` INT(11) NOT NULL,
  `cod_receita` INT(11) NOT NULL,
  PRIMARY KEY (`id_fatura`, `cod_receita`),
  CONSTRAINT `id_fatura`
    FOREIGN KEY (`id_fatura`)
    REFERENCES `farmacia`.`fatura` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
