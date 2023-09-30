.headers on
SELECT s.s_name AS supplier, COUNT(p.p_partkey) AS cnt
FROM part p
JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE p.p_container LIKE '%BOX%' AND n.n_name = 'KENYA'
GROUP BY s.s_name
ORDER BY s.s_name;
