-- OPTICA
SELECT * FROM venda WHERE data_venda BETWEEN "2020-01-01" AND "2020-12-30";
SELECT u.marca FROM ulleres u JOIN venda v ON u.id=v.ulleres_id WHERE data_venda BETWEEN "2020-01-01" AND "2020-12-30";
SELECT * from proveidor p JOIN ulleres u ON p.DNI=u.DNI_proveidor JOIN venda v ON u.id=v.ulleres_id;