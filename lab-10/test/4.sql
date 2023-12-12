-- Drop existing triggers if they exist
DROP TRIGGER IF EXISTS update_priority_add;
DROP TRIGGER IF EXISTS update_priority_delete;

-- Triggers to set order priority to 'HIGH' when a line item is added or removed
CREATE TRIGGER update_priority_add
AFTER INSERT ON lineitem
FOR EACH ROW
BEGIN
  UPDATE orders SET o_orderpriority = 'HIGH' WHERE o_orderkey = NEW.l_orderkey;
END;

CREATE TRIGGER update_priority_delete
AFTER DELETE ON lineitem
FOR EACH ROW
BEGIN
  UPDATE orders SET o_orderpriority = 'HIGH' WHERE o_orderkey = OLD.l_orderkey;
END;

-- Delete line items from orders of December 1995
DELETE FROM lineitem
WHERE l_orderkey IN (SELECT o_orderkey FROM orders WHERE strftime('%Y-%m', o_orderdate) = '1995-12');

-- Count HIGH priority orders from September to December 1995
SELECT COUNT(*) AS orders_cnt
FROM orders
WHERE o_orderpriority = 'HIGH' AND strftime('%Y-%m', o_orderdate) BETWEEN '1995-09' AND '1995-12';
