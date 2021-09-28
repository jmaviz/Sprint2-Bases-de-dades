DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARSET utf8mb4;
USE youtube;

/* TAULES */

CREATE TABLE IF NOT EXISTS usuari(
id INT NOT NULL PRIMARY KEY,
mail VARCHAR(50) NOT NULL,
contrasenya VARCHAR(10) NOT NULL,
usuari VARCHAR(25) NOT NULL UNIQUE,
naixement date NOT NULL,
sexe ENUM('home','dona') NOT NULL,
pais VARCHAR(45) NOT NULL,
postal INT UNSIGNED NOT NULL);

CREATE TABLE IF NOT EXISTS canal(
id INT NOT NULL PRIMARY KEY,
id_usuari INT NOT NULL,
nom VARCHAR(25) NOT NULL UNIQUE,
descripcio VARCHAR(200),
data_creacio date NOT NULL,
FOREIGN KEY (id_usuari) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS usuari_suscriu_canal(
usuari_id INT NOT NULL,
canal_id INT NOT NULL,
PRIMARY KEY (usuari_id, canal_id),
FOREIGN KEY (usuari_id) REFERENCES usuari(id),
FOREIGN KEY (canal_id) REFERENCES canal(id));

CREATE TABLE IF NOT EXISTS video(
id INT NOT NULL PRIMARY KEY,
usuari_id INT NOT NULL,
titol VARCHAR(45) NOT NULL,
mida INT NOT NULL,
descripcio VARCHAR(200),
duracio TIME NOT NULL,
thumbnail BLOB,
reproduccions INT NOT NULL,
likes INT UNSIGNED,
dislikes INT UNSIGNED,
estat ENUM('public','ocult','privat') NOT NULL,
data_publicacio DATETIME NOT NULL,
FOREIGN KEY (usuari_id) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS playlist(
id INT NOT NULL PRIMARY KEY,
usuari_id INT NOT NULL,
nom VARCHAR(25) NOT NULL UNIQUE,
data_creacio date NOT NULL,
estat ENUM("public", "privat") NOT NULL,
FOREIGN KEY (usuari_id) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS playlist_de_video(
playlist_id INT NOT NULL,
video_id INT NOT NULL,
PRIMARY KEY (playlist_id, video_id),
FOREIGN KEY (playlist_id) REFERENCES playlist(id),
FOREIGN KEY (video_id) REFERENCES video(id));

CREATE TABLE IF NOT EXISTS usuari_valora_video(
usuari_id INT NOT NULL,
video_id INT NOT NULL,
valoracio ENUM("like", "dislike") NOT NULL,
data_valoracio date NOT NULL,
PRIMARY KEY (usuari_id, video_id),
FOREIGN KEY (usuari_id) REFERENCES usuari(id),
FOREIGN KEY (video_id) REFERENCES VIDEO(id));


CREATE TABLE IF NOT EXISTS etiqueta(
id INT NOT NULL PRIMARY KEY,
nom VARCHAR(25) NOT NULL UNIQUE);

CREATE TABLE IF NOT EXISTS etiqueta_video(
video_id INT NOT NULL,
etiqueta_id INT NOT NULL,
PRIMARY KEY (video_id, etiqueta_id),
FOREIGN KEY (video_id) REFERENCES video(id),
FOREIGN KEY (etiqueta_id) REFERENCES etiqueta(id));

CREATE TABLE IF NOT EXISTS comentari(
id INT NOT NULL PRIMARY KEY,
usuari_id INT NOT NULL,
video_id INT NOT NULL,
texte VARCHAR(45) NOT NULL,
data_publicacio DATETIME NOT NULL,
FOREIGN KEY (usuari_id) REFERENCES usuari(id),
FOREIGN KEY (video_id) REFERENCES video(id));

CREATE TABLE IF NOT EXISTS usuari_valora_comentari(
usuari_id INT NOT NULL,
comentari_id INT NOT NULL,
data_publicacio DATETIME NOT NULL,
valoracio ENUM("like","dislike") NOT NULL,
PRIMARY KEY (usuari_id, comentari_id),
FOREIGN KEY (usuari_id) REFERENCES usuari(id),
FOREIGN KEY (comentari_id) REFERENCES comentari(id));

/* DADES INSERTADES */

INSERT INTO usuari (id, mail, contrasenya, usuari, naixement, sexe, pais, postal)
VALUES (1, "aa@gmail.com", 123, "pedro56", '2021-03-21', "home", "France", 4292);
INSERT INTO usuari (id, mail, contrasenya, usuari, naixement, sexe, pais, postal)
VALUES (2, "eee@gmail.com", 1234, "antonio12", '2020-07-19', "home", "España", 212);

INSERT INTO canal (id, id_usuari, nom, descripcio, data_creacio)
VALUES (555, 1, "pedrogamer", "canal videojocs", "2019-03-20");
INSERT INTO canal (id, id_usuari, nom, descripcio, data_creacio)
VALUES (666, 2, "canaldecuina", "canal de cuina", "2020-12-25");

INSERT INTO usuari_suscriu_canal (usuari_id, canal_id)
VALUES (1, 666);
INSERT INTO usuari_suscriu_canal (usuari_id, canal_id)
VALUES (2, 555);

INSERT INTO video (id, usuari_id, titol, mida, descripcio, duracio, thumbnail, reproduccions, likes, dislikes, estat, data_publicacio)
VALUES (121212, 1, "wow", 300, "guia wow", '00:20:00', null, 400, 20, null, "public", '2020-03-21 23:23:20');
INSERT INTO video (id, usuari_id, titol, mida, descripcio, duracio, thumbnail, reproduccions, likes, dislikes, estat, data_publicacio)
VALUES (131313, 2, "cuina", 500, "guia cuina", '00:24:00', null, 400, 3000, null, "privat", '2017-05-22 12:25:34');

INSERT INTO playlist (id, usuari_id, nom, data_creacio, estat)
VALUES (998, 1, "playlista de heavy metal", "2020-12-21", "public");
INSERT INTO playlist (id, usuari_id, nom, data_creacio, estat)
VALUES (999, 2, "playlista de polka", "2014-11-12", "privat");

INSERT INTO usuari_valora_video (usuari_id, video_id, valoracio, data_valoracio)
VALUES (1, 131313, "like", '2023-05-22');
INSERT INTO usuari_valora_video (usuari_id, video_id, valoracio, data_valoracio)
VALUES (2, 121212, "dislike", '2022-08-10');

INSERT INTO playlist_de_video (playlist_id, video_id)
VALUES (998, 121212);
INSERT INTO playlist_de_video (playlist_id, video_id)
VALUES (999, 131313);

INSERT INTO etiqueta (id, nom)
VALUES (575, "etiqueta1");
INSERT INTO etiqueta (id, nom)
VALUES (576, "etiqueta2");
INSERT INTO etiqueta (id, nom)
VALUES (577, "etiqueta3");

INSERT INTO etiqueta_video (video_id, etiqueta_id)
VALUES (121212, 575);
INSERT INTO etiqueta_video (video_id, etiqueta_id)
VALUES (131313, 576);

INSERT INTO comentari (id, usuari_id, video_id, texte, data_publicacio)
VALUES (444,1,121212, "no estic d'acord", '2012-07-23 02:25:34');
INSERT INTO comentari (id, usuari_id, video_id, texte, data_publicacio)
VALUES (333,2,131313, "el video esta be", '2024-07-20 21:23:34');

INSERT INTO usuari_valora_comentari (usuari_id, comentari_id, data_publicacio, valoracio)
VALUES (1, 333, '2025-06-10',"like");
INSERT INTO usuari_valora_comentari (usuari_id, comentari_id, data_publicacio, valoracio)
VALUES (2, 444, '2021-04-02',"dislike");