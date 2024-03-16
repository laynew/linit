#!/bin/bash

[[ $UID != 0 ]] && echo "must run as root" && exit 1

echo "Begin initialisation"

# Install packages

apt update
apt upgrade -y
apt install -y \
    build-essential \
    libexif-dev \
    libimlib2-dev \
    libx11-dev \
    libxft-dev \
    libxinerama-dev \
    xcompmgr \
    xorg \
    xinit \
    btop \
    git \
    htop \
    tmux \
    vim

# Install window manager and tools

mkdir -p $HOME/.config/suckless
cd $HOME/.config/suckless

echo "dwm st dmenu sxiv xwallpaper" | tr ' ' '\n' | \
    xargs -I {} bash -c "git clone https://github.com/laynew/{}.git; cd {}; make clean install"


