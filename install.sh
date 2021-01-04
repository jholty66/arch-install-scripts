#!/bin/sh
set -e
source ./custom.sh
case "$FS" in
	zfs) FS_DEPS="zfs-dkms"
		HOOK_OPTS="zfs"
		KERNEL_PARAMS="dozfs zfs=zroot/arch rw";;
		ZFS_SERVICES() {
			systemctl preset zfs-import-cache zfs-import-scan zfs-mount zfs-share zfs-zed zfs.target
		}
		RAMDISK_POST_HOOK="$RAMDISK_PRE_HOOK ZFS_SERVICES;"
		PACKSTRAP_PKGS="$PACKSTRAP_PKGS zfs-dkms"
esac
case "$BOOTLOADER" in
	systemd-boot) INSTALL_BOOTLOADER () {
			bootctl --path=/boot install
			echo "title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options	${KERNEL_PARAMS}" > /boot/loader/entries/arch.conf
			cat /boot/loader/entries/arch.conf
                    }
esac
bootstrap() {
	GITDIR=$(pwd)
	alias cp="cp -v"
	time pacstrap /mnt/ base base-devel linux linux-firmware man man-db man-pages texinfo $PACKSTRAP_PKGS
	genfstab -U -p /mnt/ >> /mnt//etc/fstab;cat /mnt/etc/fstab
}
timezone() {
	ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
	hwclock --systohc
}
locale() {
	emacs /etc/locale.gen
	locale-gen
	echo "LANG=en_GB.UTF-8" > /etc/locale.conf;cat /etc/locale.conf
	echo "KEYMAP=uk" > /etc/vconsole.conf;cat/etc/vconsole.conf
}
hostname() {
	echo "arch" > /etc/hostname;cat/etc/hostname
}
ramdisk() {
	cp /etc/mkinitcpio.conf{,.bak};cp /etc/mkinitcpio.conf{,.def}
	sedi -i "s/^HOOKS=.*$/HOOKS=(${RAMDISK_OPTS})/" /etc/mkinitcpio.conf
	eval $RAMDISK_PRE_HOOK
	mkinitcpio -P
	eval $RAMDISK_POST_HOOK
}
bootloader() {
	echo "Configuring bootloader."
	INSTALL_BOOTLOADER
}
services() {
	pacman -S $SERVICES
	systemctl enable $SERVICES
}
all(){
	bootstrap
	echo 'set -e;source /root/arch-install-scripts/install.sh;timezone&&locale&&hostname&&ramdisk&&bootloader&&services' | arch-chroot /mnt/ /bin/bash -s
}
while true; do
	echo "$1"
	case "$1" in
		--bootstrap) bootstrap && shfit ;;
		--timezone) timezone && shfit ;;
		--locale) locale && shfit ;;
		--hostname) hostname && shfit ;;
		--ramdisk) ramdisk && shfit ;;
		--bootloader) bootloader && shfit ;;
		--services) services && shfit ;;
		--all) all && exit;;
		--) shift;break;;
		* ) break ;;
	esac
	shift
done
