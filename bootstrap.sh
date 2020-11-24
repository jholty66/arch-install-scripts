#!/bin/sh

source $GITDIR/custom.sh
GITDIR=$(pwd)
alias cp="cp -v"

time pacstrap /mnt/arch base base-devel linux linux-firmware linux-headers man man-db man-pages texinfo dosfstools dhcpcd $FS_DEPS
genfstab -U /mnt/arch >> /mnt/arch/etc/fstab
cp $GITDIR/chroot.sh /mnt/arch/root/chroot.sh
arch-chroot /mnt/arch /root/chroot.sh
