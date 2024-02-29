#!/usr/bin/env -S bash -e
sudo rm -rf sources/firmware-*/ sources/u-boot-*/
sudo ./build.sh
scp recovery.img mdk@192.170.1.60:~/Downloads/
ssh mdk@192.170.1.60 -t "sudo dd if=/home/mdk/Downloads/recovery.img of=/dev/mmcblk0 bs=4M"
