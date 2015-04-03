FROM janlo/agendav

MAINTAINER Jan Losinski <losinski@wh2.tu-dresden.de>

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		php5-xdebug \
	&& \
	apt-get clean

COPY run /usr/local/bin/run_container
RUN cp -a /var/www/agendav/web/vendor /var/www/agendav_web_vendor

VOLUME ["/var/www/agendav", "/tmp/php_profile"]
