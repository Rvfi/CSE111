.headers on

SELECT 
    substr(l.l_receiptdate, 1, 7) as year_month, 
    COUNT(*) as items
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
WHERE o.o_custkey = '000000227'
GROUP BY year_month;