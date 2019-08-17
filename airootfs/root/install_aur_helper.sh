#/bin/bash

BUILD=/home/build

$CHROOT mkdir -p $BUILD
$CHROOT chgrp nobody $BUILD
$CHROOT chmod g+ws $BUILD
$CHROOT setfacl -m u::rwx,g::rwx $BUILD
$CHROOT setfacl -d --set u::rwx,g::rwx,o::- $BUILD

TRIZEN=$BUILD/trizen
git clone https://aur.archlinux.org/trizen.git $ROOT_DIR$TRIZEN
$CHROOT chown nobody:nobody $TRIZEN
$CHROOT bash -c "pushd $TRIZEN && sudo -u nobody makepkg -si --noconfirm"

rm -rf $BUILD
