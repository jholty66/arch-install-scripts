#!/bin/sh

source $GITDIR/custom.sh

echo -e "\nSetting timezone.\n"
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

echo -e "\nConfiguring locale.\n"
emacs /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf

echo "\nCreating  hostname.\n"
echo "arch" > /etc/hostname

echo "\nSetting up initial ramdisk.\n"
DO_HOOKS

echo "Configuring bootloader."
INSTALL_BOOTLOADER

echo "Enabling services."
$SERVICES

echo -e "\nEnter root password.\n"
passwd

echo -e "\nInstallation finnished, type \"arch-chroot /mnt/arch/\" to enter back
into installation to make ant extra changes. Add a default user before
exiting.\n"
