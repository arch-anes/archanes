#!/bin/bash

echo "Enter new user name:"
while [ -z "$USERNAME" ]; do
    read USERNAME
    if [ -z "$(echo $USERNAME | grep -E '^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$')" ]; then
        USERNAME=''
        echo "Invalid username. Please try again."
    fi
done

export USERNAME=$USERNAME

echo "Creating user '$USERNAME'..."
$CHROOT useradd -m -g users -G wheel,storage,power -s /usr/bin/fish $USERNAME

echo "Enter password for user '$USERNAME'"
until $CHROOT passwd $USERNAME; do
    :
done

echo "Allowing wheel group users to execute sudo command"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' $ROOT_DIR/etc/sudoers
