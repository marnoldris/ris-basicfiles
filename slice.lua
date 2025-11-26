#!/usr/bin/env lua

local function printargs(...)
	for _,val in ipairs{...} do
		print(val)
	end
end

printargs(table.unpack(arg, 3))

--[[
Could also run this to put all the varargs into a table, then you 
pass it to the function.

sliced_args = {table.unpack(arg, 3)}
--]]
