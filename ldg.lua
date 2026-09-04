#!/usr/bin/env lua

local function ldg()

	-- This creates a hash table for extremely fast lookups and cleaner syntax
	local exit_values = {[''] = true, quit = true, q = true, QUIT = true}

	repeat
		io.write('>> ')
		io.flush()
		local question = io.read()
	until exit_values[question]
	print('Exiting debug...')
end

ldg()
