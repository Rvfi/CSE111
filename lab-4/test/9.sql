.headers on
SELECT n.n_name AS country, COUNT(DISTINCT o.o_orderkey) AS cnt
FROM supplier s
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'AFRICA' AND o.o_orderstatus = 'F' AND EXTRACT(YEAR FROM o.o_orderdate) = 1993
GROUP BY n.n_name
HAVING COUNT(DISTINCT o.o_orderkey) > 200
ORDER BY n.n_name;
