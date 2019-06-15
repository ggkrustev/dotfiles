#!/bin/bash

source "$PWD/vscode_extensions.sh"

settings="settings.json"
target="$HOME/Library/Application Support/Code/User/$settings"

if [[ -e $target ]]; then
  if [[ ! -L $target ]]; then
    echo "WARNING: original '$target' will be removed"
    rm -f "$target"
  fi

  echo "[VSCode]: symlink user's settings"
  ln -sf "$PWD/$settings" "$target"
fi

if [ -x $(which code) ]; then
  for (( i=0; i<${#extensions[*]}; i++ ))
  do
    echo "[VSCode]: install ${extensions[$i]}"
    code --install-extensions --force ${extensions[$i]}
  done
fi
