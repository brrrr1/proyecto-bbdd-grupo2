DROP TABLE IF EXISTS docentes,actividades,alumnos,asignacion_act,asistencia_act;

CREATE TABLE docentes(
	dni				VARCHAR(10),
	nombre			VARCHAR(100) NOT NULL,
	telefono		NUMERIC NOT NULL,
	anyio_ingreso	DATE NOT NULL,
	CONSTRAINT pk_docentes PRIMARY KEY (dni)
);
CREATE TABLE actividades(
	id_act		SERIAL,
	nombre		VARCHAR(100),
	duracion	DATE NOT NULL,
	CONSTRAINT pk_actividades PRIMARY KEY (id_act)
);
CREATE TABLE alumnos(
	cod_alumno 	SERIAL,
	nombre		VARCHAR(100) NOT NULL,
	telefono	NUMERIC NOT NULL,
	nivel		INT NOT NULL,
	CONSTRAINT pk_alumnos PRIMARY KEY (cod_alumno)
);
CREATE TABLE asignacion_act	(
	id_doc			INT,
	id_act			INT,
	dia_semana		DATE,
	hora			TIMESTAMP,
	CONSTRAINT pk_asignacion_act PRIMARY KEY(id_doc,id_act,dia_semana,hora)
);
CREATE TABLE asistencia_act(
	id_alumno	INT,
	id_act		INT,
	id_doc		INT,
	CONSTRAINT pk_asistencia_act PRIMARY KEY (id_alumno,id_act)
);


ALTER TABLE asistencia_act
ADD CONSTRAINT fk_asistencia_act_alumnos FOREIGN KEY (id_alumno) REFERENCES alumnos (cod_alumno),
ADD CONSTRAINT fk_asistencia_act_actividades FOREIGN KEY (id_act) REFERENCES actividades (id_act);

ALTER TABLE asignacion_act
ADD CONSTRAINT fk_asignacion_act_actividades FOREIGN KEY (id_act) REFERENCES actividades (id_act);