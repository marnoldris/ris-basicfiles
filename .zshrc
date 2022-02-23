# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/new/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PATH="$PATH:/$HOME/.local/bin"

#RPROMPT='%(?.%F{blue}.%F{#FFFF00})%T%f'
RPROMPT='%F{#FFFF00}%T%f'
PROMPT='%B%(?.%F{green}.%F{red})>%f %F{cyan}%n%f%F{green}@%f%F{cyan}%m %~%f%b %F{green}%(!.#.$)%f '

bindkey '^R' history-incremental-search-backward

alias tshift="sudo timeshift-autosnap && sudo update-grub"
alias scan="sudo arp-scan --localnet"
alias zip="zip -r"
alias klogout="qdbus org.kde.ksmserver /KSMServer logout 0 0 0"
alias tmp="cd $(mktemp -d)"

alias vc="protonvpn-cli c -f"
alias vd="protonvpn-cli d"

# Rust replacements: exa, bat, ripgrep (rg), fd (find), procs, broot (tree+)
alias ls="exa --long"
alias ls.="exa --all --long"
alias tree="exa --tree"

VISUAL="vim"
EDITOR="$VISUAL"

neofetch
