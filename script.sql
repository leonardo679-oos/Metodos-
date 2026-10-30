
-- Limpieza previa si ya existían
DROP TABLE IF EXISTS calificaciones;
DROP TABLE IF EXISTS materias;
DROP TABLE IF EXISTS alumnos;

-- 1. Crear tabla de Alumnos (100 registros)
CREATE TABLE alumnos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    numero_control VARCHAR(20) UNIQUE NOT NULL
);

-- 2. Crear tabla de Materias
CREATE TABLE materias (
    id SERIAL PRIMARY KEY,
    nombre_materia VARCHAR(100) NOT NULL,
    semestre INT NOT NULL
);

-- 3. Crear tabla de Calificaciones (Relación Alumnos <-> Materias)
CREATE TABLE calificaciones (
    id SERIAL PRIMARY KEY,
    alumno_id INT REFERENCES alumnos(id) ON DELETE CASCADE,
    materia_id INT REFERENCES materias(id) ON DELETE CASCADE,
    calificacion NUMERIC(5, 2) CHECK (calificacion >= 0 AND calificacion <= 100),
    CONSTRAINT un_alumno_materia UNIQUE (alumno_id, materia_id)
);

-- =========================================================================
-- Inserción de Datos Automáticos
-- =========================================================================

-- Poblar 100 alumnos usando un truco con generate_series
INSERT INTO alumnos (nombre, apellido, numero_control)
SELECT 
    (ARRAY['Carlos', 'María', 'Alejandro', 'Ana', 'Luis', 'Sofía', 'José', 'Diana', 'Fernando', 'Valeria', 'Jorge', 'Gabriela', 'Ricardo', 'Carmen', 'Daniel'])[floor(random() * 15 + 1)] AS nombre,
    (ARRAY['Gómez', 'Pérez', 'Rodríguez', 'Torres', 'Martínez', 'Hernández', 'López', 'González', 'Ramírez', 'Cruz', 'Flores', 'Morales', 'Jiménez', 'Reyes', 'Ruiz'])[floor(random() * 15 + 1)] AS apellido,
    'CTRL-' || lpad(i::text, 4, '0') AS numero_control
FROM generate_series(1, 100) AS i;

-- Poblar Materias de ejemplo
INSERT INTO materias (nombre_materia, semestre) VALUES
('Sistemas Operativos', 4),
('Seguridad Informática', 6),
('Programación Web', 5),
('Bases de Datos', 3),
('Inteligencia Artificial', 7);

-- Asignar calificaciones aleatorias (entre 60 y 100) a los 100 alumnos en cada materia
INSERT INTO calificaciones (alumno_id, materia_id, calificacion)
SELECT 
    a.id AS alumno_id,
    m.id AS materia_id,
    round((random() * 40 + 60)::numeric, 2) AS calificacion -- Notas de 60.00 a 100.00
FROM alumnos a
CROSS JOIN materias m;
