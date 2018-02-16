#!/bin/bash
set -ex
add-apt-repository -y ppa:ubuntu-lxc/stable
apt-get -q update
apt-get install -y lxd
usermod -a -G lxd travis
wget https://releases.hashicorp.com/packer/1.2.0/packer_1.2.0_linux_amd64.zip -O /tmp/packer.zip
cd /tmp && unzip packer.zip
mv /tmp/packer /usr/local/bin/packer
chmod 755 /usr/local/bin/packer
chown root:root /usr/local/bin/packer
hash -r
