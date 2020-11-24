#/bin/sh
dir=$(pwd)
git clone https://aur.archlinux.org/yay.git ~/Git/yay
cd ~/Git/yay
makepkg -si
cd dir
