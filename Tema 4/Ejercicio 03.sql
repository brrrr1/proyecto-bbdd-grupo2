--Selecciona los datos del inmueble sobre el que se ha realizado una operación un lunes de
--febrero o un viernes de marzo, que tenga más de 200 metros cuadrados y donde
--el nombre del vendedor contenga una A mayúscula o minúscula.

SELECT DISTINCT i.*
FROM inmueble i JOIN operacion o USING (id_inmueble)
 JOIN vendedor v USING (id_vendedor)
WHERE superficie > 200
 AND v.nombre ILIKE '%a%'
 AND TO_CHAR(fecha_operacion, 'ID-MM') IN ('1-02', '5-03');

--Selecciona el precio medio por metro cuadrado de los alquileres de viviendas en los meses de marzo
--y abril de cualquier año para las provincias costeras de Andalucía.

SELECT ROUND((AVG (precio/superficie)),2) AS"precio_medio"
FROM inmueble JOIN tipo ON (tipo_inmueble = id_tipo)
WHERE DATE_PART('month',fecha_alta) IN (3,4)
 AND provincia IN('Huelva', 'Cádiz', 'Málaga', 'Granada', 'Almería')
 AND tipo_operacion = 'Alquiler'
 AND nombre IN ('Casa', 'Piso');

--¿Cuál es la media del porcentaje de diferencia entre el precio inicial (en la tabla inmueble) y 
--el precio final (en la tabla operación) para aquellas operaciones de alquiler realizadas en enero
--de cualquier año, donde el tipo del inmueble es Oficina, Local o Suelo?

SELECT ROUND(AVG(((i.precio-o.precio_final)*100)/precio),2) AS "media_porcentaje_diferencia"
FROM tipo t JOIN inmueble i ON (id_tipo=tipo_inmueble)
  JOIN operacion o USING (id_inmueble)
WHERE tipo_operacion = 'Alquiler'
 AND date_part('Month', o.fecha_operacion) = (1)
 AND t.nombre IN ('Oficina', 'Local', 'Suelo');

--Seleccionar el nombre de aquellos compradores de Casa o Piso en las provincias de Jaén
--o Córdoba, donde el precio final de inmueble esté entre 150.000 y 200.000€,
--para aquellos inmuebles que han tardado entre 3 y 4 meses en venderse.

SELECT c.nombre
FROM inmueble i JOIN operacion o USING (id_inmueble)
    JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
	JOIN comprador c USING(id_cliente)
WHERE t.nombre IN ('Casa', 'Piso')
  AND tipo_operacion = 'Venta'
  AND i.provincia IN ('Jaén', 'Córdoba')
  AND o.precio_final BETWEEN 150000 AND 200000
  AND AGE(fecha_operacion, fecha_alta) 
	   BETWEEN '3 mon'::interval and '4 mon'::interval;

--Selecciona la media del precio inicial (en la tabla inmueble), del precio final 
--(en la tabla operación) y de la diferencia en porcentaje entre ellas de aquellas viviendas
--(Casa o Piso) en alquiler que tengan menos de 100 metros cuadrados y que hayan tardado un año o más en alquilarse.

SELECT AVG (i.precio) AS "media_precio_inicial",
  AVG (o.precio_final) AS "media_precio_final",
  AVG ((i.precio / o.precio_final)*100) AS "porcentaje_precio"
FROM inmueble i JOIN operacion o USING (id_inmueble)
    JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE t.nombre IN ('Casa', 'Piso')
 AND tipo_operacion = 'Alquiler'
 AND i.superficie < 100
 AND AGE(fecha_operacion, fecha_alta) >= '1 year';

--Selecciona el alquiler de vivienda (Casa o Piso) más caro realizado en Julio o Agosto de cualquier año en la provincia de Huelva.

SELECT MAX(precio_final)
FROM inmueble i JOIN operacion o USING (id_inmueble)
    JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE (t.id_tipo = '1' OR t.id_tipo = '5')
  AND (date_part('Month', o.fecha_operacion) IN (7,8))
  AND tipo_operacion = 'Alquiler'
  AND provincia = 'Huelva';
