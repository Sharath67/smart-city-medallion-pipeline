CREATE SCHEMA IF NOT EXISTS bronze;

DROP TABLE IF EXISTS bronze.citizens_raw;

CREATE TABLE bronze.citizens_raw (
    citizen_id INT,
    name TEXT,
    gender TEXT,
    age INT,
    zone TEXT,
    occupation TEXT,
    vehicle_ownership TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);


DROP TABLE IF EXISTS bronze.vehicles_raw;

CREATE TABLE bronze.vehicles_raw (
    vehicle_id INT,
    citizen_id INT,
    vehicle_type TEXT,
    fuel_type TEXT,
    registration_zone TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);


DROP TABLE IF EXISTS bronze.trips_raw;

CREATE TABLE bronze.trips_raw (
    trip_id INT,
    citizen_id INT,
    vehicle_id INT,
    source_zone TEXT,
    destination_zone TEXT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    distance_km NUMERIC(6,2),
    trip_type TEXT,
    updated_at TIMESTAMP
);

DROP TABLE IF EXISTS bronze.bus_trips_raw;

CREATE TABLE bronze.bus_trips_raw (
    bus_trip_id INT,
    bus_route TEXT,
    source_stop TEXT,
    destination_stop TEXT,
    scheduled_start TIMESTAMP,
    actual_start TIMESTAMP,
    actual_end TIMESTAMP,
    occupancy INT,
    updated_at TIMESTAMP
);


DROP TABLE IF EXISTS bronze.pollution_readings_raw;

CREATE TABLE bronze.pollution_readings_raw (
    reading_id INT,
    zone TEXT,
    reading_time TIMESTAMP,
    aqi INT,
    pm25 INT,
    pm10 INT,
    no2 INT,
    co NUMERIC(5,2)
);



