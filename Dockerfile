FROM geonetwork:3.2.1

MAINTAINER doublebyte <joana.simoes@geocat.net>

COPY ./setup_inspire.sh /setup_inspire.sh
COPY ./docker-entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
