.headers on
SELECT 
    o.o_orderpriority AS priority,
    COUNT(DISTINCT o.o_orderkey) AS order_cnt
FROM 
    orders o
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
WHERE 
    o.o_orderdate BETWEEN '1995-01-01' AND '1995-12-31'
    AND l.l_receiptdate > l.l_commitdate
GROUP BY 
    o.o_orderpriority;
