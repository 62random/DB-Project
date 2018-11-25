CREATE DEFINER=`root`@`localhost` PROCEDURE `trans_new_fatura`(id INT, dataF DATETIME, dataS DATETIME, pontos_R INT, pontos_U INT, desconto FLOAT, total FLOAT, id_func INT, id_c INT, Faturacol VARCHAR(45),
    cod_receita INT)
BEGIN
	START TRANSACTION;
     CALL new_fatura(id , dataF , dataS , pontos_R , pontos_U , desconto , total , id_func , id_c , Faturacol);
     CALL new_fatura_receita(id, cod_receita);
	 CALL add_pontos_cliente(id_c, total);
     
    
	
    COMMIT;
END