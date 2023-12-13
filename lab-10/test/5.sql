.headers ON
-- Trigger to remove tuples from partsupp and lineitem when a part is deleted
CREATE TRIGGER t5
BEFORE DELETE ON part
FOR EACH ROW
BEGIN
  DELETE FROM partsupp WHERE ps_partkey = OLD.p_partkey;
  DELETE FROM lineitem WHERE l_partkey = OLD.p_partkey;
END;

-- Delete parts from Kenyan or Moroccan suppliers
DELETE FROM part
WHERE p_partkey IN (
  SELECT ps_partkey 
  FROM partsupp 
  WHERE ps_suppkey IN (
    SELECT s_suppkey 
    FROM supplier 
    WHERE s_nationkey IN (
      SELECT n_nationkey 
      FROM nation 
      WHERE n_name IN ('KENYA', 'MOROCCO')
    )
  )
);

-- Count parts supplied by each African supplier, grouped by country
SELECT n_name AS country, COUNT(ps_partkey) AS parts_cnt
FROM partsupp
JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
WHERE n_regionkey = 0
GROUP BY n_name;
