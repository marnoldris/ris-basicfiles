#!/usr/bin/env lua

filename = arg[1]

print(filename)

extless = string.match(filename, "(.+)%.")
print(extless)

ext = string.match(filename, "%.(%w+)$")
print(ext)

if ext == 'tex' then
	os.execute('okular ' .. extless .. '.pdf')
else
	os.execute('okular ' .. filename)
end
