#!/usr/bin/env bash
# Reset file size counter so we can later check if tftp download succeeded
setenv filesize 0

# When flashing an image we don't want to overwrite the SD first partition
# We don't want to flash the first image blocks (where the partition table is)
# We need to do calculations:
# Assuming RAM address is: 0x00080000
# We have partition table and other data from address 0 to 4194304 (dec, not hex)
# 0x00080000 + 4194304 = 0x480000
# The address of the second partition is: 0x16000

# Init values for reading the first file to RAM
setenv pt_size_bytes 400000
setenv ram_start_add_bytes 80000

# Get file from a remote tftp server, store in RAM
# server folder path is this device MAC address
tftpboot 0x${ram_start_add_bytes} ${serverip}:${ethaddr}/rpi_image_part_0