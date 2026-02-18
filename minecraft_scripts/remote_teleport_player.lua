#!/usr/bin/env lua

local player = arg[1]
local player_2
local x, y, z
if string.match(arg[2], '%D') then
	player_2 = arg[2]
else
	x = arg[2] or '0'
	y = arg[3] or '0'
	z = arg[4] or '0'
end

local cmd
if string.match(arg[2], '%D') then
	cmd = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "teleport %s %s" ENTER']=],
	                    player, player_2)
else
	cmd = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "teleport %s %s %s %s" ENTER']=],
                          player, x, y, z)
	print(string.format('Teleporting %s to %s %s %s...', player, x, y, z))
end

os.execute(cmd)
