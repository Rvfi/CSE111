.headers on
SELECT c.c_name AS customer, COUNT(o.o_orderkey) AS cnt
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE n.n_name = 'EGYPT' AND EXTRACT(YEAR FROM o.o_orderdate) = 1992
GROUP BY c.c_name
ORDER BY c.c_name;
