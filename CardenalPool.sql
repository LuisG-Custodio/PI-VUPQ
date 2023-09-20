create database CARDENALPOOL;
use CARDENALPOOL;
create table Roles(
id int not null primary key auto_increment,
nombre varchar(200)
);
insert into  Roles (nombre)
values
('Pasajero'),
('Conductor');

create table Generos(
id int not null primary key auto_increment,
nombre varchar(200)
);

insert into Generos (nombre)
values
('Mujer'),
('Hombre');

create table Requisitos(
id int not null primary key auto_increment,
descripcion varchar(200)
);
insert into Requisitos (descripcion)
values
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
('Flexibilidad en horarios');


create table Incidentes(
id int not null primary key auto_increment,
nombre varchar(200)
);

insert into Incidentes (nombre)
values
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
('Neumático reventado y pérdida de control del vehículo.');

create table Rutas(
id int not null primary key auto_increment,
nombre varchar(200),
descripcion varchar(200)
);

insert into Rutas (nombre, descripcion)
values
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
('Ezequiel Mondes - UPQ', 'Ruta que te lleva desde el municipio de Ezequiel Montes hacia la UPQ.');


create table Paradas(
id int not null primary key auto_increment,
nombre varchar(200),
distancia int
);

insert into Paradas (nombre, distancia)
values
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
('Plaza Principal de Ezequiel Montes', '30');

create table Tipos_autos(
id int not null primary key auto_increment,
nombre varchar(200),
capacidad int,
rendimiento decimal(5,2)
);
insert into Tipos_autos(nombre,capacidad,rendimiento)
values
('Hatchback',4,14),
('Sedan',4,13),
('Crossover',4,12.5),
('Camioneta',6,11.5),
('Minivan',6,10.5),
('Van',7,10),
('Pick-up',3,13.5);

create table Autos(
id int not null primary key auto_increment,
matricula varchar(200),
modelo varchar(200),
marca varchar(200),
color varchar(200),
poliza varchar(200),
lugares_disponibles int,
fecha_ingreso date,
fecha_actualizacion datetime,
estatus boolean,
id_tipo_auto int not null,
foreign key (id_tipo_auto) references Tipos_autos(id) on delete cascade on update cascade
);

insert into Autos (matricula, modelo, marca, color, poliza, id_tipo_auto, lugares_disponibles, fecha_ingreso, estatus)
values
('ABC123', 'Yaris', 'Toyota', 'Rojo', 'A1B2C3D4', 2, 4, CURRENT_TIMESTAMP, '1'),
('XYZ789', 'Fiesta', 'Ford', 'Azul', 'E5F6G7H8', 2, 4, CURRENT_TIMESTAMP, '1'),
('DEF456', 'Onix', 'Chevrolet', 'Negro', 'I9J0K1L2', 2, 4, CURRENT_TIMESTAMP, '1'),
('GHI987', 'Civic', 'Honda', 'Plata', 'M3N4O5P6', 2, 4, CURRENT_TIMESTAMP, '1'),
('JKL321', 'Jetta', 'Volkswagen', 'Blanco', 'Q7R8S9T0', 2, 4, CURRENT_TIMESTAMP, '1'),
('MNO654', 'Clase C', 'Mercedes-Benz', 'Gris', 'U1V2W3X4', 2, 4, CURRENT_TIMESTAMP, '1'),
('PQR876', 'Versa', 'Nissan', 'Azul Marino', 'U1V2W3X4', 2, 4, CURRENT_TIMESTAMP, '1'),
('STU543', 'Elantra', 'Hyundai', 'Rojo Oscuro', 'C9D0E1F2', 2, 4, CURRENT_TIMESTAMP, '1'),
('VWX210', 'Forte', 'Kia', 'Plateado', 'C9D0E1F2', 2, 4, CURRENT_TIMESTAMP, '1'),
('YZA789', 'Patriot', 'Jeep', 'Verde', 'C9D0E1F2', 4, 6, CURRENT_TIMESTAMP, '1'),
('BCD456', 'Forester', 'Subaru', 'Naranja', 'P1Q2R3S4', 4, 6, CURRENT_TIMESTAMP, '1'),
('EFG987', 'Mazda2', 'Mazda', 'Gris Oscuro', 'T5U6V7W8', 1, 4, CURRENT_TIMESTAMP, '1'),
('HIJ321', 'Highlander', 'Toyota', 'Blanco Perla', 'X9Y0Z1A2', 4, 6, CURRENT_TIMESTAMP, '1'),
('KLM654', 'CR-V', 'Honda', 'Negro Mate', 'B3C4D5E6', 3, 4, CURRENT_TIMESTAMP, '1'),
('NOP876', 'Tiguan', 'Volkswagen', 'Plata Metálico', 'F7G8H9I0', 4, 6, CURRENT_TIMESTAMP, '1');



