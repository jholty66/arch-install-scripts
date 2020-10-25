#!/bin/sh
echo "Setting timezone."
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

echo "Configuring locale."
emacs /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf

echo "Creating  hostname."
echo "arch" > /etc/hostname

echo "Setting up initial ramdisk."
sed -i 's/^.*HOOKS=.*$/HOOKS=(base systemd sd-vconsole modconf keyboard block filesystems btrfs)/g' /etc/mkinitcpio.conf
mkinitcpio -P

passwd

echo "Configuring bootloader."
bootctl --path /boot install
touch /boot/loader/entries/arch.conf
echo "title Arch" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" > /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" > /boot/loader/entries/arch.conf
echo "options" > /boot/loader/entries/arch.conf
emacs /boot/loader/entries/arch.conf

echo "Enabling internet."
pacman -S dhcpcd
systemctl enable dhcpcd

echo "Done."
