.headers on

SELECT 
    s.s_name, 
    s.s_acctbal
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'ASIA' AND s.s_acctbal > 5000;