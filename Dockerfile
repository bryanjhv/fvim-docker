FROM ubuntu:18.04

RUN sed -i '0,/# deb/s//deb/' /etc/apt/sources.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get build-dep -y vim-athena \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget python-dev \
 && rm -rf /var/lib/apt/lists/*

RUN useradd fvim -d /tmp -s /bin/bash
USER fvim

VOLUME /out
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
