#!/bin/sh
sudo pacman -S alsa-utils alsa-firmware

amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute
