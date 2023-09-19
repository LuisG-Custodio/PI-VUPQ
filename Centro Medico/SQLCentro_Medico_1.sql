create database Centro_Medico
use Centro_Medico

create table Personas(
id int identity(1,1),
nombre varchar(50),
ap varchar(50),
am varchar(50),
telefono varchar(10),
correo varchar(50),
primary key(id)
)

create table Sexo(
id int identity(1,1),
nombre varchar(10),
primary key(id)
)

insert into Sexo(nombre)
values
('Femenino'),
('Masculino')

create table Roles(
id int identity(1,1),
nombre varchar(50),
primary key(id)
)

insert into Roles(nombre)
values
('Administrador'),
('Usuario')

create table Departamentos(
id int identity(1,1),
nombre varchar(50),
primary key(id)
)

create table Medicos(
id int identity(1,1),
id_persona int,
RFC varchar(13) unique,
cedula varchar(10) unique,
contraseña varbinary(8000),
id_rol int,
id_departamento int,
consultorio varchar(10),
visibilidad bit default(1),
primary key(id),
foreign key(id_persona) references Personas(id),
foreign key(id_rol) references Roles(id),
foreign key(id_departamento) references Departamentos(id)
)

create table Pacientes(
id int identity(1,1),
id_persona int,
id_medico int,
nacimiento date,
id_sexo int,
enfermedades text,
alergias text,
antecedentes text,
primary key(id),
foreign key(id_persona) references Personas(id),
foreign key(id_medico) references Medicos(id),
foreign key(id_sexo) references Sexo(id)
)

create table Consultas(
id int identity(1,1),
id_paciente int,
fecha date,
peso decimal(5,2),
altura int,
temperatura decimal(5,2),
ritmo_cardiaco int,
presion varchar(10),
saturacion_oxigeno decimal(5,2),
glucosa decimal(6,2),
sintomatologia text,
diagnostico text,
receta text,
examenes text,
primary key(id),
foreign key(id_paciente) references Pacientes(id)
)

insert into Personas(nombre,ap,am,telefono,correo)
values
('Hipócrates','','','5536701512','hipocrates@medicatemp.com'),
('Sigmund Schlomo','Freud','','5536701527','sigmund_fneuro@medicatemp.com'),
('Christiaan Neethling',' Barnard','','5536701569','chris_bcardio@medicatemp.com'),
('Ambroise','Paré','','5536701500','ambroise_pcirugia@medicatemp.com'),
('Henry','Cohen','','5536701598','henry_cgastro@medicatemp.com'),
('Alexander','Fleming','','5536701564','alex_furgencias@medicatemp.com'),
('Emilio','Calvo','Crespo','5536701503','emilio_ctrauma@medicatemp.com'),
('Uriel','Pérez','Lozano','5670150111','urielperezlozano@gmail.com'),
('Miguel','González','Escutia','5670150222','miguel175689@hotmail.com'),
('Noé','López','López','5670150333','noedoblel@hotmail.com'),
('Ana María','Nogales','Flores','5670150444','b3b1t4m0xxit4@hotmail.com'),
('Penelope Arais','Rivera','Sánchez','5670150555','arais_p12@outlook.com'),
('Julieta','Martínez','Pichardo','5670150666','julimartinez@outlook.com'),
('Alexa Fernanda','Covarrubias','Estrada','5670150777','alexa_coves@outlook.com'),
('Frida','Navarrete','Gómez','5670150888','fridanavarrete156@gmail.com'),
('Nadia','Zárate','Jiménez','5670150999','nad_zj12@outlook.com'),
('Daniela','Chávez','Lima','5670151000','danii_chali@hotmail.com'),
('Ivan Enrique','Nogal','Juarez','5670151111','ivan_edgelord42069@hotmail.com'),
('Yahir','Reyes','Rojo','5670151222','yahirreyes13@gmail.com'),
('Oscar Daniel','Cadena','Prado','5670151333','cadena_doscar@outlook.com'),
('José','Flores','Pacheco','5670151444','joseflorespacheco2@gmail.com')

insert into Departamentos(nombre)
values
('Medicina General'),
('Neurología'),
('Cardiología'),
('Cirugía General'),
('Gastroenterología'),
('Urgencias'),
('Ortopedia y Traumatología')

insert into Medicos(id_persona,RFC,cedula,id_rol,id_departamento,consultorio,contraseña)
values
(1,'RFC123456RFC7','987654327',1,1,'MG-01',hashbytes('MD4','12345678')),
(2,'RFC123456RFC6','987654326',2,2,'N-01',hashbytes('MD4','87654321')),
(3,'RFC123456RFC5','987654325',2,3,'C-01',hashbytes('MD4','23456789')),
(4,'RFC123456RFC4','987654324',2,4,'CG-01',hashbytes('MD4','98765432')),
(5,'RFC123456RFC3','987654323',2,5,'GE-01',hashbytes('MD4','34567891')),
(6,'RFC123456RFC2','987654322',2,6,'ER-01',hashbytes('MD4','19876543')),
(7,'RFC123456RFC1','987654321',2,7,'OT-01',hashbytes('MD4','45678912'))

insert into Pacientes(id_medico,nacimiento,id_persona,id_sexo,enfermedades,alergias,antecedentes)
values
(1,'01/01/1980',8,2,'Ninguna','Ninguna','Ninguna'),
(2,'02/02/1981',9,2,'Ninguna','Ninguna','Ninguna'),
(3,'03/03/1982',10,2,'Ninguna','Ninguna','Ninguna'),
(4,'04/04/1983',11,1,'Ninguna','Ninguna','Ninguna'),
(5,'05/05/1984',12,1,'Ninguna','Ninguna','Ninguna'),
(6,'06/06/1985',13,1,'Ninguna','Ninguna','Ninguna'),
(7,'07/07/1986',14,1,'Ninguna','Ninguna','Ninguna'),
(1,'08/08/1987',15,1,'Ninguna','Ninguna','Ninguna'),
(2,'09/09/1988',16,1,'Ninguna','Ninguna','Ninguna'),
(3,'10/10/1989',17,1,'Ninguna','Ninguna','Ninguna'),
(4,'11/11/1990',18,2,'Ninguna','Ninguna','Ninguna'),
(5,'12/12/1991',19,2,'Ninguna','Ninguna','Ninguna'),
(6,'01/01/1992',20,2,'Ninguna','Ninguna','Ninguna'),
(7,'02/02/1993',21,2,'Ninguna','Ninguna','Ninguna')

select * from Medicos