#!/bin/bash

function ask() {
  read -p "$1 (Y/n): " res
  if [ -z "$res" ]; then
    lowercase_response="y"
  else
    lowercase_response=$(echo "$res" | tr '[:upper:]' '[:lower:]')
  fi

  [ "$lowercase_response" = "y" ]
}

SH="${HOME}/.bashrc"
echo >> $SH

echo "Do you want $SH to source: "
for file in shell/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    if ask "${filename}?"; then
      echo "source $(realpath "$file")" >> "$SH"
    fi
  fi
done

if ask "Create .ssh_aliases to be sourced?"; then
  if [ ! -e ~/.ssh_aliases ]; then
    touch ~/.ssh_aliases
  fi
  echo "source ~/.ssh_aliases" >> "$SH"
fi

if ask "Do you want to install .tmux.conf?"; then
  ln -s "$(realpath ".tmux.conf")" ~/.tmux.conf
fi

if ask "Do you want to install .vimrc?"; then
  ln -s "$(realpath ".vimrc")" ~/.vimrc
fi
