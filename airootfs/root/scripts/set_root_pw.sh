#!/bin/bash

echo "Enter root user password:"
until $CHROOT passwd; do
    :
done

echo "Adding Gnome Keyring permissions"
cp -f $CONFIGS_DIR/pam.d-login $ROOT_DIR/etc/pam.d/login
