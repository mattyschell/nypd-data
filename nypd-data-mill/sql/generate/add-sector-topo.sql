select topology.AddTopoGeometryColumn('gotham'
                                     ,'nypd'
                                     ,'sector'
                                     ,'topo'
                                     ,'polygon');
update 
    sector
set 
    topo = topology.toTopoGeom(geom, 'gotham', 1);
-- at this stage we have nodes connected to 2 edges
-- I think they are like this usually
-- -----> X <------
select
    RemoveUnusedPrimitives('gotham');
select 
    'total number of points in the topology: ' ||
    sum(st_npoints(geom)) as beforesimplification
from 
    gotham.edge;



