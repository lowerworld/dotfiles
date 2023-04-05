source ${${(%):-%N}:A:h}/.zimfw.zsh

for file in ${${(%):-%N}:A:h}/.zshrc.d/*.zsh ~/.config/zshrc.d/*.zsh(N-.); do
  source ${file}
done
