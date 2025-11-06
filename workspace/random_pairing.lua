#!/usr/bin/env lua

--[[ Read the input file ]]
if #arg < 1 then
	error([[
		
		Invalid arguments, please include a file name for the generator
		The file can be a vertical list of first names, or a vertical list 
		of names in the form: <Last Name>, <First Name>

		For example:
		carl
		katia
		lucia

		or

		warburton, carl
		grim, katia
		mar, lucia
		
		Usage: $ random_pairing.py <filename>
	]])
end

local function split(str, delim)
	--[[ Splits a string into a table based on delim ]]
	local t = {}
	delim = delim or "%s+" -- default to whitespace
	for token in string.gmatch(str, "[^" .. delim .. "]+") do
		token = token:gsub('%s', '')
		table.insert(t, token)
	end
	return t
end

local function shuffle(t)
	local j, temp
	for i = #t, 1, -1 do
		j = math.random(i)
		temp = t[i]
		t[i] = t[j]
		t[j] = temp
	end
end

file = io.open(arg[1])

names = {}

if file then
	for line in file:lines() do
		if not line:match('%S') then
			goto continue
		end
		if line:match(',') then
			local parts = split(line, ',')
			local first_name = parts[2]
			local last_name = parts[1]
			table.insert(names, first_name .. ' ' .. last_name)
		else
			name = line:gsub('%s', '')
			table.insert(names, name)
		end

		::continue::
	end
else
	error('Error: file not found!')
end

shuffle(names)

--[[
for k,v in ipairs(names) do
	print(v)
end
]]

pairs = {}

if #names % 2 == 1 then
	local temp = {}
	for i = 1, 3 do
		table.insert(temp, table.remove(names, #names))
	end
	table.insert(pairs, temp)
end

while #names > 0 do
	local temp = {}
	for i = 1, 2 do
		table.insert(temp, table.remove(names, #names))
	end
	table.insert(pairs, temp)
end

output_table = {}

for _,pair in ipairs(pairs) do
	local out = table.concat(pair, ' and ')
	table.insert(output_table, out)
end

for _,v in ipairs(output_table) do
	print(v)
end
