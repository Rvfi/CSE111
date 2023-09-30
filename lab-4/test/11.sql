.headers on
SELECT COUNT(DISTINCT o.o_orderkey) AS order_cnt
FROM customer c
JOIN orders o ON c.c_custkey = o.o_custkey
JOIN lineitem l ON o.o_orderkey = l.l_orderkey
JOIN supplier s ON l.l_suppkey = s.s_suppkey
WHERE c.c_acctbal < 0 AND s.s_acctbal > 0;
