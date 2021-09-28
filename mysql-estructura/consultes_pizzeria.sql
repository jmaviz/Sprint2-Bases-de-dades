-- PIZZERIA
SELECT l.nom, cam.quantitat FROM localitat l JOIN botiga b ON l.id=b.id_localitat JOIN comanda c ON c.botiga_id=b.id JOIN comanda_amb_producte cam ON cam.comanda_id=c.id JOIN producte p ON cam.id_producte=p.id WHERE p.tipus="beguda";
SELECT e.nom, e.DNI, count(cd.id_comanda) FROM empleat e JOIN comanda_domicili cd ON e.DNI=cd.DNI_empleat;