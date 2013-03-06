# Purpose

Enhance Raspbian with a mechanism by which *any* host system used to image an SD card can add a setup script to the SD card to initiate a process on first boot.

The mechanism will allow communities to form around Raspbian as the base for special purpose Raspberry Pi configuration without the need to build and host an entire OS. It should be possible to prepare SD cards that initiate a setup process the yeilds a system that does not need to be further configured by following lengthy explainations found on forums and wikis.

# Practical Applications

1. Set up secured wifi on headless systems
2. Add or remove packages
3. Build and install drivers

# Implementation

1. /etc/rcS.d/S01simple_boot_setup is symlinked to /etc/init.d/simple_boot_setup
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
    cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bak
    wpa_passphrase "MyWiFi" "MyPassphrase" | tee -a /etc/wpa_supplicant/wpa_supplicant.conf
    sed -i.bak 's/iface wlan0 inet manual/iface wlan0 inet dhcp/; s/wpa-roam/wpa-conf/; $i auto wlan0 eth0' /etc/network/interfaces

    ## Add your SSH pub key
    (umask 077; mkdir -p ~/.ssh; touch ~/.ssh/authorized_keys)
    chown -R $(id -u pi):$(id -g pi) ~/.ssh
    curl -sL https://raw.github.com/RichardBronosky/dotfiles/master/.ssh/authorized_keys >> ~/.ssh/authorized_keys

    ## fake completing the raspi-config
    sed '/do_finish()/,/^$/!d' /usr/bin/raspi-config | sed -e '1i ASK_TO_REBOOT=0;' -e '$a do_finish' | bash
