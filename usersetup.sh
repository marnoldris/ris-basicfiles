#!/bin/bash

#USERNAME=user
#PASSWORD=user
#GROUP=student
USERNAME=$1
PASSWORD=$2
GROUP=$3

# if the user exists, delete them and all of their files
if id "$USERNAME" &>/dev/null; then
    userdel -rf $USERNAME
fi

# make the user account
groupadd $GROUP
useradd -m -g $GROUP -s $(which zsh) $USERNAME

# set user password
echo $USERNAME:$PASSWORD | chpasswd

# make directories for the user
mkdir -p /home/$USERNAME/.config/qtile
mkdir -p /home/$USERNAME/.config/picom
mkdir -p /home/$USERNAME/Documents
mkdir -p /home/$USERNAME/Pictures


# install files
install -o $USERNAME -g $GROUP .zshrc.student /home/$USERNAME/.zshrc
install -o $USERNAME -g $GROUP .vimrc /home/$USERNAME/.vimrc
install -o $USERNAME -g $GROUP autostart.sh /home/$USERNAME/.config/qtile/
install -o $USERNAME -g $GROUP picom.conf /home/$USERNAME/.config/picom/
install -o $USERNAME -g $GROUP config.py /home/$USERNAME/.config/qtile/
install -o $USERNAME -g $GROUP kde_wp.jpg /home/$USERNAME/Pictures/


# make sure everything is executable
chmod +x /home/$USERNAME/.config/qtile/autostart.sh
