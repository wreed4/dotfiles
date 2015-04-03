#!/bin/bash

files=(bashrc tmux_conf)

echo $files
for f in ${files[@]}; do
    echo ~/.$f "-->" $(pwd)/$f
    ln -s $(pwd)/$f ~/.$f
done
