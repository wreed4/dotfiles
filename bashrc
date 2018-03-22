# Willie Reed
# bash config

source ~/.dotfiles/bash/minimal

#{{{ ###### SETTINGS ######
# set vim key bindings
# set -o vi

stty -ixon
#}}}

#{{{ ###### VARIABLES ######

export DIFF=vimdiff
export VISUAL=$EDITOR
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

if [[ -d ~/.cargo ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

#}}}

#{{{ ##### ALIASES ######
# general
if $(type exa > /dev/null 2>&1); then
  # use exa as a replacement for ls and tree
  alias exa="exa --color-scale --group-directories-first --level=3"
  alias ls="exa"
  alias la="exa -a"
  alias ll="exa -lhmU --git"
  alias lal="ll -a"
  alias t="exa --tree"
  alias tl="ll --tree"
fi

alias vj="vim +set\ ft=json"
alias nvj="nvim +set\ ft=json"

alias rmd="rm *.d"

alias gdiff='git difftool'
alias gt='git tree --color'
alias gta='git tree --all --color'

# default flags
alias tmux="tmux -u"
# alias ssh="ssh -XC"
alias htop="htop -u $(whoami)"
alias less="less -r"
alias tree="tree -C"
alias watch="watch -c "
alias diff="diff --color=always "

# kill tmux 0 session
alias k0="tmux kill-session -t 0"

# pipenv/python aliases
alias psh="pipenv shell --fancy"

# open vim config
alias evrc="$EDITOR +EditVimrc"


#}}}

#{{{ ##### HISTORY #####

HISTSIZE=9000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

history() {
  sync_history
  builtin history "$@"
}

sync_history() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  # builtin history -c         #3
  builtin history -n         #4
}


#}}}

#{{{ ##### Custom Prompt #####
if [ -z $ZSH_NAME ]; then

    show_colors() {
      for i in $(seq 0 $(tput colors) ) ; do
        tput setaf $i
        echo -n "($i) "
      done
      tput setaf 15
      echo
    }

    LIGHT_BLUE="$(tput setaf 37)"
    WHITE="$(tput setaf 15)"
    LIGHT_GREEN="$(tput setaf 72)"
    CYAN="$(tput setaf 87)"
    RED="$(tput setaf 1)"
    LIGHT_PURPLE="$(tput setaf 200)"
    RESET="$(tput sgr0)"

    _print_virtualenv() {
      # Get Virtual Env
      if [[ $VIRTUAL_ENV != "" ]]
      then
        # Strip out the path and just leave the env name
        venv="${LIGHT_PURPLE}(${VIRTUAL_ENV##*/})${RESET} "
      else
        # In case you don't have one activated
        venv=''
      fi

      echo -e -n "$venv"
    }

    _print_last_return() {
        # ret=$?
        ret=$last_ret
        if [[ $ret != 0 ]]; then
          echo -e -n "${WHITE}[${RED}$ret${WHITE}]"
        fi
    }

    _make_prompt() {
      last_ret=$?
      echo -e ''
      sync_history
    }

    PROMPT_COMMAND=_make_prompt
    export PS1="\[\$(_print_virtualenv)${LIGHT_BLUE}\]\u\[${WHITE}\]@\[${LIGHT_GREEN}\]\h\[${WHITE}\]:\[${CYAN}\]\w \[${WHITE}\]~\d \@~ \$(_print_last_return) \n\[${WHITE}\]-> \[${RESET}\]"

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

urlencode (){ python -c "import urllib, sys; print urllib.quote(sys.argv[1])" $1; }
urldecode (){ python -c "import urllib, sys; print urllib.unquote(sys.argv[1])" $1; }

wttr()
{
    # change Paris to your default location
    curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Boston}"
}

etrc()
{
  $EDITOR ~/.tmux.conf
  if [[ -n ${TMUX+x} ]]; then
    tmux source ~/.tmux.conf
  fi
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# autojump sourcing
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

if [ -f ~/.bashrc_custom ]; then
    alias ecrc='$EDITOR ~/.bashrc_custom; src'
    source ~/.bashrc_custom
fi

# vim:foldmethod=marker:foldlevel=0:
