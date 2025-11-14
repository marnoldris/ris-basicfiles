#!/usr/bin/env lua

--[[ Helper functions ]]
local function contains(table, value)
	for i, val in ipairs(table) do
		if val == value then
			return true
		end
	end
	return false
end

local function get_monitors()
	local handle = io.popen('echo "$(swaymsg -t get_outputs -r)" | jq -r ".[] | .name"')

	if not handle then
		error('Error: io.popen() failed!')
	end

	local monitors = {}
	for line in handle:lines() do
		table.insert(monitors, line)
	end
	handle:close()
	return monitors
end


--[[ Default lock screen image path ]]
local img_path = '/home/matthew-sway/Pictures/wallpaper/Dragonhawk-Fates-Tempest-2-Bloomburrow-MtG-Art.jpg'

--[[
Grab a screenshot of DP-1 if it is connected
and display it when locking the screen.
]]
local monitors = get_monitors()
if contains(monitors, "DP-1") then
	--[[ Get the projector screenshot ]]
	local proj_ss = '/tmp/proj.png'
	--local proj_ss = '/home/matthew-sway/Pictures/trans.png'
	os.execute('grim -o DP-1 ' .. proj_ss)

	-- short pause to make sure the screenshot is taken
	os.execute('sleep 1')

	--[[ Lock the screen showing the projector screenshot ]]
	os.execute([[swaylock -f -i DP-1:]] .. proj_ss ..
		' -i DP-3:' .. img_path ..
		' -i eDP-1:' .. img_path)
else
	os.execute('swaylock -f -i ' .. img_path)
end

