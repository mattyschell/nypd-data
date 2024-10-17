#!/usr/bin/env bash
echo "generating topology and simplifying with user $PGUSER on database $PGDATABASE on $PGHOST"
psql -f ./sql/generate/add-sector-topo.sql
psql -f ./sql/generate/simplify-sector-topo.sql
psql -f ./sql/generate/add-precinct-topo.sql
psql -f ./sql/generate/delayed-calculations.sql
echo "exporting sector.geojson and precinct.geojson"
psql -c "\copy (SELECT jsonb FROM sectorjson) TO '../sector.geojson';"
psql -c "\copy (SELECT jsonb FROM precinctjson) TO '../precinct.geojson';"



