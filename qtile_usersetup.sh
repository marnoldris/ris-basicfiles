#!/bin/bash
	
# check that the proper number of arguments are present, otherwise exit the script
if [[ $# -ne 4 ]]; then
    echo "Usage: ./qtile_usersetup.sh <username> <password> <default_group> <sudoer 1/0>"
    echo -e "Exiting..."
    exit 1
fi

USERNAME=$1
PASSWORD=$2
GROUP=$3
SUDOER=$4

# if the user exists, delete them and all of their files
# the &>/dev/null sends the standard output and error to null to suppress the output of the commands
if id "$USERNAME" &>/dev/null; then
    echo -e "User name matches existing user; deleting user account to start fresh..."
    userdel -rf $USERNAME &>/dev/null
fi

# remove the sudoer from /etc/sudoers.d/
if [[ -f "/etc/sudoers.d/$USERNAME" ]]; then
    echo -e "\nRemoving $USERNAME from sudoers."
    rm /etc/sudoers.d/$USERNAME
fi

# make the user account, setting the default group and shell
groupadd $GROUP &>/dev/null
groupadd $USERNAME &>/dev/null
echo -e "\nCreating user $USERNAME..."
useradd -m -g $GROUP -G $USERNAME -s $(which zsh) $USERNAME

# set user password
echo -e "\nSetting $USERNAME's password..."
echo $USERNAME:$PASSWORD | chpasswd

# make directories for the user
echo -e "\nMaking directories for $USERNAME..."
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/qtile
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/picom
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.config/micro
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Documents
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Downloads
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Pictures
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Pictures/wallpaper
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/Videos
install -v -o $USERNAME -g $GROUP -d /home/$USERNAME/.idlerc

# install files
echo -e "\nInstalling files..."
install -m 644 -v -o $USERNAME -g $GROUP .zshrc.student /home/$USERNAME/.zshrc
install -m 644 -v -o $USERNAME -g $GROUP .vimrc /home/$USERNAME/.vimrc
install -m 755 -v -o $USERNAME -g $GROUP autostart.sh /home/$USERNAME/.config/qtile/
install -m 644 -v -o $USERNAME -g $GROUP picom.conf /home/$USERNAME/.config/picom/
install -m 644 -v -o $USERNAME -g $GROUP config.py /home/$USERNAME/.config/qtile/
install -m 644 -v -o $USERNAME -g $GROUP settings.json /home/$USERNAME/.config/micro/
install -m 644 -v -C -o $USERNAME -g $GROUP ./wallpaper/* /home/$USERNAME/Pictures/wallpaper/
install -m 644 -v -o $USERNAME -g $GROUP dot.idlerc/config-highlight.cfg /home/$USERNAME/.idlerc/
install -m 644 -v -o $USERNAME -g $GROUP dot.idlerc/config-main.cfg /home/$USERNAME/.idlerc/

if [[ $SUDOER -eq 1 ]]; then
    echo -e "\nAdding $USERNAME to sudoers..."
    echo "$USERNAME ALL=(ALL) ALL" > /etc/sudoers.d/$USERNAME
fi

# finished!
echo -e "\nDone!"
