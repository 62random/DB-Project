DELIMITER $$
CREATE FUNCTION maisDeStockMinimo (ids INT, minimo INT)
RETURNS BIT
	
BEGIN
	DECLARE aux INT;
    DECLARE ReturnValue BIT;
	SELECT stock INTO aux FROM Medicamento WHERE id = ids;
    SET ReturnValue = IF(aux > minimo, 1, 0);
    RETURN ReturnValue;
END
DELIMITER;


DELIMITER $$
CREATE FUNCTION fazerLogin (ids INT,passe VARCHAR(40))
RETURNS BIT

BEGIN
	DECLARE ReturnValue BIT;
    DECLARE aux INT;
    SELECT pass INTO aux FROM Cliente WHERE id = ids;
    SET ReturnValue = (STRCMP(aux,passe));
	RETURN ReturnValue;
END
DELIMITER;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_fatura`(id_r INT)

	BEGIN
		START TRANSACTION;
        
		DECLARE quantidade INT = 0;
		DECLARE id_med INT = 0;
        
		SELECT qt_v, id_m INTO quantidade,id_med FROM Fatura_Med WHERE id_f = id_r;
		UPDATE Medicamento SET stock = stock + quantidade WHERE id = id_med;
		DELETE FROM Fatura WHERE id = id_r;
        
        COMMIT;
	END	
    
DELIMITER ;

SET @id_r = 2;
CALL remove_fatura(@id_r);
DROP PROCEDURE remove_fatura;



