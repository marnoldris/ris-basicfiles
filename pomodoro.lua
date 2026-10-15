#!/usr/bin/env lua

local focus_time = arg[1] or '15'
local rest_time = arg[2] or '5'
local long_break_time = arg[3] or '15'

local focus      = string.format('termdown -f doh -T "Focus time:" %smin', focus_time)
local rest       = string.format('termdown -f doh -T "Break time:" %smin', rest_time)
local long_break = string.format('termdown -f doh -T "Long break:" %smin', long_break_time)

repeat
	for i=1, 4 do
		os.execute(focus)
		os.execute(rest)
	end
	if arg[3] then
		os.execute(long_break)
	end
	os.execute('clear')
	io.write('Continue? (Y/n)\n> ')
	io.flush()
	local cont = io.read()
until cont ~= '' or cont ~= 'y' or cont ~= 'Y'