create table Personas(
id int not null primary key auto_increment,
matricula int,
nombre varchar(200),
ap varchar(200),
am varchar(200),
telefono varchar(20),
contraseña varchar(200),
fecha_ingreso date,
fecha_actualizacion datetime,
estatus boolean,
id_genero int not null,
foreign key (id_genero) references  Generos(id) on delete cascade on update cascade,
id_rol int not null,
foreign key (id_rol) references  Roles(id) on delete cascade on update cascade
);
INSERT INTO Personas (matricula, nombre, ap, am, telefono, contraseña, fecha_ingreso, estatus, id_genero, id_rol)
VALUES
('121045812', 'Luis', 'Garcia', 'Rodriguez', '55 1234 5678', '4T7y9P2q5R6w', CURRENT_TIMESTAMP, '1', 2, 1),
('121057193', 'Maria', 'Lopez', 'Martinez', '81 9876 5432', '3G6h8E1b4D9s', CURRENT_TIMESTAMP, '1', 1, 1),
('121060274', 'Carlos', 'Gonzalez', 'Hernandez', '33 2468 1357', '2J5k7L3m6N1v', CURRENT_TIMESTAMP, '1', 2, 2),
('121073455', 'Ana', 'Medina', 'Delgado', '664 987 6543', '9C2x4Z8v7B1n', CURRENT_TIMESTAMP, '1', 1, 1),
('121085636', 'Juan Carlos', 'Mendoza', 'Ortega', '686 543 2109', '6R9t3Y2h5N8s', CURRENT_TIMESTAMP, '1', 2, 2),
('121091817', 'Laura Andrea', 'Rivas', 'Espinoza', '998 765 4321', '5X8s2F4d7G3h', CURRENT_TIMESTAMP, '1', 1, 2),
('121102998', 'Pedro', 'Torres', 'Cruz', '444 321 0987', '1V3b6N4m9K7l',CURRENT_TIMESTAMP, '1', 2, 1),
('121116179', 'Isabel', 'Romero', 'Rios', '477 654 3210', '7M5n1B8v2C4x', CURRENT_TIMESTAMP, '1', 1, 1),
('121122350', 'Miguel Angel', 'Silva', 'Mendoza', '662 109 8765', '8T1y9P3q5R6w', CURRENT_TIMESTAMP, '1', 2, 1),
('121139531', 'Sofia', 'Jimenez', 'Navarro', '222 543 2109', '3S6d8H1f4G9j', CURRENT_TIMESTAMP, '1', 1, 1),
('121142712', 'Diego Adrian', 'Morales', 'Castro', '618 876 5432', '2L5k7M3n6B1v',CURRENT_TIMESTAMP, '1', 2, 2),
('121157893', 'Valentina', 'Vargas', 'Flores', '322 109 8765', '9X2c4Z8v7B1n', CURRENT_TIMESTAMP, '1', 1, 2),
('121169074', 'Jose Maria', 'Gonzalez', 'Flores', '744 543 2109', '6R9t3Y2h5N8s', CURRENT_TIMESTAMP, '1', 2, 1),
('121178255', 'Camila', 'Castillo', 'Blanco', '999 876 5432', '5Q8s2P4w7O3k', CURRENT_TIMESTAMP, '1', 1, 1),
('121036985', 'Omar', 'Figueroa', 'Salazar', '449 321 0987', '1I3u6B4y9T7r', CURRENT_TIMESTAMP, '1', 2, 2),
('121184436', 'Elena', 'Hernandez', 'Gomez', '555 987 6543', '4R7v9Y2u5I6o', CURRENT_TIMESTAMP, '1', 1, 2),
('121193617', 'Francisco', 'Vega', 'Santos', '999 123 4567', '3A6s8D1f4G9h', CURRENT_TIMESTAMP, '1', 2, 2),
('121202798', 'Paulina', 'Jimenez', 'Ramirez', '222 987 6543', '2W5e7R3t6Y1u', CURRENT_TIMESTAMP, 1, 1, 2),
('121215979', 'Roberto', 'Lara', 'Perez', '444 765 4321', '9I2u4B8y7T1r', CURRENT_TIMESTAMP, '1', 2, 2),
('121225160', 'Cristina', 'Mendoza', 'Hernandez', '666 543 2109', '6R9t3Y2h5N8s',CURRENT_TIMESTAMP, '1', 1, 2),
('121238341', 'Alejandro', 'Castillo', 'Rios', '333 109 8765', '3X6z8A1s4Q9w', CURRENT_TIMESTAMP, '1', 2, 2),
('121247522', 'Daniela', 'Gutierrez', 'Fuentes', '777 876 5432', '2L5k7M3n6B1v', CURRENT_TIMESTAMP, '1', 1, 2),
('121256703', 'Arturo', 'Hernandez', 'Vargas', '999 543 2109', '9X2c4Z8v7B1n', CURRENT_TIMESTAMP, '1', 2, 2),
('121265884', 'Mariana', 'Gomez', 'Torres', '888 109 8765', '8A1s3Z6x9C2v', CURRENT_TIMESTAMP, '1', 1, 2),
('121123467', 'Alejandra', 'Ramirez', 'Santos', '333 222 1111', '1A2B3C4D',CURRENT_TIMESTAMP, '1', 2, 1),
('121234578', 'Ricardo', 'Hernandez', 'Garcia', '555 444 3333', '5F4E3D2C1B', CURRENT_TIMESTAMP, '1', 1, 1),
('121345689', 'Isabella', 'Lopez', 'Mendoza', '777 666 5555', '9K8J7H6G5F', CURRENT_TIMESTAMP, '1', 2, 1),
('121456790', 'Daniel', 'Gonzalez', 'Silva', '999 888 7777', '3Q2W1E4R5T', CURRENT_TIMESTAMP, '1', 1, 1),
('121567801', 'Fernanda', 'Martinez', 'Rios', '222 111 0000', '6Y5U4I3O2P', CURRENT_TIMESTAMP, '1', 2, 1),
('121678912', 'Santiago', 'Mendoza', 'Torres', '444 333 2222', '8R7T6Y5U4I', CURRENT_TIMESTAMP, '1', 1, 1);

