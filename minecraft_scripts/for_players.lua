#!/usr/bin/env lua

local function execute_cmd(cmd)
	local handle = io.popen(cmd)
	local result = handle:read('*a')
	handle:close()
	return result
end

local ssh_server = 'ssh -i ~/.ssh/minecraft_srv minecraft@10.100.3.154'
local tmux_session = 'forge-server:0'

os.execute(string.format([[%s 'tmux send-keys -t %s "list" C-m']], ssh_server, tmux_session))

os.execute('sleep 0.1')

local raw_result = execute_cmd(string.format([[%s 'tmux capture-pane -pt %s -S -5']], ssh_server, tmux_session))
--local player_string = raw_result:match('online:%s*(.*)')
--print(player_string)
local player_string
for match in raw_result:gmatch('online:%s*(.-)\n') do
	player_string = match
end

--print(players)


---[[
local players = {}
for player in player_string:gmatch('[^,%s]+') do
	table.insert(players, player)
end

for _, name in ipairs(players) do
	print(name)
	os.execute(string.format('lua %s %s', arg[1], name))
end
--]]
