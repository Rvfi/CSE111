-- Create Trigger t5 (Adjusted for SQLite syntax)
CREATE TRIGGER t5
BEFORE DELETE ON part
FOR EACH ROW
BEGIN
    DELETE FROM partsupp WHERE ps_partkey = OLD.p_partkey;
    DELETE FROM lineitem WHERE l_partkey = OLD.p_partkey;
END;

-- Delete parts supplied by suppliers from KENYA or MOROCCO (Adjust column names as per your schema)

-- Query the number of parts supplied by each supplier in AFRICA, grouped by country (Adjust column names as per your schema)
