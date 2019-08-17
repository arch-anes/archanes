#/bin/bash

cp -r /root/packages $ROOT_DIR/packages

$CHROOT bash -c 'for file in /packages/*.explicit.pkg; do $INSTALL_CMD $(cat $file); done'
$CHROOT bash -c 'for file in /packages/*.dependency.pkg; do $INSTALL_CMD --asdep $(cat $file); done'

rm -rf $ROOT_DIR/packages
