#!/usr/bin/env bash
export SURVIVINGUSER=$PGUSER
export SURVIVINGPASSWORD=$PGPASSWORD
export PGUSER=nypd
export PGPASSWORD=$NYPDPASSWORD
psql -c "drop database nypdscratch"
export PGUSER=$SURVIVINGUSER
export PGPASSWORD=$SURVIVINGPASSWORD
psql -c "drop user nypd;"