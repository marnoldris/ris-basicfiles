if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim

alias spyderc='~/spyder-venv/bin/spyder --conf-dir ~/spyder-venv/etc/spyder/config/'
alias spyder='~/spyder-venv/bin/spyder'

alias cp="cp -rv"
alias mv="mv -v"
alias ls="ls -l --color"

alias sway_config="nvim ~/.config/sway/config"
alias nvim_config="nvim ~/.config/nvim/init.lua"
