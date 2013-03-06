#!/usr/bin/env bash

# This is a tool I use for remounting the ext partition read-write on OSX

mnt=($(cat /tmp/mount | awk '/osxfusefs_ext2/{print $1,$3}'))
sudo diskutil unmount ${mnt[1]}; sudo mkdir ${mnt[1]}; sudo fuse-ext2 ${mnt[0]} ${mnt[1]} -o rw+
