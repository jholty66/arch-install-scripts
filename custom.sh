#!/bin/sh

# Settings follow the following format:
# VAR="VAL" # "OPTION1", "OPTION2", "OPTION3" ...
# where the OPTIONs are the possible values for VAL

BOOTLOADER="systemd-boot"
# The "EFI_DISK" pysiical disk the the ESP is located and
# "EFI_PARTITION" is the partition number of the ESP. The following
# would work for and ESP located at "/dev/nvme0n1p1".
EFI_DISK="/dev/nvme0n1"
EFI_PARTITION="p1"
FS="zfs"
KERNEL="linux" # "linux", "linux-lts"
SERVICES="systemctl enable dhcpcd"

case "$FS" in
    zfs) FS_DEPS="zfs-dkms"
         HOOK_OPTS="zfs"
         SERVICES="${SERVICES}
systemctl enable zfs-import.target
systemctl enable zfs-mount
systemctl enable zfs-share
systemctl enable zfs-zed"
         SYSTEMD_D_BOOT_OPTIONS="dozfs zfs=zroot/arch rw";;
esac

case "$BOOTLOADER" in
    systemd-boot) INSTALL_BOOTLOADER () {
                        dir=$(pwd)
                        bootctl --path=/boot install
                        echo "title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options	${SYSTEMD_D_BOOT_OPTIONS}" > /boot/loader/entries/arch.conf
                        echo "Wrote to \"/boot/loader/entries/arch.conf\""
                        cat /boot/loader/entries/arch.conf
                    }
esac

DO_HOOKS () {
    sed -i 's/^.*HOOKS=.*$/HOOKS=(base systemd sd-vconsole modconf keyboard block filesystems '"${HOOKS_OPTS}"')/g' /etc/mkinitcpio.conf
    mkinitcpio -P
}
