#!/bin/bash
#
# /boot/simple_boot_setup.sh
#
# This script is executed by /etc/init.d/simple_boot_setup
#
# By default this script does nothing, and removes itself after the
# first run when called by /etc/init.d/simple_boot_setup

# This setting will cause this script to exit if there are any errors.
set -ue

disable_after_first_run(){
  if [[ $CALLED_BY == init && $0 == /boot/simple_boot_setup.sh ]]; then
    mv $0 $0.removed_after_first_run
    update-rc.d simple_boot_setup remove
  fi
}

####
##   This is where you put your setup code.
####

    ## Here are some examples of things you might do...
    ##
    ## Remove unneeded packages
    ## apt-get -y remove --purge xserver-common x11-common gnome-icon-theme gnome-themes-standard penguinspuzzle
    ## apt-get -y remove --purge desktop-base desktop-file-utils hicolor-icon-theme raspberrypi-artwork omxplayer
    ## apt-get -y autoremove
    ##
    ## Install a package that will automatically mount & unmount USB drives
    ## apt-get install usbmount
    ##
    ## Setup wifi so you can connect to a secured network without a keyboard & monitor!
    ## cat << EOF | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
    ## network={
    ##        ssid="MyWiFi"
    ##        psk="MyPassword"
    ##        proto=RSN
    ##        key_mgmt=WPA-PSK
    ##        pairwise=CCMP TKIP
    ##        group=CCMP TKIP
    ##        auth_alg=OPEN
    ## }
    ## EOF
    ## ifdown wlan0
    ## ifup wlan0


# If you want this script to remain and run at ever boot comment out the next line.
disable_after_first_run
