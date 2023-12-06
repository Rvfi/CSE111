-- Create Trigger t3 (Adjusted for SQLite syntax)
CREATE TRIGGER t3
AFTER UPDATE OF c_acctbal ON customer
FOR EACH ROW
WHEN OLD.c_acctbal < 0 AND NEW.c_acctbal >= 0
BEGIN
    UPDATE customer SET comment = 'Positive balance' WHERE c_custkey = NEW.c_custkey;
END;

-- Update balance of customers in MOZAMBIQUE to 100 (Adjust column names as per your schema)

-- Query the number of customers with negative balance in AFRICA (Adjust column names as per your schema)
