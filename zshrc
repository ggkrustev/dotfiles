export SHELL=/bin/zsh
export LANG="en_US.UTF-8"

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

#git credential helper
case `uname -a` in
  *Linux*)
      git config --global credential.helper "cache --timeout=3600";;
  *Darwin*)
      git config --global credential.helper osxkeychain
    # what?
    ;;
esac


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
case `uname -a` in
  *Linux*)
    export EDITOR='vim -v'
    export SUDO_EDITOR='vim -v'
    ;;
  *Darwin*)
    export EDITOR='mvim -v'
    export SUDO_EDITOR='mvim -v'
    ;;
esac

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
export NODE_PATH=~/.npm-global/bin:/usr/local/lib/node_modules:/usr/lib/node_modules:$NODE_PATH

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/android/platform-tools:/usr/local/android/tools
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$NODE_PATH:$PATH"

# Android Development
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# GO language
export GOROOT=/usr/local/go
export GOPATH=$HOME/work
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
