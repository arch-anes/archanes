# Anes' Arch Linux custom ISO

## Build

Run `$ sudo ./build.sh`. Output ISO image will be located in `out` folder.

## Install

- Boot into the ISO image

- Setup and mount root (and boot) partitions in `/mnt`

- Launch `$ /root/setup_system.sh`

- Setup user and boot manually

## Note

- All packages located in `/root/packages` will be installed.

- `rankmirrors.sh` script only loads USA & Canada mirrors.
