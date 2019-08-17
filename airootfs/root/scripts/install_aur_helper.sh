#/bin/bash

BUILD_DIR=/home/build

$CHROOT mkdir -p $BUILD_DIR
$CHROOT chgrp nobody $BUILD_DIR
$CHROOT chmod g+ws $BUILD_DIR
$CHROOT setfacl -m u::rwx,g::rwx $BUILD_DIR
$CHROOT setfacl -d --set u::rwx,g::rwx,o::- $BUILD_DIR

CLONE_DIR=$BUILD_DIR/trizen
git clone https://aur.archlinux.org/trizen.git $ROOT_DIR$CLONE_DIR
$CHROOT chown nobody:nobody $CLONE_DIR
$CHROOT bash -c "pushd $CLONE_DIR && sudo -u nobody makepkg -si --noconfirm"

rm -rf $CLONE_DIR