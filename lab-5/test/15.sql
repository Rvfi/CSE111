.headers on
SELECT 
    MAX(l.l_discount) AS max_small_disc
FROM 
    lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
WHERE 
    o.o_orderdate BETWEEN '1994-10-01' AND '1994-10-31'
    AND l.l_discount < (
        SELECT 
            AVG(l.l_discount)
        FROM 
            lineitem l
            JOIN orders o ON l.l_orderkey = o.o_orderkey
        WHERE 
            o.o_orderdate BETWEEN '1994-10-01' AND '1994-10-31'
    );
