-- BASE DE DADES UNIVERSIDAD

-- 1
SELECT nombre, apellido1, apellido2, tipo FROM persona WHERE tipo="alumno";
-- 2
SELECT nombre, apellido1, apellido2 FROM persona WHERE telefono IS NULL and tipo="alumno";
-- 3
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo="alumno" AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-30';
-- 4
SELECT nombre, apellido1, apellido2 FROM persona WHERE nif REGEXP "K" AND tipo="profesor" AND telefono IS NULL;
-- 5
SELECT nombre from asignatura where cuatrimestre=1 AND curso=3 AND id_grado=7;
-- 6
SELECT p.nombre,d.nombre FROM persona p JOIN profesor pr JOIN departamento d ON p.id=pr.id_profesor AND pr.id_departamento=d.id;
-- 7
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM asignatura a JOIN alumno_se_matricula_asignatura al JOIN curso_escolar ce JOIN persona p ON a.id=al.id_asignatura AND ce.id=al.id_curso_escolar AND al.id_alumno=p.id WHERE p.nif="26902806M";
-- 8 
SELECT d.nombre FROM departamento d JOIN profesor pr JOIN asignatura a JOIN grado g ON d.id=pr.id_departamento AND pr.id_profesor=a.id_profesor AND a.id_grado=g.id WHERE g.nombre="Grado en Ingeniería Informática (Plan 2015)" GROUP BY g.nombre;
-- 9 
SELECT p.nombre FROM persona p JOIN alumno_se_matricula_asignatura al JOIN curso_escolar c ON p.id=al.id_alumno AND al.id_curso_escolar=c.id WHERE c.anyo_inicio=2018 AND c.anyo_fin=2019 GROUP BY p.nombre;

-- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1 
SELECT d.nombre AS "departamento", p.nombre, p.apellido1, p.apellido2 FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN departamento d ON d.id=pr.id_departamento WHERE p.tipo="profesor" ORDER BY departamento DESC, p.apellido1, p.apellido2, p.nombre;
-- 2
SELECT p.nombre FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor WHERE pr.id_departamento NOT IN (SELECT id FROM departamento);
-- 3
SELECT d.nombre, pr.id_profesor FROM departamento d LEFT JOIN profesor pr ON d.id=pr.id_departamento WHERE d.id NOT IN (SELECT id_departamento FROM profesor);
-- 4
SELECT p.nombre, a.nombre AS "asignatura" FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor=a.id_profesor WHERE p.tipo="profesor" AND a.id_profesor IS NULL;
-- 5 
SELECT a.nombre, p.id_profesor FROM asignatura a LEFT JOIN profesor p ON p.id_profesor=a.id_profesor WHERE a.id_profesor IS NULL;
-- 6
SELECT DISTINCT d.nombre FROM departamento d LEFT JOIN profesor p ON d.id=p.id_departamento LEFT JOIN asignatura a ON p.id_profesor=a.id_profesor WHERE a.id_profesor IS NULL;

-- Consultes resum:

-- 1
SELECT count(nombre) AS "Alumnos" from persona where tipo="alumno";
-- 2
SELECT count(nombre) AS "Alumnos" from persona where tipo="alumno" AND fecha_nacimiento BETWEEN "1999-01-01" AND "1999-12-30";
-- 3
SELECT d.nombre, count(p.id_profesor) AS 'cantidad profesores' FROM departamento d JOIN profesor p ON p.id_departamento=d.id GROUP BY p.id_departamento ORDER BY 'cantidad profesores' ASC;
-- 4
SELECT d.nombre, count(pr.id_profesor) FROM departamento d LEFT JOIN profesor pr ON pr.id_departamento=d.id GROUP BY d.id;
-- 5
SELECT g.nombre, count(a.id) AS "numero asignaturas" FROM grado g LEFT JOIN asignatura a ON g.id=a.id_grado GROUP BY g.id ORDER BY a.id DESC;
-- 6
SELECT g.nombre, count(a.id) AS "numero asignaturas" FROM grado g JOIN asignatura a ON g.id=a.id_grado GROUP BY g.id HAVING count(a.id) > 40;
-- 7
SELECT g.nombre, a.tipo, count(a.creditos)*a.creditos AS "creditos totales" FROM grado g JOIN asignatura a ON g.id=a.id_grado GROUP BY g.id;
-- 8 ?
SELECT ce.anyo_inicio, count(al.id_alumno) as "alumnes" FROM curso_escolar ce JOIN alumno_se_matricula_asignatura al ON ce.id=al.id_curso_escolar GROUP BY ce.id;
-- 9
SELECT p.id, p.nombre, p.apellido1, p.apellido2, count(a.id) AS "num asignaturas" FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor=a.id_profesor WHERE p.tipo="profesor" GROUP BY p.id ORDER BY a.id DESC;
-- 10
SELECT * FROM persona WHERE fecha_nacimiento IN (SELECT min(fecha_nacimiento) from persona WHERE tipo="alumno");
-- 11
SELECT p.nombre FROM persona p JOIN profesor pr ON p.id=pr.id_profesor JOIN departamento d ON d.id=pr.id_departamento LEFT JOIN asignatura a ON pr.id_profesor=a.id_profesor GROUP by p.nombre HAVING count(a.id_profesor) = 0;