.headers on
SELECT COUNT(DISTINCT o.o_clerk) AS clerks
FROM supplier s
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE n.n_name = 'PERU';
