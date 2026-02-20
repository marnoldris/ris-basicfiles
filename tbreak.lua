#!/usr/bin/env lua

local timer = arg[1] or '10'

--local cmd = string.format([=[ssh -i ~/.ssh/minecraft_srv user@10.100.3.154 'tmux send-keys -t tclock:0 "C-b c termdown -f doh %smin"']=], timer)
local cmd = string.format([=[ssh -i ~/.ssh/minecraft_srv user@10.100.3.154 'tmux new-window -t tclock: -n timer "termdown -f doh %smin"']=], timer)

os.execute(cmd)
--os.execute('sleep ' .. tonumber(timer) * 60)
--os.execute([=[ssh -i ~/.ssh/minecraft_srv user@10.100.3.154 'tmux kill-window -t tclock:timer']=])
