#!/bin/bash

HOME_DIR="~"
rvm_path=$HOME_DIR/.rvm

if [ -d $HOME_DIR/.oh-my-zsh ]; then
    echo "You already have Oh My Zsh installed. You'll need to remove $HOME_DIR/.oh-my-zsh if you want to reinstall"
    /bin/bash $HOME_DIR/.oh-my-zsh/tools/upgrade.sh
else
    echo "Installing Oh My Zsh..."
    wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | /bin/bash
fi

if [ -d $HOME_DIR/.zbelzer-dotfiles]; then
    echo "Updatig zbelzer's dotfiles..."
    cd $HOME_DIR/.zbelzer-dotfiles
    /usr/bin/env git pull
    cd $HOME_DIR
else
    echo "Cloning zbelzer's dotfiles..."
    /usr/bin/env git clone git://github.com/zbelzer/dotfiles.git $HOME_DIR/.zbelzer-dotfiles
fi

echo "Copying custom Zsh scripts to Oh My Zsh..."
cp $HOME_DIR/.zbelzer-dotfiles/oh-my-zsh/custom/* $HOME_DIR/.oh-my-zsh/custom

echo "Symlinking other dotfiles"
ln -nsvf $HOME/.zbelzer-dotfiles/.* $HOME 

echo "Create a new terminal to be assured things are working"
