#!/usr/bin/env bash
echo "starting setup with user $PGUSER on $PGHOST"
psql -v v1=$NYPDPASSWORD -f ./sql/definition/create-users.sql
export PGUSER=nypd
export PGPASSWORD=$NYPDPASSWORD
psql -f ./sql/definition/create-database.sql
export PGDATABASE=nypdscratch
echo "setting up database and schemas with user $PGUSER on database $PGDATABASE"
psql -f ./sql/definition/setup-database.sql
psql -f ./sql/definition/create-schemas.sql
psql -f ./sql/definition/setup-schemas.sql
# load input shoreline and sectors
echo "loading shoreline and sectors with user $PGUSER on database $PGDATABASE"
psql -f ./sql/data/shoreline.sql
psql -f ./sql/data/nypdsector.sql
# clip nypdsector to shoreline. produces sector
echo "clipping sectors to shoreline with user $PGUSER on database $PGDATABASE"
psql -f ./sql/generate/clip-nypdsector.sql
