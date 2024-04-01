#!/bin/bash

[[ $UID != 0 ]] && echo "must run as root" && exit 1
[[ -z $(grep ":1000:" /etc/passwd) ]] && echo "must have default user with id=1000 configured" && exit 1

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
    entr \
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

default_user=$(id -nu 1000);
default_user_home=$(grep :1000: /etc/passwd | cut -d: -f6)

mkdir -p "$default_user_home/.config/suckless"
cd "$default_user_home/.config/suckless" || echo "Could not cd to default user home dir && exit 1"

chown -R 1000:1000 "$default_user_home/.config/"

su -p "$default_user" <<'EOF'
for app in "dwm" "st" "dmenu" "sxiv"; do
    git clone "https://github.com/laynew/$app"
    pushd $app
    make
    popd
done

git clone https://github.com/laynew/xwallpaper
pushd xwallpaper
./autogen.sh
./configure
make
popd
EOF

for app in "dwm" "st" "dmenu" "sxiv" "xwallpaper"; do
    pushd "$app" || exit
    make install
    popd || echo "Popd failed for $app" || exit
done

