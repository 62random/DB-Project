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
-- Table `farmacia`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`Funcionario` (
  `id` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `tlmv` VARCHAR(20) NOT NULL,
  `niss` VARCHAR(11) NOT NULL,
  `iban` VARCHAR(32) NOT NULL,
  `ordenado` FLOAT NOT NULL,
  `cedula` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`Cliente` (
  `id` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `nif` VARCHAR(9) NULL,
  `email` VARCHAR(50) NULL,
  `tlmv` VARCHAR(20) NULL,
  `pontos` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`Fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`Fatura` (
  `id` INT NOT NULL,
  `data_f` DATETIME NOT NULL,
  `data_s` DATETIME NOT NULL,
  `pontos_r` INT NOT NULL,
  `pontos_u` INT NOT NULL,
  `desconto` FLOAT NOT NULL,
  `total` FLOAT NOT NULL,
  `id_func` INT NOT NULL,
  `id_c` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`id_func` ASC) VISIBLE,
  INDEX `id_cliente_idx` (`id_c` ASC) VISIBLE,
  CONSTRAINT `id_func`
    FOREIGN KEY (`id_func`)
    REFERENCES `farmacia`.`Funcionario` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_c`)
    REFERENCES `farmacia`.`Cliente` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`Fatura_Receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`Fatura_Receita` (
  `id_fatura` INT NOT NULL,
  `cod_receita` INT NOT NULL,
  PRIMARY KEY (`id_fatura`, `cod_receita`),
  CONSTRAINT `id_fatura`
    FOREIGN KEY (`id_fatura`)
    REFERENCES `farmacia`.`Fatura` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`Medicamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`Medicamento` (
  `id` INT NOT NULL,
  `des` VARCHAR(45) NOT NULL,
  `qt` FLOAT NOT NULL,
  `un` VARCHAR(5) NOT NULL,
  `formato` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `preco` FLOAT NOT NULL,
  `stock` INT NOT NULL,
  `lab` VARCHAR(45) NOT NULL,
  `receita` CHAR(1) NOT NULL,
  `pos` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `farmacia`.`Fatura_Med`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `farmacia`.`Fatura_Med` (
  `id_f` INT NOT NULL,
  `id_m` INT NOT NULL,
  `qt_v` INT NOT NULL,
  `preco_v` FLOAT NOT NULL,
  `preco_l` FLOAT NOT NULL,
  PRIMARY KEY (`id_f`, `id_m`),
  INDEX `id_m_idx` (`id_m` ASC) VISIBLE,
  CONSTRAINT `id_f`
    FOREIGN KEY (`id_f`)
    REFERENCES `farmacia`.`Fatura` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_m`
    FOREIGN KEY (`id_m`)
    REFERENCES `farmacia`.`Medicamento` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
