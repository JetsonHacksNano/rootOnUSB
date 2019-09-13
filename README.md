# rootOnUSB
Set rootfs to be on a USB drive

<em><b>WARNING: </b>This is a low level system change. You may have issues which are not easily solved. You should do this working on a freshly flashed micro SD card, and certainly do not attempt this with valuable data on the card itself. Assume that if this does not work, you may have to flash the micro SD card again. A serial debug console is useful if things go wrong. </em>

The scripts in this repository will setup a NVIDIA Jetson Nano Developer Kit to set the rootfs to a USB drive. This involves four steps. The first step build the initramfs with USB support, so that USB is available early in the boot process. A convenience script named addUSBToInitramfs.sh provides this functionality.

```
$ ./addUSBToInitramfs.sh
```

The second step does not have representation here. The user must prepare a USB drive (preferably USB 3.0, SSD, HDD, or SATA->USB) by formatting the disk as ext4 with a partition. It is easier if you only plug in one USB drive during this procedure. When finished, the disk should show as /dev/sda1 or similar. Typically it is easiest to set the volume label for later use.

The third step, copyRootToUSB copies the contents of the entire system micro SD card to the USB drive. Naturally, the USB drive storage should be larger than the micro SD card. In order to copyRootToUSB:

```
usage: ./copyRootToUSB.sh [directory | [-d directory ] | [-v volume_label ] | [-h]]

  -d | --directory     Directory path to parent of kernel

  -v | --volume_label  Label of Volume to lookup

  -h | --help  This message
  ```

The fourth step modifies the file /boot/extlinux/extlinux.conf An entry should be added to point to the new rootfs (typically this is /dev/sda1). There is a sample configuration file: sample-extlinux.conf

Also, there is a convenience file: diskUUID.sh which will determine the UUID of a given device. This is useful for example to determine the UUID of the USB drive.

```
$ ./diskUUID.sh
```

While this defaults to sda1 (/dev/sda1), you can also determine other drive UUIDs. The /dev/ is assumed, use the -d flag. For example:

```
$ ./diskUUID.sh -d sdb1
```
You may find this information useful for setting up the extlinux.conf file

<h2>Release Notes</h2>
<h3>September, 2019</h4>
* Jetson Nano
* L4T 32.2.2 (JetPack 4.2.2)
* Linux kernel 4.9.140
* Change from recompiling kernel to include the tegra-xusb driver, to adding the tegra-xusb to initramfs. This allows access to the usb driver early on in the boot process.


<h3>July, 2019</h3>

* Initial Release
* Jetson Nano
* L4T 32.2 (JetPack 4.2.1)
* Linux kernel 4.9.140

<h3>April, 2019</h3>

* Initial Release
* Jetson Nano
* L4T 32.1.0 (JetPack 4.2)
* Linux kernel 4.9.140
