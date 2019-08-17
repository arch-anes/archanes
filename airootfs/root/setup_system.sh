#/bin/bash

export ROOT_DIR="/mnt"
export CHROOT="arch-chroot $ROOT_DIR"

/root/rankmirrors.sh

pacstrap $ROOT_DIR base base-devel
genfstab -U $ROOT_DIR > $ROOT_DIR/etc/fstab

MIRRORLIST=etc/pacman.d/mirrorlist
cp -f "/$MIRRORLIST" "$ROOT_DIR/$MIRRORLIST"

sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' $ROOT_DIR/etc/sudoers

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' $ROOT_DIR/etc/locale.gen
$CHROOT locale-gen
echo "LANG=en_US.UTF-8" > $ROOT_DIR/etc/locale.conf

echo "anes-archlinux" > $ROOT_DIR/etc/hostname

/root/install_aur_helper.sh
/root/install_packages.sh
