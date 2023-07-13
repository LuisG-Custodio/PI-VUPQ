--1.- Crear un trigger que no deje eliminar o modificar el id de una tabla y te marque error
CREATE TRIGGER TR_Personas_PreventIdChange
ON Personas
AFTER UPDATE, DELETE
AS
BEGIN
    IF UPDATE(id)
    BEGIN
        RAISERROR ('No se permite modificar el campo "id" en la tabla "Personas".', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        RAISERROR ('No se permite eliminar registros de la tabla "Personas".', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END

-- Intentar modificar la tabla Personas (Esto debería mostrar un mensaje de error)
ALTER TABLE Personas ADD telefono VARCHAR(20);


-- Intentar eliminar la tabla Personas (Esto debería mostrar un mensaje de error)
DROP TABLE Personas;

SELECT * FROM Personas;

--2.- Crea un disparador que se active ante cualquier modificación de los registros de la tabla Autos

CREATE TRIGGER TR_Autos_Modificacion
ON Autos
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Registro de la modificación en la tabla Bitacora
        INSERT INTO Bitacora (accion, fecha)
        VALUES ('Modificación de registro en la tabla Autos', GETDATE());

        -- Actualización de la columna fecha_actualizacion en la tabla Personas
        UPDATE Personas
        SET fecha_actualizacion = GETDATE()
        WHERE id IN (SELECT DISTINCT id FROM Autos WHERE EXISTS (SELECT * FROM inserted WHERE Autos.id = inserted.id));

    END
END

INSERT INTO Autos (matricula, marca, color, poliza, tipo_auto, capacidad, fecha_ingreso, fecha_actualizacion, estatus)
VALUES

('HJOI22', 'Toyota', 'Azul', 'PI911', 'Sedán, SUV, Camioneta', '5', GETDATE(), CONVERT(DATETIME, '2023-01-15', 120), '1');

Select * from Bitacora 

--3 impide que se ejecuten sentencias DROP TABLE y ALTER TABLE en la base de datos.
CREATE TRIGGER TR_SEGURIDAD
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    RAISERROR ('No está permitido borrar ni modificar tablas!', 16, 1);
    ROLLBACK;
END;
__
-- Intentar eliminar la tabla Autos (Esto debería mostrar un mensaje de error)
DROP TABLE Autos;


--4 crear un trigger para saber que usuario agrego registros en sql


CREATE TABLE Auditoria (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Tabla NVARCHAR(100),
    Accion NVARCHAR(100),
    Usuario NVARCHAR(100),
    FechaAudit DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_InsertAudit
ON Personas
AFTER INSERT
AS
BEGIN
    DECLARE @UserName NVARCHAR(100);
    SET @UserName = SYSTEM_USER;

    INSERT INTO Auditoria (Tabla, Accion, Usuario)
    VALUES ('Personas', 'Inserción', @UserName);
END;
