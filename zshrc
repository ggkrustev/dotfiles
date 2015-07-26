export SHELL=/bin/zsh

autoload -U colors && colors
autoload -U zmv
autoload -U compinit
autoload -Uz zcalc

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "%{$fg_bold[yellow]%}${ref#refs/heads/}%{$reset_color%}"
  fi
}


# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='%{$fg_bold[blue]%}$%{$reset_color%} '
export RPROMPT='${SSH_CONNECTION+"%{$fg_bold[cyan]%}"}%{$fg_bold[cyan]%}%~%{$reset_color%} -- $(git_prompt_info) $HOST'

__git_files () {
    _wanted files expl 'local files' _files
}

stty -ixon

# completion
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR='mvim -v'
export SUDO_EDITOR='mvim -v'

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v

# use incremental search
bindkey ^R history-incremental-search-backward

# expand functions in the prompt
setopt prompt_subst

# ignore duplicate history entries
setopt histignoredups

setopt share_history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

setopt APPEND_HISTORY

# homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/android/platform-tools:/usr/local/android/tools

export NODE_PATH=/usr/local/lib/node_modules:/usr/lib/node_modules:$NODE_PATH
