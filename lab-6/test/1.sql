.headers on
SELECT s.s_name AS supplier, c.c_name AS customer, o.o_totalprice AS price
FROM supplier s
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
WHERE o.o_orderstatus = 'F'
ORDER BY o.o_totalprice DESC, s.s_name, c.c_name
LIMIT 1;
