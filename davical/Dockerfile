# davical
FROM debian:jessie

MAINTAINER Jan Losinski <losinski@wh2.tu-dresden.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		apache2 \
		libapache2-mod-php5 \
		davical && \
	apt-get clean

COPY davical.conf /etc/apache2/sites-available/davical.conf
COPY example-config.php /etc/davical/config_real.php
COPY run /usr/local/bin/run_container

RUN a2enmod php5 && \
	a2ensite davical && \
	a2dissite 000-default

	
ENV DAVICAL_SERVER_NAME example.com
ENV DAVICAL_DB_NAME davical
ENV DAVICAL_DB_USER davical_app
ENV DAVICAL_DB_ADMIN davical_dba
ENV DAVICAL_DB_PASS XXX

VOLUME [ "/etc/davical" ]

EXPOSE 80 

ENTRYPOINT ["/usr/local/bin/run_container"]
