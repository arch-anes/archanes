#/bin/bash

new=/tmp/mirrorlist
backup=$new.backup

curl -o $new 'https://www.archlinux.org/mirrorlist/?country=CA&country=US'
cp $new $backup
sed -i 's/^#Server/Server/' $backup
rankmirrors -n 10 $backup > $new
cp -f $new /etc/pacman.d/mirrorlist
