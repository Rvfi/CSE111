.headers on
SELECT 
    r.r_name AS region,
    COUNT(DISTINCT c.c_custkey) AS cust_cnt
FROM 
    region r
    JOIN nation n ON r.r_regionkey = n.n_regionkey
    JOIN customer c ON n.n_nationkey = c.c_nationkey
    JOIN orders o ON c.c_custkey = o.o_custkey
WHERE 
    c.c_acctbal > (SELECT AVG(c_acctbal) FROM customer)
GROUP BY 
    r.r_name
HAVING 
    COUNT(o.o_orderkey) > 0;
