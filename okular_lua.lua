#!/usr/bin/env lua

filename = arg[1]

-- print(filename)

--[[
The (.+) match any number of any characters, the %. escapes the .
so it can be matched and used as the end point.
Using - intead of + matches the shortest instance.
--]]
extless = string.match(filename, "^(.-)%.")
print(extless)

--[[
The %. escapes the period and uses it as the start point, and
the (%w+) matches any number of word characters. $ is the end of line
--]]
ext = string.match(filename, "%.(%w+)$")
print(ext)

if ext == 'tex' then
	os.execute('okular ' .. extless .. '.pdf &')
else
	os.execute('okular ' .. filename .. ' &')
end
