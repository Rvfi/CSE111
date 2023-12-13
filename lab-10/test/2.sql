.headers ON
-- Drop the existing t2 trigger if it exists
DROP TRIGGER IF EXISTS t2;

-- Create the t2 trigger
CREATE TRIGGER t2
AFTER UPDATE ON customer
WHEN OLD.c_acctbal >= 0 AND NEW.c_acctbal < 0
BEGIN
  UPDATE customer SET c_comment = 'Negative balance!!!' WHERE c_custkey = NEW.c_custkey;
END;

-- Set balances of African customers to -100
UPDATE customer
SET c_acctbal = -100
WHERE c_nationkey IN (SELECT n_nationkey FROM nation WHERE n_regionkey = 0);

-- Count negative balance customers in Egypt
SELECT COUNT(*) AS customer_cnt
FROM customer
WHERE c_acctbal < 0 AND c_nationkey = (SELECT n_nationkey FROM nation WHERE n_name = 'EGYPT');
