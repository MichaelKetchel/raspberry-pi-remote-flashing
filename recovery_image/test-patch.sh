#!/usr/bin/env bash

cd sources
echo "Removing old sources"
rm -rf firmware-1.20230405/  u-boot-2024.01/
echo "Unpacking sources"
tar -xzf "v2024.01.tar.gz"
tar -xzf "1.20230405.tar.gz"
echo "Applying patches"
cd u-boot-2024.01/
for i in ../../patches/u-boot/*.patch; do patch -p1 -l < "$i"; done

