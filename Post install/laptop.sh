pacman -S tlp
sed -i 's/^.*TLP_DEFAULT_MODE=.*$/TLP_DEFAULT_MODE=BAT/g' /etc/tlp.conf
sed -i 's/^.*TLP_PERSISTENT_DEFAULT=.*$/TLP_PERSISTENT_DEFAULT=1/g' /etc/tlp.conf
sed -i 's/^.*SATA_LINKPWR_ON_BAT=.*$/SATA_LINKPWR_ON_BAT=max_performance/g' /etc/tlp.conf # BTRFS fix
systemctl start tlp
systemctl enable tlp

# sed template:
# sed -i 's/^.*oldstring.*$/newstring/g' /usr/src/linux/.conf
# example:
# sed -i 's/^.*CONFIG_HAVE_KVM.*$/CONFIG_HAVE_KVM=y/g' /usr/src/linux/.config
