#!/usr/bin/env lua

local user = arg[1] or 'user'

os.execute(string.format('malcontent-client set-app-filter %s --disallow-user-installation --disallow-system-installation app/io.github.ungoogled_software.ungoogled_chromium/x86_64/stable app/io.gitlab.librewolf-community/x86_64/stable', user))
--os.execute(string.format('malcontent-client set-app-filter %s app/io.github.ungoogled_software.ungoogled_chromium/x86_64/stable', user))
--os.execute(string.format('malcontent-client set-app-filter %s --deny-app-installation', user))

os.execute(string.format('malcontent-client set-web-filter %s --force-safe-search --filter-type block-list adult=https://v.firebog.net/hosts/Prigent-Adult.txt advertising=https://v.firebog.net/hosts/Prigent-Ads.txt', user))
