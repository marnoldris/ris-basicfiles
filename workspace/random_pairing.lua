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
	--[[ Start at the end and work backwards ]]
	for i = #t, 1, -1 do
		j = math.random(i) -- Get a random number bounded by i
		temp = t[i] -- Store the value at i
		t[i] = t[j] -- Swap the value at j to i
		t[j] = temp -- Place the value stored for i at j
	end
end

local function title(s)
	return string.gsub(s, '%f[%w]%l', string.upper)
end

file = io.open(arg[1])

names = {}

if file then
	for line in file:lines() do
		--[[ Filter out empty lines ]]
		if not line:match('%S') then -- %S is the inverse of whitespace characters
			goto continue
		end
		--[[ If the line is in the form <last name>, <first name> ]]
		if line:match(',') then
			local parts = split(line, ',') -- strip whitespace
			local first_name = parts[2]
			local last_name = parts[1]
			table.insert(names, first_name .. ' ' .. last_name)
		--[[ If the line is in the form of <first name> ]]
		else
			name = line:gsub('%s', '') -- strip whitespace
			table.insert(names, name)
		end

		::continue::
	end
else
	error('Error: file not found!')
end

--[[ Randomize the table ]]
shuffle(names)

--[[ Make the table of pairs. Each pair is a table ]]
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

--[[ Make a table of strings to print ]]
output_table = {}

for _,pair in ipairs(pairs) do
	for i = 1, #pair do
		pair[i] = title(pair[i])
	end
	local out = table.concat(pair, ' and ')
	table.insert(output_table, out)
end

for _,v in ipairs(output_table) do
	print(v)
end

--[[ Saving to a file ]]
io.write('Would you like to save the pairings to a file? [y/N]\n> ') -- We use this instead of print() to avoid printing a newline char
io.flush()
response = io.read()
response = response:gsub('%u', string.lower)

if response:match('^y') then
	if arg[2] then
		out_file = arg[2]
	else
		io.write('Please enter a file name: ')
		io.flush()
		out_file = io.read()
	end

	--[[ Try to open the file to see if it exists ]]
	output = io.open(out_file)
	if output then
		io.close(output) -- close the file
		print('File already exists, overwrite? [Y/n]')
		io.write('> ')
		io.flush()
		overwrite = io.read()
		overwrite = overwrite:gsub('%u', string.lower)
		if overwrite:match('^n') then
			print('File not written.')
			os.exit()
		else
			--[[ Open and close the file in write mode to clear it ]]
			output = io.open(out_file, 'w')
			io.close(output)
		end
	end

	--[[ Open the file in write mode ]]
	output = io.open(out_file, 'a')
	for _, pairing in ipairs(output_table) do
		output:write(pairing .. '\n')
	end
	io.close(output)
	print('Pairings written to file ' .. out_file .. '.')
end
