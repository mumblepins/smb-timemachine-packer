#!/bin/bash
set -ex
sleep 60

. /tmp/vars.sh

sed -i -r 's/^# *(deb-src.*)$/\1/' /etc/apt/sources.list

apt-get update
apt-get -y dist-upgrade --autoremove
apt-get -y install build-essential
apt-get -y --no-install-recommends install $BUILD_DEPS
adduser --disabled-password --gecos 'TimeMachine' timemachine
