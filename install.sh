#!/usr/bin/env bash

# This is a tool I use for applying this package to an imaged SD card.
# it is my hope that this gets baked into Raspbian and all that is needed is editing the /boot/simple_boot_setup.sh

if [[ ! ( # any of the following are not true
        -d "$EXT" &&
        -d "$FAT" &&
        $(sudo id -u) -eq 0 &&
        $(sudo id -g) -eq 0
        ) ]];
    then
        echo "    Usage: EXT=/path/to/ext/partition FAT=/path/to/FAT/boot/partition $(basename "$0")"
        echo "    Must run as root (id 0, group 0)"
    exit;
fi

ln -s "../init.d/simple_boot_setup" "$EXT/etc/rcS.d/S10simple_boot_setup"
cp "simple_boot_setup" "$EXT/etc/init.d/simple_boot_setup"
cp "simple_boot_setup.sh" "$FAT/simple_boot_setup.sh"

echo check ownership of...
ls -l "$EXT/etc/rcS.d/S10simple_boot_setup" "$EXT/etc/init.d/simple_boot_setup" "$FAT/simple_boot_setup.sh"
