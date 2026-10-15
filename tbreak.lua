#!/usr/bin/env lua

local timer = arg[1] or '10'
local ip = arg[2] or '10.100.3.154'

local cmd = string.format([=[ssh -i ~/.ssh/minecraft_srv user@%s 'tmux new-window -t tclock: -n timer "termdown -f doh %smin"']=], ip, timer)
--local cmd = string.format([=[ssh -i ~/.ssh/minecraft_srv user@192.168.7.51 'tmux new-window -t tclock: -n timer "termdown -f doh %smin"']=], timer)

os.execute(cmd)
--os.execute('sleep ' .. tonumber(timer) * 60)
--os.execute([=[ssh -i ~/.ssh/minecraft_srv user@10.100.3.154 'tmux kill-window -t tclock:timer']=])
