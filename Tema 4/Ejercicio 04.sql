--Seleccionar el COMPANY_NAME y CONTACT_NAME de aquellos CUSTOMERS que hayan hecho pedidos (ORDERS).

SELECT DISTINCT company_name, contact_name
FROM customers JOIN orders USING(customer_id);

--Seleccionar el número de pedidos que hemos enviado en la década de los 90 con las empresas Federal Shipping o United Package.

SELECT COUNT(order_id)
FROM orders JOIN shippers ON(ship_via = shipper_id)
WHERE EXTRACT(year from shipped_date) BETWEEN 1990 AND 2000
	AND company_name IN('Federal Shipping','United Package');
 
--Seleccionar el nombre de aquellos productos que han sido solicitados en algún pedido.

SELECT DISTINCT product_name
FROM order_details JOIN products USING(product_id);

--Seleccionar la suma de los importes "cobrados" en todos los pedidos realizados en el año 96.

SELECT SUM(unit_price * quantity * (1-discount))
FROM order_details JOIN orders USING(order_id)
WHERE EXTRACT(year from order_date) = 1996;

--Seleccionar el nombre de contacto del cliente y el del empleado para aquellos clientes y 
--empleados que han participado en pedidos donde la diferencia entre
--la fecha de envío y la fecha de requisito sea menos de 20 días

SELECT DISTINCT contact_name, first_name
FROM customers JOIN orders USING(customer_id)
    JOIN employees USING(employee_id)
WHERE AGE(required_date,shipped_date) BETWEEN
	-('19 day'::interval) AND ('19 day'::interval);