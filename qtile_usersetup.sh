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
install -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/qtile
install -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/picom
install -o $USERNAME -g $GROUP -d /home/$USERNAME/Documents
install -o $USERNAME -g $GROUP -d /home/$USERNAME/Pictures

# install files
echo "Installing files..."
install -o $USERNAME -g $GROUP .zshrc.student /home/$USERNAME/.zshrc
install -o $USERNAME -g $GROUP .vimrc /home/$USERNAME/.vimrc
install -o $USERNAME -g $GROUP autostart.sh /home/$USERNAME/.config/qtile/
install -o $USERNAME -g $GROUP picom.conf /home/$USERNAME/.config/picom/
install -o $USERNAME -g $GROUP config.py /home/$USERNAME/.config/qtile/
install -o $USERNAME -g $GROUP kde_wp.jpg /home/$USERNAME/Pictures/

# make sure everything is executable
echo "Making necessary files executable..."
chmod +x /home/$USERNAME/.config/qtile/autostart.sh

# finished!
echo "Done!"
