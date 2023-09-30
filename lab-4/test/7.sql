.headers on
SELECT n.n_name AS country, o.o_orderstatus AS status, COUNT(o.o_orderkey) AS orders
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'AFRICA'
GROUP BY n.n_name, o.o_orderstatus
ORDER BY n.n_name, o.o_orderstatus;
