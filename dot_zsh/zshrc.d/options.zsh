setopt clobber
unsetopt EXTENDED_GLOB

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

local -A key
[[ -n "${terminfo[kdch1]}" ]] && key[Delete]=${terminfo[kdch1]}
[[ -n "${terminfo[khome]}" ]] && key[Home]=${terminfo[khome]}
[[ -n "${terminfo[kend]}"  ]] && key[End]=${terminfo[kend]}

bindkey -e
[[ -n key[Delete] ]] && bindkey "${key[Delete]}" delete-char
[[ -n key[Home]   ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n key[End]    ]] && bindkey "${key[End]}" end-of-line
