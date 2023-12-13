.headers ON
DROP TRIGGER IF EXISTS t1;
-- Trigger to set order date to '2023-12-01' for new orders
-- Trigger to set order date to '2023-12-01' for new orders
CREATE TRIGGER t1
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE orders SET o_orderdate = '2023-12-01' WHERE o_orderkey = NEW.o_orderkey;
END;

-- Insert orders from December 1995
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, 
                    o_orderpriority, o_clerk, o_shippriority, o_comment)
SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, 
       o_orderpriority, o_clerk, o_shippriority, o_comment
FROM orders
WHERE strftime('%Y-%m', o_orderdate) = '1995-12';

-- Query to count orders from 2023 with 'order_cnt' as the column name
SELECT COUNT(*) AS order_cnt
FROM orders
WHERE strftime('%Y', o_orderdate) = '2023';
