.headers on
WITH RankedSuppliers AS (
    SELECT 
        s.s_name,
        p.p_size,
        ps.ps_supplycost,
        ROW_NUMBER() OVER (PARTITION BY p.p_size ORDER BY ps.ps_supplycost DESC) AS ranking
    FROM 
        part p
        JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
        JOIN supplier s ON s.s_suppkey = ps.ps_suppkey
        JOIN nation n ON s.s_nationkey = n.n_nationkey
        JOIN region r ON n.n_regionkey = r.r_regionkey
    WHERE 
        p.p_type LIKE '%STEEL%'
        AND r.r_name = 'AMERICA'
)
SELECT 
    s_name AS supplier,
    p_size AS part_size,
    ps_supplycost AS max_cost
FROM 
    RankedSuppliers
WHERE 
    ranking = 1;
