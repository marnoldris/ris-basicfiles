#!/usr/bin/env lua

local function contains(table, value)
	for i, val in ipairs(table) do
		if val == value then
			return true
		end
	end
	return false
end


--[[Set options and create a string to concat]]
options = {
	'sink_name=dual_bt',
	'slaves=bluez_output.C0_28_8D_F5_C3_17.1,bluez_output.28_FA_19_5E_6B_9C.1',
	'sink_properties=device.description="Dual bluetooth speaker output"',
	'adjust_time=0'
}

options_string = table.concat(options, ' ')


--[[Get audio devices]]
handle = io.popen([=[pactl list short sinks | awk '{print $2}']=])

if not handle then
	error('Unable to execute command')
end

audio_devices = {}
for line in handle:lines() do
	table.insert(audio_devices, line)
end
handle:close()


--[[
Check if the dual_bt device already exists, if not, create it.
If it does exist, remove it.
]]
if contains(audio_devices, 'dual_bt') then
	-- kill the device
	os.execute('pactl unload-module module-combine-sink')
else
	os.execute('pactl load-module module-combine-sink ' .. options_string)
	os.execute('pactl set-default-sink dual_bt')
end
