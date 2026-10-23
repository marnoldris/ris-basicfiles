#!/usr/bin/env lua

local name = arg[1] or 'user'
local blocked = {
	'/usr/bin/dconf-editor',
	'/usr/bin/gsettings',
	'/usr/bin/gnome-control-center',
	'/usr/bin/gnome-tweaks',
	'/usr/bin/cachy-update',
	'/usr/bin/cachyos-hello',
	'/usr/bin/gnome-software',
	'/usr/bin/cachyos-pi',
	'/usr/bin/cachyos-kernel-manager',
}

-- Make a student group and add the user to it
os.execute('sudo groupadd student')
os.execute(string.format('sudo usermod -aG student %s', name))

-- Use setfacl to remove permissions to the given programs.
for _, program in ipairs(blocked) do
	os.execute(string.format('sudo setfacl -m g:student:--- %s', program))
end

-- Use malcontent to restrict flatpaks and internet content
-- Note that every time you run set-app-filter it overwrites the previous filter, so you need to include everything at once
os.execute(string.format('malcontent-client set-app-filter %s --disallow-user-installation --disallow-system-installation app/io.github.ungoogled_software.ungoogled_chromium/x86_64/stable app/io.gitlab.librewolf-community/x86_64/stable', name))
os.execute(string.format('malcontent-client set-web-filter %s --force-safe-search --filter-type block-list adult=https://v.firebog.net/hosts/Prigent-Adult.txt advertising=https://v.firebog.net/hosts/Prigent-Ads.txt', name))
