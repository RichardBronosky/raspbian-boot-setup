#!/usr/bin/env bash

if [[ ! ( # any of the following are not true
        # 1st arg is an existing regular file
        -d "$EXT" &&
        -d "$FAT"
        ) ]];
    then
        echo "    Usage: EXT=/path/to/ext/partition FAT=/path/to/FAT/boot/partition $(basename "$0")"
    exit;
fi

ln -s "../init.d/simple_boot_setup" "$EXT/etc/rc2.d/S01simple_boot_setup"
cp "simple_boot_setup" "$EXT/etc/init.d/simple_boot_setup"
cp "simple_boot_setup.sh" "$FAT/simple_boot_setup.sh"
