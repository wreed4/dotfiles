# Willie Reed
# bash config

# set vim key bindings
set -o vi

#{{{ ######  VARIABLES ######

export EDITOR=vim
export VISUAL=$EDITOR
export PATH=$HOME/bin:$PATH
#export TERM=xterm-256color-italic

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#}}}

#{{{ ##### ALIASES ######
# general
alias ls="ls --color=auto --group-directories-first"
alias la="ls -A"
alias ll="ls -l"
alias lal="ls -lA"

alias erc='$EDITOR ~/.bashrc'

alias so="source"
alias src="source ~/.bashrc"

alias rmd="rm *.d"

alias lt='$(fc -ln -1) | less' # "less that".  Carefull, this can be dangerous because it executes the last command


# default flags
alias tmux="tmux -u"
alias ssh="ssh -XC"
alias cs="cscope -b"
alias pyclewn="pyclewn --window=bottom" # default arguments for pyclewn 
alias ctags="ctags -R --c++-kinds=+lpx --fields=+amiS --extra=+q --totals --exclude=submit *.cxx *.h "
alias grep="grep --color"



#}}}

#{{{ ##### HISTORY #####

HISTSIZE=9000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

history() {
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}

PROMPT_COMMAND=_bash_history_sync

#}}}

#{{{ ##### Custom Prompt #####
export PS1="\n\[\e[0;32m\]\u\[\e[0m\]@\[\e[1;35m\]\h\[\e[0m\]:\[\e[4;36m\]\w\[\e[0m\]\n-> "

#}}}

#"{{{##### FUNCTIONS #####

mkcd () { mkdir "$1" && cd "$1"; }

#}}}


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


if [ -e ~/.bashrc_custom ]; then
    alias ecrc='$EDITOR ~/.bashrc_custom'
    source ~/.bashrc_custom
fi

# vim: set foldmethod=marker:
