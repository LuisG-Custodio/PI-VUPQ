Create database V_Unity1;
use V_Unity1;

create table Roles(
id int AUTO_INCREMENT,
nombre varchar(200),
primary key(id)
);
create table Generos(
id int AUTO_INCREMENT,
nombre varchar(200),
primary key(id)
);
create table Requisitos(
id int AUTO_INCREMENT,
descripcion varchar(200),
primary key(id)
);
create table Tipos_Pais(
id int AUTO_INCREMENT,
tipo varchar(200),
primary key(id)
);
create table Incidentes(
id int AUTO_INCREMENT,
nombre varchar(200),
primary key(id)
);
create table Rutas(
id int AUTO_INCREMENT,
nombre varchar(200),
descripcion varchar(200),
primary key(id)
);
create table Paradas(
id int AUTO_INCREMENT,
nombre varchar(200),
distancia int,
primary key(id)
);

create table Autos(
id int AUTO_INCREMENT,
matricula int,
marca varchar(200),
color varchar(200),
poliza varchar(200),
tipo_auto varchar(200),
capacidad int,
fecha_ingreso date,
fecha_actualizacion datetime,
estatus bit,
primary key(id)
);
create table Personas(
id int AUTO_INCREMENT,
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
);
create table Pasajeros(
id int AUTO_INCREMENT,
id_persona int,
foreign key(id_persona)references Personas(id),
primary key(id)
);

create table Conductores(
id int AUTO_INCREMENT,
id_persona int,
foreign key(id_persona) references Personas(id),
id_auto int,
foreign key(id_auto) references Autos(id),
primary key(id)
);
create table Viajes_globales(
id int AUTO_INCREMENT,
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
);
create table Viajes(
id int AUTO_INCREMENT,
id_viaje_global int,
foreign key(id_viaje_global) references Viajes_globales(id),
id_pasajero int,
foreign key(id_pasajero) references Pasajeros(id),
id_parada int,
foreign key(id_parada) references Paradas(id),
fecha_ingreso date,
fecha_actualizacion datetime,
primary key(id)
);
create table Pais(
id int AUTO_INCREMENT,
id_viaje int,
foreign key(id_viaje) references Viajes(id),
fecha date,
monto varchar(200),
id_tipo_pais int,
foreign key(id_tipo_pais) references Tipos_Pais(id),
fecha_ingreso date,
fecha_actualizacion date,
estatus bit,
primary key(id)
);