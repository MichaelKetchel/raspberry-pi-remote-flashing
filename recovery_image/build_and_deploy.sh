#!/usr/bin/env -S bash -e
USER=michael
HOST=192.170.1.52
TARGET_DEVICE=/dev/sdb

sudo rm -rf sources/firmware-*/ sources/u-boot-*/
sudo ./build.sh
scp recovery.img "$USER@$HOST:~/Downloads/"
ssh "$USER@$HOST" -t "sudo dd if=/home/$USER/Downloads/recovery.img of=$TARGET_DEVICE bs=4M"
