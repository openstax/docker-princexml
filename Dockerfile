FROM debian:stretch-slim

ENV PRINCE_VERSION=12.5-1
ENV PRINCE_DEB_BUILD=9.1

ADD https://www.princexml.com/download/prince_${PRINCE_VERSION}_debian${PRINCE_DEB_BUILD}_amd64.deb /tmp/

RUN set -x \
    && apt-get update \
    && apt-get install fonts-stix \
    && apt-get install gdebi --no-install-recommends -y \
    && gdebi --non-interactive /tmp/prince_${PRINCE_VERSION}_debian${PRINCE_DEB_BUILD}_amd64.deb \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -r princess && useradd --no-log-init --home-dir /workspace --create-home -r -g princess princess
USER princess
WORKDIR /workspace
