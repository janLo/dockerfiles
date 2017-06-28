# davical
FROM janlo/apache_base

MAINTAINER Jan Losinski <losinski@wh2.tu-dresden.de>

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get -y install --no-install-recommends \
		davical \
		ca-certificates \
		php5-curl \
		patch && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY davical.conf /etc/apache2/sites-available/davical.conf
COPY example-config.php /etc/davical/config_real.php
COPY run /usr/local/bin/run_container

RUN a2ensite davical && \
	a2dissite 000-default && \
	mv /etc/davical/config.php /etc/davical/config_dflt.php && \
	ln -sf /dev/stderr /var/log/apache2/davi-error.log

ADD patches /root/
RUN cd /usr/share/davical && \
	patch -p1 < /root/001_external_ua_string.patch && \
	patch -p1 < /root/002_server_array_upper.patch

VOLUME [ "/etc/davical" ]

EXPOSE 80 

ENTRYPOINT ["/usr/local/bin/run_container"]
CMD ["apache2"]
