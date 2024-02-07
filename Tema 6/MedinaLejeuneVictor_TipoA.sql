CREATE TABLE empleado(
	num_empleado		SERIAL,
	nombre				VARCHAR(100) NOT NULL,
	apellidos			VARCHAR(100) NOT NULL,
	email				VARCHAR(320),
	cuenta_corriente	VARCHAR(24),
	pass				VARCHAR(8),
	CONSTRAINT ck_empleado_arroba CHECK( email ILIKE '%@%'),
	CONSTRAINT ck_empleado_empezar_es CHECK ( cuenta_corriente LIKE 'ES%'),
	CONSTRAINT ck_empleado_sin_espacios CHECK (pass NOT ILIKE '% %'),
	CONSTRAINT pk_empleado PRIMARY KEY (num_empleado)
);

CREATE TABLE cliente(
	dni			VARCHAR(10),
	nombre		VARCHAR(100) NOT NULL,
	apellidos	VARCHAR(100) NOT NULL,
	email		VARCHAR(320),
	direccion	VARCHAR(100),
	fecha_alta	DATE,
	CONSTRAINT ck_cliente_arroba CHECK( email ILIKE '%@%'),
	CONSTRAINT pk_cliente PRIMARY KEY (dni)
);

CREATE TABLE venta(
	id_venta	SERIAL,
	fecha		DATE,
	empleado	INT NOT NULL,
	cliente		VARCHAR(10) NOT NULL,
	CONSTRAINT pk_venta PRIMARY KEY (id_venta)
);

CREATE TABLE lineaventa(
	id_venta	INT,
	id_linea	SERIAL,
	cantidad	INT,
	producto	INT,	
	precio		NUMERIC(5,2) DEFAULT (9.99),
	CONSTRAINT ck_lineaventa_mayor_que_0 CHECK (cantidad > 0),
	CONSTRAINT pk_lineaventa PRIMARY KEY (id_venta,id_linea)
);

CREATE TABLE producto(
	cup				SERIAL,
	nombre			VARCHAR(100) NOT NULL,
	descripcion		VARCHAR(200),
	pvp				INT NOT NULL,
	categoria		INT,
	CONSTRAINT pk_producto PRIMARY KEY (cup)
);

CREATE TABLE categoria(
	id_categoria	SERIAL,
	nombre			VARCHAR(100) NOT NULL,	
	descripcion		VARCHAR(200),
	CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

INSERT INTO categoria(nombre,descripcion)
VALUES ('Apple','Tenda oficial de Appel');

INSERT INTO cliente(dni,nombre,apellidos,email)
VALUES ('538549T','Jesús','Casanova','jesus.casanova@mitienda.com');

INSERT INTO empleado(nombre,apellidos,email,cuenta_corriente)
VALUES ('Miguel','Campos','mcampos@mitienda.com','ES1200000000000012345678');

INSERT INTO producto(nombre,descripcion,pvp,categoria)
VALUES ('Mac Mini M2','256 GB',799,1);

INSERT INTO venta(empleado,cliente)
VALUES (1,'538549T');
INSERT INTO lineaventa(id_venta,cantidad,precio)
VALUES (1,1,799);


INSERT INTO empleado(nombre,apellidos,email,cuenta_corriente)
VALUES ('Ángel','Naranjo','anaranjo@mitienda.com','ES2100000000000087654321');

INSERT INTO producto(nombre,descripcion,pvp,categoria)
VALUES ('Apple Watch Nike +','Ultimo reloj del mercado',440,1);

INSERT INTO cliente(dni,nombre,apellidos,email,direccion)
VALUES ('570039R','Rafel','Villar','rafael.villar@correo.com','Calle Rue del Percebe 13');

INSERT INTO venta(empleado,cliente)
VALUES (2,'570039R');

INSERT INTO lineaventa(id_venta,cantidad,precio)
VALUES (2,1,440);

UPDATE lineaventa 
SET precio = precio - ((precio * 10)/ 100);

DELETE cliente 
SET dni = '570039R';

ALTER TABLE venta
ADD CONSTRAINT fk_venta_empleado FOREIGN KEY (empleado) REFERENCES empleado ON DELETE CASCADE,
ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente) REFERENCES cliente ON DELETE CASCADE;

ALTER TABLE lineaventa
ADD CONSTRAINT fk_lineaventa_producto FOREIGN KEY (producto) REFERENCES producto ON DELETE SET DEFAULT,
ADD CONSTRAINT fk_lineaventa_venta FOREIGN KEY (id_venta) REFERENCES venta ON DELETE CASCADE;

ALTER TABLE producto
ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria) REFERENCES categoria ON DELETE SET DEFAULT;