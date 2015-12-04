#!/bin/bash

files=(bashrc tmux.conf)

for f in ${files[@]}; do
    echo ~/.$f "-->" $(pwd)/$f
    mv ~/.$f ~/$f.old
    ln -s $(pwd)/$f ~/.$f
done
