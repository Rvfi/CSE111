-- Create Trigger t2 (Adjusted for SQLite syntax)
CREATE TRIGGER t2
AFTER UPDATE OF c_acctbal ON customer
FOR EACH ROW
WHEN OLD.c_acctbal >= 0 AND NEW.c_acctbal < 0
BEGIN
    UPDATE customer SET comment = 'Negative balance!!!' WHERE c_custkey = NEW.c_custkey;
END;

-- Update balance of all customers in AFRICA to -100 (Adjust column names as per your schema)

-- Query the number of customers with negative balance in EGYPT (Adjust column names as per your schema)
