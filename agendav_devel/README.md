Agendav development/debugging image
===================================

The purpose of this image is to have a "remote"
server for phpstorm for agendav debugging.

## Example

    docker run --rm \
    	-p 8080:80 \
    	-v /home/jan/devel/agendav:/var/www/agendav \
    	-v /tmp/profiler:/tmp/php_profile \
    	-v /tmp/accesslog:/var/log/apache2 \
    	--link davical-postgres:postgres \
    	--link pensive_leakey:caldav \
    	-e PROVIDE_VENDOR=copy \
    	-e AGENDAV_SERVER_NAME=peng \
    	agendav_devel
