## nypd-data-mill

We'll use PostGIS topology for the next generations of this data. We used Oracle Spatial topology in the past.

### Required Inputs

* nypd sectors
* shoreline polygon dataset
* PostgreSQL database with postgis 

### Outline

1. Set up a scratch database
2. Import sectors
3. Import shoreline
4. Clip sectors to shoreline
5. Add sectors to topology
6. Simplify interior edges
7. Generate sectors
8. Dissolve sectors to form precincts



