DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARSET utf8mb4;
USE pizzeria;

/* TAULES */

CREATE TABLE IF NOT EXISTS provincia(
id INT UNSIGNED NOT NULL PRIMARY KEY,
nom VARCHAR(30) NOT NULL);

CREATE TABLE IF NOT EXISTS localitat(
id INT UNSIGNED NOT NULL PRIMARY KEY,
nom VARCHAR(30) NOT NULL,
provincia_id INT UNSIGNED NOT NULL,
FOREIGN KEY (provincia_id) REFERENCES provincia(id));

CREATE TABLE IF NOT EXISTS client(
DNI VARCHAR(30) NOT NULL PRIMARY KEY,
id_localitat INT UNSIGNED NOT NULL,
nom VARCHAR(25) NOT NULL UNIQUE,
cognoms VARCHAR(50) NOT NULL,
direccio VARCHAR(100) NOT NULL,
postal INT UNSIGNED NOT NULL,
FOREIGN KEY (id_localitat) REFERENCES localitat(id));

CREATE TABLE IF NOT EXISTS botiga(
id INT UNSIGNED NOT NULL PRIMARY KEY,
id_localitat INT UNSIGNED NOT NULL,
direccio VARCHAR(100) NOT NULL,
postal INT UNSIGNED NOT NULL,
FOREIGN KEY (id_localitat) REFERENCES localitat(id));

CREATE TABLE IF NOT EXISTS empleat(
DNI VARCHAR(30) NOT NULL PRIMARY KEY,
id_botiga INT UNSIGNED NOT NULL,
nom VARCHAR(25) NOT NULL UNIQUE,
cognoms VARCHAR(50) NOT NULL,
seccio ENUM('cuiner', 'repartidor') NOT NULL,
telefon INT NOT NULL,
FOREIGN KEY (id_botiga) REFERENCES botiga(id));

CREATE TABLE IF NOT EXISTS comanda(
id INT UNSIGNED NOT NULL PRIMARY KEY,
client_DNI VARCHAR(30) NOT NULL,
botiga_id INT UNSIGNED NOT NULL,
datahora DATETIME NOT NULL,
tipus ENUM('domicili','botiga') NOT NULL,
preu_total INT UNSIGNED NOT NULL,
FOREIGN KEY (client_DNI) REFERENCES client(DNI),
FOREIGN KEY (botiga_id) REFERENCES botiga(id));

CREATE TABLE IF NOT EXISTS comanda_domicili(
id_comanda INT UNSIGNED NOT NULL,
DNI_empleat VARCHAR(30) NOT NULL,
PRIMARY KEY (id_comanda, DNI_empleat),
FOREIGN KEY (id_comanda) REFERENCES comanda(id),
FOREIGN KEY (DNI_empleat) REFERENCES empleat(DNI));

CREATE TABLE IF NOT EXISTS producte(
id INT UNSIGNED NOT NULL PRIMARY KEY,
nom VARCHAR(25) NOT NULL UNIQUE,
descripcio VARCHAR(200),
imatge BLOB,
preu INT UNSIGNED NOT NULL,
tipus ENUM("pizza", "beguda", "hamburguesa") NOT NULL);

CREATE TABLE IF NOT EXISTS categoria(
id INT UNSIGNED NOT NULL PRIMARY KEY,
nom VARCHAR(25) NOT NULL UNIQUE);

CREATE TABLE IF NOT EXISTS pizza(
id_producte INT UNSIGNED NOT NULL,
id_categoria INT UNSIGNED NOT NULL,
PRIMARY KEY (id_producte, id_categoria),
FOREIGN KEY (id_producte) REFERENCES producte(id),
FOREIGN KEY (id_categoria) REFERENCES categoria(id));

CREATE TABLE IF NOT EXISTS comanda_amb_producte(
comanda_id INT UNSIGNED NOT NULL,
id_producte INT UNSIGNED NOT NULL,
quantitat int UNSIGNED NOT NULL,
PRIMARY KEY (comanda_id, id_producte),
FOREIGN KEY (comanda_id) REFERENCES comanda(id),
FOREIGN KEY (id_producte) REFERENCES producte(id));

