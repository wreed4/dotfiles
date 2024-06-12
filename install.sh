#!/bin/bash

echo ". $HOME/.dotfiles/path_setup.sh" >> $HOME/.profile

files=(bash_profile bashrc inputrc tmux.conf xonshrc gitconfig vim taskrc)

for f in ${files[@]}; do
    echo ~/.$f "-->" $(pwd)/$f
    [[ -f ~/.$f ]] && mv ~/.$f ~/$f.old
    ln -s --backup=numbered $(pwd)/$f ~/.$f
done

./vim/make_links.sh

echo ~/.config/helix/conf.toml "-->" $(pwd)/helixconf.toml
ln -s --backup=numbered $(pwd)/helixconf.toml ~/.config/helix/config.toml

[[ -d ~/.config/zellij ]] || mkdir $HOME/.config/zellij
ln -s --backup=numbered $(pwd)/zellij_config.kdl ~/.config/zellij/config.kdl

[[ -d ~/.config/alacritty ]] || mkdir $HOME/.config/alacritty
ln -s --backup=numbered $(pwd)/alacritty.toml ~/.config/alacritty/alacritty.toml

