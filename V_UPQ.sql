Create database V_UPQ
use V_UPQ

create table Roles(
id int identity(1,1),
nombre varchar(200),
primary key(id)
)

INSERT INTO Roles (nombre)
VALUES
('Pasajero'),
('Conductor')


create table Generos(
id int identity(1,1),
nombre varchar(200),
primary key(id)
)

INSERT INTO Generos (nombre)
VALUES
('Mujer'),
('Hombre')

create table Requisitos(
id int identity(1,1),
descripcion varchar(200),
primary key(id)
)

INSERT INTO Requisitos (descripcion)
VALUES
('Ninguno'),
('Vehículo limpio y en buen estado'),
('Conductor amable y cortés'),
('Conocimiento de rutas y destinos'),
('Buena habilidad de manejo'),
('Respeto a las normas de tránsito'),
('Buena comunicación'),
('Puntualidad'),
('Conductor experimentado'),
('Confort durante el viaje'),
('Seguridad en el trayecto'),
('Conocimiento básico de primeros auxilios'),
('Conductor responsable'),
('Disponibilidad de música o entretenimiento a bordo'),
('Conocimiento de lugares de interés turístico'),
('Flexibilidad en horarios')

create table Tipos_Pagos(
id int identity(1,1),
tipo varchar(200),
primary key(id)
)

INSERT INTO Tipos_Pagos (tipo)
VALUES
('Tarjeta'),
('Transferencia'),
('Efectivo')

create table Incidentes(
id int identity(1,1),
nombre varchar(200),
primary key(id)
)

INSERT INTO Incidentes (nombre)
VALUES
('Ninguno'),
('Colisión frontal con otro vehículo.'),
('Accidente por exceso de velocidad.'),
('Choque lateral en una intersección.'),
('Deslizamiento en una curva y salida de la carretera.'),
('Choque trasero por falta de distancia de seguimiento.'),
('Accidente por conducir distraído (uso de teléfono móvil).'),
('Daño causado por un objeto caído en la carretera.'),
('Choque con un animal en la vía.'),
('Vehículo vandalizado (rayones, rotura de ventanas, etc.).'),
('Vehículo vandalizado (rayones, rotura de ventanas, etc.).'),
('Robo del automóvil.'),
('Daño causado por inundación o tormenta.'),
('Accidente por conducir bajo los efectos del alcohol.'),
('Aparcamiento incorrecto y daño a otros vehículos.'),
('Neumático reventado y pérdida de control del vehículo.')

create table Rutas(
id int identity(1,1),
nombre varchar(200),
descripcion varchar(200),
primary key(id)
)

INSERT INTO Rutas (nombre, descripcion)
VALUES
('Ruta Libre','Ruta acordada entre el usuario y el pasajero'),
('UPQ - Santiago de Querétaro', 'Ruta que conecta la UPQ con el centro de Santiago de Querétaro, pasando por avenidas principales y calles céntricas.'),
('UPQ - Huimilpan', 'Ruta escénica que te lleva desde la UPQ hacia el municipio de Huimilpan.'),
('UPQ - Pedro Escobedo', 'Ruta que te lleva desde la UPQ hacia el municipio de Pedro Escobedo, pasando por carreteras panorámicas y zonas de cultivos agrícolas.'),
('UPQ - El Marqués', 'Ruta que conecta la UPQ con el municipio de El Marqués, pasando por vialidades modernas y zonas industriales.'),
('UPQ - Corregidora', 'Ruta que te lleva desde la UPQ hacia el municipio de Corregidora, pasando por avenidas comerciales y áreas residenciales.'),
('UPQ - San Juan del Río', 'Ruta de larga distancia que conecta la UPQ con la ciudad de San Juan del Río, pasando por la autopista principal y ofreciendo vistas panorámicas.'),
('UPQ - Tequisquiapan', 'Ruta turística que te lleva desde la UPQ hacia la pintoresca ciudad de Tequisquiapan.'),
('UPQ - Ezequiel Montes', 'Ruta que te lleva desde la UPQ hacia el municipio de Ezequiel Montes, atravesando caminos rurales y hermosos paisajes naturales.'),
('UPQ - Colón', 'Ruta que te lleva desde la UPQ hacia el municipio de Colón, pasando por caminos rurales y zonas de producción agropecuaria.'),
('Santiago de Querétaro - UPQ', 'Ruta que conecta el centro de Santiago de Queretaro y la UPQ, pasando por avenidas principales y calles céntricas para llegar a UPQ.'),
('Huimilpan - UPQ', 'Ruta escénica que te lleva desde el municipio de Huimilpan hacia la UPQ, atravesando paisajes rurales.'),
('El Marqués - UPQ', 'Ruta que conecta el municipio de El Marqués con la UPQ, pasando por vialidades modernas y zonas industriales.'),
('Corregidora - UPQ', 'Ruta que te lleva desde el municipio de Corregidora hacia la UPQ, pasando por avenidas comerciales y áreas residenciales.'),
('Colón - UPQ', 'Ruta que te lleva desde el municipio de Colón hacia la UPQ, pasando por caminos rurales y zonas de producción agropecuaria.'),
('Ezequiel Mondes - UPQ', 'Ruta que te lleva desde el municipio de Ezequiel Montes hacia la UPQ.')


