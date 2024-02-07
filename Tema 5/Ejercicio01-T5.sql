--Seleccionar el salario máximo de cada departamento, mostrando el nombre del departamento y dicha cantidad.

SELECT COALESCE(department_name, 'Sin departamento'), MAX(salary)
FROM departments RIGHT JOIN employees USING(department_id)
GROUP BY department_name;

--Seleccionar el salario mínimo de cada departamento, para aquellos departamentos cuyo salario mínimo sea menor que 5000$.

SELECT department_name, MIN(salary)
FROM departments JOIN employees USING(department_id)
GROUP BY department_name
HAVING MIN(salary) < 5000
ORDER BY department_name;

--Seleccionar el número de empleados que trabajan en cada oficina, mostrando el STREET_ADDRESS y dicho número; hay que ordenar la salida de mayor a menor.

SELECT street_address AS "calle", COUNT(e.*)
FROM departments JOIN employees e USING(department_id)
	JOIN locations USING(location_id)
GROUP BY calle
ORDER BY COUNT(e.*) DESC;

--Modificar la consulta anterior para que muestre las localizaciones que no tienen ningún empleado.

SELECT street_address AS "calle", COUNT(e.*)
FROM departments JOIN employees e USING(department_id)
	RIGHT JOIN locations USING(location_id)
GROUP BY calle
ORDER BY COUNT(e.*) DESC;

--Seleccionar el salario que es cobrado a la vez por más personas. Mostrar dicho salario y el número de personas.

SELECT salary, COUNT(*)
FROM employees
GROUP BY salary
ORDER BY COUNT(*)DESC;

--Seleccionar el número de empleados que empezaron a trabajar cada año, ordenando la salida por el año.

SELECT  EXTRACT(year from hire_date)AS"año", COUNT(*)
FROM employees 
GROUP BY año
ORDER BY año