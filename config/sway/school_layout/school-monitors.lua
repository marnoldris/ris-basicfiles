#!/usr/bin/env lua

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
	return monitors end

local monitors = get_monitors()

local x_pos = 1920
local y_pos = 300

if contains(monitors, "DP-3") and
   contains(monitors, "DP-1") and
   contains(monitors, "eDP-1") then
	print('School outputs found...')
	os.execute(string.format('swaymsg output eDP-1 pos %d %d scale 1.5 mode 1920x1200@59.995Hz', x_pos, y_pos))
	os.execute(string.format('swaymsg output DP-1  pos %d %d scale 1.5 mode 1920x1080@59.995Hz', x_pos, y_pos))
	os.execute('swaymsg output DP-3                pos  0  0 scale 1   res 1920x1080')
	--os.execute('killall waybar')
	os.execute('sed -i \'s/eDP-1/DP-3/g\' ~/.config/waybar/config.jsonc')
elseif contains(monitors, "DP-3") and
       contains(monitors, "eDP-1") then
	print('Projector not found, setting up for two monitors...')
	os.execute(string.format('swaymsg output eDP-1 pos %d %d scale 1.5 res 1920x1200', x_pos, y_pos))
	os.execute('swaymsg output DP-3                pos  0  0 scale 1   res 1920x1080')
	--os.execute('killall waybar')
	os.execute('sed -i \'s/eDP-1/DP-3/g\' ~/.config/waybar/config.jsonc')
else
	print('School outputs NOT found...')
	os.execute('swaymsg output eDP-1 pos 0 0 scale 1.25 res 1920x1200')
	--os.execute('killall waybar')
	os.execute('sed -i \'s/DP-3/eDP-1/g\' ~/.config/waybar/config.jsonc')
end
