.headers on
SELECT COUNT(l.l_linenumber) AS items
FROM lineitem l
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation ns ON s.s_nationkey = ns.n_nationkey
JOIN nation nc ON c.c_nationkey = nc.n_nationkey
JOIN region rs ON ns.n_regionkey = rs.r_regionkey
WHERE rs.r_name = 'ASIA' AND nc.n_name = 'KENYA';
