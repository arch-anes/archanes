#/bin/bash

echo "Setting locale to 'en_US.UTF-8'"

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' $ROOT_DIR/etc/locale.gen
$CHROOT locale-gen
echo "LANG=en_US.UTF-8" >$ROOT_DIR/etc/locale.conf

echo "Setting system clock"
$CHROOT ln -sf /usr/share/zoneinfo/America/Montreal /etc/localtime
$CHROOT timedatectl set-ntp true
$CHROOT hwclock --systohc
