.headers on
WITH 
Revenues AS (
    SELECT 
        supp_nation.n_name AS supplier_nation,
        SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
    FROM 
        lineitem l
        JOIN orders o ON l.l_orderkey = o.o_orderkey
        JOIN customer c ON o.o_custkey = c.c_custkey
        JOIN nation cust_nation ON c.c_nationkey = cust_nation.n_nationkey
        JOIN region cust_region ON cust_nation.n_regionkey = cust_region.r_regionkey
        JOIN supplier s ON l.l_suppkey = s.s_suppkey
        JOIN nation supp_nation ON s.s_nationkey = supp_nation.n_nationkey
    WHERE 
        l.l_shipdate BETWEEN '1994-01-01' AND '1994-12-31'
        AND cust_region.r_name = 'AMERICA'
    GROUP BY 
        supp_nation.n_name
)
SELECT 
    revenue / (SELECT SUM(revenue) FROM Revenues) AS FRANCE_in_AMERICA_in_1994
FROM 
    Revenues
WHERE 
    supplier_nation = 'FRANCE';
