-- GOLD LAYER

DROP SCHEMA IF EXISTS gold CASCADE;
CREATE SCHEMA gold;

CREATE TABLE gold.city_dashboard_facts AS
SELECT
    t.date,
    t.zone,
    t.total_trips,
    t.avg_distance_km,
    p.avg_aqi,
    b.total_bus_passengers,
    b.avg_bus_delay_minutes
FROM silver.trips_daily t
LEFT JOIN silver.pollution_daily p
    ON t.date = p.date AND t.zone = p.zone
LEFT JOIN silver.bus_daily_metrics b
    ON t.date = b.date AND t.zone = b.zone;

-- DROP TABLE IF EXISTS gold.bus_service_reliability_facts;

CREATE TABLE gold.bus_service_reliability_facts AS
SELECT
    date,
    bus_route,
    COUNT(*) AS total_bus_trips,
    ROUND(AVG(delay_minutes), 2) AS avg_delay_minutes,
    ROUND(
        100.0 * SUM(
            CASE WHEN delay_minutes <= 5 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2 
    ) AS on_time_percentage,
    ROUND(AVG(occupancy), 2) AS avg_occupancy

FROM silver.bus_trips_route_clean
GROUP BY date, bus_route;

select * from gold.bus_service_reliability_facts
