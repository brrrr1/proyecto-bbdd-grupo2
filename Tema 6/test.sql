DROP TABLE IF EXISTS productos,pedido, detalle_pedido,temperatura_sevilla;

CREATE TABLE productos (
num_producto SERIAL,
nombre TEXT,
precio NUMERIC,
CONSTRAINT pk_productos PRIMARY KEY (num_producto)
);
CREATE TABLE pedido(
	num_pedido SERIAL,
	fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	cliente VARCHAR(100),
	CONSTRAINT pk_pedido PRIMARY KEY (num_pedido)
);
CREATE TABLE detalle_pedido(
	num_pedido INT,
	num_producto INT,
	precio NUMERIC,
	cantidad	INT,
	CONSTRAINT pk_detalle_pedido PRIMARY KEY (num_pedido, num_producto)
);

ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (num_pedido) REFERENCES pedido,
ADD CONSTRAINT fk_detalle_pedido_productos FOREIGN KEY (num_producto) REFERENCES productos;


INSERT INTO productos (nombre, precio)
VALUES ('Queso', 9.99), ('Tomate', 5.32), ('Huevo', 5.94),
	('Manueh',0.2),('Rarete no?', 7.77);

ALTER SEQUENCE productos_num_producto_seq
RESTART WITH 6
INCREMENT BY 1;

INSERT INTO productos (nombre, precio)
VALUES ('Pepino', 99999);

/*
Restablecer el número siguiente de un numero serial
tmb te avisa si se repite
*/

CREATE TABLE temperatura_sevilla(
	fecha DATE,
	estacion VARCHAR(200),
	provincia VARCHAR(100),
	temperatura_media NUMERIC(4,2),
	CONSTRAINT pk_temperatura_sevilla PRIMARY KEY (fecha,estacion)
);
/*
UPDATE productos
SET precio = 9.999
WHERE precio != 0;


UPDATE productos
SET precio = precio + (precio * (10.0/100))
WHERE precio < 150.00;
*/
ALTER TABLE productos
ADD COLUMN disponible boolean;



SELECT *
FROM productos;