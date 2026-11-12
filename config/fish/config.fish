if status is-interactive
    # Commands to run in interactive sessions can go here
	fastfetch
	and not set -q TMUX
	and not set -q SSH_CONNECTION
	exec tmux
end

fish_vi_key_bindings

set -gx EDITOR nvim

alias cp="cp -rv"
alias mv="mv -v"
alias ls="ls -l --color"

