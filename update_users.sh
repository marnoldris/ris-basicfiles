#!/bin/bash

for user in $(/usr/bin/ls /home/); do
    group=$(groups $user)
    echo -e "\n Checking for wallpaper directory..."
    if [[ ! -d /home/$user/Pictures/wallpaper ]]; then
        echo -e "\nwallpaper directory not found; making it..."
        mkdir -p /home/$user/Pictures/wallpaper
    fi
    echo -e "\n Updating files for $user..."
    install -C -v -o $user -g $group config.py /home/$user/.config/qtile/
    install -C -v -o $user -g $group autostart.sh /home/$user/.config/qtile/
    install -C -v -o $user -g $group ./wallpaper/* /home/$user/Pictures/wallpaper/
    install -C -v -o $user -g $group .zshrc.student /home/$user/.zshrc
    install -C -v -o $user -g $group .vimrc /home/$user/.vimrc
done
