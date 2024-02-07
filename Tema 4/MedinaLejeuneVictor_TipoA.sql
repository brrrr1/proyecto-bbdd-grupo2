--EJERCICIO 1
SELECT c.nombre
FROM tipo t JOIN inmueble i ON (id_tipo = tipo_inmueble)
	JOIN operacion USING(id_inmueble)
	JOIN comprador c USING(id_cliente)
WHERE tipo_operacion = 'Alquiler'
	AND provincia IN ('Sevilla', 'Jaén', 'Córdoba')
	AND t.nombre = 'Piso'
	AND superficie > 100
	AND (EXTRACT(isodow from fecha_operacion) = 2
	AND EXTRACT(month from fecha_operacion) = 9
	OR EXTRACT(isodow from fecha_operacion) = 1
	AND EXTRACT(month from fecha_operacion) = 10);
--EJERCICIO 2
SELECT AVG(precio_final)
FROM tipo t JOIN inmueble i ON (id_tipo = tipo_inmueble)
	JOIN operacion USING(id_inmueble)
WHERE tipo_operacion = 'Venta'
	AND provincia = 'Jaén'
	OR provincia = 'Granada'
	AND AGE(fecha_operacion, fecha_alta) < '3 month'::interval;
--EJERCICIO 3
SELECT i.*
FROM tipo t JOIN inmueble i ON (id_tipo = tipo_inmueble)
	 LEFT JOIN operacion USING(id_inmueble)
WHERE tipo_operacion = 'Alquiler'
	AND AGE(fecha_alta, CURRENT_DATE) > '6month'::interval
	AND precio_final IS NULL;

--EJERCICIO 4
SELECT *
FROM tipo t JOIN inmueble i ON (id_tipo = tipo_inmueble)
	 JOIN operacion USING(id_inmueble)
	 JOIN comprador USING (id_cliente)
WHERE tipo_operacion = 'Alquiler'
	AND EXTRACT(isodow from fecha_operacion) IN(1,2,3,4,5)
	AND (EXTRACT(day from fecha_operacion) = 21
		AND EXTRACT(month from fecha_operacion) = 3)
	AND
		(EXTRACT(day from fecha_operacion) = 20
		AND EXTRACT(month from fecha_operacion) = 6);
--EJERCICIO 5
SELECT c.*, v.*,o.*, t.*
FROM tipo t JOIN inmueble i ON (id_tipo = tipo_inmueble)
	 JOIN operacion o USING(id_inmueble)
	 JOIN comprador c USING(id_cliente)
	 JOIN vendedor v USING (id_vendedor)
WHERE t.nombre NOT IN ('Piso','Casa') 
	AND tipo_operacion IN('Venta','Alquiler') 
	AND (fecha_alta::date - fecha_contratacion::date) > 90;