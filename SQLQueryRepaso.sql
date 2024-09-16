CREATE DATABASE DB_Veterinario1;

USE DB_Veterinario1;



CREATE TABLE dueño
(
  id_dueño INT NOT NULL IDENTITY,
  dni VARCHAR(8) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  calle VARCHAR(200) NOT NULL,
  telefono INT NOT NULL,
  correo VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  nro_calle INT NOT NULL,
  CONSTRAINT PK_dueño PRIMARY KEY (id_dueño),
  CONSTRAINT UQ_dueño_correo UNIQUE (correo),
  CONSTRAINT CK_dueño_dni CHECK (LEN(dni) <= 8)
);

CREATE TABLE veterinario
(
  id_veterinario INT NOT NULL IDENTITY,
  numero_licencia INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  horario_atencion Time NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  CONSTRAINT PK_veterinario PRIMARY KEY (id_veterinario)
);

CREATE TABLE medicamento
(
  id_medicamento INT NOT NULL IDENTITY,
  nombre_comercial VARCHAR(100) NOT NULL,
  monodroga VARCHAR(100) NOT NULL,
  presentacion VARCHAR(100) NOT NULL,
  laboratorio VARCHAR(100) NOT NULL,
  CONSTRAINT PK_medicamento PRIMARY KEY (id_medicamento)
);

CREATE TABLE especie
(
  id_especie INT NOT NULL IDENTITY,
  descripcion VARCHAR(100) NOT NULL,
  CONSTRAINT PK_especie PRIMARY KEY (id_especie)
);

CREATE TABLE especialidad
(
  id_especialidad INT NOT NULL IDENTITY,
  descripcion VARCHAR(100) NOT NULL,
  CONSTRAINT PK_especialidad PRIMARY KEY (id_especialidad)
);

CREATE TABLE raza
(
  id_raza INT NOT NULL IDENTITY,
  descripcion VARCHAR(100) NOT NULL,
  id_especie INT NOT NULL,
  CONSTRAINT PK_raza PRIMARY KEY (id_raza),
  CONSTRAINT FK_raza_especie FOREIGN KEY (id_especie) REFERENCES especie(id_especie)
);

CREATE TABLE veterinario_especialidad
(
  id_veterinario INT NOT NULL,
  id_especialidad INT NOT NULL,
  CONSTRAINT PK_veterinaria_especialidad PRIMARY KEY (id_veterinario, id_especialidad),
  CONSTRAINT FK_veterinario_especialidad_veterinario FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
  CONSTRAINT FK_veterinario_especialidad_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE mascota
(
  Id_mascota INT NOT NULL IDENTITY,
  nombre VARCHAR(100) NOT NULL,
  raza VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  condicion_especial VARCHAR(200) NULL, 
  peso FLOAT NOT NULL,
  id_dueño INT NOT NULL,
  id_raza INT NOT NULL,
  CONSTRAINT PK_mascota PRIMARY KEY (Id_mascota),
  CONSTRAINT FK_mascota_dueño FOREIGN KEY (id_dueño) REFERENCES dueño(id_dueño),
  CONSTRAINT FK_mascota_raza FOREIGN KEY (id_raza) REFERENCES raza(id_raza),
  CONSTRAINT CK_mascota_fecha_nacimiento CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) <= 30)
);

CREATE TABLE cita
(
  id_cita INT NOT NULL IDENTITY,
  motivo VARCHAR(150) NOT NULL,
  fecha_cita DATE NOT NULL,
  observacion VARCHAR(200) NOT NULL,
  date_create DATE NOT NULL,
  user_create INT NOT NULL,
  id_veterinario INT NOT NULL,
  Id_mascota INT NOT NULL,
  CONSTRAINT PK_cita PRIMARY KEY (id_cita),
  CONSTRAINT FK_cita_veterinario FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
  CONSTRAINT FK_cita_mascota FOREIGN KEY (Id_mascota) REFERENCES mascota(Id_mascota)
);

CREATE TABLE tratamiento
(
  id_tratamiento INT NOT NULL,
  nombre_tratamiento VARCHAR(100) NOT NULL,
  duracion DATE NOT NULL,
  medicacion VARCHAR(100) NOT NULL,
  indicacion VARCHAR(200) NOT NULL,
  id_cita INT NOT NULL,
  CONSTRAINT PK_tratamiento PRIMARY KEY (id_tratamiento, id_cita),
  CONSTRAINT FK_tratamiento_cita FOREIGN KEY (id_cita) REFERENCES cita(id_cita)
);

CREATE TABLE tratamiento_medicamento
(
  id_medicamento INT NOT NULL,
  id_tratamiento INT NOT NULL,
  id_cita INT NOT NULL,
  CONSTRAINT PK_tratamiento_medicamento PRIMARY KEY (id_medicamento, id_tratamiento, id_cita),
  CONSTRAINT FK_tratamiento_medicamento_medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento),
  CONSTRAINT FK_tratamiento_medicamento_TRATAMIENTO FOREIGN KEY (id_tratamiento, id_cita) REFERENCES tratamiento(id_tratamiento, id_cita)
);


select * from cita;

ALTER TABLE cita
	ADD fecha_cita DATE NOT NULL 

ALTER TABLE cita
	ADD CONSTRAINT DF_cita_fecha_cita DEFAULT GETDATE() FOR fecha_cita


/*lOTES DE PRUEBAS (INSERCIONES VALIDAS)*/

INSERT INTO dueño (dni, nombre, calle, telefono, correo, apellido, nro_calle) VALUES
('1234556', 'Juan', 'lavalle', 21321213, 'juan@email.com', 'Perez', 231)

SELECT * FROM dueño

/*lOTES DE PRUEBAS (INSERCIONES QUE DEBEN FALLAR)*/

INSERT INTO dueño (dni, nombre, calle, telefono, correo, apellido, nro_calle) VALUES
('1234556', 'Juan2', 'lavalle', 21321213, 'juan@email.com', 'Perez', 231)	

INSERT INTO dueño (dni, nombre, calle, telefono, correo, apellido, nro_calle) VALUES
('1232578', 'Juan3', 'lavalle', 21321213, 'laalle@email.com', 'Perez', 231)


/*Actalizamos un registro*/
UPDATE dueño SET nombre = 'Polo' WHERE id_dueño = 6;

/*Eliminamos un registro*/
DELETE FROM dueño WHERE id_dueño = 7;

/*Sintaxios para eliminar una table*/
-- DROP TABLE especie;

CREATE TABLE persona 
(
   id_persona INT NOT NULL IDENTITY,
   genero CHAR(1) NOT NULL,
   fecha_nacimiento DATETIME NOT NULL,
   hora TIME NOT NULL,
   CONSTRAINT PK_persona PRIMARY KEY (id_persona),
   CONSTRAINT CK_persona_genero CHECK (genero IN ('M', 'F')),
   CONSTRAINT CK_persona_fechaNacimiento CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) <= 65)
);

ALTER TABLE persona
	ADD CONSTRAINT DF_persona_hora DEFAULT CAST(GETDATE() AS TIME) FOR hora


ALTER TABLE cita 
	ADD CONSTRAINT CK_cita_user CHECK (user_create BETWEEN 6 AND 8)

ALTER TABLE nombre_tabla
DROP CONSTRAINT nombre_restriccion;
