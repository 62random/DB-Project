CREATE DEFINER=`root`@`localhost` PROCEDURE `new_medicamento`(id INT, des VARCHAR(45), qt FLOAT, un VARCHAR(5), formato VARCHAR(45), categoria VARCHAR(45), preco FLOAT, stock INT, receita INT, pos CHAR(3))
BEGIN
	INSERT INTO fatura_med VALUES (id, des, qt, un, formato, categoria, preco, preco, stock, lab, receita, pos);
END