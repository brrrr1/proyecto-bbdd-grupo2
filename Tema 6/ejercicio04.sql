DROP TABLE IF EXISTS usuarios,estaciones,bicicletas,uso;

CREATE TABLE usuarios(
	dni 				VARCHAR(9),
	nombre				VARCHAR(100) NOT NULL,
	apellidos 			VARCHAR(100) NOT NULL,
	direccion 			VARCHAR(100),
	telefono 			VARCHAR(15) NOT NULL,
	email 				VARCHAR(100) NOT NULL,
	passw 				VARCHAR(8),
	saldo_disponible 	NUMERIC NOT NULL DEFAULT 0,
	CONSTRAINT pk_usuarios PRIMARY KEY (dni),
	CONSTRAINT ck_usuarios_passw_entre_4_y_8 CHECK (LENGTH (passw) BETWEEN 4 AND 8),
	CONSTRAINT ck_usuarios_passw_sin_espacios CHECK (passw NOT LIKE '% %')
);

CREATE TABLE estaciones (
    cod_estacion 	VARCHAR(20),
    num_estacion 	SERIAL,
    direccion 		VARCHAR(100) NOT NULL,
    latitud 		NUMERIC NOT NULL,
    longitud 		NUMERIC NOT NULL,
	CONSTRAINT pk_estaciones PRIMARY KEY (cod_estacion),
	CONSTRAINT ck_estaciones_cod_estacion_empezar_por_e CHECK (cod_estacion LIKE 'E%')
);

CREATE TABLE bicicletas (
    cod_bicicleta 	SERIAL,
    marca 			VARCHAR(50) NOT NULL,
    modelo 			VARCHAR(50) NOT NULL,
    fecha_alta 		DATE NOT NULL,
	CONSTRAINT pk_bicicletas PRIMARY KEY (cod_bicicleta)
);

CREATE TABLE uso (
    estacion_salida 		VARCHAR(20),
    fecha_salida 			TIMESTAMP,
    dni_usuario 			VARCHAR(20),
    cod_bicicleta 			INT,
    estacion_llegada 		VARCHAR(20),
    fecha_llegada 			TIMESTAMP NOT NULL,
	CONSTRAINT pk_uso PRIMARY KEY (estacion_salida, fecha_salida,dni_usuario, cod_bicicleta, estacion_llegada)
);

ALTER TABLE uso
ADD CONSTRAINT fk_uso_estaciones_salida FOREIGN KEY (estacion_salida)
	REFERENCES estaciones,
ADD CONSTRAINT fk_uso_usuarios FOREIGN KEY (dni_usuario)
	REFERENCES usuarios,
ADD CONSTRAINT fk_uso_bicicletas FOREIGN KEY (cod_bicicleta)
	REFERENCES bicicletas,
ADD CONSTRAINT fk_uso_estaciones_llegada FOREIGN KEY (estacion_llegada)
	REFERENCES estaciones;

ALTER TABLE usuarios
ADD COLUMN fecha_baja DATE;

--Coste acumulado
SELECT u.dni, u.nombre, u.apellidos,
    SUM(EXTRACT(MINUTE FROM (uso.Fecha_llegada - uso.Fecha_salida))) * 0.001 AS Coste_acumulado
FROM usuarios u JOIN uso uso ON u.dni = uso.dni_usuario
GROUP BY u.dni, u.nombre, u.Apellidos;