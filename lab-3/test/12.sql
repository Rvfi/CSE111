.headers on

SELECT 
    substr(o.o_orderdate, 1, 4) as year, 
    COUNT(*) as item_cnt
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE o.o_orderpriority = '3-MEDIUM' AND (n.n_name = 'ARGENTINA' OR n.n_name = 'BRAZIL')
GROUP BY year;