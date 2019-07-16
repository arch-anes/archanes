#/bin/bash

ROOT="/mnt"
CHROOT="arch-chroot $ROOT"

INSTALL=sudo -u nobody trizen -Syu --noconfirm --needed --noedit

cp -r /root/packages $ROOT/packages

$CHROOT bash -c "for file in /packages/*.explicit.pkg; do $INSTALL $(cat $file); done"
$CHROOT bash -c "for file in /packages/*.dependency.pkg; do $INSTALL --asdep $(cat $file); done"

rm -rf $ROOT/packages
