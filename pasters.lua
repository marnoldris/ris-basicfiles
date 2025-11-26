#!/usr/bin/env lua

local function copy_to_clipboard(str)
	if not os.execute('which wl-copy > /dev/null 2>&1') then
		error('wl-copy not found, try installing it with # pacman -Sy wl-clipboard')
	else
		os.execute(string.format('wl-copy %s', str))
		print('URL copied to clipboard')
	end
end

local function pasters(...)

	local cmd
	local file   = select(1, ...)-- or '/dev/stdin'
	local delete = select(2, ...)

	if not file then
		print('Enter text to upload to https://paste.rs below.')
		print('Press Enter/Return then Ctrl+d when you are finished.\n')
		---[[
		file = os.tmpname()
		local user_input = io.read('*a')

		local tmp_file = assert(io.open(file, 'w'))
		tmp_file:write(user_input)
		tmp_file:close()
		--]]
	end

	if delete then
		print('Deleting ' .. file .. '...')
		if string.match(file, '^https') then
			cmd = string.format('curl -X DELETE %s', file)
		else
			cmd = string.format('curl -X DELETE https://paste.rs/%s', file)
		end
		os.execute(cmd)
	else
		cmd = string.format('curl --data-binary @%s https://paste.rs', file)
		---[[
		local handle = io.popen(cmd)
		local last_line
		for line in handle:lines() do
			last_line = line
		end
		handle:close()
		print(last_line)

		-- Note this helper function must be declared ABOVE this function
		copy_to_clipboard(last_line)
		--]]
	end
end

pasters(arg[1], arg[2])
