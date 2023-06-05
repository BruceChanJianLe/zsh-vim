#!/bin/sh
bindkey -v
export KEYTIMEOUT=1

if [[ -o menucomplete ]]; then 
  # Use vim keys in tab complete menu:
  zmodload zsh/complist
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char
  bindkey -M menuselect 'j' vi-down-line-or-history
  bindkey -M menuselect '^y' accept-line
  bindkey -M menuselect '^l' accept-line
  bindkey -M menuselect '^e' send-break
fi

# Change cursor shape for different vi modes.
# ref: https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # steady block
        viins|main) echo -ne '\e[1 q';; # blinking block
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[1 q"
}
zle -N zle-line-init
echo -ne '\e[1 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[1 q' ;} # Use beam shape cursor for each new prompt.

# emacs like keybindings
bindkey -M viins '^A' beginning-of-line 
bindkey -M viins '^E' end-of-line 
