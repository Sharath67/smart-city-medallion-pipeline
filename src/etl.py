import os
import psycopg2
from load_bronze import load_bronze, conn

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SQL_DIR = os.path.join(BASE_DIR, "sql")

def run_sql(file_name):
    path = os.path.join(SQL_DIR, file_name)
    with open(path, "r") as f:
        sql = f.read()
    cur = conn.cursor()
    cur.execute(sql)
    conn.commit()
    print(f"Executed {file_name}")

def run_pipeline():
    print("Starting ETL Pipeline")

    print("Loading Bronze Layer")
    load_bronze()

    print("Building Silver Layer")
    run_sql("silver.sql")

    print("Building Gold Layer")
    run_sql("gold.sql")

    conn.close()
    print("ETL PIPELINE COMPLETED SUCCESSFULLY")


if __name__ == "__main__":
    run_pipeline()
