GITDIR=$(pwd)
DISTRO=arch
pacstrap /mnt/$DISTRO base base-devel linux linux-firmware emacs man man-db man-pages texinfo btrfs dosfstools
genfstab -U /mnt/$DISTRO >> /mnt/$DISTRO/etc/fstab
arch-chroot /mnt/$DISTRO $GITDIR/chroot.sh
