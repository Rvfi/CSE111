.headers on
SELECT n.n_name AS country
FROM nation n
JOIN supplier s ON n.n_nationkey = s.s_nationkey
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
WHERE strftime('%Y', l.l_shipdate) = '1994'  -- Replace with YEAR(l.l_shipdate) = 1994 for MySQL or SQL Server
GROUP BY n.n_name
ORDER BY SUM(l.l_extendedprice) ASC
LIMIT 1;
