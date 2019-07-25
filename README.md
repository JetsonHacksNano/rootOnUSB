# rootOnUSB
Set rootfs to be on a USB drive

<em><b>WARNING: </b>This is a low level system change. You may have issues which are not easily solved. You should do this working on a freshly flashed micro SD card, and certainly do not attempt this with valuable data on the card itself. Assume that if this does not work, you may have to flash the micro SD card again. A serial debug console is useful if things go wrong. </em>

The scripts in this repository will setup a NVIDIA Jetson Nano Developer Kit to set the rootfs to a USB drive. This involves four steps. The first step requires the Linux kernel to be rebuilt to include the Tegra USB firmware drivers internally. A convenience script named buildKernel.sh provides this functionality.

```
$ ./buildKernel.sh
```

The script downloads another repository (buildKernelAndModules) from the JetsonHacksNano Github account. buildKernelAndModules provides scripts to download the kernel sources, make the kernel, and then copy the kernel image to /boot/Image. The rootToUSB repository leverages these functions, while adding the necessary firmware and kernel configurations to allow a USB drive to run as the root file system. After the kernel has finished building, you can reboot the system to make sure it compiled correctly.

The second step does not have representation here. The user must prepare a USB drive (preferably USB 3.0, SSD, HDD, or SATA->USB) by formatting as ext4 with a partition. It is easier if the user only plugs in one USB drive during this procedure. When finished, the disk should show as /dev/sda1 or similar. Typically it is easiest to set the volume label for later use.

The third step, copyRootToUSB copies the contents of the entire system micro SD card to the USB drive. Naturally, the USB drive storage should be larger than the micro SD card. In order to copyRootToUSB:

```
usage: ./copyRootToUSB.sh [directory | [-d directory ] | [-v volume_label ] | [-h]]

  -d | --directory     Directory path to parent of kernel

  -v | --volume_label  Label of Volume to lookup

  -h | --help  This message
  ```

The fourth step modifies the file /boot/extlinux/extlinux.conf An entry should be added to point to the new rootfs (typically this is /dev/sda1). There is a sample configuration file: sample-extlinux.conf

<h2>Release Notes</h2>

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
