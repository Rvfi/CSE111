.headers on
SELECT 
    o.o_orderpriority AS priority,
    COUNT(l.l_orderkey) AS item_cnt
FROM 
    (SELECT * FROM orders WHERE strftime('%Y', o_orderdate) = '1995') o
    JOIN lineitem l ON o.o_orderkey = l.l_orderkey
WHERE 
    l.l_receiptdate < l.l_commitdate
GROUP BY 
    o.o_orderpriority;
