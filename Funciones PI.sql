 --1.- función  que te permite ver el auto y quién lo conduce 

CREATE FUNCTION ObtenerInformacionAutoConductor2(@id_auto int)
RETURNS TABLE
AS
RETURN
(
    SELECT Autos.matricula, Personas.nombre AS nombre_conductor
    FROM Autos
    INNER JOIN Conductores ON Autos.id = Conductores.id_auto
    INNER JOIN Personas ON Conductores.id_persona = Personas.id
    WHERE Autos.id = @id_auto
);
SELECT *FROM dbo.ObtenerInformacionAutoConductor(2);

--Realizar una funcion que premita buscar un auto por Marca.

CREATE FUNCTION BuscarAutoPorMarca(@marca varchar(200))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Autos
    WHERE marca = @marca
);

SELECT * FROM dbo.BuscarAutoPorMarca('Toyota');

--función en sql  para saber el genero de una persona
CREATE FUNCTION ObtenerGeneroPersona(@id_persona int)
RETURNS varchar(200)
AS
BEGIN
    DECLARE @genero varchar(200);
    
    SELECT @genero = g.nombre
    FROM Personas p
    INNER JOIN Generos g ON p.id_genero = g.id
    WHERE p.id = @id_persona;
    
    RETURN @genero;
END;

DECLARE @id_persona int;
SET @id_persona = 6; -- Cambia el valor por el id de la persona deseada

SELECT dbo.ObtenerGeneroPersona(1) AS GeneroPersona;

--- funcion  que muestre las rutas y paradas 
CREATE FUNCTION ObtenerRutasYParadas()
RETURNS TABLE
AS
RETURN
(
    SELECT r.nombre AS ruta, p.nombre AS parada
    FROM Rutas r
    INNER JOIN Paradas p ON r.id = p.id
);

SELECT *FROM dbo.ObtenerRutasYParadas();


