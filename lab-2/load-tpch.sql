-- if tables werent empty, I would put 'DELETE FROM etc' here

-- Bulk Loading Format
.mode "csv"
.separator "|"
.headers off

-- Import data
.import ./data/customer.tbl customer
.import ./data/lineitem.tbl lineitem
.import ./data/nation.tbl nation
.import ./data/orders.tbl orders
.import ./data/part.tbl part
.import ./data/partsupp.tbl partsupp
.import ./data/region.tbl region
.import ./data/supplier.tbl supplier