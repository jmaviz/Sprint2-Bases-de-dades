-- BASE DE DADES TIENDA

-- 1 
SELECT nombre FROM producto;
-- 2
SELECT nombre, precio FROM producto;
-- 3 
SELECT * from producto;
-- 4
SELECT nombre, precio*1.17, precio FROM producto;
-- 5
SELECT nombre AS 'nom de producto', precio AS euros, precio * 1.17 AS dolarss
-- 6
SELECT upper(nombre), precio FROM producto;
-- 7
SELECT lower(nombre), precio FROM producto;
-- 8
SELECT nombre, upper(left(nombre, 2)) FROM fabricante;
-- 9
SELECT nombre, round(precio) FROM producto;
-- 10
SELECT nombre, truncate(precio,0) FROM producto;
-- 11
SELECT codigo_fabricante FROM fabricante f, producto p WHERE f.codigo = p.codigo_fabricante;
-- 12
SELECT DISTINCT codigo_fabricante FROM fabricante f, producto p WHERE f.codigo = p.codigo_fabricante;
-- 13
SELECT nombre FROM fabricante ORDER BY nombre ASC;
-- 14
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- 15
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
-- 16
SELECT * FROM fabricante LIMIT 5;
-- 17
SELECT * FROM fabricante LIMIT 3, 2;
-- 18
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
-- 19 
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- 20
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
-- 21
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN  fabricante f ON p.codigo_fabricante = f.codigo;
-- 22
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN  fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre ASC;
-- 23
SELECT p.codigo, p.nombre, f.codigo, f.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante;
-- 24
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE p.precio = (SELECT min(precio) FROM producto);
-- 25
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE p.precio = (SELECT max(precio) FROM producto);
-- 26
SELECT p.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre= (SELECT nombre FROM fabricante WHERE nombre="Lenovo");
-- 27
SELECT p.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre= (SELECT nombre FROM fabricante WHERE nombre="Crucial" AND precio > 200);
-- 28
SELECT p.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre REGEXP "Seagate|Asus|Hewlett-Packard";
-- 29
SELECT p.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre IN (SELECT nombre FROM fabricante WHERE nombre REGEXP "Seagate|Asus|Hewlett-Packard");
-- 30
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre REGEXP "e$";
-- 31
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre REGEXP "w";
-- 32
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre ASC;
-- 33 ?
SELECT DISTINCT f.codigo, f.nombre FROM producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante;
-- 34
SELECT f.codigo, f.nombre, p.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo=p.codigo_fabricante;
-- 35
SELECT f.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo=p.codigo_fabricante WHERE p.nombre IS NULL;
-- 36
SELECT p.nombre FROM fabricante f, producto p WHERE f.codigo=p.codigo_fabricante AND f.nombre LIKE "Lenovo";
-- 37 ?
SELECT * from producto p, fabricante f WHERE f.codigo=p.codigo_fabricante AND p.precio = (SELECT max(p.precio) FROM producto p, fabricante f WHERE f.nombre="Lenovo");
-- 38
SELECT p.nombre FROM fabricante f JOIN producto p ON f.codigo=p.codigo_fabricante WHERE p.precio = (SELECT max(p.precio) FROM fabricante j JOIN producto p ON f.codigo=p.codigo_fabricante WHERE f.nombre="Lenovo");
-- 39
SELECT p.nombre FROM fabricante f JOIN producto p ON f.codigo=p.codigo_fabricante WHERE p.precio = (SELECT min(p.precio) FROM fabricante j JOIN producto p ON f.codigo=p.codigo_fabricante WHERE f.nombre="Hewlett-Packard");
-- 40
SELECT p.nombre from producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE p.precio >= (SELECT max(p.precio) FROM producto p join fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre="Lenovo");
-- 41
SELECT p.nombre, p.precio from producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE p.precio > (select avg(precio) from producto p JOIN fabricante f ON f.codigo=p.codigo_fabricante WHERE f.nombre="Asus");