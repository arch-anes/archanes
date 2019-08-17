# Anes' Arch Linux custom ISO

## Build

Run `$ sudo ./build.sh`. Output ISO image will be located in `out` folder.

## Install

- Boot into the ISO image

- Launch `$ bash /root/setup_system.sh`

## Notes

- All packages located in `/root/packages` will be installed.

- `rankmirrors.sh` script only loads USA & Canada mirrors.

- The script opens `cgdisk` to partition the drive.

- The root partition is encrypted

- The script supports EFI boot partition only.

- Swap has to be configured manually.
