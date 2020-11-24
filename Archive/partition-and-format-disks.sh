DISTRO=arch
DISK=
#ESPSIZE= # comment out if not using EFI

echo "Partitioning disks."
sgdisk --zap-all $DISK
if [ -z ${ESPSIZE+x} ]; then
    sgdisk --clear \
	   --new=1:0:$ESPSIZE --typecode=1:ef00 --change-name=1:EFI\
	   --new=2:0:0        --typecode=2:8200 --change-name=2:root\
	   $DISK
    echo "Formatting partitions."
    mkfs.vfat /dev/disk/by-partlabel/EFI
    mkfs.btrfs -f /dev/disk/by-partlabel/root
else
    sgdisk --clear \
	   --new=1:0:0        --typecode=1:8200 --change-name=1:root\
	   $DISK
    echo "Formatting partitions."
    mkfs.btrfs -f /dev/disk/by-partlabel/root
fi

echo "Done."
