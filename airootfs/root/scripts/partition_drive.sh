#!/bin/bash

ENCRYPTED_LABEL=cryptroot
ENCRYPTED_PATH="/dev/mapper/$ENCRYPTED_LABEL"

echo "Available drives:"
DISKS=$(lsblk -dp | grep -o '^/dev[^ ]*')
lsblk

echo "Select a drive to partition: "
while [ -z "$DRIVE" ]; do
    read DRIVE
    if [ -z "$(echo $DISKS | grep -w $DRIVE 2>/dev/null)" ]; then
        DRIVE=''
        echo "Invalid drive. Please try again."
    fi
done

read -p "Do you want to wipe drive '$DRIVE'? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Wiping drive '$DRIVE'"
    sgdisk --zap-all $DRIVE
fi

echo "Partitionning drive '$DRIVE'"
echo "You need to add at least a UEFI boot partition and a Linux (root) filesystem"
echo "Press enter to proceed..." && read
while [ -z "$BOOT_PARTITION" ] || [ -z "$ROOT_PARTITION" ]; do
    cgdisk $DRIVE
    export BOOT_PARTITION=$(fdisk -l $DRIVE | grep 'EFI' | cut -f 1 -d " ")
    export ROOT_PARTITION=$(fdisk -l $DRIVE | grep 'Linux filesystem' | cut -f 1 -d " ")
done

echo "Encrypting root partition"
until cryptsetup -y -v luksFormat $ROOT_PARTITION; do
    :
done
until cryptsetup open $ROOT_PARTITION $ENCRYPTED_LABEL; do
    :
done

echo "Formatting partitions"
mkfs.fat -F32 $ROOT_PARTITION
mkfs.f2fs $ENCRYPTED_PATH

echo "Mounting partitions"
mkdir -p $ROOT_DIR
mount $ENCRYPTED_PATH $ROOT_DIR
mkdir -p $BOOT_DIR
mount $BOOT_PARTITION $BOOT_DIR