/* DADES INSERTADES */

INSERT INTO provincia (id, nom)
VALUES (1234, "Barcelona");
INSERT INTO provincia (id, nom)
VALUES (1235, "Lleida");
INSERT INTO provincia (id, nom)
VALUES (1236, "Tarragona");

INSERT INTO localitat (id, nom, provincia_id)
VALUES (111, "Cornella", 1234);
INSERT INTO localitat (id, nom, provincia_id)
VALUES (2222, "Cervera", 1235);
INSERT INTO localitat (id, nom, provincia_id)
VALUES (333, "Pradell", 1236);

INSERT INTO client (DNI, id_localitat, nom, cognoms, direccio, postal)
VALUES ("1234RT", 111, "Pedro", "Piqueras Martinez", "Downing Street", 0983);
INSERT INTO client (DNI, id_localitat, nom, cognoms, direccio, postal)
VALUES ("55543T", 2222, "Alvaro", "Benito Torres", "Carre Pelai", 890983);
INSERT INTO client (DNI, id_localitat, nom, cognoms, direccio, postal)
VALUES ("66776K", 333, "Marta", "Lopez Perez", "Carrer Concepcio", 021983);

INSERT INTO botiga (id, id_localitat, direccio, postal)
VALUES (2828, 111, "carrer alfred", 23123);
INSERT INTO botiga (id, id_localitat, direccio, postal)
VALUES (24234, 2222, "carrer pere", 22222);
INSERT INTO botiga (id, id_localitat, direccio, postal)
VALUES (256566, 333, "carrer arthur", 39393);

INSERT INTO empleat (DNI, id_botiga, nom, cognoms, seccio, telefon)
VALUES ("2343J", 2828, "Alfredo", "Martinez Lopez", "cuiner", 123213);
INSERT INTO empleat (DNI, id_botiga, nom, cognoms, seccio, telefon)
VALUES ("asdrwer", 24234, "Marta", "Harris Strong", "repartidor", 23123);
INSERT INTO empleat (DNI, id_botiga, nom, cognoms, seccio, telefon)
VALUES ("srfwe23", 256566, "Bruce", "Carrion", "cuiner", 3939);

INSERT INTO comanda (id, client_DNI, botiga_id, datahora, tipus, preu_total)
VALUES(956, "1234rt",2828, '2020-04-21 20:30:50', "domicili", 50);
INSERT INTO comanda (id, client_DNI, botiga_id, datahora, tipus, preu_total)
VALUES(957, "55543T",2828, '2021-07-22 22:30:50', "domicili", 25);
INSERT INTO comanda (id, client_DNI, botiga_id, datahora, tipus, preu_total)
VALUES(958, "66776K",256566, '2019-03-20 19:30:50', "botiga", 14);

INSERT INTO comanda_domicili (id_comanda, DNI_empleat)
VALUES (956, "asdrwer");
INSERT INTO comanda_domicili (id_comanda, DNI_empleat)
VALUES (957,"asdrwer");

INSERT INTO producte (id, nom, descripcio, imatge, preu, tipus)
VALUES (1, "pizza", null, null, 15, "pizza");
INSERT INTO producte (id, nom, descripcio, imatge, preu, tipus)
VALUES (2, "cervesa", null, null, 2, "beguda");
INSERT INTO producte (id, nom, descripcio, imatge, preu, tipus)
VALUES (3, "hamburguesa", null, null, 5, "hamburguesa");

INSERT INTO categoria (id, nom)
VALUES (12, "Familiar");
INSERT INTO categoria (id, nom)
VALUES (13, "Petita");
INSERT INTO categoria (id, nom)
VALUES (14, "Mitjana");

INSERT INTO pizza (id_producte, id_categoria)
VALUES (1, 12);
INSERT INTO pizza (id_producte, id_categoria)
VALUES (1, 13);
INSERT INTO pizza (id_producte, id_categoria)
VALUES (1, 14);

INSERT INTO comanda_amb_producte (comanda_id, id_producte, quantitat)
VALUES (956, 1, 2);
INSERT INTO comanda_amb_producte (comanda_id, id_producte, quantitat)
VALUES (957, 2, 5);
