#!/bin/bash

HOME_DIR="~"
rvm_path=$HOME_DIR/.rvm

if [ -d $HOME_DIR/.oh-my-zsh ]
then
    echo "You already have Oh My Zsh installed. You'll need to remove $HOME_DIR/.oh-my-zsh if you want to reinstall"
    /bin/bash $HOME_DIR/.oh-my-zsh/tools/upgrade.sh
else
    echo "Installing Oh My Zsh..."
    wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | /bin/bash
fi


if [ -d $HOME_DIR/.zbelzer-dotfiles]
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

if [ -d $rvm_path ]; then
    echo "Found rvm, adding rvm bit to vanilla zshrc config..."
    echo -e "\n# rvm-install added line:\nif [[ -s $rvm_path/scripts/rvm ]] ; then source $rvm_path/scripts/rvm ; fi\n" >> $HOME_DIR/.zshrc
fi


# echo "Installing vim bundles..."
# mkdir -p $HOME_DIR/.vim/bundle
# wget http://github.com/jc00ke/scripts/raw/master/install_vim_files -O - | /bin/bash

echo "Using Drew's vim setup"
/usr/bin/env git clone git://github.com/drewolson/vim_dotfiles.git $HOME/.zbelzer-dotfiles/vim_dotfiles
ln -nsf $HOME/.zbelzer-dotfiles/vim_dotfiles/vim $HOME/.vim 

echo "Create a new terminal to be assured things are working"
