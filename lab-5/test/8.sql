.headers on
SELECT p.p_mfgr AS manufacturer
FROM part p
JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN supplier s ON ps.ps_suppkey = s.s_suppkey
WHERE s.s_name = 'Supplier#000000040'
ORDER BY ps.ps_availqty ASC
LIMIT 1;


