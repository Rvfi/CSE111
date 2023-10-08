.headers on
SELECT 
    COUNT(c.c_custkey) AS cust_cnt
FROM 
    customer c
    JOIN nation n ON c.c_nationkey = n.n_nationkey
    LEFT JOIN region r ON n.n_regionkey = r.r_regionkey AND r.r_name IN ('EUROPE', 'ASIA')
WHERE 
    r.r_name IS NULL;
