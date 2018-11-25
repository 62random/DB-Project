CREATE DEFINER=`root`@`localhost` PROCEDURE `new_cliente`(id INT, nome VARCHAR(75), nif VARCHAR(9), email VARCHAR(50), tlmv VARCHAR(20), pontos INT)
BEGIN
	INSERT INTO cliente VALUES (id, nome, nif, email, tlmv, pontos);
END