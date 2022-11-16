#!/bin/bash

for user in $(/usr/bin/ls /home/); do

    echo -e "\nFinding group for user..."
    group=""
    if [[ $(groups $user | grep "student") ]]; then
        group="student"
    elif [[ $(groups $user | grep "teacher") ]]; then
        group="teacher"
    else
        group=$user
    fi
    echo -e "\n $user is in group $group"

    echo -e "\n Checking for wallpaper directory..."
    if [[ ! -d /home/$user/Pictures/wallpaper ]]; then
        echo -e "\nwallpaper directory not found; making it..."
        install -v -C -o $user -g $group -d /home/$user/Pictures
        install -v -C -o $user -g $group -d /home/$user/Pictures/wallpaper
    fi

    echo -e "\n Checking for ~/.config/micro directory..."
    if [[ ! -d /home/$user/.config/micro ]]; then
        echo -e "\nmicro directory not found; making it..."
        install -v -C -o $user -g $group -d /home/$user/.config
        install -v -C -o $user -g $group -d /home/$user/.config/micro
    fi

    echo -e "\n Updating files for $user..."
    install -m 644 -C -v -o $user -g $group config.py /home/$user/.config/qtile/
    install -C -v -o $user -g $group autostart.sh /home/$user/.config/qtile/
    install -m 644 -C -v -o $user -g $group picom.conf /home/$user/.config/picom/
    install -m 644 -C -v -o $user -g $group settings.json /home/$user/.config/micro/
    install -m 644 -C -v -o $user -g $group ./wallpaper/* /home/$user/Pictures/wallpaper/
    install -m 644 -C -v -o $user -g $group .zshrc.student /home/$user/.zshrc
    install -m 644 -C -v -o $user -g $group .vimrc /home/$user/.vimrc
done

# Done!
echo -e "Done!"
