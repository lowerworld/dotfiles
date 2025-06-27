setopt prompt_subst
setopt re_match_pcre

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' formats       '%F{067}[%F{081}%b%m%F{067}]%f'
zstyle ':vcs_info:git*:*' actionformats '%F{067}[%F{081}%b%F{236}|%F{135}%a%m%F{067}]%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-set-misc

+vi-git-set-misc() {
  [[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" != 'true' ]] && return 1

  local -A count=(staged 0 unmerged 0 unstaged 0 untracked 0)

  for line in ${(@f)"$(git status --porcelain=v2 2> /dev/null)"}; do
    if   [[ ${line} =~ '^[12] \.\w' ]]; then ((count[unstaged]++))
    elif [[ ${line} =~ '^[12] \w\.' ]]; then ((count[staged]++))
    elif [[ ${line} =~ '^[12] \w\w' ]]; then ((count[staged]++)); ((count[unstaged]++))
    elif [[ ${line} =~ '^u'  ]]; then ((count[unmerged]++))
    elif [[ ${line} =~ '^\?' ]]; then ((count[untracked]++))
    fi
  done

  local -a misc

  [[ count[staged]    -gt 0 ]] && misc+=("%F{118}+${count[staged]}%F{236}")
  [[ count[unmerged]  -gt 0 ]] && misc+=("%F{162}!${count[unmerged]}%F{236}")
  [[ count[unstaged]  -gt 0 ]] && misc+=("%F{208}+${count[unstaged]}%F{236}")
  [[ count[untracked] -gt 0 ]] && misc+=("%F{059}?${count[untracked]}%F{236}")

  if [[ ${#misc} -gt 0 ]]; then
    hook_com[misc]="%F{236}|${(j.,.)misc}%f"
  else
    hook_com[misc]=''
  fi
}

PROMPT='%F{236}------------------------------------------------------------%f
%F{033}%~%f${vcs_info_msg_0_} %F{067}%(!.#.»)%f '

RPROMPT='%F{236}%n@%m%f'
