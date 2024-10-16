-- any number greater than ~100 input to 
-- Visvalingham-Whyatt accomplishes little additional simplification
-- sectors are mostly composed of almost-straight line segments
-- call at 1,10,100,1000 (see integer array below)
DO $$
DECLARE
    row RECORD;
    retval text;
    vals INTEGER[] := ARRAY[1,10,100,1000]; 
    v INTEGER; 
BEGIN
    FOREACH v IN ARRAY vals 
    LOOP 
        FOR row IN select 
                       edge_id
                      ,geom 
                   from  
                       gotham.edge_data 
                   where 
                       left_face <> 0 
                   and right_face <> 0 
        LOOP
            BEGIN
                select 
                    topology.ST_ChangeEdgeGeom('gotham'
                                              ,row.edge_id
                                              ,ST_SimplifyVW(row.geom, v)) 
                into retval;
            EXCEPTION
                WHEN others THEN
                    -- usually this sort of thing
                    -- some sort of corner being turned at a node
                    -- Error processing row with edge_id 48: SQL/MM Spatial exception - coincident edge 47
                    RAISE NOTICE 'Error processing row with edge_id %: %'
                                 ,row.edge_id
                                 ,SQLERRM;
            END;
        END LOOP;
    END LOOP;
END $$;
--
update 
    sector 
set 
    geom = CAST(topo AS geometry);
select 
    'total number of points in the topology: ' ||
    sum(st_npoints(geom)) as aftersimplification
from 
    gotham.edge;
--
select 
    topology.topologysummary('gotham') as topologysummary;
select 
    'topology validity';
--
select
    error
   ,id1
   ,id2 
from 
    topology.ValidateTopology('gotham');
-- at least one bad face MBR
-- ST_SetFaceMbr doesnt exist for me in 3.4 for some reason
-- consider adding that correction here
--
select 
    count(*) as invalidornullsectors
from
    sector
where 
   not st_isvalid(geom)
   or st_isempty(geom);

