select 
    topology.AddTopoGeometryColumn('gotham'
                                  ,'nypd'
                                  ,'precinct'
                                  ,'topo'
                                  ,'polygon'
                                  ,(SELECT 
                                        layer_id(
                                            findLayer('nypd.sector'
                                                     ,'topo')
                                                )
                                    ));
-- BASIC REMINDERS TO SELF
--  add a single sector to a precinct
--   insert into precinct (precinct, topo)
--    values
--    ('113'
--    ,topology.CreateTopoGeom
--        ('gotham'
--        ,3  -- type areal
--        ,2  -- PRECINCT (parent, this) layer id
--       ,'{{235,1}}'::topology.topoelementarray) -- SECTOR (child) topo.id,topo.layer_id
--   );
--     {235,1} 
--     is one or more (topogeo_id, layer_id) records in gotham.relation
--     which in turn point to the face primitives
--
-- NEXT STEP
--  get all the topo elements for precinct 113A,113B,113C,113D
--  select topoelement(topo) from sector
--  where sector like '113_'
--
--  {295,1}    
--  {235,1}   -- see this one above  
--  {198,1}    
--  {97,1}     
--
-- FINAL STEP 
--    aggregate into topoelementarray
--  select topology.TopoElementArray_Agg(topoelement(topo)) 
--  from sector
--  where sector like '113_'
--
--  {{295,1},{235,1},{198,1},{97,1}}
--
-- FINALLY 
--  can't insert a straight topoelementarray
--  must create a topogeom out of it
insert into 
    precinct (precinct
             ,topo)
select
    substring(sector FROM '^[0-9]+')
   ,CreateTopoGeom('gotham'
                  ,3
                  ,(select layer_id(findLayer('nypd.precinct','topo')))
                  ,topology.TopoElementArray_Agg(topoelement(topo))
                  ) 
from 
    sector
group by 
    SUBSTRING(sector FROM '^[0-9]+');



