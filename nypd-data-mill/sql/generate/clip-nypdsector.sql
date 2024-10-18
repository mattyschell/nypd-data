--drop table if exists sector;
-- clip input nypdsector (from nypd)
insert into 
    nypdsectorclipped (sector, geom)
select 
    a.sector as sector
   ,ST_Intersection(a.geom
                   ,(select geom from shoreline)
                   ) as geom
from
    nypdsector a;
-- remove sliver bits
-- in some cases this will change our input shoreline to match whatever 
-- the nypd uses
-- in some cases we will also chomp off our own input shoreline piers on
-- the other side of a waterway but this is ok we do not care
-- at around 10000 area we start losing legit islands near city island
-- dont get (too) greedy
with 
    sectorexploded 
as
    (select 
        sector
        ,(ST_Dump(geom)).geom as geom
    from 
        nypdsectorclipped
    ) 
insert into 
    sector (sector, geom)
select 
    sector
   ,st_collect(geom) as geom 
from 
    sectorexploded
where 
    st_area(geom) > 15000 -- configure area
group by 
    sector;