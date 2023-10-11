.headers on
WITH Outbound AS (
  SELECT n1.n_name AS country, COUNT(l.l_quantity) AS items_sold
  FROM nation n1
  JOIN supplier s ON n1.n_nationkey = s.s_nationkey
  JOIN lineitem l ON s.s_suppkey = l.l_suppkey
  JOIN orders o ON l.l_orderkey = o.o_orderkey
  JOIN customer c ON o.o_custkey = c.c_custkey
  JOIN nation n2 ON c.c_nationkey = n2.n_nationkey
  WHERE strftime('%Y', l.l_shipdate) = '1997' AND n1.n_nationkey != n2.n_nationkey
  GROUP BY n1.n_name
),
Inbound AS (
  SELECT n2.n_name AS country, COUNT(l.l_quantity) AS items_bought
  FROM nation n2
  JOIN customer c ON n2.n_nationkey = c.c_nationkey
  JOIN orders o ON c.c_custkey = o.o_custkey
  JOIN lineitem l ON o.o_orderkey = l.l_orderkey
  JOIN supplier s ON l.l_suppkey = s.s_suppkey
  JOIN nation n1 ON s.s_nationkey = n1.n_nationkey
  WHERE strftime('%Y', l.l_shipdate) = '1997' AND n1.n_nationkey != n2.n_nationkey
  GROUP BY n2.n_name
)
SELECT n.n_name AS country, 
       COALESCE(Outbound.items_sold, 0) - COALESCE(Inbound.items_bought, 0) AS economic_exchange
FROM nation n
LEFT JOIN Outbound ON n.n_name = Outbound.country
LEFT JOIN Inbound ON n.n_name = Inbound.country
