#!/bin/bash

files=(bash_profile bashrc inputrc tmux.conf xonshrc gitconfig vim taskrc helixconf)

for f in ${files[@]}; do
    echo ~/.$f "-->" $(pwd)/$f
    [[ -f ~/.$f ]] && mv ~/.$f ~/$f.old
    ln -s $(pwd)/$f ~/.$f
done

./vim/make_links.sh
