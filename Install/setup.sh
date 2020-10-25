GITDIR=$(pwd)
DISTRO=arch
pacstrap /mnt/$DISTRO base base-devel linux linux-firmware emacs man man-db man-pages texinfo btrfs dosfstools
genfstab -U /mnt/$DISTRO >> /mnt/$DISTRO/etc/fstab
cd /mnt/$DISTRO
mount -t proc none proc
mount --rbind /sys sys
mount --make-rslave sys
mount --rbind /dev dev
mount --make-rslave dev
chroot /mnt/$DISTRO chroot.sh
cd $GITDIR
