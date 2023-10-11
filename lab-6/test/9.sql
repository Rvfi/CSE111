.headers on
SELECT COUNT(DISTINCT ps.ps_suppkey) AS supplier_cnt
FROM partsupp ps
JOIN part p ON ps.ps_partkey = p.p_partkey
WHERE p.p_retailprice = (
  SELECT MIN(p2.p_retailprice)
  FROM part p2
);
