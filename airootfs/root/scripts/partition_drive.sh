#/bin/bash

ENCRYPTED_LABEL=cryptroot
ENCRYPTED_PATH="/dev/mapper/$ENCRYPTED_LABEL"

echo "Available drives:"
DISKS=$(lsblk -dp | grep -o '^/dev[^ ]*')
echo $DISKS

echo "Select a drive to partition"
while [ -z $DRIVE ]; do
    read _DRIVE
    DRIVE=$(echo $DISKS | grep $_DRIVE)
done

echo "Wiping drive '$DRIVE'"
sgdisk --zap-all $DRIVE

echo "Partitionning drive '$DRIVE'"
echo "You need to add at least a UEFI boot partition and a Linux (root) filesystem"
echo "Press enter to proceed..." && read
while [ -z $BOOT_PARTITION ] || [ -z $ROOT_PARTITION ]; do
    cgdisk $DRIVE
    BOOT_PARTITION=$(fdisk -l $DRIVE | grep 'EFI' | cut -f 1 -d " ")
    ROOT_PARTITION=$(fdisk -l $DRIVE | grep 'Linux filesystem' | cut -f 1 -d " ")
done

echo "Encrypting root partition"
cryptsetup -y -v luksFormat $ROOT_PARTITION
cryptsetup open $ROOT_PARTITION $ENCRYPTED_LABEL

echo "Formatting partitions"
mkfs.fat -F32 $ROOT_PARTITION
mkfs.f2fs $ENCRYPTED_PATH

echo "Mounting partitions"
mount $ENCRYPTED_PATH $ROOT_DIR
mount $ROOT_PARTITION "$ROOT_DIR/boot"
