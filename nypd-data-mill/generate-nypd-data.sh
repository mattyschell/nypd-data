#!/usr/bin/env bash
psql -f ./sql/generate/add-sector-topo.sql
psql -f ./sql/generate/simplify-sector-topo.sql
psql -f ./sql/generate/add-precinct-topo.sql

