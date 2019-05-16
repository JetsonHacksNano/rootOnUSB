#!/bin/bash
# Copyright (c) 2016-19 Jetsonhacks 
# MIT License
# Configure kernel to include tegra usb firmware
# SOURCE_TARGET and KERNEL_RELEASE should be set in caller
cd "$SOURCE_TARGET"kernel/kernel-$KERNEL_RELEASE
cp /lib/firmware/tegra21x_xusb_firmware ./firmware/
# CONFIG_EXTRA_FIRMWARE="tegra21x_xusb_firmware"
FIRMWARE_NAME="tegra21x_xusb_firmware"
bash scripts/config --file .config \
	--set-str CONFIG_EXTRA_FIRMWARE "$FIRMWARE_NAME" \
        --set-str CONFIG_EXTRA_FIRMWARE_DIR "firmware"