create table Paradas(
id int identity(1,1),
nombre varchar(200),
distancia int,
primary key(id)
)

INSERT INTO Paradas (nombre, distancia)
VALUES
('Ruta Libre','1'),
('Parque Bicentenario', '5'),
('Ex-Hacienda El Cerrito', '12'),
('Puente de Milenio', '20'),
('Parque Industrial Bernardo Quintana', '15'),
('Centro Comercial Antea', '8'),
('Puente de la Historia', '60'),
('Mercado de Artesanías', '45'),
('Viñedos La Redonda', '30'),
('Zona Arqueológica El Cerrito', '25'),
('Auditorio Josefa Ortiz de Domínguez', '5'),
('Parroquia de Huimilpan', '12'),
('Parque Industrial Querétaro', '15'),
('Centro Cívico de Corregidora', '8'),
('Parroquia de Colón', '25'),
('Plaza Principal de Ezequiel Montes', '30')


create table Tipos_autos(
id int identity(1,1),
nombre varchar(200),
capacidad int,
rendimiento decimal(5,2),
primary key(id)
)

insert into Tipos_autos(nombre,capacidad,rendimiento)
values

('Hatchback',4,14),
('Sedan',4,13),
('Crossover',4,12.5),
('Camioneta',6,11.5),
('Minivan',6,10.5),
('Van',7,10),
('Pick-up',3,13.5)

create table Autos(
id int identity(1,1),
matricula varchar(200),
modelo varchar(200),
marca varchar(200),
color varchar(200),
poliza varchar(200),
id_tipo_auto int,
lugares_disponibles int,
fecha_ingreso date,
fecha_actualizacion datetime,
estatus bit,
primary key(id),
foreign key(id_tipo_auto) references Tipos_autos(id)
)

INSERT INTO Autos (matricula, modelo, marca, color, poliza, id_tipo_auto, lugares_disponibles, fecha_ingreso, estatus)
VALUES

('ABC123', 'Yaris', 'Toyota', 'Rojo', 'A1B2C3D4', 2, 4, GETDATE(), '1'),
('XYZ789', 'Fiesta', 'Ford', 'Azul', 'E5F6G7H8', 2, 4, GETDATE(), '1'),
('DEF456', 'Onix', 'Chevrolet', 'Negro', 'I9J0K1L2', 2, 4, GETDATE(), '1'),
('GHI987', 'Civic', 'Honda', 'Plata', 'M3N4O5P6', 2, 4, GETDATE(), '1'),
('JKL321', 'Jetta', 'Volkswagen', 'Blanco', 'Q7R8S9T0', 2, 4, GETDATE(), '1'),
('MNO654', 'Clase C', 'Mercedes-Benz', 'Gris', 'U1V2W3X4', 2, 4, GETDATE(), '1'),
('PQR876', 'Versa', 'Nissan', 'Azul Marino', 'U1V2W3X4', 2, 4, GETDATE(), '1'),
('STU543', 'Elantra', 'Hyundai', 'Rojo Oscuro', 'C9D0E1F2', 2, 4, GETDATE(), '1'),
('VWX210', 'Forte', 'Kia', 'Plateado', 'C9D0E1F2', 2, 4, GETDATE(), '1'),
('YZA789', 'Patriot', 'Jeep', 'Verde', 'C9D0E1F2', 4, 6, GETDATE(), '1'),
('BCD456', 'Forester', 'Subaru', 'Naranja', 'P1Q2R3S4', 4, 6, GETDATE(), '1'),
('EFG987', 'Mazda2', 'Mazda', 'Gris Oscuro', 'T5U6V7W8', 1, 4, GETDATE(), '1'),
('HIJ321', 'Highlander', 'Toyota', 'Blanco Perla', 'X9Y0Z1A2', 4, 6, GETDATE(), '1'),
('KLM654', 'CR-V', 'Honda', 'Negro Mate', 'B3C4D5E6', 3, 4, GETDATE(), '1'),
('NOP876', 'Tiguan', 'Volkswagen', 'Plata Metalico', 'F7G8H9I0', 4, 6, GETDATE(), '1');

