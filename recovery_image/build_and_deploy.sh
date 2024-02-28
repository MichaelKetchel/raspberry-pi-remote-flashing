#!/usr/bin/env -S bash -e
sudo rm -rf sources/firmware-1.20230405/ sources/u-boot-2024.01/
sudo ./build.sh
scp recovery.img mdk@192.170.1.60:~/Downloads/
ssh mdk@192.170.1.60 -t "sudo dd if=/home/mdk/Downloads/recovery.img of=/dev/mmcblk0 bs=4M"
