.headers on

SELECT DISTINCT 
    n.n_name
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE substr(o.o_orderdate, 1, 4) = '1994' AND substr(o.o_orderdate, 6, 2) = '12'
ORDER BY n.n_name;