#!/bin/bash

# change shell
echo "Changing shell..."
chsh -s $(which zsh)

# copy in files
echo "Copying essential files..."
cp .zshrc.root ~/.zshrc
cp .vimrc ~/.vimrc

# enable system services
echo "Enabling extra system services..."
systemctl enable cronie.service sshd.service reflector.service reflector.timer

# start system services
echo "Attempting to start reflector.timer..."
systemctl start reflector.timer

# make usersetup.sh executable
echo "Making usersetup.sh and ./kde_usersetup.sh executable..."
chmod +x ./usersetup.sh ./kde_usersetup.sh

# tweak /etc/pacman.conf
echo "Tweaking /etc/pacman.conf..."
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# install cron job for fn keys
#echo '@reboot root echo 2 > /sys/module/hid_apple/parameters/fnmode' > /etc/cron.d/fnkeys

# finished!
echo "Done!"
