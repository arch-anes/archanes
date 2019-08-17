#/bin/bash

read USERNAME

echo "Creating user '$USERNAME'..."
$CHROOT useradd -m -g users -G wheel,storage,power -s /usr/bin/fish $USERNAME

echo "Enter password for user '$USERNAME'"
$CHROOT passwd $USERNAME
