CREATE DEFINER=`root`@`localhost` PROCEDURE `new_funcionario`(id INT, nome VARCHAR(75), niss VARCHAR(11), iban VARCHAR(25), ordenado FLOAT, tlmv INT, cedula VARCHAR(6))
BEGIN
	INSERT INTO funcionario VALUES (id, nome, tlmv, niss, iban, ordenado, cedula);
END