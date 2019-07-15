#/bin/bash

ROOT="/mnt"
CHROOT="arch-chroot $ROOT"

INSTALL=sudo -u nobody trizen -Syu --needed --noedit

cp -r /root/packages $ROOT/packages

$CHROOT 'bash -c "for file in /packages/*.pkg; do $INSTALL $(cat $file); done"'

rm -rf $ROOT/packages

