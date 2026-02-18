#!/usr/bin/env lua

local function find_oldest(t, separator)
	--[[
	Returns the oldest file or folder from the given table when the date is appended to the name.
	Date format must be:
	DAY<sep>MONTH<sep>YEAR
	--]]
	local sep = separator or '_'
	local smallest_year = {}
	local smallest_month = {}
	local smallest_day = {}
	local smallest
	local tmp_smallest = math.huge
	
	for _, v in ipairs(t) do
		if v:match('%d+' .. sep .. '%d+' .. sep .. '(%d+)') then
			tmp_smallest = math.min(tonumber(v:match('%d+' .. sep .. '%d+' .. sep .. '(%d+)')), tmp_smallest)
		end
	end
	for _, v in ipairs(t) do
		if tonumber(v:match('%d+' .. sep .. '%d+' .. sep .. '(%d+)')) == tmp_smallest then
			table.insert(smallest_year, v)
		end
	end

	for _, v in ipairs(smallest_year) do
		print(v)
	end
	print('---')

	tmp_smallest = math.huge
	for _, v in ipairs(smallest_year) do
		tmp_smallest = math.min(tonumber(v:match('%d+' .. sep .. '(%d+)' .. sep .. '%d+')), tmp_smallest)
	end
	for _, v in ipairs(smallest_year) do
		if tonumber(v:match('%d+' .. sep .. '(%d+)' .. sep .. '%d+')) == tmp_smallest then
			table.insert(smallest_month, v)
		end
	end
	for _, v in ipairs(smallest_month) do
		print(v)
	end
	print('---')

	tmp_smallest = math.huge
	for _, v in ipairs(smallest_month) do
		tmp_smallest = math.min(tonumber(v:match('(%d+)' .. sep .. '%d+' .. sep .. '%d+')), tmp_smallest)
	end
	for i, v in ipairs(smallest_month) do
		if tonumber(v:match('(%d+)' .. sep .. '%d+' .. sep .. '%d+')) == tmp_smallest then
			smallest = smallest_month[i]
			return smallest
			--table.insert(smallest_day, v)
		end
	end

	--[[
	smallest = smallest_day[1]
	return smallest
	--]]
end

--print(find_oldest({'world', 'world_2_3_18', 'world_1_3_18', 'world_10_10_18'}))
