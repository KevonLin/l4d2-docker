#!/bin/bash
microdnf -y install SDL2.i686 \
    libcurl.i686 \
    glibc-langpack-en \
    tar \
    telnet
microdnf -y update
microdnf clean all

useradd louis

mkdir /tmp/dumps
chown louis:louis /tmp/dumps