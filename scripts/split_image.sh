#!/usr/bin/env bash

PATH_TO_IMAGE=$(ls ./work/*.img)
SLAVE_MAC_ADDRESS="e4:5f:01:02:21:b3"

split_file() {
    TFTP_FOLDER="./work/${SLAVE_MAC_ADDRESS}"

    # Create a folder with the MAC address name
    mkdir -p "${TFTP_FOLDER}"
    rm -rf "${TFTP_FOLDER}/*"

    # Minimum size to split is 750MB
    minimum_size_to_split=786432000
    actualsize=$(stat -c%s "${PATH_TO_IMAGE}")
    echo "actualsize = $actualsize"
    # PT takes 4MB, we won't flash it, and so no need to calculate it as well
    ((IMG_SIZE = actualsize - 4194304))
    echo "IMG_SIZE = $IMG_SIZE"
    if [ $actualsize -ge $minimum_size_to_split ]; then
        # Split the big image to 750MB smaller parts, and put them into this folder
        echo "Splitting image file to parts of $minimum_size_to_split bytes"
        split -d -a 1 --bytes=${minimum_size_to_split} "${PATH_TO_IMAGE}" "./work/${SLAVE_MAC_ADDRESS}/rpi_image_part_"
        rm -f "${PATH_TO_IMAGE}"
    else
        # Move the image to this folder
        mv "${PATH_TO_IMAGE}" "./work/${SLAVE_MAC_ADDRESS}/rpi_image_part_0"
    fi
}
split_file