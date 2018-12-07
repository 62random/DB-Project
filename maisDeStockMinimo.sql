CREATE DEFINER=`root`@`localhost` FUNCTION `maisDeStockMinimo`(ids INT, minimo INT) RETURNS bit(1)
    DETERMINISTIC
BEGIN
	DECLARE aux INT;
    DECLARE ReturnValue BIT;
	SELECT stock INTO aux FROM Medicamento WHERE id = ids;
    SET ReturnValue = IF(aux > minimo, 1, 0);
    RETURN ReturnValue;
END