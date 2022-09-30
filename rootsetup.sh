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
