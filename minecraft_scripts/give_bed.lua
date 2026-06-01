#!/usr/bin/env lua

--[[ Turtle code ]]
local can_place = {
	'\\"minecraft:deepslate\\"',
	'\\"minecraft:grass_block\\"',
	'\\"minecraft:dirt\\"',
	'\\"minecraft:stone\\"',
	'\\"minecraft:cobblestone\\"',
	'\\"minecraft:sand\\"',
	'\\"minecraft:gravel\\"',
	'\\"minecraft:planks\\"',
	'\\"minecraft:spruce_planks\\"',
	'\\"minecraft:mossy_cobblestone\\"',
}

local upgrades = {
	'\\"minecraft:diamond_pickaxe\\"',
}

local place_string = table.concat(can_place, ',')
local upgrade_string = table.concat(upgrades, ',')

local player = arg[1] or '@p'

local bed_cmd = string.format(
	'give %s minecraft:white_bed{CanPlaceOn:[%s],BlockEntityTag:{CanPlaceOn:[%s]}} 1',
	player,
	place_string,
	place_string,
	upgrade_string
)


print(bed_cmd)

local cmd = string.format(
	[[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "%s" ENTER']],
	bed_cmd
)
os.execute(cmd)

