psql -v v1=$NYPDPASSWORD -f ./sql/definition/create-users.sql
export PGUSER=nypd
export PGPASSWORD=$NYPDPASSWORD
psql -f ./sql/definition/create-database.sql
export PGDATABASE=nypdscratch
psql -f ./sql/definition/setup-database.sql
psql -f ./sql/definition/create-schemas.sql
psql -f ./sql/data/shoreline.sql
psql -f ./sql/data/nypdsector.sql
