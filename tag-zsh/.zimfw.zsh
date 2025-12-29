ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

typeset -A ZSH_HIGHLIGHT_STYLES
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

ENHANCD_ENABLE_DOUBLE_DOT=false
ENHANCD_ENABLE_SINGLE_DOT=false
ENHANCD_ENABLE_HOME=false

# ------------------
# Initialize modules
# ------------------
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh
