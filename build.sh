#!/bin/bash

set -xe


chmod 755 /tmp/vars.sh
. /tmp/vars.sh

sudo -E -u timemachine -i -H bash -xe << EOF
DEB_HOST_MULTIARCH="$(dpkg-architecture -qDEB_HOST_MULTIARCH)"
cd /tmp
wget https://download.samba.org/pub/samba/rc/samba-${SAMBA_VERSION}.tar.gz
tar -xzvf samba-${SAMBA_VERSION}.tar.gz
cd /tmp/samba-${SAMBA_VERSION}
./configure --prefix=/usr \
  --enable-fhs \
  --sysconfdir=/etc \
  --localstatedir=/var \
  --with-privatedir=/var/lib/samba/private \
  --with-smbpasswd-file=/etc/samba/smbpasswd \
  --with-piddir=/var/run/samba \
  --with-pammodulesdir=/lib/${DEB_HOST_MULTIARCH}/security \
  --with-pam \
  --with-syslog \
  --with-utmp \
  --with-winbind \
  --with-shared-modules=idmap_rid,idmap_ad,idmap_adex,idmap_hash,idmap_ldap,idmap_tdb2,vfs_dfs_samba4,auth_samba4  \
  --with-automount \
  --with-ldap \
  --with-ads \
  --with-dnsupdate \
  --with-gpgme \
  --with-systemd \
  --systemd-install-services \
  --with-systemddir=/lib/systemd/system \
  --datadir=/usr/share \
  --with-lockdir=/var/run/samba \
  --with-statedir=/var/lib/samba \
  --with-cachedir=/var/cache/samba \
  --enable-avahi \
  --disable-rpath \
  --disable-rpath-install \
  --with-cluster-support \
  --with-socketpath=/var/run/ctdb/ctdbd.socket \
  --with-logdir=/var/log/ctdb \
  --libexecdir=/usr/lib/${DEB_HOST_MULTIARCH} \
  --builtin-libraries=ccan,samba-cluster-support \
  --libdir=/usr/lib/${DEB_HOST_MULTIARCH} \
  --with-modulesdir=/usr/lib/${DEB_HOST_MULTIARCH}/samba
make -j$(nproc)

EOF

cd /tmp/samba-${SAMBA_VERSION}
make install
systemctl enable smb nmb winbind

