Agendav docker image
====================

This is a docker image of a agendav caldav frontend. The
Project can be found on https://github.com/adobo/agendav/.

It is not configured at all and needs the config dir as a
volume using `-v <path_to_config>:/var/www/agendav/web/config`.

## Configuration

Configuration is done using some environment variables and a
volume with a valid config.


### `DAVICAL_SERVER_NAME`

The Server name to use. It is used for the apache2 config


### `/var/www/agendav/web/config`

This is the location where the config should be mounted.


## Example

Create the Database user and tables (assuming you are using 
the official postgres docker image)

    $ docker run -it --rm \
    	--link davical-postgres:postgres \
    	postgres \
    	sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres '                             
    $ postgres=# CREATE USER agendav WITH PASSWORD 'xxx';
    $ postgres=# CREATE DATABASE agendav ENCODING 'UTF8';
    $ postgres=# GRANT ALL PRIVILEGES ON DATABASE agendav TO agendav;
    $ postgres=# \q


Create the database tables

    $ wget -O- https://raw.githubusercontent.com/janLo/agendav/agendav_running/sql/pgsql.schema.sql | docker run --rm -ti \
        --link davical-postgres:postgres \
        --link boring_nobel:caldav \
        postgres \
    	sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres '                             

Run the webserver

    $ docker run -P -d \
	--name agendav \
   	--link postgres:postgres \
    	--link caldav:caldav \
        janlo/agendav
