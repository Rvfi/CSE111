.headers ON
-- Trigger to reset customer comment to 'Positive balance' when balance becomes positive
CREATE TRIGGER t3
AFTER UPDATE ON customer
WHEN OLD.c_acctbal < 0 AND NEW.c_acctbal >= 0
BEGIN
  UPDATE customer SET c_comment = 'Positive balance' WHERE c_custkey = NEW.c_custkey;
END;

-- Set balances of Mozambican customers to 100
UPDATE customer
SET c_acctbal = 100
WHERE c_nationkey IN (SELECT n_nationkey FROM nation WHERE n_name = 'MOZAMBIQUE');

-- Count negative balance customers in Africa
SELECT COUNT(*) AS customer_cnt
FROM customer
WHERE c_acctbal < 0 AND c_nationkey IN (SELECT n_nationkey FROM nation WHERE n_regionkey = 0);
