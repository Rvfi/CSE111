.headers on

SELECT 
    n.n_name, 
    SUM(s.s_acctbal) as total_acct_bal
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
GROUP BY n.n_name;