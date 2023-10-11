.headers on
SELECT DISTINCT p.p_name AS part
FROM part p
JOIN lineitem l ON p.p_partkey = l.l_partkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n1 ON c.c_nationkey = n1.n_nationkey
JOIN region r1 ON n1.n_regionkey = r1.r_regionkey
WHERE r1.r_name = 'ASIA'
AND (
  SELECT COUNT(DISTINCT s.s_suppkey)
  FROM supplier s
  JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
  JOIN nation n2 ON s.s_nationkey = n2.n_nationkey
  JOIN region r2 ON n2.n_regionkey = r2.r_regionkey
  WHERE ps.ps_partkey = p.p_partkey AND r2.r_name = 'AFRICA'
) = 3;
