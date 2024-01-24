#!/bin/bash

is_apple=false

# Check if the computer is an Apple computer
if [[ $(hostnamectl | grep "Hardware Vendor" | awk '{print $3}') = Apple ]]; then
    is_apple=true
fi

# change shell
echo "Changing shell..."
chsh -s $(which zsh)

# copy in files
echo -e "\nCopying essential files..."
install -m 644 -C -v .zshrc.root ~/.zshrc
install -m 644 -C -v .vimrc ~/.vimrc
mkdir -p ~/.config/micro
install -m 644 -C -v settings.json ~/.config/micro/
mkdir -p ~/.idlerc
install -m 644 -C -v dot.idlerc/config-highlight.cfg ~/.idlerc/
install -m 644 -C -v dot.idlerc/config-main.cfg ~/.idlerc/
cp -v .tmux.conf /etc/tmux.conf


# enable system services
echo -e "\nEnabling extra system services..."
systemctl enable cronie.service sshd.service reflector.service reflector.timer ntpd.service

if [[ "$is_apple" = true && $(cat /sys/module/hid_apple/parameters/fnmode) != 2 ]]; then
    echo -e "\nApple computer detected, adding /etc/modprobe.d/hid_apple.conf to set fnmode..."
    echo "options hid_apple fnmode=2" > /etc/modprobe.d/hid_apple.conf
    echo -e "\nRebuilding initramfs..."
    mkinitcpio -P
fi

# start system services
echo -e "\nAttempting to start reflector.timer and ntp.service..."
systemctl start reflector.timer ntpd.service

# make files executable
#echo -e "\nMaking qtile_usersetup.sh and ./kde_usersetup.sh executable..."
#chmod +x ./qtile_usersetup.sh ./kde_usersetup.sh

# tweak /etc/pacman.conf
echo -e "\nTweaking /etc/pacman.conf..."
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# disable mouse acceleration
echo -e "\nDisabling Mouse Acceleration..."
install -m 644 -C -v -o root -g root 50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

# finished!
echo -e "\nDone!"
