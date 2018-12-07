CREATE DEFINER=`root`@`localhost` FUNCTION `LoginCliente`(ids INT,passe VARCHAR(40)) RETURNS bit(1)
    DETERMINISTIC
BEGIN
	DECLARE ReturnValue bit(1);
    DECLARE aux VARCHAR(41);
    SELECT pass INTO aux FROM Cliente WHERE id = ids;
    SET ReturnValue = if(STRCMP(aux,passe),0,1);
	RETURN ReturnValue;
END