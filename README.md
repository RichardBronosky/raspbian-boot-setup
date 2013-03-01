# Purpose

Enhance Raspbian with a mechanism by which *any* host system used to image an SD card can add a setup script to the SD card to initiate a process on first boot.

The mechanism will allow communities to form around Raspbian as the base for special purpose Raspberry Pi configuration without the need to build and host an entire OS. It should be possible to prepare SD cards that initiate a setup process the yeilds a system that does not need to be further configured by following lengthy explainations found on forums and wikis.

# Practical Applications

1. Set up secured wifi on headless systems
2. Add or remove packages
3. Build and install drivers

# Implementation

1. /etc/rc2.d/S01simple_boot_setup is symlinked to /etc/init.d/simple_boot_setup
2. /etc/init.d/simple_boot_setup calls /boot/simple_boot_setup.sh
3. /boot is a FAT file system so that *any* OS can edit it.

#### Here are some examples of things you might do...

    ## Remove unneeded packages
    apt-get -y remove --purge xserver-common x11-common gnome-icon-theme gnome-themes-standard penguinspuzzle
    apt-get -y remove --purge desktop-base desktop-file-utils hicolor-icon-theme raspberrypi-artwork omxplayer
    apt-get -y autoremove
    
    ## Install a package that will automatically mount & unmount USB drives
    apt-get install usbmount
    
    ## Setup wifi so you can connect to a secured network without a keyboard & monitor!
    cat << EOF | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
    network={
           ssid="MyWiFi"
           psk="MyPassword"
           proto=RSN
           key_mgmt=WPA-PSK
           pairwise=CCMP TKIP
           group=CCMP TKIP
           auth_alg=OPEN
    }
    EOF
