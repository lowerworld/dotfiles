export ASDF_DATA_DIR=~/.dotfiles/tag-asdf/.asdf
source ${ASDF_DATA_DIR}/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
