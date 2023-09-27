create database carpool;
use carpool;

create table Conductor(
id_conductor int not null primary key auto_increment,
matricula varchar(15),
primer_ingreso_flag tinyint default 0,
telefono varchar(10),
foto mediumblob,
INE mediumblob,
CredencialUPQ mediumblob,
foreign key (matricula) references vw_inscripciones(matricula)
);

create table Autos(
id_auto int not null primary key auto_increment,
placa varchar(200),
modelo varchar(200),
marca varchar(200),
color varchar(200),
poliza varchar(200),
fecha_vencimiento date,
lugares_disponibles int,
Tarjeta_circulacion mediumblob,
capacidad int,
espacios_disponibles int,
estatus boolean
);

create table Relacion_autos(
id int not null primary key auto_increment,
id_conductor int,
id_auto int,
foreign key (id_conductor) references Conductor(id_conductor) on delete cascade on update cascade,
foreign key (id_auto) references Autos(id_auto) on delete cascade on update cascade
);

create table Ruta(
id_ruta int not null primary key auto_increment,
destino text not null
);

create table Referencias(
id_referencias int not null primary key auto_increment,
paradas text not null,
id_ruta int,
foreign key (id_ruta) references Ruta(id_ruta) on delete cascade on update cascade
);

create table Relacion_ruta(
id int not null primary key auto_increment,
id_ruta int,
id_referencias int,
foreign key (id_ruta) references Ruta(id_ruta) on delete cascade on update cascade,
foreign key (id_referencias) references Referencias(id_referencias) on delete cascade on update cascade
);

create table Horarios(
id_horario int,
id_conductor int,
dia varchar(10),
turno varchar(10),
salida time,
id_relacion int,
foreign key (id_relacion) references Relacion_ruta(id) on delete cascade on update cascade
);

create table Pasajero(
id_pasajero int not null primary key auto_increment,
matricula varchar(15),
telefono varchar(10),
id_conductor int,
aprovacion_flag tinyint default 0,
foreign key (matricula) references vw_inscripciones(matricula),
foreign key (id_conductor) references Conductor(id_conductor) on delete cascade on update cascade
);

create table Administrador(
id varchar(15),
password binary
);
