Agendav docker image
====================

This is a docker image of a agendav caldav frontend. The
Project can be found on https://github.com/adobo/agendav/.

It is configured to use a postgres database and a caldav
server that is reachable via docker container linking.

## Configuration

Configuration is done using some environment variables:


### `DAVICAL_SERVER_NAME`

The Server name to use. It is used for the apache2 config

### `AGENDAV_TITLE`

The title of the agendav installation

### `AGENDAV_FOOTER`

The Footer text of the installation

### `AGENDAV_DB_NAME`

The name of the database

### `AGENDAV_DB_USER`

The database user

### `AGENDAV_DB_PASSWORD`

The database password

### `AGENDAV_ENC_KEY`

The encryption key for the instance

### `AGENDAV_CALDAV_SERVER`

The caldav url for public caldav links

### `AGENDAV_TIMEZONE`

The timezone

### `AGENDAV_LANG`

The language to use



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

    $ docker run --rm -ti \
        -e AGENDAV_TITLE="My Agendav" \
        -e AGENDAV_FOOTER="Simple calendar server" \
        -e AGENDAV_DB_NAME="agendav" \
        -e AGENDAV_DB_USER="agendav" \
        -e AGENDAV_DB_PASSWORD="xxx" \
        -e AGENDAV_ENC_KEY="emaePie2thi5aipaizee" \
        -e AGENDAV_CALDAV_SERVER="https://my.caldav.com/" \
        -e AGENDAV_TIMEZONE="Europe/Berlin" \
        -e AGENDAV_LANG="de" \
        --link davical-postgres:postgres \
        --link boring_nobel:caldav \
        agendav \
    	bash -c "cd /var/www/agendav/bin && ./agendavcli  migrations:migrate"  

Run the webserver

    $ docker run -P -d \
	--name agendav \
    	-e AGENDAV_TITLE="My Agendav" \
    	-e AGENDAV_FOOTER="Simple calendar server" \
    	-e AGENDAV_DB_NAME="agendav" \
    	-e AGENDAV_DB_USER="agendav" \
    	-e AGENDAV_DB_PASSWORD="xxx" \
    	-e AGENDAV_ENC_KEY="emaePie2thi5aipaizee" \
    	-e AGENDAV_CALDAV_SERVER="https://my.caldav.com/" \
    	-e AGENDAV_TIMEZONE="Europe/Berlin" \
    	-e AGENDAV_LANG="de" \
   	--link postgres:postgres \
    	--link caldav:caldav \
        janlo/agendav
