#!/usr/bin/env lua

--[[
Toggles the current window between a classic "maximized" view
and tiled view. This will unfloat the window if it is already
floating for any other reason.
]]

function split(str, delim)
	--[[ Splits a string into a table based on delim ]]
	local t = {}
	delim = delim or "%s+" -- default to whitespace
	for token in string.gmatch(str, "[^" .. delim .. "]+") do
		table.insert(t, token)
	end
	return t
end

function get_waybar_height()
	local handle = io.popen([=[grep 'height' ~/.config/waybar/config.jsonc | awk '{print $2}']=])
	local raw = handle:read("*a")
	local height = raw:gsub(',', '')
	handle:close()
	return height
end

function get_output_res()
	local handle = io.popen([=[swaymsg -t get_outputs |
		jq -er '.[] | select(.focused==true) |
		.current_mode|(.width | tostring) + " " + (.height | tostring)']=])
	local raw = handle:read("*a")
	local dimensions = split(raw)
	handle:close()
	return dimensions
end

function is_floating()
	local floating = os.execute([=[swaymsg -t get_tree |
		jq -er '.. | select(.type?) | select(.focused==true) |
		.type == "floating_con"' >/dev/null]=]
	)
	if floating then
		return true
	else
		return false
	end
end

function get_current_window_id()
	local handle = io.popen([=[swaymsg -t get_tree |
		jq -r '..|try select(.focused==true).id']=]
	)
	local id = handle:read("*a")
	handle:close()
	return id
end

function maximize()
	local bar_height = get_waybar_height()
	local resolution = get_output_res()
	local floating = is_floating()
	local window_id = get_current_window_id()
	local window_height = resolution[2] - bar_height
	local window_width = resolution[1]
	output_str = ('border pixel 1; floating enable; resize set '
	..  window_width .. ' ' .. window_height)
	os.execute('swaymsg \"' .. output_str .. '\"')
end

if is_floating() then
	os.execute('swaymsg floating off')
else
	maximize()
end
