--EJERCICIO 1
--Seleccionar el FIRST_NAME y LAST_NAME de los empleados del departamento de IT o Finance cuya fecha de alta (HIRE_DATE) fuera un día cualquiera de Abril o Junio.

SELECT e.first_name , e.last_name
FROM employees e JOIN departments d USING(department_id)
WHERE (department_name = ('IT')
 OR department_name = ('Finance'))
 AND (hire_date::text LIKE ('%-04-%')
 OR hire_date::text LIKE ('%-06-%'));

--EJERCICIO 2
--Seleccionar el FIRST_NAME y LAST_NAME de los managers de los empleados del departamento de Administration.

SELECT DISTINCT m.first_name, m.last_name
FROM employees m JOIN employees e ON (m.employee_id=e.manager_id)
	JOIN departments d ON(e.department_id = d.department_id)
WHERE department_name = 'Administration';

--EJERCICIO 3
--Seleccionar el COUNTRY_NAME donde tiene localización el departamento de Public Relations

SELECT country_name
FROM countries c JOIN locations l USING(country_id)
	JOIN departments USING(location_id)
WHERE department_name = 'Public Relations';
--EJERCICIO 4
--Seleccionar aquellos empleados que trabajen en oficinas de América.

SELECT first_name , last_name
FROM countries c JOIN locations l USING(country_id)
	JOIN departments d USING(location_id)
	JOIN employees e USING(department_id)
	JOIN regions USING(region_id)
WHERE region_name = 'Americas';

--EJERCICIO 5
--Seleccionar el nombre y apellidos de los hijos, así como el nombre y apellidos de sus padres, para aquellos
--empleados que trabajen en oficinas de América.
--Ordena la salida por orden alfabético del país :)

 

--EJERCICIO 6
--Diseña una consulta (incluyendo su solución) para la base de datos HR que contenga los siguientes elementos.
--La salida del select no será SELECT *
--Debe realizar el JOIN de al menos 3 tablas.
--Uno de los JOINs debe, obligatoriamente, ser un JOIN ON
--Al menos, tendrá dos condiciones en el WHERE (conectadas con AND u OR)
--Debe ordenar la salida por algún criterio.

--Poner los nombres de los manager que tengan departamentos en Europa y que pertenezcan a Human Resources o Public Relations
SELECT DISTINCT m.first_name , m.last_name
FROM employees e JOIN departments USING(department_id)
 JOIN locations USING(location_id)
 JOIN countries USING(country_id)
 JOIN employees m ON(m.manager_id  = e.manager_id)
WHERE country_id IN ('UK','DE')
 AND department_name = 'Human Resources'
 OR department_name = 'Public Relations';
