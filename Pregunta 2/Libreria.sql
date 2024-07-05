CREATE DATABASE libreria;

CREATE TABLE Autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    nacionalidad VARCHAR(100)
);


CREATE TABLE Categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);


CREATE TABLE Libros (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    autor_id INT,
    categoria_id INT,
    precio DECIMAL(10, 2),
    FOREIGN KEY (autor_id) REFERENCES Autores(id_autor),
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id_categoria)
);



-- 1. Insertar datos en la tabla Autores
INSERT INTO Autores (id_autor, nombre, nacionalidad) VALUES
(1, 'Gabriel García Márquez', 'Colombiana'),
(2, 'J.K. Rowling', 'Británica'),
(3, 'Stephen King', 'Estadounidense');

-- Insertar datos en la tabla Categorias
INSERT INTO Categorias (id_categoria, nombre) VALUES
(1, 'Ficción'),
(2, 'Fantasía'),
(3, 'Terror');

-- Insertar datos en la tabla Libros

INSERT INTO Libros (id_libro, titulo, autor_id, categoria_id, precio) VALUES
(1, 'Cien años de soledad', 1, 1, 8900.00),
(2, 'Harry Potter y la piedra filosofal', 2, 1, 10180.00),
(3, 'It', 3, 3,  17000.00),
(4, 'El amor en los tiempos del cólera', 1, 1, 1300.00),
(5, 'El resplandor', 3, 3, 14090.00);


-- 1. Seleccionar el título y el nombre del autor de todos los libros de la categoría "Ficción":

SELECT Libros.titulo, Autores.nombre
FROM Libros
JOIN Autores ON Libros.autor_id = Autores.id_autor
JOIN Categorias ON Libros.categoria_id = Categorias.id_categoria
WHERE Categorias.nombre = 'Ficción';


-- 2. Calcular el precio promedio de todos los libros en la tabla Libros:


SELECT AVG(precio) AS precio_promedio FROM Libros;


-- 3. Actualizar el precio de todos los libros escritos por el autor con id_autor = 5 en un 10% de descuento 
-- (considerando que los autores de los libros en los datos de ejemplo tienen ids diferentes):


UPDATE Libros SET precio = precio * 0.90 WHERE autor_id = 5;