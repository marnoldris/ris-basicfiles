#!/usr/bin/env lua


local function ldg()

	-- This creates a hash table for extremely fast lookups and cleaner syntax
	local exit_values = {[''] = true} --, quit = true, q = true, QUIT = true}

	-- Functions
	local function locals()
		local vars = {}
		local i = 1
		while true do
			local ln, lv = debug.getlocal(3, i)
			if ln ~= nil then
				vars[ln] = lv
			else
				break
			end
			i = i + 1
		end
		return vars
	end

	local function upvalues()
		local vars = {}
		local i = 1
		local func = debug.getinfo(3, 'f').func
		while true do
			local ln, lv = debug.getupvalue(func, i)
			if ln ~= nil then
				vars[ln] = lv
			else
				break
			end
			i = i + 1
		end
		return vars
	end

	local function tab_rec(name, val, indent)
		indent = indent or ''
		if type(val) == 'table' then
			--print(indent .. name .. ' = ' .. tostring(val))
			print(indent .. tostring(val))
			print(indent .. name .. ' = {')
			for k, v in next, val do
				if type(v) == 'table' then
					tab_rec(tostring(k), v, indent .. '  ')
				else
					print(indent .. '  ' .. tostring(k) .. ' = ' .. tostring(v))
				end
			end
			io.write(indent .. '}')
			if indent ~= '' then io.write(',\n') else io.write('\n') end
			io.flush()
			--print(indent .. '}')

		end
	end


	print('Entering debug mode.')
	print('Press Return to continue your script or enter a variable name to print its value.\n')

	repeat
		local locals = locals()
		local upvals = upvalues()
		local globals = _ENV
		local found = false
		io.write('>> ')
		io.flush()
		local question = io.read()
		if locals[question] ~= nil then
			found = true
			local found_var = locals[question]
			if type(found_var) == 'table' then
				--[[
				for k, v in pairs(found_var) do
					print(tostring(k), tostring(v))
				end
				--]]
				print('Local table found:\n')
				tab_rec(question, locals[question])
			else
				print('Local variable ' .. question .. ':\n' .. locals[question])
			end
		end
		if upvals[question] ~= nil then
			found = true
			local found_var = upvals[question]
			if type(found_var) == 'table' then
				--[[
				for k, v in pairs(found_var) do
					print(tostring(k), tostring(v))
				end
				--]]
				print('Upvalue table found:\n')
				tab_rec(question, upvals[question])
			else
				print('Upvalue ' .. question .. ':\n' .. upvals[question])
			end
		end
		if globals[question] ~= nil then
			found = true
			local found_var = globals[question]
			if type(found_var) == 'table' then
				--[[
				for k, v in pairs(found_var) do
					print(tostring(k), tostring(v))
				end
				--]]
				print('Global table found:\n')
				tab_rec(question, globals[question])
			else
				print('Global variable ' .. question .. ':\n' .. globals[question])
			end
		end

		if not found and not exit_values[question] then
			print('Variable not found.')
		end

		--[[ for k,v in pairs(locals) do print(k, v) end ]]
		--[[ for k,v in pairs(upvals) do print(k, v) end ]]
		--[[ for k,v in pairs(globals) do print(k, v) end ]]
	until exit_values[question]
	print('Exiting debug...')
end


--[[
local a = 1
b = 2
local c = {'one', 'two', three = 3}
d = {'a','b','c'}

ldg()
--]]

return ldg
