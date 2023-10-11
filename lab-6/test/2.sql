.headers on
SELECT COUNT(DISTINCT c.c_custkey) AS customer_cnt
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    JOIN supplier s ON l.l_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    JOIN region r ON n.n_regionkey = r.r_regionkey
    WHERE o.o_custkey = c.c_custkey AND r.r_name != 'AFRICA'
)
AND EXISTS (
    SELECT 1
    FROM orders o
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
    JOIN supplier s ON l.l_suppkey = s.s_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    JOIN region r ON n.n_regionkey = r.r_regionkey
    WHERE o.o_custkey = c.c_custkey AND r.r_name = 'AFRICA'
);
