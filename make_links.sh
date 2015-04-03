#!/bin/bash

files=(bashrc tmux_conf)

for f in $files; do
    ln -s $f ~/.$f
done
