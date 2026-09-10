setopt clobber

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

unsetopt EXTENDED_GLOB

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

fzf-history() {
  BUFFER=$(fc -lnr 1 | fzf --border=sharp --exact --exit-0 --height=45% --highlight-line --keep-right --layout=reverse --no-sort)
  CURSOR=${#BUFFER}
  zle reset-prompt
}

zle -N fzf-history
bindkey '^R' fzf-history
