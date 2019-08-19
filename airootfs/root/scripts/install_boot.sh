#!/bin/bash

echo "Installing boot partition"
$CHROOT bootctl install

echo "Adapting mkinitcpio.conf"
sed -i 's/^HOOKS=.*/HOOKS=(base udev autodetect keyboard modconf block encrypt filesystems fsck)/' $ROOT_DIR/etc/mkinitcpio.conf
$CHROOT mkinitcpio -p linux

echo "Creating Arch Linux boot entry"
ARCH_BOOT_FILE=$BOOT_DIR/loader/entries/archlinux.conf
echo "title Arch Linux" >$ARCH_BOOT_FILE
echo "linux /vmlinuz-linux" >>$ARCH_BOOT_FILE

CPU=$(lscpu)
case $CPU in
*AMD*)
    install_packages amd-ucode
    echo "initrd /amd-ucode.img" >>$ARCH_BOOT_FILE
    ;;
*Intel*)
    install_packages intel-ucode
    echo "initrd /intel-ucode.img" >>$ARCH_BOOT_FILE
    ;;
*)
    echo -n "Unknown CPU"
    ;;
esac

echo "initrd /initramfs-linux.img" >>$ARCH_BOOT_FILE
echo "options cryptdevice=UUID=$(blkid -s "UUID" -o value $ROOT_PARTITION):cmain root=/dev/mapper/cmain quiet rw" >>$ARCH_BOOT_FILE

echo "Creating Windows 10 boot entry"
WINDOWS_BOOT_FILE=$BOOT_DIR/loader/entries/windows.conf
echo "title Windows 10" >$WINDOWS_BOOT_FILE
echo "efi /EFI/MICROSOFT/BOOT/BOOTMGFW.EFI" >>$WINDOWS_BOOT_FILE

echo "Setting default boot loader"
LOADER_CONF_FILE=$BOOT_DIR/loader/loader.conf
echo "timeout 3" >$LOADER_CONF_FILE
echo "default archlinux" >>$LOADER_CONF_FILE