create table Personas(
id int identity (1,1),
matricula int,
nombre varchar(200),
ap varchar(200),
am varchar(200),
telefono varchar(20),
contraseña varchar(200),
fecha_ingreso date,
fecha_actualizacion datetime,
estatus bit,
id_genero int,
foreign key(id_genero) references Generos(id),
id_rol int,
foreign key(id_rol) references Roles(id),
primary key(id)
)

INSERT INTO Personas (matricula, nombre, ap, am, telefono, contraseña, fecha_ingreso, estatus, id_genero, id_rol)
VALUES
('121045812', 'Luis', 'Garcia', 'Rodriguez', '55 1234 5678', '4T7y9P2q5R6w', GETDATE(), '1', 2, 1),
('121057193', 'Maria', 'Lopez', 'Martinez', '81 9876 5432', '3G6h8E1b4D9s', GETDATE(), '1', 1, 1),
('121060274', 'Carlos', 'Gonzalez', 'Hernandez', '33 2468 1357', '2J5k7L3m6N1v', GETDATE(), '1', 2, 2),
('121073455', 'Ana', 'Medina', 'Delgado', '664 987 6543', '9C2x4Z8v7B1n', GETDATE(), '1', 1, 1),
('121085636', 'Juan Carlos', 'Mendoza', 'Ortega', '686 543 2109', '6R9t3Y2h5N8s', GETDATE(), '1', 2, 2),
('121091817', 'Laura Andrea', 'Rivas', 'Espinoza', '998 765 4321', '5X8s2F4d7G3h', GETDATE(), '1', 1, 2),
('121102998', 'Pedro', 'Torres', 'Cruz', '444 321 0987', '1V3b6N4m9K7l', GETDATE(), '1', 2, 1),
('121116179', 'Isabel', 'Romero', 'Rios', '477 654 3210', '7M5n1B8v2C4x', GETDATE(), '1', 1, 1),
('121122350', 'Miguel Angel', 'Silva', 'Mendoza', '662 109 8765', '8T1y9P3q5R6w', GETDATE(), '1', 2, 1),
('121139531', 'Sofia', 'Jimenez', 'Navarro', '222 543 2109', '3S6d8H1f4G9j', GETDATE(), '1', 1, 1),
('121142712', 'Diego Adrian', 'Morales', 'Castro', '618 876 5432', '2L5k7M3n6B1v', GETDATE(), '1', 2, 2),
('121157893', 'Valentina', 'Vargas', 'Flores', '322 109 8765', '9X2c4Z8v7B1n', GETDATE(), '1', 1, 2),
('121169074', 'Jose Maria', 'Gonzalez', 'Flores', '744 543 2109', '6R9t3Y2h5N8s', GETDATE(), '1', 2, 1),
('121178255', 'Camila', 'Castillo', 'Blanco', '999 876 5432', '5Q8s2P4w7O3k', GETDATE(), '1', 1, 1),
('121036985', 'Omar', 'Figueroa', 'Salazar', '449 321 0987', '1I3u6B4y9T7r', GETDATE(), '1', 2, 2),
('121184436', 'Elena', 'Hernandez', 'Gomez', '555 987 6543', '4R7v9Y2u5I6o', GETDATE(), '1', 1, 2),
('121193617', 'Francisco', 'Vega', 'Santos', '999 123 4567', '3A6s8D1f4G9h', GETDATE(), '1', 2, 2),
('121202798', 'Paulina', 'Jimenez', 'Ramirez', '222 987 6543', '2W5e7R3t6Y1u', GETDATE(), 1, 1, 2),
('121215979', 'Roberto', 'Lara', 'Perez', '444 765 4321', '9I2u4B8y7T1r', GETDATE(), '1', 2, 2),
('121225160', 'Cristina', 'Mendoza', 'Hernandez', '666 543 2109', '6R9t3Y2h5N8s', GETDATE(), '1', 1, 2),
('121238341', 'Alejandro', 'Castillo', 'Rios', '333 109 8765', '3X6z8A1s4Q9w', GETDATE(), '1', 2, 2),
('121247522', 'Daniela', 'Gutierrez', 'Fuentes', '777 876 5432', '2L5k7M3n6B1v', GETDATE(), '1', 1, 2),
('121256703', 'Arturo', 'Hernandez', 'Vargas', '999 543 2109', '9X2c4Z8v7B1n', GETDATE(), '1', 2, 2),
('121265884', 'Mariana', 'Gomez', 'Torres', '888 109 8765', '8A1s3Z6x9C2v', GETDATE(), '1', 1, 2),
('121123467', 'Alejandra', 'Ramirez', 'Santos', '333 222 1111', '1A2B3C4D', GETDATE(), '1', 2, 1),
('121234578', 'Ricardo', 'Hernandez', 'Garcia', '555 444 3333', '5F4E3D2C1B', GETDATE(), '1', 1, 1),
('121345689', 'Isabella', 'Lopez', 'Mendoza', '777 666 5555', '9K8J7H6G5F', GETDATE(), '1', 2, 1),
('121456790', 'Daniel', 'Gonzalez', 'Silva', '999 888 7777', '3Q2W1E4R5T', GETDATE(), '1', 1, 1),
('121567801', 'Fernanda', 'Martinez', 'Rios', '222 111 0000', '6Y5U4I3O2P', GETDATE(), '1', 2, 1),
('121678912', 'Santiago', 'Mendoza', 'Torres', '444 333 2222', '8R7T6Y5U4I', GETDATE(), '1', 1, 1)

