create schema if not exists nypd;
grant usage on schema 
    nypd 
to 
    public;
revoke create on schema 
    public 
from 
    public;