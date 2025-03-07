with

septa_bus_stop_blockgroups as (
    select
        stops.stop_id,
        bg.statefp as statefp,
        bg.countyfp as countyfp,
        '1500000US' || bg.geoid as geoid
    from septa.bus_stops as stops
    inner join census.blockgroups_2020 as bg
        on st_dwithin(st_setsrid(stops.geog::geography, 4326), st_setsrid(bg.geog::geography, 4326), 800)
    where bg.statefp::integer = 42 and bg.countyfp::integer = 101
),

septa_bus_stop_surrounding_population as (
    select
        stops.stop_id,
        sum(pop.total) as estimated_pop_800m
    from septa_bus_stop_blockgroups as stops
    inner join census.population_2020 as pop using (geoid)
    group by stops.stop_id
)

select
    stops.stop_name,
    pop.estimated_pop_800m,
    stops.geog
from septa_bus_stop_surrounding_population as pop
inner join septa.bus_stops as stops using (stop_id)
where pop.estimated_pop_800m >= 500
order by pop.estimated_pop_800m asc
limit 8
