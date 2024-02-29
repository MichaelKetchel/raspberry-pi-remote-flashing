need: dosfstools make bison flex kpartx u-boot-tools gcc-arm-linux-gnueabi libncurses-dev
libssl-dev
gcc-aarch64-linux-gnu

also need to run build.sh as root, unfortunately.

need a way to get gateway via dhcp

4194304 ÷ 1024 = 4096
46137344
41380052992

266240
31914983424 bytes, 62333952

second boot starts @ 272629760 bytes or 532480 512 byte sectors

start writing at 0x82000?

mmcblk0p1 : 0 524288 /dev/mmcblk0 8192
mmcblk0p2 : 0 524288 /dev/mmcblk0 532480
mmcblk0p3 : 0 20447232 /dev/mmcblk0 1056768

bash hex conv:
printf '%x\n' 85

zsh base conversion:
dec=85
hex=$(([##16]dec))

(4096 + 40960)*1024
hex((4096 + 40960)*1024//512)

setenv bootargs console=ttyS0,115200 console=tty1 root=PARTUUID=35c84628-03 rootfstype=ext4 fsck.repair=yes rootwait quiet init=/usr/lib/raspberrypi-sys-mods/firstboot 8250.nr_uarts=1 initcall_blacklist=bcm2708_fb_init


load mmc 0:1 $loadaddr env.txt
env import -t $loadaddr $filesize serverip ipaddr image_name netconsole nc_ip mmc_write_offset_hex
setenv filesize 0
setenv pt_size_bytes 400000
setenv ram_start_add_bytes 80000
tftpboot 0x${ram_start_add_bytes} ${serverip}:${ethaddr}/rpi_image_part_0

blkmap create ram_disk
setexpr fileblks ${filesize} + 0x1ff
setexpr fileblks ${filesize} / 0x200
blkmap map ram_disk 0 ${fileblks} mem ${fileaddr}

echo "Remote partition map:"
part list blkmap 0

# Local part dims
part start mmc 0 1 l_boot_part_start
part size mmc 0 1 l_boot_part_size

setexpr l_boot_part_end $l_boot_part_start + $l_boot_part_size
setexpr part_offset $l_boot_part_end

# Set up start of mbr_parts
# 8192*512/1024/1024
# setenv mbr_parts "name=uboot,start=4M,size=256M,bootable,id=0x0c"

# Takes a hex sector count and returns a hex megabyte value
function sectors_to_mbytes(sectors)
    
end


setenv mbr_parts "name=uboot,start=4M,size=512M,bootable,id=0x0c;name=rootfs,start=516M,size=2096M,id=0x83"

part list blkmap 0 r_part_numbers
for i in $r_part_numbers; do
    part start blkmap 0 $i r_part_start
    part start blkmap 0 $i r_part_size
    part type blkmap 0 $i r_part_type
    setexpr new_part_num $i+1
    echo "Would update part $i ($r_part_type) to $new_part_num at $part_offset"
    setexpr part_offset $part_offset + $r_part_size
done

## Scratch box
part size mmc 0 1 l_boot_part_size
setexpr a $l_boot_part_size * 200
setexpr a $a / 100000
echo "$a"

