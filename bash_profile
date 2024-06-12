# vim:foldmethod=marker:foldlevel=0:filetype=sh
# Willie Reed
# bash profile

#{{{ ###### VARIABLES ######

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
