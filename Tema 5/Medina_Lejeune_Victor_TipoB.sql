--EJERCICIO1
SELECT c1.*
FROM comprador c1 JOIN operacion USING(id_cliente)
	JOIN inmueble USING(id_inmueble)
WHERE tipo_operacion = 'Alquiler'
	AND provincia IN ('Almería', 'Granada')
	AND id_cliente = ALL(SELECT id_cliente
						FROM comprador c2 JOIN operacion USING(id_cliente)
							JOIN inmueble USING(id_inmueble)
						WHERE tipo_operacion = 'Alquiler'
							AND provincia IN ('Almería', 'Granada')
						 	AND c1.id_cliente = c2.id_cliente
						);
--EJERCICIO3



SELECT i.*
FROM inmueble i LEFT JOIN operacion USING (id_inmueble)
WHERE tipo_operacion = 'Venta'
	AND fecha_operacion IS NULL
	AND precio < ALL(SELECT AVG(precio_final)
					FROM inmueble JOIN operacion USING (id_inmueble)
					WHERE tipo_operacion = 'Venta'
					);
					
--EJERCICIO5
SELECT EXTRACT(year from fecha_operacion) AS "año", EXTRACT(month from fecha_operacion) AS "mes",
		ROUND(AVG(precio_final), 2) AS "precio_medio" ,ROUND(AVG(precio_final/superficie),2) AS "precio_medio_supfc"
FROM inmueble i JOIN operacion USING (id_inmueble)
WHERE tipo_operacion = 'Alquiler'
GROUP BY mes,año
ORDER BY año, mes;


--EJERCICIO6
SELECT v.nombre, provincia, SUM(precio_final), COUNT(*)
FROM vendedor v JOIN operacion USING(id_vendedor)
	JOIN inmueble i1 USING(id_inmueble)
GROUP BY v.nombre, provincia
HAVING SUM(precio_final)> ALL(SELECT SUM(precio_final)
								FROM vendedor JOIN operacion USING(id_vendedor)
									JOIN inmueble i2 USING(id_inmueble)
							  WHERE i1.provincia = i2.provincia
							 );

