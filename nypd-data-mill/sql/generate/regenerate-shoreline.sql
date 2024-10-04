-- to maintain a constant shoreline
-- we can regenerate shoreline from the previously generated
-- output data
-- PRE STEP
--   load precincts as "precincttodissolve"
drop table if exists shoreline;
--
create table shoreline (     
    objectid serial primary key
   ,geom geometry(multipolygon, 2263)
);
-- 
create index shorelinegeom 
on 
    shoreline 
using 
    gist(geom);
--
with shorelinewithinteriorrings 
as (
    select 
        st_union(geom) as geom
    from 
        precincttodissolve
   )   
insert into 
    shoreline (geom)
select 
    st_union(geom) as geom 
from (
      select 
          st_makepolygon(st_exteriorring((ST_Dump(geom)).geom)) as geom
      from 
          shorelinewithinteriorrings)
-- optional cleanup
-- drop table precincttodissolve