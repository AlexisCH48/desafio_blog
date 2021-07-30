DROP DATABASE blog;

CREATE DATABASE blog;
\c blog;

CREATE TABLE usuario(
    id INT PRIMARY KEY,
    email VARCHAR(100)
);

CREATE TABLE post(
    id INT PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR(100),
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE comentario(
    id INT PRIMARY KEY,
    usuario_id INT,
    post_id INT,
    texto VARCHAR(150),
    fecha DATE,
    FOREIGN key(post_id) REFERENCES post(id),
    FOREIGN KEY(usuario_id) REFERENCES usuario(id)
);

\COPY usuario FROM 'usuarios.csv' CSV;
\COPY post FROM 'posts.csv' CSV;
\COPY comentario FROM 'comentarios.csv' CSV;

--4°
SELECT us.email, pst.id, pst.titulo FROM usuario AS us LEFT JOIN post AS pst ON us.id = pst.usuario_id WHERE us.id = 5;

--RESPUESTA ALTERNATIVA
--SELECT us.id, us.email, pst.titulo FROM(SELECT * FROM post WHERE usuario_id = 5) AS pst INNER JOIN usuario AS us ON pst.usuario_id = us.id;

--SELECT usuario.id, usuario.email, post.titulo FROM usuario INNER JOIN Post ON usuario.id = post.usuario_id WHERE usuario.id = 5;

--5°
SELECT us.email, com.id, com.texto FROM comentario AS com FULL OUTER JOIN usuario AS us ON com.usuario_id = us.id WHERE us.email <> 'usuario06@hotmail.com' AND com.id IS NOT NULL;

--6°
SELECT us.email FROM usuario AS us LEFT JOIN post AS pst ON us.id = pst.usuario_id WHERE pst.id IS NULL;

--RESPUESTA ALTERNATIVA
--SELECT email AS usuarios FROM usuario AS u WHERE u.id NOT IN (SELECT usuario_id FROM post);

--SELECT usuario.id FROM POST FULL OUTER JOIN USUARIO ON usuario.id=post.usuario_id WHERE titulo IS NULL;

--7°
SELECT * FROM post AS pst FULL OUTER JOIN comentario AS com ON pst.id = com.post_id;

--8°
SELECT DISTINCT(us.email) FROM usuario AS us LEFT JOIN post AS pst ON us.id = pst.usuario_id WHERE EXTRACT(MONTH FROM pst.fecha) = 6;

--RESPUESTA ALTERNATIVA
--SELECT DISTINCT(usuario.email) FROM usuario LEFT JOIN post ON usuario.id = post.usuario_id WHERE fecha BETWEEN '2020-05-31' AND '2020-07-01';