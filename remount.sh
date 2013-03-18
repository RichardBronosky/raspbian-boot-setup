#!/usr/bin/env bash

# NOTE: This script is not intended to make its way into the upstream package
# This is a tool I use for remounting the ext partition read-write on OSX while doing local development
# This requires:
# https://github.com/mxcl/homebrew/blob/master/Library/Formula/fuse4x.rb (aka: brew install fuse4x) or http://osxfuse.github.com/
# http://sourceforge.net/projects/fuse-ext2/

mnt=($(cat /tmp/mount | awk '/osxfusefs_ext2/{print $1,$3}'))
sudo diskutil unmount ${mnt[1]}; sudo mkdir ${mnt[1]}; sudo fuse-ext2 ${mnt[0]} ${mnt[1]} -o rw+
