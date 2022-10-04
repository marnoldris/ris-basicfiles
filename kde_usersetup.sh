#!/bin/bash

# check that the proper number of arguments are present, otherwise exit the script
if [[ $# -ne 3 ]]; then
    echo "Usage: ./usersetup.sh <username> <password> <default_group>"
    echo "Exiting..."
    exit 1
fi

USERNAME=$1
PASSWORD=$2
GROUP=$3

# if the user exists, delete them and all of their files
if id "$USERNAME" &>/dev/null; then
    echo "User name matches existing user; deleting user account to start fresh..."
    userdel -rf $USERNAME
fi

# make the user account
groupadd $GROUP &>/dev/null
echo "Creating user $USERNAME..."
useradd -m -g $GROUP -s $(which zsh) $USERNAME

# set user password
echo "Setting $USERNAME's password..."
echo $USERNAME:$PASSWORD | chpasswd

# make directories for the user
echo "Making directories for $USERNAME..."
install -C -o $USERNAME -g $GROUP -d /home/$USERNAME/Documents
install -C -o $USERNAME -g $GROUP -d /home/$USERNAME/Pictures
install -C -o $USERNAME -g $GROUP -d /home/$USERNAME/.config


# install files
echo "Installing files..."
install -o $USERNAME -g $GROUP .zshrc.student /home/$USERNAME/.zshrc
install -o $USERNAME -g $GROUP .vimrc /home/$USERNAME/.vimrc
install -C -o $USERNAME -g $GROUP kde_wp.jpg /home/$USERNAME/Pictures/

# change kde settings
echo "Installing KDE settings..."
install -C -o $USERNAME -g $GROUP /home/$USERNAME/.config/dolphinrc
echo -e '[General]\nRememberOpenedTabs=false' >> /home/$USERNAME/.config/dolphinrc

install -C -o $USERNAME -g $GROUP /home/$USERNAME/.config/kcminputrc
echo -e '[Mouse]\nX11LibInputXAccelProfileFlat=false\nXLbInptAccelProfileFlat=true' >> /home/$USERNAME/.config/kcminputrc

install -C -o $USERNAME -g $GROUP /home/$USERNAME/.config/kdeglobals
echo -e '[KDE]\nSingleClick=false' >> /home/$USERNAME/.config/kdeglobals

install -C -o $USERNAME -g $GROUP /home/$USERNAME/.config/kglobalshortcutsrc
echo -e '[Alacritty.desktop]\nNew=none,none,New Terminal\n_k_friendly_name=Alacritty\n_launch=Meta+Return,none,Alacritty' >> /home/$USERNAME/.config/kglobalshortcutsrc

install -C -o $USERNAME -g $GROUP /home/$USERNAME/.config/ksmserverrc
echo -e '[General]\nconfirmLogout=false\nloginMode=emptySession\nofferShutdown=false' >> /home/$USERNAME/.config/ksmserverrc


# make sure everything is executable

# finished!
echo "Done!"
