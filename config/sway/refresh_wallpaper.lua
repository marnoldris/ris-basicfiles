#!/usr/bin/env lua

--[[Wallpaper path]]
wallpapers_path = '$HOME/Pictures/wallpaper'

os.execute('swaymsg output "eDP-1" bg "$(find ' .. wallpapers_path .. ' -type f | shuf -n 1)" fill')
os.execute('swaymsg output "DP-3" bg "$(find ' .. wallpapers_path .. ' -type f | shuf -n 1)" fill')
