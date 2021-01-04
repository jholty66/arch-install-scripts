# Alias.
cp='cp -v'
mv='mv -v'
rm='mm -v'
grep='grep --colour=auto'
# Veriables.
BOOTLOADER="systemd" # "systemd"
EDITOR="nano"
EFI_DISK="/dev/nvme0n1" # Disk name.
EFI_PARTITION="p1" # Partition.
FS="zfs"
FS_ROOT="zroot/arch" # Bootfs name, recuired for BTRFS and ZFS.
KERNEL="linux" # "linux", "linux-lts"
KERNEL_PARAMS=""
PACKSTRAP_PKGS=""
RAMDISK_OPTS="base systemd sd-vconsole modconf keyboard block filesystems"
SERVICES="dhcpcd"
# Hooks, define function then add to hook.
RAMDISK_PRE_HOOK=""
RAMDISK_POST_HOOK=""
