#!/usr/bin/env lua

filename = arg[1]

if os.execute([=[grep -q '^\\printanswers' ]=] .. filename) then
	print('File is in "KEY" mode, fixing...')
	os.execute([=[sed -i '/\\printanswers/c\%\\printanswers' ]=] .. filename)
end

os.execute('pdflatex ' .. filename)
os.execute('rm *.log *.aux')