create table Pasajeros(
id int identity(1,1),
id_persona int,
foreign key(id_persona)references Personas(id),
primary key(id)
)

INSERT INTO Pasajeros (id_persona)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15)


create table Conductores(
id int identity(1,1),
id_persona int,
foreign key(id_persona) references Personas(id),
id_auto int,
foreign key(id_auto) references Autos(id),
primary key(id)
)

INSERT INTO Conductores (id_persona, id_auto)
VALUES
(3, 1),
(5, 2),
(6, 3),
(11, 4),
(12, 5),
(15, 6),
(16, 7),
(17, 8),
(18, 9),
(19, 10),
(20, 11),
(21, 12),
(22, 13),
(23, 14),
(24, 15)

create table Viajes_globales(
id int identity(1,1),
fecha_ingreso date,
fecha_actualizacion datetime,
id_ruta int,
foreign key(id_ruta) references Rutas(id),
id_conductor int,
foreign key(id_conductor) references Conductores(id),
id_requisitos int default(1),
foreign key(id_requisitos) references Requisitos(id),
id_incidente int default(1),
foreign key(id_incidente) references Incidentes(id),
estado bit default 0,
primary key(id)
)
create table Viajes(
id int identity(1,1),
id_viaje_global int,
foreign key(id_viaje_global) references Viajes_globales(id),
id_pasajero int,
foreign key(id_pasajero) references Pasajeros(id),
id_parada int,
foreign key(id_parada) references Paradas(id),
fecha_ingreso date,
fecha_actualizacion datetime,
primary key(id)
)
create table Pagos(
id int identity(1,1),
id_viaje int,
foreign key(id_viaje) references Viajes(id),
fecha date,
monto varchar(200),
id_tipo_pago int,
foreign key(id_tipo_pago) references Tipos_Pagos(id),
fecha_ingreso date,
fecha_actualizacion date,
estatus bit,
primary key(id)
)

go
create trigger tr_validacion_pago
on Pagos
after update
as
begin
if((select id_tipo_pago from inserted) is not null)
begin
if((select fecha_ingreso from inserted) is null)
begin
update Pagos set fecha_ingreso=GETDATE() where id=(select id from inserted)
end
end
end


update Pagos set id_tipo_pago=3 where id=1
select * from Pagos

go
create function fn_viajes_por_persona
(@id_persona int)
returns table
as
return
(select Personas.nombre+' '+Personas.ap+' '+Personas.am as Nombre_Pasajero,
count(Viajes.id) as Viajes_pasajero
from Personas
inner join Pasajeros on Pasajeros.id_persona=Personas.id
inner join Viajes on Viajes.id_pasajero=Pasajeros.id
where Personas.id=@id_persona
group by Personas.nombre,Personas.ap,Personas.am)

go
create function fn_viajes_por_conductor
(@id_persona int)
returns table
as
return
(select Personas.nombre+' '+Personas.ap+' '+Personas.am as Nombre_Pasajero,
count(Viajes_globales.id) as Viajes_Conductor
from Personas
inner join Conductores on Conductores.id_persona=Personas.id
inner join Viajes_globales on Viajes_globales.id_conductor=Conductores.id
where Personas.id=@id_persona
group by Personas.nombre,Personas.ap,Personas.am)

select * from fn_viajes_por_persona(1)
select * from fn_viajes_por_conductor(3)

go
create procedure sp_crear_viaje
@conductor int,
@ruta int
as
insert into Viajes_globales(id_ruta,id_conductor,fecha_ingreso) values (@ruta,@conductor,GETDATE())



