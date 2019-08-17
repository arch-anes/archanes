#/bin/bash

echo "Enter root user password:"
until $CHROOT passwd; do
    :
done
