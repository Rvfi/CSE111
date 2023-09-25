.headers on

SELECT 
    COUNT(*) as order_cnt
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE n.n_name = 'ROMANIA' AND o.o_orderpriority = '1-URGENT' 
AND substr(o.o_orderdate, 1, 4) BETWEEN '1993' AND '1997';