#!/bin/bash

settings="settings.json"
vscode_path="$PWD/vscode"
target="$HOME/Library/Application Support/Code/User/$settings"

source "$vscode_path/vscode_extensions.sh"

if [[ -e $target && ! -L $target ]]; then
  echo "WARNING: original '$target' will be removed"
  rm -f "$target"
fi

echo "[VSCode]: symlink user's $vscode_path/$settings $target"

ln -sf "$vscode_path/$settings" "$target"

if [ -x $(which code) ]; then
  for (( i=0; i<${#extensions[*]}; i++ ))
  do
    echo "[VSCode]: install ${extensions[$i]}"
    code --install-extension ${extensions[$i]}
  done
fi
