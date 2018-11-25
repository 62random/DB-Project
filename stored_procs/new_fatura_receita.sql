CREATE DEFINER=`root`@`localhost` PROCEDURE `new_fatura_receita`(id_fatura INT, cod_receita INT)
BEGIN
	INSERT INTO fatura_med VALUES (id_fatura, cod_receita);
END