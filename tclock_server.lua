#!/usr/bin/env lua

---[[
os.execute([=[foot -F tmux new-session -s tclock 'termdown -f doh -z -Z "%-I:%M %p"' &]=])
os.execute('sleep 10')
--]]
os.execute('ydotool mousemove -a -x 800 -y 300')
os.execute('ydotool click LEFT')
os.execute('ydotool mousemove -a -x 0 -y 0')

