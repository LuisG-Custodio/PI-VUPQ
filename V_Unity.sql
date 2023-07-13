--Create database V_Unity1
use V_Unity1

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
('Transferencia')

create table Incidentes(
id int identity(1,1),
nombre varchar(200),
primary key(id)
)

INSERT INTO Incidentes (nombre)
VALUES
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

create table Autos(
id int identity(1,1),
matricula char(10),
marca varchar(200),
color varchar(200),
poliza varchar(200),
tipo_auto varchar(200),
capacidad int,
fecha_ingreso date,
fecha_actualizacion datetime,
estatus bit,
primary key(id)
)


INSERT INTO Autos (matricula, marca, color, poliza, tipo_auto, capacidad, fecha_ingreso, fecha_actualizacion, estatus)
VALUES

('ABC123', 'Toyota', 'Rojo', 'A1B2C3D4', 'Sedán, SUV, Camioneta', '5', GETDATE(), CONVERT(DATETIME, '2023-01-15', 120), '1'),
('XYZ789', 'Ford', 'Azul', 'E5F6G7H8', 'Sedán, SUV, Camioneta', '7', GETDATE(), CONVERT(DATETIME, '2023-02-28', 120), '1'),
('DEF456', 'Chevrolet', 'Negro', 'I9J0K1L2', 'Sedán, SUV, Camioneta', '7', GETDATE(), CONVERT(DATETIME, '2023-03-10', 120), '1'),
('GHI987', 'Honda', 'Plata', 'M3N4O5P6', 'Sedán, SUV, Hatchback', '7', GETDATE(), CONVERT(DATETIME, '2023-04-05', 120), '1'),
('JKL321', 'Volkswagen', 'Blanco', 'Q7R8S9T0', 'Sedán, SUV, Hatchback', '7', GETDATE(), CONVERT(DATETIME, '2023-05-22', 120), '1'),
('MNO654', 'Mercedes-Benz', 'Gris', 'U1V2W3X4', 'Sedán, SUV, Coupé', '5', GETDATE(), CONVERT(DATETIME, '2023-06-11', 120), '1'),
('PQR876', 'Nissan', 'Azul Marino', 'U1V2W3X4', 'Sedán, SUV, Camioneta', '5', GETDATE(), CONVERT(DATETIME, '2023-07-19', 120), '1'),
('STU543', 'Hyundai', 'Rojo Oscuro', 'C9D0E1F2', 'Sedán, SUV, Hatchback', '7', GETDATE(), CONVERT(DATETIME, '2023-08-02', 120), '1'),
('VWX210', 'Kia', 'Plateado', 'C9D0E1F2', 'Sedán, SUV, Hatchback', '7', GETDATE(), CONVERT(DATETIME, '2023-09-14', 120), '1'),
('YZA789', 'Jeep', 'Verde', 'C9D0E1F2', 'SUV, Camioneta todoterreno', '5', GETDATE(), CONVERT(DATETIME, '2023-10-29', 120), '1'),
('BCD456', 'Subaru', 'Naranja', 'P1Q2R3S4', 'Sedán, SUV, Hatchback', '7', GETDATE(), CONVERT(DATETIME, '2023-11-07', 120), '1'),
('EFG987', 'Mazda', 'Gris Oscuro', 'T5U6V7W8', 'Sedán, SUV, Hatchback', '5', GETDATE(), CONVERT(DATETIME, '2023-12-18', 120), '1'),
('HIJ321', 'Toyota', 'Blanco Perla', 'X9Y0Z1A2', 'Sedán, SUV, Camioneta', '6', GETDATE(), CONVERT(DATETIME, '2023-01-02', 120), '1'),
('KLM654', 'Honda', 'Negro Mate', 'B3C4D5E6', 'Sedán, SUV, Camioneta', '5', GETDATE(), CONVERT(DATETIME, '2023-02-14', 120), '1'),
('NOP876', 'Volkswagen', 'Plata Metalico', 'F7G8H9I0', 'Sedán, SUV, Coupé', '7', GETDATE(), CONVERT(DATETIME, '2023-03-27', 120), '1');



