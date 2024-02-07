DROP TABLE IF EXISTS empresas,alumnos,alumnos_asisten,	
						cursos,profesores,tipos_curso;

CREATE TABLE empresas(
	cif 		VARCHAR(10),
	nombre		VARCHAR(100) NOT NULL,
	direccion	VARCHAR(100) NOT NULL,
	telefono	VARCHAR(160) NOT NULL,
	CONSTRAINT pk_empresas PRIMARY KEY (cif)
);
CREATE TABLE alumnos(
	dni			VARCHAR(10),
	nombre		VARCHAR(100),
	direccion	VARCHAR(100),
	telefono	VARCHAR(160),
	edad		NUMERIC(100),
	empresa		VARCHAR(100),
	CONSTRAINT pk_alumnos PRIMARY KEY (dni)
);
CREATE TABLE alumnos_asisten(
	dni				VARCHAR(10),
	num_concreto	INT,
	CONSTRAINT pk_alumnos_asisten PRIMARY KEY(dni,num_concreto)
);
CREATE TABLE cursos(
	num_concreto	SERIAL,
	fecha_inicio	DATE NOT NULL,
	fecha_fin		DATE,
	dni_profesor	VARCHAR(10) NOT NULL,
	tipo_curso		INT NOT NULL,
	CONSTRAINT pk_cursos PRIMARY KEY (num_concreto)
);
CREATE TABLE profesores(
	dni			VARCHAR(10),
	nombre		VARCHAR(100),
	apellido	VARCHAR(100),
	telefono	VARCHAR(160),
	direccion	VARCHAR(100),
	CONSTRAINT pk_profesores PRIMARY KEY (dni)
);
CREATE TABLE tipos_curso(
	cod_curso	SERIAL,
	duracion	INT NOT NULL,
	programa	VARCHAR(100) NOT NULL,
	titulo		VARCHAR(100) NOT NULL,
	CONSTRAINT pk_tipos_curso PRIMARY KEY (cod_curso)
);

ALTER TABLE alumnos
ADD CONSTRAINT fk_alumnos_empresas FOREIGN KEY (empresa) REFERENCES empresas;
ALTER TABLE alumnos_asisten
ADD CONSTRAINT fk_alumnos_asisten_alumnos FOREIGN KEY (dni) REFERENCES alumnos;
ALTER TABLE alumnos_asisten
ADD CONSTRAINT fk_alumnos_asisten_cursos FOREIGN KEY (num_concreto) REFERENCES cursos;
ALTER TABLE cursos
ADD CONSTRAINT fk_cursos_rofesores_ FOREIGN KEY (dni_profesor) REFERENCES profesores,
ADD CONSTRAINT fk_cursos_tipos_curso FOREIGN KEY (tipo_curso) REFERENCES tipos_curso;


INSERT INTO empresas (cif,nombre,direccion,telefono)
VALUES ('79348373T','Manuel SL','Av/ Gongora 55', '645 34 23 67'),
	   ('75735858F','S.A Lejeune','C/ Andalucía 1', '602 52 75 64'),
	   ('29546563W','Almacenes Paco','Av/ Sevilla 16', '683 32 22 97');
	   
INSERT INTO alumnos (dni,nombre,direccion,telefono,edad,empresa)
VALUES 	('79347895E','Manuel','C/ Cadiz 44', '834 43 42 56', 19, '29546563W'),
		('03452457Y','Victor','C/ Malaga 54', '753 34 65 06', 19, '29546563W'),
		('34823454U','Jose','C/ Córdoba 14', '802 67 34 80', 19, '29546563W'),
		('45627554O','Oscar','C/ Malaga 75', '874 23 35 23', 19, '29546563W'),
		('46352574R','Sofía','C/ Andalucía 02', '863 21 64 54', 19, '29546563W'),
		('45247604W','David','C/ Malaga 1', '834 43 42 56', 19, '75735858F'),
		('86024858L','Kike','C/ Federico García Lorca 53', '834 43 42 56', 19, '75735858F'),
		('43682560P','Carmen','C/ Sevilla 13', '834 43 42 56', 19, '75735858F'),
		('42576835G','Miriam','C/ Sevilla 33', '834 43 42 56', 19, '75735858F'),
		('82567030F','Maria','C/ Madrid 63', '834 43 42 56', 19, '75735858F'),
		('98231386D','Manuel','C/ Valencia 24', '834 43 42 56', 19, '79348373T'),
		('06156335Z','Manuel','C/ Jaén 53', '834 43 42 56', 19, '79348373T'),
		('62485154K','Manuel','C/ Jaén 71', '834 43 42 56', 19, '79348373T');

INSERT INTO  cursos (fecha_inicio, fecha_fin, dni_profesor, tipo_curso) VALUES
(CURRENT_DATE, CURRENT_DATE+4, '293586321R',1),
(CURRENT_DATE, CURRENT_DATE+8, '29486556T',1),
(CURRENT_DATE, CURRENT_DATE+14, '29463217U',1),
(CURRENT_DATE, CURRENT_DATE+23, '29496874W',1),
(CURRENT_DATE, CURRENT_DATE+4, '29486587O',1),
(CURRENT_DATE, CURRENT_DATE+1, '29498741W',2),
(CURRENT_DATE, CURRENT_DATE+3, '69886321P',2),
(CURRENT_DATE, CURRENT_DATE+2, '69876321S',2),
(CURRENT_DATE, CURRENT_DATE+7, '25894321G',2),
(CURRENT_DATE, CURRENT_DATE+9, '29698321G',2),
(CURRENT_DATE, CURRENT_DATE+10, '29698741T',3),
(CURRENT_DATE, CURRENT_DATE+10, '69854712Q',3),
(CURRENT_DATE, CURRENT_DATE+11, '58965744J',3),
(CURRENT_DATE, CURRENT_DATE+7, '69874532B',3),
(CURRENT_DATE, CURRENT_DATE+9, '36987452S',3),
(CURRENT_DATE, CURRENT_DATE+9, '98741256G',4),
(CURRENT_DATE, CURRENT_DATE+4, '98745632D',4),
(CURRENT_DATE, CURRENT_DATE+4, '78546984C',4),
(CURRENT_DATE, CURRENT_DATE+3, '36987425q',4),
(CURRENT_DATE, CURRENT_DATE+5, '63254125l',4);

INSERT INTO tipos_curso(duracion, programa, titulo)
VALUES (2000,'Lorem Ipsun', 'Desarrollo de aplicaciones multiplataforma'),
	   (720,'Lorem Ipsun', 'AyF'),
	   (740,'Lorem Ipsun', 'Comercio'),
	   (1500,'Lorem Ipsun', 'Teleco');
	  
INSERT INTO profesores(dni, nombre, apellido, telefono, direccion)
VALUES ('293586321R','','','','')
	   ('29486556T')
	   ('29463217U')
	   ('29496874W')
	   ('29486587O')
	   ('')
	   ('')
	   ('')
	   ('')
	   ('')
	   ('')
	   ('')
	   ('')
	   ('')
	   ('')