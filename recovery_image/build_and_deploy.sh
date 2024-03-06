#!/usr/bin/env -S bash -e
USER=michael
HOST=192.170.1.51
TARGET_DEVICE=/dev/sdb

sudo rm -rf sources/firmware-*/ sources/u-boot-2*/
sudo ./build.sh
scp recovery.img "$USER@$HOST:~/Downloads/"
# ssh "$USER@$HOST" -t "sudo dd if=/home/$USER/Downloads/recovery.img of=$TARGET_DEVICE bs=4M"
ssh "$USER@$HOST" -t "sudo dd if=/home/$USER/Downloads/recovery.img of=$TARGET_DEVICE bs=4M skip=1 seek=1"
