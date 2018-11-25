CREATE DEFINER=`root`@`localhost` PROCEDURE `add_pontos_cliente`(id_cliente INT, valor FLOAT)
BEGIN
	if(valor > 10 and (SELECT pontos FROM cliente WHERE cliente.id= id_cliente) > 10) THEN
		UPDATE cliente SET pontos = pontos + 15 WHERE id= id_cliente;
        elseif (valor > 10) then
        UPDATE cliente SET pontos = pontos + 10 WHERE id= id_cliente;
	end if;
END