import csv
import os
from datetime import datetime
import psycopg2

# ---------- CONFIG ----------
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BRONZE_DIR = os.path.join(BASE_DIR, "bronze_inputs")

conn = psycopg2.connect(
    host="localhost",
    port="5432",
    dbname="smart_city_dw",    
    user="postgres",
    password="Sharath@4708"
)

TIMESTAMP_COLUMNS = {
    "citizens_raw": ["created_at", "updated_at"],
    "vehicles_raw": ["created_at", "updated_at"],
    "trips_raw": ["start_time", "end_time", "updated_at"],
    "bus_trips_raw": ["scheduled_start", "actual_start", "actual_end", "updated_at"],
    "pollution_readings_raw": ["reading_time"]
}
def parse_ts(value):
    if value is None or value == "":
        return None

    try:
        # Case 1: date + time
        return datetime.strptime(value, "%m/%d/%Y %H:%M:%S")
    except ValueError:
        # Case 2: date only
        return datetime.strptime(value, "%m/%d/%Y")


def load_csv(table_name, columns, csv_file):
    path = os.path.join(BRONZE_DIR, csv_file)
    cur = conn.cursor()

    with open(path, "r") as f:
        reader = csv.DictReader(f)
        for row in reader:
            values = []
            for col in columns:
                val = row[col]
                if col in TIMESTAMP_COLUMNS.get(table_name, []):
                    val = parse_ts(val)
                values.append(val)

            placeholders = ",".join(["%s"] * len(columns))
            cur.execute(
                f"INSERT INTO bronze.{table_name} VALUES ({placeholders})",
                values
            )

    conn.commit()
    print(f"Loaded {table_name}")

# ---------- LOAD ALL TABLES ----------

def load_bronze():
    load_csv(
        "citizens_raw",
        ["citizen_id","name","gender","age","zone","occupation",
         "vehicle_ownership","created_at","updated_at"],
        "citizens_raw.csv"
    )

    load_csv(
        "vehicles_raw",
        ["vehicle_id","citizen_id","vehicle_type","fuel_type",
         "registration_zone","created_at","updated_at"],
        "vehicles_raw.csv"
    )

    load_csv(
        "trips_raw",
        ["trip_id","citizen_id","vehicle_id","source_zone",
         "destination_zone","start_time","end_time",
         "distance_km","trip_type","updated_at"],
        "trips_raw.csv"
    )

    load_csv(
        "bus_trips_raw",
        ["bus_trip_id","bus_route","source_stop","destination_stop",
         "scheduled_start","actual_start","actual_end",
         "occupancy","updated_at"],
        "bus_trips_raw.csv"
    )

    load_csv(
        "pollution_readings_raw",
        ["reading_id","zone","reading_time","aqi","pm25","pm10","no2","co"],
        "pollution_readings_raw.csv"
    )

    print("BRONZE LOAD COMPLETED")


if __name__ == "__main__":
    load_bronze()
    conn.close()
