#/bin/bash

echo "Installing boot partition"

$CHROOT bootctl install

BOOT_FILE=$BOOT_DIR/loader/entries/arch.conf

echo "title Arch Linux" >$BOOT_FILE
echo "linux /vmlinuz-linux" >>$BOOT_FILE
echo "initrd /initramfs-linux.img" >>$BOOT_FILE

CPU=$(lscpu)
case $CPU in
*AMD*)
    $CHROOT $INSTALL_CMD amd-ucode
    echo "initrd /amd-ucode.img" >>$BOOT_FILE
    ;;
*Intel*)
    $CHROOT $INSTALL_CMD intel-ucode
    echo "initrd /intel-ucode.img" >>$BOOT_FILE
    ;;
*)
    echo -n "Unknown CPU"
    ;;
esac

echo "options cryptdevice=UUID=$(blkid -s "UUID" -o value $ROOT_PARTITION):cmain root=/dev/mapper/cmain quiet rw" >>$BOOT_FILE

echo "Adapting mkinitcpio.conf"

sed -i 's/^HOOKS=.*/HOOKS=(base udev autodetect keyboard modconf block encrypt filesystems fsck)/' $ROOT_DIR/etc/mkinitcpio.conf
$CHROOT mkinitcpio -p linux
