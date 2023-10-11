.headers on
WITH EconomicExchange AS (
  SELECT n.n_name AS country, 
         strftime('%Y', l.l_shipdate) AS year,
         COUNT(CASE WHEN n.n_nationkey = s.s_nationkey THEN l.l_quantity ELSE NULL END) -
         COUNT(CASE WHEN n.n_nationkey = c.c_nationkey THEN l.l_quantity ELSE NULL END) AS exchange
  FROM nation n
  LEFT JOIN supplier s ON n.n_nationkey = s.s_nationkey
  LEFT JOIN lineitem l ON s.s_suppkey = l.l_suppkey
  LEFT JOIN orders o ON l.l_orderkey = o.o_orderkey
  LEFT JOIN customer c ON o.o_custkey = c.c_custkey
  WHERE strftime('%Y', l.l_shipdate) IN ('1997', '1998')
  GROUP BY n.n_name, strftime('%Y', l.l_shipdate)
)
SELECT country, 
       SUM(CASE WHEN year = '1997' THEN exchange ELSE 0 END) AS '1997',
       SUM(CASE WHEN year = '1998' THEN exchange ELSE 0 END) AS '1998'
FROM EconomicExchange
GROUP BY country;
