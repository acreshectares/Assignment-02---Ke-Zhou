SELECT
    bus_stops.stop_id AS stop_id,
    bus_stops.stop_name AS stop_name,
    bus_stops.stop_lon AS stop_lon,
    bus_stops.stop_lat AS sop_lat
    t.dist || '' || 'meters from' || t.address_name AS stop_desc,
FROM septa.bus_stops
CROSS JOIN LATERAL (
    SELECT
        ST_SETSRID(pwd_parcels.geog::geography, 4326) <-> ST_SETSRID(bus_stops.geog::geography, 4326) AS dist,
        pwd_parcels.address AS address_name
    FROM phl.pwd_parcels
    ORDER BY dist DESC
    LIMIT 1
) AS t
