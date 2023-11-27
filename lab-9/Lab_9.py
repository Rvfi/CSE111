import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)
    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")
    return conn


def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)
    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def create_View1(_conn):
    try:
        sql = """
        CREATE VIEW V1 AS
        SELECT c.c_custkey, c.c_name, c.c_address, c.c_phone, c.c_acctbal, c.c_mktsegment, c.c_comment, n.n_name AS nation, r.r_name AS region
        FROM customer c
        JOIN nation n ON c.c_nationkey = n.n_nationkey
        JOIN region r ON n.n_regionkey = r.r_regionkey;
        """
        _conn.execute(sql)
    except Error as e:
        print(e)


def create_View2(_conn):
    try:
        sql = """
        CREATE VIEW V2 AS
        SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, strftime('%Y', o_orderdate) AS o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment
        FROM orders;
        """
        _conn.execute(sql)
    except Error as e:
        print(e)


def create_View4(_conn):
    try:
        sql = """
        CREATE VIEW V4 AS
        SELECT s_name AS supplier, COUNT(*) AS cnt
        FROM partsupp, supplier, nation, part
        WHERE p_partkey = ps_partkey AND ps_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'KENYA' AND p_container LIKE '%BOX%'
        GROUP BY s_name;
        """
        _conn.execute(sql)
    except Error as e:
        print(e)


def create_View10(_conn):
    try:
        sql = """
        CREATE VIEW V10 AS
        SELECT p_type AS part_type, MIN(l_discount) AS min_disc, MAX(l_discount) AS max_disc
        FROM lineitem, part
        WHERE l_partkey = p_partkey AND (p_type LIKE '%ECONOMY%' OR p_type LIKE '%COPPER%')
        GROUP BY p_type;
        """
        _conn.execute(sql)
    except Error as e:
        print(e)


def create_View111(_conn):
    try:
        sql = """
        CREATE VIEW V111 AS
        SELECT c_name AS customer, COUNT(*) AS order_cnt
        FROM orders, customer
        WHERE o_custkey = c_custkey
        GROUP BY c_name;
        """
        _conn.execute(sql)
    except Error as e:
        print(e)


def create_View112(_conn):
    try:
        sql = """
        CREATE VIEW V112 AS
        SELECT s_name AS supplier, MAX(s_acctbal) AS max_bal
        FROM supplier
        GROUP BY s_name;
        """
        _conn.execute(sql)
    except Error as e:
        print(e)


def query_execution(_conn, query, output_file):
    try:
        output = open(output_file, "w")
        cursor = _conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        for row in rows:
            output.write("|".join(map(str, row)) + "\n")
        output.close()
    except Error as e:
        print(e)


def Q1(_conn):
    query_execution(_conn, "SELECT * FROM V1;", "output/1.out")


def Q2(_conn):
    query_execution(_conn, "SELECT * FROM V2;", "output/2.out")


def Q3(_conn):
    query_execution(
        _conn,
        "SELECT c_name AS customer, sum(o_totalprice) AS total_price FROM orders, customer WHERE o_custkey = c_custkey GROUP BY c_name;",
        "output/3.out",
    )


def Q4(_conn):
    query_execution(_conn, "SELECT * FROM V4;", "output/4.out")


def Q5(_conn):
    query_execution(
        _conn,
        "SELECT n_name AS country, COUNT(*) AS cnt FROM supplier, nation WHERE s_nationkey = n_nationkey AND (n_name = 'ARGENTINA' OR n_name = 'BRAZIL') GROUP BY n_name;",
        "output/5.out",
    )


def Q6(_conn):
    query_execution(
        _conn,
        "SELECT s_name AS supplier, o_orderpriority AS priority, COUNT(DISTINCT ps_partkey) AS parts FROM partsupp, orders, lineitem, supplier, nation WHERE l_orderkey = o_orderkey AND l_partkey = ps_partkey AND l_suppkey = ps_suppkey AND ps_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'INDONESIA' GROUP BY s_name, o_orderpriority;",
        "output/6.out",
    )


