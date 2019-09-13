#!/bin/bash
# Copyright (c) 2019 Jetsonhacks 
# MIT License
# Add the xusb_firmware to the initramfs.
# Initramfs is used as the first root filesystem that your machine has access to. 
# It is used for mounting the real rootfs.
# Since we are putting the real rootfs on a USB drive, we need the USB driver.
# Because the USB driver is not built into the Jetson kernel, we load it into initramfs to make it available before we set up the rootfs.
sudo ./scripts/addUSBToInitramfs.sh


