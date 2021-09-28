DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARSET utf8mb4;
USE optica;

/* TAULES */

CREATE TABLE IF NOT EXISTS proveidor(
DNI VARCHAR(10) NOT NULL PRIMARY KEY,
nom VARCHAR(25) NOT NULL UNIQUE,
direccio VARCHAR(45) NOT NULL,
telefon INT UNSIGNED NOT NULL,
fax INT UNSIGNED NOT NULL);

CREATE TABLE IF NOT EXISTS ulleres(
id INT UNSIGNED NOT NULL PRIMARY KEY,
DNI_proveidor VARCHAR(10) NOT NULL,
marca VARCHAR(30) NOT NULL,
graduacio INT NOT NULL,
tipus_montura VARCHAR(40) NOT NULL,
color_vidre VARCHAR(40) NOT NULL,
color_montura VARCHAR(40) NOT NULL,
preu INT NOT NULL,
FOREIGN KEY (DNI_proveidor) REFERENCES proveidor(DNI));

CREATE TABLE IF NOT EXISTS client(
DNI VARCHAR(30) NOT NULL PRIMARY KEY,
nom VARCHAR(25) NOT NULL UNIQUE,
postal INT UNSIGNED NOT NULL,
telefon INT UNSIGNED NOT NULL,
correu VARCHAR(45) NOT NULL,
registre DATE NOT NULL,
client_DNI VARCHAR(25),
FOREIGN KEY (client_DNI) REFERENCES client(DNI));

CREATE TABLE IF NOT EXISTS venda(
client_DNI VARCHAR(30) NOT NULL,
ulleres_id INT UNSIGNED NOT NULL,
venedor VARCHAR(30) NOT NULL,
data_venda DATE NOT NULL,
PRIMARY KEY (client_DNI, ulleres_id),
FOREIGN KEY (client_DNI) REFERENCES client(DNI),
FOREIGN KEY (ulleres_id) REFERENCES ulleres(id));

/* DADES INSERTADES */

INSERT INTO proveidor (DNI, nom, direccio, telefon, fax)
VALUES ("4889685U", "Pedro", "Calle Balmes", 9873482, 302349);
INSERT INTO proveidor (DNI, nom, direccio, telefon, fax)
VALUES ("2342423U", "Alberto", "Calle Marina", 234234, 123123);
INSERT INTO proveidor (DNI, nom, direccio, telefon, fax)
VALUES ("452345U", "Maria", "Calle Constitucio", 647645, 456456);
INSERT INTO proveidor (DNI, nom, direccio, telefon, fax)
VALUES ("3123123", "Paco", "Calle Llibertat", 13223, 48989);
INSERT INTO proveidor (DNI, nom, direccio, telefon, fax)
VALUES ("28282GH", "Joan", "Calle Marina", 929292, 848583);

INSERT INTO ulleres (id, DNI_proveidor, marca, graduacio, tipus_montura, color_vidre, color_montura, preu)
VALUES (1, "4889685U", "aspir", 6, "blanda", "transparent", "vermell", 90);
INSERT INTO ulleres (id, DNI_proveidor, marca, graduacio, tipus_montura, color_vidre, color_montura, preu)
VALUES (2, "2342423U", "twohouses", 2, "dura", "opac", "groc", 98);
INSERT INTO ulleres (id, DNI_proveidor, marca, graduacio, tipus_montura, color_vidre, color_montura, preu)
VALUES (3, "452345U", "visionmil", 8, "mixta", "reflectant", "blau", 50);
INSERT INTO ulleres (id, DNI_proveidor, marca, graduacio, tipus_montura, color_vidre, color_montura, preu)
VALUES (4, "3123123", "hellglasses", 6, "mixta", "reflectant", "blau", 50);
INSERT INTO ulleres (id, DNI_proveidor, marca, graduacio, tipus_montura, color_vidre, color_montura, preu)
VALUES (5, "3123123", "hellglasses", 3, "mixta", "reflectant", "blau", 50);
INSERT INTO ulleres (id, DNI_proveidor, marca, graduacio, tipus_montura, color_vidre, color_montura, preu)
VALUES (6, "28282GH", "redglasses", 2, "mixta", "reflectant", "blau", 50);
INSERT INTO ulleres (id, DNI_proveidor, marca, graduacio, tipus_montura, color_vidre, color_montura, preu)
VALUES (7, "28282GH", "redglasses", 1, "mixta", "reflectant", "blau", 50);


INSERT INTO client (DNI, nom, postal, telefon, correu, registre, client_DNI)
VALUES ("3123123", "Alfred", 1234, 323423, "jsk@gmail.com", "2020-03-20", null);

INSERT INTO venda (client_DNI, ulleres_id, venedor, data_venda)
VALUES ("3123123", 1, "Pablo", "2020-03-20");
INSERT INTO venda (client_DNI, ulleres_id, venedor, data_venda)
VALUES ("3123123", 2, "Pablo", "2020-04-25");
INSERT INTO venda (client_DNI, ulleres_id, venedor, data_venda)
VALUES ("3123123", 3, "Maria", "2017-01-08");
