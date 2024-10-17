update 
    sector
set 
    geom = CAST(topo AS geometry); 
--    
update 
    precinct
set 
    geom = CAST(topo AS geometry); 
--
delete from 
    sectorjson;
insert into
    sectorjson (jsonb)
SELECT 
    json_build_object(
        'type', 'FeatureCollection',
        'name', 'sector',
        'features', json_agg(ST_AsGeoJSON(t.*,'geom',5)::json)
    )
FROM ( ( select 
             sector
            ,ST_Reduceprecision(ST_Transform(geom,4326),.000001)
         from 
            sector)
     ) as 
        t(sector, geom);
--
delete from 
    precinctjson;
insert into
    precinctjson (jsonb)
SELECT 
    json_build_object(
        'type', 'FeatureCollection',
        'name', 'precinct',
        'features', json_agg(ST_AsGeoJSON(t.*,'geom',5)::json)
    )
FROM ( ( select 
             precinct
            ,ST_Reduceprecision(ST_Transform(geom,4326),.000001)
         from 
            precinct)
     ) as 
        t(precinct, geom);