#!/usr/bin/env lua

--[[
Take folder paths as args

ls the contents of each, store in a table or SLL - filter out directories

Go through each element of the first list and compare the file contents to the second list,
if there's a match, then run diff on the two files and print the output.

TODO:
-- Handle recursive checking through directories
]]

LinkedList = require('linked_list')

local function read_ls(path, a)
	if a then
		a = 'a'
	else
		a = ''
	end
	local handle = io.popen(string.format('ls -l%s %s',a, path))

	if not handle then
		error('Error: io.popen() failed!')
	end

	local stack = LinkedList:new()

	-- skip the first line
	handle:read('*l')

	for line in handle:lines() do
		-- check if its a directory, if not add to stack
		if not string.match(line, '^d') then
			stack:push(split_to_stack(line):pop())
		end
	end
	handle:close()
	return stack:reverse()
end

function split_to_stack(str, delim)
	local stack = LinkedList:new()
	local delim = delim or '%s+'
	for token in string.gmatch(str, '[^' .. delim .. ']+') do
		stack:push(token)
	end
	return stack
end

local ls1 = read_ls(arg[1], arg[3])

local ls2 = read_ls(arg[2], arg[3])

local filename = ls1:pop()
while filename do
	if ls2:contains(filename) then
		local handle = io.popen(string.format(
			'diff %s/%s %s/%s',
			arg[1], filename, arg[2], filename
		))
		local tmp = handle:read('*line')
		print(tmp)
		print('---')
		if tmp ~= '' then
			print(filename)
			for line in handle:lines() do
				print(line)
			end
		end
		handle:close()
	end
	filename = ls1:pop()
end
