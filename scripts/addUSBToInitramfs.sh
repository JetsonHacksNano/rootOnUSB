#!/bin/bash
# Copyright (c) 2016-19 Jetsonhacks 
# MIT License
# Add the xusb_firmware to the initramfs.
# Initramfs is used as the first root filesystem that your machine has access to. 
# It is used for mounting the real rootfs.
# Since we are putting the real rootfs on a USB drive, we need the USB driver.
# Because the USB driver is not built into the Linux kernel, we load it into initramfs to make it available before we set up the rootfs.
# Copy the hook function
cp ./data/usb-firmware /etc/initramfs-tools/hooks
cd /etc/initramfs-tools/hooks
mkinitramfs -o /boot/initrd-xusb.img

