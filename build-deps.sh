#!/bin/bash
set -ex
sleep 15

. /tmp/vars.sh

sed -i -r 's/^# *(deb-src.*)$/\1/' /etc/apt/sources.list
echo 'Acquire::http { Proxy "http://10.0.0.10:3142"; };' > /etc/apt/apt.conf.d/00aptproxy 
    
apt-get update
apt-get -y dist-upgrade --autoremove
apt-get -y install build-essential
apt-get -y --no-install-recommends install $BUILD_DEPS
adduser --disabled-password --gecos 'TimeMachine' timemachine
