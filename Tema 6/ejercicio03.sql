DROP TABLE IF EXISTS invitado,teatro,obra,exhibe,tipo_asiento,asiento_tipo,precio,entrada;

CREATE TABLE invitado(
	numero_invitado		SERIAL,
	nombre				VARCHAR(100) NOT NULL,
	categoria			VARCHAR(100) NOT NULL,
	origen				VARCHAR(60) NOT NULL,
	CONSTRAINT pk_invitado PRIMARY KEY (numero_invitado)
);

CREATE TABLE teatro(
	cod_teatro				SERIAL,
	nombre					VARCHAR(100) NOT NULL,
	direccion				VARCHAR(100) NOT NULL,
	cantidad_asientos		INT,
	CONSTRAINT pk_teatro PRIMARY KEY (cod_teatro)
);

CREATE TABLE obra(
	cod_obra		SERIAL,
	nombre_obra		VARCHAR(100) NOT NULL,
	autor			VARCHAR(100),
	CONSTRAINT pk_obra PRIMARY KEY (cod_obra)
);

CREATE TABLE exhibe(
	cod_teatro	INT,
	fecha		DATE,
	cod_obra	INT,
	CONSTRAINT pk_exhibe PRIMARY KEY (cod_teatro,fecha)
);
ALTER TABLE exhibe
ADD CONSTRAINT fk_exhibe_teatro FOREIGN KEY (cod_teatro) REFERENCES teatro,
ADD CONSTRAINT fk_exhibe_obra FOREIGN KEY(cod_obra) REFERENCES obra;

CREATE TABLE tipo_asiento(
	tipo			VARCHAR(100),
	nombre			VARCHAR(100),
	descripcion		VARCHAR(200),
	CONSTRAINT pk_tipo_asiento PRIMARY KEY (tipo)
);

CREATE TABLE asiento_tipo(
	numero_asiento	SERIAL,
	tipo			VARCHAR(100),
	CONSTRAINT pk_asiento_tipo PRIMARY KEY (numero_asiento)
);
ALTER TABLE asiento_tipo
ADD CONSTRAINT fk_asiento_tipo_tipo_asiento_ FOREIGN KEY (tipo) REFERENCES tipo_asiento;

CREATE TABLE precio(
	cod_teatro 	INT,
	fecha		DATE,
	tipo		VARCHAR(100),
	precio		NUMERIC,
	CONSTRAINT precio_positivo CHECK (precio>=0),
	CONSTRAINT pk_precio PRIMARY KEY (cod_teatro,fecha,tipo)
);
ALTER TABLE precio
ADD CONSTRAINT fk_precio_exhibe FOREIGN KEY(cod_teatro,fecha) REFERENCES exhibe,
ADD CONSTRAINT fk_precio_tipo_asiento FOREIGN KEY(tipo) REFERENCES tipo_asiento;

CREATE TABLE entrada(
	cod_teatro		INT,
	fecha			DATE,
	numero_asiento	INT,
	numero_invitado	INT,
	CONSTRAINT pk_entrada PRIMARY KEY(cod_teatro,fecha,numero_asiento)
);
ALTER TABLE entrada
ADD CONSTRAINT fk_entrada_exhibe FOREIGN KEY (cod_teatro, fecha) REFERENCES exhibe,
ADD CONSTRAINT fk_entrada_asiento_tipo FOREIGN KEY (numero_asiento) REFERENCES asiento_tipo,
ADD CONSTRAINT fk_entrada_invitado FOREIGN KEY (numero_invitado) REFERENCES invitado;