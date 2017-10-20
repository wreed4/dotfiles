#!/bin/bash

files=(bashrc inputrc tmux.conf xonshrc gitconfig vim)

for f in ${files[@]}; do
    echo ~/.$f "-->" $(pwd)/$f
    [[ -f ~/.$f ]] && mv ~/.$f ~/$f.old
    ln -s $(pwd)/$f ~/.$f
done

./vim/make_links.sh
