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


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    try:
        sql = """ CREATE TABLE IF NOT EXISTS warehouse (
                      w_warehousekey DECIMAL(9,0) NOT NULL,
                      w_name CHAR(100) NOT NULL,
                      w_capacity DECIMAL(6,0) NOT NULL,
                      w_suppkey DECIMAL(9,0) NOT NULL,
                      w_nationkey DECIMAL(2,0) NOT NULL
                  ); """
        _conn.execute(sql)
        print("Table created successfully")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")
    try:
        sql = "DROP TABLE IF EXISTS warehouse"
        _conn.execute(sql)
        print("Table dropped successfully")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    try:
        cursor = _conn.cursor()
        supplier_query = """
        SELECT s.s_suppkey, s.s_name, n.n_nationkey, n.n_name, SUM(l.l_quantity * p.p_size) as total_quantity
        FROM supplier s
        JOIN lineitem l ON s.s_suppkey = l.l_suppkey
        JOIN nation n ON s.s_nationkey = n.n_nationkey
        JOIN part p ON l.l_partkey = p.p_partkey
        GROUP BY s.s_suppkey, n.n_nationkey
        ORDER BY s.s_suppkey, total_quantity DESC, n.n_name ASC;
        """
        cursor.execute(supplier_query)
        suppliers_data = cursor.fetchall()

        warehouse_key = 1
        last_suppkey = None
        count = 0
        max_qty = 0

        for row in suppliers_data:
            suppkey, supp_name, nationkey, nation_name, total_qty = row
            if suppkey != last_suppkey:
                last_suppkey = suppkey
                count = 0
                max_qty = 0

            if count < 3:
                if total_qty > max_qty:
                    max_qty = total_qty
                w_name = f"{supp_name}____{nation_name}"
                capacity = 3 * max_qty  # Triple of max part size
                insert_query = """
                INSERT INTO warehouse (w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey)
                VALUES (?, ?, ?, ?, ?);
                """
                cursor.execute(
                    insert_query, (warehouse_key, w_name, capacity, suppkey, nationkey)
                )
                warehouse_key += 1
                count += 1

        _conn.commit()
        print("Table populated successfully")
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    try:
        cursor = _conn.cursor()
        query = "SELECT * FROM warehouse ORDER BY w_warehousekey"
        cursor.execute(query)

        output = open("output/1.out", "w")
        header = "{:>10} {:<40} {:>10} {:>10} {:>10}\n"
        output.write(header.format("wId", "wName", "wCap", "sId", "nId"))

        for row in cursor:
            line = "{:>10} {:<40} {:>10} {:>10} {:>10}\n".format(*row)
            output.write(line)

        output.close()
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    try:
        cursor = _conn.cursor()
        query = """
        SELECT n_name, COUNT(*), SUM(w_capacity) 
        FROM warehouse 
        JOIN nation ON warehouse.w_nationkey = nation.n_nationkey 
        GROUP BY n_name 
        ORDER BY COUNT(*) DESC, SUM(w_capacity) DESC, n_name ASC;
        """
        cursor.execute(query)

        output = open("output/2.out", "w")
        header = "{:<40} {:>10} {:>10}\n"
        output.write(header.format("nation", "numW", "totCap"))

        for row in cursor:
            line = "{:<40} {:>10} {:>10}\n".format(*row)
            output.write(line)

        output.close()
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    try:
        input_file = open("input/3.in", "r")
        nation = input_file.readline().strip()
        input_file.close()

        cursor = _conn.cursor()
        query = """
        SELECT s_name, n_name, w_name 
        FROM warehouse 
        JOIN supplier ON warehouse.w_suppkey = supplier.s_suppkey 
        JOIN nation ON supplier.s_nationkey = nation.n_nationkey 
        WHERE nation.n_name = ? 
        ORDER BY s_name ASC;
        """
        cursor.execute(query, (nation,))

        output = open("output/3.out", "w")
        header = "{:<20} {:<20} {:<40}\n"
        output.write(header.format("supplier", "nation", "warehouse"))

        for row in cursor:
            line = "{:<20} {:<20} {:<40}\n".format(*row)
            output.write(line)

        output.close()
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    try:
        input_file = open("input/4.in", "r")
        region = input_file.readline().strip()
        cap = int(input_file.readline().strip())
        input_file.close()

        cursor = _conn.cursor()
        query = """
        SELECT w.w_name, w.w_capacity 
        FROM warehouse w
        JOIN supplier s ON w.w_suppkey = s.s_suppkey
        JOIN nation n ON s.s_nationkey = n.n_nationkey
        JOIN region r ON n.n_regionkey = r.r_regionkey
        WHERE r.r_name = ? AND w.w_capacity > ?
        ORDER BY w.w_capacity DESC;
        """
        cursor.execute(query, (region, cap))

        output = open("output/4.out", "w")
        header = "{:<40} {:>10}\n"
        output.write(header.format("warehouse", "capacity"))

        for row in cursor:
            line = "{:<40} {:>10}\n".format(*row)
            output.write(line)

        output.close()
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    try:
        input_file = open("input/5.in", "r")
        nation = input_file.readline().strip()
        input_file.close()

        cursor = _conn.cursor()
        query = """
        SELECT r.r_name, COALESCE(SUM(w.w_capacity), 0)
        FROM region r
        LEFT JOIN nation n ON r.r_regionkey = n.n_regionkey
        LEFT JOIN supplier s ON n.n_nationkey = s.s_nationkey
        LEFT JOIN warehouse w ON s.s_suppkey = w.w_suppkey
        WHERE n.n_name = ?
        GROUP BY r.r_name
        ORDER BY r.r_name ASC;
        """
        cursor.execute(query, (nation,))

        output = open("output/5.out", "w")
        header = "{:<20} {:>20}\n"
        output.write(header.format("region", "capacity"))

        for row in cursor:
            line = "{:<20} {:>20}\n".format(*row)
            output.write(line)

        output.close()
    except Error as e:
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)
        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)
    closeConnection(conn, database)


if __name__ == "__main__":
    main()
