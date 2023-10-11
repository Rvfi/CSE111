.headers on
SELECT COUNT(DISTINCT s.s_suppkey) AS supplier_cnt
FROM supplier s
WHERE (
  SELECT COUNT(DISTINCT o.o_orderkey)
  FROM lineitem l
  JOIN orders o ON l.l_orderkey = o.o_orderkey
  JOIN customer c ON o.o_custkey = c.c_custkey
  JOIN nation n ON c.c_nationkey = n.n_nationkey
  WHERE l.l_suppkey = s.s_suppkey AND (n.n_name = 'EGYPT' OR n.n_name = 'JORDAN')
) < 50;
