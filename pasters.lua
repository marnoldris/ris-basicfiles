#!/usr/bin/env lua

local function pasters()
	local file
	if #arg > 0 then
		file = arg[1]
	else
		file = '/dev/stdin'
	end
	os.execute(string.format('curl --data-binary "@%s" https://paste.rs', file))
end

pasters()
