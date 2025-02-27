
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/go/bin" ] ; then
    export PATH="$HOME/go/bin:$PATH"
fi
if [ -d "/usr/local/go/bin" ] ; then
    export PATH="/usr/local/go/bin:$PATH"
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
