for file in ${${(%):-%N}:A:h}/.zshrc.d/*.zsh ~/.config/zshrc.d/*.zsh(N-.); do
  source ${file}
done

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
