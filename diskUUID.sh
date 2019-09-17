#!/bin/bash
# Copyright (c) 2016-19 Jetsonhacks 
# MIT License
# print out the UUID of the given disk
DISK_TARGET="sda1"
function usage
{
    echo "usage: ./diskUUID.sh [disk [-d disk ]  | [-h]]"
    echo "-d | --disk ; default sda1"
    echo "-h | --help  This message"
}

# Iterate through command line inputs
while [ "$1" != "" ]; do
    case $1 in
        -d | --disk )      shift
				DISK_TARGET=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                    
                               ;;
    esac
    shift
done

UUID_STRING=$(find /dev/disk/by-uuid -lname '*/'$DISK_TARGET -printf %f)
echo UUID of Disk: /dev/$DISK_TARGET
echo $UUID_STRING
echo 
echo Sample for /boot/extlinux/extlinux.conf entry:
echo 'APPEND ${cbootargs} root=UUID='$UUID_STRING rootwait rootfstype=ext4
