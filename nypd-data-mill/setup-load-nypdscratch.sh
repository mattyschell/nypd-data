#!/usr/bin/env bash
psql -v v1=$NYPDPASSWORD -f ./sql/definition/create-users.sql
export PGUSER=nypd
export PGPASSWORD=$NYPDPASSWORD
psql -f ./sql/definition/create-database.sql
export PGDATABASE=nypdscratch
psql -f ./sql/definition/setup-database.sql
psql -f ./sql/definition/create-schemas.sql
# load input shoreline and sectors
psql -f ./sql/data/shoreline.sql
psql -f ./sql/data/nypdsector.sql
# clip nypdsector to shoreline. produces sector
psql -f ./sql/generate/clip-nypdsector.sql
