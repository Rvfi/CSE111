.headers on
SELECT COUNT(DISTINCT c.c_custkey) AS customer_cnt
FROM customer c
WHERE (
  SELECT COUNT(o.o_orderkey)
  FROM orders o
  WHERE o.o_custkey = c.c_custkey AND strftime('%Y-%m', o.o_orderdate) = '1995-11'
) <= 3;
