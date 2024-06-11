# vim:foldmethod=marker:foldlevel=0:filetype=sh
# Willie Reed
# bash profile

#{{{ ###### VARIABLES ######

#{{{ ###### PATH ######
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/go/bin" ] ; then
    export PATH="$HOME/go/bin:$PATH"
fi
if [ -d "$HOME/.krew/bin" ] ; then
    export PATH="$HOME/.krew/bin:$PATH"
fi
if [ -d "$HOME/.rbenv" ] ; then
    export PATH="$PATH:$HOME/.rbenv/bin"
fi
if [ -d "$HOME/.pyenv/bin" ] ; then
    export PATH="$PATH:$HOME/.pyenv/bin"
fi

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

if [[ -d ~/.yarn ]]; then
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

if [[ -d ~/pymodules ]]; then
  export PYTHONPATH="$HOME/pymodules:$PYTHONPATH"
fi

# LASTly...
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

#}}}

nvim --version > /dev/null 2>&1 && export EDITOR=nvim || export EDITOR=vim
nvim --version > /dev/null 2>&1 && export SUDO_EDITOR=$(which nvim) || export SUDO_EDITOR=$(which vim)

export DIFF=vimdiff
export VISUAL=$EDITOR
export PYTHONBREAKPOINT=ipdb.set_trace
export PIPENV_MAX_DEPTH=5
#export TERM=xterm-256color-italic
if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if $(type fd > /dev/null 2>&1); then
  export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
  export FZF_DEFAULT_OPTS="--ansi"
fi

#}}}

alias ep='$EDITOR ~/.bash_profile; src'

if [ -f ~/.bash_profile_custom ]; then
    alias ecp='$EDITOR ~/.bash_profile_custom; src'
    source ~/.bash_profile_custom
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

eval $(ssh-agent) > /dev/null
ssh-add ~/.ssh/id_rsa 2> /dev/null
ssh-add ~/.ssh/acquia_prod 2> /dev/null
ssh-add ~/.ssh/jenkins_ssh 2> /dev/null
ssh-add ~/.ssh/williamreed.pem 2> /dev/null
