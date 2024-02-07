DROP TABLE IF EXISTS libro,autor,editorial,genero,edicion;

CREATE TABLE autor(
	dni				VARCHAR(9),
	nombre			VARCHAR(100) NOT NULL,
	nacionalidad	VARCHAR(100),
	CONSTRAINT pk_autor PRIMARY KEY (dni)
);
CREATE TABLE genero(
	id_genero		SERIAL,
	nombre			VARCHAR(100) NOT NULL,
	descripcion		VARCHAR(100),
	CONSTRAINT pk_genero PRIMARY KEY (id_genero)
);

CREATE TABLE editorial(
	cod_editorial	SERIAL,
	nombre			VARCHAR(100) NOT NULL,
	direccion		VARCHAR(100),
	poblacion		VARCHAR(100),
	CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial)
);
CREATE TABLE libro(
	isbn			VARCHAR(10),
	título			VARCHAR(100) NOT NULL,
	dni_autor		VARCHAR(9) NOT NULL,
	cod_genero		INT NOT NULL,
	cod_editorial	INT NOT NULL,
	CONSTRAINT pk_libro PRIMARY KEY (isbn),
	CONSTRAINT fk_libro_autor FOREIGN KEY(dni_autor) REFERENCES autor,
	CONSTRAINT fk_libro_genero FOREIGN KEY (cod_genero) REFERENCES genero,
	CONSTRAINT fk_libro_editorial FOREIGN KEY (cod_editorial) REFERENCES editorial	
);
CREATE TABLE edicion(
	isbn				VARCHAR(100),
	fecha_publicacion	DATE,
	cantidad			INT,
	CONSTRAINT cantidad_positiva CHECK (cantidad > 0),
	CONSTRAINT pk_edicion PRIMARY KEY (isbn,fecha_publicacion),
	CONSTRAINT fk_edicion_libro FOREIGN KEY(isbn) REFERENCES libro
);