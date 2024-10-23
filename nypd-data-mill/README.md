## nypd-data-mill

We use PostGIS topology to generate this data. We used Oracle Spatial topology in the past.

### Required Inputs

* New York Police Department (NYPD) sectors
* New York City shoreline polygon dataset
* PostgreSQL database with postgis and postgis_topology

### Outline

1. Set up a scratch database
2. Load sectors
3. Load shoreline
4. Clip sectors to shoreline (removes water)
5. Add sectors to topology
6. Simplify interior edges
7. Generate sectors and precincts from the topology
8. Export to geojson

Then use [mapshaper.org](https://mapshaper.org/) to review line intersections and produce topojson. Two tips/reminders on this:

* Beginning manual edits crosses the Rubicon from code to clicks. Once begun we can't (easily) go back to revisit automated steps.
* Best practice when editing is to remove points from both sector.geojson and precinct.geojson.  Usually we do this to both datasets simultaneously along the shoreline.  The alternative, moving coordinates, is too complicated to attempt when we are freeform editing two partially coincident datasets. 


### Setup

We usually receive a new NYPD sector dataset directly from the NYPD. Convert it to a shapefile if that's not the format provided. Then produce a new /sql/data/nypdsector.sql from the shapefile. Here's a sample shp2pgsql.

```shell
shp2pgsql -s 2263 -c nypdsector.shp nypdsector > ../../sql/data/nypdsector.sql
```

Run setup and load script. 

```shell
$ export NYPDPASSWORD=<samplepassword1>
$ export PGUSER=****
$ export PGPASSWORD=****
$ export PGHOST=****
$ export PGDATABASE=postgres
./setup-load-nypdscratch.sh
```

### Simplify and generate geojson

```shell
$ export PGUSER=nypd
$ export PGPASSWORD=<samplepassword1>
$ export PGHOST=****
$ export PGDATABASE=nypdscratch
./generate-nypd-data.sh
```

The output sector.geojson and precinct.geojson will likely be afflicted with a few self-intersections. Fix these either by manually editing the geojson or by tweaking the inputs and re-running the entire process.

### Teardown scratch database

```shell
$ export NYPDPASSWORD=<samplepassword1>
$ export PGUSER=****
$ export PGPASSWORD=****
$ export PGHOST=****
$ export PGDATABASE=postgres
./teardown-nypdscratch.sh
```

### Secret Executive Decisions

* Sector 43A includes a disjoint water polygon on the Westchester Creek in the Bronx. This all water polygon interacts poorly with the shoreline layer, in effect creating its own shoreline.  We removed this part of the sector manually from the inputs.
* The boundary of sector 63A/63B is also on the shoreline on the south side of Mill Basin. We removed piers from the input sectors to prevent messy interactions with our simplified input shoreline piers.

