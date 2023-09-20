go
create procedure sp_insertar_medicos
@nombre varchar(50),
@ap varchar(50),
@am varchar(50),
@telefono varchar(10),
@correo varchar(50),
@RFC varchar(13),
@cedula varchar(10),
@contraseña varchar(50),
@id_rol int,
@id_departamento int,
@consultorio varchar(10)
as
insert into Personas(nombre,ap,am,telefono,correo)
values
(@nombre,@ap,@am,@telefono,@correo)

declare @id_persona int
set @id_persona=(select id from Personas where nombre=@nombre and ap=@ap and am=@am and telefono=@telefono and correo=@correo)

insert into Medicos(id_persona,RFC,cedula,contraseña,id_rol,id_departamento,consultorio)
values
(@id_persona,@RFC,@cedula,HASHBYTES('MD4',@contraseña),@id_rol,@id_departamento,@consultorio)

go
create procedure sp_insertar_paciente

@nombre varchar(50),
@ap varchar(50),
@am varchar(50),
@telefono varchar(10),
@correo varchar(50),
@id_medico int,
@nacimiento date,
@id_sexo int,
@enfermedades text,
@alergias text,
@antecedentes text

as

insert into Personas(nombre,ap,am,telefono,correo)

values
(@nombre,@ap,@am,@telefono,@correo)

declare @id_persona int
set @id_persona=(select id from Personas where nombre=@nombre and ap=@ap and am=@am and telefono=@telefono and correo=@correo)

insert into Pacientes(id_persona,id_medico,nacimiento,id_sexo,enfermedades,alergias,antecedentes)
values
(@id_persona,@id_medico,@nacimiento,@id_sexo,@enfermedades,@alergias,@antecedentes)
go
create procedure sp_insertar_consulta
@id_paciente int,
@peso decimal(5,2),
@altura int,
@temperatura decimal(3,2),
@ritmo_cardiaco int,
@presion varchar(10),
@saturacion_oxigeno decimal(5,2),
@glucosa decimal(6,2),
@sintomatologia text,
@diagnostico text,
@receta text,
@examenes text
as
insert into Consultas(id_paciente,fecha,peso,altura,temperatura,ritmo_cardiaco,presion,saturacion_oxigeno,glucosa,sintomatologia,diagnostico,receta,examenes)
values
(@id_paciente,GETDATE(),@peso,@altura,@temperatura,@ritmo_cardiaco,@presion,@saturacion_oxigeno,@glucosa,@sintomatologia,@diagnostico,@receta,@examenes)
go
create procedure sp_eliminar_medico
@id_medico int
as
update Medicos set visibilidad=0 where id=@id_medico
go
create procedure sp_editar_medico
@id_persona int,
@nombre varchar(50),
@ap varchar(50),
@am varchar(50),
@telefono varchar(10),
@correo varchar(50),
@RFC varchar(13),
@cedula varchar(10),
@id_rol int,
@id_departamento int,
@consultorio varchar(10)
as
update Personas set nombre=@nombre,ap=@ap,am=@am,telefono=@telefono,correo=@correo where id=@id_persona
update Medicos set RFC=@RFC, cedula=@cedula,id_rol=@id_rol,id_departamento=@id_departamento,consultorio=@consultorio where id_persona=@id_persona
go
create procedure sp_editar_paciente
@id_persona int,
@nombre varchar(50),
@ap varchar(50),
@am varchar(50),
@telefono varchar(10),
@correo varchar(50),
@nacimiento date,
@id_sexo int,
@enfermedades text,
@alergias text,
@antecedentes text
as
update Personas set nombre=@nombre,ap=@ap,am=@am,telefono=@telefono,correo=@correo where id=@id_persona
update Pacientes set nacimiento=@nacimiento,id_sexo=@id_sexo,enfermedades=@enfermedades,alergias=@alergias,antecedentes=@antecedentes where id_persona=@id_persona
