#!/bin/bash

# make sure to exit on error
set -euo pipefail

function configure_kernel_and_grub() {
  sudo sed -i 's|^GRUB_CMDLINE_LINUX_DEFAULT=".*"|GRUB_CMDLINE_LINUX_DEFAULT="nouveau.modeset=0 quiet splash"|' /etc/default/grub
  sudo update-grub
}

function install_razer_drivers() {
  echo "Adding all the appropriate repositories to apt"
  sudo add-apt-repository ppa:openrazer/stable -y
  sudo apt update

  echo "Installing OpenRazer drivers"
  sudo apt install software-properties-gtk openrazer-meta -y

  echo "Installing drivers for controlling backlight" 
  sudo apt install xorg xserver-xorg-video-intel -y
}

function configure_trackpad() {
  echo "Installing synaptics driver for touchpad and enabling OS X like 'coasting' scrolling (aoka. scrolling has inertia)"
  sudo apt install xserver-xorg-input-synaptics -y
  sudo apt-get remove xserver-xorg-input-libinput -y
  synclient VertScrollDelta=-20
  synclient HorizScrollDelta=-20
  synclient CoastingSpeed=30

  echo "Enabling palm detection so the mousepad is disabled while typing"
  touch ~/.xsession
  echo "syndaemon -i 1 -t -K -R -d" >> ~/.xsessionrc
}

function install_faceid() {
  echo "Do you want to enable Windows Hello style authentication (Facial authentication)? (ONLY SUPPORTED ON MACHINES WITH AN IR BLASTER!)"
  read -p "Yes/No. ('Y/n)" -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    sudo add-apt-repository ppa:boltgolt/howdy -y
    sudo apt update

    echo "Installing (Howdy) as a Linux version of Windows Hello"
    sudo apt install howdy cheese v4l-utils -y

    echo "Building IR toggle from source (so that IR blaster turns on correctly for Windows Hello"
    git clone git@github.com:PetePriority/chicony-ir-toggle.git
    cd chicony-ir-toggle && gcc main.c -o chicony-ir-toggle && chicony-ir-toggle /dev/video2 on && sudo cp chicony-ir-toggle /usr/local/bin/chicony-ir-toggle && cd ../ && rm -rf chicony-ir-toggle

    echo "Listing all camera based devices" 
    v4l2-ctl --list-devices

    echo "Howdy should be installed. Run 'sudo howdy add' to train it to recognize your face"
    echo "Please set the 'device_path' to '/dev/video2' or equivalent (when you run 'sudo howdy test', both the IR blaster and the camera should turn on)"

    read -p "Opening config. Press enter to continue"
    sudo howdy config

    logInfo "Running 'sudo howdy test' to ensure you have the right "
  fi
}

function configure_laptop_settings() {
  # For some reason, there are times when the microphone isn't detected because
  # the mic volume is set to 0.
  echo "Increasing onboard microphone to 100%"
  amixer sset Mic 100%

  echo "Since NVIDIA drivers are probably installed, brightness controls need to be fixed."
  NVIDIA_BOARD_NAME=`nvidia-smi --query-gpu=name --format=csv,noheader`
  (sudo tee -a /etc/X11/xorg.conf.d <<- EOF

Section "Device"
  Identifier "Device0"
  Driver "nvidia"
  VendorName "NVIDIA Corporation"
  BoardName "$NVIDIA_BOARD_NAME"
  Option "RegistryDwords" "EnableBrightnessControl=1"
EndSection
EOF
  ) &> /dev/null
}

configure_kernel_and_grub
#install_razer_drivers
#install_faceid
#configure_trackpad
#configure_laptop_settings

echo "Done! Please restart your computer for changes to take effect!"
