#!/usr/bin/env lua

local function printargs(...)
	-- Note the ipairs{...} syntax, this puts the varargs into a table for ipairs()
	for _,val in ipairs{...} do
		print(val)
	end
end

-- Unpack the table into a vararg object, starting from arg[3]
printargs(table.unpack(arg, 3))

--[[
Could also run this to put all the varargs into a table, starting at arg[3], then you pass it to the function.

sliced_args = {table.unpack(arg, 3)}
--]]
