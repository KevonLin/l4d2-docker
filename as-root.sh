#!/bin/bash
dpkg --add-architecture i386
apt-get -y update && apt-get -y upgrade
apt-get -y install libc6:i386 lib32z1 curl
useradd -m louis

mkdir /tmp/dumps /maps
chown louis:louis /tmp/dumps /maps