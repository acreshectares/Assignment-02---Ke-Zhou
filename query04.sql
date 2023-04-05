WITH bus_length AS(
	SELECT 
		shapes.shape_id AS shape_id,
		ST_MakeLine(array_agg(ST_SetSRID(ST_MakePoint(shapes.shape_pt_lon, shapes.shape_pt_lat),4326) ORDER BY shapes.shape_pt_sequence)) AS shape_geog,
		ST_Length(ST_MakeLine(array_agg(ST_SetSRID(ST_MakePoint(shapes.shape_pt_lon, shapes.shape_pt_lat),4326) ORDER BY shapes.shape_pt_sequence))) AS shape_length
	FROM septa.bus_shapes AS shapes
	GROUP BY shapes.shape_id)
SELECT DISTINCT
  routes.route_short_name, 
  trips.trip_headsign,
  len.shape_length,
  len.shape_geog
  FROM bus_length AS len
  JOIN septa.bus_trips AS trips ON len.shape_id = trips.shape_id
  JOIN septa.bus_routes AS routes ON trips.route_id = routes.route_id
  ORDER BY shape_length DESC
  LIMIT 2


SELECT AS route_short_name
AS trip_headsign
AS shape_geog
AS shape_length
FROM septa.bus_stops
CROSS JOIN LATERAL (
  SELECT AS

  FROM phl.pwd_parcels 
  ORDER BY shape_length DESC
  LIMIT 2

SELECT shape_id, ST_MakeLine(array_agg(
  ST_SetSRID(ST_MakePoint(shape_pt_lon, shape_pt_lat),4326) ORDER BY shape_pt_sequence))
FROM shapes
GROUP BY shape_id
ORDER BY shape_length DESC
LIMIT 2