# NYPD-DATA

This repository contains New York Police Department Precinct and Sector boundaries that we've processed to optimize for speed and reduced file size.  These boundaries are intended for display on web maps and shouldn't be used where spatial accuracy is a critical requirement.

Click on file names here in Github to preview them.

Sectors nest approximately within precincts.  Both have been clipped to a constant, simplified water shoreline. 

Nodes (intersections of 3 or more line segments) have not been altered from the source data.  We have removed vertices between nodes, and in some cases moved vertices to improve the representation.

All files are in the [WGS84](http://epsg.io/4326) geographic coordinate system.  Files with the extension .geojson are in [GeoJSON](http://geojson.org/) format.  Files with the extension .json are quantized [topojson](https://github.com/topojson/topojson) to further reduce file size.

See the nypd-data-mill directory for details on data generation. 
