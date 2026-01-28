-- SILVER LAYER

DROP SCHEMA IF EXISTS silver CASCADE;
CREATE SCHEMA IF not EXISTS silver;

-- Trips
CREATE TABLE silver.trips_daily AS
SELECT
    DATE(start_time) AS date,
    source_zone AS zone,
    COUNT(*) AS total_trips,
    ROUND(AVG(distance_km), 2) AS avg_distance_km
FROM bronze.trips_raw
GROUP BY 1, 2;

-- Bus trips (delay)
CREATE TABLE silver.bus_trips_clean AS
SELECT
    DATE(scheduled_start) AS date,
    source_stop AS zone,
    occupancy,
    EXTRACT(EPOCH FROM (actual_start - scheduled_start)) / 60 AS delay_minutes
FROM bronze.bus_trips_raw;

CREATE TABLE silver.bus_daily_metrics AS
SELECT
    date,
    zone,
    SUM(occupancy) AS total_bus_passengers,
    ROUND(AVG(delay_minutes), 2) AS avg_bus_delay_minutes
FROM silver.bus_trips_clean
GROUP BY 1, 2;

-- Pollution
CREATE TABLE silver.pollution_daily AS
SELECT
    DATE(reading_time) AS date,
    zone,
    ROUND(AVG(aqi), 2) AS avg_aqi
FROM bronze.pollution_readings_raw
GROUP BY 1, 2;


CREATE TABLE IF NOT EXISTS silver.bus_trips_route_clean AS
SELECT
    DATE(scheduled_start) AS date,
    bus_route,
    EXTRACT(EPOCH FROM (actual_start - scheduled_start)) / 60 AS delay_minutes,
    occupancy
FROM bronze.bus_trips_raw
WHERE actual_start IS NOT NULL
  AND scheduled_start IS NOT NULL;