#!/bin/bash
set -xe

. /tmp/vars.sh

rm -rf --one-file-system /tmp/samba*
apt-get autoremove --purge -y $BUILD_DEPS build-essential
apt-get install -y libavahi-client3 libcups2 libjansson4

rm -rf /var/lib/apt/lists/*
rm -f /tmp/vars.sh
