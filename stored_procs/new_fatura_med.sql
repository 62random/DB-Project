CREATE DEFINER=`root`@`localhost` PROCEDURE `new_fatura_med`(id_f INT, id_m INT, qt_v INT, preco_v FLOAT, preco_l FLOAT)
BEGIN
	INSERT INTO fatura_med VALUES (id_f, id_m, qt_v, preco_v, preco_v);
END