go
create procedure sp_reserva_viaje
@viaje int,
@pasajero int,
@parada int
as
insert into Viajes(id_viaje_global,id_pasajero,id_parada,fecha_ingreso) values (@viaje,@pasajero,@parada,GETDATE())


go
create procedure sp_restablecer_lugares
@id_auto int
as
declare @capacidad int
set @capacidad=(select Tipos_autos.capacidad from Autos
inner join Tipos_autos on Tipos_autos.id=Autos.id_tipo_auto where Autos.id=@id_auto)
update Autos set lugares_disponibles=@capacidad where id=@id_auto

go
create function fn_calculo_monto
(@id_auto int,@distancia int,@costo_gas decimal(5,2))
returns decimal(5,2)
as
begin
declare @monto decimal(5,2),
		@capacidad int,
		@tipo_auto int
set @tipo_auto=(select id_tipo_auto from Autos where id=@id_auto)
set @monto=(select rendimiento from Tipos_autos where id=@tipo_auto)
set @capacidad=(select capacidad from Tipos_autos where id=@tipo_auto)
return ((@distancia*@costo_gas)/(@monto*@capacidad))
end

go
create procedure sp_insertar_datos_pago
@id_viaje int,@distancia int
as
begin
insert into Pagos(id_viaje,fecha,monto,estatus) values
(@id_viaje,GETDATE(),dbo.fn_calculo_monto(@id_viaje,@distancia,25.00),1)
end



go
create trigger tr_actualizar_lugares
on Viajes
after insert
as
begin
declare @lugares int,
		@id_auto int,
		@id_viaje int,
		@distancia int
set @lugares=(select Autos.lugares_disponibles from inserted
inner join Viajes_globales on Viajes_globales.id=inserted.id_viaje_global
inner join Conductores on Conductores.id=Viajes_globales.id_conductor
inner join Autos on Autos.id=Conductores.id_auto)
set @id_auto=(select Conductores.id_auto from inserted
inner join Viajes_globales on Viajes_globales.id=inserted.id_viaje_global
inner join Conductores on Conductores.id=Viajes_globales.id_conductor)
set @id_viaje=(select id from inserted)
set @distancia=(select Paradas.distancia from inserted
inner join Paradas on Paradas.id=inserted.id_parada)
if(@lugares=0)
begin
	print 'No hay lugares disponibles'
	rollback transaction
end
else
begin
	update Autos set lugares_disponibles=@lugares-1 where id=@id_auto
	exec sp_insertar_datos_pago @id_viaje,@distancia
	commit transaction
end
end


go
create function fn_parada_de_viajero(
@id_viaje int
)
returns table
as
return
(
    select Viajes.id as id,Paradas.nombre as Nombre_Parada,
			Rutas.nombre as Ruta
	from Viajes
	inner join Paradas on Paradas.id=Viajes.id_parada
	inner join Viajes_globales on Viajes_globales.id=Viajes.id_viaje_global
	inner join Rutas on Rutas.id=Viajes_globales.id_ruta
	where Viajes.id=@id_viaje
)

go
create function fn_datos_pasajero
(@id_viaje int)
returns table
as
return
(select Personas.nombre+' '+Personas.ap+' '+Personas.am as Nomber_Pasajero,
Parada.Nombre_Parada, Parada.Ruta,Viajes.fecha_ingreso as Fecga_de_Viaje
from Viajes
inner join Pasajeros on Pasajeros.id=Viajes.id_pasajero
inner join Personas on Personas.id=Pasajeros.id_persona
full join fn_parada_de_viajero(@id_viaje) as Parada on Parada.id=Viajes.id 
where Viajes.id=@id_viaje)

go 
create trigger tr_actualizar_estado
on Viajes_globales
after update
as
begin
declare @incidente int,
		@id_viaje int
set @incidente = (select id_incidente from inserted)
set @id_viaje=(select id from inserted)
if(@incidente != 1)
	begin
		update Pagos set Pagos.monto=0,Pagos.fecha_actualizacion=GETDATE() from Viajes inner join Pagos on Pagos.id_viaje=Viajes.id where Viajes.id_viaje_global=@id_viaje
		update Viajes set fecha_actualizacion=GETDATE() where id_viaje_global=@id_viaje
		print 'El viaje fue cancelado por incidente'
	end
end

exec sp_crear_viaje 1,1
exec sp_reserva_viaje 1,1,1

select * from Viajes_globales
select * from Viajes

select * from Autos
exec sp_restablecer_lugares 1
select * from Autos

select * from fn_datos_pasajero(1)

update Viajes_globales set id_incidente=2 where id=1

select * from Viajes
select * from Pagos

