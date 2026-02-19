#!/usr/bin/env lua

local x1 = arg[1] or '4'
local y1 = arg[2] or '298'
local z1 = arg[3] or '3'

local x2 = arg[4] or '-3'
local y2 = arg[5] or '312'
local z2 = arg[6] or '-3'

local x3 = arg[7] or '2'
local y3 = arg[8] or '310'
local z3 = arg[9] or '1'

local x4 = arg[10] or '-1'
local y4 = arg[11] or '300'
local z4 = arg[12] or '-1'


local fill_bedrock = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "fill %s %s %s %s %s %s bedrock" ENTER']=], x1, y1, z1, x2, y2, z2)

local fill_air = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "fill %s %s %s %s %s %s air" ENTER']=], x3, y3, z3, x4, y4, z4)

local place_torch = string.format([=[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "setblock %s %s %s minecraft:wall_torch[facing=east]" ENTER']=], '-1', '309', '0')

os.execute(fill_bedrock)
os.execute(fill_air)
os.execute(place_torch)

