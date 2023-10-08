.headers on
SELECT 
    p.p_name AS part
FROM 
    lineitem l
    JOIN part p ON l.l_partkey = p.p_partkey
WHERE 
    l.l_shipdate > '1993-10-02'
    AND l.l_extendedprice * (1 - l.l_discount) = 
        (SELECT MAX(l_extendedprice * (1 - l_discount)) 
         FROM lineitem 
         WHERE l_shipdate > '1993-10-02');
