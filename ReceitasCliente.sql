CREATE DEFINER=`root`@`localhost` PROCEDURE `receitasCliente`(ids INT)
BEGIN
	SELECT * from Fatura WHERE id_c = ids;
END