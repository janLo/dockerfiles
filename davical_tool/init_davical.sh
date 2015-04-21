#!/bin/bash

# http://wiki.davical.org/index.php/PostgreSQL_Config

PGPASSWORD=${DAVICAL_DB_ADMIN_PASS}
DAVICAL_BACKUP=${DAVICAL_BACKUP:-/tmp/davical_backup.sql}
POSTGRES_HOST=${POSTGRES_HOST:-postgres}

psql -qXAt -U ${DAVICAL_DB_ADMIN} -h ${POSTGRES_HOST} ${DAVICAL_DB_NAME} < /usr/share/awl/dba/awl-tables.sql 
psql -qXAt -U ${DAVICAL_DB_ADMIN} -h ${POSTGRES_HOST} ${DAVICAL_DB_NAME} < /usr/share/awl/dba/schema-management.sql
psql -qXAt -U ${DAVICAL_DB_ADMIN} -h ${POSTGRES_HOST} ${DAVICAL_DB_NAME} < /usr/share/davical/dba/davical.sql 

/usr/share/davical/dba/update-davical-database \
    --dbname ${DAVICAL_DB_NAME} \
    --dbuser ${DAVICAL_DB_ADMIN} \
    --dbhost ${POSTGRES_HOST} \
    --dbpass ${DAVICAL_DB_ADMIN_PASS} \
    --appuser ${DAVICAL_DB_USER} \
    --nopatch \
    --owner ${DAVICAL_DB_ADMIN}

if [ -e "${DAVICAL_BACKUP}" ]; then
    psql -qXAt -U ${DAVICAL_DB_ADMIN} -h ${POSTGRES_HOST} ${DAVICAL_DB_NAME} < ${DAVICAL_BACKUP}
else
    psql -qXAt -U ${DAVICAL_DB_ADMIN} -h ${POSTGRES_HOST} ${DAVICAL_DB_NAME} < /usr/share/davical/dba/base-data.sql 
    psql -qX   -U ${DAVICAL_DB_ADMIN} -h ${POSTGRES_HOST} -c "UPDATE usr SET password = '**YOURADMINPASSWORD' WHERE user_no = 1;" ${DAVICAL_DB_NAME}
fi

