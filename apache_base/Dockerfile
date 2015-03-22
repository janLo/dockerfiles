# davical
FROM debian:jessie

MAINTAINER Jan Losinski <losinski@wh2.tu-dresden.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		apache2 \
		libapache2-mod-php5 && \
	apt-get clean

RUN a2enmod php5

EXPOSE 80 

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