def Q7(_conn):
    query_execution(
        _conn,
        "SELECT n_name AS country, o_orderstatus AS status, COUNT(*) AS orders FROM orders, customer, nation, region WHERE o_custkey = c_custkey AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name='AFRICA' GROUP BY n_name, o_orderstatus;",
        "output/7.out",
    )


def Q8(_conn):
    query_execution(
        _conn,
        "SELECT COUNT(DISTINCT o_clerk) AS clerks FROM orders, supplier, nation, lineitem WHERE o_orderkey = l_orderkey AND l_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'PERU';",
        "output/8.out",
    )


def Q9(_conn):
    query_execution(
        _conn,
        "SELECT n_name AS country, COUNT(DISTINCT l_orderkey) AS cnt FROM orders, nation, supplier, lineitem, region WHERE o_orderkey = l_orderkey AND l_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND o_orderstatus = 'F' AND o_orderdate LIKE '1993-%' AND r_name = 'AFRICA' GROUP BY n_name HAVING cnt > 200;",
        "output/9.out",
    )


def Q10(_conn):
    query_execution(_conn, "SELECT * FROM V10;", "output/10.out")


def Q11(_conn):
    query_execution(
        _conn,
        "SELECT COUNT(DISTINCT l_orderkey) AS order_cnt FROM lineitem, supplier, orders, customer WHERE l_suppkey = s_suppkey AND l_orderkey = o_orderkey AND o_custkey = c_custkey AND c_acctbal < 0 AND s_acctbal > 0;",
        "output/11.out",
    )


def Q12(_conn):
    query_execution(
        _conn,
        "SELECT r_name AS region, MAX(s_acctbal) AS max_bal FROM supplier, nation, region WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey GROUP BY r_name HAVING max_bal > 9000;",
        "output/12.out",
    )


def Q13(_conn):
    query_execution(
        _conn,
        "SELECT r1.r_name AS supp_region, r2.r_name AS cust_region, MIN(o_totalprice) AS min_price FROM lineitem, supplier, orders, customer, nation n1, region r1, nation n2, region r2 WHERE l_suppkey = s_suppkey AND s_nationkey = n1.n_nationkey AND n1.n_regionkey = r1.r_regionkey AND l_orderkey = o_orderkey AND o_custkey = c_custkey AND c_nationkey = n2.n_nationkey AND n2.n_regionkey = r2.r_regionkey GROUP BY r1.r_name, r2.r_name;",
        "output/13.out",
    )


def Q14(_conn):
    query_execution(
        _conn,
        "SELECT COUNT(*) AS items FROM orders, lineitem, customer, supplier, nation n1, region, nation n2 WHERE o_orderkey = l_orderkey AND o_custkey = c_custkey AND l_suppkey = s_suppkey AND s_nationkey = n1.n_nationkey AND n1.n_regionkey = r_regionkey AND c_nationkey = n2.n_nationkey AND r_name = 'ASIA' AND n2.n_name = 'KENYA';",
        "output/14.out",
    )


def Q15(_conn):
    query_execution(
        _conn,
        "SELECT r.r_name AS region, s.s_name AS supplier, s.s_acctbal AS acct_bal FROM supplier s, nation n, region r WHERE s.s_nationkey = n.n_nationkey AND n.n_regionkey = r.r_regionkey AND s.s_acctbal = (SELECT MAX(s1.s_acctbal) FROM supplier s1, nation n1, region r1 WHERE s1.s_nationkey = n1.n_nationkey AND n1.n_regionkey = r1.r_regionkey AND r.r_regionkey = r1.r_regionkey);",
        "output/15.out",
    )


def main():
    database = r"tpch.sqlite"
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)
        create_View2(conn)
        Q2(conn)
        create_View4(conn)
        Q4(conn)
        create_View10(conn)
        Q10(conn)
        create_View111(conn)
        create_View112(conn)
        Q3(conn)
        Q5(conn)
        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)
        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)
        Q15(conn)
    closeConnection(conn, database)


if __name__ == "__main__":
    main()
