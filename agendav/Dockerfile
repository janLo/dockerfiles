# agendav
FROM janlo/apache_base

MAINTAINER Jan Losinski <losinski@wh2.tu-dresden.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		php5-pgsql \
		php5-mcrypt \
		php5-curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY agendav.conf /etc/apache2/sites-available/agendav.conf

RUN a2ensite agendav && \
	a2dissite 000-default && \
	a2enmod rewrite

RUN cd /var/www && \
	apt-get update && \
	apt-get -y install --no-install-recommends unzip curl git ca-certificates && \
	git clone --branch agendav_running https://github.com/janLo/agendav.git && \
	apt-get -y remove --purge ca-certificates unzip git curl && \
	apt-get -y autoremove --purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN chown -R www-data:www-data /var/www/agendav/

COPY run /usr/local/bin/run_container

EXPOSE 80 

VOLUME ["/var/www/agendav/web/config"]
ENTRYPOINT ["/usr/local/bin/run_container"]
CMD ["apache2"]
