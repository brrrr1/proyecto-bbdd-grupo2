DROP TABLE IF EXISTS trabajador;
DROP TABLE IF EXISTS lineaVenta;
DROP TABLE IF EXISTS pieza;
DROP TABLE IF EXISTS coche;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS proovedor;
DROP TABLE IF EXISTS factura;
DROP TABLE IF EXISTS cliente;

CREATE TABLE trabajador(
    dni            VARCHAR(10) ,
    nombre        VARCHAR(100) NOT NULL,
    apellidos    VARCHAR(300) NOT NULL,
    fechaAlta    DATE NOT NULL,
    fechaBaja    DATE,
    sueldoBase    NUMERIC(6,2) DEFAULT(1100),
    CONSTRAINT pk_trabajador PRIMARY KEY(dni)
);
CREATE TABLE lineaVenta(
    codLineaVenta    SERIAL,
    codFactura        VARCHAR(150), --fk
    codPieza          VARCHAR(100), --fk
    cantidad        INTEGER,
    pvpUnitario        NUMERIC(6,2),
    pvpvTotal        NUMERIC(7,2),
    dniTrabajador    VARCHAR(9),--fk
    CONSTRAINT pk_lineaVenta PRIMARY KEY(codLineaVenta,codFactura,codPieza)
);
CREATE TABLE pieza(
    referencia         VARCHAR(100),
    nombre            VARCHAR(150) NOT NULL,
    descripcion        VARCHAR(300),
    idCategoria        INTEGER, --fk
    CONSTRAINT pk_pieza PRIMARY KEY(referencia)
);
CREATE TABLE coche(
    numBastidor    VARCHAR(19),
    matricula    VARCHAR(9) NOT NULL,
    marca        VARCHAR(50) NOT NULL,
    modelo        VARCHAR(100) NOT NULL,
    anyoPrimeraMatriculacion  DATE NOT NULL,
    dniTrabajador        VARCHAR(9),--fk
    dniCliente            VARCHAR(9),--fk
    CONSTRAINT pk_coche PRIMARY KEY(numBastidor)
);
CREATE TABLE categoria(
    idCategoria        SERIAL,
    nombre            VARCHAR(100),
    CONSTRAINT pk_categoria PRIMARY KEY(idCategoria)
);
CREATE TABLE proovedor(
    cifEmpresa     VARCHAR(10),
    descripcion  VARchAR(100),
    tipoRespuestos    VARCHAR(100),    
    nombre    VARCHAR(100),
    CONSTRAINT pk_empresa PRIMARY KEY(cifEmpresa)
    
);
CREATE TABLE factura(
    codFactura    VARCHAR(150),
    fechaEmision DATE NOT NULL,
    fechaInicio DATE NOT NULL,
    idTrabajador VARCHAR(9), --fk
    idCliente    VARCHAR(9), --fk
    codLineaVenta    INTEGER, --fk
    descuento        NUMERIC(4,2),
    subTotalSinIVA    NUMERIC(6,2),
    IVA                NUMERIC(4,2) DEFAULT(21),
    cantidadDescontadaSubTotalSinIVA    NUMERIC(5,2),
    totalFactura        NUMERIC(6,2),
    CONSTRAINT pk_factura PRIMARY KEY(codFactura)
);
CREATE TABLE cliente(
    dni    VARCHAR(9),
    nombre    VARCHAR(100) NOT NULL,
    apellido1    VARCHAR(300),
    apellido2    VARCHAR(300),
    numTelefono    VARCHAR NOT NULL,
    direccion    VARCHAR(200),
    correo        VARCHAR(300),
    clienteEmpresa    BOOLEAN,
    CONSTRAINT pk_cliente PRIMARY KEY(dni)
);
ALTER TABLE lineaVenta
ADD CONSTRAINT fk_lineaVenta_factura FOREIGN KEY (codFactura) REFERENCES factura(codFactura),
ADD CONSTRAINT fk_lineaVenta_pieza FOREIGN KEY (codPieza) REFERENCES pieza(referencia),
ADD CONSTRAINT fk_lineaVenta_trabajador FOREIGN KEY (dniTrabajador) REFERENCES trabajador(dni);

ALTER TABLE pieza
ADD CONSTRAINT fk_pieza_categoria FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria);

ALTER TABLE coche
ADD CONSTRAINT fk_coche_trabajador FOREIGN KEY (dniTrabajador) REFERENCES trabajador(dni),
ADD CONSTRAINT fk_coche_cliente FOREIGN KEY (dniCliente) REFERENCES cliente(dni);

ALTER TABLE factura
ADD CONSTRAINT fk_factura_trabajador FOREIGN KEY (idTrabajador) REFERENCES trabajador(dni),
ADD CONSTRAINT fk_factura_cliente FOREIGN KEY (idCliente) REFERENCES cliente(dni);
