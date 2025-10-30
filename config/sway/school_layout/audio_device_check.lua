#!/usr/bin/env lua

local function contains(table, value)
	for i, val in ipairs(table) do
		if val == value then
			return true
		end
	end
	return false
end

handle = io.popen([=[pactl list short sinks | awk '{print $2}']=])

if not handle then
	error('Unable to execute command')
end

audio_devices = {}
for line in handle:lines() do
	table.insert(audio_devices, line)
end
handle:close()

if contains(audio_devices, 'dual_bt') then
	print('dual_bt')
else
	print('\\@DEFAULT_SINK@')
end