create table Pasajeros(
id int not null primary key auto_increment,
id_persona int not null,
foreign key (id_persona) references  Personas(id) on delete cascade on update cascade
);

insert into Pasajeros (id_persona)
values
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
(15);


create table Conductores(
id int not null primary key auto_increment,
id_persona int not null,
foreign key (id_persona) references  Personas(id) on delete cascade on update cascade,
id_auto int not null,
foreign key (id_auto) references  Autos(id) on delete cascade on update cascade
);

insert into Conductores (id_persona, id_auto)
values
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
(24, 15);


create table Viajes_globales(
id int not null primary key auto_increment,
fecha_ingreso date,
fecha_actualizacion datetime,
id_ruta int not null,
foreign key (id_ruta) references  Rutas(id),
id_conductor int not null,
foreign key (id_conductor) references Conductores(id) on delete cascade on update cascade,
id_requisitos int not null,
foreign key (id_requisitos) references Requisitos(id) on delete cascade on update cascade,
id_incidente int not null,
foreign key (id_incidente) references Incidentes(id) on delete cascade on update cascade,
estado boolean default 0
);

create table Viajes(
id int not null primary key auto_increment,
id_viaje_global int not null,
foreign key (id_viaje_global) references Viajes_globales(id) on delete cascade on update cascade,
id_pasajero int not null,
foreign key (id_pasajero) references Pasajeros(id) on delete cascade on update cascade,
id_parada int,
foreign key(id_parada) references Paradas(id) on delete cascade on update cascade,
fecha_ingreso date,
fecha_actualizacion datetime
);

-- PROCEDIMIENTO CREAR UN NUEVO VIAJE --
DELIMITER //

create procedure sp_crear_viaje (
  in conductor int,
  in ruta int
)
begin
  insert into Viajes_globales (id_ruta, id_conductor, fecha_ingreso)
  values(ruta, conductor, now());
end //

DELIMITER ;
/* Para ejecutarlo y Notas
DELIMITER-- Es utilizado para cambiar temporalmente el delimitador predeterminado que se utiliza para definir sentencias
NOW()--En Mysql es para obtener la fecha y hora actualmente
call sp_crear_viaje(conductor_value, ruta_value);
Ejemplo
call sp_crear_viaje(1, 2);
*/

DELIMITER //
-- PROCEDIMIENTO Para reservar un viaje especifico en una parada determinada 
create procedure sp_reserva_viaje (
  in viaje int,
  in pasajero int,
  in parada int
)
begin
  insert into Viajes (id_viaje_global, id_pasajero, id_parada, fecha_ingreso)
  values (viaje, pasajero, parada, now());
end //

DELIMITER ;

/*PROCEDIMIENTO para mantener actualizados el numero de lugares dispinibles en un automovil*/

DELIMITER //

create procedure sp_restablecer_lugares (
  in id_auto int
)
begin
  declare capacidad int;
  
  select Tipos_autos.capacidad into capacidad
  from Autos
  inner join Tipos_autos on Tipos_autos.id = Autos.id_tipo_auto
  where Autos.id = id_auto;

  update Autos set lugares_disponibles = capacidad where id = id_auto;
  
end //

DELIMITER ;









