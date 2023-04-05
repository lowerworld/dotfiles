setopt prompt_subst
setopt re_match_pcre

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*'      enable git
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*:*' formats       '%F{067}[%F{081}%b%m%F{067}]%f'
zstyle ':vcs_info:git*:*' actionformats '%F{067}[%F{081}%b%F{236}|%F{135}%a%m%F{067}]%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-set-misc

+vi-git-set-misc() {
  [[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" != 'true' ]] && return 1

  local -a git_status=(${(@f)"$(git status --porcelain=v2 2> /dev/null)"})

  local -A count
  for line in ${git_status}; do
    local -a types=()
    if   [[ ${line} =~ '^[12] \.\w' ]]; then types+=(unstaged)
    elif [[ ${line} =~ '^[12] \w\.' ]]; then types+=(staged)
    elif [[ ${line} =~ '^[12] \w\w' ]]; then types+=(staged unstaged)
    elif [[ ${line} =~ '^u'  ]]; then types+=(unmerged)
    elif [[ ${line} =~ '^\?' ]]; then types+=(untracked)
    fi
    for type in ${types}; do ((count[${type}]++)) done
  done

  local -a misc
  [[ ${count[(i)staged]}    ]] && misc+=("%F{118}+${count[staged]}%F{236}")
  [[ ${count[(i)unmerged]}  ]] && misc+=("%F{162}!${count[unmerged]}%F{236}")
  [[ ${count[(i)unstaged]}  ]] && misc+=("%F{208}+${count[unstaged]}%F{236}")
  [[ ${count[(i)untracked]} ]] && misc+=("%F{059}?${count[untracked]}%F{236}")

  if [[ ${#misc} -gt 0 ]]; then
    hook_com[misc]="%F{236}|${(j.,.)misc}"
  else
    hook_com[misc]=''
  fi
}

PROMPT='%F{236}------------------------------------------------------------%f
%F{033}%~${vcs_info_msg_0_} %F{067}%(!.#.»)%f '
RPROMPT='%F{236}%n@%m%f'
