.headers on
SELECT 
    p.p_name AS part
FROM 
    partsupp ps
    JOIN part p ON ps.ps_partkey = p.p_partkey
    JOIN supplier s ON s.s_suppkey = ps.ps_suppkey
    JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE 
    n.n_name = 'FRANCE'
    AND ps.ps_supplycost * ps.ps_availqty >= 
        (SELECT 
            ps_supplycost * ps_availqty AS total_value
         FROM 
            partsupp
         ORDER BY 
            total_value DESC
         LIMIT 1 OFFSET (SELECT COUNT(*) FROM partsupp) * 5 / 100);
