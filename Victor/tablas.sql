DROP TABLE IF EXISTS trabajador,lineaVenta,pieza,coche,categoria,proovedor,factura,cliente;

CREATE TABLE trabajador(
	dni					
	nombre				
	apellidos
	fechaAlta
	fechaBaja
	sueldoBase
	departamento
);
CREATE TABLE lineaVenta(
	codFactura
	codPieza
	cantidad
	pvpUnitario
	pvpvTotal
);
CREATE TABLE pieza(
	id
	nombre
	descripcion
);
CREATE TABLE coche(
	numBastidor
	matricula
	marca
	modelo
	anyoPrimeraMatriculacion
);
CREATE TABLE categoria(
	idCategoria
	nombre
	descripcion
);
CREATE TABLE proovedor(
	cifEmpresa
	descripcion
	tipoRespuestos
	nombre
);
CREATE TABLE factura(
	codFactura
	fechaEmision
	fechaInicio
	idTrabajador
	idCliente
	codLineaVenta
	descuento
	subTotalSinIVA
	IVA
	cantidadDescontadaSubTotalSinIVA
	totalFactura
);
CREATE TABLE cliente(
	dni
	nombre
	apellidos
	numTelefono
	direccion
	correo
	clienteEmpresa
);




