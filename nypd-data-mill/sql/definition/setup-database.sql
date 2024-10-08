create extension postgis;
create extension postgis_topology;
set search_path to topology,public;
SELECT CreateTopology('gotham'
                     ,2263
                     ,0.001);