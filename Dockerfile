FROM wtfo/docker-base-ubuntu-s6
LABEL maintainer="teknofile <teknofile@teknofile.org>"

ARG BUILD_DATE

LABEL build_date="Build Date: ${BUILD_DATE}"

RUN apt-get update

ENV BIND_USER=bind \
    DNSUTILS_VERSION=9.11.3+dfsg-1ubuntu1.11 \
    DATA_DIR=/data 

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  syslog-summary \
  syslog-ng 

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 514/udp 514/tcp 6514/tcp

COPY root/ / 
VOLUME /config
