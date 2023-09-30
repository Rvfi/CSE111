.headers on
SELECT s.s_name AS supplier, o.o_orderpriority AS priority, COUNT(DISTINCT p.p_partkey) AS parts
FROM part p
JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN lineitem l ON p.p_partkey = l.l_partkey AND s.s_suppkey = l.l_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
WHERE n.n_name = 'INDONESIA'
GROUP BY s.s_name, o.o_orderpriority
ORDER BY s.s_name, o.o_orderpriority;
