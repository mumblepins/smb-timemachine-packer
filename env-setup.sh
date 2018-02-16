#!/bin/bash
set -ex
export PATH=/snap/bin:$PATH
apt-get -q update
groupadd --system lxd
usermod -a -G lxd travis
apt-get install -y snapd
snap install lxd

wget https://releases.hashicorp.com/packer/1.2.0/packer_1.2.0_linux_amd64.zip -O /tmp/packer.zip
cd /tmp && unzip packer.zip
mv /tmp/packer /usr/local/bin/packer
chmod 755 /usr/local/bin/packer
chown root:root /usr/local/bin/packer
hash -r
systemctl restart snap.lxd.daemon || true
