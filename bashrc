# Willie Reed
# bash config

#{{{ ###### SETTINGS ######
# set vim key bindings
#set -o vi

stty -ixon
#}}}

#{{{ ###### VARIABLES ######

nvim --version > /dev/null 2>&1 && export EDITOR=nvim || export EDITOR=vim
export DIFF=vimdiff
export VISUAL=$EDITOR
# if [[ ! $PATH =~ "$HOME/bin" ]]; then
export PATH=$HOME/bin:$PATH
# fi
#export TERM=xterm-256color-italic
if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# linuxbrew setup
if [[ -d ~/.linuxbrew ]]; then #&& ! $PATH =~ "linuxbrew" ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export PATH="/home/user/wreed/.linuxbrew/sbin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi

#}}}

#{{{ ##### ALIASES ######
# general
ls --color=al > /dev/null 2>&1 && alias ls='ls --color=al' || alias ls='ls -G'  # compatibility between linux and mac
alias la="ls -A"
alias ll="ls -lh"
alias lal="ls -lAh"

alias erc='$EDITOR ~/.bashrc; src'

alias so="source"
alias src="source ~/.bashrc"

alias x="chmod +x"

alias vj="vim +set\ ft=json"
alias nvj="nvim +set\ ft=json"

alias rmd="rm *.d"

alias lt='$(fc -ln -1) | less' # "less that".  Carefull, this can be dangerous because it executes the last command

alias gst='git status'
alias gdiff='git difftool'

# default flags
alias tmux="tmux -u"
# alias ssh="ssh -XC"
alias cs="cscope -b"
alias pyclewn="pyclewn --window=bottom" # default arguments for pyclewn 
alias ctags="ctags -R --c++-kinds=+lpx --fields=+amiS --extra=+q --totals --exclude=submit *.cxx *.h "
alias grep="grep --color"
alias htop="htop -u $(whoami)"
alias less="less -r"

# kill tmux 0 session
alias k0="tmux kill-session -t 0"

# open vim config
alias evrc="$EDITOR +EditVimrc"


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


#}}}

#{{{ ##### Custom Prompt #####
if [ -z $ZSH_NAME ]; then

    _print_last_return() {
        # ret=$?
        ret=$1
        if [[ $ret != 0 ]]; then
            echo -e "[\[\e[0;31m\]$ret\[\e[0m\]]"
        fi
    }

    _make_prompt() {
      ret=$?
      export PS1="\n\[\033[38;5;37m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;72m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;87m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]  ~\d \@~\n$(_print_last_return $ret)-> \[$(tput sgr0)\]"
      # PS1="\n\[\e[0;32m\]\u\[\e[0m\]@\[\e[1;35m\]\h\[\e[0m\]:\[\e[4;36m\]\w\[\e[0m\]  ~\d \@~\n$(_print_last_return)-> "
      _bash_history_sync
    }

    PROMPT_COMMAND=_make_prompt

    # if [[ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]]; then
        # GIT_PROMPT_START="\n\e[0;32m\u\e[0m@\e[1;35m\h\e[0m:\e[4;36m\w\e[0m"
        # GIT_PROMPT_END='  ~ \d \@ ~\n$(_print_last_return)-> '

        # source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
    # else
        # export PS1="\n\[\e[0;32m\]\u\[\e[0m\]@\[\e[1;35m\]\h\[\e[0m\]:\[\e[4;36m\]\w\[\e[0m\]\n-> "
        # simplified version:
        # export PS1="\n\[\e[0;32m\]\u\[\e[0m\]@\[\e[1;35m\]\h\[\e[0m\]:\[\e[4;36m\]\w\[\e[0m\]  ~\d \@~\n\$(_print_last_return)-> "
    # fi

fi

#}}}

#"{{{##### FUNCTIONS #####

mkcd () { mkdir -p "$1" && cd "$1"; }

urlencode (){ python -c "import urllib, sys; print urllib.quote(sys.argv[1])" $1; }
urldecode (){ python -c "import urllib, sys; print urllib.unquote(sys.argv[1])" $1; }

wttr()
{
    # change Paris to your default location
    curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Boston}"
}

cdrm()
{
  dir=$(pwd)
  cd ..
  rmdir $dir
}

etrc()
{
  $EDITOR ~/.tmux.conf
  if [[ -n ${TMUX+x} ]]; then
    tmux source ~/.tmux.conf
  fi
}

#}}}


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -z $ZSH_NAME ]; then
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        elif [ -f /usr/local/etc/bash_completion ]; then
            . /usr/local/etc/bash_completion
        elif type brew > /dev/null 2>&1; then
            if [ -f $(brew --prefix)/etc/bash_completion ]; then
                source $(brew --prefix)/etc/bash_completion
            fi
        fi

        # if [ -f ~/.bash_completion ]; then
            # source ~/.bash_completion
        # fi
    fi
fi


if [ -f ~/.bashrc_custom ]; then
    alias ecrc='$EDITOR ~/.bashrc_custom; src'
    source ~/.bashrc_custom
fi

# vim:foldmethod=marker:foldlevel=0:

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
