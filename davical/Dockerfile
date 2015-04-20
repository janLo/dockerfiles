# davical
FROM janlo/apache_base

MAINTAINER Jan Losinski <losinski@wh2.tu-dresden.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		davical \
		php5-curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY davical.conf /etc/apache2/sites-available/davical.conf
COPY example-config.php /etc/davical/config_real.php
COPY run /usr/local/bin/run_container

RUN a2ensite davical && \
	a2dissite 000-default


VOLUME [ "/etc/davical" ]

EXPOSE 80 

ENTRYPOINT ["/usr/local/bin/run_container"]
CMD ["apache2"]
