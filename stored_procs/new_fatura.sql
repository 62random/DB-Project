CREATE DEFINER=`root`@`localhost` PROCEDURE `new_fatura`(id INT, dataF DATETIME, dataS DATETIME, pontos_R INT, pontos_U INT, desconto FLOAT, total FLOAT, id_func INT, id_c INT, Faturacol VARCHAR(45))
BEGIN
	INSERT INTO fatura VALUES (id, dataF, dataS, pontos_R, pontos_U, desconto, total, id_func, id_c, Faturacol);
END