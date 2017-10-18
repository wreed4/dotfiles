#!/bin/bash

files=(bashrc tmux.conf xonshrc gitconfig)

for f in ${files[@]}; do
    echo ~/.$f "-->" $(pwd)/$f
    [[ -f ~/.$f ]] && mv ~/.$f ~/$f.old
    ln -s $(pwd)/$f ~/.$f
done
