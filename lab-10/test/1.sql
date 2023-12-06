-- Create Trigger t1
CREATE TRIGGER t1
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    NEW.o_orderdate := '2023-12-01';
END;

-- Insert orders from December 1995 (Assuming a method to insert these orders)

-- Query to count orders from 2023 using strftime
SELECT COUNT(*) AS orders_cnt FROM orders WHERE strftime('%Y', o_orderdate) = '2023';
