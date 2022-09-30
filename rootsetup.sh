#!/bin/bash

# change shell
chsh -s $(which zsh)

# copy in files
cp .zshrc.root ~/.zshrc
cp .vimrc ~/.vimrc

# enable system services
systemctl enable cronie.service sshd.service reflector.service reflector.timer

# start system services
systemctl start reflector.timer

# install cron job for fn keys
echo '@reboot root echo 2 > /sys/module/hid_apple/parameters/fnmode' > /etc/cron.d/fnkeys
