FROM debian:stretch
MAINTAINER Jacob Alberty <jacob.alberty@foundigital.com>

ENV PREFIX=/usr/local/cups
ENV DEBIAN_FRONTEND noninteractive
ENV CUPSURL=https://github.com/apple/cups/releases/download/v2.2.3/cups-2.2.3-source.tar.gz

ADD build.sh ./build.sh

RUN chmod +x ./build.sh && \
    sync && \
    ./build.sh && \
    rm -f ./build.sh

VOLUME ["/config"]

EXPOSE 631/tcp 631/udp

ADD docker-entrypoint.sh ${PREFIX}/docker-entrypoint.sh
RUN chmod +x ${PREFIX}/docker-entrypoint.sh

ENTRYPOINT ${PREFIX}/docker-entrypoint.sh ${PREFIX}/sbin/cupsd -f
