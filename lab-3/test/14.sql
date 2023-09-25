.headers on

SELECT 
    s.s_name, 
    COUNT(*) as discounted_items
FROM lineitem l
JOIN supplier s ON l.l_suppkey = s.s_suppkey
WHERE l.l_discount = 0.10
GROUP BY s.s_name;