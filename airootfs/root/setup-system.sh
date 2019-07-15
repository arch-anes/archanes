#/bin/bash

ROOT="/mnt"
CHROOT="arch-chroot $ROOT"

/root/rankmirrors.sh

pacstrap $ROOT base base-devel
genfstab -U $ROOT >> $ROOT/etc/fstab

MIRRORLIST=etc/pacman.d/mirrorlist
cp -f "/$MIRRORLIST" "$ROOT/$MIRRORLIST"

sed -i 's/^#en_US\.UTF-8 UTF-8/en_US\.UTF-8 UTF-8/' $ROOT/etc/locale.gen
$CHROOT locale-gen
echo "LANG=en_US.UTF-8" > $ROOT/etc/locale.conf

echo "anes-archlinux" > $ROOT/etc/hostname

