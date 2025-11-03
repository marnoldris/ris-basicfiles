#!/usr/bin/env lua

filename = arg[1]

--[[
The (.-) match any number of any characters, the %. escapes the .
so it can be matched and used as the end point.
Using - intead of + matches the shortest instance.
]]
extless = string.match(filename, "^(.-)%.")

output_file = extless .. '_KEY'

if not os.execute([=[grep -q '^\\printanswers' ]=] .. filename) then
	print('File is not in "KEY" mode, fixing...')
	os.execute([=[sed -i '/\\printanswers/c\\\\printanswers' ]=] .. filename)
end

os.execute('pdflatex -jobname=' .. output_file .. ' ' .. filename)
os.execute('rm *.log *.aux')

os.execute([=[sed -i '/\\printanswers/c\%\\printanswers' ]=] .. filename)
