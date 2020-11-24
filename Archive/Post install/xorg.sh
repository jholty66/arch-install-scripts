sudo pacman -S \
     chromium \
     emacs \
     xorg-server \
     xorg-xinit \
     xorg-xmodmap \
     xsecurelock 

yay -S terminus-font ttf-go-mono ttf-iosevka ttf-cmu-typewriter xorg-mkfontscale xorg-font-utils ttf-symbola ttf-dejavu adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts

mkdir ~/.config/fontconfig/
cp fonts.conf ~/.config/fontconfig/

touch ~/.Xresources
echo "Xft.dpi: 96 >> ~/.Xresources

# touch ~/.xinitrc
# cat <<EOM >~/.xinitrc
# if [ -s ~/.Xresources ]; then
#     xrdb ~/.Xresources
# fi
# xset r rate 250 50 
# echo "exec emacs" >> ~/.xinitrc
# EOM

if [ -f ~/.bash_profile ]; then
    echo ". ~/.profile" >> ~/.bash_profile
fi
echo ". ~/.profile" > ~/.bash_profile

if [ -f .profile ]; then
    rm ~/.profile
fi
cat <<EOF
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
 . startx
 logout
fi
EOF

