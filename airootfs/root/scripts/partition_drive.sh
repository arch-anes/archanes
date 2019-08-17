#/bin/bash

DRIVE="/dev/nvme0n1"
ENCRYPTED_LABEL=cryptroot
ENCRYPTED_PATH="/dev/mapper/$ENCRYPTED_LABEL"

echo "Wiping drive '$DRIVE'"
# wipe it here...

echo "Partitionning drive '$DRIVE'"
# add boot partition
# add root partition

# fetch partitions paths
BOOT_PARTITION=
ROOT_PARTITION=

echo "Encrypting root partition"
cryptsetup -y -v luksFormat $ROOT_PARTITION
cryptsetup open $ROOT_PARTITION $ENCRYPTED_LABEL

echo "Formatting partitions"
mkfs.fat -F32 $ROOT_PARTITION
mkfs.f2fs $ENCRYPTED_PATH

echo "Mounting partitions"
mount $ENCRYPTED_PATH $ROOT_DIR
mount $ROOT_PARTITION "$ROOT_DIR/boot"
