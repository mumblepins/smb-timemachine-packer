#!/bin/bash
set -x
export PATH=/snap/bin:$PATH
cat /etc/group
packer version
lxc --version
lxd --version
groups
id
id -gn
lxd init --auto
lxc storage list
lxc network list
