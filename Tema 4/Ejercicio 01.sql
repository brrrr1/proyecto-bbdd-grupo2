--Seleccionar el nombre, apellidos y email de los empleados que pertenecen a un departamento que tenga sede en United Kingdom.

SELECT first_name, last_name, email
FROM countries c JOIN locations l USING (country_id)
	JOIN departments d ON (l.location_id = d.location_id)
	JOIN employees e ON (d.department_id = e.department_id)
WHERE country_id = 'UK';

--Seleccionar el nombre de aquellos departamentos en los que trabaja un empleado que fue contratado a lo largo del año 1993.
/*SE PONE UN DISTINCT PARA LAS COSAS QUE SE PUEDEN REPETIR NO SE REPITAN*/

SELECT DISTINCT department_name
FROM departments d JOIN employees e USING(department_id)
WHERE LEFT(hire_date::text,4) = '1993';

--Seleccionar la región de los empleados con un salario inferior a 10000$
SELECT DISTINCT region_name
FROM regions r JOIN countries c USING(region_id)
 JOIN locations l USING(country_id)
 JOIN departments d USING(location_id)
 JOIN employees e USING(department_id)
WHERE salary < 10000;
 
--Seleccionar el nombre de aquellos empleados cuyo jefe directo tenga un apellido que empiece por D, H o S.

SELECT e.first_name, e.last_name
FROM employees e JOIN employees j ON (e.manager_id = j.employee_id)
WHERE LEFT(j.last_name::text,1) IN('D','H','S');

--Seleccionar el número de familiares (dependents) que son hijos de algún miembro de los departamentos de Marketing, Administration e IT.

SELECT COUNT(*)
FROM employees e JOIN dependents d USING(employee_id)
	JOIN departments dd USING (department_id)
WHERE department_name IN('Marketing','Administration','IT')
 AND relationship = 'Child';