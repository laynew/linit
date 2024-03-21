#!/bin/bash

[[ $UID != 0 ]] && echo "must run as root" && exit 1

echo "Begin initialisation"

# Install packages

apt update
apt upgrade -y
apt install -y \
    build-essential \
    dh-autoreconf \
    libexif-dev \
    libimlib2-dev \
    libx11-dev \
    libxcb-image0-dev \
    libxcb-util-dev \
    libxft-dev \
    libxinerama-dev \
    xcompmgr \
    xorg \
    xinit \
    btop \
    figlet \
    firefox \
    git \
    gpg \
    htop \
    imagemagick \
    keepassxc \
    neofetch \
    pass \
    shellcheck \
    syncthing \
    tldr \
    tmux \
    vim

# Install window manager and tools

mkdir -p $HOME/.config/suckless
cd $HOME/.config/suckless

echo "dwm st dmenu sxiv xwallpaper" | tr ' ' '\n' | \
    xargs -I {} bash -c "git clone https://github.com/laynew/{}.git; cd {}; make clean install"


