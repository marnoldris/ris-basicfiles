#!/usr/bin/env lua

local player = arg[1]
local freeze_time = arg[2] or '10'

local freeze = string.format([=[ssh -i .ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "effect give %s minecraft:slowness 255 255 true" ENTER']=], player)
local no_jump = string.format([=[ssh -i .ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "effect give %s minecraft:jump_boost 1000000 128" ENTER']=], player)
local unfreeze = string.format([=[ssh -i .ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "effect clear %s minecraft:slowness" ENTER']=], player)
local jump = string.format([=[ssh -i .ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "effect clear %s minecraft:jump_boost" ENTER']=], player)
os.execute(freeze)
os.execute(no_jump)
os.execute(string.format('sleep %s', freeze_time))
os.execute(unfreeze)
os.execute(jump)

