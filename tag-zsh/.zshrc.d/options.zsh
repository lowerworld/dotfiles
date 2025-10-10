typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zsh_history
unsetopt EXTENDED_GLOB

setopt clobber
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
