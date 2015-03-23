Davical docker image
====================

## How to use this Image

You have to link a postgres database to the container. The users on
the postgres server must exist prior to the container startup. The 
link bust be aliased as "postgres"!

The container exposes port 80 for http. I recommend to use a reverse
proxy to enable ssl!

The container should be configured by environment variables passed.
The variables are:

### `DAVICAL_SERVER_NAME`

The Server name to use. It is used for the apache2 config and for
the administrator email.

### `DAVICAL_DB_NAME`

The name of the postgres database.

### `DAVICAL_DB_USER`

The name of the normal davical database user.

### `DAVICAL_DB_ADMIN`

The name of the davical database admin user.

This is only needed for the cli maintainance scripts.

### `DAVICAL_DB_PASS`

The database password for the normal davical user.

### `DAVICAL_DB_ADMIN_PASS`

The database password of the admin user.

This is only needed for the cli maintainance scripts.


## Example

    docker run -d -P  \
    	-e DAVICAL_SERVER_NAME=example.com \
    	-e DAVICAL_DB_NAME=davical \
    	-e DAVICAL_DB_USER=davical_app \
    	-e DAVICAL_DB_ADMIN=davical_dba \
    	-e DAVICAL_DB_PASS=xxx \
    	-e DAVICAL_DB_ADMIN_PASS=yyy \
    	--link db:postgres \
    	janlo/davical \

