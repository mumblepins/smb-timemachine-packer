#!/bin/bash
set -xe

. /tmp/vars.sh

rm -rf --one-file-system /tmp/samba*
apt-get autoremove --purge -y $BUILD_DEPS build-essential
rm -rf /var/lib/apt/lists/*
rm -f /tmp/vars.sh
