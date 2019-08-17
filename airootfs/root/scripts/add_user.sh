#/bin/bash

while [ -z $USERNAME ]; do
    read -a USERNAME
done

echo "Creating user '$USERNAME'..."
$CHROOT useradd -m -g users -G wheel,storage,power -s /usr/bin/fish $USERNAME

echo "Enter password for user '$USERNAME'"
$CHROOT passwd $USERNAME

echo "Allowing wheel group users to execute SUDO commands"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' $ROOT_DIR/etc/sudoers
