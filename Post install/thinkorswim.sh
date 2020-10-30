#!/bin/sh
sudo pacman -S jre8-openjdk wget
mkdir ~/Downloads
wget https://mediaserver.thinkorswim.com/installer/InstFiles/thinkorswim_installer.sh -P ~/Downloads
sh ~/Downloads/thinkorswim_installer.sh
