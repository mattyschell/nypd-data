-- input any number greater than a few hundred to 
-- Visvalingham-Whyatt accomplishes little additional simplification
-- sectors are mostly composed of almost-straight line segments
update 
    gotham.edge_data
set 
    geom = ST_SimplifyVW(geom, 200)
where 
    left_face <> 0
and right_face <> 0;
update 
    sector 
set 
    geom = CAST(topo AS geometry);
select 
    'total number of points in the topology: ' ||
    sum(st_npoints(geom)) as aftersimplification
from 
    gotham.edge;
select 
    topology.topologysummary('gotham') as topologysummary;
select 
    'topology validity';
select
    error
   ,id1
   ,id2 
from 
    topology.ValidateTopology('gotham');
select 
    count(*) as invalidsectors
from
    sector
where 
    not st_isvalid(geom);
select 
    count(*) as emptysectors
from 
    sector 
where 
    st_isempty(geom);

