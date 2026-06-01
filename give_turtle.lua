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
	'\\"minecraft:netherrack\\"',
}

local upgrades = {
	'\\"minecraft:diamond_pickaxe\\"',
}

local place_string = table.concat(can_place, ',')
local upgrade_string = table.concat(upgrades, ',')

local player = arg[1] or '@p'

local turtle_cmd = string.format(
	'give %s computercraft:turtle_advanced{CanPlaceOn:[%s],BlockEntityTag:{CanPlaceOn:[%s]},RightUpgrade:%s} 1',
	player,
	place_string,
	place_string,
	upgrade_string
)


print(turtle_cmd)

local cmd = string.format(
	[[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "%s" ENTER']],
	turtle_cmd
)
os.execute(cmd)

local coal_num = 64/4
local coal_string = string.format(
	[[give %s minecraft:coal_block %d]],
	player,
	coal_num
)
local coal_block_cmd = string.format(
	[[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "%s" ENTER']],
	coal_string
)
os.execute(coal_block_cmd)

--[[ Turtle Wand Code ]]

local can_destroy = {
	'\\"computercraft:turtle_advanced\\"',
	'\\"computercraft:turtle_normal\\"'
}
local can_destroy_string = table.concat(can_destroy, ',')

local sword_attributes = {
	'\\\"text\\\":\\\"Turtle Destroyer\\\"',
	--'\\\"italic\\\":false',
}
local sword_attr_string = table.concat(sword_attributes, ',')

local sword_cmd = string.format(
	[[give %s minecraft:netherite_sword{CanDestroy:[%s],display:{Name:'{%s}'}} 1]],
	player,
	can_destroy_string,
	sword_attr_string
)

local s_cmd = string.format(
	[[ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154 'tmux send-keys -t forge-server:0 "%s" ENTER']],
	sword_cmd
)
print(s_cmd)

--os.execute(s_cmd)