create table Personas(
id int identity (1,1),
matricula int,
nombre varchar(200),
ap varchar(200),
am varchar(200),
telefono varchar(10),
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

use V_Unity1
INSERT INTO Personas (matricula, nombre, ap, am, telefono, contraseña, fecha_ingreso, fecha_actualizacion, estatus, id_genero, id_rol)
VALUES
('121045812', 'Luis', 'Garcia', 'Rodriguez', '5512345678', '4T7y9P2q5R6w', GETDATE(), '2023-01-01', 1, 2, 1),
('121057193', 'Maria', 'Lopez', 'Martinez', '8198765432', '3G6h8E1b4D9s', GETDATE(), '2023-02-15', 1, 1, 1),
('121060274', 'Carlos', 'Gonzalez', 'Hernandez', '334681357', '2J5k7L3m6N1v', GETDATE(), '2023-03-10', 1, 2, 2),
('121073455', 'Ana', 'Medina', 'Delgado', '6649876543', '9C2x4Z8v7B1n', GETDATE(), '2023-04-22', 1, 1, 1),
('121085636', 'Juan Carlos', 'Mendoza', 'Ortega', '6865432109', '6R9t3Y2h5N8s', GETDATE(), '2023-05-05', 1, 2, 2)

create table Pasajeros(
id int identity(1,1),
id_persona int,
foreign key(id_persona)references Personas(id),
primary key(id)
)
---------------------------------------
INSERT INTO Pasajeros (id_persona)
VALUES
('1'),
('2'),
('3'),
('4'),
('5'),
('6'),
('7'),
('8'),
('9'),
('10'),
('11'),
('12'),
('13'),
('14'),
('15')




create table Conductores(
id int identity(1,1),
id_persona int,
foreign key(id_persona) references Personas(id),
id_auto int,
foreign key(id_auto) references Autos(id),
primary key(id)
)
-------------------------
INSERT INTO Conductores (id_persona, id_auto)
VALUES
('3', '1'),
('5', '2'),
('6', '3'),
('11', '4'),
('12', '5'),
('15', '6');

create table Viajes_globales(
id int identity(1,1),
fecha_ingreso date,
fecha_actualizacion datetime,
id_ruta int,
foreign key(id_ruta) references Rutas(id),
id_conductor int,
foreign key(id_conductor) references Conductores(id),
id_requisitos int,
foreign key(id_requisitos) references Requisitos(id),
id_incidente int,
foreign key(id_incidente) references Incidentes(id),
primary key(id)
)
INSERT INTO Viajes_globales(fecha_ingreso, fecha_actualizacion, id_ruta, id_incidente, id_requisitos, id_conductor)
VALUES
('2023-01-01', 'GETDATE()', '1', '1', '1', '3'),
('2023-02-15', 'GETDATE()', '2', '2', '1', '5'),
('2023-03-10', 'GETDATE()', '3', '3', '2', '6'),
('2023-04-22', 'GETDATE()', '4', '4', '1', '11'),
('2023-05-05', 'GETDATE()', '5', '5', '2', '12'),
('2023-06-18', 'GETDATE()', '6', '6', '1', '15'),
('2023-07-02', 'GETDATE()', '7', '7', '1', '16'),
('2023-08-14', 'GETDATE()', '8', '8', '1', '17'),
('2023-09-28', 'GETDATE()', '9', '9', '2', '18'),
('2023-10-10', 'GETDATE()', '10', '10', '1', '19'),
('2023-11-25', 'GETDATE()', '11', '11', '2', '20'),
('2023-12-08', 'GETDATE()', '12', '12', '1', '21'),
('2024-01-20', 'GETDATE()', '13', '13', '2', '22'),
('2024-02-09', 'GETDATE()', '14', '14', '1', '23'),
('2024-03-16', 'GETDATE()', '15', '15', '2', '24')

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
INSERT INTO Viajes(id_viaje_global, id_pasajero, id_parada ,fecha_ingreso, fecha_actualizacion)
VALUES
(1, 1, 1, '2023-01-01', GETDATE()),
(2, 2, 2, '2023-02-15', GETDATE()),
(3, 4, 3, '2023-03-10', GETDATE()),
(4, 7, 4, '2023-04-22', GETDATE()),
(5, 8, 5, '2023-05-05', GETDATE()),
(6, 9, 6, '2023-06-18', GETDATE()),
(7, 10, 7, '2023-07-02', GETDATE()),
(8, 13, 8, '2023-08-14', GETDATE()),
(9, 14, 9, '2023-09-28', GETDATE()),
(10, 25, 10, '2023-10-10', GETDATE()),
(11, 26, 11, '2023-11-25', GETDATE()),
(12, 27, 12, '2023-12-08', GETDATE()),
(13, 28, 13, '2024-01-20', GETDATE()),
(14, 29, 14, '2024-02-09', GETDATE()),
(15, 30, 15, '2024-03-16', GETDATE())
------
INSERT INTO Viajes_globales(fecha_ingreso, fecha_actualizacion, id_ruta, id_incidente, id_requisitos, id_conductor)
VALUES
('2023-01-01', GETDATE(), 1, 1, 1, 3),
('2023-02-15', GETDATE(), 2, 2, 1, 5),
('2023-03-10', GETDATE(), 3, 3, 2, 6),
('2023-04-22', GETDATE(), 4, 4, 1, 11),
('2023-05-05', GETDATE(), 5, 5, 2, 12),
('2023-06-18', GETDATE(), 6, 6, 1, 15),
('2023-07-02', GETDATE(), 7, 7, 1, 16),
('2023-08-14', GETDATE(), 8, 8, 1, 17),
('2023-09-28', GETDATE(), 9, 9, 2, 18),
('2023-10-10', GETDATE(), 10, 10, 1, 19),
('2023-11-25', GETDATE(), 11, 11, 2, 20),
('2023-12-08', GETDATE(), 12, 12, 1, 21),
('2024-01-20', GETDATE(), 13, 13, 2, 22),
('2024-02-09', GETDATE(), 14, 14, 1, 23),
('2024-03-16', GETDATE(), 15, 15, 2, 24)

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


<
INSERT INTO Roles (nombre) VALUES ('Administrador');
INSERT INTO Generos (nombre) VALUES ('Masculino');
INSERT INTO Requisitos (descripcion) VALUES ('Licencia de conducir');
INSERT INTO Tipos_Pagos (tipo) VALUES ('Tarjeta de crédito');
INSERT INTO Incidentes (nombre) VALUES ('Accidente de tráfico');

INSERT INTO Pagos (id_viaje, fecha, monto, id_tipo_pago, fecha_ingreso, fecha_actualizacion, estatus)
VALUES
(1, GETDATE(), 100, 1, GETDATE(), GETDATE(), 1),
(2, GETDATE(), 150, 1, GETDATE(), GETDATE(), 1),
(3, GETDATE(), 200, 2, GETDATE(), GETDATE(), 1),
(4, GETDATE(), 250, 2, GETDATE(), GETDATE(), 1),
(5, GETDATE(), 190, 1, GETDATE(), GETDATE(), 1),
(6, GETDATE(), 110, 2, GETDATE(), GETDATE(), 1),
(7, GETDATE(), 150, 2, GETDATE(), GETDATE(), 1),
(8, GETDATE(), 190, 1, GETDATE(), GETDATE(), 1),
(9, GETDATE(), 210, 2, GETDATE(), GETDATE(), 1),
(10, GETDATE(), 250, 2, GETDATE(), GETDATE(), 1),
(11, GETDATE(), 170, 1, GETDATE(), GETDATE(), 1),
(12, GETDATE(), 160, 2, GETDATE(), GETDATE(), 1),
(13, GETDATE(), 180, 1, GETDATE(), GETDATE(), 1),
(14, GETDATE(), 200, 2, GETDATE(), GETDATE(), 1),
(15, GETDATE(), 290, 1, GETDATE(), GETDATE(), 1)