.headers on
SELECT COUNT(*) AS suppliers_cnt
FROM (
  SELECT s.s_suppkey
  FROM supplier s
  JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
  JOIN nation n ON s.s_nationkey = n.n_nationkey
  WHERE n.n_name = 'PERU'
  GROUP BY s.s_suppkey
  HAVING COUNT(DISTINCT ps.ps_partkey) > 40
) AS UniqueSuppliers;
