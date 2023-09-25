.headers on

SELECT 
    SUM(o.o_totalprice) as total_price
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'AMERICA' AND substr(o.o_orderdate, 1, 4) = '1995';