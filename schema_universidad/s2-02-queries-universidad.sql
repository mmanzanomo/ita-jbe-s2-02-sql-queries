SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre ASC;
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%k';
SELECT * FROM asignatura WHERE id_grado = 7 AND curso = 3 AND cuatrimestre = 1;
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre FROM profesor pr INNER JOIN persona p ON pr.id_profesor = p.id LEFT JOIN departamento d ON pr.id_departamento = d.id ORDER BY p.apellido1, p.apellido2, p.nombre DESC;
SELECT a.nombre, c.anyo_inicio, anyo_fin FROM asignatura a INNER JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura INNER JOIN curso_escolar c ON am.id_curso_escolar = c.id WHERE am.id_alumno = (SELECT id FROM persona WHERE nif = '26902806M');
SELECT DISTINCT d.nombre FROM departamento d INNER JOIN profesor pr ON d.id = pr.id_departamento WHERE id_profesor IN (SELECT id_profesor FROM asignatura a INNER JOIN grado g ON a.id_grado = g.id WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)');
SELECT * FROM persona p WHERE p.id IN (SELECT am.id_alumno FROM alumno_se_matricula_asignatura am INNER JOIN curso_escolar c ON am.id_curso_escolar = c.id WHERE c.anyo_inicio = '2018' AND c.anyo_fin = '2019');
--
SELECT d.nombre, p.apellido1, p.apellido2, p.nombre FROM persona p RIGHT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre DESC;
SELECT p.nif, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor WHERE p.tipo = 'profesor' AND pr.id_profesor IS NULL;
SELECT d.id, d.nombre FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento WHERE pr.id_departamento IS NULL;
SELECT pr.id_profesor, p.apellido1, p.apellido2, p.nombre FROM profesor pr LEFT JOIN persona p ON pr.id_profesor = p.id LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor GROUP BY pr.id_profesor, p.nombre HAVING COUNT(a.id_profesor) = 0;
SELECT * FROM asignatura a LEFT JOIN profesor pr ON a.id_profesor = pr.id_profesor WHERE pr.id_profesor IS NULL;
SELECT d.nombre FROM asignatura a JOIN profesor p ON a.id_profesor = p.id_profesor RIGHT JOIN departamento d ON p.id_departamento = d.id GROUP BY d.nombre HAVING COUNT(p.id_departamento) = 0;



--
SELECT COUNT(id) AS total_alumnos FROM persona WHERE tipo = 'alumno';
SELECT COUNT(id) AS alumnos_nacidos_en_1999 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
SELECT d.nombre AS nombre_departamento, COUNT(pr.id_profesor) AS número_profesores FROM departamento d RIGHT JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre ORDER BY número_profesores DESC; 
SELECT d.nombre AS nombre_departamento, COUNT(pr.id_profesor) AS número_profesores FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre ORDER BY número_profesores DESC; 
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS número_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY número_asignaturas DESC;
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS número_asignaturas FROM grado g RIGHT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING número_asignaturas > 40 ORDER BY COUNT(a.id) DESC;
SELECT g.nombre AS grado, a.tipo, SUM(a.creditos) FROM grado g INNER JOIN asignatura a ON g.id = a.id_grado GROUP BY grado, a.tipo;
SELECT ce.anyo_inicio, COUNT(am.id_alumno) FROM alumno_se_matricula_asignatura am INNER JOIN curso_escolar ce ON am.id_curso_escolar = ce.id INNER JOIN asignatura a ON am.id_asignatura = a.id GROUP BY ce.anyo_inicio;
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id_profesor) as n_asignaturas FROM profesor pr INNER JOIN persona p ON pr.id_profesor = p.id LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor GROUP BY p.id, p.nombre, p.apellido1, p.apellido2, a.id_profesor ORDER BY n_asignaturas DESC;
SELECT * FROM persona p WHERE p.fecha_nacimiento = (SELECT MIN(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');
SELECT pr.id_profesor, pr.id_departamento FROM profesor pr WHERE pr.id_profesor NOT IN (SELECT id_profesor FROM asignatura GROUP BY id_profesor HAVING id_profesor IS NOT NULL);

