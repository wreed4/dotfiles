# Willie Reed
# bash config

#{{{ ######  VARIABLES ######

export EDITOR=vim
export VISUAL=$EDITOR
export PATH=$HOME/bin:$PATH
#export TERM=xterm-256color

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#}}}

#{{{ ##### ALIASES ######
# general
alias ls="ls --color=auto --group-directories-first"
alias la="ls -A"
alias ll="ls -l"
alias lal="ls -lA"
alias erc="$EDITOR ~/.bashrc"

alias so="source"
alias src="source ~/.bashrc"

alias rmd="rm *.d"

# default flags
alias tmux="tmux -u"
alias ssh="ssh -XC"
alias cs="cscope -b"
alias pyclewn="pyclewn --window=bottom" # default arguments for pyclewn 
alias ctags="ctags -R --c++-kinds=+lpx --fields=+amiS --extra=+q --totals --exclude=submit *.cxx *.h "
alias grep="grep --color"

#alias lt="\!\! | less" # "less that".  Carefull, this can be dangerous because it uses the '!!' macro  # DOESN'T WORK 


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


if [ -e ~/.bashrc_custom ]; then
    source ~/.bashrc_custom
fi

# vim: set foldmethod=marker:
