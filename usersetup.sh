#!/bin/bash
	
# check that the proper number of arguments are present, otherwise exit the script
if [[ $# -ne 3 ]]; then
    echo "Usage: ./usersetup.sh username password default_group"
    echo "Exiting..."
    exit 1
fi

USERNAME=$1
PASSWORD=$2
GROUP=$3

# if the user exists, delete them and all of their files
if id "$USERNAME" &>/dev/null; then
    echo "User name matches existing user; deleting user account to start fresh..."
    userdel -rf $USERNAME &>/dev/null
fi

# make the user account
groupadd $GROUP &>/dev/null
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
