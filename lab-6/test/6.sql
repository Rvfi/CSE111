.headers on
SELECT COUNT(DISTINCT s.s_suppkey) AS suppliers_cnt
FROM supplier s
JOIN partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE n.n_name = 'PERU'
GROUP BY s.s_suppkey
HAVING COUNT(DISTINCT ps.ps_partkey) > 40;
