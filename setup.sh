#!/bin/bash

# Ubuntu (GNOME) 18.04 setup script.

dpkg -l | grep -qw gdebi || sudo apt-get install -yyq gdebi

# Initial Software

sudo apt update

sudo apt install virtualbox virtualbox-guest-additions-iso virtualbox-ext-pack \
net-tools htop lame git mc flatpak audacity \
openssh-server sshfs gedit-plugin-text-size simplescreenrecorder nano \
ubuntu-restricted-extras mpv vlc gthumb gnome-tweaks \
gnome-tweak-tool qt5-style-plugins spell synaptic -yy

# Add me to any groups I might need to be a part of:

sudo adduser $USER vboxusers

# Remove undesirable packages:

sudo apt purge gstreamer1.0-fluendo-mp3 deja-dup shotwell whoopsie whoopsie-preferences -yy

# Remove snaps and get packages from apt:

sudo snap remove gnome-characters gnome-calculator gnome-system-monitor
sudo apt install gnome-characters gnome-calculator gnome-system-monitor \
gnome-software-plugin-flatpak -yy

# Purge Firefox, install Chromium:

sudo apt purge firefox -yy
sudo apt purge firefox-locale-en -yy
if [ -d "/home/$USER/.mozilla" ]; then
    rm -rf /home/$USER/.mozilla
fi
if [ -d "/home/$USER/.cache/mozilla" ]; then
    rm -rf /home/$USER/.cache/mozilla
fi

sudo apt install chromium-browser

gsettings set com.ubuntu.update-notifier show-livepatch-status-icon false
#set icons to minimize on click
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

## Remove junk
sudo apt-get remove thunderbird rhythmbox ubuntu-web-launchers -y

## Multimedia
sudo apt-get install -y gimp scribus

## Games
sudo apt-get install -y steam-installer

## Music
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y

## Text Editor
sudo snap install --classic code

## Disable Apport
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

# Fixing an Ubuntu bug that stops you from burning cd's

sudo chmod 4711 /usr/bin/cdrdao
sudo chmod 4711 /usr/bin/wodim
sudo chmod 0755 /usr/bin/growisofs

# Gotta update now:
sudo apt update && sudo apt upgrade -y

echo $'\n'$"*** All done! Please reboot now. ***"
