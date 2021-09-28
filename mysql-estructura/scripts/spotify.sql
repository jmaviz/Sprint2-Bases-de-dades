DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARSET utf8mb4;
USE spotify;

/* TAULES */

CREATE TABLE IF NOT EXISTS usuari(
id int NOT NULL PRIMARY KEY,
nom VARCHAR(25) NOT NULL UNIQUE,
cognoms VARCHAR(50) NOT NULL,
email VARCHAR(60) NOT NULL,
pais VARCHAR(45) NOT NULL,
postal int NOT NULL,
naixement DATE NOT NULL,
sexe ENUM("home","dona") NOT NULL,
tipus_usuari ENUM("free","premium") NOT NULL);

CREATE TABLE IF NOT EXISTS premium(
id_usuari int NOT NULL PRIMARY KEY,
inici_sub date NOT NULL,
forma_pagament ENUM("targeta","paypal") NOT NULL,
num_targeta VARCHAR(45) NOT NULL,
caducitat date NOT NULL,
codi_seguretat integer,
nom_paypal VARCHAR(45),
FOREIGN KEY (id_usuari) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS pagament(
id_ordre int NOT NULL,
premium_usuari int NOT NULL,
data_factura date NOT NULL,
total integer NOT NULL,
FOREIGN KEY (premium_usuari) REFERENCES premium(id_usuari));

CREATE TABLE IF NOT EXISTS artista(
id integer NOT NULL PRIMARY KEY,
nom VARCHAR(45) NOT NULL,
imatge BLOB);

CREATE TABLE IF NOT EXISTS segueix_artista(
artista_id integer NOT NULL,
usuari_id integer NOT NULL,
PRIMARY KEY (artista_id, usuari_id),
FOREIGN KEY (artista_id) REFERENCES artista(id),
FOREIGN KEY (usuari_id) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS artista_relacionat(
artista_id integer NOT NULL,
artista_relacionat_artista_id integer NOT NULL,
PRIMARY KEY (artista_id, artista_relacionat_artista_id),
FOREIGN KEY (artista_id) REFERENCES artista(id),
FOREIGN KEY (artista_relacionat_artista_id) REFERENCES artista(id));

CREATE TABLE IF NOT EXISTS playlist(
id integer NOT NULL PRIMARY KEY,
usuari_id integer NOT NULL,
titol VARCHAR(45) NOT NULL,
num_songs integer NOT NULL,
data_creacio DATE NOT NULL,
estat_playlist ENUM("activa","esborrada") NOT NULL,
data_baixa DATE,
FOREIGN KEY (usuari_id) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS album(
id integer NOT NULL PRIMARY KEY,
id_artista integer NOT NULL,
titol VARCHAR(45) NOT NULL,
any_publicacio year NOT NULL,
imatge BLOB,
FOREIGN KEY (id_artista) REFERENCES artista(id));

CREATE TABLE IF NOT EXISTS canço(
id integer NOT NULL PRIMARY KEY,
id_album integer NOT NULL,
titol VARCHAR(45) NOT NULL,
durada time NOT NULL,
reproduida integer NOT NULL,
FOREIGN KEY (id_album) REFERENCES album(id));

CREATE TABLE IF NOT EXISTS llista_compartida(
id_playlist integer NOT NULL,
id_canço integer NOT NULL,
id_usuari int NOT NULL,
data_canço_afegida date NOT NULL,
PRIMARY KEY (id_playlist, id_canço, id_usuari),
FOREIGN KEY (id_playlist) REFERENCES playlist(id),
FOREIGN KEY (id_canço) REFERENCES canço(id),
FOREIGN KEY (id_usuari) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS canço_guardada(
id_canço integer NOT NULL,
id_usuari int NOT NULL,
PRIMARY KEY (id_canço, id_usuari),
FOREIGN KEY (id_canço) REFERENCES canço(id),
FOREIGN KEY (id_usuari) REFERENCES usuari(id));

CREATE TABLE IF NOT EXISTS album_guardat(
id_usuari int NOT NULL,
id_album int NOT NULL,
PRIMARY KEY (id_usuari, id_album),
FOREIGN KEY (id_usuari) REFERENCES usuari(id),
FOREIGN KEY (id_album) REFERENCES album(id));

/* DADES */

INSERT INTO usuari(id, nom, cognoms, email, pais, postal, naixement, sexe, tipus_usuari)
VALUE (1, "pedro123", "lopez","juan@laskd", "anglaterra", 1234, "2019-03-20", "home", "free");
INSERT INTO usuari(id, nom, cognoms, email, pais, postal, naixement, sexe, tipus_usuari)
VALUE (2,"alba123", "martines","alba@laskd", "alemanya", 2233, "2018-05-21", "dona", "premium");

INSERT INTO premium(id_usuari, inici_sub, forma_pagament, num_targeta, caducitat, codi_seguretat, nom_paypal)
VALUES (2, "2020-03-20","paypal", "123123k", "2022-04-20", 123123, "usuario123");

INSERT INTO pagament(id_ordre, premium_usuari, data_factura, total)
VALUES (1111, 2, "2020-12-01", 20);

INSERT INTO artista(id, nom, imatge)
values (1212, "iron maiden", null);
INSERT INTO artista(id, nom, imatge)
values (1213, "the clash", null);
INSERT INTO artista(id, nom, imatge)
values (1214, "new york dolls", null);

INSERT INTO segueix_artista(artista_id, usuari_id)
values (1212, 2);
INSERT INTO segueix_artista(artista_id, usuari_id)
values (1212, 1);
INSERT INTO segueix_artista(artista_id, usuari_id)
values (1213, 1);
INSERT INTO segueix_artista(artista_id, usuari_id)
values (1214, 1);

INSERT INTO artista_relacionat(artista_id, artista_relacionat_artista_id)
VALUES (1212, 1214);
INSERT INTO artista_relacionat(artista_id, artista_relacionat_artista_id)
VALUES (1214, 1212);

INSERT INTO playlist(id, usuari_id, titol, num_songs, data_creacio, estat_playlist, data_baixa)
VALUES (5656, 1, "rock", 60, "2016-03-01", "activa", null);
INSERT INTO playlist(id, usuari_id, titol, num_songs, data_creacio, estat_playlist, data_baixa)
VALUES (777, 2, "jazz", 620, "2017-06-02", "esborrada", "25-12-18");

INSERT INTO album(id, id_artista, titol, any_publicacio, imatge)
VALUES (7575, 1212, "the number of the beast", 1982, NULL);
INSERT INTO album(id, id_artista, titol, any_publicacio, imatge)
VALUES (7576, 1212, "senjetsu", 2021, NULL);
INSERT INTO album(id, id_artista, titol, any_publicacio, imatge)
VALUES (7577, 1213, "london calling", 1979, NULL);
INSERT INTO album(id, id_artista, titol, any_publicacio, imatge)
VALUES (7578, 1214, "new york dolls", 1973, NULL);

INSERT INTO canço(id, id_album, titol, durada, reproduida)
VALUES (8888, 7575, "invaders", "3:23", 123123 );
INSERT INTO canço(id, id_album, titol, durada, reproduida)
VALUES (9999, 7576, "death of the celts", "10:20", 122 );
INSERT INTO canço(id, id_album, titol, durada, reproduida)
VALUES (3434, 7577, "white riot", "2:30", 1223 );
INSERT INTO canço(id, id_album, titol, durada, reproduida)
VALUES (343488, 7578, "trash", "2:20", 1223000 );

INSERT INTO llista_compartida(id_playlist, id_canço, id_usuari, data_canço_afegida)
VALUES (5656, 8888, 1, "2020-01-27");
INSERT INTO llista_compartida(id_playlist, id_canço, id_usuari, data_canço_afegida)
VALUES (777, 9999, 1, "2021-02-19");

INSERT INTO canço_guardada(id_canço, id_usuari)
VALUES (8888, 1);
INSERT INTO canço_guardada(id_canço, id_usuari)
VALUES (8888, 2);
INSERT INTO canço_guardada(id_canço, id_usuari)
VALUES (9999, 1);
INSERT INTO canço_guardada(id_canço, id_usuari)
VALUES (3434, 2);

INSERT INTO album_guardat(id_album, id_usuari)
VALUES (7575, 1);
INSERT INTO album_guardat(id_album, id_usuari)
VALUES (7576, 1);
INSERT INTO album_guardat(id_album, id_usuari)
VALUES (7577, 1);
INSERT INTO album_guardat(id_album, id_usuari)
VALUES (7578, 2);
INSERT INTO album_guardat(id_album, id_usuari)
VALUES (7576, 2);