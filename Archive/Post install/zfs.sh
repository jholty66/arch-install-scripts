#!/bin/sh
echo "[archzfs]
Server = https://archzfs.com/$repo/$arch" >> /etc/pacman.conf

wget https://archzfs.com/archzfs.gpg -P /tmp/
pacman-key -a /tmp/archzfs.gpg
rm /tmp/archzfs.gpg
pacman-key --finger DDF7DB817396A49B2A2723F7403BD972F75D9D76
pacman-key -lsign-key DDF7DB817396A49B2A2723F7403BD972F75D9D76
pacman -Syy

pacman -S archzfs-dkms linux-headers

echo "zfs" > /etc/modules-load.d/zfs.conf
/sbin/modprobe zfs

systemctl enable zfs-import-cache.service # Required to import zpools:
systemctl enable zfs-import.target        # Required to import zpools:
systemctl enable zfs-mount.service        # Required to mount ZFS filessystems
