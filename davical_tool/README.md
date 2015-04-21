Davical docker tool image
=========================

# About this image

This is a tool image to initialize a postgres database
for a davical instance using the `janlo/davical` image.
You can look at the Readme for this image to see all the
relevant options.

For details you can also look at http://wiki.davical.org/index.php/PostgreSQL_Config

The simplest usecase is to create a new davical user and
database:

    $ docker run -it --link <davical-postgres>:postgres --rm postgres /bin/bash
    $ createuser -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres" -W -P <davical_dba>
    $ createuser -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres" -W -P <davical_app>
    $ createdb -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres" -W -P <davical_database>

And then run the init container:

    $ docker run -ti --rm  \
    	-e DAVICAL_SERVER_NAME=example.com \
    	-e DAVICAL_DB_NAME=davical \
    	-e DAVICAL_DB_USER=davical_app \
    	-e DAVICAL_DB_ADMIN=davical_dba \
    	-e DAVICAL_DB_PASS=xxx \
    	-e DAVICAL_DB_ADMIN_PASS=yyy \
    	--link db:postgres \
    	janlo/davical:tool

When it finishes the database is ready.

You cal also provide a (data-only) backup from a previous
davical installation. Then it will load this data instead
of the default data:

    $ docker run -ti --rm  \
    	-e DAVICAL_SERVER_NAME=example.com \
    	-e DAVICAL_DB_NAME=davical \
    	-e DAVICAL_DB_USER=davical_app \
    	-e DAVICAL_DB_ADMIN=davical_dba \
    	-e DAVICAL_DB_PASS=xxx \
    	-e DAVICAL_DB_ADMIN_PASS=yyy \
	-e DAVICAL_BACKUP=/tmp/davical_backup.sql \
    	--link db:postgres \
	-v /path/to/backup.sql:/tmp/davical_backup.sql \
    	janlo/davical:tool
