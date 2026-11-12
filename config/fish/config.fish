if status is-interactive
    # Commands to run in interactive sessions can go here
	and not set -q TMUX
	exec tmux
end

fish_vi_key_bindings

set -gx EDITOR nvim

fastfetch

alias cp="cp -rv"
alias mv="mv -v"
alias ls="ls -l --color"

