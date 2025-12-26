source ${${(%):-%N}:A:h}/.zimfw.zsh

if [[ ! -d ~/.config/zshrc.d ]]; then
  mkdir -p ~/.config/zshrc.d
fi

for file in ${${(%):-%N}:A:h}/.zshrc.d/*.zsh ~/.config/zshrc.d/*.zsh(N-.); do
  source ${file}
done
