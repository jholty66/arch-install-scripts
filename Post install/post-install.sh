pacman -S \
       sudo \
       git \
       openssh

systemctl enable sshd

if [ -d /home/charlie]; then
    useradd -m -G wheel,audio,video charlie
fi
passwd charlie
emacs /etc/sudoers # Fix wheel permissions

if [ -d /home/chalrie/Git ]; then
    mkdir /home/charlie/Git
fi
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

