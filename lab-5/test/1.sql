.headers on
SELECT 
    n.n_name AS country,
    COUNT(DISTINCT c.c_custkey) AS cust_cnt,
    COUNT(DISTINCT s.s_suppkey) AS supp_cnt
FROM 
    nation n
    LEFT JOIN customer c ON n.n_nationkey = c.c_nationkey
    LEFT JOIN supplier s ON n.n_nationkey = s.s_nationkey
    JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE 
    r.r_name = 'AMERICA'
GROUP BY 
    n.n_name;
