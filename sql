
CREATE DATABASE conectados_seguros2;
USE conectados_seguros2;

CREATE TABLE usuarios2 (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    gmail VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'usuario') DEFAULT 'usuario',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE categorias_ciberdelitos (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);


CREATE TABLE ciberdelitos_info (
    id_ciberdelito INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    recomendaciones TEXT,
    FOREIGN KEY (id_categoria) REFERENCES categorias_ciberdelitos(id_categoria)
);


CREATE TABLE recursos (
    id_recurso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    tipo ENUM('articulo', 'video', 'tutorial') NOT NULL,
    url VARCHAR(255) NOT NULL,
    autor VARCHAR(100),
    fecha_publicacion DATE,
    UNIQUE(url)
);


CREATE TABLE foros_temas (
    id_tema INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios2(id_usuario)
);


CREATE TABLE foros_respuestas (
    id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
    id_tema INT NOT NULL,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_respuesta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tema) REFERENCES foros_temas(id_tema),
    FOREIGN KEY (id_usuario) REFERENCES usuarios2(id_usuario)
);


CREATE INDEX idx_tema_usuario ON foros_temas(id_usuario);
CREATE INDEX idx_respuesta_usuario ON foros_respuestas(id_usuario);
CREATE INDEX idx_categoria ON ciberdelitos_info(id_categoria);


INSERT INTO usuarios2 (nombre, gmail, password_hash, rol) VALUES
('Álvaro Gómez', 'alvaro@gmail.com', 'hash1', 'usuario'),
('Anaya Torres', 'anaya@gmail.com', 'hash2', 'admin'),
('Chacón Díaz', 'chacon@gmail.com', 'hash3', 'usuario'),
('Ledesma Ruiz', 'ledesma@gmail.com', 'hash4', 'usuario'),
('Parejo Fernández', 'parejo@gmail.com', 'hash5', 'usuario');


INSERT INTO categorias_ciberdelitos (nombre, descripcion) VALUES
('Phishing', 'Engaños para obtener información personal.'),
('Ransomware', 'Malware que encripta archivos para pedir rescate.'),
('Ingeniería Social', 'Manipulación psicológica para engañar a las personas.');


INSERT INTO ciberdelitos_info (id_categoria, titulo, descripcion, recomendaciones) VALUES
(1, 'Correos bancarios falsos', 'Intentos de robo de contraseñas.', 'Verificar el remitente.'),
(1, 'Phishing en redes sociales', 'Cuentas falsas piden datos.', 'Activar autenticación en dos pasos.'),
(2, 'Ransomware básico', 'Encripta archivos del usuario.', 'Hacer backups frecuentes.'),
(3, 'Llamadas de soporte falsas', 'Buscan acceder a tu computadora.', 'Nunca dar control remoto.'),
(3, 'Sorteos falsos', 'Promesas de premios falsos.', 'Desconfiar de mensajes sospechosos.');


INSERT INTO recursos (titulo, tipo, url, autor, fecha_publicacion) VALUES
('Guía para evitar phishing', 'articulo', 'https://recurso1.com', 'Álvaro Gómez', '2024-01-10'),
('Cómo protegerse del ransomware', 'tutorial', 'https://recurso2.com', 'Anaya Torres', '2023-12-02'),
('Curso básico de ciberseguridad', 'video', 'https://recurso3.com', 'Chacón Díaz', '2023-09-14'),
('Tips de seguridad en redes sociales', 'articulo', 'https://recurso4.com', 'Ledesma Ruiz', '2024-02-01'),
('Seguridad informática para todos', 'tutorial', 'https://recurso5.com', 'Parejo Fernández', '2024-03-11');


INSERT INTO foros_temas (id_usuario, titulo, contenido) VALUES
(1, '¿Cómo reconocer un phishing?', 'Me llegó un correo raro, ¿cómo saber si es falso?'),
(2, 'Ransomware en negocios pequeños', 'Consejos para evitar ataques.'),
(3, 'Perfiles falsos en redes', 'Crearon una cuenta falsa con mi nombre.'),
(4, 'Buenas prácticas de seguridad informática', '¿Qué recomiendan para empezar?'),
(5, 'Estafa por WhatsApp', 'Me pidieron un código ¿es falso?');


INSERT INTO foros_respuestas (id_tema, id_usuario, contenido) VALUES
(1, 2, 'No abras enlaces desconocidos.'),
(1, 3, 'Fijate en el dominio del correo.'),
(2, 5, 'Hace backups regularmente.'),
(3, 1, 'Reportá el perfil falso.'),
(4, 4, 'Usá contraseñas fuertes.');
