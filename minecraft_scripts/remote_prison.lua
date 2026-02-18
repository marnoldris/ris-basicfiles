#!/usr/bin/env lua

local player = arg[1]
local player2
local x, y, z
local sleep_time

--[[
if #arg < 4 then
	error('USAGE: lua remote_prison.lua <player name> <return x> <return y> <return z> [<time>]')
end
--]]

if string.match(arg[2], '%D') then
	player2 = arg[2]
	sleep_time = arg[3] or '30'
else
	x = arg[2] or '0'
	y = arg[3] or '0'
	z = arg[4] or '0'
	sleep_time = arg[5] or '30'
end

local to_prison
to_prison = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "teleport %s %s %s %s" ENTER']=], player, '0', '300', '0')

local tp_back
if player2 then
	tp_back = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "teleport %s %s" ENTER']=], player, player2)
else
	tp_back = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "teleport %s %s %s %s" ENTER']=], player, x, y, z)
end

os.execute(to_prison)
os.execute(string.format('sleep %s', sleep_time))
os.execute(tp_back)
