#!/bin/bash

# make sure to exit on error
set -euo pipefail

echo "Adding all the appropriate repositories to apt"
sudo add-apt-repository ppa:openrazer/stable -y
sudo add-apt-repository ppa:boltgolt/howdy -y
sudo apt update

echo "Installing OpenRazer drivers"
sudo apt install software-properties-gtk openrazer-meta -y

echo "Installing synaptics driver for touchpad and enabling OS X like 'coasting' scrolling (aoka. scrolling has inertia)"
sudo apt install xserver-xorg-input-synaptics -y
sudo apt-get remove xserver-xorg-input-libinput -y
synclient VertScrollDelta=-20
synclient HorizScrollDelta=-20
synclient CoastingSpeed=30

echo "Enabling palm detection so the mousepad is disabled while typing"
echo "Copying default config over and adding palm detection settings"
sudo cp /usr/share/X11/xorg.conf.d/70-synaptics.conf /etc/X11/xorg.conf.d
sudo tee -a /etc/X11/xorg.conf.d <<-EOF

# Enable palm detection when we are using synclient
# See: https://unix.stackexchange.com/a/139262 
synclient PalmDetect=1
synclient PalmMinWidth=4
synclient PalmMinZ=50
EOF

# For some reason, there are times when the microphone isn't detected because
# the mic volume is set to 0.
echo "Increasing onboard microphone to 100%"
amixer sset Mic 100%

echo "Do you want to enable Windows Hello style authentication (Facial authentication)? (ONLY SUPPORTED ON MACHINES WITH AN IR BLASTER!)"
read -p "Yes/No. ('Y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo "Installing (Howdy) as a Linux version of Windows Hello"
  sudo apt install howdy cheese v4l-utils -y

  echo "Listing all camera based devices"
  v4l2-ctl --list-devices

  echo "Howdy should be installed. Run 'sudo howdy add' to train it to recognize your face"
  echo "Please set the 'device_path' to '/dev/video2' or equivalent (when you run 'sudo howdy test', both the IR blaster and the camera should turn on)"

  read -p "Opening config. Press enter to continue"
  sudo howdy config

  read -p "Running 'sudo howdy test' to ensure you have the right "
fi

echo "Done! Please restart your computer for changes to take effect!"

