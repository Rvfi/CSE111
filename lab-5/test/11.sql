.headers on
SELECT 
    SUM(ps.ps_supplycost) AS total_supply_cost
FROM 
    partsupp ps
    JOIN part p ON ps.ps_partkey = p.p_partkey
    JOIN lineitem l ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
    LEFT JOIN (
        SELECT DISTINCT l2.l_suppkey
        FROM lineitem l2
        WHERE l2.l_shipdate BETWEEN '1997-01-01' AND '1997-12-31'
        AND l2.l_extendedprice * (1 - l2.l_discount) < 1000
    ) excluded_suppliers ON ps.ps_suppkey = excluded_suppliers.l_suppkey
WHERE 
    p.p_retailprice < 2000
    AND l.l_shipdate BETWEEN '1994-01-01' AND '1994-12-31'
    AND excluded_suppliers.l_suppkey IS NULL;
