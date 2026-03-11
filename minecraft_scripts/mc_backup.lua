#!/usr/bin/env lua

--[[ package.path must have the script directory appended if the required scripts are not in standard locations ]]
--package.path = package.path .. ';/srv/minecraft/minecraft_scripts/?.lua'
local m = require('find_oldest')

--[[ Make the folder /srv/minecraft/world_backup if it doesn't already exist ]]
local handle = io.popen('ls -la /srv/minecraft')
local ls_results = {}
for line in handle:lines() do
	table.insert(ls_results, line)
end
handle:close()

local world_backup_exists = false
for i,v in ipairs(ls_results) do
	if string.match(v, 'world_backup$') and
	   string.match(v, '^d') then
		world_backup_exists = true
	end
end

print(world_backup_exists)

if not world_backup_exists then
	os.execute('mkdir /srv/minecraft/world_backup')
end

--[[
Check the size of the /srv/minecraft/world_backup folder.

If it is greater than a certain size:
	List the file names and put them into a table
	Run m.find_oldest(filenames)
	rm the oldest folder
--]]

local handle = io.popen('du -s -B G /srv/minecraft/world_backup')
local size = string.match(handle:read(), '^%d+')
-- convert size to a number from a string
size = size + 0
handle:close()

if size > 3 then
	print('Backup folder too large, deleting oldest...')
	local handle = io.popen('ls /srv/minecraft/world_backup')
	local worlds = {}
	for backup in handle:lines() do
		table.insert(worlds, backup)
	end
	handle:close()
	local oldest = m.find_oldest(worlds)
	--[[
	io.write('Oldest backup: ' .. oldest .. '\nWould you like to delete it? [y/N]\n> ')
	io.flush()
	local response = io.read()
	response = response:gsub('%u', string.lower)
	if response:match('^y') then
		os.execute(string.format('rm -rf /srv/minecraft/world_backup/%s', oldest))
		print('Removed backup ' .. oldest)
	end
	--]]
	os.execute(string.format('rm -rf /srv/minecraft/world_backup/%s', oldest))
end

--[[ Backup the current world with the date appended in the format day_month_year using rsync ]]

local day = os.date('%d')
local month = os.date('%m') + 0
local year = os.date('%Y')
local filename = 'world_' .. day .. '_' .. month .. '_' .. year
os.execute(string.format('rsync -avhP /srv/minecraft/world /srv/minecraft/world_backup/%s', filename))
