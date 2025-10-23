#!/usr/bin/env lua

local function contains(table, value)
	for i, val in ipairs(table) do
		if val == value then
			return true
		end
	end
	return false
end

handle = io.popen('echo "$(swaymsg -t get_outputs -r)" | jq -r ".[] | .name"')

if not handle then
	error('Unable to execute command')
end

monitors = {}
for line in handle:lines() do
	table.insert(monitors, line)
end
handle:close()

for i,mon in ipairs(monitors) do
	print(mon)
end
if contains(monitors, "DP-3") and
   contains(monitors, "DP-1") and
   contains(monitors, "eDP-1") then
	print('School outputs found...')
	os.execute('swaymsg output eDP-1 pos 1920 100 scale 1.5 res 1920x1080')
	os.execute('swaymsg output DP-1  pos 1920 100 scale 1.5 res 1920x1080')
	os.execute('swaymsg output DP-3  pos    0   0 scale 1   res 1920x1080')
	os.execute('sed -i \'s/eDP-1/DP-3/g\' ~/.config/waybar/config.jsonc')
elseif contains(monitors, "DP-3") and
       contains(monitors, "eDP-1") then
	print('Projector not found, setting up for two monitors...')
	os.execute('swaymsg output eDP-1 pos 1920 100 scale 1.5 res 1920x1080')
	os.execute('swaymsg output DP-3  pos    0   0 scale 1   res 1920x1080')
	os.execute('sed -i \'s/eDP-1/DP-3/g\' ~/.config/waybar/config.jsonc')
else
	print('School outputs NOT found...')
	os.execute('swaymsg output eDP-1 pos 0 0 scale 1.25 res 1920x1200')
	os.execute('sed -i \'s/DP-3/eDP-1/g\' ~/.config/waybar/config.jsonc')
end
