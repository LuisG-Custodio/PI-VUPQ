--Procedimienos almacenados 
--1.-Realiza un procedimiento Almacenado que permita agregar de uno en uno un nuevo registro en una tabla  en Personas

CREATE PROCEDURE AgregarPersona
    @matricula INT,
    @nombre VARCHAR(200),
    @ap VARCHAR(200),
    @am VARCHAR(200),
    @telefono VARCHAR(10),
    @contraseña VARCHAR(200),
    @fecha_ingreso DATE,
    @fecha_actualizacion DATETIME,
    @estatus BIT,
    @id_genero INT,
    @id_rol INT
AS
BEGIN
    INSERT INTO Personas (matricula, nombre, ap, am, telefono, contraseña, fecha_ingreso, fecha_actualizacion, estatus, id_genero, id_rol)
    VALUES (@matricula, @nombre, @ap, @am, @telefono, @contraseña, @fecha_ingreso, @fecha_actualizacion, @estatus, @id_genero, @id_rol)
END
---Auí se hace el proc
EXEC AgregarPersona
    @matricula = 12345,
    @nombre = 'John',
    @ap = 'Doe',
    @am = 'Smith',
    @telefono = '5551234',
    @contraseña = 'secreto',
    @fecha_ingreso = '2023-07-12',
    @fecha_actualizacion = '2023-07-12',
	@estatus = 1,
    @id_genero = 1,
    @id_rol = 1;


---2.- Modificar el procedimiento Almacenado anterior para que agregue un registro a la bitatacora, cada que se agruege un 
--nuevo registro a la tabla Personas 
CREATE TABLE Bitacora (
    id INT IDENTITY (1, 1) PRIMARY KEY,
    accion VARCHAR(200),
    fecha DATETIME
);



CREATE PROCEDURE AgregarPersona1
    @matricula INT,
    @nombre VARCHAR(200),
    @ap VARCHAR(200),
    @am VARCHAR(200),
    @telefono VARCHAR(10),
    @contraseña VARCHAR(200),
    @fecha_ingreso DATE,
    @fecha_actualizacion DATETIME,
    @estatus BIT,
    @id_genero INT,
    @id_rol INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        INSERT INTO Personas (matricula, nombre, ap, am, telefono, contraseña, fecha_ingreso, fecha_actualizacion, estatus, id_genero, id_rol)
        VALUES (@matricula, @nombre, @ap, @am, @telefono, @contraseña, @fecha_ingreso, @fecha_actualizacion, @estatus, @id_genero, @id_rol);
        
        INSERT INTO Bitacora (accion, fecha)
        VALUES ('Se agregó un nuevo registro en la tabla Personas', GETDATE());
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        -- Manejo del error, puedes agregar el código necesario aquí
    END CATCH
END;

EXEC AgregarPersona1
    @matricula = 1221,
    @nombre = 'Javier',
    @ap = 'Herrera',
    @am = 'Chavez',
    @telefono = '5552234',
    @contraseña = '123',
    @fecha_ingreso = '2023-07-12',
    @fecha_actualizacion = '2023-07-12',
	@estatus = 1,
    @id_genero = 1,
    @id_rol = 1;

--3.- Realizar un procedimiento Almacenado que permita consultar personas

CREATE PROCEDURE ConsultarPersonas
    @nombre VARCHAR(200)
AS
BEGIN
    SELECT id, matricula, nombre, ap, am, telefono, contraseña, fecha_ingreso, fecha_actualizacion, estatus, id_genero, id_rol
    FROM Personas
    WHERE nombre LIKE '%' + @nombre + '%'
END
---Aquí jala el proc
EXEC ConsultarPersonas
    @nombre = 'John'


---4.-Prodecimiento para actualizar la contraseña
CREATE PROCEDURE ActualizarContraseña
    @id INT,
    @nuevaContraseña VARCHAR(200)
AS
BEGIN
    UPDATE Personas
    SET contraseña = @nuevaContraseña,
        fecha_actualizacion = GETDATE()
    WHERE id = @id
END


EXEC ActualizarContraseña
    @id = 1,
    @nuevaContraseña = 'nueva123'

