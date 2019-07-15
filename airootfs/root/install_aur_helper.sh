#/bin/bash

ROOT="/mnt"
CHROOT="arch-chroot $ROOT"

$CHROOT pacman -S --needed git

BUILD=/home/build

$CHROOT mkdir -p $BUILD
$CHROOT chgrp nobody $BUILD
$CHROOT chmod g+ws $BUILD
$CHROOT setfacl -m u::rwx,g::rwx $BUILD
$CHROOT setfacl -d --set u::rwx,g::rwx,o::- $BUILD

TRIZEN=$ROOT$BUILD/trizen
git clone https://aur.archlinux.org/trizen.git $TRIZEN
$CHROOT pushd $TRIZEN && sudo -u nobody makepkg

