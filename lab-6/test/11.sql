.headers on
SELECT r.r_name AS region
FROM region r
JOIN nation n1 ON r.r_regionkey = n1.n_regionkey
JOIN customer c ON n1.n_nationkey = c.c_nationkey
JOIN orders o ON c.c_custkey = o.o_custkey
JOIN lineitem l ON o.o_orderkey = l.l_orderkey
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation n2 ON s.s_nationkey = n2.n_nationkey
WHERE n1.n_regionkey = n2.n_regionkey
GROUP BY r.r_name
ORDER BY SUM(l.l_extendedprice) DESC
LIMIT 1;
