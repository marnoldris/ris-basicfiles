#!/usr/bin/env lua

local function help()
	print('Pomodoro is a technique used to improve productivity and focus by breaking work periods into smaller chunks of time with short breaks between.')
	print('The default time is 25 minutes of focus with 10 minute breaks for four cycles, followed by a 15 minute break. To run a session this way, simply run lua pomodoro.lua.')
	print('\nUsage:\nlua pomodoro.lua <focus time> <break time> <long break time> <number of cycles>')
	os.exit()
end


local help_values = {['-h'] = true, ['--help'] = true, ['help'] = true}
local cont_values = {[''] = true, ['y'] = true, ['Y'] = true}

if help_values[arg[1]] then
	help()
end

local focus_time = arg[1] or '25' -- these are fine as strings
local rest_time = arg[2] or '10'
local long_break_time = arg[3] or '15'
local cycles = tonumber(arg[4]) or 4 -- needs to be a number

local focus      = string.format('termdown -f doh -T "Focus time:" %smin', focus_time)
local rest       = string.format('termdown -f doh -T "Break time:" %smin', rest_time)
local long_break = string.format('termdown -f doh -T "Long break:" %smin', long_break_time)
local cont

repeat
	for i=1, cycles do
		os.execute(focus)
		if i < cycles then
			os.execute(rest)
		end
	end
	if arg[3] then
		os.execute(long_break)
	end
	os.execute('clear')
	io.write('Continue? (Y/n)\n> ')
	io.flush()
	cont = io.read()
until not cont_values[cont]
