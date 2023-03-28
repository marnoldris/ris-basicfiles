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
#RPROMPT='%F{#FFFF00}%T%f'
PROMPT='%B%(?.%F{green}.%F{red})>%f %F{cyan}%n%f%F{green}@%f%F{cyan}%m %~%f%b %F{green}%(!.#.$)%f '

bindkey '^R' history-incremental-search-backward

export VISUAL="vim"
export EDITOR="$VISUAL"

# Custom Functions

# upload a file to paste.rs, or upload from stdin if no file name
# was included. Usage: paste <filename> or paste -> enter text -> ctrl+d
function pasters() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs
}

# Aliases
# Duplicate screen to dual monitor in qtile
alias dm="killall picom; xrandr --output eDP-1 --mode 1920x1080 && xrandr --output DP-3 --mode 1920x1080 --same-as eDP-1"
alias dml="xrandr --output DP-3 --mode 1920x1080 --left-of eDP-1"
alias dmr="xrandr --output DP-3 --mode 1920x1080 --right-of eDP-1"
alias dmoff="picom -b; xrandr --output DP-3 --off && xrandr --output eDP-1 --mode 1920x1200"

# qtile aliases
alias config="vim ~/.config/qtile/config.py"
alias logger="less ~/.local/share/qtile/qtile.log"

# udisksctl aliases
alias udmount="udisksctl mount -b"
alias udunmount="udisksctl unmount -b"

# Rust replacements: exa, bat, ripgrep (rg), fd (find), procs, broot (tree+)
alias ls="exa --long"
alias ls.="exa --all --long"
alias tree="exa --tree"
alias bat="bat -P"

alias tshift="sudo timeshift-autosnap && sudo update-grub"
alias scan="sudo arp-scan --localnet"
alias zip="zip -r"
alias klogout="qdbus org.kde.ksmserver /KSMServer logout 0 0 0"
alias tmp="cd $(mktemp -d)"
#alias battery='echo "$(cat /sys/class/power_supply/BAT0/capacity)%"'
alias battery='upower --show-info /org/freedesktop/UPower/devices/battery_BAT0'
alias cp="cp -v"
alias mv="mv -v"

alias jclip4="bluetoothctl connect 28:FA:19:5E:6B:9C"
alias break10="termdown 10m -f doh" # other good fonts: gothic, poison, speed, starwars, doom
alias break5="termdown 5m -f doh"
alias vpnc="protonvpn-cli connect --fastest"
alias bottom="btm"
alias feh="feh --scale-down"
alias login_chime="mpv /usr/share/sounds/Oxygen-Sys-Log-In.ogg"
