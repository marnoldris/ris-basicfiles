#!/usr/bin/env lua

local help_values = {['-h'] = true, ['--help'] = true, ['help'] = true}

if help_values[arg[1]] then
	print('Pomodoro is a technique used to improve productivity and focus by breaking work periods into smaller chunks of time with short breaks between.')
	print('The default time is 25 minutes of focus with 10 minute breaks for four cycles, followed by a 15 minute break. To run a session this way, simply run lua pomodoro.lua.')
	print('\nUsage:\nlua pomodoro.lua <focus time> <break time> <long break time> <number of cycles>')
	os.exit()
end

local focus_time = arg[1] or '25'
local rest_time = arg[2] or '10'
local long_break_time = arg[3] or '15'
local cycles = tonumber(arg[4]) or 4

local focus      = string.format('termdown -f doh -T "Focus time:" %smin', focus_time)
local rest       = string.format('termdown -f doh -T "Break time:" %smin', rest_time)
local long_break = string.format('termdown -f doh -T "Long break:" %smin', long_break_time)

repeat
	for i=1, cycles do
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
