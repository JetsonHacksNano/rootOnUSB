#!/bin/bash
# Copyright (c) 2016-19 Jetsonhacks 
# MIT License
# Copy the root directory to the given volume 

DESTINATION_TARGET=""
VOLUME_LABEL=""

function usage
{
    echo "usage: ./copyRootToUSB.sh [directory [-d directory ]  | [-h]]"
    echo "-d | --directory Directory path to parent of kernel"
    echo "-h | --help  This message"
}

# Iterate through command line inputs
while [ "$1" != "" ]; do
    case $1 in
        -d | --directory )      shift
				DESTINATION_TARGET=$1
                                ;;
        -v | --volume_label )   shift
                                VOLUME_LABEL=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     DESTINATION_TARGET=$1
                               ;;
    esac
    shift
done

echo "Destination Target: "$DESTINATION_TARGET

if [ "$DESTINATION_TARGET" = "" ] ; then
   if [ "$VOLUME_LABEL" = "" ] ; then
      # No destination path, no volume label
      usage
      exit 1
   else
      DEVICE_PATH=$(findfs LABEL="$VOLUME_LABEL")
      if [ "$DEVICE_PATH" = "" ] ; then
         echo "Unable to find mounted volume: ""$VOLUME_LABEL"
         exit 1
      else
        DESTINATION_TARGET=$(findmnt -rno TARGET "$DEVICE_PATH")
        if [ "$DESTINATION_TARGET" = "" ] ; then
          echo "Unable to find the mount point of: ""$VOLUME_LABEL"
         exit 1
        fi
      fi
   fi

echo "Target: "$DESTINATION_TARGET
sudo apt -y install rsync
sudo rsync -axHAWX --numeric-ids --info=progress2 --exclude=/proc / "$DESTINATION_TARGET"

