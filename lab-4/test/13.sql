.headers on
SELECT sr.r_name AS supp_region, cr.r_name AS cust_region, MIN(o.o_totalprice) AS min_price
FROM orders o
JOIN lineitem l ON o.o_orderkey = l.l_orderkey
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation sn ON s.s_nationkey = sn.n_nationkey
JOIN region sr ON sn.n_regionkey = sr.r_regionkey
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation cn ON c.c_nationkey = cn.n_nationkey
JOIN region cr ON cn.n_regionkey = cr.r_regionkey
WHERE sr.r_name != cr.r_name
GROUP BY sr.r_name, cr.r_name
ORDER BY sr.r_name, cr.r_name;
