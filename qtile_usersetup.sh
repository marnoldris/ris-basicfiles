#!/bin/bash
	
# check that the proper number of arguments are present, otherwise exit the script
if [[ $# -ne 3 ]]; then
    echo "Usage: ./qtile_usersetup.sh <username> <password> <default_group>"
    echo "Exiting..."
    exit 1
fi

USERNAME=$1
PASSWORD=$2
GROUP=$3

# if the user exists, delete them and all of their files
# the &>/dev/null sends the standard output and error to null to suppress the output of the commands
if id "$USERNAME" &>/dev/null; then
    echo "User name matches existing user; deleting user account to start fresh..."
    userdel -rf $USERNAME &>/dev/null
fi

# make the user account, setting the default group and shell
groupadd $GROUP &>/dev/null
echo "Creating user $USERNAME..."
useradd -m -g $GROUP -s $(which zsh) $USERNAME

# set user password
echo "Setting $USERNAME's password..."
echo $USERNAME:$PASSWORD | chpasswd

# make directories for the user
echo "Making directories for $USERNAME..."
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/qtile
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/picom
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Documents
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Downloads
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Pictures
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Pictures/wallpaper
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Videos

# install files
# chattr is used to make these files immutable after installing them
echo "Installing files..."
install -v -o $USERNAME -g $GROUP .zshrc.student /home/$USERNAME/.zshrc
install -v -o $USERNAME -g $GROUP .vimrc /home/$USERNAME/.vimrc
install -v -o $USERNAME -g $GROUP autostart.sh /home/$USERNAME/.config/qtile/
install -v -o $USERNAME -g $GROUP picom.conf /home/$USERNAME/.config/picom/
install -v -o $USERNAME -g $GROUP config.py /home/$USERNAME/.config/qtile/
install -v -o $USERNAME -g $GROUP kde_wp.jpg /home/$USERNAME/Pictures/

# make sure everything is executable
echo "Making necessary files executable..."
chmod +x /home/$USERNAME/.config/qtile/autostart.sh

# make the files immutable with chattr +i <file>
echo "Making necessary files immutable..."
chattr +i /home/$USERNAME/.zshrc
chattr +i /home/$USERNAME/.vimrc
chattr +i /home/$USERNAME/.config/qtile/autostart.sh
chattr +i /home/$USERNAME/.config/picom/picom.conf
chattr +i /home/$USERNAME/.config/qtile/config.py
chattr +i /home/$USERNAME/Pictures/wallpaper/kde_wp.jpg

# finished!
echo "Done!"
