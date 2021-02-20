export ZPLUG_HOME=${${(%):-%N}:A:h}/zplug
source ${ZPLUG_HOME}/init.zsh

zplug 'b4b4r07/enhancd', use:'init.sh'; ENHANCD_DISABLE_HOME=1
zplug 'yous/vanilli.sh'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

zplug check --verbose || zplug install
zplug load

# zsh-syntax-highlighting
local -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[arg0]='fg=118'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=135'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=135'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=161'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=161'
ZSH_HIGHLIGHT_STYLES[comment]='fg=59'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=118'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=144'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=144'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=161'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=81'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=161,underline'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=161'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=135'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=161'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=161,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=144'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=161,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
