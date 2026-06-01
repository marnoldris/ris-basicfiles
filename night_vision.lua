#!/usr/bin/env lua

--[[ Turtle code ]]

local player = arg[1] or '@p'

local night_vision = string.format(
	'effect give %s minecraft:night_vision infinite 255 true',
	player
)


print(night_vision)

local cmd = string.format(
	[[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "%s" ENTER']],
	night_vision
)
os.execute(cmd)

