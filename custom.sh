# Veriables.
BOOTLOADER="systemd" # "systemd"
EDITOR="gvim"
EFI_DISK="/dev/sda" # Disk name.
EFI_PARTITION="1" # Partition.
FS="zfs"
FS_ROOT="server/arch" # Bootfs name, recuired for BTRFS and ZFS.
HOSTNAME="server-arch"
KERNEL="linux" # "linux", "linux-lts"
KERNEL_PARAMS=""
KEYMAP="uk" # blank defaults us
LOCALE="en_GB.UTF-8"
PACKSTRAP_PKGS=""
RAMDISK_OPTS="base udev autodetect modconf block keyboard zfs filesystems"
SERVICES="dhcpcd"
# Hooks, define function then add to hook.
BOOTSRAP_PRE_HOOK=""
BOOTSRAP_POST_HOOK=""
RAMDISK_PRE_HOOK=""
RAMDISK_POST_HOOK=""
