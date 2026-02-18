#!/usr/bin/env lua

local player = arg[1]
local x, y, z

if #arg < 4 then
	error('USAGE: lua remote_prison.lua <player name> <return x> <return y> <return z> [<time>]')
end

x = arg[2] or '0'
y = arg[3] or '0'
z = arg[4] or '0'
local sleep_time = arg[5] or '30'

local to_prison
to_prison = string.format([=[ssh -i .ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "teleport %s %s %s %s" ENTER']=], player, '0', '300', '0')

local tp_back
tp_back = string.format([=[ssh -i .ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "teleport %s %s %s %s" ENTER']=], player, x, y, z)

os.execute(to_prison)
os.execute(string.format('sleep %s', sleep_time))
os.execute(tp_back)
