-- Create Triggers for o_orderpriority (Adjusted for SQLite syntax)
-- (Add or delete lineitem tuples)

-- Delete line items corresponding to orders from December 1995 using strftime
DELETE FROM lineitem WHERE l_orderkey IN (SELECT o_orderkey FROM orders WHERE strftime('%m', o_orderdate) = '12' AND strftime('%Y', o_orderdate) = '1995');

-- Query the number of HIGH priority orders between September and December 1995 using strftime
