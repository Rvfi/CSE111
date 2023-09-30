.headers on
WITH MaxBalance AS (
  SELECT r.r_name AS region, s.s_name AS supplier, s.s_acctbal AS acct_bal,
         RANK() OVER (PARTITION BY r.r_name ORDER BY s.s_acctbal DESC) AS rank
  FROM supplier s
  JOIN nation n ON s.s_nationkey = n.n_nationkey
  JOIN region r ON n.n_regionkey = r.r_regionkey
)
SELECT region, supplier, acct_bal
FROM MaxBalance
WHERE rank = 1
ORDER BY region;
