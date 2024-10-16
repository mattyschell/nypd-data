create table sector (     
    objectid serial primary key
   ,sector varchar(4)
   ,geom geometry(multipolygon, 2263)
);
create index sectorgeom 
on 
    sector 
using 
    gist(geom);
create table nypdsectorclipped (     
    objectid serial primary key
   ,sector varchar(4)
   ,geom geometry(multipolygon, 2263)
);
create index nypdsectorclippedgeom 
on 
    nypdsectorclipped 
using 
    gist(geom);
create table precinct (     
    objectid serial primary key
   ,precinct varchar(3)
   ,geom geometry(multipolygon, 2263)
);
create index precinctgeom 
on 
    precinct 
using 
    gist(geom);