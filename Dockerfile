# syntax=docker/dockerfile:1
FROM ubuntu:latest

ARG VERSION=0.11.4

RUN apt-get update && \
    apt-get -y install rubygems curl gnupg2 && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sLO https://github.com/deb-s3/deb-s3/releases/download/$VERSION/deb-s3-0.11.4.gem && \
    gem install deb-s3-$VERSION.gem && \
    rm deb-s3-$VERSION.gem

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "/usr/local/bin/deb-s3" ]