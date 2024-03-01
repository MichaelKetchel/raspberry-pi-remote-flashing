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

```shell

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
# part type mmc 0:1 l_boot_part_type

setexpr l_boot_part_end $l_boot_part_start + $l_boot_part_size
setexpr part_offset $l_boot_part_end


setexpr boot_part_start_hex $l_boot_part_start * 200
setexpr boot_part_start_hex $boot_part_start_hex / 100000

setexpr boot_part_size_hex $l_boot_part_size * 200
setexpr boot_part_size_hex $boot_part_size_hex / 100000

setenv mbr_parts "name=uboot,start=0x${boot_part_start_hex}M,size=0x${boot_part_size_hex}M,bootable,id=0x0c;"

part list blkmap 0 r_part_numbers
for i in $r_part_numbers; do
    part start blkmap 0 $i r_part_start
    part size blkmap 0 $i r_part_size
    # part type blkmap 0 $i r_part_type
    setexpr new_part_num $i+1
    
    # Hate this, but until `part type` is fixed, figuring this out another way is a real pain
    setenv part_type "83"
    if test "${i}" = "1"; then
        setenv part_type "0c"
    fi

    setexpr r_part_start_hex $r_part_start * 200
    setexpr r_part_start_hex $r_part_start_hex / 100000
    setexpr r_part_start_hex $r_part_start_hex + $part_offset

    setexpr r_part_size_hex $r_part_size * 200
    setexpr r_part_size_hex $r_part_size_hex / 100000
    echo "Updating part $i to $new_part_num at $r_part_start_hex"
    # echo "Updating part $i ($r_part_type) to $new_part_num at $r_part_start_hex"
    setenv mbr_parts "${mbr_parts}start=0x${r_part_start_hex}M,size=0x${r_part_size_hex}M,id=0x${part_type};"
done

## Scratch box
part size mmc 0 1 l_boot_part_size
setexpr a $l_boot_part_size * 200
setexpr a $a / 100000
echo "$a"




# Set up start of mbr_parts
# 8192*512/1024/1024
# setenv mbr_parts "name=uboot,start=4M,size=256M,bootable,id=0x0c"

# Takes a hex sector count and returns a hex megabyte value
# function sectors_to_mbytes(sectors)
#     setexpr stmbytes $sectors * 200
#     setexpr stmbytes $stmbytes / 100000
#     return $stmbytes
# end

```