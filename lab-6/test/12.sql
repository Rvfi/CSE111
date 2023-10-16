.headers on
SELECT COUNT(*) AS part_cnt
FROM (
  SELECT p.p_partkey
  FROM part p
  JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
  JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
  JOIN nation n ON s.s_nationkey = n.n_nationkey
  WHERE n.n_name = 'UNITED STATES'
  GROUP BY p.p_partkey
  HAVING COUNT(DISTINCT s.s_suppkey) = 1
) AS UniqueParts;
