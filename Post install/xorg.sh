sudo pacman -S \
     chromium \
     emacs \
     xorg-server \
     xorg-xinit \
     xorg-xmodmap \
     xsecurelock

yay -S terminus-font ttf-go-mono ttf-iosevka ttf-cmu-typewriter xorg-mkfontscale xorg-font-utils

touch ~/.Xresources
echo "Xft.dpi 120" >> ~/.Xresources

touch ~/.xinitrc
cat <<EOM >~/.xinitrc
if [ -s ~/.Xresources ]; then
    xrdb ~/.Xresources
fi
xset r rate 250 50 
echo "exec emacs" >> ~/.xinitrc
EOM

if [ -f ~/.bash_profile]; then
    rm ~/.bash_profile
fi
echo ". ~/.profile" > ~/.bash_profile

if [ -f .profile]; then
    rm ~/.profile
fi
cat <<EOF
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
 . startx
 logout
fi
EOF

