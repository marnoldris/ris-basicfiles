#!/usr/bin/env lua

--[[ Turtle code ]]

local player = arg[1] or '@p'

local saturation_cmd = string.format(
	'effect give %s minecraft:saturation infinite 255 true',
	player
)


print(saturation_cmd)

local cmd = string.format(
	[[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "%s" ENTER']],
	saturation_cmd
)
os.execute(cmd)

